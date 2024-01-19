Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64A8328F2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:37:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBB-00048l-72; Fri, 19 Jan 2024 06:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnB1-0003vK-9Y
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAy-0002qs-W3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e8fec0968so8389085e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664203; x=1706269003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAPSTP3JoL9Rbkyt54ClOb8XBp1E6hFiC5B+aqm9oc8=;
 b=cuby521LwVfsbJER/LRPs2/2NQjF1OH9/MvN5JLXnmvoo/Kjl/4VhVI7wq648PrE3k
 GXjKDKnhC9PAboqu8Mr1No6EwLYvmCj98DWz4qpYQQDiH4OwewTbuqdbprn1OhyO+tin
 CNYvAp+Uxxit255z7EkO9c1pZGbZP6glCNt7MjqrLX2uZDwKfVjMG+JCvFxTQVTcZeRH
 sX563UxC8hdhbp4RPvWHPrNBWgczdCwEE96RKFOoumRko6MwSMQOEbkuAZJcnKSlRIg4
 XHZl7GtuZcFn1CR26J2DxwSMN/4xViV8x/y4KzqE3xBdPE+U33W9OEqgK+ZU2uqgy3xs
 SppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664203; x=1706269003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAPSTP3JoL9Rbkyt54ClOb8XBp1E6hFiC5B+aqm9oc8=;
 b=EQdHULO1ioz/UuZFcQauWdmavpr6+dMFv1lVRE2RGsk3f54GdAo/ERZ5Ej7JQHOQUj
 OkG9/8BWyPxI3krCvaigt8fqI81G4vnzp7XbbLk3d8oMEfFg5wymRlEUMJmE0+nzqQ36
 Z72OXbJ6pMFqhQtw2INRIynaw6FANUeSdXpyYqcH6EOJRe/MoEB2r5zbPalW1xiq0MV9
 5ZXK8+tDWWm4vHSoLob/qRThEotV9wdWM1sFABRY/vdcLO+T6CEbHGpOL0hxSRjp4etH
 g2brEGbvJeKQWN49cgxCcSJ6fmm9uvdCZqA49xBh/l9wECHlcnuJgY05j8waAnCjDHHO
 Tl+Q==
X-Gm-Message-State: AOJu0Ywe+Tq0X/pw4TWZ5oczcAmJoP3zQMXHBpFb8tpqZoFPtKGhGO04
 r85JB1tBXoUvGj39IqurfViYSeEiUCMigOKWNiqsd8Ibsk2bbPnkGsnM4/3CCiZyFTpwRgNkSRj
 UTcVuFg==
X-Google-Smtp-Source: AGHT+IHISkHdSr18waL5utIUkxFUJwTaWRF75Lh3ZC2wSlAjeClGryFxg8O8BHfbToppa6wRY+N4Hg==
X-Received: by 2002:a05:600c:1547:b0:40e:4d17:b239 with SMTP id
 f7-20020a05600c154700b0040e4d17b239mr1433286wmg.60.1705664203301; 
 Fri, 19 Jan 2024 03:36:43 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c1c8900b0040d772030c2sm28737333wms.44.2024.01.19.03.36.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 21/36] system/replay: Restrict icount to system emulation
Date: Fri, 19 Jan 2024 12:34:50 +0100
Message-ID: <20240119113507.31951-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231208113529.74067-7-philmd@linaro.org>
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
index 83995ae4bd..f229b2109c 100644
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
@@ -84,12 +87,14 @@ int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
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
index 1eb35b10a8..9f9a59f55b 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -6,10 +6,6 @@
 
 ICountMode use_icount = ICOUNT_DISABLED;
 
-void icount_update(CPUState *cpu)
-{
-    abort();
-}
 bool icount_configure(QemuOpts *opts, Error **errp)
 {
     /* signal error */
@@ -22,21 +18,6 @@ int64_t icount_get_raw(void)
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


