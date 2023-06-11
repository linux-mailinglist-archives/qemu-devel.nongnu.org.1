Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A872B103
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gy0-0006R6-KI; Sun, 11 Jun 2023 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gw4-000368-T4
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gw2-00046U-97
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30fbcfdc7b6so131086f8f.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474027; x=1689066027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bOi95+MAdYOQf36lFFFxG4Odq562AhoTTqq539rW9I=;
 b=pVvQCGkKt+lBR/jD68SYizRPTi1X3apKBFe9rOh2WBWZtaGnK2+P+iNT5vmiu5s4tn
 Rhh3Gx/IPP3QtLtJl35AUb/Aluq75RpStzEjk1ArUXz+V8QK/rhTboCQRu3cMlnuWBqz
 1Xu3lEtfIZUNeWxtKqdyJmtsNKj4ZUgqPB5Xqew/ijndssGqVnsv3n6Eaunpa8U6T10W
 GlFNe6uJpGboMda4SwfMC/HAFUzZJQ4V+8G5Pnbwx2anwDu6QL2F700+e4/wXBGioeag
 PnVvvQeUVbhQXQMvBd56284gp/pcE0FO2J6R6g0Vv8W2xlGpXuAisOLa8xIVIXkMHKRe
 7l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474027; x=1689066027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bOi95+MAdYOQf36lFFFxG4Odq562AhoTTqq539rW9I=;
 b=ViEG8NskAoN1OmaoIwFKg7kyqYQFudd1LOyd0QnYJUgJoEDqX1/OBf4JI2ZYeaXXGg
 kJy+3fsKCQ3FEnfWBF2xgPP/pzMpxhmYEMT9pr0Kx+6z/T5zftrNOdgKLpjkkIo3sUu2
 +uxf+uUMq377E0+bw5jZO3sGeo29zXd/DRewW3qREAb0Iqv5fMMQD6s7ZP3qSX3z+fCP
 3ul4GAUX1FehJF7MduWugiqYpzMKQab5mNwY9yE8J9M3nD8/Br+LWfw2ioOgKEc8fubx
 prVXifuUshwhT5DNxNwZeKjhuXlelzn8kReIdV5ebVXsfT4jUZqj91yn/tcJK1wcEP3W
 epSQ==
X-Gm-Message-State: AC+VfDwNs2cJKFB1Hx1BLikwUYDMIJTx/GWo8/X8W/l6b06i6nT1kSwh
 yP2Fuz70kjjgnSLdHzu3tL9W4pZjIR6WNkEqiUA=
X-Google-Smtp-Source: ACHHUZ5O5uBSLqz/G2trQjTtoONJ6eSBlQX0ryEYWc7OOfJS9lz2Hy6hTcNMz/+hHh9UhEyJ42Smmg==
X-Received: by 2002:a05:6000:c4:b0:30a:e5f1:eedd with SMTP id
 q4-20020a05600000c400b0030ae5f1eeddmr2207118wrx.67.1686474027539; 
 Sun, 11 Jun 2023 02:00:27 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 h4-20020adffa84000000b0030647d1f34bsm9103172wrr.1.2023.06.11.02.00.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 23/26] target/arm/tcg: Inline 'exec/helper-gen.h'
Date: Sun, 11 Jun 2023 10:58:43 +0200
Message-Id: <20230611085846.21415-24-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
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
CHECK: By extracting some inlined (FP) helpers from translate.h,
we could reduce 'helper-gen.h.inc' to helper.c.
---
 target/arm/tcg/translate.h | 4 +++-
 target/arm/helper.c        | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3d7c55d3b6..fc6357eae8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -6,9 +6,11 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
-#include "exec/helper-gen.h"
 #include "internals.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 /* internal defines */
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d4bee43bd0..89ee68893f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -26,6 +26,11 @@
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
 #ifdef CONFIG_TCG
+
+#define HELPER_H "helper.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
-- 
2.38.1


