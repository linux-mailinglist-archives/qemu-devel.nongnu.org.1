Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FA7057BF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yd-0006e0-AF; Tue, 16 May 2023 15:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Ya-0006cz-1v
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YY-0002jf-40
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-643a1fed360so9087809b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266117; x=1686858117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WjHj7SEbww3DXTRNkJQIziiBJKKRW1RlTjQnuos+9yc=;
 b=KsiVpDJYD8d/RF/XrK5LWLpzgDuo7ljc4I+V7F2FZvX8E55ib6eiM61CFVukCliHUK
 qvtOimiXk25FcsAtWR3f8t7B/+aJzObJzNieC/HmodK6vJ0Ze7dZql9uce9PGr0n+Wyi
 qbr1eURBiJyEBAGaFkRwOsm62VkREDSP/6i/nGvXNlZxdc01xl3VUvcx2DWIKYJ4gFm+
 ulc3NRLrqP9j1KZeqJ7/Ew2rgrCSVTRK+eFj3dSioTBxenqv3Ael+UMVcNgB2ZrQmMmq
 HzSrAkXdXFllKmqABWniSuOfEluWPqguzlB2MhbE4qnYovgCfGtrKf36ojmyO50ueYyU
 QoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266117; x=1686858117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjHj7SEbww3DXTRNkJQIziiBJKKRW1RlTjQnuos+9yc=;
 b=PhYHQeCMw9WCcYuHiQ+ZkaYVt5bt0CAybPpGzZ41lciLpKhzN8ReQM7F16M+RE4Fgy
 QuN78ZHB6Z8XHcpmycW6zznYUp5tbRXwuG4XgvtTH0KFr8ThLnzWalit/6SgROEj1UII
 4N0izG0vybqPdh496Ey4hheF1KSV5eVvwN/OtCSwUwyjpBoqk94NvYTTe4QkdYFB+KbH
 HdR8aPF0PpRajD/PGvzwBRQHiVWT33dZo4ozE7yKaFM3z8fmY+6uLPICx2p/IeOjSqQ4
 jcsOiyzZ0O9HsyfwJODuRoiGawocgisheXMaM+vh/YNSWTGpScdVwluN8h2+mYnWPrVk
 xeIA==
X-Gm-Message-State: AC+VfDy2My1aaC0RU602QN/d8yHRMwzyxJYiPso6eexoPXnMNz9bcZ6H
 7yEqFhTH1uxjeQW7VxsO1bv5sLN5LvGu4Y4WjSs=
X-Google-Smtp-Source: ACHHUZ4KiZV+a5ylB2oB0/a5CoIpuFboXrb/4VuSXFfb1wjEVRcXfeQ7X4DRLVDGlf9kDcpf0Gj3nQ==
X-Received: by 2002:a05:6a00:1390:b0:646:3162:31a2 with SMTP id
 t16-20020a056a00139000b00646316231a2mr41795260pfg.17.1684266117268; 
 Tue, 16 May 2023 12:41:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/80] tcg/aarch64: Detect have_lse, have_lse2 for linux
Date: Tue, 16 May 2023 12:40:36 -0700
Message-Id: <20230516194145.1749305-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Notice when the host has additional atomic instructions.
The new variables will also be used in generated code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  3 +++
 tcg/aarch64/tcg-target.c.inc | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index c0b0f614ba..3c0b0d312d 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -57,6 +57,9 @@ typedef enum {
 #define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_EVEN
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
+extern bool have_lse;
+extern bool have_lse2;
+
 /* optional instructions */
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index e6636c1f8b..fc551a3d10 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -13,6 +13,9 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 #include "qemu/bitops.h"
+#ifdef __linux__
+#include <asm/hwcap.h>
+#endif
 
 /* We're going to re-use TCGType in setting of the SF bit, which controls
    the size of the operation performed.  If we know the values match, it
@@ -71,6 +74,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
+bool have_lse;
+bool have_lse2;
+
 #define TCG_REG_TMP TCG_REG_X30
 #define TCG_VEC_TMP TCG_REG_V31
 
@@ -2899,6 +2905,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
 static void tcg_target_init(TCGContext *s)
 {
+#ifdef __linux__
+    unsigned long hwcap = qemu_getauxval(AT_HWCAP);
+    have_lse = hwcap & HWCAP_ATOMICS;
+    have_lse2 = hwcap & HWCAP_USCAT;
+#endif
+
     tcg_target_available_regs[TCG_TYPE_I32] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_I64] = 0xffffffffu;
     tcg_target_available_regs[TCG_TYPE_V64] = 0xffffffff00000000ull;
-- 
2.34.1


