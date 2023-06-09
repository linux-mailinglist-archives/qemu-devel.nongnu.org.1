Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26657729757
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Zeu-0001KP-J7; Fri, 09 Jun 2023 06:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zes-0001HB-Ln
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:54 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Zeq-0001Eq-IW
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:47:54 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f611ac39c5so2078646e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307670; x=1688899670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWKAibTUADLLTxJ/+sZHZAPdH6D/uto5/x3pl3Mjmng=;
 b=xMAAe5xPdJB0WKbvxeRgyFr+oP/oBwWgSJVqQ/hAI+rhg/EuJRTmPS0EPvJfeWrmiw
 DnAI3oyyvf/BNIULcCbZZnPYSS6YxtNnoAjoIOBGOr5sMp0PQ6ALSjkbUCIKHLw4zumA
 zU7ypI2BIJYxD+ePZr9rjsSeOFOSn2VUzPtto3l+y4lmurWeqaeYUxYWRACgUznxmPYY
 21XUPrLcDiRdwN155cvx8TH09tX2Jd+C62CS68OdaLAcWoGkaYFhUSj5Ff4nslFO/GPN
 wE5d102oAeIN7ewBN6I18BlqZDkTP0oLt339dXsWciJXeFKlmiNYEtbAX273Xp81yFPb
 wt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307670; x=1688899670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWKAibTUADLLTxJ/+sZHZAPdH6D/uto5/x3pl3Mjmng=;
 b=CBg5YYeHJ4f6H+y3nJDgH5k5I7fwrxoy/L8cHr93L9gaTqbfG4mq4fnvuVWHljghDH
 O9qKxj6T7Wcp2lVr3iajCelSpjFqlle8NFQIc3VXT8SbdsCia9T7c1FYNZHX/vcxK1se
 oVZSd6Zp04D0Ug1s65Z97XWgvhlzeV/cjWIvu6QQIKPeXVFrGfbplfIZh8BkXmnlXL4M
 xqfyhY/wXzMZYuRDC+31oiUDjM+HznVoQz2mxm3wDFVMXMckhrDIWpff8c6CIYrMWE/G
 m41j/VSsdu9YCSPYkA14AkAlBAWgbLhWzR7G1+PDugimQF0PBdQkGjaY+MfLa4yzTotB
 emcw==
X-Gm-Message-State: AC+VfDx5pVRaZFQzKAkn647DioqFeoTMSLMY6S+wsjsjEHqLukRp4XEc
 +zT2zsrH8PAxtsSjtNYLjxQTyh0csR8CRroB7BBaaw==
X-Google-Smtp-Source: ACHHUZ4ngZDlI4ybp8OmR7P4vzVMwktQkHlepivaTL5E5yN7qVb6WrqH5/sfD+ulM3W9wDqGQ/l3Sg==
X-Received: by 2002:a05:6512:461:b0:4f3:b6b8:dabb with SMTP id
 x1-20020a056512046100b004f3b6b8dabbmr754595lfd.13.1686307670252; 
 Fri, 09 Jun 2023 03:47:50 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a1cf619000000b003f7f52c9988sm2317463wmc.21.2023.06.09.03.47.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:47:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/22] target/arm/tcg: Extract iwMMXt helpers from the generic
 'helper.h'
Date: Fri,  9 Jun 2023 12:47:00 +0200
Message-Id: <20230609104717.95555-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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
 target/arm/helper.h                |  96 +-----------------------
 target/arm/tcg/helper-iwmmxt.h.inc | 114 +++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 95 deletions(-)
 create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 4218d98b51..c4a321c0ea 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -445,101 +445,6 @@ DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, ptr)
 DEF_HELPER_3(neon_acge_f64, i64, i64, i64, ptr)
 DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, ptr)
 
-/* iwmmxt_helper.c */
-DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_madduq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadb, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulslw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulshw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mululw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_muluhw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macsw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macuw, i64, i64, i64)
-DEF_HELPER_1(iwmmxt_setpsr_nz, i32, i64)
-
-#define DEF_IWMMXT_HELPER_SIZE_ENV(name) \
-DEF_HELPER_3(iwmmxt_##name##b, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##w, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##l, i64, env, i64, i64) \
-
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackl)
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackh)
-
-DEF_HELPER_2(iwmmxt_unpacklub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackluw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhuw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsl, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsl, i64, env, i64)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpeq)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgtu)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgts)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(mins)
-DEF_IWMMXT_HELPER_SIZE_ENV(minu)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxs)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxu)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(subn)
-DEF_IWMMXT_HELPER_SIZE_ENV(addn)
-DEF_IWMMXT_HELPER_SIZE_ENV(subu)
-DEF_IWMMXT_HELPER_SIZE_ENV(addu)
-DEF_IWMMXT_HELPER_SIZE_ENV(subs)
-DEF_IWMMXT_HELPER_SIZE_ENV(adds)
-
-DEF_HELPER_3(iwmmxt_avgb0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgb1, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw1, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_align, i64, i64, i64, i32)
-DEF_HELPER_4(iwmmxt_insr, i64, i64, i32, i32, i32)
-
-DEF_HELPER_1(iwmmxt_bcstb, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstw, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstl, i64, i32)
-
-DEF_HELPER_1(iwmmxt_addcb, i64, i64)
-DEF_HELPER_1(iwmmxt_addcw, i64, i64)
-DEF_HELPER_1(iwmmxt_addcl, i64, i64)
-
-DEF_HELPER_1(iwmmxt_msbb, i32, i64)
-DEF_HELPER_1(iwmmxt_msbw, i32, i64)
-DEF_HELPER_1(iwmmxt_msbl, i32, i64)
-
-DEF_HELPER_3(iwmmxt_srlw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srlq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_slll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sral, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorl, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_shufh, i64, env, i64, i32)
-
-DEF_HELPER_3(iwmmxt_packuw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packul, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packuq, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsl, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsq, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_muladdsl, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdsw, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdswl, i64, i64, i32, i32)
-
 DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
@@ -1044,4 +949,5 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
+#include "tcg/helper-iwmmxt.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/helper-iwmmxt.h.inc b/target/arm/tcg/helper-iwmmxt.h.inc
new file mode 100644
index 0000000000..b464290545
--- /dev/null
+++ b/target/arm/tcg/helper-iwmmxt.h.inc
@@ -0,0 +1,114 @@
+/*
+ *  XScale iwMMXt specific helper definitions
+ *
+ * Copyright (c) 2007 OpenedHand, Ltd.
+ * Written by Andrzej Zaborowski <andrew@openedhand.com>
+ * Copyright (c) 2008 CodeSourcery
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_madduq, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_sadb, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_sadw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_mulslw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_mulshw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_mululw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_muluhw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_macsw, i64, i64, i64)
+DEF_HELPER_2(iwmmxt_macuw, i64, i64, i64)
+DEF_HELPER_1(iwmmxt_setpsr_nz, i32, i64)
+
+#define DEF_IWMMXT_HELPER_SIZE_ENV(name) \
+DEF_HELPER_3(iwmmxt_##name##b, i64, env, i64, i64) \
+DEF_HELPER_3(iwmmxt_##name##w, i64, env, i64, i64) \
+DEF_HELPER_3(iwmmxt_##name##l, i64, env, i64, i64) \
+
+DEF_IWMMXT_HELPER_SIZE_ENV(unpackl)
+DEF_IWMMXT_HELPER_SIZE_ENV(unpackh)
+
+DEF_HELPER_2(iwmmxt_unpacklub, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackluw, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpacklul, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhub, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhuw, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhul, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpacklsb, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpacklsw, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpacklsl, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhsb, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhsw, i64, env, i64)
+DEF_HELPER_2(iwmmxt_unpackhsl, i64, env, i64)
+
+DEF_IWMMXT_HELPER_SIZE_ENV(cmpeq)
+DEF_IWMMXT_HELPER_SIZE_ENV(cmpgtu)
+DEF_IWMMXT_HELPER_SIZE_ENV(cmpgts)
+
+DEF_IWMMXT_HELPER_SIZE_ENV(mins)
+DEF_IWMMXT_HELPER_SIZE_ENV(minu)
+DEF_IWMMXT_HELPER_SIZE_ENV(maxs)
+DEF_IWMMXT_HELPER_SIZE_ENV(maxu)
+
+DEF_IWMMXT_HELPER_SIZE_ENV(subn)
+DEF_IWMMXT_HELPER_SIZE_ENV(addn)
+DEF_IWMMXT_HELPER_SIZE_ENV(subu)
+DEF_IWMMXT_HELPER_SIZE_ENV(addu)
+DEF_IWMMXT_HELPER_SIZE_ENV(subs)
+DEF_IWMMXT_HELPER_SIZE_ENV(adds)
+
+DEF_HELPER_3(iwmmxt_avgb0, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_avgb1, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_avgw0, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_avgw1, i64, env, i64, i64)
+
+DEF_HELPER_3(iwmmxt_align, i64, i64, i64, i32)
+DEF_HELPER_4(iwmmxt_insr, i64, i64, i32, i32, i32)
+
+DEF_HELPER_1(iwmmxt_bcstb, i64, i32)
+DEF_HELPER_1(iwmmxt_bcstw, i64, i32)
+DEF_HELPER_1(iwmmxt_bcstl, i64, i32)
+
+DEF_HELPER_1(iwmmxt_addcb, i64, i64)
+DEF_HELPER_1(iwmmxt_addcw, i64, i64)
+DEF_HELPER_1(iwmmxt_addcl, i64, i64)
+
+DEF_HELPER_1(iwmmxt_msbb, i32, i64)
+DEF_HELPER_1(iwmmxt_msbw, i32, i64)
+DEF_HELPER_1(iwmmxt_msbl, i32, i64)
+
+DEF_HELPER_3(iwmmxt_srlw, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_srll, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_srlq, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_sllw, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_slll, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_sllq, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_sraw, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_sral, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_sraq, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_rorw, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_rorl, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_rorq, i64, env, i64, i32)
+DEF_HELPER_3(iwmmxt_shufh, i64, env, i64, i32)
+
+DEF_HELPER_3(iwmmxt_packuw, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_packul, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_packuq, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_packsw, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_packsl, i64, env, i64, i64)
+DEF_HELPER_3(iwmmxt_packsq, i64, env, i64, i64)
+
+DEF_HELPER_3(iwmmxt_muladdsl, i64, i64, i32, i32)
+DEF_HELPER_3(iwmmxt_muladdsw, i64, i64, i32, i32)
+DEF_HELPER_3(iwmmxt_muladdswl, i64, i64, i32, i32)
-- 
2.38.1


