Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EAB832911
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAQ-0002Vp-7F; Fri, 19 Jan 2024 06:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAN-0002Om-GS
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAK-0001ZX-C8
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:07 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e779f030aso4013685e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664163; x=1706268963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZyaevqz+BXyv3cNgww9mIqrqdn3HHupjjYERjA5ZHo=;
 b=PzjBfl7JgPrdR2nlF8LJhLzmOV5m3ibMjDKnxC4aqNfDvuqb1x0jt1eIv3Z8IWSD7A
 hoyWNknS34fz7r/LL6+pi1AbIZ/vjHkgfGL0VCvah5IFYJcHMNY6gHIHHV8rsej9ss69
 rfGXP+EVX2+3jwE0p6ZLoOFCaSNkhQe2vkQZ2VkY5dNcUFAqkY8Raz47RVXqp7mL+Tl9
 SRiE7h2ldMxqImmeWkD4j7iUGqDkmjnN80Fp4+j0iXJeq4/HicDrPzzp5ciMsrP+giBK
 BZJwS9+TmYoojczEmnDKwLSgY8X+5bZikk3yt1lqoU2yk+222qjem+cyQbedaMiAdAOP
 g82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664163; x=1706268963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZyaevqz+BXyv3cNgww9mIqrqdn3HHupjjYERjA5ZHo=;
 b=v8n6xjTdFEyeIuob8OVWvteujMM9V8CIout1UdVhGsdlhC3CEpsnWxfEJ78eBsbKDF
 ISdGtYMBsApL68lwUhT5tQ5+0LhNctNs//IzcqCdJwahqe8M4Ar1wdErLgM9117GdbQh
 WGyDNNGew5htD60OtwNhDK3nxKzmlJnJriduSwCqg3YPa71iSfZvy9NenjbZAsAjoDqW
 4udcgp8No2bc8f/xCPEIF5I6DqgQc/kmswsHGJ3rsi2HVMBiMU43DA+Ci7qjZOqfqY2Y
 DIzs2sPm68dvr1goJSNHxTNKAWAKuy5sISUAkajLMtNiBYp3442zMNWV2dL6ZYQeSmbg
 YTdQ==
X-Gm-Message-State: AOJu0YxxrmD00vbqTMGL/i37O7cy5WyNSp4CTAtfKjar2I8+K5eO/htA
 EAB1jFQ1fKH+UZDb7Wg3m85Q8LIZPLkFOwoQ4OsGONUeAfq0S4TwaNqJIhyUQS3uMCBgBk0cWqx
 AD7AanQ==
X-Google-Smtp-Source: AGHT+IFP/IowVtz3LFJQUMgsv4McpoI910qLDZ/G3lZd2v2R+OvFwQCFeOPOGd9Q4QMcmURvP+JH3Q==
X-Received: by 2002:a7b:c3d7:0:b0:40e:59e9:98d0 with SMTP id
 t23-20020a7bc3d7000000b0040e59e998d0mr583577wmj.154.1705664162785; 
 Fri, 19 Jan 2024 03:36:02 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 hg14-20020a05600c538e00b0040e5cf9a6c7sm29071140wmb.13.2024.01.19.03.36.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/36] system/cpu-timers: Introduce ICountMode enumerator
Date: Fri, 19 Jan 2024 12:34:41 +0100
Message-ID: <20240119113507.31951-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Rather than having to lookup for what the 0, 1, 2, ...
icount values are, use a enum definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231208113529.74067-4-philmd@linaro.org>
---
 include/sysemu/cpu-timers.h | 20 +++++++++++++-------
 accel/tcg/icount-common.c   | 16 +++++++---------
 stubs/icount.c              |  2 +-
 system/cpu-timers.c         |  2 +-
 target/arm/helper.c         |  3 ++-
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index b70dc7692d..3f05f29b10 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -17,18 +17,24 @@ void cpu_timers_init(void);
 
 /* icount - Instruction Counter API */
 
-/*
- * icount enablement state:
+/**
+ * ICountMode: icount enablement state:
  *
- * 0 = Disabled - Do not count executed instructions.
- * 1 = Enabled - Fixed conversion of insn to ns via "shift" option
- * 2 = Enabled - Runtime adaptive algorithm to compute shift
+ * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
+ * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
+ * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
  */
+typedef enum {
+    ICOUNT_DISABLED = 0,
+    ICOUNT_PRECISE,
+    ICOUNT_ADAPTATIVE,
+} ICountMode;
+
 #ifdef CONFIG_TCG
-extern int use_icount;
+extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
-#define icount_enabled() 0
+#define icount_enabled() ICOUNT_DISABLED
 #endif
 
 /*
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index dc69d6a4c6..f0f8fc7f1c 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -49,21 +49,19 @@ static bool icount_sleep = true;
 /* Arbitrarily pick 1MIPS as the minimum allowable speed.  */
 #define MAX_ICOUNT_SHIFT 10
 
-/*
- * 0 = Do not count executed instructions.
- * 1 = Fixed conversion of insn to ns via "shift" option
- * 2 = Runtime adaptive algorithm to compute shift
- */
-int use_icount;
+/* Do not count executed instructions */
+ICountMode use_icount = ICOUNT_DISABLED;
 
 static void icount_enable_precise(void)
 {
-    use_icount = 1;
+    /* Fixed conversion of insn to ns via "shift" option */
+    use_icount = ICOUNT_PRECISE;
 }
 
 static void icount_enable_adaptive(void)
 {
-    use_icount = 2;
+    /* Runtime adaptive algorithm to compute shift */
+    use_icount = ICOUNT_ADAPTATIVE;
 }
 
 /*
@@ -256,7 +254,7 @@ static void icount_warp_rt(void)
         int64_t warp_delta;
 
         warp_delta = clock - timers_state.vm_clock_warp_start;
-        if (icount_enabled() == 2) {
+        if (icount_enabled() == ICOUNT_ADAPTATIVE) {
             /*
              * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too far
              * ahead of real time (it might already be ahead so careful not
diff --git a/stubs/icount.c b/stubs/icount.c
index 85c381a0ea..c2c10dfb6b 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -4,7 +4,7 @@
 
 /* icount - Instruction Counter API */
 
-int use_icount;
+ICountMode use_icount = ICOUNT_DISABLED;
 
 void icount_update(CPUState *cpu)
 {
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index bdf3a41dcb..0b31c9a1b6 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -154,7 +154,7 @@ static bool adjust_timers_state_needed(void *opaque)
 
 static bool icount_shift_state_needed(void *opaque)
 {
-    return icount_enabled() == 2;
+    return icount_enabled() == ICOUNT_ADAPTATIVE;
 }
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dc8f14f433..49665bb763 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -948,7 +948,8 @@ static int64_t cycles_ns_per(uint64_t cycles)
 
 static bool instructions_supported(CPUARMState *env)
 {
-    return icount_enabled() == 1; /* Precise instruction counting */
+    /* Precise instruction counting */
+    return icount_enabled() == ICOUNT_PRECISE;
 }
 
 static uint64_t instructions_get_count(CPUARMState *env)
-- 
2.41.0


