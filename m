Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC97C8F48
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPin-0006NT-91; Fri, 13 Oct 2023 17:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPih-0006Lg-7E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:20 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPie-0000V9-5S
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:18 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ae35773a04so1560470b6e.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232553; x=1697837353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QABJBdmOOd4yUiJkdSwe+tt/g7tM8AVI1FM0pWgwVX0=;
 b=m343NfW4zYV4egtKZP63IZLIP0SFaEE6uaF/ytW9wpiGrdT1mF9hqRiU5Aly/68ybd
 kJ3fx87iNkLhYPsk0yEn6z8+fnJbOIYLF6r4A+wPVMpFBP7Sk53q7bzJVii1DcyzNBQQ
 6q2FazV7seT5WJsL9n6hzK6THm6n3XF1ncLC0aYFLS1QQebU+nK24yyCONfyNZz53Pnf
 Mf8xfOi2mNghujJkfOvgKXxBe2+iIXrHeJdv6d3xjC87gKYGkvZSpeFNe/U/AlzZngpS
 hhafxaeBYFeYtPm9l7QRTRQN6Nqd2+fF74ZO0jMZhZQ+XB1JcrCXcCjUK1/eyzE81rZH
 taig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232553; x=1697837353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QABJBdmOOd4yUiJkdSwe+tt/g7tM8AVI1FM0pWgwVX0=;
 b=X2iK4E+PQs3nTPo9s94YDq2QG/wK+gsWnKGU6841uZ3+23gQtzlEgxEHvJUA2JLz5Z
 jEyqWc3sINqGNT7gEqQr3HV9HBJ2OVEQlvxj50roUjTShtJuMssV/4m5lug4GMgDHBA4
 NQ6GdmzZV+hrFzBPlPVc0lmAdu8hp0Q45t7W7z0RNbOCT8hIKYdO38L5OVReupsfiEB/
 1cpW9ky3raulWZwFoEtezDAxMBb0o5ZSvtmVA0eAtAWZnOJrYXa717oMYecESzefJsZC
 UrT2/UxygwBdyV685FvC95RKBkmsscYNQziyKZIHNaaYUO8+WlcZamzknPnMIsh3JGr6
 k0GA==
X-Gm-Message-State: AOJu0YwQBiRSP4yQsg+r0WBqYkEBwYMh721YoETjFVZ0PnqllypCGzHs
 jdd4iqOnHHUg+7fJHlMfOXDaCQZyBbsKDi0gL4A=
X-Google-Smtp-Source: AGHT+IFffqe+NeBSsnpemEcWoQHZadLFgI2Agx2dQ/Xv4gYzursHfk7KDbBHs2p4wl5K1h10pULX4A==
X-Received: by 2002:a05:6808:1395:b0:3af:e556:4602 with SMTP id
 c21-20020a056808139500b003afe5564602mr17804273oiw.11.1697232553459; 
 Fri, 13 Oct 2023 14:29:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 27/85] target/sparc: Move UMUL, SMUL to decodetree
Date: Fri, 13 Oct 2023 14:27:48 -0700
Message-Id: <20231013212846.165724-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 20 ++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d907a4a69f..9cd89cf03b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -175,3 +175,7 @@ XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
 ADDC        10 ..... 001000 ..... . .............          @r_r_ri
 ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
 MULX        10 ..... 001001 ..... . .............          @r_r_ri
+UMUL        10 ..... 001010 ..... . .............          @r_r_ri
+UMULcc      10 ..... 011010 ..... . .............          @r_r_ri
+SMUL        10 ..... 001011 ..... . .............          @r_r_ri
+SMULcc      10 ..... 011011 ..... . .............          @r_r_ri
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7a7d517fac..38c1f2f79a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4150,6 +4150,8 @@ TRANS(ANDN, ALL, do_arith, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
 TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
+TRANS(UMUL, ALL, do_arith, a, gen_op_umul, NULL)
+TRANS(SMUL, ALL, do_arith, a, gen_op_smul, NULL)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4159,6 +4161,8 @@ TRANS(SUBcc, ALL, do_cc_arith, a, CC_OP_SUB, gen_op_sub_cc, NULL)
 TRANS(ANDNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+TRANS(UMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
+TRANS(SMULcc, ALL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
@@ -4621,22 +4625,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1 = get_src1(dc, insn);
                     cpu_src2 = get_src2(dc, insn);
                     switch (xop & ~0x10) {
-                    case 0xa: /* umul */
-                        gen_op_umul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
-                    case 0xb: /* smul */
-                        gen_op_smul(cpu_dst, cpu_src1, cpu_src2);
-                        if (xop & 0x10) {
-                            tcg_gen_mov_tl(cpu_cc_dst, cpu_dst);
-                            tcg_gen_movi_i32(cpu_cc_op, CC_OP_LOGIC);
-                            dc->cc_op = CC_OP_LOGIC;
-                        }
-                        break;
                     case 0xc: /* subx, V9 subc */
                         gen_op_subx_int(dc, cpu_dst, cpu_src1, cpu_src2,
                                         (xop & 0x10));
-- 
2.34.1


