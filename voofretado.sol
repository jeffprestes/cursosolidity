//Autoria de Flavio Freitas
pragma solidity 0.5.1;

contract VooFretado {
    
    address payable airline;
    uint value;
    uint agencyFee;
    uint airlineFee;
    uint public ticketValue;
    uint public numberOfFlight;
    uint public dateOfFlight;
    uint public numberOfTickets;

    passenger[] public passengers;
    agency[] public agencies;

    enum FlightState { Created, Open, End }
    FlightState public flightState;
    
    // Registrers
    
    struct passenger {
        address payable passengerWallet;
        address payable agencyWallet;
        string passengerName;
        bool reembolsoPago;
    }
    
    struct agency {
        address payable agencyWallet;
        string agencyName;
        uint passagensVendidas;
        bool comissaoPaga;
    }
    
    // Constructor
    
    constructor( 
        uint _numberOfFlight,
        uint _dateOfFlight,
        uint _ticketValue,
        uint _airCompanyFee,
        uint _agencyFee,
        uint _numberOfTickets
    ) public payable {
        airline = msg.sender;
        numberOfFlight = _numberOfFlight;
        dateOfFlight = _dateOfFlight;
        ticketValue = _ticketValue;
        airlineFee = _airCompanyFee;
        agencyFee = _agencyFee;
        numberOfTickets = _numberOfTickets;
        flightState = FlightState.Open;
    }

    // modifiers

    modifier onlyAirCompany() {
        require(msg.sender == airline, "Only Air Company can do this");
        _;
    }
    
    modifier inState(FlightState _state) {
        require(state == _state, "Invalid state.");
        _;
    }
    
    // Registrer Agency
    function registrerAgency(
        address payable agencyWallet, 
        string memory agencyName
    ) 
    onlyAirCompany
    inState(FlightState.Open)
    public  {
        agencies.push(agency(agencyWallet, agencyName, 0, false));
    }
    
    // Buy Ticket
    function buyTicket(
        address payable passengerWallet,
        string memory passengerName, 
        uint agencyId
    ) 
    inState(FlightState.Open)
    public payable     {
        require(passengers.length < numberOfTickets, "Voo encerrado.");
        require(msg.value == ticketValue, "Valor incorreto.");
        require(now <= dateOfFlight, "Voo enecerrado");
        passengers.push(passenger(passengerWallet, passengerName, false));
        agency memory sellingAgency = agencies[agencyId];
        sellingAgency.passagensVendidas = sellingAgency.passagensVendidas + 1;
        // sellingAgency.passagensVendidas++;
        // agencies[agencyId].passagensVendidas++;
    }
    
    
    event FlightArrived();
    
    function flightLanded()
        inState(FlightState.Open)
        onlyAirCompany
        public
    {
        flightState = FlightState.End;
        airline.transfer((address(this).balance*airlineFee)/100);
        uint totalRemainingFee = address(this).balance;
        for (uint i=0; i < agencies.length; i++) {
            agency memory agencyReceiving = agency[i];
            if (!agencyReceiving.comissaoPaga) {
                uint fee = (ticketValue * agencyFee * agencyReceiving.passagensVendidas)/100;
                agency.agencyWallet.transfer(fee);
                agency.comissaoPaga = true;
            }
        }
        emit FlightArrived();
    }
}
