Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70992729780
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 12:50:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ZfX-0002MD-BN; Fri, 09 Jun 2023 06:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZfN-00022V-79
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:26 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7ZfJ-0001UK-LR
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 06:48:23 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f629ccb8ebso1966772e87.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686307700; x=1688899700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQVMFnSnRrSFcc+z/a3bT1hs0FZjoEq6vgTJcq2cEQg=;
 b=aIF4Vggr0VNHn+dp5UpfCOe0Nk/9qT7lHn/Jr1jmqrDzC671Onhs2c/GiHvVw7LZ+W
 U4lFiIdaPFXd7mvgkO3ltqmlqMSwX7n6TExOwNQ6ctzu5+Oq2lSBBeb4jMe7cVO+KlG2
 1BpiigsBkfKrn3c4tfEb/0cVwrSmDapC9zq1yMU4mU0gaPEN5rK35qUMkpMmAh3DHRco
 qbRlBJubda7JxEe8Z4tBZZQzznqq9pDTb1vqd2kgOWPah83aPwMldASgvID7uNKEs9mz
 nNWcVsaV0juxJ7MzAyf2c99MTgA6WAhg77rCEJeT1sdiRpDXeg4Iuo4OYf6fIZXs0osQ
 Oxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686307700; x=1688899700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQVMFnSnRrSFcc+z/a3bT1hs0FZjoEq6vgTJcq2cEQg=;
 b=VnCYGDaVfo7Qn1Z8xPsKK/ve/kpU6jDNjqO/W2fBhBigGVjmBiHN/5uRuZle3e4XQY
 tp/h7w5+SzhVhdSiSv6FaUla1eB/7wUFDVIif50YTWcilan5JfBbXV/Aqe1D+VWRPG9/
 AEGwNVvLtZQZlt9Ht/EgW29LLsuBFkms+x57w5rknkJKmn+qf9c00O4I5CRsFdj+e1xi
 sRK7P0DB6NjVHuT2hWK6h/Cper8K9EorLzjmxkHr1Ecpm5qgt4IPZIeNOlfZjheEz4bJ
 XmVFyiNsBI7MO7zcLVJONIMCsyHoH85SG91uGvvzqKvgWyWs9AaDdPHihayHzoJ9xJqY
 AWLg==
X-Gm-Message-State: AC+VfDz/plsNMgkJHxUBveJoqLHaaFsOfpCH0yTlqc7YGv76YKLgHrtT
 IJ5oturWYFqGCaD52rTbY/eapD0fNSosfPlRpYkg5A==
X-Google-Smtp-Source: ACHHUZ6F60lXjpQQHtY/YyHeL4Hh0AssuCjhGeMU0q0/W7s7Jm20v9BkViExJuI+W05AahoIUyFx9A==
X-Received: by 2002:a19:674d:0:b0:4f6:43cc:5857 with SMTP id
 e13-20020a19674d000000b004f643cc5857mr643148lfj.19.1686307699785; 
 Fri, 09 Jun 2023 03:48:19 -0700 (PDT)
Received: from localhost.localdomain (23.171.88.92.rev.sfr.net. [92.88.171.23])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c204700b003f7a562ff31sm2325064wmg.6.2023.06.09.03.48.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jun 2023 03:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/22] target/arm/tcg: Reduce 'helper-iwmmxt.h.inc' inclusion
Date: Fri,  9 Jun 2023 12:47:04 +0200
Message-Id: <20230609104717.95555-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230609104717.95555-1-philmd@linaro.org>
References: <20230609104717.95555-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

Instead of including helper-iwmmxt.h.inc via helper.h which
is included by all TCG files, restrict it to the few files
that require it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h               | 1 -
 target/arm/tcg/iwmmxt_helper.c    | 6 +++++-
 target/arm/tcg/translate-iwmmxt.c | 6 ++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index c4a321c0ea..dd12fee107 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -949,5 +949,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
 #include "tcg/helper-sme.h.inc"
 #endif
 
-#include "tcg/helper-iwmmxt.h.inc"
 #include "tcg/helper-mve.h.inc"
diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
index 610b1b2103..fa84b5f672 100644
--- a/target/arm/tcg/iwmmxt_helper.c
+++ b/target/arm/tcg/iwmmxt_helper.c
@@ -22,7 +22,11 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "exec/helper-proto.h"
+
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 /* iwMMXt macros extracted from GNU gdb.  */
 
diff --git a/target/arm/tcg/translate-iwmmxt.c b/target/arm/tcg/translate-iwmmxt.c
index a054064c98..d241f64835 100644
--- a/target/arm/tcg/translate-iwmmxt.c
+++ b/target/arm/tcg/translate-iwmmxt.c
@@ -21,6 +21,12 @@
 #include "translate.h"
 #include "translate-a32.h"
 
+#define HELPER_H "tcg/helper-iwmmxt.h.inc"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#include "exec/helper-info.c.inc"
+#undef  HELPER_H
+
 #define ARM_CP_RW_BIT   (1 << 20)
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
-- 
2.38.1


