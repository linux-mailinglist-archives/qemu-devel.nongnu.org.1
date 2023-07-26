Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F1C763F43
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:10:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjMW-0000B1-7i; Wed, 26 Jul 2023 14:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMT-00008u-HU; Wed, 26 Jul 2023 14:35:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMR-0008Eh-RL; Wed, 26 Jul 2023 14:35:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so716945ad.1; 
 Wed, 26 Jul 2023 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396546; x=1691001346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQcYlfJ1g+AfvOYwtN/gl8mmYP+jyHxbUuizv7xOcwM=;
 b=eY3nnYw3UJjmVYgNMT7Vl42xwPQPTghClhKhTlAQlPjJ5I335peitRzg2eQ7VXq89c
 MpIM5+1dnpDRDYvypmKRHHK0cTxJBt9Sy3Cm7yJ7lhRfEeqGSDb4OALe8CYqjuHmR1nr
 6KsZsiskvclWiEYUIhVxvPtgDdKH6qlJ0okUBRDEMcg7aazjtFA9XOWip6sn/6l/zeTb
 H8q6G9yy53GIbkCKGqAlr/ZaF0Q8BALDwPTjj6T092pAr+GqbyzwQOY5Y1ynQlbahivw
 jDk8ZjO7hZWzNhmgNfJ1ot83UPK3hNEU5MFJESovmFUGUw1C6Rqpyj2BKrZvWvkTKqRo
 OYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396546; x=1691001346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQcYlfJ1g+AfvOYwtN/gl8mmYP+jyHxbUuizv7xOcwM=;
 b=ADBdXv1zb/U1xrtRPvaPxfMlH7GShwj+ATaxYQ8+/mb7UOJJLsCPbeFuQ3VTInzmK6
 5trbpJ5DcJrF6VwhGiittEp4NiNJil26l04w8SB71e/clcu/J0vJ1NaGo1hH1T2Oz434
 qkZ/GpvLPxMvyOw02uJJ0GWgBeLzJayAuMYAkDrDcAKDcymG2R+fJNfWck8ZwTZC3tnW
 UI0KZFHvd/xan/hJ3f2xPBIrPc9JzdoMLdQj23SewfsUlgV5nXOBfNjsVnmi1afeekFa
 gZZPpyCZ8llasp4wXlAAHiedkcLkpIm5tyyx8qId2jSfa2PUFRAKpZ5TDEbjMo6m/x6Z
 ZOng==
X-Gm-Message-State: ABy/qLZp5nc0kLb8iJpTRAgTyuubtwvTAOgn+bpfGTgQyeiAEJ66oDu8
 6WMxRDC+nBx4ChdQUB9UvjM=
X-Google-Smtp-Source: APBJJlEmRDAaNbUbGu+715wQqFZ5dKRqIcltjSCu2fXA2qxaZ95NgEXF/WDSkCezaXPpX6NltRejHA==
X-Received: by 2002:a17:902:c951:b0:1ac:5717:fd5 with SMTP id
 i17-20020a170902c95100b001ac57170fd5mr3491465pla.60.1690396546132; 
 Wed, 26 Jul 2023 11:35:46 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:35:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 1/7] target/ppc: Fix CPU reservation migration for
 record-replay
Date: Thu, 27 Jul 2023 04:35:26 +1000
Message-Id: <20230726183532.434380-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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
---
 target/ppc/cpu.h       |  2 ++
 target/ppc/machine.c   | 26 ++++++++++++++++++++++++--
 target/ppc/translate.c |  4 ++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577a..27532d8f81 100644
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
index ebb37e07d0..9f956b972c 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -10,6 +10,7 @@
 #include "qemu/main-loop.h"
 #include "kvm_ppc.h"
 #include "power8-pmu.h"
+#include "sysemu/replay.h"
 
 static void post_load_update_msr(CPUPPCState *env)
 {
@@ -685,6 +686,27 @@ static const VMStateDescription vmstate_compat = {
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
@@ -706,8 +728,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         VMSTATE_UINTTL_ARRAY(env.spr, PowerPCCPU, 1024),
         VMSTATE_UINT64(env.spe_acc, PowerPCCPU),
 
-        /* Reservation */
-        VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+        VMSTATE_UNUSED(sizeof(target_ulong)), /* was env.reserve_addr */
 
         /* Supervisor mode architected state */
         VMSTATE_UINTTL(env.msr, PowerPCCPU),
@@ -736,6 +757,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbemb,
         &vmstate_tlbmas,
         &vmstate_compat,
+        &vmstate_reservation,
         NULL
     }
 };
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e6a0709066..b88c00b4b0 100644
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
2.40.1


