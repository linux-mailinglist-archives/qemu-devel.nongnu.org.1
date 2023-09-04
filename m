Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4F79146C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Yk-0003VH-I0; Mon, 04 Sep 2023 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yb-0003Cn-6A; Mon, 04 Sep 2023 05:07:41 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YY-0003qU-GI; Mon, 04 Sep 2023 05:07:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7s3kK2z4x09;
 Mon,  4 Sep 2023 19:07:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7q30tRz4wxN;
 Mon,  4 Sep 2023 19:07:35 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 23/35] spapr: Fix machine reset deadlock from replay-record
Date: Mon,  4 Sep 2023 11:06:18 +0200
Message-ID: <20230904090630.725952-24-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

When the machine is reset to load a new snapshot while being debugged
with replay-record, it is done from another thread, so the CPU does
not run the register setting operations. Set CPU registers directly in
machine reset.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h |  1 +
 target/ppc/cpu.h       |  1 +
 hw/ppc/spapr.c         | 20 ++++++++++++++++++--
 target/ppc/compat.c    | 19 +++++++++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 538b2dfb8996..f47e8419a575 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1012,6 +1012,7 @@ bool spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
+void spapr_init_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
 bool spapr_memory_hot_unplug_supported(SpaprMachineState *spapr);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 77113521acfd..173e4c351a41 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1504,6 +1504,7 @@ int ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr, Error **errp);
 
 #if !defined(CONFIG_USER_ONLY)
 int ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp);
 #endif
 int ppc_compat_max_vthreads(PowerPCCPU *cpu);
 void ppc_compat_add_property(Object *obj, const char *name,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 07e91e380077..c0b0ada121f9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1322,6 +1322,22 @@ void spapr_set_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
+/* May be used when the machine is not running */
+void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
+{
+    CPUState *cs;
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        CPUPPCState *env = &cpu->env;
+        target_ulong lpcr;
+
+        lpcr = env->spr[SPR_LPCR];
+        lpcr &= ~(LPCR_HR | LPCR_UPRT);
+        ppc_store_lpcr(cpu, lpcr);
+    }
+}
+
+
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1583,7 +1599,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
     }
     /* We're setting up a hash table, so that means we're not radix */
     spapr->patb_entry = 0;
-    spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
+    spapr_init_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
     return 0;
 }
 
@@ -1661,7 +1677,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
     spapr_ovec_cleanup(spapr->ov5_cas);
     spapr->ov5_cas = spapr_ovec_new();
 
-    ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
+    ppc_init_compat_all(spapr->max_compat_pvr, &error_fatal);
 
     /*
      * This is fixing some of the default configuration of the XIVE
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7949a24f5a15..ebef2cccecf3 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -229,6 +229,25 @@ int ppc_set_compat_all(uint32_t compat_pvr, Error **errp)
     return 0;
 }
 
+/* To be used when the machine is not running */
+int ppc_init_compat_all(uint32_t compat_pvr, Error **errp)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+        int ret;
+
+        ret = ppc_set_compat(cpu, compat_pvr, errp);
+
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 int ppc_compat_max_vthreads(PowerPCCPU *cpu)
 {
     const CompatInfo *compat = compat_by_pvr(cpu->compat_pvr);
-- 
2.41.0


