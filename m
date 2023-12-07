Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA7808560
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBBaq-0004fq-4a; Thu, 07 Dec 2023 05:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBaj-0004eV-Tk
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:51 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBag-0001Yw-Ti
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c09f5a7cfso9051495e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701944805; x=1702549605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3NowGfQ+Uh8kFkQHiDEgo2KSzDvk36tqOsqfMg+nHw=;
 b=UHoUid5OxExp9gtgboFVFjy7u1FGS9SNgaEowrG2YGoOMFq7LJdqrvqvauTlcwENoJ
 1oujlxOmVc+f+5IUOYF8V6Y+rH2Zb+3QoibqRstehXhmwY7pCi/cxWTJml11NR77NbJX
 zs3WgBN8Bfy98X87Z5z87lBP2+YgYQw31Z+aFQO4hcr8AVgoZAVYF9/cykNAyKzZtoQf
 kHt2fQTL5P6nLpqfZhw5MX9Jj9J/00APZVYmBZ+q79on6Nnu2iEPvhtFS9g+gAu6DOjd
 yTwYMuV+Zqj+t8/fRZM+Rs0Nszrg91loWM8ZllbyxjBzXYUQSWHcptXY5b2v0vmqdXyz
 fKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701944805; x=1702549605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3NowGfQ+Uh8kFkQHiDEgo2KSzDvk36tqOsqfMg+nHw=;
 b=KVbsv4jA5O9oZUadxFGqjLCGNL8vjB3maVp5nZkydxm38F683tjMdiX2zph8H2ag8T
 eO1CZP0Tt810ueuERicaoK/Fp39D9tDxqhdoRBlkUGooX9eKC3r1tQLj4CfvfvkrCZL5
 D9lz5NpsGd9uJrwRE76v9XTM6ULTR+YKQR/VMdZK7uhC8qJGEJQXj52W8hy2kG2lylfu
 G5p+DAruTFPzlC/fWNhpcSyFFlOaD40adfw7lsA75dg08l041vrl6upotXv3u3JJ1JLR
 smNGYpcKLoDBmFwtdet+QHUosxan5jQhgiGNKYwJRkfx5truIkD2F0cNsJSe4aSVCL6H
 25vQ==
X-Gm-Message-State: AOJu0Yw6hhVsXtOa8fNGUvUd8sMCh+F5tQu563WbJHcu0VjDG8+h0nRy
 Jattft05raVe6zhbsOyMJ7UwUquxjAW7UWjIzJw=
X-Google-Smtp-Source: AGHT+IFSftCQ1iP3Uhw/vSbJ/eUpyDSByqITy/z+dX4EczDmrMmon7AHlzQh52UxTFVyJrnS4tISBA==
X-Received: by 2002:a05:600c:4512:b0:40b:383a:ebc7 with SMTP id
 t18-20020a05600c451200b0040b383aebc7mr1351527wmo.34.1701944805241; 
 Thu, 07 Dec 2023 02:26:45 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b0040b4c59f133sm1435364wms.1.2023.12.07.02.26.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:26:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] sysemu/replay: Restrict icount to TCG emulation
Date: Thu,  7 Dec 2023 11:26:30 +0100
Message-ID: <20231207102632.33634-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207102632.33634-1-philmd@linaro.org>
References: <20231207102632.33634-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
 include/sysemu/replay.h | 2 ++
 stubs/icount.c          | 6 ------
 system/vl.c             | 6 +++++-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 08aae5869f..02fa75c783 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -79,12 +79,14 @@ int64_t replay_save_clock(ReplayClockKind kind, int64_t clock,
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
index fc3beac003..c39a65da92 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -1,5 +1,4 @@
 #include "qemu/osdep.h"
-#include "qapi/error.h"
 #include "sysemu/cpu-timers.h"
 
 /* icount - Instruction Counter API */
@@ -10,11 +9,6 @@ void icount_update(CPUState *cpu)
 {
     abort();
 }
-void icount_configure(QemuOpts *opts, Error **errp)
-{
-    /* signal error */
-    error_setg(errp, "cannot configure icount, TCG support not available");
-}
 int64_t icount_get_raw(void)
 {
     abort();
diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a..8c99c5f681 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2270,7 +2270,11 @@ static void user_register_global_props(void)
 
 static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 {
-    icount_configure(opts, errp);
+    if (tcg_enabled()) {
+        icount_configure(opts, errp);
+    } else {
+        error_setg(errp, "cannot configure icount, TCG support not available");
+    }
     return 0;
 }
 
-- 
2.41.0


