Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A0781548
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iw-0004yO-4i; Fri, 18 Aug 2023 18:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7it-0004wZ-MI
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ir-0004NY-F3
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso10901115ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396816; x=1693001616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tLG8/XHxQLwSuertWPZX823LWYyhiS+FEGkrYeTEgw=;
 b=ZmP06Wd+ePylm1HjV+TG70o9WYnVbq+EjDnGpksYfN/KsUEQ/tto6Jgu9s/MNRnCr8
 GYMfFbgwhwhhz/t6Z77zTikzTVX71AgiB72N8SqsoiI4ZyWamRSkz7CrrDdMk2rcERHS
 sGQH+Brg07QhvdA4fuizh92htLaGwl+2e1oBmKulHh0GuhLvUGe0B/5j5weMePjlMigi
 cHfpaw7qPjFWh6jWYFCudX7gaPLbAm/ijo8Nn2b+ucNt4E2uk+tV+1BXplueiSax9kqi
 pCNPUhNK/83I2K6zAw2kxC5G8efrS+LQoxWZwZEhc9INT8nTCFz4V26MdYtRINp27jK5
 BdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396816; x=1693001616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tLG8/XHxQLwSuertWPZX823LWYyhiS+FEGkrYeTEgw=;
 b=l/OoNv1MZf5OhfoCwaIvcU+puJ8U57YznRFk862bW1MedZ7vQ/ZWPPzpO1IjpNzihZ
 Nw+QiA9J41b3jVMbI/88OjC+6NlDulSxgpZyxlVVj5Zyq9ir4qs8gD3K1298IMdpBsxJ
 zZSMvyiMGQLOwj7qbsc44zjMyDVaoboXNAR4DvwcqpXvG19ZrFy3dJecvmD9NFKqrN28
 vnBA0i7vtP5MLVICxbxyELMHo6ofrAe8mkQ6vdhUTXtEZMnZEgSjn2DiTUGdCeglLJV7
 Tdm0rlHA3WjVfTqxo1la5QmXtQ23/1P0skOcoj2JIqa542JKe6EuH9Sjtc/CLL/jzIES
 W1BA==
X-Gm-Message-State: AOJu0Yy16nqHoClsCICZw7flsjIElIQbf1LNgh2l6O0Haw0svjGhL5Qs
 IWhP9wJ6zXPvMWY5KAD5a/rHL7qXoh6EwR24A+8=
X-Google-Smtp-Source: AGHT+IFAvnRc00MpDmbaIlaIwzgEdKoN2Trj7POx0VJPYx4iMBpfjB7jRJRgIJM/MtKY76X5zMNMgQ==
X-Received: by 2002:a17:902:bf46:b0:1bd:bba1:be7b with SMTP id
 u6-20020a170902bf4600b001bdbba1be7bmr504517pls.39.1692396816061; 
 Fri, 18 Aug 2023 15:13:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 08/23] target/sparc: Use tcg_gen_movcond_i64 in gen_edge
Date: Fri, 18 Aug 2023 15:13:12 -0700
Message-Id: <20230818221327.150194-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

The setcond + neg + or sequence is a complex method of
performing a conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index bd877a5e4a..fa80a91161 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2916,7 +2916,7 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
 
     tcg_gen_shr_tl(lo1, tcg_constant_tl(tabl), lo1);
     tcg_gen_shr_tl(lo2, tcg_constant_tl(tabr), lo2);
-    tcg_gen_andi_tl(dst, lo1, omask);
+    tcg_gen_andi_tl(lo1, lo1, omask);
     tcg_gen_andi_tl(lo2, lo2, omask);
 
     amask = -8;
@@ -2926,18 +2926,9 @@ static void gen_edge(DisasContext *dc, TCGv dst, TCGv s1, TCGv s2,
     tcg_gen_andi_tl(s1, s1, amask);
     tcg_gen_andi_tl(s2, s2, amask);
 
-    /* We want to compute
-        dst = (s1 == s2 ? lo1 : lo1 & lo2).
-       We've already done dst = lo1, so this reduces to
-        dst &= (s1 == s2 ? -1 : lo2)
-       Which we perform by
-        lo2 |= -(s1 == s2)
-        dst &= lo2
-    */
-    tcg_gen_setcond_tl(TCG_COND_EQ, lo1, s1, s2);
-    tcg_gen_neg_tl(lo1, lo1);
-    tcg_gen_or_tl(lo2, lo2, lo1);
-    tcg_gen_and_tl(dst, dst, lo2);
+    /* Compute dst = (s1 == s2 ? lo1 : lo1 & lo2). */
+    tcg_gen_and_tl(lo2, lo2, lo1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, dst, s1, s2, lo1, lo2);
 }
 
 static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-- 
2.34.1


