Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF017D3EF9
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQv-0005VV-CD; Mon, 23 Oct 2023 14:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQr-0005Tw-Dn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:41 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQl-000857-45
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:41 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5845213c583so1032466eaf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084814; x=1698689614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=Z6xUgsqyg/YSo2mtmN81hn4f9jkjDkOnnYjxjptmIfVKsNGs+J6lZVTgXgSteB0rGo
 5YpWTttqgfykuIXrj98RvMHRjm+0DlucedArR99+nY1zaQ00pj6I6qyBwERifTiuZkxb
 y0U1VFcU9tpNLE28Gm8f/r32Q08FTAD4sY931w+KHVPJBhKSsyGN9Q5cA8/DWQmVtt6V
 tmIeGnztE0S/wGnwJuH6wjgBEhIEafR5EM6Swf4WmMhPDm62bHVNuYWxRrBT0e+/ocQV
 33Uk/7LHTJWQBgDXfPq5ofdDkUl2GPqssdqXR6HZMgVWdGz++11BcalvGwAPJPDIPa+g
 9NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084814; x=1698689614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=g/OSI5vtrJTHjFrVV/36ODJ9k8G0bWB+rFgae7+vWKP2BR5rdMLr9QK6Z2DEuXMKPC
 S5B9Js7Mef0DVsTCVQsrnZ/tGqX826WRW/6hF7wCuXuebVweR1IW8giQ4ZFHYOKjzyJc
 2JHHawJoaHopgUrOv3aRmTnbia2RvCsolT4U0IRUA6PjaRo28ufMyrZXf3xWXeUd1c4Y
 jMA7SVKIbidyuU3OxDouEhIVrjO+s25hmeoFMZboW/P/G8uY9W3Uh6qLsnDJ4QV5Rtvg
 pliVUTgTK5RAtNVQejMVRnoRxMWueDEGadWbEZYoEBsioxIbeNhsVgJbMMQm8l2cixY3
 V5ZQ==
X-Gm-Message-State: AOJu0YwvwdMp2+u0PFseVNaWK5LBbF9OdnIUcihAhi1jmoA/zhttI916
 YhPQf3CXoXMFLImkEqSHrtiP53DpELxmpkO4PYc=
X-Google-Smtp-Source: AGHT+IGJdThe0J3hhihGJOZU3G4hHbjraFYZJngUsEdnUGM5lYZT+ydt3qp0FDIuSENwgCptB0xAiw==
X-Received: by 2002:a05:6359:4289:b0:168:d0d4:d8e6 with SMTP id
 kp9-20020a056359428900b00168d0d4d8e6mr7666134rwb.16.1698084813892; 
 Mon, 23 Oct 2023 11:13:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/38] tcg/ppc: Reinterpret tb-relative to TB+4
Date: Mon, 23 Oct 2023 11:12:54 -0700
Message-Id: <20231023181329.171490-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

It saves one insn to load the address of TB+4 instead of TB.
Adjust all of the indexing to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9197cfd6c6..aafbf2db4e 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -215,6 +215,12 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_R31
 };
 
+/* For PPC, we use TB+4 instead of TB as the base. */
+static inline ptrdiff_t ppc_tbrel_diff(TCGContext *s, const void *target)
+{
+    return tcg_tbrel_diff(s, target) - 4;
+}
+
 static inline bool in_range_b(tcg_target_long target)
 {
     return target == sextract64(target, 0, 26);
@@ -991,7 +997,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Load addresses within the TB with one insn.  */
-    tb_diff = tcg_tbrel_diff(s, (void *)arg);
+    tb_diff = ppc_tbrel_diff(s, (void *)arg);
     if (!in_prologue && USE_REG_TB && tb_diff == (int16_t)tb_diff) {
         tcg_out32(s, ADDI | TAI(ret, TCG_REG_TB, tb_diff));
         return;
@@ -1044,7 +1050,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* Use the constant pool, if possible.  */
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
-                       tcg_tbrel_diff(s, NULL));
+                       ppc_tbrel_diff(s, NULL));
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
@@ -1104,7 +1110,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
      */
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
-        add = tcg_tbrel_diff(s, NULL);
+        add = ppc_tbrel_diff(s, NULL);
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -2531,7 +2537,6 @@ static void tcg_out_tb_start(TCGContext *s)
         /* bcl 20,31,$+4 (preferred form for getting nia) */
         tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
         tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
-        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -4));
     }
 }
 
@@ -2551,7 +2556,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     /* When branch is out of range, fall through to indirect. */
     if (USE_REG_TB) {
-        ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
+        ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-- 
2.34.1


