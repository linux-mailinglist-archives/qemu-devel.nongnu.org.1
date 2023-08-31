Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564478EE63
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLV-0008BT-2t; Thu, 31 Aug 2023 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhID-0001UA-Px
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:01:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhI8-0006xN-O6
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:01:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so7663645e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486855; x=1694091655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DlQKvvYxi/qCYEWGVTmqr7bzh4KTihilnnc7Rwr6fI=;
 b=jCMrT8BIIecveYmht/zcR/MM4uSG20H+ePvDhXxPp5EyW4gGprD3ZFRlSJvHI4PkTF
 M9GnGmQQuS1T1lzbUXoP2Pd5DjxAm+T6ZcY1rIBUb1moJqFhcxUeSIRci2fus8QnQLXu
 qR84noLKVTQTohPxZFgVWrgt7HYhKzjv/ZrOdqaGkprfSMXqiRrkY3H9l9E03LuhoisL
 TqYYowdoob2Fd5ufFBYXt7elTFPFmyyuoyfCIKjk9mNuz+rfsceyNNPBurh7PXYEbQdw
 8Cg6kYuDR7uvdhIV+Izm+MnrdgQiIuyVRK5x6Q20zeiKf8+RukKFa+G5mECmUzLfIdug
 g+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486855; x=1694091655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DlQKvvYxi/qCYEWGVTmqr7bzh4KTihilnnc7Rwr6fI=;
 b=hWAPB5tt0Kskrq8t2Z+I5Q7c4+HJKhQw8HzumlGiROyMgD1i5FCTVbM5/0xB+gWTrK
 +kPsvN4V9aCurL1weLsTd4aslTzNDVwMj0fVzrXYlGRcqD0X60MPAylCpx81QLmtbY4U
 87QqZppLtMzDlZiu87zweJESxcXoX754pTE6cPF5fUpjOd91M9oLchKJoO3N4P+5U0r1
 GFN0Q2KNa11hnXxEa98e4BY7s9rk0ivBfhXK3vhruAl6olCacXAr8bR7LcVwJq+oUd7A
 sbR5R/gNtZ52yHMv+oY2DHd4NY7Klg7vzrTs01rlf44wPqRKTg7pisvJHqdeplhYggKL
 pTBQ==
X-Gm-Message-State: AOJu0YzeyIooY9jhcRMqDUP6bwJtTKQTvwS4UO8TTSFYI0gwAXC0vkhX
 tI+A9mrhDCIFtgYHw9gomrbrob4sU6rbm6tBPho=
X-Google-Smtp-Source: AGHT+IF9zXp5z0tE5lsQ1/7sCJqanpRlZWKLVXEkWFZx1qC01p3Yj6O7U9t2aQzWy2kATFY9QwU5/g==
X-Received: by 2002:a05:600c:228e:b0:3fe:ef11:d79f with SMTP id
 14-20020a05600c228e00b003feef11d79fmr4442477wmf.36.1693486854925; 
 Thu, 31 Aug 2023 06:00:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fedcd02e2asm1881333wmg.35.2023.08.31.06.00.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 41/41] tests/tcg/aarch64: Rename bti-crt.inc.c -> bti-crt.c.inc
Date: Thu, 31 Aug 2023 14:56:43 +0200
Message-ID: <20230831125646.67855-42-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented as the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'bti-crt.inc.c' as 'bti-crt.c.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230606141252.95032-6-philmd@linaro.org>
---
 tests/tcg/aarch64/bti-1.c                          | 2 +-
 tests/tcg/aarch64/bti-3.c                          | 2 +-
 tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename tests/tcg/aarch64/{bti-crt.inc.c => bti-crt.c.inc} (100%)

diff --git a/tests/tcg/aarch64/bti-1.c b/tests/tcg/aarch64/bti-1.c
index 61924f0d7a..99a879af23 100644
--- a/tests/tcg/aarch64/bti-1.c
+++ b/tests/tcg/aarch64/bti-1.c
@@ -2,7 +2,7 @@
  * Branch target identification, basic notskip cases.
  */
 
-#include "bti-crt.inc.c"
+#include "bti-crt.c.inc"
 
 static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 {
diff --git a/tests/tcg/aarch64/bti-3.c b/tests/tcg/aarch64/bti-3.c
index a852856d9a..8c534c09d7 100644
--- a/tests/tcg/aarch64/bti-3.c
+++ b/tests/tcg/aarch64/bti-3.c
@@ -2,7 +2,7 @@
  * BTI vs PACIASP
  */
 
-#include "bti-crt.inc.c"
+#include "bti-crt.c.inc"
 
 static void skip2_sigill(int sig, siginfo_t *info, ucontext_t *uc)
 {
diff --git a/tests/tcg/aarch64/bti-crt.inc.c b/tests/tcg/aarch64/bti-crt.c.inc
similarity index 100%
rename from tests/tcg/aarch64/bti-crt.inc.c
rename to tests/tcg/aarch64/bti-crt.c.inc
-- 
2.41.0


