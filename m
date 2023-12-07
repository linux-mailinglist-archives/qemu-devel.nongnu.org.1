Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85501808C2D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:48:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGa3-0000nC-Sw; Thu, 07 Dec 2023 10:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZw-0000i0-Cc
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:21 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBGZq-0002AL-Bs
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:46:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54c74b3cd4cso2315971a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701963971; x=1702568771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwehzbql2APDeG+wQ20PBY5aWPTjdNYBgHCWKgUCJ14=;
 b=mUX6v3vp20TDI8rGeV3wmX1CvCwE0D97UZzCS/m4Cqkmf0dePOambbUezlALs1o4gm
 DxN4HX4C7cLorKX9TKqruXUxURVI54D29xRT/heARAqAkYQ8IzSa3dXFmNqw1dfNSsHO
 zbAry8azt8szyC1WLtWhVTD8pjAbdAFLz9FEYTeVNS4j7sGN+Kg1hW+DGovrv1CJAU9T
 goqLu25arS3XbBNpNZFWMgsva8ggUYwcI5WYgL532J3gt7TBb5COP9jc3gK6Qd9Ot6mb
 mWNgTrfNEl4T+QkdgXY+VA3+JyZawyhjdYXDuFKLazMSCByXgLR0yz6cwU6IANMTVAF9
 Rkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701963971; x=1702568771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwehzbql2APDeG+wQ20PBY5aWPTjdNYBgHCWKgUCJ14=;
 b=oNC++3vx28GF5Dq7ApdwErxzbY3axyurJy8AEtfMAa3mPQaPaeGSUYQjcsY0kc4o6S
 9hSnbbZU4LLsBj1VtrKkocdCEIgeCczIb8INaX1Hjl14ORR/ATPcoqmt23C6uLUH+u16
 3TqkUiifHD03FzGMKd0qKu6SuYWgb/q7e0NvZTrhzIJRCx1Ta4tIroee+He3FnoAbQTH
 xZVcAvfQNZBEOMK/XLbRB45EQgExHT4lX76qjBJmPAiTQtk0SrBfyUH16RUgddIn7qDC
 kQmF6DbsbfbqFRv46ifJnp2pPCDPaT9FbIocL/8DunxNTv5BULr8+cnhCfxdyi1/Ug12
 5OJw==
X-Gm-Message-State: AOJu0YwokUTD+rVqrmYhx1O/YEd6IwGqP3jv3723fpgx4GG+64g+b4Ik
 PR+oNmOY6FdLwPkqW+PPAeiI/DEj3mROAF49EXE=
X-Google-Smtp-Source: AGHT+IH+fUjL8JpAdfa+TEJhDvKFg2SP2gxEb5KLK7Svj+3vRKYuykJTv15lFCKlqk6DbPPWMaSKUw==
X-Received: by 2002:a50:bb03:0:b0:54c:553e:67f5 with SMTP id
 y3-20020a50bb03000000b0054c553e67f5mr3540189ede.8.1701963971415; 
 Thu, 07 Dec 2023 07:46:11 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a50ccc1000000b0054ce5c00e74sm923565edj.88.2023.12.07.07.46.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 07:46:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] util/async: Only call icount_notify_exit() if icount
 is enabled
Date: Thu,  7 Dec 2023 16:45:48 +0100
Message-ID: <20231207154550.65087-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207154550.65087-1-philmd@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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
 stubs/icount.c |  2 +-
 util/async.c   | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/stubs/icount.c b/stubs/icount.c
index f8e6a014b8..a5202e2dd9 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -43,7 +43,7 @@ void icount_account_warp_timer(void)
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


