Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57B7D79A8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo72-0002Mx-3f; Wed, 25 Oct 2023 20:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6G-0001Dz-OI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo66-0006eJ-G9
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so2320485ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279577; x=1698884377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii+UgCJP+tPdYxSJC+tW/iaYho3LkDYSDzYDIA5OxYY=;
 b=ZSdBgwragL1KvGUP0Fuk+D9WS3MzvYj6MUu24GxX/cSphnyWKpObfhkOFYwNg54hLp
 bfgmQEe6AmIioYOA3/Obr3Ct360l6uGjzxSXT4OvULUYx69o6xRZQqSUA32cxPpSYOq2
 YGHWwFHyjM99y7jv16sniH0DNMFkUNIYPsDGM1zUmgZl2gMwnkRHfSr+TO3TexYzYgWM
 1wHv9acXMBwyYder8uZXNUOmamzGBN+FmUTz4khukMxCtCoztNBVzBCxNlQAjWsPxZJn
 eH93dV3sGfvvWHwAfQ+ZmxzYmmfHgQ0q7FzteLrLRh1NkkDdX3aQ1OItrwXT6CVZqTTe
 Aa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279577; x=1698884377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ii+UgCJP+tPdYxSJC+tW/iaYho3LkDYSDzYDIA5OxYY=;
 b=bdf5KEAU14ey3E50RcLM0/zYivVCpKGVOZOQAnPXwIyjNTNor5sf2lUhOH8Lqbqxsi
 zwiD5FYDvsW0e5kjHGItorvFG+1fQe1DRyiKdQQkB1Tz51ABKlDsxJ8VTt9H0soS2pVj
 vdakLEjTAddmezi3w1RWWXwFG3v+gE3WtLKt5voVfZ7x+dAglhkjhdXo7bBlcdx+2UNq
 plOM0+Oss8NlypyXEHGcxfyzjDSCe3lxMD75J9hGMrJEbuXqeNn/YiKpIMrHs6ajKaE8
 VQVQIJgvtnvKhkTe7hbQAvxu3j75M1RblLahN6A9KcLXayIR+zdb7JtLCUqMZ1Ydfb9y
 u31A==
X-Gm-Message-State: AOJu0Yxa1HqvC7he4MYOH6BaGBtNks9n7jiLV5Tt6IpEFsvF4vYefPv9
 5sRKL78+haGVWD57jqcbaDQbqr1aJBUR2mjevwQ=
X-Google-Smtp-Source: AGHT+IHz5D5DVoH9wiDGFCfiChg80zlUOKR3wZW0tJkQ5r32i+P746hH1gub3rz+uGCwwZ7bcQS72g==
X-Received: by 2002:a17:903:191:b0:1c5:c546:febf with SMTP id
 z17-20020a170903019100b001c5c546febfmr18470105plg.35.1698279577073; 
 Wed, 25 Oct 2023 17:19:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 35/94] target/sparc: Move MULX to decodetree
Date: Wed, 25 Oct 2023 17:14:43 -0700
Message-Id: <20231026001542.1141412-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 3 +++
 target/sparc/translate.c  | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1cff18fa1f..1a04a8e229 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -31,6 +31,7 @@ CALL    01 i:s30
 
 &r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
 @r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
+@r_r_ri_cc0 .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13         &r_r_ri_cc cc=0
 
 {
   [
@@ -165,6 +166,8 @@ ORN         10 ..... 0.0110 ..... . .............          @r_r_ri_cc
 XORN        10 ..... 0.0111 ..... . .............          @r_r_ri_cc
 ADDC        10 ..... 0.1000 ..... . .............          @r_r_ri_cc
 
+MULX        10 ..... 001001 ..... . .............          @r_r_ri_cc0
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eb829acc68..2ecd9edb33 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4073,6 +4073,7 @@ static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
                      void (*func_cc)(TCGv, TCGv, TCGv))
 {
     if (a->cc) {
+        assert(cc_op >= 0);
         return do_arith_int(dc, a, cc_op, func_cc, NULL);
     }
     return do_arith_int(dc, a, cc_op, func, funci);
@@ -4096,6 +4097,8 @@ TRANS(ANDN, ALL, do_logic, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_logic, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
 
+TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
+
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
@@ -4561,11 +4564,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-#ifdef TARGET_SPARC64
-                    case 0x9: /* V9 mulx */
-                        tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-                        break;
-#endif
                     case 0xa: /* umul */
                         CHECK_IU_FEATURE(dc, MUL);
                         gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-- 
2.34.1


