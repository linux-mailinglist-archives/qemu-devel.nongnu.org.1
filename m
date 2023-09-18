Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C277A4B60
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFj8-0000Lt-2x; Mon, 18 Sep 2023 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFit-0000FP-9t; Mon, 18 Sep 2023 10:59:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiFil-00061G-I2; Mon, 18 Sep 2023 10:59:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rq7HG0zxWz4xM7;
 Tue, 19 Sep 2023 00:59:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rq7HC4MKHz4xNG;
 Tue, 19 Sep 2023 00:59:19 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/8] spapr: Clean up local variable shadowing in
 spapr_dt_cpus()
Date: Mon, 18 Sep 2023 16:58:45 +0200
Message-ID: <20230918145850.241074-4-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918145850.241074-1-clg@kaod.org>
References: <20230918145850.241074-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=KtGU=FC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

Introduce a helper routine defining one CPU device node to fix this
warning :

  ../hw/ppc/spapr.c: In function ‘spapr_dt_cpus’:
  ../hw/ppc/spapr.c:812:19: warning: declaration of ‘cs’ shadows a previous local [-Wshadow=compatible-local]
    812 |         CPUState *cs = rev[i];
        |                   ^~
  ../hw/ppc/spapr.c:786:15: note: shadowed declaration is here
    786 |     CPUState *cs;
        |               ^~

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index de3c616b4637..d89f0fd496b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -780,6 +780,26 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
                               pcc->lrg_decr_bits)));
 }
 
+static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
+                             int cpus_offset)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    int index = spapr_get_vcpu_id(cpu);
+    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    g_autofree char *nodename = NULL;
+    int offset;
+
+    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
+        return;
+    }
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
+    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
+    _FDT(offset);
+    spapr_dt_cpu(cs, fdt, offset, spapr);
+}
+
+
 static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
 {
     CPUState **rev;
@@ -809,21 +829,7 @@ static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
     }
 
     for (i = n_cpus - 1; i >= 0; i--) {
-        CPUState *cs = rev[i];
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        int index = spapr_get_vcpu_id(cpu);
-        DeviceClass *dc = DEVICE_GET_CLASS(cs);
-        g_autofree char *nodename = NULL;
-        int offset;
-
-        if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-            continue;
-        }
-
-        nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
-        offset = fdt_add_subnode(fdt, cpus_offset, nodename);
-        _FDT(offset);
-        spapr_dt_cpu(cs, fdt, offset, spapr);
+        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
     }
 
     g_free(rev);
-- 
2.41.0


