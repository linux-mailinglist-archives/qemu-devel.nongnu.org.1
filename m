Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB07737E1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDA-0006sG-N9; Tue, 08 Aug 2023 00:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTED8-0006oC-C8; Tue, 08 Aug 2023 00:20:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTED6-0007ie-ML; Tue, 08 Aug 2023 00:20:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686b9920362so3464496b3a.1; 
 Mon, 07 Aug 2023 21:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468443; x=1692073243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7224617qU4aowjj8pMFVGiu1BetDjMqd9SnzR+pOz8=;
 b=dMIhJvZErVbCnpo1A6b2OyLR9YijVduT8VivHvftvPzh0ZA1hNmOJ2c4/LmArnhvoH
 JoLkrRF782Fc4lhkeFdypeqU9JyCA7g0LTSHViUxqGsC9q0hWBsVCjTfPPCNF0+z7xpx
 rDNqMnubMjvkHoOQnISZww5h9VDDLV8EmUXMaVEEpBVJWRXnq1gRb2vTRsSXO8blE+uA
 3mKCuNyFAipe9pSxGrkO/Tnszk+u6kySRlfPukiC993OqERnSTfe9QIU3MWnr7iuVOOV
 gtV45adqVKhY8v7scOZ/4UzHLotNqLWXWsN3hx9e/9jeel4zJ2FDT2c8Jhdro+5GBylr
 2yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468443; x=1692073243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7224617qU4aowjj8pMFVGiu1BetDjMqd9SnzR+pOz8=;
 b=CADmkMjNpOs2q6IswsNRSqEhB0/Mwv996N+S1CpYtcA0sQ3YiABwxmr5Qz9kTyc753
 CSTfhHRNkbyvJKwXeFiDgGdqIi9NUtmtjggHXfF8oU+DqRWsj2YRKdyMKVuyWQw0V1yt
 OFhmifFUBvC2UMlBefW5RCuj24LmD0MxYvhFnX+1lqC2KrVfG+VyLgUW4Jj7ScewTixA
 dwGH6naKveButan68gOQRg1z4IeK4ypGGad3eipa3mPGBbKpo3xDfBm+KPGc+lt3y90y
 KkZGMk1E5O0gJkb64onZu9dw2WC77KgAElEKPVMdXBx8Twb0WnIi/yxmk3HsOOogCkIx
 Jb6g==
X-Gm-Message-State: AOJu0YyCQflhVk14u0anJwna2JBrG2PWR2d1VRetuJXWoozwFTTg4slJ
 uuYV7BkYTuTna/8mMKvjg04=
X-Google-Smtp-Source: AGHT+IHgHFPiZm50v96aW3L69A61gdReu6iE3XJ0WcfIVjcDPTxL/L/Cbi/aOJnODsyXVMddUJMzIg==
X-Received: by 2002:a05:6a20:3c8e:b0:134:16a3:83ad with SMTP id
 b14-20020a056a203c8e00b0013416a383admr10697319pzj.57.1691468443111; 
 Mon, 07 Aug 2023 21:20:43 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 07/19] hw/ppc: Avoid decrementer rounding errors
Date: Tue,  8 Aug 2023 14:19:49 +1000
Message-Id: <20230808042001.411094-8-npiggin@gmail.com>
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

The decrementer register contains a relative time in timebase units.
When writing to DECR this is converted and stored as an absolute value
in nanosecond units, reading DECR converts back to relative timebase.

The tb<->ns conversion of the relative part can cause rounding such that
a value writen to the decrementer can read back a different, with time
held constant. This is a particular problem for a deterministic icount
and record-replay trace.

Fix this by storing the absolute value in timebase units rather than
nanoseconds. The math before:
  store:  decr_next = now_ns + decr * ns_per_sec / tb_per_sec
  load:        decr = (decr_next - now_ns) * tb_per_sec / ns_per_sec
  load(store): decr = decr * ns_per_sec / tb_per_sec * tb_per_sec /
                      ns_per_sec

After:
  store:  decr_next = now_ns * tb_per_sec / ns_per_sec + decr
  load:        decr = decr_next - now_ns * tb_per_sec / ns_per_sec
  load(store): decr = decr

Fixes: 9fddaa0c0cab ("PowerPC merge: real time TB and decrementer - faster and simpler exception handling (Jocelyn Mayer)")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 13eb45f4b7..a397820d9c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -711,16 +711,17 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
 static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    int64_t decr, diff;
+    uint64_t now, n;
+    int64_t decr;
 
-    diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    if (diff >= 0) {
-        decr = ns_to_tb(tb_env->decr_freq, diff);
-    } else if (tb_env->flags & PPC_TIMER_BOOKE) {
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    n = ns_to_tb(tb_env->decr_freq, now);
+    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
-    }  else {
-        decr = -ns_to_tb(tb_env->decr_freq, -diff);
+    } else {
+        decr = next - n;
     }
+
     trace_ppc_decr_load(decr);
 
     return decr;
@@ -857,13 +858,18 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         (*lower_excp)(cpu);
     }
 
-    /* Calculate the next timer event */
+    /*
+     * Calculate the next decrementer event and set a timer.
+     * decr_next is in timebase units to keep rounding simple. Note it is
+     * not adjusted by tb_offset because if TB changes via tb_offset changing,
+     * decrementer does not change, so not directly comparable with TB.
+     */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + tb_to_ns_round_up(tb_env->decr_freq, value);
+    next = ns_to_tb(tb_env->decr_freq, now) + value;
     *nextp = next;
 
     /* Adjust timer */
-    timer_mod(timer, next);
+    timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
 
 static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
@@ -1177,12 +1183,15 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + tb_to_ns_round_up(tb_env->decr_freq,
-                                       ppc40x_timer->pit_reload);
-        if (is_excp)
-            next += tb_env->decr_next - now;
+
+        if (is_excp) {
+            tb_env->decr_next += ppc40x_timer->pit_reload;
+        } else {
+            tb_env->decr_next = ns_to_tb(tb_env->decr_freq, now)
+                                + ppc40x_timer->pit_reload;
+        }
+        next = tb_to_ns_round_up(tb_env->decr_freq, tb_env->decr_next);
         timer_mod(tb_env->decr_timer, next);
-        tb_env->decr_next = next;
     }
 }
 
-- 
2.40.1


