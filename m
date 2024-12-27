Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66BF9FD096
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Dec 2024 07:22:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR3jw-0003C6-9z; Fri, 27 Dec 2024 01:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tR3jl-0003AF-Po
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:18 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tR3jj-0000Ky-RQ
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:17 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxUa+WR25nptlaAA--.48261S3;
 Fri, 27 Dec 2024 14:22:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eQR25nZ54KAA--.56394S6;
 Fri, 27 Dec 2024 14:22:13 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL v2 4/6] hw/loongarch/virt: Improve fdt table creation for CPU
 object
Date: Fri, 27 Dec 2024 14:22:06 +0800
Message-Id: <20241227062208.1232281-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241227062208.1232281-1-maobibo@loongson.cn>
References: <20241227062208.1232281-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eQR25nZ54KAA--.56394S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For CPU object, possible_cpu_arch_ids() function is used rather than
smp.cpus. With command -smp x, -device la464-loongarch-cpu, smp.cpus
is not accurate for all possible CPU objects, possible_cpu_arch_ids()
is used here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 266f291509..99594a13a0 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -365,26 +365,35 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
 static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
 {
     int num;
-    const MachineState *ms = MACHINE(lvms);
-    int smp_cpus = ms->smp.cpus;
+    MachineState *ms = MACHINE(lvms);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus;
+    LoongArchCPU *cpu;
+    CPUState *cs;
+    char *nodename, *map_path;
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
     qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
     /* cpu nodes */
-    for (num = smp_cpus - 1; num >= 0; num--) {
-        char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
-        LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
-        CPUState *cs = CPU(cpu);
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    for (num = 0; num < possible_cpus->len; num++) {
+        cs = possible_cpus->cpus[num].cpu;
+        if (cs == NULL) {
+            continue;
+        }
+
+        nodename = g_strdup_printf("/cpus/cpu@%d", num);
+        cpu = LOONGARCH_CPU(cs);
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
         qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
         qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                                 cpu->dtb_compatible);
-        if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
+        if (possible_cpus->cpus[num].props.has_node_id) {
             qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id",
-                ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
+                possible_cpus->cpus[num].props.node_id);
         }
         qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
         qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
@@ -394,11 +403,13 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
 
     /*cpu map */
     qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
+    for (num = 0; num < possible_cpus->len; num++) {
+        cs = possible_cpus->cpus[num].cpu;
+        if (cs == NULL) {
+            continue;
+        }
 
-    for (num = smp_cpus - 1; num >= 0; num--) {
-        char *cpu_path = g_strdup_printf("/cpus/cpu@%d", num);
-        char *map_path;
-
+        nodename = g_strdup_printf("/cpus/cpu@%d", num);
         if (ms->smp.threads > 1) {
             map_path = g_strdup_printf(
                 "/cpus/cpu-map/socket%d/core%d/thread%d",
@@ -412,10 +423,10 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
                 num % ms->smp.cores);
         }
         qemu_fdt_add_path(ms->fdt, map_path);
-        qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", cpu_path);
+        qemu_fdt_setprop_phandle(ms->fdt, map_path, "cpu", nodename);
 
         g_free(map_path);
-        g_free(cpu_path);
+        g_free(nodename);
     }
 }
 
-- 
2.43.5


