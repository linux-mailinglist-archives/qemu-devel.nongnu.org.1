Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A435E74E0FE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzKs-0003Rk-RG; Mon, 10 Jul 2023 18:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKq-0003RM-Qd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:24 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzKo-0001g8-Ut
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:26:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso51882945e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027981; x=1691619981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+boInrFMOouLAZH87rtNgQEAsi3AA1iZOyWyu8Hur4=;
 b=u29PcR6NQxPtf5i4GoH84MvHmB/VdIvUGJKiGm0xmKIKTJOI/z9R7UmuLxCgBRjoeg
 7CMbZKFrKIa9nZOL4tN16xzhm+sJNgvbraX1b8CKSoaYRCmxbuV4EL6kdMFHIX3HrCPc
 LefdiWsWIGPmZr3FObzvW9NIJMD1HWW21s/QSReuKgprfXZgvnhRtSPLzuTBfG2HvoDs
 7w4kgfekclgDEZOZBmZ307qkVQKTPMyvdv3KBxdlF3/6abCGMihz9bhwDcgSU5oqx0oX
 ihoSi41Pqs+p2pSPHTW4PC0GEZzRbEp35+Ymi6d3WlOH+3QtCKTNs3YpVVCmh4yEaxum
 Yokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027981; x=1691619981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+boInrFMOouLAZH87rtNgQEAsi3AA1iZOyWyu8Hur4=;
 b=BEfYgdOjnEmzMKg9DtB5wUBYe9g8CU1JK1tiHpJZyRSawqEQi0adZKveZ2IqXKJsgQ
 0QyIxtAksqcFnKYTAuMBIX4NAgXqQcgMhgGYCocxL6hHJmbx3KZrbeYjzi6aa7Lq16B9
 gVz00KEeME3veIQUgH9jM5Wuq6t1qt/cdMwh3MPCLUewg0gDBR0bQPMm/sT4OoKWk+ir
 0KCYrqLu8r3xK5GNfRZj+p1ugl9IV/JPptvt71QG13xHvKDDBYUxIN794wRwSqZ2RsQR
 rGe9mrd3SOsjzoySJVUaNbszdbucOb7AR755mzP41W4nUH04EaNR4xG2tFSLh54QrO8a
 XjBQ==
X-Gm-Message-State: ABy/qLaz9nrK3RtBmkgZyyo5IrppiEhsBeoT7wpj+RqjZjz6b4y94Aw9
 vI6jz4kSGqdcBHebI8pzIqzzqE06yGZLOBifVYLaDA==
X-Google-Smtp-Source: APBJJlFlcwN+1Oxv/Mfjg7/TRa7+mamfHrQ1CWJhqdqQQ94Oemebzkldmb23NuV1jvVc8y44M+zrnw==
X-Received: by 2002:a7b:c408:0:b0:3fb:bc4a:46ad with SMTP id
 k8-20020a7bc408000000b003fbbc4a46admr11258163wmi.9.1689027980505; 
 Mon, 10 Jul 2023 15:26:20 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 hn32-20020a05600ca3a000b003fbdd5d0758sm889033wmb.22.2023.07.10.15.26.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 01/44] target/mips: Rework cp0_timer with clock API
Date: Tue, 11 Jul 2023 00:25:28 +0200
Message-Id: <20230710222611.50978-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Previous implementation of MIPS cp0_timer computes a
cp0_count_ns based on input clock. However rounding
error of cp0_count_ns can affect precision of cp0_timer.

Using clock API and a divider for cp0_timer, so we can
use clock_ns_to_ticks/clock_ns_to_ticks to avoid rounding
issue.

Also workaround the situation that in such handler flow:

count = read_c0_count()
write_c0_compare(count)

If timer had not progressed when compare was written, the
interrupt would trigger again.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h              |  3 ++-
 target/mips/cpu.c              |  8 +++++---
 target/mips/sysemu/cp0_timer.c | 35 ++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index a3bc646976..d3ee874a18 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1160,8 +1160,8 @@ typedef struct CPUArchState {
 
     const mips_def_t *cpu_model;
     QEMUTimer *timer; /* Internal timer */
+    Clock *count_clock; /* CP0_Count clock */
     target_ulong exception_base; /* ExceptionBase input to the core */
-    uint64_t cp0_count_ns; /* CP0_Count clock period (in nanoseconds) */
 } CPUMIPSState;
 
 /**
@@ -1178,6 +1178,7 @@ struct ArchCPU {
     /*< public >*/
 
     Clock *clock;
+    Clock *count_div; /* Divider for CP0_Count clock */
     CPUNegativeOffsetState neg;
     CPUMIPSState env;
 };
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 01e0fbe10d..b7119cbbb4 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -449,9 +449,9 @@ static void mips_cp0_period_set(MIPSCPU *cpu)
 {
     CPUMIPSState *env = &cpu->env;
 
-    env->cp0_count_ns = clock_ticks_to_ns(MIPS_CPU(cpu)->clock,
-                                          env->cpu_model->CCRes);
-    assert(env->cp0_count_ns);
+    clock_set_mul_div(cpu->count_div, env->cpu_model->CCRes, 1);
+    clock_set_source(cpu->count_div, cpu->clock);
+    clock_set_source(env->count_clock, cpu->count_div);
 }
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -504,6 +504,8 @@ static void mips_cpu_initfn(Object *obj)
 
     cpu_set_cpustate_pointers(cpu);
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
+    cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
+    env->count_clock = clock_new(OBJECT(obj), "clk-count");
     env->cpu_model = mcc->cpu_def;
 }
 
diff --git a/target/mips/sysemu/cp0_timer.c b/target/mips/sysemu/cp0_timer.c
index 70de95d338..9d2bcb0dea 100644
--- a/target/mips/sysemu/cp0_timer.c
+++ b/target/mips/sysemu/cp0_timer.c
@@ -28,15 +28,26 @@
 #include "internal.h"
 
 /* MIPS R4K timer */
+static uint32_t cpu_mips_get_count_val(CPUMIPSState *env)
+{
+    int64_t now_ns;
+    now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    return env->CP0_Count +
+            (uint32_t)clock_ns_to_ticks(env->count_clock, now_ns);
+}
+
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
     uint64_t now_ns, next_ns;
     uint32_t wait;
 
     now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    wait = env->CP0_Compare - env->CP0_Count -
-           (uint32_t)(now_ns / env->cp0_count_ns);
-    next_ns = now_ns + (uint64_t)wait * env->cp0_count_ns;
+    wait = env->CP0_Compare - cpu_mips_get_count_val(env);
+    /* Clamp interval to overflow if virtual time had not progressed */
+    if (!wait) {
+        wait = UINT32_MAX;
+    }
+    next_ns = now_ns + clock_ticks_to_ns(env->count_clock, wait);
     timer_mod(env->timer, next_ns);
 }
 
@@ -64,7 +75,7 @@ uint32_t cpu_mips_get_count(CPUMIPSState *env)
             cpu_mips_timer_expire(env);
         }
 
-        return env->CP0_Count + (uint32_t)(now_ns / env->cp0_count_ns);
+        return cpu_mips_get_count_val(env);
     }
 }
 
@@ -79,9 +90,8 @@ void cpu_mips_store_count(CPUMIPSState *env, uint32_t count)
         env->CP0_Count = count;
     } else {
         /* Store new count register */
-        env->CP0_Count = count -
-               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                          env->cp0_count_ns);
+        env->CP0_Count = count - (uint32_t)clock_ns_to_ticks(env->count_clock,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
         /* Update timer timer */
         cpu_mips_timer_update(env);
     }
@@ -107,8 +117,8 @@ void cpu_mips_start_count(CPUMIPSState *env)
 void cpu_mips_stop_count(CPUMIPSState *env)
 {
     /* Store the current value */
-    env->CP0_Count += (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                                 env->cp0_count_ns);
+    env->CP0_Count += (uint32_t)clock_ns_to_ticks(env->count_clock,
+                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
 }
 
 static void mips_timer_cb(void *opaque)
@@ -121,14 +131,7 @@ static void mips_timer_cb(void *opaque)
         return;
     }
 
-    /*
-     * ??? This callback should occur when the counter is exactly equal to
-     * the comparator value.  Offset the count by one to avoid immediately
-     * retriggering the callback before any virtual time has passed.
-     */
-    env->CP0_Count++;
     cpu_mips_timer_expire(env);
-    env->CP0_Count--;
 }
 
 void cpu_mips_clock_init(MIPSCPU *cpu)
-- 
2.38.1


