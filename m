Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0EF7DA902
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG1-0004v1-Lv; Sat, 28 Oct 2023 15:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFk-0004l6-93
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFi-00049W-28
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:47 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3577ce73552so9702295ab.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522345; x=1699127145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQqAIZ7Xh7BNepoaMPlY+YxkKXZzZN5XYqBDd4SweoE=;
 b=lqe2NBNvhpGXDAetg4hf8J4xMjDUxWOyLj7HQoIcsAA4F76I9X8l9dq4O145n7BojG
 wP3OiZgw8fbhoex5dHFGwURT8GyJSdssEtcNaggQYU/Athy6DKTDnlYmsZ1qxoGQ8XxK
 /cCtRJgRjkYBzklMDjt3JA2TY4FfiAvnCl28XzT2kLUqkJ6NsZ9/FcM/Q91JUy7zY4qF
 7u5dT0Q9UadIdq6qCcbxOMni8WI4xQ4afrhtu+K1ZU+iACGSYdvWChCQQLXa62Ql+pSM
 Y8nRDoUGbSSmhtqlXNDpbfziujx7aUMmZZqQm5bSoQRoXnaD78vJLZjcp6dmEGCkdOhD
 xIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522345; x=1699127145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQqAIZ7Xh7BNepoaMPlY+YxkKXZzZN5XYqBDd4SweoE=;
 b=BJ1xPSeQCpSMJjsr2xcuulYljrMJ8O6kLml3ojj1nLYfYBdD2/rudWtywd3VPc9AbA
 a/cvvIwYw/K7tD6yYJcp13MjO9wHYwVy25BzoQC4KMleoKAHKalyOFlNNYIlyDsjR+rG
 uZrBOE+AX0WG2O5eTWblJI25LmZbPG14GBt9uqqepQG9eAEEsxJ16uHvxgrJpmwA+N5+
 cXAnQ3yWwY0GWOoo0PmDMLE5wkX1YA61lISAE+2k/59RYQauxBm5wEfy7O/wjpblCX+1
 zMruSQULmX2R5KP0VV1er4P0OXKl0dKBzxFMdkKchKNYoMtb/cBbUfMH3WRdqM2gV5lc
 iX7Q==
X-Gm-Message-State: AOJu0YzViYZ6gzqZGhSmFO8OCmC7NwY2+5TfYL27TJuCcbm0OgY034RU
 ct6hFwdVTBKWUgqocDw67HfmNPJQmHJqYF7+lts=
X-Google-Smtp-Source: AGHT+IG+F8c6PA4k4v5a2yykqAsxLRjq4pM135v00Qk0m/vmb4IcX8WzxJ4m5jfWDBvVhRhYrOVB2A==
X-Received: by 2002:a05:6e02:748:b0:359:92:48aa with SMTP id
 x8-20020a056e02074800b00359009248aamr5196351ils.28.1698522345032; 
 Sat, 28 Oct 2023 12:45:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 23/35] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Date: Sat, 28 Oct 2023 12:45:10 -0700
Message-Id: <20231028194522.245170-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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

Rename the current tcg_out_bc function to tcg_out_bc_lab, and
create a new function that takes an integer displacement + link.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a5871f55b1..ca281dd33e 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1946,14 +1946,20 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     }
 }
 
-static void tcg_out_bc(TCGContext *s, int bc, TCGLabel *l)
+static void tcg_out_bc(TCGContext *s, TCGCond cond, int bd)
 {
+    tcg_out32(s, tcg_to_bc[cond] | bd);
+}
+
+static void tcg_out_bc_lab(TCGContext *s, TCGCond cond, TCGLabel *l)
+{
+    int bd = 0;
     if (l->has_value) {
-        bc |= reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
+        bd = reloc_pc14_val(tcg_splitwx_to_rx(s->code_ptr), l->u.value_ptr);
     } else {
         tcg_out_reloc(s, s->code_ptr, R_PPC_REL14, l, 0);
     }
-    tcg_out32(s, bc);
+    tcg_out_bc(s, cond, bd);
 }
 
 static void tcg_out_brcond(TCGContext *s, TCGCond cond,
@@ -1961,7 +1967,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGLabel *l, TCGType type)
 {
     tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
-    tcg_out_bc(s, tcg_to_bc[cond], l);
+    tcg_out_bc_lab(s, cond, l);
 }
 
 static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
@@ -2003,7 +2009,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
             }
         }
         /* Branch forward over one insn */
-        tcg_out32(s, tcg_to_bc[cond] | 8);
+        tcg_out_bc(s, cond, 8);
         if (v2 == 0) {
             tcg_out_movi(s, type, dest, 0);
         } else {
@@ -2024,11 +2030,11 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
             tcg_out32(s, tcg_to_isel[TCG_COND_EQ] | TAB(a0, a2, TCG_REG_R0));
         } else if (!const_a2 && a0 == a2) {
-            tcg_out32(s, tcg_to_bc[TCG_COND_EQ] | 8);
+            tcg_out_bc(s, TCG_COND_EQ, 8);
             tcg_out32(s, opc | RA(a0) | RS(a1));
         } else {
             tcg_out32(s, opc | RA(a0) | RS(a1));
-            tcg_out32(s, tcg_to_bc[TCG_COND_NE] | 8);
+            tcg_out_bc(s, TCG_COND_NE, 8);
             if (const_a2) {
                 tcg_out_movi(s, type, a0, 0);
             } else {
@@ -2108,11 +2114,11 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
 }
 
-static void tcg_out_brcond2 (TCGContext *s, const TCGArg *args,
-                             const int *const_args)
+static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
+                            const int *const_args)
 {
     tcg_out_cmp2(s, args, const_args);
-    tcg_out_bc(s, BC | BI(7, CR_EQ) | BO_COND_TRUE, arg_label(args[5]));
+    tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
 }
 
 static void tcg_out_mb(TCGContext *s, TCGArg a0)
@@ -2446,7 +2452,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out32(s, BC | BI(7, CR_EQ) | BO_COND_FALSE | LK);
+        tcg_out_bc(s, TCG_COND_NE, LK);
 
         h->base = TCG_REG_TMP1;
     } else {
-- 
2.34.1


