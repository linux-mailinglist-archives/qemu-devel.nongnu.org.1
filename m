Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E296E7737E8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:23:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDt-0008Gd-6P; Tue, 08 Aug 2023 00:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDq-0008Et-Oe; Tue, 08 Aug 2023 00:21:30 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDo-0007q4-Vu; Tue, 08 Aug 2023 00:21:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so5213028b3a.3; 
 Mon, 07 Aug 2023 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468487; x=1692073287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4nIyoBZpzkLWiOsMGF0XETST9Jt61px+DBqOx+1JmI=;
 b=AHNFvaLiOzcccjTlzZHfQvOnZx3LGPeK7aUog+oLbmwckPThrHZIVqMWGFGp+vDZD8
 Gd1v9AWUEP+PvRwcmCs81hbD/o3dM4a2iTDwSnWvuYl41W2RcBqVEUylBCSc7EzCa7Sp
 zfuQa1JN/Rqw6L1klU+4+MNkmck+jr567eVNcDICc4dhZCND5u8PAdLJsFQOPMzibcka
 HwoVLDlZZFHZD308tchBMiPEtQWOJe6rd2coUpFaX4k4u17BJAV+/QxEF0PQw0Tp8Ymp
 v/XXbLv6t3BThtfaHb1BkXwNxUXvtQ8rUSn+l2fKWn+2Brg7p8lCfpymlOctH3Tut78Q
 XCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468487; x=1692073287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4nIyoBZpzkLWiOsMGF0XETST9Jt61px+DBqOx+1JmI=;
 b=hHoD5srqdp59in+zLC5I8A/goW+4AcbocMIEaXtne1N8haY690kdcjcZ1AaRxUXGC/
 gbiefRddil2D5Ui4fLFCVwTgs9/gOOi0Ijyzfd2jpVuvBI0Xs7PwL44Po7rN6nmNFoyX
 OZ101togB0LBmwRv/LQpBdGMXN30TAiZU2DG9reK+u1l89vCCOdK+jTcCiP2pfJgzzjq
 eTP6joyzO3FExvXlvErV6/UlLZNLH0/pOYFB4GNc437TAmdjgh9osNGvPATx38XFH15p
 DSWY2DMd5tvi4zFgHKV7mpEa0fv24Gzv54rLzkfkz4Ke/Ka7I7eSMUbCBTH1PGkXbHV2
 Tavg==
X-Gm-Message-State: AOJu0YxCgDugZs0M6lJkXTbIVOyiOv4vNYVj6qOg0z92FceGdF/24f0s
 T1aDnvwyV044mde0m5RGR2U=
X-Google-Smtp-Source: AGHT+IGs2n/QcuZbzImQ3aG9hapkyszjtcJbpcruzm6mG3kKhdSoK3/Ajej7HGulM471bub/iIs2Vw==
X-Received: by 2002:a05:6a20:449:b0:12f:a373:ba8d with SMTP id
 b9-20020a056a20044900b0012fa373ba8dmr11431731pzb.24.1691468487191; 
 Mon, 07 Aug 2023 21:21:27 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 16/19] spapr: Fix record-replay machine reset consuming too
 many events
Date: Tue,  8 Aug 2023 14:19:58 +1000
Message-Id: <20230808042001.411094-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

spapr_machine_reset gets a random number to populate the device-tree
rng seed with. When loading a snapshot for record-replay, the machine
is reset again, and that tries to consume the random event record
again, crashing due to inconsistent record

Fix this by saving the seed to populate the device tree with, and
skipping the rng on snapshot load.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 12 +++++++++---
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7d84244f03..ecfbdb0030 100644
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
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f47e8419a5..f4bd204d86 100644
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
-- 
2.40.1


