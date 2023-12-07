Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE1808561
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 11:28:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBBap-0004eR-4e; Thu, 07 Dec 2023 05:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBai-0004e8-0b
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBBaf-0001YL-JJ
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:26:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40b27726369so8656595e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701944800; x=1702549600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZZpBZ1VJe1txisZ3T5aUZfE6odH/PADS2VLpythQ8NQ=;
 b=djxDQFuHqOCVA49KJ+mdchwsmaUYEGm5f6I/Y5PqdEkyxi7beZwbOHAQn5ls0IseKF
 V1A8OWih8rj4v+rZLIWl3P9RtOqqEaU9p6lQCbd5cklWnRxeTnkEnL1G1xNIA5mb15pX
 kBcpCD1xbLdg8TMMXwhK6lucs+1LE9kh8PCDbAVTnXgX2h88OoU+e72I3vIEcZwvEKWg
 NsFVJojuqbbXaakAvTB3jDiPptQyD+PJ/ICko2XLpPjgL0XWa9uu4gbBF+Rew7cTAcJJ
 cD+zJA31FPQystfBAtJpKUBc1LzMGZu5ghxFd4BW448MZjl29ctKqvs4h43+DdbXDX0V
 XrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701944800; x=1702549600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZpBZ1VJe1txisZ3T5aUZfE6odH/PADS2VLpythQ8NQ=;
 b=Y6g/IQN934FvMyQxTmy/SvFise3TMpqAXpJ7XpTXJPxq3VohZfpCoiABxHM9bmuMkH
 R1pMurvhO/nJxqgp0xb5LASVLUtFLc7AMVDQ3v+6Unuz65bxRVrbwFmcsild/qdKVoQq
 ukC5W7KfT51WiHj5xI42WVs/TNPO/Yv9KECXsh+XhWHntha/Vf8GtqsQQO+nvQH7FOMb
 K8s6XALxAnFr5O8Q1Fjqf9vjAXfPwJIDk+diDNEXm7fLTp423QNJJEeZDljGKRV02Zzc
 iAly8cHkdTOlH2dy3yAoVDBsx0nN+n7FCBSRPSPgOqd+34oKSTUrH4d6W/UCY41VEwNA
 +Ocw==
X-Gm-Message-State: AOJu0YyCOSZmiIY2hBSz+y2ux2gXm9sSLenDdd/uAqpTxBRGy6Nx7JbO
 AoafXO901WKnEoP9KRl/8T2G+zVI/fslgASB3pc=
X-Google-Smtp-Source: AGHT+IEjfazqrRKNyZu7f6uIeBimdbMtRgBkS51QYvt4shkhGmTx1gSNS2hfJTdI+NBOJfHN2wbDxA==
X-Received: by 2002:a05:600c:501e:b0:40b:5e1c:af31 with SMTP id
 n30-20020a05600c501e00b0040b5e1caf31mr1416336wmr.55.1701944799949; 
 Thu, 07 Dec 2023 02:26:39 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adff949000000b0033342338a24sm1077287wrr.6.2023.12.07.02.26.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 02:26:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] util/async: Only call icount_notify_exit() if icount is
 enabled
Date: Thu,  7 Dec 2023 11:26:29 +0100
Message-ID: <20231207102632.33634-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231207102632.33634-1-philmd@linaro.org>
References: <20231207102632.33634-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
 stubs/icount.c |  2 +-
 util/async.c   | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/stubs/icount.c b/stubs/icount.c
index 6df8c2bf7d..fc3beac003 100644
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


