Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F81AFB321
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Jul 2025 14:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYksi-0003RW-CN; Mon, 07 Jul 2025 08:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uYkqK-0002LP-0i; Mon, 07 Jul 2025 08:21:09 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uYkqG-0002IZ-OW; Mon, 07 Jul 2025 08:21:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbNY432qlz6L5Nl;
 Mon,  7 Jul 2025 20:17:44 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 1BE5B1402F8;
 Mon,  7 Jul 2025 20:20:51 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.45.147.207) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Jul 2025 14:20:49 +0200
To: <qemu-devel@nongnu.org>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mst@redhat.com>,
 <mtosatti@redhat.com>, <peter.maydell@linaro.org>, <philmd@linaro.org>,
 <qemu-arm@nongnu.org>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v14 3/7] hw/arm/virt: add cache hierarchy to device tree
Date: Mon, 7 Jul 2025 13:19:04 +0100
Message-ID: <20250707121908.155-4-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707121908.155-1-alireza.sanaee@huawei.com>
References: <20250707121908.155-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.45.147.207]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Specify which layer (core/cluster/socket) caches found at in the CPU
topology. Updating cache topology to device tree (spec v0.4).
Example:

Here, 2 sockets (packages), and 2 clusters, 4 cores and 2 threads
created, in aggregate 2*2*4*2 logical cores. In the smp-cache object,
cores will have l1d and l1i.  However, extending this is not difficult).
The clusters will share a unified l2 level cache, and finally sockets
will share l3. In this patch, threads will share l1 caches by default,
but this can be adjusted if case required.

Currently only three levels of caches are supported.  The patch does not
allow partial declaration of caches. In another word, all caches must be
defined or caches must be skipped.

./qemu-system-aarch64 \
    -machine virt,\
         smp-cache.0.cache=l1i,smp-cache.0.topology=core,\
         smp-cache.1.cache=l1d,smp-cache.1.topology=core,\
         smp-cache.2.cache=l2,smp-cache.2.topology=cluster,\
         smp-cache.3.cache=l3,smp-cache.3.topology=socket\
    -cpu max \
    -m 2048 \
    -smp sockets=2,clusters=2,cores=4,threads=1 \
    -kernel ./Image.gz \
    -append "console=ttyAMA0 root=/dev/ram rdinit=/init acpi=force" \
    -initrd rootfs.cpio.gz \
    -bios ./edk2-aarch64-code.fd \
    -nographic

For instance, following device tree will be generated for a scenario
where we have 2 sockets, 2 clusters, 2 cores and 2 threads, in total 16
PEs. L1i and L1d are private to each thread, and l2 and l3 are shared at
socket level as an example.

Limitation: SMT cores cannot share L1 cache for now. This
problem does not exist in PPTT tables.

Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/arm/virt.c               | 412 +++++++++++++++++++++++++++++++++++-
 include/hw/acpi/aml-build.h |   2 +
 include/hw/acpi/cpu.h       |  13 +-
 include/hw/arm/virt.h       |   7 +-
 include/hw/cpu/core.h       |   1 +
 5 files changed, 432 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bcdf92e2f..8511c834d4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,7 +74,9 @@
 #include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/cpu.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
@@ -86,6 +88,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/core/cpu.h"
 #include "qemu/guest-random.h"
 
 static GlobalProperty arm_virt_compat[] = {
@@ -238,6 +241,132 @@ static const int a15irqmap[] = {
     [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
 };
 
+unsigned int virt_get_caches(const VirtMachineState *vms,
+                             CPUCorePPTTCaches *caches)
+{
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0)); /* assume homogeneous CPUs */
+    bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
+    unsigned int num_cache, i;
+    int level_instr = 1, level_data = 1;
+
+    for (i = 0, num_cache = 0; i < CPU_MAX_CACHES; i++, num_cache++) {
+        int type = (armcpu->clidr >> (3 * i)) & 7;
+        int bank_index;
+        int level;
+        enum CacheType cache_type;
+
+        if (type == 0) {
+            break;
+        }
+
+        switch (type) {
+        case 1:
+            cache_type = INSTRUCTION_CACHE;
+            level = level_instr;
+            break;
+        case 2:
+            cache_type = DATA_CACHE;
+            level = level_data;
+            break;
+        case 4:
+            cache_type = UNIFIED_CACHE;
+            level = level_instr > level_data ? level_instr : level_data;
+            break;
+        case 3: /* Split - Do data first */
+            cache_type = DATA_CACHE;
+            level = level_data;
+            break;
+        default:
+            error_setg(&error_abort, "Unrecognized cache type");
+            return 0;
+        }
+        /*
+         * ccsidr is indexed using both the level and whether it is
+         * an instruction cache. Unified caches use the same storage
+         * as data caches.
+         */
+        bank_index = (i * 2) | ((type == 1) ? 1 : 0);
+        if (ccidx) {
+            caches[num_cache] = (CPUCorePPTTCaches) {
+                .type =  cache_type,
+                .level = level,
+                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                             CCSIDR_EL1,
+                                             CCIDX_LINESIZE) + 4),
+                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                            CCSIDR_EL1,
+                                            CCIDX_ASSOCIATIVITY) + 1,
+                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                   CCIDX_NUMSETS) + 1,
+            };
+        } else {
+            caches[num_cache] = (CPUCorePPTTCaches) {
+                .type =  cache_type,
+                .level = level,
+                .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                             CCSIDR_EL1, LINESIZE) + 4),
+                .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                            CCSIDR_EL1,
+                                            ASSOCIATIVITY) + 1,
+                .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                   NUMSETS) + 1,
+            };
+        }
+        caches[num_cache].size = caches[num_cache].associativity *
+            caches[num_cache].sets * caches[num_cache].linesize;
+
+        /* Break one 'split' entry up into two records */
+        if (type == 3) {
+            num_cache++;
+            bank_index = (i * 2) | 1;
+            if (ccidx) {
+                /* Instruction cache: bottom bit set when reading banked reg */
+                caches[num_cache] = (CPUCorePPTTCaches) {
+                    .type = INSTRUCTION_CACHE,
+                    .level = level_instr,
+                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                 CCSIDR_EL1,
+                                                 CCIDX_LINESIZE) + 4),
+                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                CCSIDR_EL1,
+                                                CCIDX_ASSOCIATIVITY) + 1,
+                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                       CCIDX_NUMSETS) + 1,
+                };
+            } else {
+                caches[num_cache] = (CPUCorePPTTCaches) {
+                    .type = INSTRUCTION_CACHE,
+                    .level = level_instr,
+                    .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                 CCSIDR_EL1, LINESIZE) + 4),
+                    .associativity = FIELD_EX64(armcpu->ccsidr[bank_index],
+                                                CCSIDR_EL1,
+                                                ASSOCIATIVITY) + 1,
+                    .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
+                                       NUMSETS) + 1,
+                };
+            }
+            caches[num_cache].size = caches[num_cache].associativity *
+                caches[num_cache].sets * caches[num_cache].linesize;
+        }
+        switch (type) {
+        case 1:
+            level_instr++;
+            break;
+        case 2:
+            level_data++;
+            break;
+        case 3:
+        case 4:
+            level_instr++;
+            level_data++;
+            break;
+        }
+    }
+
+    return num_cache;
+}
+
 static void create_randomness(MachineState *ms, const char *node)
 {
     struct {
@@ -416,13 +545,150 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     }
 }
 
+static void add_cache_node(void *fdt, char * nodepath, CPUCorePPTTCaches cache,
+                           uint32_t *next_level)
+{
+    /* Assume L2/3 are unified caches. */
+
+    uint32_t phandle;
+
+    qemu_fdt_add_path(fdt, nodepath);
+    phandle = qemu_fdt_alloc_phandle(fdt);
+    qemu_fdt_setprop_cell(fdt, nodepath, "phandle", phandle);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-level", cache.level);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-size", cache.size);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-block-size", cache.linesize);
+    qemu_fdt_setprop_cell(fdt, nodepath, "cache-sets", cache.sets);
+    qemu_fdt_setprop(fdt, nodepath, "cache-unified", NULL, 0);
+    qemu_fdt_setprop_string(fdt, nodepath, "compatible", "cache");
+    if (cache.level != 3) {
+        /* top level cache doesn't have next-level-cache property */
+        qemu_fdt_setprop_cell(fdt, nodepath, "next-level-cache", *next_level);
+    }
+
+    *next_level = phandle;
+}
+
+static bool add_cpu_cache_hierarchy(void *fdt, CPUCorePPTTCaches* cache,
+                                    uint32_t cache_cnt,
+                                    uint32_t top_level,
+                                    uint32_t bottom_level,
+                                    uint32_t cpu_id,
+                                    uint32_t *next_level) {
+    bool found_cache = false;
+    char *nodepath;
+
+    for (int level = top_level; level >= bottom_level; level--) {
+        for (int i = 0; i < cache_cnt; i++) {
+            if (i != level) {
+                continue;
+            }
+
+            nodepath = g_strdup_printf("/cpus/cpu@%d/l%d-cache",
+                                       cpu_id, level);
+            add_cache_node(fdt, nodepath, cache[i], next_level);
+            found_cache = true;
+            g_free(nodepath);
+
+        }
+    }
+
+    return found_cache;
+}
+
+static void set_cache_properties(void *fdt, const char *nodename,
+                                 const char *prefix, CPUCorePPTTCaches cache)
+{
+    char prop_name[64];
+
+    snprintf(prop_name, sizeof(prop_name), "%s-block-size", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.linesize);
+
+    snprintf(prop_name, sizeof(prop_name), "%s-size", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.size);
+
+    snprintf(prop_name, sizeof(prop_name), "%s-sets", prefix);
+    qemu_fdt_setprop_cell(fdt, nodename, prop_name, cache.sets);
+}
+
+static int partial_cache_description(const MachineState *ms,
+                                     CPUCorePPTTCaches *caches,
+                                     int num_caches)
+{
+    int level, c;
+
+    for (level = 1; level < num_caches; level++) {
+        for (c = 0; c < num_caches; c++) {
+            if (caches[c].level != level) {
+                continue;
+            }
+
+            switch (level) {
+            case 1:
+                /*
+                 * L1 cache is assumed to have both L1I and L1D available.
+                 * Technically both need to be checked.
+                 */
+                if (machine_get_cache_topo_level(ms,
+                                                 CACHE_LEVEL_AND_TYPE_L1I) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            case 2:
+                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L2) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            case 3:
+                if (machine_get_cache_topo_level(ms, CACHE_LEVEL_AND_TYPE_L3) ==
+                    CPU_TOPOLOGY_LEVEL_DEFAULT) {
+                    return level;
+                }
+                break;
+            }
+        }
+    }
+
+    return 0;
+}
+
 static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 {
     int cpu;
     int addr_cells = 1;
     const MachineState *ms = MACHINE(vms);
+    const MachineClass *mc = MACHINE_GET_CLASS(ms);
     const VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int smp_cpus = ms->smp.cpus;
+    int socket_id, cluster_id, core_id;
+    uint32_t next_level = 0;
+    uint32_t socket_offset = 0;
+    uint32_t cluster_offset = 0;
+    uint32_t core_offset = 0;
+    int last_socket = -1;
+    int last_cluster = -1;
+    int last_core = -1;
+    int top_node = 3;
+    int top_cluster = 3;
+    int top_core = 3;
+    int bottom_node = 3;
+    int bottom_cluster = 3;
+    int bottom_core = 3;
+    unsigned int num_cache;
+    CPUCorePPTTCaches caches[16];
+    bool cache_created = false;
+    bool cache_available;
+    bool llevel;
+
+    num_cache = virt_get_caches(vms, caches);
+
+    if (mc->smp_props.has_caches &&
+        partial_cache_description(ms, caches, num_cache)) {
+            error_setg(&error_fatal, "Missing cache description");
+            return;
+    }
 
     /*
      * See Linux Documentation/devicetree/bindings/arm/cpus.yaml
@@ -451,9 +717,14 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = smp_cpus - 1; cpu >= 0; cpu--) {
+        socket_id = cpu / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
+        cluster_id = cpu / (ms->smp.cores * ms->smp.threads) % ms->smp.clusters;
+        core_id = cpu / (ms->smp.threads) % ms->smp.cores;
+
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
+        const char *prefix = NULL;
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
         qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
@@ -483,6 +754,140 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
                                   qemu_fdt_alloc_phandle(ms->fdt));
         }
 
+        if (!vmc->no_cpu_topology && num_cache) {
+            for (uint8_t i = 0; i < num_cache; i++) {
+                /* only level 1 in the CPU entry */
+                if (caches[i].level > 1) {
+                    continue;
+                }
+
+                if (caches[i].type == INSTRUCTION_CACHE) {
+                    prefix = "i-cache";
+                } else if (caches[i].type == DATA_CACHE) {
+                    prefix = "d-cache";
+                } else if (caches[i].type == UNIFIED_CACHE) {
+                    error_setg(&error_fatal,
+                               "Unified type is not implemented at level %d",
+                               caches[i].level);
+                    return;
+                } else {
+                    error_setg(&error_fatal, "Undefined cache type");
+                    return;
+                }
+
+                set_cache_properties(ms->fdt, nodename, prefix, caches[i]);
+            }
+        }
+
+        if (socket_id != last_socket) {
+            bottom_node = top_node;
+            /* this assumes socket as the highest topological level */
+            socket_offset = 0;
+            cluster_offset = 0;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                  CPU_TOPOLOGY_LEVEL_SOCKET);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_node,
+                        CPU_TOPOLOGY_LEVEL_SOCKET);
+            if (cache_available && llevel) {
+
+                if (bottom_node == 1 && !virt_is_acpi_enabled(vms)) {
+                    error_setg(&error_fatal,
+                        "Cannot share L1 at socket_id %d. DT limiation on "
+                        "sharing at cache level = 1",
+                        socket_id);
+                }
+
+                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
+                                                        num_cache,
+                                                        top_node,
+                                                        bottom_node, cpu,
+                                                        &socket_offset);
+
+                if (!cache_created) {
+                    error_setg(&error_fatal,
+                               "Socket: No caches at levels %d-%d",
+                               top_node, bottom_node);
+                    return;
+                }
+
+                top_cluster = bottom_node - 1;
+            }
+
+            last_socket = socket_id;
+        }
+
+        if (cluster_id != last_cluster) {
+            bottom_cluster = top_cluster;
+            cluster_offset = socket_offset;
+            core_offset = 0;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                 CPU_TOPOLOGY_LEVEL_CLUSTER);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_cluster,
+                        CPU_TOPOLOGY_LEVEL_CLUSTER);
+            if (cache_available && llevel) {
+                cache_created = add_cpu_cache_hierarchy(ms->fdt, caches,
+                                                        num_cache,
+                                                        top_cluster,
+                                                        bottom_cluster, cpu,
+                                                        &cluster_offset);
+                if (bottom_cluster == 1 && !virt_is_acpi_enabled(vms)) {
+                    error_setg(&error_fatal,
+                        "Cannot share L1 at socket_id %d, cluster_id %d. "
+                        "DT limitation on sharing at cache level = 1.",
+                        socket_id, cluster_id);
+                }
+
+                if (!cache_created) {
+                    error_setg(&error_fatal,
+                               "Cluster: No caches at levels %d-%d",
+                               top_cluster, bottom_cluster);
+                    return;
+                }
+
+                top_core = bottom_cluster - 1;
+            } else if (top_cluster == bottom_node - 1) {
+                top_core = bottom_node - 1;
+            }
+
+            last_cluster = cluster_id;
+        }
+
+        if (core_id != last_core) {
+            bottom_core = top_core;
+            core_offset = cluster_offset;
+            cache_available = machine_defines_cache_at_topo_level(ms,
+                                 CPU_TOPOLOGY_LEVEL_CORE);
+            llevel = machine_find_lowest_level_cache_at_topo_level(ms,
+                        &bottom_core,
+                        CPU_TOPOLOGY_LEVEL_CORE);
+            if (cache_available && llevel) {
+                if (bottom_core == 1 && top_core > 1) {
+                    bottom_core++;
+                    cache_created = add_cpu_cache_hierarchy(ms->fdt,
+                                                            caches,
+                                                            num_cache,
+                                                            top_core,
+                                                            bottom_core, cpu,
+                                                            &core_offset);
+
+                    if (!cache_created) {
+                        error_setg(&error_fatal,
+                                   "Core: No caches at levels %d-%d",
+                                   top_core, bottom_core);
+                        return;
+                    }
+                }
+            }
+
+            last_core = core_id;
+        }
+
+        next_level = core_offset;
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "next-level-cache",
+                              next_level);
+
         g_free(nodename);
     }
 
@@ -2653,7 +3058,7 @@ static void virt_set_oem_table_id(Object *obj, const char *value,
 }
 
 
-bool virt_is_acpi_enabled(VirtMachineState *vms)
+bool virt_is_acpi_enabled(const VirtMachineState *vms)
 {
     if (vms->acpi == ON_OFF_AUTO_OFF) {
         return false;
@@ -3179,6 +3584,11 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
+    /* Supported caches */
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1D] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L1I] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L2] = true;
+    mc->smp_props.cache_supported[CACHE_LEVEL_AND_TYPE_L3] = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     /* platform instead of architectural choice */
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index c18f681342..6fa2e1eedf 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -496,6 +496,8 @@ void build_srat_acpi_generic_port(GArray *table_data, uint32_t node,
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
+typedef struct CPUPPTTCaches CPUCorePPTTCaches;
+
 void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..6a02a32db4 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -14,8 +14,8 @@
 
 #include "qapi/qapi-types-acpi.h"
 #include "hw/qdev-core.h"
-#include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/acpi.h"
 #include "hw/boards.h"
 #include "hw/hotplug.h"
 
@@ -70,6 +70,17 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list);
 
+struct CPUPPTTCaches {
+    enum CacheType type;
+    uint32_t pptt_id;
+    uint32_t sets;
+    uint32_t size;
+    uint32_t level;
+    uint16_t linesize;
+    uint8_t attributes; /* write policy: 0x0 write back, 0x1 write through */
+    uint8_t associativity;
+};
+
 extern const VMStateDescription vmstate_cpu_hotplug;
 #define VMSTATE_CPU_HOTPLUG(cpuhp, state) \
     VMSTATE_STRUCT(cpuhp, state, 1, \
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9a1b0f53d2..2f5f08cd71 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -39,6 +39,7 @@
 #include "system/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "qom/object.h"
+#include "hw/acpi/cpu.h"
 
 #define NUM_GICV2M_SPIS       64
 #define NUM_VIRTIO_TRANSPORTS 32
@@ -50,6 +51,8 @@
 /* GPIO pins */
 #define GPIO_PIN_POWER_BUTTON  3
 
+#define CPU_MAX_CACHES 16
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
@@ -182,7 +185,9 @@ struct VirtMachineState {
 OBJECT_DECLARE_TYPE(VirtMachineState, VirtMachineClass, VIRT_MACHINE)
 
 void virt_acpi_setup(VirtMachineState *vms);
-bool virt_is_acpi_enabled(VirtMachineState *vms);
+bool virt_is_acpi_enabled(const VirtMachineState *vms);
+unsigned int virt_get_caches(const VirtMachineState *vms,
+                             CPUCorePPTTCaches *caches);
 
 /* Return number of redistributors that fit in the specified region */
 static uint32_t virt_redist_capacity(VirtMachineState *vms, int region)
diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
index 98ab91647e..7af609e272 100644
--- a/include/hw/cpu/core.h
+++ b/include/hw/cpu/core.h
@@ -11,6 +11,7 @@
 
 #include "hw/qdev-core.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-machine-common.h"
 
 #define TYPE_CPU_CORE "cpu-core"
 
-- 
2.43.0


