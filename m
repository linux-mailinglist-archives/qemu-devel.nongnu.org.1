Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC27253AA
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 07:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6m0l-0003qU-Aq; Wed, 07 Jun 2023 01:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m0i-0003qG-Ta
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:47:09 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6m0a-0006Py-5X
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 01:47:08 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-38e04d1b2b4so5931299b6e.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686116817; x=1688708817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WHe7sC6PSzbBVXVvmOEhsfQw8NBoIdms7kVdUmUQa0=;
 b=oH7fmUiFi661eVwIwCBhLOzmznBXlf4PnY1eaqtmOl9xXzLB1et/EOdL7JObK8Ak1D
 JV8k87B8IJfsUtzOoFVG9kkp2jVs1hLp2UvAnVCBCzuuZ3yQqWS8xcAHfr5n2w/pw+yq
 hCDlgyxmHyeyY6XyxpgkZc3qhQupBLtZD3jIt/23560Wn+GEj+Oaao8Ylrallt2JXITC
 5xa5kwVhXT8e9+HvdLWp6g9dYNCt6jFWKxWaoxRyQIh3OKDTx4L6XdDZ2CrFWNPsofBj
 DI+dboTnYnsvoJRb0TI76tXpi9nHhpBvNLihDZ76o9swkCml5ttGu/Nop29FrdzDKJng
 ndHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686116818; x=1688708818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WHe7sC6PSzbBVXVvmOEhsfQw8NBoIdms7kVdUmUQa0=;
 b=kHUS3RvT5Zb67khnTM6UFIhVRfya9rholAOb/V3J5P4nHytgoftJsMqhWpR/PHivRq
 Oqb5lZebCPxXtu0A4lGIOVGX28NZcF1P9SCJBRXm+KMvE0RoBWCUeCpkKKPVOWfI9AL9
 HavBVEh0x2hg8uRmiMUGfwIF38LiZIGe477AZnkFXDksdHGAygckB1vLXFgq7UkwXQEI
 UewddnsBE+Gl7vyXL3BVVW3MwIjb5k5KdGT9s7mj+UjKVmX/8iqRoyTUYmEIja0cYDw+
 juCYUb0l0UXAyxNJqProx+aP4427gbGpdpFcW6nnmwkXZssqdOFaMFVQCtS4iSFlj097
 UEUA==
X-Gm-Message-State: AC+VfDxuW/AmELIajlqG16c4UsufTdfiwgILZzmPIsqFFegCBbkmIpOr
 jEEL7sxBtW50Y8t8gZOf6dA3Mxq1HMAlDxUfTKI=
X-Google-Smtp-Source: ACHHUZ7q1/+YqkZxhbZgVq3kS1N8iaYUUe8KiViC8Yr1Idgmo6FPbBoQpsvC3FUYvbxWNs8qgK5vNw==
X-Received: by 2002:aca:2219:0:b0:39a:a99a:2195 with SMTP id
 b25-20020aca2219000000b0039aa99a2195mr4585490oic.31.1686116817586; 
 Tue, 06 Jun 2023 22:46:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 fe16-20020a056a002f1000b0064d48d98260sm7640310pfb.156.2023.06.06.22.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 22:46:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de
Subject: [PATCH 2/2] tcg/tci: Adjust call-clobbered regs for int128_t
Date: Tue,  6 Jun 2023 22:46:54 -0700
Message-Id: <20230607054654.622010-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607054654.622010-1-richard.henderson@linaro.org>
References: <20230607054654.622010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

We require either 2 or 4 registers to hold int128_t.
Failure to do so results in a register allocation assert.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.c.inc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5b456e1277..0037f904f1 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -179,8 +179,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 }
 
 static const int tcg_target_reg_alloc_order[] = {
-    TCG_REG_R2,
-    TCG_REG_R3,
     TCG_REG_R4,
     TCG_REG_R5,
     TCG_REG_R6,
@@ -193,6 +191,9 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_R13,
     TCG_REG_R14,
     TCG_REG_R15,
+    /* Either 2 or 4 of these are call clobbered, so use them last. */
+    TCG_REG_R3,
+    TCG_REG_R2,
     TCG_REG_R1,
     TCG_REG_R0,
 };
@@ -934,11 +935,11 @@ static void tcg_target_init(TCGContext *s)
     /*
      * The interpreter "registers" are in the local stack frame and
      * cannot be clobbered by the called helper functions.  However,
-     * the interpreter assumes a 64-bit return value and assigns to
+     * the interpreter assumes a 128-bit return value and assigns to
      * the return value registers.
      */
     tcg_target_call_clobber_regs =
-        MAKE_64BIT_MASK(TCG_REG_R0, 64 / TCG_TARGET_REG_BITS);
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
 
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
-- 
2.34.1


