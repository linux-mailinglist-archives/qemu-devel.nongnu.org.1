Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F097737DB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDe-0007QI-Ee; Tue, 08 Aug 2023 00:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDb-0007In-RQ; Tue, 08 Aug 2023 00:21:15 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDZ-0007ns-W0; Tue, 08 Aug 2023 00:21:15 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5052976b3a.2; 
 Mon, 07 Aug 2023 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468472; x=1692073272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDoBnWU9nJFYhYMaJ09B/DrZ52b50Hn/a9GD0l2GXqY=;
 b=B6F5OWDlr3SS1m/25MhItVOWNPkUVZk8ePecvD4fAl6iNKUWWv1sWkfZ9ZUxGyPQPY
 UCcT0Y71VwE4Hp1aOJmrBdFlIGGfDvs5KVrlZw1Vpfcfon+1uGnkObdONf/RjIwpmOuP
 QhKZ1JXDLjEO+Y4zuJ6kuKEwuPWntaRlLHRhKiovF1/gMvJEARkotTBaoZauTJD8JeVw
 LoDi5vaiEB03HFpiSGDNljsiCBuah6VtPuB9xOVrkTzvmzVkoUPwcrJqwU9wRjqsQ7Kk
 N/nTJxDA6QecTqskqM3Stc7d7u1GnVU8H97/06obb7Up9QBsOXFr7A05zzDtzteD7l7H
 6tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468472; x=1692073272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NDoBnWU9nJFYhYMaJ09B/DrZ52b50Hn/a9GD0l2GXqY=;
 b=kp0CnggcqKfF05BS8hyMkRUhQGa6KOob7Cw4q36xG0sjc1HHjN5W1YI+PJm0KdbYd6
 fX7Yck1U7pOEc0yweaaygswxhLCvfDLeYKD2SpA2s7cydKqHsi6skg3RCRKzYhDB/nyB
 VDGN51yp9StjhO1yDLWlBnisosVZgA9U5WZcw35iqiUZNXZPVJ87V4jivxpiBA6EHQzk
 SEQPk0hC6wyS4IlL7h+Cws2rsVDf3ZTiZQCIPrg6MujTI5NQftXXejF5PpWsDuQ0zTVp
 +l7yR7m7KC4OvZEruHqXBPhB7nPU5BxgLbLqRymH7nMVou92C4A16ejXT1HBr07Vxd57
 a1GA==
X-Gm-Message-State: AOJu0YztAtfOO0suwHnljLa6JL8HPlB7xEl+Nva+QOyr1jmvkWchQ6JN
 dgttPpPTsYykHaFTtcdpXCQ=
X-Google-Smtp-Source: AGHT+IEOzlImFZwx5jXiTGocVHuE5KhDCeNbspIYwLowcLK0tb1bgByDZ+SZ2xxHiNu5wVuLcP3RHQ==
X-Received: by 2002:aa7:88c1:0:b0:682:537f:2cb8 with SMTP id
 k1-20020aa788c1000000b00682537f2cb8mr14957489pff.26.1691468472262; 
 Mon, 07 Aug 2023 21:21:12 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 13/19] target/ppc: Fix CPU reservation migration for
 record-replay
Date: Tue,  8 Aug 2023 14:19:55 +1000
Message-Id: <20230808042001.411094-14-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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
index 2777ea3110..9e491e05eb 100644
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
index 8a190c4853..ad7b4f6338 100644
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
index b8c7f38ccd..4a60aefd8f 100644
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


