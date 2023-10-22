Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A270C7D2755
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhts-0007Mn-40; Sun, 22 Oct 2023 19:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtY-0007H2-0T
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:08 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtW-00071b-33
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:30:07 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1e19cb7829bso2148625fac.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017404; x=1698622204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIDRHHwL20Ez7O3FOkE9ooWuirGVWTRJKVkXyJDSDW0=;
 b=d+3Hl1l2Butn7MqOi9mLzK5T+zKLSmLclG8+7Atpoba2X9PnQoRWmkQhY9T75zhss1
 W3oFw140/AWzI3iVQxXRr/tseYEuar2QRmpnUFgRd8wM1GbqDSRGjFFlD07iUnH0tAJ9
 xKImM29ATwFpZbpaOZu9TUi8Y+75Qi0qmjjudckAaBsxStLn+qxWl6cVEU9+jMMJZQSr
 +MUErsmmcWUAmbz2u3qO3OEgVMCIv2yGKtOBZ3VKayor6avlk+Ppjjvf2Sg5sii1Fpg2
 xoJAG0Eo39xiU9EkfETa/7PjTWwQE523YAJBjI8XOOhL7JxhNHk1V/wNAVE5ReZ8uxY6
 fB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017404; x=1698622204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIDRHHwL20Ez7O3FOkE9ooWuirGVWTRJKVkXyJDSDW0=;
 b=QxaKxQDVYYUznVXiBlJ940rt9C5hFfPNiXl5cQ1E382RWWzHH3xpL1Z4hZrYOFngZe
 q3K5/MFBD4PzLfDIF2XQ0MBdlSwRQNhBtTLG5boyoK7WUKYTyxGLHi/w0JjLHbOunYij
 EXNp7YuYWXnrkQ7N5AgjKuju6cZwikNI65ZRqFRlshfDX3JQagh7YyHked+y8rSukPHC
 uBV9Tx47uhENmqAuN4BNKjjmKoQU8vzE81xcnOI/JnZLzz50tGRQPwq7MqT+6Uk4OuBG
 MHJMwf8V3haOI6MOeCktNUA+8FjAluLOMvRwr4cM0P9kHEnsTUWVnenEevohnPBvsfsM
 3WHw==
X-Gm-Message-State: AOJu0YwRLYbnHQMgFYR/fWbc+HbaimWB8CG0hZq3/oCbXu1R3Gm22tSq
 0xhAKUNbhTqj1bmZGGD9I2nIsuue94g9ArqU0cg=
X-Google-Smtp-Source: AGHT+IHKh8mpO7BWrBanWazgtkjrwHD8yRLP+WszvtrEgBRZdF/I7JcTLwI0BltydHjg88Jmv2g5Wg==
X-Received: by 2002:a05:6871:4003:b0:1e9:54ef:4806 with SMTP id
 kx3-20020a056871400300b001e954ef4806mr9567753oab.9.1698017404309; 
 Sun, 22 Oct 2023 16:30:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:30:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 35/94] target/sparc: Move MULX to decodetree
Date: Sun, 22 Oct 2023 16:28:33 -0700
Message-Id: <20231022232932.80507-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
 target/sparc/translate.c  | 7 ++-----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index d27876084e..20c59b6aaf 100644
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
@@ -4090,6 +4091,7 @@ TRANS(XOR, ALL, do_logic, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
 TRANS(ANDN, ALL, do_logic, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_logic, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_logic, a, tcg_gen_eqv_tl, NULL)
+TRANS(MULX, 64, do_arith, a, -1, tcg_gen_mul_tl, tcg_gen_muli_tl, NULL)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4561,11 +4563,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


