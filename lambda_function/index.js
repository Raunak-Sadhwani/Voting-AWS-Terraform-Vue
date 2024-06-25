exports.handler = async (event) => {
    console.log("Log event: ", JSON.stringify(event, null, 2));
    return `Successfully processed ${event.records.length} records.`;
};
