export FABRIC_CFG_PATH=~/AppDev/Training/Fabric2.0/fabric-getting-started/config/
echo $FABRIC_CFG_PATH
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=~/AppDev/Training/Fabric2.0/fabric-getting-started/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE1=~/AppDev/Training/Fabric2.0/fabric-getting-started/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=~/AppDev/Training/Fabric2.0/fabric-getting-started/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=~/AppDev/Training/Fabric2.0/fabric-getting-started/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export CHANNEL_NAME=mychannel
export PEERS=peer0
#PEER_CONN_PARMS=--peerAddresses localhost:7051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

echo "===================== Invoking transaction createCar on $PEERS on channel '$CHANNEL_NAME' ===================== " 
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n fabcar --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE1 -c '{"function":"createCar","Args":["Car2012","Audi","Q5","blue","Anand"]}'
echo "===================== Invoke transaction successful on $PEERS on channel '$CHANNEL_NAME' ===================== "

sleep 5

echo "===================== Quering on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010	 ===================== " 

peer chaincode query -C mychannel -n fabcar -c '{"Args":["queryCarsByColor","blue"]}'

echo "===================== Query Result successful on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010 ===================== " 

sleep 5

echo "===================== Invoking transaction createCar on $PEERS on channel '$CHANNEL_NAME' ===================== " 
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n fabcar --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE1 -c '{"function":"updateCar","Args":["Car2012","Audi","Q5","red","Amit"]}'
echo "===================== Invoke transaction successful on $PEERS on channel '$CHANNEL_NAME' ===================== "

sleep 5

echo "===================== Quering on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010	 ===================== " 

peer chaincode query -C mychannel -n fabcar -c '{"Args":["queryCarsByColor","blue"]}'

echo "===================== Query Result successful on $PEERS on channel '$CHANNEL_NAME' to get Car Details for Car2010 ===================== " 