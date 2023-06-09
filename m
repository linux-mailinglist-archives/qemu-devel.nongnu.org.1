Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A2729778
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zh3-0002ag-Dv; Fri, 09 Jun 2023 06:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zgg-0001xv-2C
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zge-0001kt-0a
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:49:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so11952215e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307782; x=1688899782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=LFO2lzV35nvXrFwGqKhLi351u+HgMzt5AZ+zBIWSBd1I1NTl7W8W2zC3zxPNwjCyC7
 akALs4J/gU/9lijzLBwVe4rr+5hdMFJ8GMWcL/8F4X758twcQva3ritUPG/hwLlokusg
 nwK7/6kT35orJIiiXPqQif8OsQwHGS+6Q5K7sv+1dnhUIBaHFOe0V0NFOFZzCzXLuBPv
 en4IUwhGbWzxXJc5YJ9yoGjg2FGiXT/kR2J5+eGCT7zT5trbzKih3SImEaXLTfEvIEeV
 hCSG67TtjZg3tf0Ye1EBIwNH6WWdKTtgd8hIpaO7L52VGxJWn1IEs3a8jKrfQAHbDY2b
 P6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307782; x=1688899782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=a+9tKxJ0OgGBRa/0NOyAEkPrr7jfEg7/QnZEi+ZIqwVPt5wP1ZOSXh15H5BHJtGBai
 1UPiGqggkEK3Y07h6HT3qrmIMYj4Z3r9+pZ0ec2Ptovy/qfFlovQda9AJkLn7G66BDuk
 s7r8eu5GU/9dUMc+1UZ3u4nTFHfuTUcH1kG5pTtVFxq2Mb4bgrAlN657ju2TFL2gWIL8
 MyaAtMD7utpY9p2g+hmB8v9MKz+mwGiZIl5bsn9vAvd+Z8Rjal54z7mXjqjnUwXShETA
 1m2MGi86wwB8mMsXcvGaoQhIgXTVeDfKk1e2L0ky/vLcnfu/go84y6aPGuDd5BIOJSWF
 AWpA==
X-Gm-Message-State: AC+VfDyAWZjdzKp6mTHlHETpDGM0ew8WH32dK5zhvCnD8FcSiFJfGJzD
 9pOgkb3R7j35DBiSWJdAKQcp7kXHXgmZN0ALsU6WLA==
X-Google-Smtp-Source: ACHHUZ6/xjRARBlemyArWkK+2LV+0U9ls37BHapadOzvc+xtzVVGCHIJ+GYJx2KRBpu/wWGIibLS4g==
X-Received: by 2002:a7b:c385:0:b0:3f4:bb58:d174 with SMTP id
 s5-20020a7bc385000000b003f4bb58d174mr652758wmj.22.1686307782121; 
 Fri, 09 Jun 2023 03:49:42 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 l15-20020adff48f000000b003078cd719ffsm4112422wro.95.2023.06.09.03.49.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:49:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 22/22] tests/tcg/aarch64: Rename bti-crt.inc.c -> bti-crt.c.inc
Date: Fri,  9 Jun 2023 12:47:17 +0200
Message-Id: <20230609104717.95555-23-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
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
2.38.1


