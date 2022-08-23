function fn(array, issueId) {
  var isFound = false
  for (var i = 0; i < array.length; i++) {
    if (array[i]== issueId){
      isFound = true;
    }
  }
  return isFound;
}