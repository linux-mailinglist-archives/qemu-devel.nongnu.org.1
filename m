Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF91735BAB
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:58:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHEu-0006qE-20; Mon, 19 Jun 2023 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEl-0006kY-EG
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:16 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHEj-00050c-OS
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:56:15 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9889429a89eso247178566b.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190171; x=1689782171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uI0+eCWvosfOJTgHMMhqagfj9N9jRnfnJQ1FN+rDYgA=;
 b=uQcOqrUlLiPe1/eFqVrffkQUUQ7hrqUOFCU8j1YhyrxM9fPNi+crQgKX6ezUGq6c7S
 yjLkAy1Zkin6Wnq0XMRbijWjtgRDAgCDfOslOoBnpMEnSJ+kGfQJq02jCFn3iQ5qN6ir
 XJU841Wo8ulrUWd/JKZfmUwPg0riSvZSKSBkg518Zckyoq22jO5GRuJ3E5ZLCl0Gqekn
 gNvGDSWTymk1yoj3fkAZ23A/qTpXZaIn1gne7rgFcVerT3Shb2e/cHw49ee/qEmvqGJ4
 NqNc/vYK3ghvYvovS1DaG/JVU0MS+fX0Cskk3rSGPZvP2jJimeTbDVFAMjEGcQlomgCD
 YLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190171; x=1689782171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uI0+eCWvosfOJTgHMMhqagfj9N9jRnfnJQ1FN+rDYgA=;
 b=TqBRtS+RrwQ5c7Iw//8qGbduO4aEpGRVCK4nsERKKMWoteIgIbUCilNnQ5X7A0Eu3E
 bBSmE2WXrG1oF/dUeKcY0tJ8mwJgLQiubmYI118F1SjrBgDAw/tCaZ3XZ3xkVUmiIKTZ
 uRn/LXQClc9EUZrbXUnq7JqM1pMqAzza2+B1i4KiiaSvkVvMAIWQwZFa7q2NkGYIj5Tm
 t58EmXo8UZpJ6iniYB8NMls1gSfCl+R229taA/ToYL7XsJWhjzKxNIf/7AfRV58Xhjuq
 gmJ5mofaO4GsV+cPPVoObcWifi9JGMWCixGRjqHCh05cEXG1l2O8R9vLDFKWaQsOyxvu
 tcKw==
X-Gm-Message-State: AC+VfDwa7PSkjdVBpTKQXdQB7RJrl4CnqMt8Q2G7QC4W8VvbtpWhYsWc
 mGkmTAi5B7zKhuM17WgT3GjLW0ee09mLF75kF1GRjA==
X-Google-Smtp-Source: ACHHUZ7ko2csTXfiJvfSOTPI1l0ZgBjXFxbHD1RLC5MA3bIOcc9sWLkW1h55mi/N1ecO66NP8lnmTA==
X-Received: by 2002:a17:907:8686:b0:987:d0c3:e300 with SMTP id
 qa6-20020a170907868600b00987d0c3e300mr5720544ejc.26.1687190171335; 
 Mon, 19 Jun 2023 08:56:11 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 j15-20020a170906410f00b0098768661505sm3689999ejk.117.2023.06.19.08.56.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/34] target/arm/tcg: Reduce 'helper-gvec.h.inc' inclusion
Date: Mon, 19 Jun 2023 17:54:54 +0200
Message-Id: <20230619155510.80991-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Instead of including helper-gvec.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h             | 1 -
 target/arm/tcg/translate-a64.c  | 4 ++++
 target/arm/tcg/translate-gvec.c | 6 ++++++
 target/arm/tcg/translate-neon.c | 4 ++++
 target/arm/tcg/translate-sve.c  | 3 +++
 target/arm/tcg/vec_helper.c     | 4 ++++
 6 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index df22f1a117..6d61694f5e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -198,5 +198,4 @@ DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-gvec.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 22caf89bb0..924bbdbf1d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -26,6 +26,10 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 
+#define HELPER_H "tcg/helper-gvec.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/translate-gvec.c b/target/arm/tcg/translate-gvec.c
index 8b1d5e283c..1ae346c5a8 100644
--- a/target/arm/tcg/translate-gvec.c
+++ b/target/arm/tcg/translate-gvec.c
@@ -13,6 +13,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-gvec.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                             uint32_t opr_sz, uint32_t max_sz,
                             gen_helper_gvec_3_ptr *fn)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 9a1831f849..fa13e7e8cb 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -24,6 +24,10 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-gvec.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff050626e6..605cce0979 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -22,6 +22,9 @@
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
 
+#define HELPER_H "tcg/helper-gvec.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 typedef void GVecGen2sFn(unsigned, uint32_t, uint32_t,
                          TCGv_i64, uint32_t, uint32_t);
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index af325577f0..b0aaca38e7 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -25,6 +25,10 @@
 #include "qemu/int128.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper-gvec.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
-- 
2.38.1


