Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3072B108
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gxl-0005f3-Gi; Sun, 11 Jun 2023 05:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvy-0002tM-NJ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gvw-00044I-QA
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 05:00:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so23238015e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686474023; x=1689066023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/kuWTPxcHL3QCO5m7VZbZfFT5tI+SpH0RGLuwEKATs=;
 b=slPZWIsNNSlkzh5ypNLiLJBLpiPEZ9PjN7GRKNE/M+hV2J9dr1cjmI90S8zLvvKEsx
 v5MiuAMFfwt1OMdAALcfasJgPl3JkS1uiGflP3S4J8WSAZ8Hj1m+I8/YYgTmSetJl1Fn
 qu9GCvJmw6gmIXEX1riRJeRfmaHtfbjy6xAwSje5mXdu/UVFb58sBdEtg3GCzhGrjeU+
 MCvjswRv2nFOOU7A7UdHKyYOuVSwJd5siJ8Z6p/nsNdKQ88BINR1lxY79iE7TLn3sXwz
 meT+uBgNDrHRBLlbY6nMdmDQZn3ibQiYP70Fa/MFIwK8On9d1kKBjYR16tVi4W6F1Rlw
 PIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686474023; x=1689066023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/kuWTPxcHL3QCO5m7VZbZfFT5tI+SpH0RGLuwEKATs=;
 b=HUGcoawXkwqIBlWv7QiZHwyJewPguFkDMWQI/3n2kwZTKMDN8xLfg27/ZHTUViSruw
 uskrYmKTzXUeiNSn8uMXuTF0RmyDZM8ldxttKxgHIACg8+OVLV9BBNnS72GqWzUJuhUo
 vFqp6oTFbs0S27Vb5+rcfujiSA032bh/fY2m0sz0qNEcdHRvY975Ufqi0DyxroCmhoHP
 C2DMAlb736XbYfP6eIKCpHNY3YzrprD1zeomTH/rGpJ1oCyNREsCclh011ADerBo/imA
 gLvtwTJZYDS8El1Oxo0KTj8x3qnMe/14b5Xv8QmeoTA0NhmO2reUCx1S5ZnL7cU9ozvT
 rc7w==
X-Gm-Message-State: AC+VfDz+ZqXxB7WKTkHRSFIpjqkiMVk9O9KEGUCOPQcLWF2LT+b2Zw74
 c1Nwq74iklr/HA8lsC1NN60pjUkN4GbhHoNp61Q=
X-Google-Smtp-Source: ACHHUZ4WhaWkldvC+Yjy0rU6HKA9agnKe1GRLl4U+G4GGiJuBxyTFloLf4pzOKCJ+HW9T87LXM103g==
X-Received: by 2002:a1c:f70a:0:b0:3f8:342:d67f with SMTP id
 v10-20020a1cf70a000000b003f80342d67fmr3771399wmh.0.1686474023357; 
 Sun, 11 Jun 2023 02:00:23 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c114a00b003f7e60622f0sm7865177wmz.6.2023.06.11.02.00.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 02:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/26] target/arm/tcg: Reduce 'helper-m.h.inc' inclusion
Date: Sun, 11 Jun 2023 10:58:42 +0200
Message-Id: <20230611085846.21415-23-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Instead of including helper-m.h.inc via helper.h which is
included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 2 --
 target/arm/tcg/m_helper.c         | 4 ++++
 target/arm/tcg/translate-m-nocp.c | 6 ++++++
 target/arm/tcg/translate-vfp.c    | 4 ++++
 target/arm/tcg/translate.c        | 5 +++++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 05117934f3..37f9879b95 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -521,5 +521,3 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
-
-#include "tcg/helper-m.h.inc"
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 0780bb3dea..45568d96bb 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -21,6 +21,10 @@
 #include "hw/intc/armv7m_nvic.h"
 #endif
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-proto.h.inc"
+#undef  HELPER_H
+
 static void v7m_msr_xpsr(CPUARMState *env, uint32_t mask,
                          uint32_t reg, uint32_t val)
 {
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 7343945b41..ee9c296a98 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -25,6 +25,12 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 /* Include the generated decoder */
 #include "decode-m-nocp.c.inc"
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 10d4502239..7d36a06726 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -24,6 +24,10 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "tcg/helper-vfp.h.inc"
 #include "exec/helper-proto.h.inc"
 #include "exec/helper-gen.h.inc"
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index d88b355230..0e692f45f8 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -37,6 +37,11 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
+#define HELPER_H "tcg/helper-m.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
+
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
-- 
2.38.1


