Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40052705849
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0en-0002qH-8q; Tue, 16 May 2023 15:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cE-0000HZ-IG
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cA-0003kY-Dd
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:45 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1aaff9c93a5so433675ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266339; x=1686858339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtDld2gFk+pS05MnfqGIihYYTTfEqLTj2+RJM8YOMsA=;
 b=FTaIJf7bNpCRrBz0i6HQSxKfZPSKGA1lFQd60j0qTIIQPvklnkoWwHmWWZRuGet2XV
 Cwv1iuckqLtKhg4vJ/IO4eaw+g1KcAKcCDqS0mLji94rlNbhxP+EtSe/Y9qFpJO4jzSX
 3ACQdMn/HFwUSq+VIopmKpIdsIvRL2W6+dYrIUlCdgWAWOe1zHmm8GYCRLMHjjIxIKo5
 IO2XbeI5k/pcizPtxsGaykdPis5pMNfUDIXCGeBOis6gRs4MLHRpZEUUlTR+atK4vttp
 3urFgdSRZBKTVOJ+7/2jkN+KA/HD/dPcALF+g4GFO98UFUQ27NLmKp9nb+70Q+OCXyXH
 sqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266339; x=1686858339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtDld2gFk+pS05MnfqGIihYYTTfEqLTj2+RJM8YOMsA=;
 b=kM0kGNkXzOu7zD89RTS/zxC92BMEr4eY/K+MntH1bYSxbBlsTFqI2Ug7S7/Fp6hzSx
 W5tMI9eDWlgPZF1PkluG+ZAY6lxLXQfLwQv/+agx0TSDmswe3jTG0kKiVPwE1nDxG21D
 TRAy1JwqykjwDq4QvYWvIn2ZQKLrhpelUZeHRZV4QWhhqpOmXS3gg20+luOccEthvlaA
 FRB4QCd14zegWIcxCgVJJ7lS+ixdGDJUmF0yA8DkbGj4WUw+GIgrt1VCM1IzLce09lyL
 QkNuVyUyxkFLfJBKoS84RYx8e2aRYQTyPaSeb707+tuyoIsz8BKSkS/o+U3y+BhiFB4/
 TSeg==
X-Gm-Message-State: AC+VfDzK756xgyeJMFjI96JPZRPI0kEMYE6D5vF279ps8UJXCVUA7Xm8
 aOU0BbuWCvS7LsO/oduubNthnZT0kJmmFM+OjnE=
X-Google-Smtp-Source: ACHHUZ7ZLdsTqviLx0uG98CtEEX4UEqzC+/vQRBPWUpJ0Wngocc6vpxFMEeUxDhKy1dEKoXwoOy6SA==
X-Received: by 2002:a17:902:6ac3:b0:1ac:93ba:a5ec with SMTP id
 i3-20020a1709026ac300b001ac93baa5ecmr24773619plt.52.1684266338805; 
 Tue, 16 May 2023 12:45:38 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 58/80] tcg: Widen tcg_gen_code pc_start argument to uint64_t
Date: Tue, 16 May 2023 12:41:23 -0700
Message-Id: <20230516194145.1749305-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index f40de4177d..42a3c05607 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -852,7 +852,7 @@ void tcg_register_thread(void);
 void tcg_prologue_init(TCGContext *s);
 void tcg_func_start(TCGContext *s);
 
-int tcg_gen_code(TCGContext *s, TranslationBlock *tb, target_ulong pc_start);
+int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start);
 
 void tb_target_set_jmp_target(const TranslationBlock *, int,
                               uintptr_t, uintptr_t);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index cdd194639e..800dcba159 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5947,7 +5947,7 @@ int64_t tcg_cpu_exec_time(void)
 #endif
 
 
-int tcg_gen_code(TCGContext *s, TranslationBlock *tb, target_ulong pc_start)
+int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
 {
 #ifdef CONFIG_PROFILER
     TCGProfile *prof = &s->prof;
-- 
2.34.1


