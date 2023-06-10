Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642872ABB3
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yht-0004zs-Dy; Sat, 10 Jun 2023 09:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhp-0004x9-06; Sat, 10 Jun 2023 09:32:38 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhn-0007hn-Ew; Sat, 10 Jun 2023 09:32:36 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-38e04d1b2b4so1145056b6e.3; 
 Sat, 10 Jun 2023 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403954; x=1688995954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BanqkVFMg9yncGo4DeOmhBFlNLXn/JOVG8Bvg2cvUk=;
 b=qt9MIuFDxZA39H8QgEh2JNA5vPBfIlo9mH9qpcIpd1OJsvb5+FBPhksuY2MVBjX+KD
 YYyAaRaYZ7X2j3xQGwVwDfvc/zTBvXxeqpkBDFNZPmhBl42p2+6dLWXODp51SuxUrEhI
 w9cHvZb0/4jzCgDpHmSB1gTS6+Sbdd8wa2bQjISQPwHMwA2EWsJGaw7M/zhNY93xBRg/
 plQAM9B6zlNPJJ76A/m9haSFUjSHHFgbeXx5wvY4uKUrvNJlRy3JQXQArh4WwrmnTluz
 GCKbfNJAG4PECrL40Whr4at6rFyEj3Dpjn9JGQD0IAdlfBjpPOba5NztpYKyTws9Sy9k
 Lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403954; x=1688995954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BanqkVFMg9yncGo4DeOmhBFlNLXn/JOVG8Bvg2cvUk=;
 b=Ecs1kCSDGta9I7++lCKURw0o7v55vS68+UdDHNiK5svZllUVYYPKSL0VrH2MP5UBS5
 nmPnTsVhIdwhyN+/PQln0wrIf73e+77Jhn9zf26x0slW9Nr5HGx8KiM5CSsLCSMS2euu
 AnvIR40CQa84pGClEeI/xUwJG9gccIoESooI1GBq9P85WMAUttJm5+Wo1MP2id1s3AoM
 7e6HoFltwjFiIE3xbrN2K+sEK+oPVRJeDRLZuxrKHDam7RHdPcy+aOjbC74uydKP1dFD
 1oD6xFOWmLLB4qweMzJ77fXstzQHY8TY6TRoxn64gXN2K9bMwqDV0snDH1M09vqlHnPE
 +fgw==
X-Gm-Message-State: AC+VfDwEf0KtqFqPUoGcvMq/ZW/W7T+3eTX9ZaoCodrRelXUvw+9JF6N
 WTO5KC8phlqVy7izzplqhnT7hKZrtWA=
X-Google-Smtp-Source: ACHHUZ46KQVrp4FTwJ25sW4Q4oRYDn+CvNiAolPjCHzQy6iavgGaUEZQcdzkq2ypOdnd0O2lA0DdPA==
X-Received: by 2002:a05:6808:1382:b0:398:4465:ed25 with SMTP id
 c2-20020a056808138200b003984465ed25mr1206368oiw.37.1686403953735; 
 Sat, 10 Jun 2023 06:32:33 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:33 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 22/29] target/ppc: Remove larx/stcx. memory barrier semantics
Date: Sat, 10 Jun 2023 10:31:25 -0300
Message-Id: <20230610133132.290703-23-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

larx and stcx. are not defined to order any memory operations.
Remove the barriers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230605025445.161932-3-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cf0bd79b8c..cb4764476d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3476,7 +3476,6 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     tcg_gen_mov_tl(cpu_reserve, t0);
     tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
 
 #define LARX(name, memop)                  \
@@ -3720,11 +3719,6 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 
     gen_set_label(l1);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(l2);
@@ -3828,11 +3822,6 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_br(lab_over);
     gen_set_label(lab_fail);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(lab_over);
-- 
2.40.1


