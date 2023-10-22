Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB57D2141
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWZ-0000mk-SG; Sun, 22 Oct 2023 02:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWH-0000c0-IN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:02 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRWF-0001cG-Q4
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:01:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so1809057b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954458; x=1698559258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JohjTeLgxEEBwOOQtITWo4pQmKo+Yz9DXG7dwEjVRi8=;
 b=IQYq7JaOyyrrtOaHjJ+FzC3Bn7oUhLMPINYzxljxmHQuOgWa1pEB8ozkw/zw8Jv1VV
 SCEMN0z+TqfZOH1D0NST66XLCA2LiHKOklO7mtFzEEgaq7cX2xH7kVCExSwsTvXIMi6Q
 W/mkZXLAekagwaDwW21z8i+FSYSdlR6KetX+KeYKTm8k6wmhDR4b3V/sRtkRlIkuPAiu
 UPfu494F5iRTQOyGPS3Gl+xZ5DJyMoesthozifa6viYF6Uep1pzYR+DVAGnnFpFuzBIS
 hrEuqRjJ7no4M/98Wb8rNpJqS7DeXpWDbcZzmnc7BQ3xodhpJobBjEeaHGgVUDViqPLo
 xdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954458; x=1698559258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JohjTeLgxEEBwOOQtITWo4pQmKo+Yz9DXG7dwEjVRi8=;
 b=oel/oqbyRhqU+4F+fs8gomBab4dFMnsXFGuRU+W6Dhnezr+yMXW/vhoWAAUqnY8q/f
 n0zrIkjg4nEuja6Rn/qHCW1v3joGVrtd3g3tdKbJr6nZn70WZ8cWhR4eWvyysr1RlVlH
 0zRdMeaK40Ep3bEMwj2ApNxr/+oLx7Xd5oK+pFSTZ8IfjdqQTQya+aAG7fVmWDR6VanX
 WygjZGFT8MQRnifBIYaxTdaZCPBpL/fBEgkesvS6UwHpl6WNgVzKRdR7HvVZoyfnrICP
 SWNI4CV3Kqa91ZZ4k5rYQmsM+h7nnfm7viH60KGbYOfy1ot/7GKJbsvGYXH6ohUlnsxx
 Ny3w==
X-Gm-Message-State: AOJu0YxzzXVvzppv5fvLi9vWDKlSgP8su3wqmxrVNm6+X4QEta9cspdv
 6F+OUNsqdp+xKrSa6kmCacoX6rggk58fpDylEA4=
X-Google-Smtp-Source: AGHT+IHkW3EFB0fPhXzX2034CSMFBUgHpw2TGsUZ32XtrBQZtbjpYGWytKGwVHieye+rh2oYVYadFw==
X-Received: by 2002:a17:902:c401:b0:1bc:5924:2da2 with SMTP id
 k1-20020a170902c40100b001bc59242da2mr6599964plk.56.1697954458592; 
 Sat, 21 Oct 2023 23:00:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 31/90] target/sparc: Move MULX to decodetree
Date: Sat, 21 Oct 2023 22:59:32 -0700
Message-Id: <20231022060031.490251-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index c87125a328..be00bd00fc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4210,6 +4210,7 @@ TRANS(XOR, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_xor_tl, tcg_gen_xori_tl)
 TRANS(ANDN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
+TRANS(MULX, 64, do_arith, a, 0, tcg_gen_mul_tl, tcg_gen_muli_tl)
 
 static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
@@ -4700,11 +4701,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


