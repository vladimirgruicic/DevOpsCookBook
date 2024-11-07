import logging
from tabulate import tabulate
import docker

# Initialize Docker client
client = docker.from_env()

def list_container_networks():
    """Lists network settings for each running container."""
    try:
        containers = client.containers.list()  # List all running containers

        # Prepare a list to store network data for tabulation
        network_data = []

        # Loop through containers to extract network details
        for container in containers:
            logging.info(f"Checking container: {container.name}")
            try:
                # Try fetching network settings for the container
                network_settings = container.attrs.get('NetworkSettings', {}).get('Networks', {})

                if not network_settings:
                    logging.warning(f"No network settings found for container: {container.name}")
                    network_data.append({
                        "Container Name": container.name,
                        "IP Address": "N/A",
                        "Network Name": "N/A",
                        "Gateway": "N/A"
                    })
                else:
                    # Loop through networks for the container
                    for network_name, settings in network_settings.items():
                        ip_address = settings.get('IPAddress', 'N/A')
                        gateway = settings.get('Gateway', 'N/A')
                        network_data.append({
                            "Container Name": container.name,
                            "IP Address": ip_address,
                            "Network Name": network_name,
                            "Gateway": gateway
                        })

            except Exception as e:
                logging.error(f"Error while fetching network settings for container {container.name}: {e}")
                network_data.append({
                    "Container Name": container.name,
                    "IP Address": "Error",
                    "Network Name": "Error",
                    "Gateway": "Error"
                })

        # If network data exists, print it in a tabular format
        if network_data:
            table = tabulate(network_data, headers=["Container Name", "IP Address", "Network Name", "Gateway"], tablefmt="pretty")
            print(table)
        else:
            logging.info("No network data available for running containers.")

        return network_data

    except docker.errors.APIError as api_error:
        logging.error(f"Error with Docker API: {api_error}")
    except Exception as e:
        logging.error(f"An unexpected error occurred: {e}")

    return []

