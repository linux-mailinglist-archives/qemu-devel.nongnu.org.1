Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9F80A264
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZ9N-0004Rw-Ro; Fri, 08 Dec 2023 06:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9K-0004FM-Q1
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBZ9I-0004U3-7r
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:36:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332fd81fc8dso1879989f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702035362; x=1702640162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVurd634A6d7jfTmu56SsLNYdI1euektVunJFK5bAB4=;
 b=mETiaTtkWBmuG4oPJMm+dKQt6UqhhzDCzBH/UTajH+ubYJOSDnNHWRkXDJnLCsBhkV
 My1ILds0NK5V4u3n9Gin+Sk/xzsZ/Bib8zf77cYeg4xofFWzf57TtR0hQz3HY2YyHdeq
 uhqkR9vbjy6IM/nP2DsQyMcNlad+HksdKCWllIDVM/0mlKeB/lGDtyX0057jCE2+a/Fs
 iTWINlYhxHW0m2DQilLaOcic+UUt7A5wrkRWNZH3+fGNxkFEomPR5ip/Nxgi7frfI13H
 SNZwruHuzgqkBDA+J3p8M1KJdDqMeCux6RUgwC5RvE2tk0uz9OihyFWmoYYSxpDBVTQF
 dkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702035362; x=1702640162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVurd634A6d7jfTmu56SsLNYdI1euektVunJFK5bAB4=;
 b=pfKQnn3k8y1LZ/elidXSN1uwMkJjw/sDKj9BFgkVkT5J62+cA/k2/rjeyJ7c6saLwY
 mFyjKj5TY/bmEyPFFcIlqEOroWBPnkgklbphaU5pJVyLJuCmHVmc9OmxcTQv3xpviFlX
 4TpE/WfTpAJg3QBY1anyLGHJdQvxp0Sc04NDv/tUJsG5kAYhGJhwQOWBLB2yfLoLNzJ9
 afrbU2uthbgV3fUh4LUftYO7JlGLnO3o/fVy9Df7RVvNszrS/VOAN2wRIoTKkgaRRbhl
 tCOYleQ1u8LosnPCjSCTcabSyA/8089YVQdzBsuLpr9xkxGtEOpGzle/3MgTmBOr+Xqj
 WOlQ==
X-Gm-Message-State: AOJu0YywOnjf8tzdgX3o0vjwbK52fnO93fgzskqiFiNiLuZy39kU+iWx
 eCFhZO3exYyIx9BuZxA/ATQwuRgv5gjgj1DORK8=
X-Google-Smtp-Source: AGHT+IEgxfK4q24frtfMGjLwXczGWe5dnyetb+TjvVWkoaIwEkzO/l9kUNaZnEYCPozoR/waVoXfwg==
X-Received: by 2002:adf:fc52:0:b0:333:2fd2:68d3 with SMTP id
 e18-20020adffc52000000b003332fd268d3mr2309689wrs.102.1702035362697; 
 Fri, 08 Dec 2023 03:36:02 -0800 (PST)
Received: from m1x-phil.lan ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adff952000000b0033609b71825sm1357263wrr.35.2023.12.08.03.36.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Dec 2023 03:36:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/6] util/async: Only call icount_notify_exit() if icount
 is enabled
Date: Fri,  8 Dec 2023 12:35:27 +0100
Message-ID: <20231208113529.74067-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208113529.74067-1-philmd@linaro.org>
References: <20231208113529.74067-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
 accel/tcg/icount-common.c |  4 +++-
 stubs/icount.c            |  2 +-
 util/async.c              | 16 +++++++++-------
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index f0f8fc7f1c..a4a747d1dc 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -495,7 +495,9 @@ bool icount_configure(QemuOpts *opts, Error **errp)
 
 void icount_notify_exit(void)
 {
-    if (icount_enabled() && current_cpu) {
+    assert(icount_enabled());
+
+    if (current_cpu) {
         qemu_cpu_kick(current_cpu);
         qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
     }
diff --git a/stubs/icount.c b/stubs/icount.c
index 7055c13725..b060b03a73 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -37,7 +37,7 @@ void icount_account_warp_timer(void)
 {
     abort();
 }
-
 void icount_notify_exit(void)
 {
+    abort();
 }
diff --git a/util/async.c b/util/async.c
index 8f90ddc304..9007642c27 100644
--- a/util/async.c
+++ b/util/async.c
@@ -94,13 +94,15 @@ static void aio_bh_enqueue(QEMUBH *bh, unsigned new_flags)
     }
 
     aio_notify(ctx);
-    /*
-     * Workaround for record/replay.
-     * vCPU execution should be suspended when new BH is set.
-     * This is needed to avoid guest timeouts caused
-     * by the long cycles of the execution.
-     */
-    icount_notify_exit();
+    if (unlikely(icount_enabled())) {
+        /*
+         * Workaround for record/replay.
+         * vCPU execution should be suspended when new BH is set.
+         * This is needed to avoid guest timeouts caused
+         * by the long cycles of the execution.
+         */
+        icount_notify_exit();
+    }
 }
 
 /* Only called from aio_bh_poll() and aio_ctx_finalize() */
-- 
2.41.0


