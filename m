Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16079147F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Y2-0001cz-WD; Mon, 04 Sep 2023 05:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Y0-0001Wi-1v; Mon, 04 Sep 2023 05:07:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xu-0003da-Uq; Mon, 04 Sep 2023 05:07:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN756nGHz4x09;
 Mon,  4 Sep 2023 19:06:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN740tBZz4wxW;
 Mon,  4 Sep 2023 19:06:55 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 08/35] spapr: implement H_SET_MODE debug facilities
Date: Mon,  4 Sep 2023 11:06:03 +0200
Message-ID: <20230904090630.725952-9-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Wire up the H_SET_MODE debug resources to the CIABR and DAWR0 debug
facilities in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_hcall.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9b1f225d4a5d..b7dc388f2fc9 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,6 +3,7 @@
 #include "qapi/error.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
+#include "sysemu/tcg.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -789,6 +790,54 @@ static target_ulong h_logical_dcbf(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_set_mode_resource_set_ciabr(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong mflags,
+                                                  target_ulong value1,
+                                                  target_ulong value2)
+{
+    CPUPPCState *env = &cpu->env;
+
+    assert(tcg_enabled()); /* KVM will have handled this */
+
+    if (mflags) {
+        return H_UNSUPPORTED_FLAG;
+    }
+    if (value2) {
+        return H_P4;
+    }
+    if ((value1 & PPC_BITMASK(62, 63)) == 0x3) {
+        return H_P3;
+    }
+
+    ppc_store_ciabr(env, value1);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong mflags,
+                                                  target_ulong value1,
+                                                  target_ulong value2)
+{
+    CPUPPCState *env = &cpu->env;
+
+    assert(tcg_enabled()); /* KVM will have handled this */
+
+    if (mflags) {
+        return H_UNSUPPORTED_FLAG;
+    }
+    if (value2 & PPC_BIT(61)) {
+        return H_P4;
+    }
+
+    ppc_store_dawr0(env, value1);
+    ppc_store_dawrx0(env, value2);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_set_mode_resource_le(PowerPCCPU *cpu,
                                            SpaprMachineState *spapr,
                                            target_ulong mflags,
@@ -858,6 +907,14 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong ret = H_P2;
 
     switch (resource) {
+    case H_SET_MODE_RESOURCE_SET_CIABR:
+        ret = h_set_mode_resource_set_ciabr(cpu, spapr, args[0], args[2],
+                                            args[3]);
+        break;
+    case H_SET_MODE_RESOURCE_SET_DAWR0:
+        ret = h_set_mode_resource_set_dawr0(cpu, spapr, args[0], args[2],
+                                            args[3]);
+        break;
     case H_SET_MODE_RESOURCE_LE:
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
         break;
-- 
2.41.0


