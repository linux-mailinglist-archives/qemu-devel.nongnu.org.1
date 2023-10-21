Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4267D1AF4
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bH-0007IQ-Ud; Sat, 21 Oct 2023 01:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b6-0007FC-8j
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:29 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b4-0008SN-FF
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so1445897b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866345; x=1698471145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1mRozPLloATOsE1zPRn/KSGBk/VdF2/1IvPJmxRsR8=;
 b=VYCERwMdVdi54xWwzgaY+jdzWqZPohvt043LY9WiR2WyqAGVKaqWbHpP2Oo+gIGUtb
 9k5N+FqPZlzP7f7SeahetwV8T4eNXbK0yOizMtuAluZqzbbSZZ+MIpBt7+Mbb0kBt4KW
 UPDzVMSVcnLY4/Sqi+veETAVpQIZG7EvYsyn9cU/oL/6tMzl8Kx3yloToKovz0BeiiFq
 M4H4UmmIlHI8xlWw6br9Rb8eS9hxPgPs83b5Pd7El/ER+0MJKRBeVv8mOG05f5YMH2uj
 +vpG3uAQobezV70nMDQjj/J4kEoDaLBO/MXrrpLtA6mCNQCU7ozZSCea5N3DGgp2ojlq
 hB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866345; x=1698471145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1mRozPLloATOsE1zPRn/KSGBk/VdF2/1IvPJmxRsR8=;
 b=A46ykN1pJQ04VoahqzF25WrONLmf+LnsC59zzL3vEzkcJ9ufYZsL5dLnFMIq88SHUu
 QOxh5KNkDLTVu5HU84Wy+YjX6DLET3fQddydpM8o5OvMmw1hyQqVgiIHbZqQ8e5PhusZ
 krbPQ0aViSIalI31xshqSWZdobk5xN0rd6lcwCnNV53K0FdVIPQbMhUVhG1y1NVixKmy
 cajIBvAYMxFjN1IqMYcohO5JPUVkkuRSRg5j8paZxwRnznuZwMfLUDJCb89yCaXt8KwC
 gzapuxQ49W4cLhc5AEiSQo/MgNz1gzmPrnR37cpikShJYmj9Z0CC0PoD2SWB1azaRdt6
 VQtQ==
X-Gm-Message-State: AOJu0YzFzgMamqaEmN8CACzjSMqYn5DTGC0fSDntZ5TThirZZdGObbCm
 Yf91lUCcoqE/Il4IEJAGo8IAn7raXPJiVHsWtNE=
X-Google-Smtp-Source: AGHT+IFhULMDun4HmE33AJVha7VHrr8u2jH/eeOtcqxQmVQejNy27pIImxjV8O3vF7lGZeb1wPq+Dw==
X-Received: by 2002:aa7:988c:0:b0:6b5:ec98:427d with SMTP id
 r12-20020aa7988c000000b006b5ec98427dmr2983434pfl.17.1697866345241; 
 Fri, 20 Oct 2023 22:32:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 31/90] target/sparc: Move MULX to decodetree
Date: Fri, 20 Oct 2023 22:30:59 -0700
Message-Id: <20231021053158.278135-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/sparc/insns.decode | 3 +++
 target/sparc/translate.c  | 6 +-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 959397e62f..694d2c3648 100644
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
index bf41047f66..4ce87f59b9 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4169,6 +4169,7 @@ TRANS(XOR, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_xor_tl, tcg_gen_xori_tl)
 TRANS(ANDN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4659,11 +4660,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


