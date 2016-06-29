function main(params){
	if(params === undefined)
	return whisk.done({"message":"Hello, World!"});
	else
		return whisk.done({"message":"Hello, "+params.name+"!"});
}