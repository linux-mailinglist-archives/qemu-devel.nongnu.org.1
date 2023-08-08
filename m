Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5A57737D6
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDa-00079F-3U; Tue, 08 Aug 2023 00:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDX-00078x-57; Tue, 08 Aug 2023 00:21:11 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDV-0007nP-AE; Tue, 08 Aug 2023 00:21:10 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3a4875e65a3so3641896b6e.2; 
 Mon, 07 Aug 2023 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468467; x=1692073267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCnCdFj9EuliCkE/oMkl/TySBNxO/JoW1C8ZeaibWDg=;
 b=iXECEEG+QZVy5rAtkW/kmbtBGE15pkDa2nDAO2WOqQR+cTK4skh8bnKBodBAYK+ac1
 LD++KTt7VDb1wMWNXaGoJ0RRBuz+x75cmhp7EP+grbnvZBZ2QHrrtj/hNRIkaHQ+CqZd
 wMa1cjtXrixqVgS2TRepaKJkHB1bhxTQBBWheKAYCa2IgsRw6rHB0Qe2Xc5wr8/ndqHW
 OJBOnxCirNUEmnSE2yssPPP+Bj57ISMqP7yiJfShsUb9OlvIyY/PmZSOavm8tIS+EAJM
 /eh55uPTNGtHJuUyH+F/5EzG5nSGM5+2dJuS6hSGRXCnXZBrF50euv/KBzF5wuvUc5jj
 lnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468467; x=1692073267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCnCdFj9EuliCkE/oMkl/TySBNxO/JoW1C8ZeaibWDg=;
 b=BVNbK2VBWgW1TD0vn7nU5o5bIcOrVh6pHL7dlin/fSvOJ1av17nJZdc7Td2PjruIp/
 letbCYLE7q7f6e091VuTeQNzlbqHFXqbah2lVw/2lCO1NBSUXzYbbZ9t2uqKSPbWWQ5s
 pOPaFYNFMUK8Xad/5vPXbmvcISPhFQwj1SFd5jmqlgXdPWLMO41cZkOcsGqtwpjl9wsu
 mCPSyBl/QVz45gmDre0QJnmzdstvXyWelVSagKjJPmDLUyLuIaTgl6tVI74UBltvjPwe
 ZtCXG3B/TbBAvM6FjGhRGXk1jtia2OL0F2KmmbllgjghU7xN5fU328/F5B2r2D/AyZiU
 alkg==
X-Gm-Message-State: AOJu0YxZ/LMzsqS3whOn/LSjwDqQYqZ26xi3m7ORKP2MTOCtJlMaHweP
 7ET7qZQnnluhCmpkGpN1M40=
X-Google-Smtp-Source: AGHT+IFzAfKVf2yM7fO5eJWk4udIsyh6rXjOdPzaDJFrSbp/bq9k9BngCcZ9yjAOPI7hS32ErM6L0w==
X-Received: by 2002:a05:6808:bd5:b0:3a7:3ce0:1ae5 with SMTP id
 o21-20020a0568080bd500b003a73ce01ae5mr15162867oik.47.1691468467467; 
 Mon, 07 Aug 2023 21:21:07 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 12/19] hw/ppc: Read time only once to perform decrementer
 write
Date: Tue,  8 Aug 2023 14:19:54 +1000
Message-Id: <20230808042001.411094-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x230.google.com
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

Reading the time more than once to perform an operation always increases
complexity and fragility due to introduced deltas. Simplify the
decrementer write by reading the clock once for the operation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 84 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index f391acc39e..a0ee064b1d 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -708,13 +708,13 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
     return ((tb_env->flags & flags) == PPC_DECR_UNDERFLOW_TRIGGERED);
 }
 
-static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
+static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
+                                          uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t now, n;
+    uint64_t n;
     int64_t decr;
 
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     n = ns_to_tb(tb_env->decr_freq, now);
     if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
@@ -727,16 +727,12 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
     return decr;
 }
 
-target_ulong cpu_ppc_load_decr(CPUPPCState *env)
+static target_ulong _cpu_ppc_load_decr(CPUPPCState *env, int64_t now)
 {
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t decr;
 
-    if (kvm_enabled()) {
-        return env->spr[SPR_DECR];
-    }
-
-    decr = _cpu_ppc_load_decr(env, tb_env->decr_next);
+    decr = __cpu_ppc_load_decr(env, now, tb_env->decr_next);
 
     /*
      * If large decrementer is enabled then the decrementer is signed extened
@@ -750,14 +746,23 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
     return (uint32_t) decr;
 }
 
-target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
+target_ulong cpu_ppc_load_decr(CPUPPCState *env)
+{
+    if (kvm_enabled()) {
+        return env->spr[SPR_DECR];
+    } else {
+        return _cpu_ppc_load_decr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    }
+}
+
+static target_ulong _cpu_ppc_load_hdecr(CPUPPCState *env, int64_t now)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t hdecr;
 
-    hdecr =  _cpu_ppc_load_decr(env, tb_env->hdecr_next);
+    hdecr =  __cpu_ppc_load_decr(env, now, tb_env->hdecr_next);
 
     /*
      * If we have a large decrementer (POWER9 or later) then hdecr is sign
@@ -771,6 +776,11 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
     return (uint32_t) hdecr;
 }
 
+target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
+{
+    return _cpu_ppc_load_hdecr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+}
+
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
@@ -815,7 +825,7 @@ static inline void cpu_ppc_hdecr_lower(PowerPCCPU *cpu)
     ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
 }
 
-static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
+static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
@@ -824,7 +834,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t now, next;
+    uint64_t next;
     int64_t signed_value;
     int64_t signed_decr;
 
@@ -836,18 +846,12 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     trace_ppc_decr_store(nr_bits, decr, value);
 
-    if (kvm_enabled()) {
-        /* KVM handles decrementer exceptions, we don't need our own timer */
-        return;
-    }
-
     /*
      * Calculate the next decrementer event and set a timer.
      * decr_next is in timebase units to keep rounding simple. Note it is
      * not adjusted by tb_offset because if TB changes via tb_offset changing,
      * decrementer does not change, so not directly comparable with TB.
      */
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     next = ns_to_tb(tb_env->decr_freq, now) + value;
     *nextp = next; /* nextp is in timebase units */
 
@@ -876,12 +880,13 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
 
-static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
-                                       target_ulong value, int nr_bits)
+static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now,
+                                       target_ulong decr, target_ulong value,
+                                       int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
-    __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
+    __cpu_ppc_store_decr(cpu, now, &tb_env->decr_next, tb_env->decr_timer,
                          tb_env->decr_timer->cb, &cpu_ppc_decr_lower,
                          tb_env->flags, decr, value, nr_bits);
 }
@@ -890,13 +895,22 @@ void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int64_t now;
+    target_ulong decr;
     int nr_bits = 32;
 
+    if (kvm_enabled()) {
+        /* KVM handles decrementer exceptions, we don't need our own timer */
+        return;
+    }
+
     if (env->spr[SPR_LPCR] & LPCR_LD) {
         nr_bits = pcc->lrg_decr_bits;
     }
 
-    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value, nr_bits);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    decr = _cpu_ppc_load_decr(env, now);
+    _cpu_ppc_store_decr(cpu, now, decr, value, nr_bits);
 }
 
 static void cpu_ppc_decr_cb(void *opaque)
@@ -906,14 +920,15 @@ static void cpu_ppc_decr_cb(void *opaque)
     cpu_ppc_decr_excp(cpu);
 }
 
-static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
-                                        target_ulong value, int nr_bits)
+static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, int64_t now,
+                                        target_ulong hdecr, target_ulong value,
+                                        int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     if (tb_env->hdecr_timer != NULL) {
         /* HDECR (Book3S 64bit) is edge-based, not level like DECR */
-        __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
+        __cpu_ppc_store_decr(cpu, now, &tb_env->hdecr_next, tb_env->hdecr_timer,
                              tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
                              PPC_DECR_UNDERFLOW_TRIGGERED,
                              hdecr, value, nr_bits);
@@ -924,9 +939,12 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int64_t now;
+    target_ulong hdecr;
 
-    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value,
-                         pcc->lrg_decr_bits);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    hdecr = _cpu_ppc_load_hdecr(env, now);
+    _cpu_ppc_store_hdecr(cpu, now, hdecr, value, pcc->lrg_decr_bits);
 }
 
 static void cpu_ppc_hdecr_cb(void *opaque)
@@ -936,12 +954,16 @@ static void cpu_ppc_hdecr_cb(void *opaque)
     cpu_ppc_hdecr_excp(cpu);
 }
 
-void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
+static void _cpu_ppc_store_purr(CPUPPCState *env, int64_t now, uint64_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
 
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->purr_offset, value);
+    cpu_ppc_store_tb(tb_env, now, &tb_env->purr_offset, value);
+}
+
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
+{
+    _cpu_ppc_store_purr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), value);
 }
 
 static void timebase_save(PPCTimebase *tb)
-- 
2.40.1


