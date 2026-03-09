import re
from collections import Counter

ERROR_PATTERN = r"ERROR"
WARN_PATTERN = r"WARN"

def analyze_logs(log_lines):

    errors = 0
    warnings = 0
    services = []

    for line in log_lines:

        if re.search(ERROR_PATTERN, line):
            errors += 1

        if re.search(WARN_PATTERN, line):
            warnings += 1

        if "service=" in line:
            service = line.split("service=")[1].split()[0]
            services.append(service)

    service_counts = Counter(services)

    return {
        "total_logs": len(log_lines),
        "error_count": errors,
        "warning_count": warnings,
        "top_services": service_counts.most_common(5)
    }