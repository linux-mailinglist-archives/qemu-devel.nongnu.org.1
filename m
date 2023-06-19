Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FB1735B5C
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH2m-0002va-Be; Mon, 19 Jun 2023 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2f-0002ls-K0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:46 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBH2d-000150-Gi
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:43:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f86d8a8fd4so1989487e87.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189421; x=1689781421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhArNuatDNYVRkaFGuTDa+3jxPD4OXoWAoXbKpvzLCo=;
 b=bgQjK0CexgrgZirL6E4/gCBXHpDcwnsPcjqSojdBRfW7CyTM1Y7NSwzYhaO84zuf06
 Cb4k+x9idwYra2Jr2SAgs0VKuR24v1vEGQyt/HTTznYdCg12vjxT/17o8k059QOFUTNA
 H3LcrbAkEOMo/VL2dYUO21J9Djaqy4icxKxp1QbJdXyzTiPeILcbnouWP/+dD2311s3m
 R//ovEoBtq0spmdyO8EBJuSK+xPa9NFHAR8GMtDmj13/Ooxrn+vFX17uigvmQtg3jUta
 GMtmRtBynZxRnqSp1puKG4iJ5NG+FX4WjiXdie9tTfhNldZi3UN0kM34nidULXp9D8dQ
 MXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189421; x=1689781421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhArNuatDNYVRkaFGuTDa+3jxPD4OXoWAoXbKpvzLCo=;
 b=dRdQKNxF3xh718QDvJzLujynhdzs/d7ae2uS9/xZxBkRWqUmUYsg3wTFxla+7i0PSd
 T6YWknyY/vjy+bxBa8++dtK+z0Dvlukj5uDYMecwNgEHkPa6EfBrrsxSW7X9+YWzVcTu
 4wyBrnvHuQNtnDSrUik9r/R2pTe3w1FChMYMaOeymd0TQQK0R1n4k0U+vCr5irJaCh1y
 fSiknpPNSaEfYQWmB/2tOezoktBuPEaaxeOEmiai2arhP+m6HpL6TM6JCqA2w6Vc5kHy
 A5vPo8EEmfBA9cRk4JCjNPca8JOGnCSVMKS5hpuUMBuKt2dvbzh4yDJsoixPiokiKZ+b
 yyLw==
X-Gm-Message-State: AC+VfDxVKKjaZZ1apJZuW/eGfmN0rYfbJ+g3zu2LmdYt7swd2dCzyhef
 JYaTFbnnuO7DHJ48em9N59KetX3suzHO+uMTF+lOWQ==
X-Google-Smtp-Source: ACHHUZ7xC11maWFLGmoruW6tJNKdqLdkfygTnyuaUfqgjkMM7upSgfnFNcjIo/XvMkqMZOonXQuqIA==
X-Received: by 2002:ac2:5b0c:0:b0:4f8:666b:9de8 with SMTP id
 v12-20020ac25b0c000000b004f8666b9de8mr3365417lfn.13.1687189421156; 
 Mon, 19 Jun 2023 08:43:41 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 e6-20020a05600c218600b003f9b3588192sm2002434wme.8.2023.06.19.08.43.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:43:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/34] target/arm/tcg: Extract iwMMXt helpers from the
 generic 'helper.h'
Date: Mon, 19 Jun 2023 17:42:31 +0200
Message-Id: <20230619154302.80350-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619154302.80350-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h                |  96 +--------------------------
 target/arm/tcg/helper-iwmmxt.h.inc | 103 +++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 95 deletions(-)
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
index 0000000000..955ab2365b
--- /dev/null
+++ b/target/arm/tcg/helper-iwmmxt.h.inc
@@ -0,0 +1,103 @@
+/*
+ * XScale iwMMXt specific helper definitions
+ *
+ * Copyright (c) 2007 OpenedHand, Ltd.
+ * Written by Andrzej Zaborowski <andrew@openedhand.com>
+ * Copyright (c) 2008 CodeSourcery
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
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


