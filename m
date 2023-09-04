Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FA4791479
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Yp-0003aX-AU; Mon, 04 Sep 2023 05:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yd-0003Ja-D9; Mon, 04 Sep 2023 05:07:47 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yb-0003r2-3X; Mon, 04 Sep 2023 05:07:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7w0yrpz4wxW;
 Mon,  4 Sep 2023 19:07:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7t0K1sz4wxN;
 Mon,  4 Sep 2023 19:07:37 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 24/35] spapr: Fix record-replay machine reset consuming too
 many events
Date: Mon,  4 Sep 2023 11:06:19 +0200
Message-ID: <20230904090630.725952-25-clg@kaod.org>
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

spapr_machine_reset gets a random number to populate the device-tree
rng seed with. When loading a snapshot for record-replay, the machine
is reset again, and that tries to consume the random event record
again, crashing due to inconsistent record

Fix this by saving the seed to populate the device tree with, and
skipping the rng on snapshot load.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr.h |  1 +
 hw/ppc/spapr.c         | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f47e8419a575..f4bd204d8633 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -204,6 +204,7 @@ struct SpaprMachineState {
     uint32_t fdt_size;
     uint32_t fdt_initial_size;
     void *fdt_blob;
+    uint8_t fdt_rng_seed[32];
     long kernel_size;
     bool kernel_le;
     uint64_t kernel_addr;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c0b0ada121f9..f7cc6a890f45 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1022,7 +1022,6 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
 {
     MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
-    uint8_t rng_seed[32];
     int chosen;
 
     _FDT(chosen = fdt_add_subnode(fdt, 0, "chosen"));
@@ -1100,8 +1099,7 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         spapr_dt_ov5_platform_support(spapr, fdt, chosen);
     }
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    _FDT(fdt_setprop(fdt, chosen, "rng-seed", rng_seed, sizeof(rng_seed)));
+    _FDT(fdt_setprop(fdt, chosen, "rng-seed", spapr->fdt_rng_seed, 32));
 
     _FDT(spapr_dt_ovec(fdt, chosen, spapr->ov5_cas, "ibm,architecture-vec-5"));
 }
@@ -1654,6 +1652,14 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
     void *fdt;
     int rc;
 
+    if (reason != SHUTDOWN_CAUSE_SNAPSHOT_LOAD) {
+        /*
+         * Record-replay snapshot load must not consume random, this was
+         * already replayed from initial machine reset.
+         */
+        qemu_guest_getrandom_nofail(spapr->fdt_rng_seed, 32);
+    }
+
     pef_kvm_reset(machine->cgs, &error_fatal);
     spapr_caps_apply(spapr);
 
-- 
2.41.0


