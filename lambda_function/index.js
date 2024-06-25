exports.handler = async (event) => {
    return `Successfully processed ${event.records.length} records.`;
};
