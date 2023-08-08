Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8E7737DA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTED6-0006lp-3q; Tue, 08 Aug 2023 00:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTED4-0006lS-Lx; Tue, 08 Aug 2023 00:20:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTED3-0007hr-1R; Tue, 08 Aug 2023 00:20:42 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so3713466b3a.0; 
 Mon, 07 Aug 2023 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468438; x=1692073238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XWtaCCtPGQ8JFN+IlgusaRfj73rKbgISkOsjU+Yu/I=;
 b=Ap+DfBVyLGM9d2GrA1yq7ta7tM7WMBYQ33sAluIAXdl2g5xaAnVK6WZ7o17AHC2978
 scoP1wLcOIkGonMGk6rwEs/xz3wugh4jw8N21ZFoHkb380hAjzD23ufbn9sNrtn1PMsG
 JuG3zicHVsd+pbgZokAeOurtoDdei2fyB2sHPdWjm8Q+eRNaJfcKrtt1o5TcnB7cBVQ2
 e1o3P7CzSfUCDqlEszhJNAqYrLyVAYt2a8cCcVSjCWySGcKZH3qcA5lwS5nx9dOgquV0
 p1/rlCn5oRMCJA4nL4sACTNGCAB5toYzBY/zkveoZRn5OLQgXEtPF2NLpnwJ34zpFeLx
 PmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468438; x=1692073238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XWtaCCtPGQ8JFN+IlgusaRfj73rKbgISkOsjU+Yu/I=;
 b=RAcaG+ZfSVghzvQzZwaqj6Qun1aIie95ajPRwfR2h8Q9u0CN2I7rx0uK6cI0AZa5LX
 DoDCNYPyvCwYIPMi5JXB5SmvGTKDUMgjkhZLqwTd6XnRNM/tuHiXWZxxkSrTEh8TzPr8
 Or0Zre1BsLt9VX05b/xQGfs5+8z9VmC6u/QR987sEp8n2lT6e26JRwMZOdpjZdnyHF9J
 pos8Y/jb2oNw7LE8ixPP9i3FA1AxQ6E1a/6sBTZNVFGQEqKRUChRlr2OJhbamh2yMUS8
 7qUTjzsLT+FcMsztS8VhwrXsZ+jV+wz4Lm+fJHMbdCoFcQfHglsiRVz6Q+9//QVWs6WQ
 jhEA==
X-Gm-Message-State: AOJu0YxWlUGi81BcbRta9uFgYyQ/5KlARjIlet+MfW6Hi/K45d79BFKf
 uxJz1QaW3GoHjcD+pR3GP4U=
X-Google-Smtp-Source: AGHT+IEfrSJrQHlssy9wkipkSnoPo7Mv/VJ8Z5nLLd63HCWKRzDitaRfvkzX36BSRWv/zQeHTQo/ig==
X-Received: by 2002:a05:6a00:2351:b0:661:4a00:1ea5 with SMTP id
 j17-20020a056a00235100b006614a001ea5mr10959152pfj.20.1691468438409; 
 Mon, 07 Aug 2023 21:20:38 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 06/19] hw/ppc: Round up the decrementer interval when
 converting to ns
Date: Tue,  8 Aug 2023 14:19:48 +1000
Message-Id: <20230808042001.411094-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

The rule of timers is typically that they should never expire before the
timeout, but some time afterward. Rounding timer intervals up when doing
conversion is the right thing to do.

Under most circumstances it is impossible observe the decrementer
interrupt before the dec register has triggered. However with icount
timing, problems can arise. For example setting DEC to 0 can schedule
the timer for now, causing it to fire before any more instructions
have been executed and DEC is still 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 423a3a117a..13eb45f4b7 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -482,14 +482,26 @@ void ppce500_set_mpic_proxy(bool enabled)
 /*****************************************************************************/
 /* PowerPC time base and decrementer emulation */
 
+/*
+ * Conversion between QEMU_CLOCK_VIRTUAL ns and timebase (TB) ticks:
+ * TB ticks are arrived at by multiplying tb_freq then dividing by
+ * ns per second, and rounding down. TB ticks drive all clocks and
+ * timers in the target machine.
+ *
+ * Converting TB intervals to ns for the purpose of setting a
+ * QEMU_CLOCK_VIRTUAL timer should go the other way, but rounding
+ * up. Rounding down could cause the timer to fire before the TB
+ * value has been reached.
+ */
 static uint64_t ns_to_tb(uint32_t freq, int64_t clock)
 {
     return muldiv64(clock, freq, NANOSECONDS_PER_SECOND);
 }
 
-static int64_t tb_to_ns(uint32_t freq, uint64_t tb)
+/* virtual clock in TB ticks, not adjusted by TB offset */
+static int64_t tb_to_ns_round_up(uint32_t freq, uint64_t tb)
 {
-    return muldiv64(tb, NANOSECONDS_PER_SECOND, freq);
+    return muldiv64_round_up(tb, NANOSECONDS_PER_SECOND, freq);
 }
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
@@ -847,7 +859,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + tb_to_ns(tb_env->decr_freq, value);
+    next = now + tb_to_ns_round_up(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1139,9 +1151,7 @@ static void cpu_4xx_fit_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + tb_to_ns(tb_env->tb_freq, next);
-    if (next == now)
-        next++;
+    next = now + tb_to_ns_round_up(tb_env->tb_freq, next);
     timer_mod(ppc40x_timer->fit_timer, next);
     env->spr[SPR_40x_TSR] |= 1 << 26;
     if ((env->spr[SPR_40x_TCR] >> 23) & 0x1) {
@@ -1167,11 +1177,10 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + tb_to_ns(tb_env->decr_freq, ppc40x_timer->pit_reload);
+        next = now + tb_to_ns_round_up(tb_env->decr_freq,
+                                       ppc40x_timer->pit_reload);
         if (is_excp)
             next += tb_env->decr_next - now;
-        if (next == now)
-            next++;
         timer_mod(tb_env->decr_timer, next);
         tb_env->decr_next = next;
     }
@@ -1226,9 +1235,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + tb_to_ns(tb_env->decr_freq, next);
-    if (next == now)
-        next++;
+    next = now + tb_to_ns_round_up(tb_env->decr_freq, next);
     trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
     switch ((env->spr[SPR_40x_TSR] >> 30) & 0x3) {
     case 0x0:
-- 
2.40.1


