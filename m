Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F07DDBCE
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2aB-0005xv-19; Wed, 01 Nov 2023 00:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a2-0005vh-5C
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:46 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2a0-0007Yk-LY
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:45 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2ea7cc821so4337562b6e.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811903; x=1699416703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHAd8J1EO3gqRG1PwwkBxS4ZKXQX1Vw7TjDE0ZA1Du0=;
 b=eEaLcZwIPnAbfl7vKKzSSngVTE+UexnX577FgYu2N0apBQ6lLfOFgBEJa4H7EOtWvI
 9DlpwTKBGWmg0T0xxzGLFAT4wQhL3eNacCWFArlj/NsgvxAJe+UOgrnMVMBmxvbEG6MT
 hAHID9mfP2GYZt4w5mDvPPXxr89RCGEJjDmrjmgc4GfTt9qC5R8cfmEdRvvKKppBv1t4
 bYEnYnI6GzF2Jp827oPfE0gua4y0eWx9d497yD/HAcr1raw+EqTOpBSr7oV8bVV5/pP6
 TBz/7p4tR4u+z8bvsblTn3IfnF3r6yzrz/L1KBRUG2s14Owpc9K6pRNm7xji5AF6Eyns
 uuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811903; x=1699416703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHAd8J1EO3gqRG1PwwkBxS4ZKXQX1Vw7TjDE0ZA1Du0=;
 b=HiP3oqCP3mWn6plyDf4deRpn63LoGn9lQF3omvn983jqkS/uA4YF3xeZopPtClPKJg
 7p9EuXYXdQwx+1uwrhw36zWa87fnW2EoeGo0QmWhu0zcWlOJDHiI5CtdBUYUNuprMeNo
 BR5iw3fr4rL4ZmBuy+1eMOFq5wwshjfxEl7qD5NIIccCVQUu1uZ/Qjyb1L2oA0jmfGyz
 /PWWu3TLDInoTZSu6sB6Tygqgj8xEZ1e95nZ6h3DW4cOHWzkcG4sbqWopgHJZtJylR3C
 NHjMj0CaCxR4zGP54vXIox8Y+NBqQHpFa8hsZoxxHzeWuXlyZ93w5/UhqvxNSP1ie1dn
 V/gA==
X-Gm-Message-State: AOJu0Yw1cvJ9J+uZ/DeMOZcaUhSZWSkzgasqWl9f5SRl4Yd1rZ6McoLv
 0vG+DhfGFUVgeLRJDMfaPc4j/fKA1UISRkLwdvQ=
X-Google-Smtp-Source: AGHT+IHYwA0c2uP3W1rNA5/nseP97Yr8/Uib5lyp4HSKWle0wzKEZ4iMf1/pErNCRfU3JKFW2lHO+A==
X-Received: by 2002:a05:6808:6381:b0:3ae:5442:ed11 with SMTP id
 ec1-20020a056808638100b003ae5442ed11mr15449065oib.54.1698811903643; 
 Tue, 31 Oct 2023 21:11:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 11/21] target/sparc: Always copy conditions into a new
 temporary
Date: Tue, 31 Oct 2023 21:11:22 -0700
Message-Id: <20231101041132.174501-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

This will allow the condition to live across changes to
the global cc variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a405512e6c..dd6d43d1f1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1226,8 +1226,9 @@ static const TCGCond gen_tcg_cond_reg[8] = {
 static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 {
     cmp->cond = tcg_invert_cond(gen_tcg_cond_reg[cond]);
-    cmp->c1 = r_src;
+    cmp->c1 = tcg_temp_new();
     cmp->c2 = 0;
+    tcg_gen_mov_tl(cmp->c1, r_src);
 }
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
-- 
2.34.1


