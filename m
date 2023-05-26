Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A430711B12
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFF-0002Zl-1c; Thu, 25 May 2023 20:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFC-0002YO-Uy
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:46 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF8-0002A2-Mc
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:46 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so141125a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060621; x=1687652621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0AAV8qNIzM2y2qtbP5R8DqIlK8an3kV/cLXGaTOytOE=;
 b=Gd7lrdjmRVyo9O2UCPi9Z71mChg/fJ/nbl4T/7Nc3D2v7gIjtDu9/LYxECJ4kGoCBm
 IaLnM7bWAItfvzykn2elY5de/1as3Qhi+YWDlM0PvuO5H4hTgiCglgm6i0WfvHnKRcqc
 AbfI0uj6RMyGbrAQHu+61DgSj94eKjC4FkxKj5RtV8oBc/NwsvJa+isHRCrBiYEPcSgC
 SOcDX6fZ/x/GI69EvofTrvhXJfmSlMhR8HKy2KtwJR6D28hcQHe3njdO0QG3eWDsTAMp
 +DAUgaiCbbn6YIFXciKJt/mXe1RyXNondZ/MOIRaRQqgJzyIaGo6JUplJW6eiP8YqXH9
 jzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060621; x=1687652621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AAV8qNIzM2y2qtbP5R8DqIlK8an3kV/cLXGaTOytOE=;
 b=knyo8bXVIPjcjJDGm/WHNeOnk4jDsSULZsV4Dft5N47PYma2DT9r4358rHF+pASqkI
 3yOaa7oPllFehVSjsavwCJVMuaMSMyr2ote+Z1XBBidjItR4qkbtWDuTlT3oVRpFxSr8
 G4h4oDQoAW3N8xGB5s5QhZ2KrT30c+NWEkd8QHrNkYrNbvfxMKl7wZf3dLJ8zkfit/aj
 H/9DGXC+QpA4NQtUvB7S5/VBRLNO5jDOCI1DPGR/P50bf0/fLCWfk9Bm+KP24woIwu0r
 TM9fCFi2uVdp99S3LB5+t9twfwIS1kdgydI6GIkLxEe34R5zBcoYnqbRe9wsdlMy6Ibk
 YVmQ==
X-Gm-Message-State: AC+VfDzcmxNMGXeIEphLb7FWI9iPeRjYQpV1UGh5cY7aE23diZJ2Rsjo
 1R2j7EbYYwFNai+2BdbiF/3g5LsCkSbb0QtW3dw=
X-Google-Smtp-Source: ACHHUZ6jPqW4rsHsHs7qjWHuNWe5p7YX/3vsHwkKiM6ndi6yFbTQ2vgDFER5FQjv4jbXvFsqc1yLXQ==
X-Received: by 2002:a05:6a20:728f:b0:10c:b9ed:6a38 with SMTP id
 o15-20020a056a20728f00b0010cb9ed6a38mr11531391pzk.28.1685060621323; 
 Thu, 25 May 2023 17:23:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 07/16] tcg/aarch64: Reserve TCG_REG_TMP1, TCG_REG_TMP2
Date: Thu, 25 May 2023 17:23:25 -0700
Message-Id: <20230526002334.1760495-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 8996e29ca9..5e7ac6fb76 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -40,11 +40,12 @@ static const int tcg_target_reg_alloc_order[] = {
 
     TCG_REG_X8, TCG_REG_X9, TCG_REG_X10, TCG_REG_X11,
     TCG_REG_X12, TCG_REG_X13, TCG_REG_X14, TCG_REG_X15,
-    TCG_REG_X16, TCG_REG_X17,
 
     TCG_REG_X0, TCG_REG_X1, TCG_REG_X2, TCG_REG_X3,
     TCG_REG_X4, TCG_REG_X5, TCG_REG_X6, TCG_REG_X7,
 
+    /* X16 reserved as temporary */
+    /* X17 reserved as temporary */
     /* X18 reserved by system */
     /* X19 reserved for AREG0 */
     /* X29 reserved as fp */
@@ -71,7 +72,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_X0 + slot;
 }
 
-#define TCG_REG_TMP0 TCG_REG_X30
+#define TCG_REG_TMP0 TCG_REG_X16
+#define TCG_REG_TMP1 TCG_REG_X17
+#define TCG_REG_TMP2 TCG_REG_X30
 #define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
@@ -2902,6 +2905,8 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_FP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_X18); /* platform register */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP1);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP2);
     tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
 }
 
-- 
2.34.1


