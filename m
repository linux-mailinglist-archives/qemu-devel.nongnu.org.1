Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E380A7D792C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo39-0007OR-Hw; Wed, 25 Oct 2023 20:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2q-00075n-TQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2l-0004tI-6Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so2427855ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279369; x=1698884169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPgAucB/EvVI7/45p+5WkYALvfhQJlj29a4kXp2aWhI=;
 b=bfalixj1Kqe1rg2Z0W60miOifocDxef5rcvBHgV4WeFce0m3MLUhYOF134MMskFPNt
 He4mAWK1TBNJQjmXD3Gtv6aPWl2fiq9Xxuc7XiiahcIBS/hNHrFCYM2xp5tMZjMJmjSD
 Mn8DQ9/lJKEnWSj1vl1itFclt8VsRtAge33cx21SN7MnrUuoa+tNtt/S47wNsv4y/Q2e
 w3+Kwaf46y0rGkBugUGtz9cGs9R9E2ChYESidElimVZvjOUgGrMjTMBbswlzhab9wqCE
 eq8JknOD+I5wcoS6O8DcwGJMzjHOJnhIoLoQUOB/lqDIGB38/IbZeSoXFo4KQOY/3klh
 J2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279369; x=1698884169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPgAucB/EvVI7/45p+5WkYALvfhQJlj29a4kXp2aWhI=;
 b=Ief/cuz/2SknYY5w28jRkVN+f2aDIzx136/xo6fF8s27c9wwhv+Mx4BJOeVbHQWFW9
 zUi0utaEjAAql9DKJAT35Hi+yP/wd5BHMXVtbDhYKvCx5XV6emdi/EsnXM29zGAMmszc
 voi7VWeAlWrVzgAZWOUWLKLVc61A/FdXrpZuBSLIiahX0mLI96L0JzQrswpXuNntsl2b
 ImIIvdlav8DK/71N3n8yJSCg+qn0NCyKFsi23fKTxsVyO6bfwQHHr2l81tCdLaSi8b4a
 qs9O8jTP6yoUAkGEyq0rq+hikihQZzCEl07QYih5R6qB2oMB12iOHDkhOl2TX3a+iZ6m
 tNpA==
X-Gm-Message-State: AOJu0Yyp5qV0UnSRxMboHhalwuSJS+r6QMRxg6pKBudPBJkCVILKA8Yy
 SZsjOZogDw6MgNmHAyc9Q04m1QFllcHhy/cP47w=
X-Google-Smtp-Source: AGHT+IHk0sjH3c1lq6LtiY96grt1EgHCtArUYGsjl6Cxrg5n6WXlzPyTPJ7RJLn8wSya2yf0bFV5/Q==
X-Received: by 2002:a17:902:edc2:b0:1c6:2d13:5b77 with SMTP id
 q2-20020a170902edc200b001c62d135b77mr16093034plk.39.1698279369365; 
 Wed, 25 Oct 2023 17:16:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/94] target/sparc: Merge gen_cond with only caller
Date: Wed, 25 Oct 2023 17:14:10 -0700
Message-Id: <20231026001542.1141412-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/sparc/translate.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 69e85b1842..2664db302d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1309,20 +1309,6 @@ static void gen_fcompare(DisasCompare *cmp, unsigned int cc, unsigned int cond)
     }
 }
 
-static void gen_cond(TCGv r_dst, unsigned int cc, unsigned int cond,
-                     DisasContext *dc)
-{
-    DisasCompare cmp;
-    gen_compare(&cmp, cc, cond, dc);
-
-    /* The interface is to return a boolean in r_dst.  */
-    if (cmp.is_bool) {
-        tcg_gen_mov_tl(r_dst, cmp.c1);
-    } else {
-        tcg_gen_setcond_tl(cmp.cond, r_dst, cmp.c1, cmp.c2);
-    }
-}
-
 static void gen_fcond(TCGv r_dst, unsigned int cc, unsigned int cond)
 {
     DisasCompare cmp;
@@ -2980,6 +2966,7 @@ static bool advance_jump_cond(DisasContext *dc, bool annul, target_ulong dest)
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+    DisasCompare cmp;
 
     switch (a->cond) {
     case 0x0:
@@ -2988,7 +2975,13 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
         return advance_jump_uncond_always(dc, a->a, target);
     default:
         flush_cond(dc);
-        gen_cond(cpu_cond, a->cc, a->cond, dc);
+
+        gen_compare(&cmp, a->cc, a->cond, dc);
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


