Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BAE7D273C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtZ-0007HL-CC; Sun, 22 Oct 2023 19:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtJ-00077h-9H
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:56 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtF-0006l8-A1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:52 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-357cd0d4e47so4203115ab.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017388; x=1698622188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPgAucB/EvVI7/45p+5WkYALvfhQJlj29a4kXp2aWhI=;
 b=Ox4HCqqjfIH3orRtzhLX49Swky91FgVr+/uiA/FR09PXDRfaAqJlccMiH8+yY5IK95
 kfXkYwpBDQ1abis6jd9OK956h1oN4Oyc5rOlXkZsLzVo6FNqjqkKNfdljhxIYOyTPwxk
 h5v2cBUFvMD1RuNyDsl9AAAcmyq9REss+U5Wz0D5XikKznifclRcfVkBj+nN8bRV+h1s
 yF64mj1va5rdKE9fwaMlJ+/GvdNEC4QFFTNU7SAchNE02vPsPUP7jnRep27mQCu+XoY1
 AM3nHIQ8U7RwXGSDxu6R9/WKl8xmDGWbxeG8I+VZXqG+FDNi9egryWAwPvXNqlC7MKNH
 ZrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017388; x=1698622188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPgAucB/EvVI7/45p+5WkYALvfhQJlj29a4kXp2aWhI=;
 b=PGExHTOkxhRG5YycgNSDYCiYkOtmi1JyTt4j3q6q07QeadVYGicbiRw+4gZOs/EeIL
 Wq0vY+WGW6lb2YPmLUrrRbHcJwzYE7jU4tTeakYf6KkJh0oGkmoG4uapiA6LVFxwyEZG
 c2Uj8SbcWtkwhCKXr0ilgy3mEFxnubbwGEdkGkyn3bciMhKuTrOROoQ5GE0nsXBbeYTO
 Uu7R+CLDKYp/DQgTOw+E7UNXFUEABuzZ8k+Ytj6pu78D1OhvasIgimwsiA3VYLGJMS8D
 6taYB/lc2D1BD7dZYrAd5qLO21eRiczIwyHESprPTA2H0Uemp3P54pWH59Jp8ASr4YrG
 tEiQ==
X-Gm-Message-State: AOJu0YxLdCJS9VUHPODonWygn85RhbqnsC3BWfAwhWHF2PRXHWydEQSM
 5arkKBoGQlvAAk+2As3Qow4adsncxBjFJDgR4Eg=
X-Google-Smtp-Source: AGHT+IE3fLnFRZB2iaeoYAgDQtDEO5qsdvuPGEXc6hCQRgoRhk3vwh1IR96HqB1pku9oIktd8z6bTA==
X-Received: by 2002:a05:6e02:12c6:b0:357:a04c:31d2 with SMTP id
 i6-20020a056e0212c600b00357a04c31d2mr10899571ilm.16.1698017388065; 
 Sun, 22 Oct 2023 16:29:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 16/94] target/sparc: Merge gen_cond with only caller
Date: Sun, 22 Oct 2023 16:28:14 -0700
Message-Id: <20231022232932.80507-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
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


