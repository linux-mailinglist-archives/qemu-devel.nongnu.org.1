Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0780A265
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ9T-0004be-Lz; Fri, 08 Dec 2023 06:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9R-0004Zw-EJ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:13 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9O-0004hp-D0
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-332fd78fa9dso1811655f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702035368; x=1702640168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIk3tQ6ySkCzXvhu4fvVzI666gbM4pnzLPnY/8QAtQ8=;
 b=AP4J7T0Mw7X/AahUirC0GLGYq1AuMfv0cQcLcCnoD8VUfsL161OjVEezJxCyyq8WS4
 3xEnMsrSsOBEbg2Zxnt8/lo3yz3wmCdilaXLnM7JGHyMz9j5LAyw+OJnb+RXs6MTMOCt
 nNID7ngH0TrZj1ldWXA9oDvhoom75osvTwlo7r6lXUKhJKYfrlr9aDILqArBFNMr0Ad8
 32joTRKlGWJmXn1CoX1TlEw1as3v6Ph+6fUNNh06mSonnpk24FjOqNPIyqkqkoUZY89d
 32F2Z1ZkW6aMRVwFLJJtrFdhTeNvz0IWXfSjT8Bjye+KcGHcbhqusIYL9pjtT9WJ3ch9
 2MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702035368; x=1702640168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIk3tQ6ySkCzXvhu4fvVzI666gbM4pnzLPnY/8QAtQ8=;
 b=Qc7VVY7q6ZrQLYhWhmQlrSwHcVUg3m0i9ig++eBy/iSTVOEfbcHGokPzrbQzaq2szw
 gKrgf68U/tOfsocZYRJrvGm63vEevkvh966Sanui9AefXn/slSuOSbySX/Vf1+qThyr9
 q8YNJLYCBUKAXvPuTcAY/C2EciNrR7rrRsAPY2Ce2SbrxtUWra5RavS+d1QwotCMRrBm
 VPgNp4A81zCBGbnLLshU8pnBCHP7Kox7PKNEm6/Y7tcTXulhAwj7PCAQGLMXmbCwa7Z3
 NR/5q/mgaEBgGyK+JkcloybmMgzdm/ZdCnvYSNaGRNP6hdpRW6YJQtpc40R/WamZIWM9
 8f6A==
X-Gm-Message-State: AOJu0Ywj9eMis9HuHCSxRD5H8E/9f4jrF5SLVon2682jc5xZtQ3FAW0j
 MTH1jczkldHg8ZNGguR5JmMmOVeVY/Ri/bmlA7E=
X-Google-Smtp-Source: AGHT+IE9BaoBjK/k/CCGBAt7DShHqwEhdyF9nlkAlXXI+2IsVM0ORDD/Tfd82OeostL2F4CwsICg1g==
X-Received: by 2002:a7b:ce0e:0:b0:40c:2205:e5ff with SMTP id
 m14-20020a7bce0e000000b0040c2205e5ffmr960841wmc.297.1702035368514; 
 Fri, 08 Dec 2023 03:36:08 -0800 (PST)
Received: from m1x-phil.lan ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a05600c46c900b0040b347d90d0sm4877337wmo.12.2023.12.08.03.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Dec 2023 03:36:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/6] sysemu/replay: Restrict icount to system emulation
Date: Fri,  8 Dec 2023 12:35:28 +0100
Message-ID: <20231208113529.74067-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208113529.74067-1-philmd@linaro.org>
References: <20231208113529.74067-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/cpu-timers.h |  2 +-
 include/sysemu/replay.h     | 11 ++++++++---
 stubs/icount.c              | 19 -------------------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index 3f05f29b10..d86738a378 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -30,7 +30,7 @@ typedef enum {
     ICOUNT_ADAPTATIVE,
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


