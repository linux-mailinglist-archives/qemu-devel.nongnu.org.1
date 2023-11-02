Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E096F7DEA42
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:41:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcZ-0008IP-IA; Wed, 01 Nov 2023 21:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbH-0006d2-Rj
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbE-00029p-31
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so3239085ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888859; x=1699493659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAOg6fl3cxRolbZZTtfnbVT8Mh+MYrIU1+C7rjgT91E=;
 b=E9zn6Oxe18XpepQhqcO9gQu0vwfgoLIAnmk2mX633XXsxW9s20q7fyeDDBu2Ftv3Wd
 e3Kaf2dCNc5BlLLolq2c/CqGu5Pw2b7A55PqIqo1LTmQ+xfgQZxQfyxtVvf3ibyqh7Uf
 l23N+pedhs/oiHcYfRvH10mTkR+GGj6RRQwvs41S9ghjS64jkCdGBNDkqvjIAgIlKIpv
 knV5bxQywvzzTDHMBBgFRZrcps3hJCgza7QQnwlA4k6cxClqcAqFTFvopPon0BJKwsVA
 djHYCFg/w5DJzA7nXmZ0cvVsULlozSV3g8yrPdsP03Pa6ecm04u59Sw6022LcWTVv+MC
 TtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888859; x=1699493659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAOg6fl3cxRolbZZTtfnbVT8Mh+MYrIU1+C7rjgT91E=;
 b=XGyqsjiyJh9QX7ahyfujXcGf2c+0+6Yr8lDUBZo+Kovll28rxWZrAgRaOXMjXhDYRv
 kTaKh7UFXj1qjLMgRkeRM5tu6Fst5iuBMVykgCVoBvPWlncYG7UOT1btzMUUPIMJSdyu
 Ik1FEfz+R9rUKTGlH10t9kXb6nhVr7LgO0vqCKBVT57rfiZQyX0tAfnHnLCudmxltvVc
 VdULARIZpU1wzB9CZbGAS3FNuu9xz0ZZ930+g1bbBMBJQWk1ACHbL0qKCAdkdscME7RL
 v+JHXCS/hIp8fgui3xgVz45lSeIV2s5rCWvzYA2Hn7BXXpqiJxCGypRMSO3mFpc4Q5Vi
 W+5A==
X-Gm-Message-State: AOJu0YxmAI0ugV1KMxVvMILLJqQvzjiPbyIMZBIo6oMK2v4quP/fv+Ct
 hSmNeBRd7Im78Ioz00L0f5tpiFuuFKjjqo29ezY=
X-Google-Smtp-Source: AGHT+IEKojz8Ino2QRErA1X5XSXTnJHoz9s6FHaA1D4QnIZwN1zE8FkjLFe824AyLOdVxIOY6WyAcQ==
X-Received: by 2002:a17:903:44d:b0:1cc:87f8:96bc with SMTP id
 iw13-20020a170903044d00b001cc87f896bcmr414186plb.15.1698888858920; 
 Wed, 01 Nov 2023 18:34:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 72/88] target/hppa: Return zero for r0 from load_gpr
Date: Wed,  1 Nov 2023 18:30:00 -0700
Message-Id: <20231102013016.369010-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5d780bcf56..3d8240ea7d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,7 @@ static void cond_free(DisasCond *cond)
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_i64 t = tcg_temp_new_i64();
-        tcg_gen_movi_i64(t, 0);
-        return t;
+        return ctx->zero;
     } else {
         return cpu_gr[reg];
     }
-- 
2.34.1


