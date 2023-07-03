Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D3745A01
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGd9-0001QB-Qk; Mon, 03 Jul 2023 06:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcf-0000S2-Sj; Mon, 03 Jul 2023 06:17:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcd-0000wD-Sv; Mon, 03 Jul 2023 06:17:33 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666683eb028so2118266b3a.0; 
 Mon, 03 Jul 2023 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688379447; x=1690971447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDDgIXZ0Dz48EHlggB8LitElzh77PIq0t2sx1HDcbcw=;
 b=AFLC93dSgVztL0beEf59Odq/gG7r9gSzh84iSGNXehpd1fPNRuYjZG1lTT3BlnxZza
 eoQGXdnFKyfHnh4VrEY1YBWH5Ye3Dn5GjIW49E/YW1nEfF7Zrl3UOCb+omYQfBX7LF0t
 coHwprjk0qmySwYmkfxHKjJrTNThM4SAX4GFBu+k6z1dnHbqCR2o2vyU9YJPIf2xFNnb
 apz1mhLjBwYXJmrN/d4gMpUzQf3u++R0glnrixDnCtIfUXNvlBvCaBivCmzNtw4rekGv
 3d+9K6QZMiy1sRNWHhMDcCFggw7JDPEMRn/yDXTzTCnfsEGoLnFaGoMCohVPssBpwdNz
 noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379447; x=1690971447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDDgIXZ0Dz48EHlggB8LitElzh77PIq0t2sx1HDcbcw=;
 b=S0tlU69FXov3fe9oFGZU3k/bZMEInL6Zq1KEIZ9JpIdeY1Q68myOTgHbsL+2favzy4
 xXAAdj/QbfNVzcHvRB2EgJfMMB+Zw3qPzfQPWXQT/yq26yqj7Bgs28qCOoJFXIbKC0LG
 Z3oiN/3m8rYmOwIEtOnedWjO4IQt1S65H37BTK2TuHACm4N5ukuHUdxDrrKrq4yAoOLA
 KgT+rrS4Etmt/x5ORlxRjBcD05yMPY1owykExJEpLCRlHT7QWiyvcTQvjJz1xGMg9W24
 /JBSgnkVjsf0L4yUr1WjKcjH0oEQ5wRa4HORMH5mMGqmP6o/cRdrqp4RkR7vHNjE9cqo
 aNwA==
X-Gm-Message-State: ABy/qLaHMqRm9P0jE4846qikFAjcL/NckS0vMAz1g+Z7Qjyy+Mipc2Ah
 5+Z2yhZtLDvAjMku7OfA4ys=
X-Google-Smtp-Source: APBJJlFovDia4jCIKo69Ate6rA7lPu3fsiZa9vuoRLqft062DOzcd3MElXBjwL3jCjkVI20WH08TxA==
X-Received: by 2002:a05:6a00:2da0:b0:668:8596:752f with SMTP id
 fb32-20020a056a002da000b006688596752fmr10915414pfb.4.1688379447458; 
 Mon, 03 Jul 2023 03:17:27 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 o2-20020aa79782000000b006826c9e4397sm3887727pfp.48.2023.07.03.03.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:17:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/4] ppc/pnv: SMT support for powernv
Date: Mon,  3 Jul 2023 20:16:59 +1000
Message-Id: <20230703101700.24064-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703101700.24064-1-npiggin@gmail.com>
References: <20230703101700.24064-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
 hw/ppc/pnv.c      | 12 ++++++++++++
 hw/ppc/pnv_core.c | 13 +++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fc083173f3..f599ccad1d 100644
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
index 0bc3ad41c8..acd83caee8 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -167,12 +167,13 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
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
 
@@ -188,11 +189,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
 
     core_pir = object_property_get_uint(OBJECT(pc), "pir", &error_abort);
 
-    /*
-     * The PIR of a thread is the core PIR + the thread index. We will
-     * need to find a way to get the thread index when TCG supports
-     * more than 1. We could use the object name ?
-     */
+    tir->default_value = thread_index;
     pir->default_value = core_pir + thread_index;
 
     /* Set time-base frequency to 512 MHz */
@@ -241,7 +238,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     }
 
     for (j = 0; j < cc->nr_threads; j++) {
-        pnv_core_cpu_realize(pc, pc->threads[j], &local_err);
+        pnv_core_cpu_realize(pc, pc->threads[j], &local_err, j);
         if (local_err) {
             goto err;
         }
-- 
2.40.1


