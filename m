Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426677D1AE4
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bD-0007D3-2j; Sat, 21 Oct 2023 01:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4au-0007AC-5x
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:16 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4as-0008Oo-Kl
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:15 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-581cb88f645so915775eaf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866332; x=1698471132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmDa64Gca20nDmrXVypVfD852JFXcmSGDjcXXZ4bM8M=;
 b=cme65L8CywUh/lM8pRoWt2CXiZ9mCCnW2QYd8Fnh3kj/mtWoa2fsLkaLJTrdsviaoE
 /6UU8NcyTk8SUVETg7goBLpE9fPW9hafl187CV4AlYbEFfTBjB8wJAXKuC7Gef5Ch3gT
 cgGAxdnnnl0W8GvN4vxxRemiDM/YmNK0r6E5iPouYFeg/zgG8exh7h5/ziporJD5V8AQ
 7n7azV4uaoIi+b+etJ3WwmKimcxJZe66nBTyQcUNFFTCSrgaPKwlFNYA8U+DUmNIOc7+
 FJG+pZ94181fIlDt84vWodEIL7nS4Z5GazY8pM/h2e1GsJbqTbZ3W5KvZnz8TGn+o+N3
 NqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866332; x=1698471132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmDa64Gca20nDmrXVypVfD852JFXcmSGDjcXXZ4bM8M=;
 b=ux/jIUOkNGPp5Gtf4hXS/jtXlUO3mFF4uPSSZKqARXPGr5fvPzosngS8XZ773VUQOi
 gyS4qGM2C+wjdGxJ7XKscYmQhO6PkU1p/R3gJE9S7n39tSmcAB84n3L+Eod1otHgdXIz
 mA3gY5giufyC71bWjQVoGgOcHK3y+W45hMHuoC8FIVBbsi13jow3nBJU06khehReKufD
 DPHuAvAV22YTccmbEqwtqRgesl2RXtdnikDga9P9VuJUknd2ciRL0n/K8vJ+jbDIUdm/
 xAbhUkaKNtI23Eglz8aGEmBInUWYCZ+phbIS5g2/YvkqpoEQbk/AJoF4Ydj51IFcEHVl
 Fuzw==
X-Gm-Message-State: AOJu0YxpDv7hpVR2AQk6SRx4mtjaykY0Pz+aMyXORNBpWPsc5eibHIXZ
 Ee2kOhTyQw51OyfEWb4vgVOfBZ+UADgZCZeL55M=
X-Google-Smtp-Source: AGHT+IFlpMNyaWBa09FihMKfd9Rx61HQR2ru/1GZQk1/xo06vuXbI+6VjmF6xDUW69ybr8J72a3n0w==
X-Received: by 2002:a05:6870:a105:b0:1ea:d8bb:411a with SMTP id
 m5-20020a056870a10500b001ead8bb411amr4786944oae.6.1697866332219; 
 Fri, 20 Oct 2023 22:32:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/90] target/sparc: Merge gen_cond with only caller
Date: Fri, 20 Oct 2023 22:30:43 -0700
Message-Id: <20231021053158.278135-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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


