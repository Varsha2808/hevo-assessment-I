from io.hevo.api import Event

"""
event: each record streaming through Hevo pipeline is an event

returns: 
    - The modified event object.
    - Array of event objects if new events are generated from the incoming event.
    - None if the event is supposed to be dropped from the pipeline.

Read complete documentation at: https://docs.hevodata.com/pipelines/transformations/
"""


def transform(event):
    # Get event name from the event #
    # eventName = event.getEventName()

    # Get properties from the event #
    # properties = event.getProperties()

    # Add a new field to the event #
    # properties['foo'] = 'bar'

    # Rename event
    # event.rename(newName)
    
    properties = event.getProperties()
    
# Transformation for orders → order_events    

    if event.getEventName() == "orders":
        status_to_event = {
            "delivered": "order_delivered",
            "placed": "order_placed",
            "shipped": "order_shipped",
            "cancelled": "order_cancelled"
        }
        
        properties['event_type'] = status_to_event.get(properties.get('status', ''), 'unknown')
        event.setProperties(properties)
        
        event.rename("order_events")
            
# Transformation for customers → add username

    elif event.getEventName() == "customers":
        email = properties.get("email", "")
        username = email.split("@")[0] if "@" in email else email
        properties["username"] = username
        event.setProperties(properties)
        

    return event
