Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 540177D6302
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIZ-0000Fa-Mi; Wed, 25 Oct 2023 03:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIV-0000Ce-AW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIT-0004gR-KG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:23 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso4679515ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218840; x=1698823640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWAF8Yy1Ybd5ENfcMHYAo9tgOERLXXMk37OKNqP6zdk=;
 b=V7PmbJKVLyms9G9LcOmCQUMsrEABiIiLbVToQHZZ1SJq1e0J3acNcvU+GSY65rmqxF
 ayFiM7rGetLNasdYQMGcMQz6SWL5/pO080lLBiEjqdxlDA8rQwXC/QIP9spX6fWGGJnh
 vQXfkC0EjTWLZW+2Xi+XrR0dBWoWprVb9PqDaNMQUvUz7B8PRxWNgdWK0yR5VRav+oiy
 ZNeVEY/RCVqdY2B2gT8DDCExUFXooMQMB7J6z2IBT5UWVNLgco4+MmDGbzjtOXEmOYal
 Cz+8NhEAsBJH3W/IDKfnFotkw9848Nj7V1CtKyS2XodVG0FTTIsh1u3MSr6m9hc+vsfn
 FTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218840; x=1698823640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWAF8Yy1Ybd5ENfcMHYAo9tgOERLXXMk37OKNqP6zdk=;
 b=htASKIHyzmQNUV8BCJWPeDW6zm7AJwrqjQOiTP251peA3Y4OP/Y65Wg21KiaiFwz4X
 bdceteY+ELBY9jUM4KElb+kzkjdR+yubli3MazGbPxuQHiPLXRNtLarC14XBI+LRIMrq
 0Ypqr5tlm1TtzlIbVk66RfjGIhd2/6mjx0i4umwLpnw91QekaUZRzHn2NifTE2pIjm1H
 IBeb2CB9rfQ8Udpc07qLeO5vfPrVwSS1y1vHwRw8Xdq9Zg045o9sVi8txbXQQObFtX5H
 MkhUmm4VFdakAd/7GU/oc3JNgk4CW+jySlOQ/CgpoununRkRa0jipTjCWGbY9MtAvZzC
 j+Ww==
X-Gm-Message-State: AOJu0YyG/Cd0NiEZdXnnDVNTe6zdHQZk90VBaquUrw8AEd2eMRWurlNz
 7R8WPD5UqudYqADbpTPNL9lRlaR6jAC65cgpKJw=
X-Google-Smtp-Source: AGHT+IHVra7PionzJ0pr619ciDhjg7Z7ebI5RC3ecdIwKjYq0qcZ9vmRuMGgG0jno5VdilPMo2tcYQ==
X-Received: by 2002:a17:903:32c1:b0:1c7:5776:a30f with SMTP id
 i1-20020a17090332c100b001c75776a30fmr18012824plr.12.1698218840276; 
 Wed, 25 Oct 2023 00:27:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 12/29] tcg/i386: Add rexw argument to tcg_out_testi
Date: Wed, 25 Oct 2023 00:26:50 -0700
Message-Id: <20231025072707.833943-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Move up above tcg_out_cmp, where it will be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6e8af1fcf6..f4f456a2c0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1418,6 +1418,19 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
+/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
+static void __attribute__((unused))
+tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
+{
+    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
+        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
+        tcg_out8(s, i);
+    } else {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, r);
+        tcg_out32(s, i);
+    }
+}
+
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
@@ -1796,23 +1809,6 @@ static void tcg_out_nopn(TCGContext *s, int n)
     tcg_out8(s, 0x90);
 }
 
-/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i)
-{
-    /*
-     * This is used for testing alignment, so we can usually use testb.
-     * For i686, we have to use testl for %esi/%edi.
-     */
-    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
-        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
-        tcg_out8(s, i);
-    } else {
-        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_TESTi, r);
-        tcg_out32(s, i);
-    }
-}
-
 typedef struct {
     TCGReg base;
     int index;
@@ -2080,7 +2076,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        tcg_out_testi(s, addrlo, a_mask);
+        tcg_out_testi(s, addrlo, a_mask, false);
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
@@ -2229,7 +2225,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
 
-            tcg_out_testi(s, h.base, 15);
+            tcg_out_testi(s, h.base, 15, false);
             tcg_out_jxx(s, JCC_JNE, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
@@ -2357,7 +2353,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
 
-            tcg_out_testi(s, h.base, 15);
+            tcg_out_testi(s, h.base, 15, false);
             tcg_out_jxx(s, JCC_JNE, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
-- 
2.34.1


