Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EE080A266
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:38:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ9G-00049O-Pf; Fri, 08 Dec 2023 06:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9B-00040l-3R
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:35:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ97-0003xN-Ci
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:35:56 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so23637585e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702035350; x=1702640150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzEnAxgAgPgAskKIL5lE29mKmqmzfiARuWbhtCikfuI=;
 b=FKIVQFC8wFMkd03omRC6fsPjmQMGrR8U5mT7SDKZC/ZWQXO+zHKgkinPdQtg702yZy
 TvUebPTnurPsFfuBcfY3xsJ8imYYo6TYfpPbl6JbV2fukaaVCoPcFfnavLw2S+loARy8
 07r9jFHV5yDNzKQOk7nX9BtIKGy8EaWPKUxHMVTid4JwBgU4QMmdSTsk4uDX0ZYK6+ga
 FLWQb1VGsgWa1LjDr9cdj7g7lGcJfSclEk49THY6n3obfVh5tCKMVTU0aK1L/+s8sd/O
 b0RgN00IEorN2Qs+TUWt8tezjvZaSMxR9YGng5UEBhverVMER97xvNtKjcLbs9Og0k0I
 Qusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702035350; x=1702640150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzEnAxgAgPgAskKIL5lE29mKmqmzfiARuWbhtCikfuI=;
 b=bUqDfPtprgs4ZkQyIrsPNPk7huSSFgMvi2uknQqXJsXDjnPqwytouZcz55rlg4vVVb
 mbNAfFtNG/HYAbXBHA4WMtIoDDt2V1GBJrwTjIogo4jRhjVFgquW3+jObqCyPCFEgrKp
 88TYzDXDuKkiLIHgeqY4NZWwLeYTWPgcPcWQvM6QH85pVJNB/8pNxwbOCesj+iyfdQnp
 jDM5gN3p1XkAD1QTntXQoAOLIc0yvhK+rXWGVTroAGYFchHs2gfvsknFDo46WQKwg4sl
 ITAh1pdWUbQcM7flIXKT32OGJhvdZ/2Jl7Ei67yMbU0Dh+unTNVFgmktUZDt7DWnsRsA
 yGow==
X-Gm-Message-State: AOJu0YzALmaoSMRT2b29mXxkPC9vYb8EiyTtSN+3FOik8yKeijg/Gd4v
 DGmfJL/lnRroTYW2azVUu5bDsXeXUN8i7c3kYQY=
X-Google-Smtp-Source: AGHT+IFfqDQv0a+i++vl/cts5SbpDyzuVXz4EQl1AhSqM3ZPlDjh5GUnmIch3lFG1heT1njSRmWDaA==
X-Received: by 2002:a05:600c:6025:b0:40c:2a2a:1169 with SMTP id
 az37-20020a05600c602500b0040c2a2a1169mr1350259wmb.115.1702035350029; 
 Fri, 08 Dec 2023 03:35:50 -0800 (PST)
Received: from m1x-phil.lan ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d4c4a000000b003333abf3edfsm1832772wrt.47.2023.12.08.03.35.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Dec 2023 03:35:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/6] sysemu/cpu-timers: Introduce ICountMode enumerator
Date: Fri,  8 Dec 2023 12:35:25 +0100
Message-ID: <20231208113529.74067-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208113529.74067-1-philmd@linaro.org>
References: <20231208113529.74067-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index 014ae5d8e4..7055c13725 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -3,7 +3,7 @@
 
 /* icount - Instruction Counter API */
 
-int use_icount;
+ICountMode use_icount = ICOUNT_DISABLED;
 
 void icount_update(CPUState *cpu)
 {
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 7452d97b67..6befb82e48 100644
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
index 2746d3fdac..adb0960bba 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -934,7 +934,8 @@ static int64_t cycles_ns_per(uint64_t cycles)
 
 static bool instructions_supported(CPUARMState *env)
 {
-    return icount_enabled() == 1; /* Precise instruction counting */
+    /* Precise instruction counting */
+    return icount_enabled() == ICOUNT_PRECISE;
 }
 
 static uint64_t instructions_get_count(CPUARMState *env)
-- 
2.41.0


