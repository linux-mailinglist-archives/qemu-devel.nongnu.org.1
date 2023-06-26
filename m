Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BF73E3A5
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoL7-0001kK-8x; Mon, 26 Jun 2023 11:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJp-0000HO-8b
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJk-0002o9-Lr
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:56 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so1388475f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793990; x=1690385990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HG5rz65U57sVq58UVLRV5u9TWpEQiOWql+ZKzfQsiSQ=;
 b=f+AaW4ascJw8x06Rp787solyLQSHPozmdX53zKXcx3A04gUqTOeGMN1dkAYpexSaUE
 Tymo9IyyB0B2lrwi2ACdnjlgCvkdRaqJdw0GIpoZ9r0KfQ+roIci2kcOqTj23qXuP1O7
 MXUWEqVfGAc6PiN9eO+SjAtBPmu9i7R1+8FAIqWBGaa35uWNMihIHbzrx0wcJQkq71cb
 oM9F4EXtyxNHNC3mhwIZE2HTok8vtKEBuumynzIL6CkeY2RsUHqwJN9cQ79JV6g0mS1E
 PxyJck/VHuv9oolD4k8XScf4qYMUgG48pEMAl3wddAz0GM84W3r40hiBSBXtwlESQAtc
 Cyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793990; x=1690385990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HG5rz65U57sVq58UVLRV5u9TWpEQiOWql+ZKzfQsiSQ=;
 b=UeIVdnXAE68MZJwFLvvQqYt0WeaNBzyFg5BIomXXdMeEjY/xSbQGILq/b1TtEcffib
 ZsU4CeRVsA+ZrjyNPb36FMxI58OcwIDkbCrM8ScAoYzkZe8Gfu3SPsDAeEObSVF/0V7n
 wu+o2zZoK/iNWzEcWkI2MZI9SJ2dfrgDwknebyzNzFgVhjpfB5+HlQWaa2QyOKqF0Bjt
 aSncZaxkuByWinNNnlDtz79I4bmLXXKyTryT2BujK7zuDYKI+nYbMt5M8D4N0K1H7h9V
 gfR0NtxhNJE3T1Rxr9mg0F0w+dVQSI2Os2dMC+ZOxp37fMyP5r/hdmYte+LlBBoN2+Rf
 aNPg==
X-Gm-Message-State: AC+VfDyn2WGm79Vb6pa9Cuj8OqdywIhYPBcs6N9Dor3M9omSAkO/bkXD
 FK89Q2m8pB8Y24sAk0Pzh16o0sKmbXvGF4pLHOg0T2F4
X-Google-Smtp-Source: ACHHUZ5SxM1D/tYVf+yv+KaWdz23sBBs5Sh/Iw+blVZy6zluZPbzuVrdUR6Un1Io8v5VZBdIH1tK4Q==
X-Received: by 2002:a5d:6982:0:b0:313:e591:94ec with SMTP id
 g2-20020a5d6982000000b00313e59194ecmr6431523wru.67.1687793990324; 
 Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 06/22] accel/tcg/cpu-exec.c: Widen pc to vaddr
Date: Mon, 26 Jun 2023 17:39:29 +0200
Message-Id: <20230626153945.76180-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson <anjo@rev.ng>

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621135633.1649-7-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4d952a6cc2..ba1890a373 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -169,8 +169,8 @@ uint32_t curr_cflags(CPUState *cpu)
 }
 
 struct tb_desc {
-    target_ulong pc;
-    target_ulong cs_base;
+    vaddr pc;
+    uint64_t cs_base;
     CPUArchState *env;
     tb_page_addr_t page_addr0;
     uint32_t flags;
@@ -193,7 +193,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
             return true;
         } else {
             tb_page_addr_t phys_page1;
-            target_ulong virt_page1;
+            vaddr virt_page1;
 
             /*
              * We know that the first page matched, and an otherwise valid TB
@@ -214,8 +214,8 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     return false;
 }
 
-static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
-                                          target_ulong cs_base, uint32_t flags,
+static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
+                                          uint64_t cs_base, uint32_t flags,
                                           uint32_t cflags)
 {
     tb_page_addr_t phys_pc;
@@ -238,9 +238,9 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
 }
 
 /* Might cause an exception, so have a longjmp destination ready */
-static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
-                                          target_ulong cs_base,
-                                          uint32_t flags, uint32_t cflags)
+static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
+                                          uint64_t cs_base, uint32_t flags,
+                                          uint32_t cflags)
 {
     TranslationBlock *tb;
     CPUJumpCache *jc;
@@ -292,13 +292,13 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, target_ulong pc,
     return tb;
 }
 
-static void log_cpu_exec(target_ulong pc, CPUState *cpu,
+static void log_cpu_exec(vaddr pc, CPUState *cpu,
                          const TranslationBlock *tb)
 {
     if (qemu_log_in_addr_range(pc)) {
         qemu_log_mask(CPU_LOG_EXEC,
                       "Trace %d: %p [%08" PRIx64
-                      "/" TARGET_FMT_lx "/%08x/%08x] %s\n",
+                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
 
@@ -323,7 +323,7 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
     }
 }
 
-static bool check_for_breakpoints_slow(CPUState *cpu, target_ulong pc,
+static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
                                        uint32_t *cflags)
 {
     CPUBreakpoint *bp;
@@ -389,7 +389,7 @@ static bool check_for_breakpoints_slow(CPUState *cpu, target_ulong pc,
     return false;
 }
 
-static inline bool check_for_breakpoints(CPUState *cpu, target_ulong pc,
+static inline bool check_for_breakpoints(CPUState *cpu, vaddr pc,
                                          uint32_t *cflags)
 {
     return unlikely(!QTAILQ_EMPTY(&cpu->breakpoints)) &&
@@ -485,10 +485,10 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
             cc->set_pc(cpu, last_tb->pc);
         }
         if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
-            target_ulong pc = log_pc(cpu, last_tb);
+            vaddr pc = log_pc(cpu, last_tb);
             if (qemu_log_in_addr_range(pc)) {
-                qemu_log("Stopped execution of TB chain before %p ["
-                         TARGET_FMT_lx "] %s\n",
+                qemu_log("Stopped execution of TB chain before %p [%"
+                         VADDR_PRIx "] %s\n",
                          last_tb->tc.ptr, pc, lookup_symbol(pc));
             }
         }
@@ -882,8 +882,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 }
 
 static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
-                                    target_ulong pc,
-                                    TranslationBlock **last_tb, int *tb_exit)
+                                    vaddr pc, TranslationBlock **last_tb,
+                                    int *tb_exit)
 {
     int32_t insns_left;
 
-- 
2.34.1


