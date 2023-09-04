Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB2791480
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Yc-0003Co-9p; Mon, 04 Sep 2023 05:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YY-00032C-Gr; Mon, 04 Sep 2023 05:07:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YU-0003qr-Jx; Mon, 04 Sep 2023 05:07:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7m22Q5z4x2Z;
 Mon,  4 Sep 2023 19:07:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7j4NLpz4x2W;
 Mon,  4 Sep 2023 19:07:29 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 21/35] target/ppc: Fix CPU reservation migration for
 record-replay
Date: Mon,  4 Sep 2023 11:06:16 +0200
Message-ID: <20230904090630.725952-22-clg@kaod.org>
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

ppc only migrates reserve_addr, so the destination machine can get a
valid reservation with an incorrect reservation value of 0. Prior to
commit 392d328abe753 ("target/ppc: Ensure stcx size matches larx"),
this could permit a stcx. to incorrectly succeed. That commit
inadvertently fixed that bug because the target machine starts with an
impossible reservation size of 0, so any stcx. will fail.

This behaviour is permitted by the ISA because reservation loss may
have implementation-dependent cause. What's more, with KVM machines it
is impossible save or reasonably restore reservation state. However if
the vmstate is being used for record-replay, the reservation must be
saved and restored exactly in order for execution from snapshot to
match the record.

This patch deprecates the existing incomplete reserve_addr vmstate,
and adds a new vmstate subsection with complete reservation state.
The new vmstate is needed only when record-replay mode is active.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h       |  2 ++
 target/ppc/machine.c   | 26 ++++++++++++++++++++++++--
 target/ppc/translate.c |  4 ++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7e7a60f68f79..77113521acfd 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1121,7 +1121,9 @@ struct CPUArchState {
     target_ulong reserve_addr;   /* Reservation address */
     target_ulong reserve_length; /* Reservation larx op size (bytes) */
     target_ulong reserve_val;    /* Reservation value */
+#if defined(TARGET_PPC64)
     target_ulong reserve_val2;
+#endif
 
     /* These are used in supervisor mode only */
     target_ulong msr;      /* machine state register */
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 8a190c485363..ad7b4f633827 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -10,6 +10,7 @@
 #include "qemu/main-loop.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
+#include "sysemu/replay.h"
 
 static void post_load_update_msr(CPUPPCState *env)
 {
@@ -690,6 +691,27 @@ static const VMStateDescription vmstate_compat = {
     }
 };
 
+static bool reservation_needed(void *opaque)
+{
+    return (replay_mode != REPLAY_MODE_NONE);
+}
+
+static const VMStateDescription vmstate_reservation = {
+    .name = "cpu/reservation",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = reservation_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+        VMSTATE_UINTTL(env.reserve_length, PowerPCCPU),
+        VMSTATE_UINTTL(env.reserve_val, PowerPCCPU),
+#if defined(TARGET_PPC64)
+        VMSTATE_UINTTL(env.reserve_val2, PowerPCCPU),
+#endif
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_ppc_cpu = {
     .name = "cpu",
     .version_id = 5,
@@ -711,8 +733,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         VMSTATE_UINTTL_ARRAY(env.spr, PowerPCCPU, 1024),
         VMSTATE_UINT64(env.spe_acc, PowerPCCPU),
 
-        /* Reservation */
-        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+        VMSTATE_UNUSED(sizeof(target_ulong)), /* was env.reserve_addr */
 
         /* Supervisor mode architected state */
         VMSTATE_UINTTL(env.msr, PowerPCCPU),
@@ -741,6 +762,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbemb,
         &vmstate_tlbmas,
         &vmstate_compat,
+        &vmstate_reservation,
         NULL
     }
 };
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b8c7f38ccdec..4a60aefd8fd9 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -77,7 +77,9 @@ static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
 static TCGv cpu_reserve_length;
 static TCGv cpu_reserve_val;
+#if defined(TARGET_PPC64)
 static TCGv cpu_reserve_val2;
+#endif
 static TCGv cpu_fpscr;
 static TCGv_i32 cpu_access_type;
 
@@ -151,9 +153,11 @@ void ppc_translate_init(void)
     cpu_reserve_val = tcg_global_mem_new(cpu_env,
                                          offsetof(CPUPPCState, reserve_val),
                                          "reserve_val");
+#if defined(TARGET_PPC64)
     cpu_reserve_val2 = tcg_global_mem_new(cpu_env,
                                           offsetof(CPUPPCState, reserve_val2),
                                           "reserve_val2");
+#endif
 
     cpu_fpscr = tcg_global_mem_new(cpu_env,
                                    offsetof(CPUPPCState, fpscr), "fpscr");
-- 
2.41.0


