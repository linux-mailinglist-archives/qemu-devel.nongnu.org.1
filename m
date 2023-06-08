Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EB72816B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fjf-0001UF-O5; Thu, 08 Jun 2023 09:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fjd-0001QL-45
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7FjZ-0005ku-2P
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:31:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso5052315e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231083; x=1688823083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=JSt74SocMJbSpH9d7lDvOU8mQoi0/RVg2JluqSvjpvJuA++dwnyncBL3H5qJ/SNLFo
 r/YOlTwcSKMvK7rXip538USYAqqlwqVzfPX63N8eKGjqZqJbvIj9Vy/++AG85RMiNgtq
 vn7vLJgQG1ZveR8Z5wFj3XKpO+IxmB6Ck7kW98u7WGwA42Cel+UeqA3oOrewc4LaSfQ4
 fpbqs4NnZItGRGApnOCfQ+QZDGn3AUduEQfuIBpbYgAcaGnziNnC673nM7OYo/5d3asW
 7rZHMldU/Y4n4JvhGreiI9b4wN8IWNnRkDqJBPdBrKpqk23ER0RB4SHmb+ZhuF7GqLrx
 F4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231083; x=1688823083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=jKjrKBGdnMjk3HgKVys0WPH9lMAWu6dFVzlkhB0THsme8shaIeJ03DPw2vdlndJgd4
 g7CnSQ6OH3eCskgrsFqPWN2AYhl0Z6aOnkIiRgvX5uuHjobTU/6bNIqvZH9R0dWitwhV
 Aep46fB1W9iiWPuXm8bDprxs1hkfBrasibfmLasDtt1Zj2R6bjTf/B5k9XTUHXHw1D8t
 LFE9rh8YP3KZOqepC3LP4LV3Lb8Gafg3K2JG75egPETmryvYqqt6hA3lWGqrFXCVPPgn
 2Bmz/O9L2SYPa4bQpHd182iFDzJPR2/h+2HuZyaqjcJLg0cvExkJ79GzwD0PfX/Bs91z
 a+kw==
X-Gm-Message-State: AC+VfDzwysX1cZAVCY5VP8PNqAIUbUrirE9h9E3pbj1ZHmrLR8Iah/wN
 zKMBXwGdMzKnvZ3Bkj6d3pqCoJOWJQbwjrP50RY=
X-Google-Smtp-Source: ACHHUZ6RsiAID39DaIGkbTi5XhZpyJvVNvr0DgM7in6YvHIFCW0/uLKFvHb0zwnoOSYSi61mxsACRA==
X-Received: by 2002:a05:600c:da:b0:3f7:a20a:561d with SMTP id
 u26-20020a05600c00da00b003f7a20a561dmr1405285wmm.8.1686231083175; 
 Thu, 08 Jun 2023 06:31:23 -0700 (PDT)
Received: from localhost.localdomain ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a1c4c0a000000b003f50d6ee334sm1961021wmf.47.2023.06.08.06.31.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jun 2023 06:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/5] tests/tcg/aarch64: Rename bti-crt.inc.c ->
 bti-crt.c.inc
Date: Thu,  8 Jun 2023 15:31:05 +0200
Message-Id: <20230608133108.72655-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608133108.72655-1-philmd@linaro.org>
References: <20230608133108.72655-1-philmd@linaro.org>
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


