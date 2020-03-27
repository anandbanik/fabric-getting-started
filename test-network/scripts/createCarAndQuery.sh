
FABRIC_CFG_PATH=$PWD/../../config/
cd ../
CORE_PEER_TLS_ENABLED=true
CORE_PEER_LOCALMSPID="Org1MSP"
CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
CORE_PEER_ADDRESS=localhost:7051
CORE_PEER_TLS_ENABLED=true
ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
CHANNEL_NAME=mychannel
PEER=peer0
#PEER_CONN_PARMS=--peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

echo "===================== Invoking transaction createCar on $PEERS on channel '$CHANNEL_NAME' ===================== " 
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n fabcar --peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt -c '{"function":"createCar","Args":["Car2010","Audi","Q5","Blue","Anand"]}'
echo "===================== Invoke transaction successful on $PEERS on channel '$CHANNEL_NAME' ===================== "

sleep 5

echo "===================== Quering on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010	 ===================== " 

peer chaincode query -C mychannel -n fabcar -c '{"Args":["queryCar","Car2010"]}'

echo "===================== Query Result successful on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010 ===================== " 

