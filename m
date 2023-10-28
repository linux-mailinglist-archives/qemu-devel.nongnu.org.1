Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C457DA905
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFz-0004uR-V1; Sat, 28 Oct 2023 15:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFg-0004kn-3I
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFe-00048a-Dg
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc0d0a0355so20257935ad.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522340; x=1699127140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJ1WN/0iuBwc2NCK63JpHvn6inIzrDX6DykcbHZYqkQ=;
 b=lCQZL2vNTmhwUS/CqGbpr96K3gD6oh4v7DKcV+QfcJWC1X8zITg4t5sQ5HLh6gNUR8
 HHt9VkFLVemHlPE4pQfsIzp6NBd1RbCEeql7YeACYkgkyB+MfOqbgI2FFBWoSDo4E/b3
 NoxSoTnzGPyrlh8hwfmGnzhpdi4FXI6MOZHB56kE8LlLP3gmyC7SxYI0cIOdjWi00isf
 SA+BhP7ltvmX3M3HF//C4lSXpd+QSxO1DYsh5nXnGtwE7Ov4Z45YxbOSbUTjXGaCopA4
 d9fZON+rsZ1hhudkZimuEeLHfi/tdgwhcE0+UNk1Rc/ipbl9t+x5he2vpLwVSIH1DXbu
 2B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522340; x=1699127140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ1WN/0iuBwc2NCK63JpHvn6inIzrDX6DykcbHZYqkQ=;
 b=mMw2pYWuph2awWpNYdlY8n0GzU+k4GWkycm0szV1IbvyrrXCSs+zR2dNCzuna4D1Bu
 F0yZZPmT8ASttVRuIfpTjwy4DmvBmHUSHjHH2xJtsR3bsbDbCm4C8t1J/gyP040ojuFn
 Jh1cbYXXZmqDgXL5z08bRY/zY79MkxfY4Pvo+E1rNXFgQSKiy3KCuDH92XyofzIT7C9g
 wk/8+xfKvhcuPqiNgKp9aohRlvobkFLQxuyFg8xzRvrEI76qH6gDphkFg8n0R5zx5cTo
 UNzIY6mZOt8aQ64OR9tsODFI5H1AqL+L24XB7lkVQz3gGV4sjQQuHnT9Hz50Nogf7J7T
 BPpw==
X-Gm-Message-State: AOJu0YwwkuVSMqHqUh90HdNx1dyaX38jlpBRvDmF+FF3u9bOa3DihdV1
 BBxAKHq3VJm+o4AqcKYlSxhaJRF9ryhl1tgfb8k=
X-Google-Smtp-Source: AGHT+IE0vgUpkYIuASda/Mta2vzqQUWtZGaSdvoZYzeDpPqvXJ0KVYJQmS2CHc/HaG8dB/5Z6Gb7DA==
X-Received: by 2002:a17:902:fa4e:b0:1c9:d667:4e85 with SMTP id
 lb14-20020a170902fa4e00b001c9d6674e85mr4449665plb.40.1698522340613; 
 Sat, 28 Oct 2023 12:45:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 18/35] tcg/riscv: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:05 -0700
Message-Id: <20231028194522.245170-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 639363039b..358579b3fd 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -799,8 +799,14 @@ static const struct {
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
                            TCGReg arg2, TCGLabel *l)
 {
-    RISCVInsn op = tcg_brcond_to_riscv[cond].op;
+    RISCVInsn op;
 
+    if (is_tst_cond(cond)) {
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP0, arg1, arg2);
+        cond = tcg_tst_eqne_cond(cond);
+    }
+
+    op = tcg_brcond_to_riscv[cond].op;
     tcg_debug_assert(op != 0);
 
     if (tcg_brcond_to_riscv[cond].swap) {
@@ -828,6 +834,7 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
     case TCG_COND_GEU:   /* -> LTU */
     case TCG_COND_GT:    /* -> LE  */
     case TCG_COND_GTU:   /* -> LEU */
+    case TCG_COND_TSTEQ: /* -> TSTNE */
         cond = tcg_invert_cond(cond);
         flags ^= SETCOND_INV;
         break;
@@ -887,6 +894,15 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
         }
         break;
 
+    case TCG_COND_TSTNE:
+        flags |= SETCOND_NEZ;
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ANDI, ret, arg1, arg2);
+        } else {
+            tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
+        }
+        break;
+
     case TCG_COND_LT:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SLTI, ret, arg1, arg2);
@@ -1080,7 +1096,7 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     int tmpflags;
     TCGReg t;
 
-    if (!have_zicond && (!c_cmp2 || cmp2 == 0)) {
+    if (!have_zicond && (!c_cmp2 || cmp2 == 0) && !is_tst_cond(cond)) {
         tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
                             val1, c_val1, val2, c_val2);
         return;
-- 
2.34.1


