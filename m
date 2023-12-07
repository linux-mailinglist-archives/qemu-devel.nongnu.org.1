Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E43808C25
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:47:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGaO-0000xz-42; Thu, 07 Dec 2023 10:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGa5-0000p7-P7
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:29 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGa0-0002DI-Ou
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:29 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9fa2714e828so133733766b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701963983; x=1702568783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTaowFnx2H+uQC34ffSxi316ffYwhZaQm2jWOVPrZuQ=;
 b=yh5s31wDOyOF69MMOHFk5N1Yuz/QkIM0x8+nouKPuEf1N+MUIw5DvpsJpj/oOc8RIS
 gpEK4PcJarN+HE47Fp5Y+kQud2B2VixnnD9OtsWbYS6tbSt40HRdBV0MuPkVjgArGxhH
 pjaUvwFpRT4FRJFzWGi1hP2f6GBOo1A8QKlebqyUC6DK7FSFW90Xs6K21lKNLQwf/llq
 KehMGuudxFvSpudp3ht1Cxm5cdEq7ckOENm8E2MzF/hX4wzrW8N2krn9SYTHiQ2X+HXS
 ED095M3kblTqgd0A/IDXCArk8JuCsqYfDDRv/kfqQdEINahnipyNTPZ3/ikopK17cNHi
 JGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963983; x=1702568783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTaowFnx2H+uQC34ffSxi316ffYwhZaQm2jWOVPrZuQ=;
 b=JhsQNqrSx4NUNoVG/kC2wMAaArFOp3EzrJVOvraHOv7voEAm8qFVy+QhkUw5laNDYx
 2m6DokBC93nb3gZk5vjKApTj7cxTP2Eepy3aS6Gd/q4BOu+R2MM2+v7QCc/evBYQguIQ
 dJtsOw9AB+183wS7CCaSmeTpDWWogCZ7DTi14GDvOSByl2pjjR0R3cQpxLUoGFoDpyUP
 uujrtqVecLfdkf7v839VpiARhbgRGXMwy+1i9TibWEmsEbN1B5wNPRJtjaA1keS1JtU2
 oMln+p0/dhdiFHhoIJ8tpHX+8ZhPlBhFO1nITfHy50eAaVXTaENco29GDoKr5uHxnDeN
 0sig==
X-Gm-Message-State: AOJu0Yxm48shGUaRrshj9LV+cxyOdARUou/s6DmI7jSnqdWi8qulqrAU
 mu5K16t2ve7Uf6Ia9tOfanz7uJfoOFS/OTwIoDY=
X-Google-Smtp-Source: AGHT+IH9OyUELfNSL6kMUBsGE6Luba9SS4Oy+xn8bsHoQR1QGp1lP4ujn8Vw+pyDOZwbb8VwGk6DEA==
X-Received: by 2002:a17:906:2c47:b0:a1d:15ac:14fc with SMTP id
 f7-20020a1709062c4700b00a1d15ac14fcmr1319786ejh.22.1701963982824; 
 Thu, 07 Dec 2023 07:46:22 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a17090626cd00b00a1e8fa8b1f1sm973463ejc.79.2023.12.07.07.46.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 07:46:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/5] sysemu/replay: Restrict icount to system emulation
Date: Thu,  7 Dec 2023 16:45:50 +0100
Message-ID: <20231207154550.65087-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207154550.65087-1-philmd@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/cpu-timers.h |  2 +-
 include/sysemu/replay.h     | 11 ++++++++---
 stubs/icount.c              | 19 -------------------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index e909ffae47..25dfc76599 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -30,7 +30,7 @@ typedef enum {
     ICOUNT_ADAPTATIVE = 2,
 } ICountMode;
 
-#ifdef CONFIG_TCG
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
 extern ICountMode use_icount;
 #define icount_enabled() (use_icount)
 #else
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869f..8102fa54f0 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -1,6 +1,3 @@
-#ifndef SYSEMU_REPLAY_H
-#define SYSEMU_REPLAY_H
-
 /*
  * QEMU replay (system interface)
  *
@@ -11,6 +8,12 @@
  * See the COPYING file in the top-level directory.
  *
  */
+#ifndef SYSEMU_REPLAY_H
+#define SYSEMU_REPLAY_H
+
+#ifdef CONFIG_USER_ONLY
+#error Cannot include this header from user emulation
+#endif
 
 #include "exec/replay-core.h"
 #include "qapi/qapi-types-misc.h"
@@ -79,12 +82,14 @@ int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
 int64_t replay_read_clock(ReplayClockKind kind, int64_t raw_icount);
 /*! Saves or reads the clock depending on the current replay mode. */
 #define REPLAY_CLOCK(clock, value)                                      \
+    !icount_enabled() ? (value) :                                       \
     (replay_mode == REPLAY_MODE_PLAY                                    \
         ? replay_read_clock((clock), icount_get_raw())                  \
         : replay_mode == REPLAY_MODE_RECORD                             \
             ? replay_save_clock((clock), (value), icount_get_raw())     \
             : (value))
 #define REPLAY_CLOCK_LOCKED(clock, value)                               \
+    !icount_enabled() ? (value) :                                       \
     (replay_mode == REPLAY_MODE_PLAY                                    \
         ? replay_read_clock((clock), icount_get_raw_locked())           \
         : replay_mode == REPLAY_MODE_RECORD                             \
diff --git a/stubs/icount.c b/stubs/icount.c
index b060b03a73..9a29084ecc 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -5,30 +5,11 @@
 
 ICountMode use_icount = ICOUNT_DISABLED;
 
-void icount_update(CPUState *cpu)
-{
-    abort();
-}
 int64_t icount_get_raw(void)
 {
     abort();
     return 0;
 }
-int64_t icount_get(void)
-{
-    abort();
-    return 0;
-}
-int64_t icount_to_ns(int64_t icount)
-{
-    abort();
-    return 0;
-}
-int64_t icount_round(int64_t count)
-{
-    abort();
-    return 0;
-}
 void icount_start_warp_timer(void)
 {
     abort();
-- 
2.41.0


