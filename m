Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5467D7933
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo3B-0007Pl-Uu; Wed, 25 Oct 2023 20:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2r-00076i-Hk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:17 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2m-0004tl-Fr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c77449a6daso2337045ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279371; x=1698884171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIOAJWBVtCMbS0c4KC6cXcYTMMaXIG2tg2FWJOn2ue8=;
 b=pDmdxugLk2t8vZtSZ1t7551RxFxwfyDfhcxkGhsDokxhqbldzYp2nJcIVgeQ7xrTfH
 +ws5q0IiFVHsgX9OLJ8IFaKUxARrROwngf9nN8htr2qNldicXYpFkts04nak6kqJBfKy
 Tndp4ITroNWcrsCITpsKCmQkT50hTQ5at3UO8q6KazAc8qoB8HHDy4zmAlW0CbYepMlO
 S1JHuiS4QJaE3jGjLRPo9AnoELFS2HKroAESx6KK7yEyfYKYHi1QYCdCWzGhg5AchGTv
 yD3LqUhyRzhEZG6jhZwldmo9091S0+OtktzXp8Mm9jwTG2UwLxZFL+JD11izlROtwtv0
 XAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279371; x=1698884171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIOAJWBVtCMbS0c4KC6cXcYTMMaXIG2tg2FWJOn2ue8=;
 b=QClyZ5FOCUA9aSS/8H1xaJezTqvFcSkYZVK2CpnleBNICKdhAl5JEmDH+Uot7YbXI5
 luC2awymdztKGceE5SUlwJhaRh9fn1YyalQ3aHsYnrTIbkvkZerl/hXvhcTxKIkwqRjn
 0VdRX2tSHXF99NzuKrdqgrpO4dNlVBsk246s9OGDXvjXHRKrJ8Io1TriySwLqefKT0w3
 ZON/+uGaIvjsaQwgT3U45bdc2KC26bWYSCsL/JyV72OZYc02FHOIfwiXQyNbbmyWagzi
 YbCgTWPA2m9334z/dwINHN4ZxABcsbebWDw9BDfZ7ZHNs74PTBE4gOx3mccHXpcBgdA5
 SirA==
X-Gm-Message-State: AOJu0YxP7AqVoVxHlzdZjOwwlM+yBr8hU0uqRdmeNAMa4iMZVgUYxqlb
 Sdk5wIwul70csAwZr9//hecLVb5gjnT8o3QcG2o=
X-Google-Smtp-Source: AGHT+IHcvgoMCol3UzbToCpH4SQizYea20t7HYM4P3u9qzEQ/3W6Ep9HMeUzDxfSjYX9s95lzQL5ow==
X-Received: by 2002:a17:902:db12:b0:1c2:218c:3754 with SMTP id
 m18-20020a170902db1200b001c2218c3754mr20237530plx.53.1698279370892; 
 Wed, 25 Oct 2023 17:16:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/94] target/sparc: Merge gen_fcond with only caller
Date: Wed, 25 Oct 2023 17:14:12 -0700
Message-Id: <20231026001542.1141412-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2664db302d..b8d51d6d64 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1309,19 +1309,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
-{
-    DisasCompare cmp;
-    gen_fcompare(&cmp, cc, cond);
-
-    /* The interface is to return a boolean in r_dst.  */
-    if (cmp.is_bool) {
-        tcg_gen_mov_tl(r_dst, cmp.c1);
-    } else {
-        tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-    }
-}
-
 // Inverted logic
 static const TCGCond gen_tcg_cond_reg[8] = {
     TCG_COND_NEVER,  /* reserved */
@@ -2992,6 +2979,7 @@ TRANS(BPcc,  64, do_bpcc, a)
 static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+    DisasCompare cmp;
 
     if (gen_trap_ifnofpu(dc)) {
         return true;
@@ -3003,7 +2991,13 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
         return advance_jump_uncond_always(dc, a->a, target);
     default:
         flush_cond(dc);
-        gen_fcond(cpu_cond, a->cc, a->cond);
+
+        gen_fcompare(&cmp, a->cc, a->cond);
+        if (cmp.is_bool) {
+            tcg_gen_mov_tl(cpu_cond, cmp.c1);
+        } else {
+            tcg_gen_setcond_tl(cmp.cond, cpu_cond, cmp.c1, cmp.c2);
+        }
         return advance_jump_cond(dc, a->a, target);
     }
 }
-- 
2.34.1


