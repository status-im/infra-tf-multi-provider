/**
 * The number of hosts created for each supported Providers is controlled
 * by either the count for the given provider(e.g., `do_count`) or the default
 * set via `host_count` variable.
 * If count is set to `0` the whole module is disabled, this includes all
 * the support resources like firewall rules or security groups.
 *
 * Each provider configuration exists in a `module_*.tf` file.
 */

locals {
  stage = var.stage != "" ? var.stage : terraform.workspace
  fleet = "${var.env}.${local.stage}"

  /* Counts, default to general count. */
  ac_count  = var.ac_count  != -1 ? var.ac_count  : var.host_count
  aws_count = var.aws_count != -1 ? var.aws_count : var.host_count
  do_count  = var.do_count  != -1 ? var.do_count  : var.host_count
  gc_count  = var.gc_count  != -1 ? var.gc_count  : var.host_count
}
