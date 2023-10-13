Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C047C8F27
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPij-0006LT-5O; Fri, 13 Oct 2023 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPif-0006Kt-8K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:17 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPic-0000Ur-PJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:16 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d1aee5aa1so1920274a91.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232552; x=1697837352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR/6YK4ZSvvWC0fnzOM6CLDYWM4TIoHTM+fei4eVb6E=;
 b=imxDT4lRbq37FnT0p7V5ZDCtyMRF7G+c92yMK6BB9gxxd+wBvVxcDcSiw+AB6ZocyE
 YZXi6PDluEHBN9ZopnwDWhnNn/SvlmxEcw72yRfr8EId0VmvOTOB0Ay4/g1UpZtol/7A
 B16PoeOOYmf/6UukVc75EItVXzZuGhb2Ys0MQU1VqhfLK1im/8OOFiQzhF+0MI5yCeEk
 cZypT7W64ADx/RlMTiBXjHp9Uam/SYMaMCcF59ad/HpzMSoTJ1hIoWxsyucX0Q2oT5ux
 uGS7oPR9LODhF/HPDQhuQCyQkdCEGqEt7YgxqCAoeNgI3OQIrn+IUo3jscorX2fGtEt1
 9WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232552; x=1697837352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aR/6YK4ZSvvWC0fnzOM6CLDYWM4TIoHTM+fei4eVb6E=;
 b=VByIm6usgw3STPnjOOVO867XLnBiHd22tjjqIjCLBOGi/OPX15PtyjFcvhSQ48VLmv
 GfDT6HIHmziRce842C2/jKGsP6DEC2CuZ7cH3ro9k9GrWxboaozlhyVBGr49gzmedSSX
 bW3KdXqBX5jzZa+jlfNz8jNsMawWpzvl3JWXpdp6NcWTVbzZaMBRJPfQ8AAKcOIKtKWS
 DrkL+8nvR4QOayw8j23CuSmhkBsbxgQqeDP6Txg7rrV14F+fpsyAeasnIN/nuhADkfGM
 ZGUrDZsX53Li/eg75NZeZOEG/9luwkd1G6QhzRuluuzKELPL0oomEaYeziwsX+FGvFOq
 O3NA==
X-Gm-Message-State: AOJu0YzYOnQ/8hFZEQa1jNvayRr+QQQjvQKQH+u7qDJcDuzojQHoZMES
 5CY/ow7fA3vV3eUQ+4Lm+Oz0c6jQsvraTfYUl/g=
X-Google-Smtp-Source: AGHT+IEQ86SD67eHSzeOqG03KjlmRIOkZQjCyuxgAedcR0sXxynme6keop6nzfIk1PR78uied1QH/w==
X-Received: by 2002:a17:90a:fb87:b0:27c:ecec:8854 with SMTP id
 cp7-20020a17090afb8700b0027cecec8854mr1994183pjb.7.1697232552446; 
 Fri, 13 Oct 2023 14:29:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 26/85] target/sparc: Move MULX to decodetree
Date: Fri, 13 Oct 2023 14:27:47 -0700
Message-Id: <20231013212846.165724-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/sparc/insns.decode | 1 +
 target/sparc/translate.c  | 6 +-----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 87108da5da..d907a4a69f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -174,3 +174,4 @@ XORN        10 ..... 000111 ..... . .............          @r_r_ri
 XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
 ADDC        10 ..... 001000 ..... . .............          @r_r_ri
 ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
+MULX        10 ..... 001001 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 37917ad397..7a7d517fac 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4149,6 +4149,7 @@ TRANS(SUB, ALL, do_arith, a, tcg_gen_sub_tl, tcg_gen_subi_tl)
 TRANS(ANDN, ALL, do_arith, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
+TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4620,11 +4621,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-#ifdef TARGET_SPARC64
-                    case 0x9: /* V9 mulx */
-                        tcg_gen_mul_i64(cpu_dst, cpu_src1, cpu_src2);
-                        break;
-#endif
                     case 0xa: /* umul */
                         gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
                         if (xop & 0x10) {
-- 
2.34.1


