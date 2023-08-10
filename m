Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A3F776E20
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 04:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTvWq-0000zW-3W; Wed, 09 Aug 2023 22:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWj-0000uY-RH
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTvWi-0004x8-7U
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 22:35:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so370698b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691634951; x=1692239751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phrIw6b5pWNBBmVHR2P9mXRKZKLN/f9yT3V1nvx09pc=;
 b=hetcGLSTvMBODJofQGfMVBISegsvqZdiKKEbSfvqqqx+d99tfCCDuaJWnrsG3hV+gX
 HeX00d8gGHe9ieeT8E3SnzLZiy0K+JL/Vf3EN5EDq1i9CFp1PrEhJ4mVePQ9vO1g7tbZ
 herQk+zbXxrFUzSytvWYr3gFniGDMuDmXW9GFngAh3r5ExlIX7IiyEzofpDk4+ypzfkG
 KX43SBIB+cpGu/HC3yzMxaRaVi3mlnug36VLLig+Q2A0/ZwpQ4O0Q3l5uU5e7AY6RIBV
 PimncngeezMtCofNYYrpyqc49LtO1xjVFWkcLo7R5y/t1KpFpCsRx8Pmrkj6MbxU2VzH
 H8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691634951; x=1692239751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phrIw6b5pWNBBmVHR2P9mXRKZKLN/f9yT3V1nvx09pc=;
 b=AX2PWhf1ZTgUn9kSAckmH1NH+NXZnNCvlHfSG1XupyLA+n8YSU3xWhi7wcd1/93wAN
 5IP9RHb8K0K9q90ZPn5rFQs+7dzyBw11QbKQvu212g+jOD3tuVGWbwbgLSb/Lwosbpk8
 4DCM1aezieTV0fYFoYztANWibmoCnsiSD5E8yJNJ1SXCTJHZIaOqwk5vsgJgfFTAKxrV
 P2oCbtGeeYLtlFTVRmUASGvffTMIcwW3COFtfoh54MrbImw4pEhp6WUf+LXsohTcteM1
 yVPNGJR84uXi8FoIp/FkJp0kCWhHxgmkUmxDha3EMaGkO9P/3qmJryzPAoP6FKFo9GSX
 eeCw==
X-Gm-Message-State: AOJu0YymsuusrddBxeddiEUJ0uAztZcyPAwt1Tf+kTAdZUpPOXotY6FX
 ncoqnP+ZnHvlmVFuEtnH+KlqB0FFTMIP4kFz0ho=
X-Google-Smtp-Source: AGHT+IEUG51SrYGxqrFVabABdMjUAcKCckHEvErqH8od8fPuYIIAMz9p2mGtyazKJ+rZO1dPB6WhDw==
X-Received: by 2002:a05:6a00:23d1:b0:687:520e:4b17 with SMTP id
 g17-20020a056a0023d100b00687520e4b17mr1382835pfc.8.1691634950943; 
 Wed, 09 Aug 2023 19:35:50 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 z7-20020aa791c7000000b0066ebaeb149dsm287283pfa.88.2023.08.09.19.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 19:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/5] target/arm: Disable FEAT_TRF in neoverse-v1
Date: Wed,  9 Aug 2023 19:35:44 -0700
Message-Id: <20230810023548.412310-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810023548.412310-1-richard.henderson@linaro.org>
References: <20230810023548.412310-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Self-hosted trace is out of scope for QEMU.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8019f00bc3..60e5f034d9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -618,7 +618,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->id_aa64afr0 = 0x00000000;
     cpu->id_aa64afr1 = 0x00000000;
-    cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
+    cpu->isar.id_aa64dfr0  = 0x000000f210305519ull; /* w/o FEAT_TRF */
     cpu->isar.id_aa64dfr1 = 0x00000000;
     cpu->isar.id_aa64isar0 = 0x1011111110212120ull; /* with FEAT_RNG */
     cpu->isar.id_aa64isar1 = 0x0111000001211032ull;
@@ -628,7 +628,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64pfr0  = 0x1101110120111112ull; /* GIC filled in later */
     cpu->isar.id_aa64pfr1  = 0x0000000000000020ull;
     cpu->id_afr0       = 0x00000000;
-    cpu->isar.id_dfr0  = 0x15011099;
+    cpu->isar.id_dfr0  = 0x05011099; /* w/o FEAT_TRF */
     cpu->isar.id_isar0 = 0x02101110;
     cpu->isar.id_isar1 = 0x13112111;
     cpu->isar.id_isar2 = 0x21232042;
-- 
2.34.1


