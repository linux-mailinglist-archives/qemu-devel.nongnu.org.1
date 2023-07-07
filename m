Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26474B03E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:48:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhr-0003OA-67; Fri, 07 Jul 2023 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhl-0003D2-4l; Fri, 07 Jul 2023 07:32:53 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhh-0006ng-TT; Fri, 07 Jul 2023 07:32:52 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b75637076eso1627613a34.2; 
 Fri, 07 Jul 2023 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729568; x=1691321568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBqNDvSs5Wa5TnsOiDj0bWKOiiB8IyybwzexMIV6a1s=;
 b=hN/Xz0pxd3i2PpIjXRdLwfvtDpezuRnk+Pk1LFVZQsjU7CZ9ZDC9nmmZT/Ia2yViGo
 AbmavQ+PJCAHZKgpiCcf2CHupsmuDqzQulZ4sYpGqF7ZeBKRH1o+XPqPI82ZoduCuY3m
 2G+lk/NNx12UPhfu+SeqjGNmpwBr3ezVkp8ISdH+AqdxjTkaY19LjjXG84TdgFrj4TTx
 9JMtK+7kDa51+CqtnFcWh+6DB2CqOQraHY6+scg1gR8cCPx3pWiFu+JdwgJnc1UA7sc6
 3pKkOjsUm1ClqCXEOC9UPD2v9On5PZc5wZ3fopnxKz0brfM5e2mPYjHOTIZD2fe/Rw0P
 QAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729568; x=1691321568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBqNDvSs5Wa5TnsOiDj0bWKOiiB8IyybwzexMIV6a1s=;
 b=i/eZuk2D+qgZrQXspg4e6kYuZiSkFt5SQ4CLVseZeOq1vIKYyt5NgwPbH/fKmgJjkF
 FeEgtfCjAlQai5yqwqqod+hvhnqeoDlJUXgeSN01L3xakxhpvp9hxo/jkETxM8V/Gt19
 x28UKKwdzfLzEOsbf7ci6Hl6HjTxjtmEpiWvWwujDvFySo6HiX+0vFkze5yQEkHiy3eJ
 zhNRb3CE+L2t9TIeqlq32KdJO0nzHw2CeO2XMsXJtriuYOb7XCX4F/8t/PezctTRyvpU
 OUPVEpziSf0OowbRobI/s+uodv/VvC+5p0xnLE7eJeYwIFa52U/m6q43eW+ABPGZ5EcC
 U54A==
X-Gm-Message-State: ABy/qLaF3IBgfAEhqiQDvRscM9W0SyqGyP0JcSWCUay2T9a2fcdTIfl+
 4ADeTLbpJoFU/zWwIN6A5Rm5UElrrkI=
X-Google-Smtp-Source: APBJJlGc28a271HqCWw/ZgKnx6ouWqaDY1PEgdQytJXsNQP7P7SV/qAmsz11lOK9zcGqNDb0yxlhLw==
X-Received: by 2002:a9d:6210:0:b0:6b8:8174:80e4 with SMTP id
 g16-20020a9d6210000000b006b8817480e4mr5003522otj.21.1688729567830; 
 Fri, 07 Jul 2023 04:32:47 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:47 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 33/60] ppc/pnv: SMT support for powernv
Date: Fri,  7 Jul 2023 08:30:41 -0300
Message-ID: <20230707113108.7145-34-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Set the TIR default value with the SMT thread index, and place some
standard limits on SMT configurations. Now powernv is able to boot
skiboot and Linux with a SMT topology, including booting a KVM guest.

There are several SPRs and other features (e.g., broadcast msgsnd)
that are not implemented, but not used by OPAL or Linux and can be
added incrementally.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230705120631.27670-4-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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
index b7223bb445..8a72171ce0 100644
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
2.41.0


