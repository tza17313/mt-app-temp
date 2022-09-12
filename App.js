/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 */

import React from "react";
import { Button, SafeAreaView, StatusBar, View ,NativeEventEmitter, NativeModules } from "react-native";

const { LivePhotosTool } = NativeModules;

function App() {

  const backgroundStyle = {
    backgroundColor: "#F3F3F3",
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={"dark-content"} />
      <View
        style={{
          alignItems: "center",
          justifyContent: "center",
          height:"100%"
        }}>
        <Button title="提取LivePhotos" onPress={() => {
          LivePhotosTool.extractResources(["photoURL"]).then((pairedImage, pairedVideo) => {

          }).catch((e) => {
            console.log("catch error:", e);
          })
        }} />
        <View style={{height:50}}/>
        <Button title="保存LivePhotos" onPress={() => {
          LivePhotosTool.generate("photoURL","videoURL").then((pairedImage, pairedVideo) => {

          }).catch((e) => {
            console.log("catch error:", e);
          })
        }} />
      </View>
    </SafeAreaView>
  );
}

export default App;
