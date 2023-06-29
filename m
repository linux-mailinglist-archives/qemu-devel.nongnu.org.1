Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B599741E1C
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 04:18:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEhDT-00033T-Mw; Wed, 28 Jun 2023 22:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDS-00032n-2D; Wed, 28 Jun 2023 22:17:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qEhDQ-0003yB-8z; Wed, 28 Jun 2023 22:17:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666fb8b1bc8so206624b3a.1; 
 Wed, 28 Jun 2023 19:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688005017; x=1690597017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bn08iYhmP9EqtEkFzK5y1qNpa4zcjhM6e4zEdjb0S4=;
 b=Mdh9orJhAzyydXFR7Wz7GQ6n2y7koXcr3fad9efWDPXjVvFozRdMrvrMrrkousv6Jg
 IxjKW9a9h+k/05Ft0++Va3gH/MQgy40j0wela0hAhq0/2yIJryNeIgWp/pdzlC2ESpNJ
 4TyeWZnl6YIlneeTsCgxPMOvGwZUERTyx6vpzQd0Fxx6xgNvDTQq9lGvZ2zmY/DzGRjU
 J/oXpB6AIEgUfL8E2T2erRpWnK9vRKWtAuat0178bdjsKaw+TdzFh8P7zlysWLCjlrIk
 u0ffxAhPCo9IBl6RwxZRXCMZojck8nQ8Sv4JfXRQ9xCkIz1MlmwSosx2/6sIdhY4AecJ
 CAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688005017; x=1690597017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bn08iYhmP9EqtEkFzK5y1qNpa4zcjhM6e4zEdjb0S4=;
 b=XIu7K37ZbswTkbnIL6t/MSZfkwvhoHDnB5XPGsxg1ueWWuiXH0TMuyV1uPnva6+EMg
 /05YeO3LI0hio1vOVxfEkBx+AV3II328YoouubF2osCAabpApS+jeD5vnMPkSPjn46AE
 txLlPxBWjZRLPWbRD9p+9XfkMTDggo8tsRylqjMB6gngE7zc59WcqLtt/31eCqwvaMf3
 6aBQGL84wL3tbWVDtUs53EaDz05ecbiO9CGRdq/Dpd+a+f4lCBc03nPCSJvb+iSk9civ
 YHRgAPF7vypBSi4xltXL9ZJ086cAW5Y0+5tHCUHEmU63Op87Z8Af+Kb1O6QsyGZnpi2v
 H1kQ==
X-Gm-Message-State: AC+VfDzcSO4tlH8TLEjYPOQKWaGrxEodO1AvnVwv1SJC8gcnYKj4qItM
 G04T4pj35eGQ2+8EljFDVLBF2e3JCzg=
X-Google-Smtp-Source: ACHHUZ4xzkiVHPySSxFkhiX5nm1oDs7Py2vzGohh/wwRaBkg48i3n0vOc7JNwX7pP6c7M1fcG1wLxg==
X-Received: by 2002:a05:6a00:1954:b0:67a:8fc7:1b61 with SMTP id
 s20-20020a056a00195400b0067a8fc71b61mr11192097pfk.11.1688005017004; 
 Wed, 28 Jun 2023 19:16:57 -0700 (PDT)
Received: from wheely.local0.net ([125.254.1.121])
 by smtp.gmail.com with ESMTPSA id
 5-20020aa79145000000b0063b96574b8bsm7480123pfi.220.2023.06.28.19.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 19:16:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [RFC PATCH 3/3] ppc/pnv: SMT support for powernv
Date: Thu, 29 Jun 2023 12:16:33 +1000
Message-Id: <20230629021633.328916-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230629021633.328916-1-npiggin@gmail.com>
References: <20230629021633.328916-1-npiggin@gmail.com>
MIME-Version: 1.0
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

There are several other per-core SPRs, but they are not so important to
run OPAL/Linux. Some important per-LPAR ones to convert before powernv
could run in 1LPAR mode. Broadcast msgsnd is not yet implemented either,
but skiboot/Linux does not use that. KVM uses an implementation-specific
detail of POWER9/10 TLBs where TLBIEL invalidates translations of all
threads on a core, but that is not required here because KVM does not
cache translations across PID or LPID switch. Most of these I have or
aren't too hard to implement, but I start with a small bare bones for
comments.

Not-yet-Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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


