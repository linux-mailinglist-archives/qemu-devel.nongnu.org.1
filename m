Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDC816C47
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:34:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsB-0006gg-3z; Mon, 18 Dec 2023 06:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs8-0006e1-Bh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs2-0003JD-RG
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:20 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d12b56a38so17124165e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899192; x=1703503992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gThDCBT1NLIns1yMSSTDgKj1hf4iO2zsqHlQHQg2dD0=;
 b=EobsDH453GwtUpWwiFLUjKldhTjHXn8VtQP50zzFbwNjeY2vKlBH8pd9j5MMkrl+W1
 lBLuBHhA1D2Z1h1sGKUEi+gYvKmV4Xo8GJbtnmsuu6wGE9EFjDnmbiQ3bdNvC/KEC/L9
 08LDlP0FUXCXMxCCsnD7K5qae0r98RO/atr9VN2cJq8itR2Cv50/1FDESFt8J4GXF94J
 U8hly7vRmrncbhnKI51xF6iDdzwV0xKpn1QEgZAif/Zq8TlfC5cr9AKpuUhqopfewFmb
 AUO6K0DoQyRrQm0bqB2kraeP8VvAJq/VjV2oXAgyDdPGx68MjH6YCSZ6xuoiIFM7SvXJ
 9GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899192; x=1703503992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gThDCBT1NLIns1yMSSTDgKj1hf4iO2zsqHlQHQg2dD0=;
 b=Z6PA+qRR5qJODyNqpLtRtxFWnLM5dxnZnBSVHWKnbopZEi3e6o/+/QusoKpNoHV/4z
 Nx1lfm7A7uRaDgBTJcOWJfpSNMq4xQQlABfdtReFTuBmiAasvR07MbAwVZBDJd0yqHl7
 uw1yxEjo4BrYrzv09ij0hiBmY7Osv2BVJHjVVbVpdIdStMG1ESDQesJJgIQg+XEGedLe
 oWU86ogzYbIA9vbiFS1nPmMdKVC6i9nLoNlNnrNTyrvMdz0Rf7PrEn/gwiYyvbpJ0Btu
 Y6X1/afKLjbgv2++YkLTySylrnHz6Xej1Vh0wMaljSAOUR3hqEnAyDuJtVkCn+Zfu3qn
 pjQw==
X-Gm-Message-State: AOJu0YyxYiVE5EQq7YeP6WKtIdF2imVp39ECFUkrvXPzFeOwIUm/Acau
 woL2pJpBNMISGM5BULGFa+zxpsqHnKZgwTrMlWA=
X-Google-Smtp-Source: AGHT+IH+CmCh6e1xz+Lr/IPBjOLPnw1CGQOntUYnyrU7nBuV1CPD9MNieMnh0gcC983rmZIVPcJdKw==
X-Received: by 2002:adf:f3ca:0:b0:336:64b8:9d3c with SMTP id
 g10-20020adff3ca000000b0033664b89d3cmr502236wrp.67.1702899192343; 
 Mon, 18 Dec 2023 03:33:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/35] target/arm: Move FPU/SVE/SME access checks up above
 ARM_CP_SPECIAL_MASK check
Date: Mon, 18 Dec 2023 11:32:42 +0000
Message-Id: <20231218113305.2511480-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In handle_sys() we don't do the check for whether the register is
marked as needing an FPU/SVE/SME access check until after we've
handled the special cases covered by ARM_CP_SPECIAL_MASK.  This is
conceptually the wrong way around, because if for example we happen
to implement an FPU-access-checked register as ARM_CP_NOP, we should
do the access check first.

Move the access checks up so they are with all the other access
checks, not sandwiched between the special-case read/write handling
and the normal-case read/write handling. This doesn't change
behaviour at the moment, because we happen not to define any
cpregs with both ARM_CPU_{FPU,SVE,SME} and one of the cases
dealt with by ARM_CP_SPECIAL_MASK.

Moving this code also means we have the correct place to put the
FEAT_NV/FEAT_NV2 access handling, which should come after the access
checks and before we try to do any read/write action.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 00d12e148ca..2d26cb6210f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2189,6 +2189,14 @@ static void handle_sys(DisasContext *s, bool isread,
         gen_a64_update_pc(s, 0);
     }
 
+    if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
+        return;
+    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
+        return;
+    } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
+        return;
+    }
+
     /* Handle special cases first */
     switch (ri->type & ARM_CP_SPECIAL_MASK) {
     case 0:
@@ -2267,13 +2275,6 @@ static void handle_sys(DisasContext *s, bool isread,
     default:
         g_assert_not_reached();
     }
-    if ((ri->type & ARM_CP_FPU) && !fp_access_check_only(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SVE) && !sve_access_check(s)) {
-        return;
-    } else if ((ri->type & ARM_CP_SME) && !sme_access_check(s)) {
-        return;
-    }
 
     if (ri->type & ARM_CP_IO) {
         /* I/O operations must end the TB here (whether read or write) */
-- 
2.34.1


