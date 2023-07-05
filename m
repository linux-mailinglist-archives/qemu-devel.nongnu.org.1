Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE97483C7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Hl-0004fq-ER; Wed, 05 Jul 2023 08:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1Hi-0004ei-Uv; Wed, 05 Jul 2023 08:07:02 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1Hd-0003Xy-OH; Wed, 05 Jul 2023 08:06:59 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-564e4656fecso4320378eaf.0; 
 Wed, 05 Jul 2023 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688558816; x=1691150816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISNn5BNwQja6M0zx3YuGc7KNUQDOjwu58QCVQx4OvJ8=;
 b=gJAFnhJC82dtMVsIIbGPMe3afTasssjkpDCIytSZ4uH+kPj/Br01ditDw5ZaKUtvTB
 pOxSTY+hNV5rhFXj2ZjM0w9wAKY++aWfTBXcyrSaqRDYDpsoFOBbGVnxS9m+WbcE+ytu
 1IvZOQuz0ySV3tOZETJ39USEvN/2UcVA3unm7Dvo7jYQNt5oKzTy9HIJ8dPSe7BZub+I
 O2KUOpJ5qZ8SarU3kcOmi/kLxQkS1CTp11SHA4OEcCiHISlN39VSLa34jgcN4FHctXY7
 dR7ZltkJHgSKaN0YRZNnxEXbamBOvQJQdRalcwa0ZneuqYI4EkslORFtjYo0bWtkFzbZ
 nOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558816; x=1691150816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ISNn5BNwQja6M0zx3YuGc7KNUQDOjwu58QCVQx4OvJ8=;
 b=N4ZGSqHzePlpHhjfIx7Zkke8dacpjjErRa1At/gE+lFSjCuRpTeZc2j9oSljZgPKEw
 xJsbHMqeia9R3+n3alTebn49cpMD9ERhQtbbEejAjNh4ambEnJBZORSNi2XZ7nlML1YN
 drEOFpCgZ1COahp3cN+dK9cbtPO8AMrQmqNfDn86C1i/El5O6P5HjUH0cJC2duwCITXp
 ClPHNsW1YP7qZpiaFGiBcO0H3OCE9a65jaWIkCDbzAhM/fQO0iG2J4BzAesblduR6wD8
 NGWQ5kDJ0DORYerCXd87gW+E6mt4Xm1l+IRT2Wt39L5CJACWttm84RW1G0olz0cgKSlp
 qUfw==
X-Gm-Message-State: AC+VfDxQzGYYAq+26Enelj+PgWe+OhJCzvU3FXZ/04YrKZFzUyW9aNXo
 db11g2a6kjyszfF3jMC5/sE=
X-Google-Smtp-Source: ACHHUZ6Hj7pEckqAZGRLFycJa7FTjByUDjxVVVcEvB5Kt5DIKKoKWafnIYRNv0tN4sVf1sH0NoWWTA==
X-Received: by 2002:a05:6808:1813:b0:398:268a:1d00 with SMTP id
 bh19-20020a056808181300b00398268a1d00mr19783942oib.51.1688558813706; 
 Wed, 05 Jul 2023 05:06:53 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a00271000b0067459e92801sm15764843pfv.64.2023.07.05.05.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:06:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] ppc/pnv: SMT support for powernv
Date: Wed,  5 Jul 2023 22:06:30 +1000
Message-Id: <20230705120631.27670-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705120631.27670-1-npiggin@gmail.com>
References: <20230705120631.27670-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Set the TIR default value with the SMT thread index, and place some
standard limits on SMT configurations. Now powernv is able to boot
skiboot and Linux with a SMT topology, including booting a KVM guest.

There are several SPRs and other features (e.g., broadcast msgsnd)
that are not implemented, but not used by OPAL or Linux and can be
added incrementally.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/system/ppc/powernv.rst |  5 -----
 hw/ppc/pnv.c                | 12 ++++++++++++
 hw/ppc/pnv_core.c           | 13 +++++--------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index c8f9762342..09f3965858 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -195,11 +195,6 @@ Use a MTD drive to add a PNOR to the machine, and get a NVRAM :
 
   -drive file=./witherspoon.pnor,format=raw,if=mtd
 
-CAVEATS
--------
-
- * No support for multiple HW threads (SMT=1). Same as pseries.
-
 Maintainer contact information
 ------------------------------
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5f25fe985a..23740f9d07 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -887,6 +887,18 @@ static void pnv_init(MachineState *machine)
 
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
+
+    if (machine->smp.threads > 8) {
+        error_report("Cannot support more than 8 threads/core "
+                     "on a powernv machine");
+        exit(1);
+    }
+    if (!is_power_of_2(machine->smp.threads)) {
+        error_report("Cannot support %d threads/core on a powernv"
+                     "machine because it must be a power of 2",
+                     machine->smp.threads);
+        exit(1);
+    }
     /*
      * TODO: should we decide on how many chips we can create based
      * on #cores and Venice vs. Murano vs. Naples chip type etc...,
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index ffbc29cbf4..17c267fa61 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -218,12 +218,13 @@ static const MemoryRegionOps pnv_core_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
+static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
+                                 int thread_index)
 {
     CPUPPCState *env = &cpu->env;
     int core_pir;
-    int thread_index = 0; /* TODO: TCG supports only one thread */
     ppc_spr_t *pir = &env->spr_cb[SPR_PIR];
+    ppc_spr_t *tir = &env->spr_cb[SPR_TIR];
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
@@ -239,11 +240,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
 
     core_pir = object_property_get_uint(OBJECT(pc), "pir", &error_abort);
 
-    /*
-     * The PIR of a thread is the core PIR + the thread index. We will
-     * need to find a way to get the thread index when TCG supports
-     * more than 1. We could use the object name ?
-     */
+    tir->default_value = thread_index;
     pir->default_value = core_pir + thread_index;
 
     /* Set time-base frequency to 512 MHz */
@@ -292,7 +289,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        pnv_core_cpu_realize(pc, pc->threads[j], &local_err);
+        pnv_core_cpu_realize(pc, pc->threads[j], &local_err, j);
         if (local_err) {
             goto err;
         }
-- 
2.40.1


