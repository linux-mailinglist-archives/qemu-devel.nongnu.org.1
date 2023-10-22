Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 449C37D2136
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW9-0000ZO-15; Sun, 22 Oct 2023 02:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW5-0000X8-V2
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW3-0001YR-Vm
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:49 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c77449a6daso18343645ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954446; x=1698559246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRMTQptI2nfQXOSpXQo/O0ul1mHB/BhVdQiXtwwiUDw=;
 b=rAxGsRbi/usu3mntgUTGFufiBC3kA3RzjmZw9cw91OmN1KPXmgZ3Cs1Zq5JiSfFXcT
 UGEeNGRh4kI3cNktWIuB4VdGqJNi1oFbbQQ2XFKeAcB35VzfzH7Wn73CEwmlQqBNh7XK
 ab8uRk1zFSCzyEIiiWJoiltpQXtC8tkT9xRDVh2id4HnAyLKohk1gacXY/sU6q/Cf+MR
 da/u34Bx6EX471nRm7OB27LXX0seJOQPxqb9zqYzlVH8rllgW2z1JHb9LfQfKmxsI1Lh
 W24z5Dwf7GNawX9WHLiBDn/jE+RwaIgA0eG9xtIRas9PCWIXh/7kjIIJ8Ds4pLSk1Wzh
 1rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954446; x=1698559246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRMTQptI2nfQXOSpXQo/O0ul1mHB/BhVdQiXtwwiUDw=;
 b=gxmKmNdo2S9Wb122jYQ6Cfwhs3E863ZYIM0M69ffZ3J/BFnMpKb80coQOeJzxkSUns
 VwDEdimR0ufbZSXAreavssCj78cuGigI1PpviZgRg7P9bELiyXEDesnIocB8POdKv0LS
 qGQAbBUZ3Ts19K4c6pmwHAepuhL8oQjY8y1IWSzBi0QFKUClvN4htnVYVAU5SmofWzgJ
 Ha2D+cNvZfKNIUElLUx5MxH/KC1iLwB3qvfRSUT8ugoAhVonaiJ3szBuNDRhK+VMXo2C
 lct8uthDd8A6F2rtt/f0hnN0NYOLa2NnjKBOGkpd0vsRAOZvuIiLkOEMF6Ko3hR6Rsdo
 TBtA==
X-Gm-Message-State: AOJu0YztQYlv1oU6DPMp9yLZcVXHHIgOtuVjda8lcsC32IZMImyAUvB/
 qo6w0ZcQrXPHYXFCCBY0Ln6m76JsI6MnbonvOV4=
X-Google-Smtp-Source: AGHT+IEFEDhf0eVahuw/9Pk9JTYBcZSmyJVv2ZlO3bcaB0+vXzlLK/zJI4j0Me/aKb+ktb7dToBQaw==
X-Received: by 2002:a17:903:30d2:b0:1ca:e491:f525 with SMTP id
 s18-20020a17090330d200b001cae491f525mr359172plc.31.1697954446398; 
 Sat, 21 Oct 2023 23:00:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 16/90] target/sparc: Merge gen_fcond with only caller
Date: Sat, 21 Oct 2023 22:59:17 -0700
Message-Id: <20231022060031.490251-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


