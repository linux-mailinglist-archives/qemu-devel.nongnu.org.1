Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8D72B109
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gxm-0005uM-Qv; Sun, 11 Jun 2023 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GwR-0003TB-SU
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GwJ-00049V-1J
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30ae141785bso3043432f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474040; x=1689066040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=KMH4A5NVVpQqs0+u339v2qEHWKHSsqO0eHhvqtEv6XuXXum/KWS0MOkaqywQKG70KE
 nYWnbHXeVsMgLCyvux3JAetmGkz20tCCx6zJRbS61NB+0w1yIjRh4MdVq5QbwcueV4HW
 sOyPbv5MN6l6DySYx33HQLXck7okuMHImvz0O9MUJDj40r14WU73r3ACTC/qYzeccrDU
 LcBRGUtxkldoGv7yFAZk86i8UqgW/Nb/y2AX2jf1Jqd2gCW/He5ZiFXjN/kvZ7TWeZ7Q
 npTdwyNs5DwCxXbLasgzubfejF37koB8xhmj7bHvujujtkqd511lgm74nskdWFCnYtnZ
 bTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474040; x=1689066040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/F/L6gm+zkVK5EOXjzGUKkb1zlWJACWpFKWw3y8T80=;
 b=fjyhgElbQJ3p3KXhUZz5TZwqfenFP8ATz6R3kgBmzZiqDhtQTPrdvpKVfNzWPTwNFG
 HSofwp3tMEXy7zT/8FuZfuZLNZUTJZj0b2ye5zirGemvWcxWrrJEHRKcknPaOynpkxPK
 D6y7qq5wfKiZ1wYOejaK6pWsZ3sh8LKeDU9Nvx9BXlHFi9AAJyLzxcpdhbgWq5wB4jmt
 mI23UPIVPsnuNcVXqc+xQFg8nTx2Qe5yUi6a26IlpgBl/C1+jzw5HTM5QzXjZS7zGWqn
 UKdryp/pFoCw6FfEY/y6iOcCBIdxwsyPhkGIHjR9wPjJoJlsaHupiyTorE7tIEqy1pWA
 U5/A==
X-Gm-Message-State: AC+VfDzkoqbPKN4AHuwFfdeQwSf7EZnKVichoBtxSK+Dk3j1bAZO9fej
 P95gu9ix0uxbs0azVwAtHSCNYuTH4BxfeXfLb0o=
X-Google-Smtp-Source: ACHHUZ4HEuH0fpMSXFeq2lM2+eohGzSGtm0VpsMnqzyocUpSDvVFBiNApLwC3wdz+ZaQ1SIdyLE99g==
X-Received: by 2002:adf:f649:0:b0:30a:9014:838d with SMTP id
 x9-20020adff649000000b0030a9014838dmr2645906wrp.11.1686474040470; 
 Sun, 11 Jun 2023 02:00:40 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d43d2000000b0030ae93bd196sm9052286wrr.21.2023.06.11.02.00.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 26/26] tests/tcg/aarch64: Rename bti-crt.inc.c ->
 bti-crt.c.inc
Date: Sun, 11 Jun 2023 10:58:46 +0200
Message-Id: <20230611085846.21415-27-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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


