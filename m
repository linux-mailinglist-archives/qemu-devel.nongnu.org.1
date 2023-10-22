Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B97D2702
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtQ-00079r-HB; Sun, 22 Oct 2023 19:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtK-00077m-Dd
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:55 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtH-0006lH-6X
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:54 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-357ccaf982eso5925345ab.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017389; x=1698622189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIOAJWBVtCMbS0c4KC6cXcYTMMaXIG2tg2FWJOn2ue8=;
 b=UKGC2oDrRzXoO+qleSXRZ2mM4GgyktJeSdltYsU/puTQ4rAajfRY+YCC/TMYWB8jjk
 i9+6031RvSKc3tipYJJuQTpftUOYO+vioSu69Y6T0MHPpAiv3hIrhG/h7mmdfmm8misp
 m+KYAtr0HTjU66sd2Aq216fVWgGNagmezYwltqbF6aW7AJvXe0QhWaxBlqNQMrzCqOGT
 gWTvoyaBfdFfM8S/rjL8n/pwu3kD6M9xynZCTX6JVJG8WMUwrDCXdzgcWYcx4MKd9gab
 2H4SuvjCFWam+YoSMxTtl8hWtDZor8Jtdrh5YUvW2q3hOU5JiiVWfKpC2bBrq024EerA
 I8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017389; x=1698622189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIOAJWBVtCMbS0c4KC6cXcYTMMaXIG2tg2FWJOn2ue8=;
 b=mAmnL2rYtDnCZBd4F6tLS/XXdeaRxPPV9ZOsWV5eoKZ2GYPqGZw6dZ2tlk7mW2Szoq
 veJQ62FE22tYsgV2aswsR0e67hQglwOfTI3mKH/FeDfFJK8DvETrYNfwR7QysTNbmi2a
 gV9bdP9uiMFzdMcZsnU8+Vqp12sxIHdRF6Lf+sgjF51ydNMWst1VP6Puri8ru4LZQSS7
 OZDL1D5NojaxQgaN/S+NI8htmhLaC9p1Z+X8YhTLd4Sqts9m+gUL51+qx0V4W2+brmGO
 ccAsszXQgnZE4RaznyZK18lsX5XpD5XM5W7ADu3cDaTD4w12c8KTxq90mRbJgRQ/LBn7
 7EYw==
X-Gm-Message-State: AOJu0YzzxnLRX8OxKCP9z/M7WNBgtHUxfWdRAdguoHGIAyMhFUuaZxIJ
 xu3fLrWM4c5Q3kSYJr6EwS5y+OlcaEQ7nWRyZcI=
X-Google-Smtp-Source: AGHT+IHmc5OduOZqRoA0hJFgt6XtvTev5yuAo4dgwnR14vKdfay7mUh7oTDgHSIoTnl7E7iATjOcYA==
X-Received: by 2002:a92:de07:0:b0:357:a180:6b74 with SMTP id
 x7-20020a92de07000000b00357a1806b74mr8049299ilm.27.1698017388922; 
 Sun, 22 Oct 2023 16:29:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 17/94] target/sparc: Merge gen_fcond with only caller
Date: Sun, 22 Oct 2023 16:28:15 -0700
Message-Id: <20231022232932.80507-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x131.google.com
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


