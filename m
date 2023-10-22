Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E47D218B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW6-0000XB-Ir; Sun, 22 Oct 2023 02:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW4-0000WP-Mt
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW3-0001YF-5W
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:48 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso1592228b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954445; x=1698559245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmDa64Gca20nDmrXVypVfD852JFXcmSGDjcXXZ4bM8M=;
 b=UQAarqwJBEjeGheaKzZW8N8Rm5YbQuJ9j/gTLhAWsSO8trtf5bHqb2jxRDTAtAyfH2
 6/eldwo9Iht0FZT/kWLvFgv2mJs6xR5ED48GCB+GUNqXGJ67TlccQQz4GcVvmt8Y55aj
 8M59C5lGjVzBbBvVnrtegffLW2FD2l5qdBMsGfLJdQXHqCvgCbsDb7iI4Yb3aEk0T28c
 +PyEBAknsrwDMkifGP3iDHLJrEfE/XZ1x5u3UCLy+2B2S2BcLWgzALtia+eEgPSyL6gE
 +oG39ieaVRzx6byOPCdMZmWBkagxqEA9penfxuQSiVhLUuO1n9zTmqojwmNmDCZCAXCO
 c3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954445; x=1698559245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmDa64Gca20nDmrXVypVfD852JFXcmSGDjcXXZ4bM8M=;
 b=I+FVyFNqqkqXNcpUveONGcfQ+/NFWLS+5SnrVVGSVbC36w0+QzOCNmJEBgTPIPZjlX
 Kz+jyKTDD0P615V9A6k8AQlXVybzbHdPb2RdgGN/UCibx9rZVdqTp8mtFNVymH2h2UWT
 SErNwQdl2m0b7yxHiRS01NJuzFux77TTS8/Kj63ZWon4e4xlxkicSAbYrgNMsa1yJzNK
 K74EKQOSMJzjkZ2b0a49jcseNupHa59PmYyywxy5fYbEdw3KFDqPwDlXYSqqEUQNP2S2
 n65Mm7G9jCO5DnRns3sexUUz3m37+BlrVhil+reGItUIEURZwKXzoAyz2bEl2v8lJEpB
 NPzg==
X-Gm-Message-State: AOJu0Yx29M55KraZ9NDKwlM3tLAvShyQQwv4X+d6GbTtjDhShFemaLGG
 4D4a+3J9p2uPnWffenaMKDCAWE/LTnj/oVabXOU=
X-Google-Smtp-Source: AGHT+IFec0+npsyYfjyu67ORaebxuNpKkR67p+ivm4HKYaoFZL46zF13oGNwVjziMeK9Zkxr4wAjKA==
X-Received: by 2002:a17:902:e5c5:b0:1c4:56c8:27f8 with SMTP id
 u5-20020a170902e5c500b001c456c827f8mr3697257plf.68.1697954445623; 
 Sat, 21 Oct 2023 23:00:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 15/90] target/sparc: Merge gen_cond with only caller
Date: Sat, 21 Oct 2023 22:59:16 -0700
Message-Id: <20231022060031.490251-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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


