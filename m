Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE47CBAFB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKa-0000mu-BN; Tue, 17 Oct 2023 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKR-0000lN-Ch
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKM-0003wd-Eg
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c8a1541232so45565975ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523192; x=1698127992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cyZhTWXD8uswH5UFBIgKC9QPemzvcbCKADxfMZxTEk=;
 b=TqwhjCb/9Oy+I88WHV8ciEap2JG1H1OAyoo8eqXjSnHWdtqqTDVGL0YdbpAxPb6kWF
 RNcHi5VNNSdKddAQLl8Ixwprc6FQWqiKE4rQCnYQ6Lgdie64jlVHKbjVXdRJ5WckGexw
 9SpabrSc5oH4LEqfzhJBhcGPnUqWLoI2cOIo4lnn4LkoXg9y60uv7FGZlEK5Floh7ivp
 4v5O/6ipAkTGRAAahmclVWAbyr8jUiqWr5RvG0EqsXmZX06uGUQnqOD7wDmwLzPYIgP0
 e77AU09g1UR72zKfkVIWmoRIH6Iuclarly7rxKdnHh91wf1WW5402BAxaAjRGwDiwrE1
 pbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523192; x=1698127992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cyZhTWXD8uswH5UFBIgKC9QPemzvcbCKADxfMZxTEk=;
 b=nIcfYmiQk5sHzLoERsRsERN2220uM4bfchdL6DusK5TEGUGYyJTxecDQLM/imipf6j
 Bo9M0wN6eObDukgo3Zo5t3SXwFB0WRiye+m5bobklN+LTBXs+4FnY8p3/TcOex6diQJh
 llm659sNf7WKp9wO4lJy5Wx3FxX6uau4Z70JeITDmpNi1sXzepkXehHUpAob3K0g/7IU
 aiorklWIDMIks6rJNlmmbm2dM4Pgcp3QNgrF4W/Z1O0gmQwegbkLzM10vqeWY4ASujab
 HUKhlN9JJmp5BE1hegAovvgc3YFyPoxCCBHqE/V0YtrjCMf40sSSHpSovkzfqJKldrn9
 pTGA==
X-Gm-Message-State: AOJu0YzSDKh1n0lku1x+6MRXr5cX8bnFF6r0HTvj7HmdkaQLp8WXImuV
 aT9uJB3AOLWq+BZ2vKgP9xB3OTfUswosIeafB/w=
X-Google-Smtp-Source: AGHT+IHetc3iIoMSGQdPMeP/qQzCcSefe8xiGwEpf5UWRuTxaLZn4CD2SBLFJbhvPgRzKcQqbrxApw==
X-Received: by 2002:a17:902:f98f:b0:1c8:7822:e5c3 with SMTP id
 ky15-20020a170902f98f00b001c87822e5c3mr1140173plb.47.1697523192223; 
 Mon, 16 Oct 2023 23:13:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 31/90] target/sparc: Move MULX to decodetree
Date: Mon, 16 Oct 2023 23:11:45 -0700
Message-Id: <20231017061244.681584-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index abcee27fd4..d9474d2a20 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -171,5 +171,6 @@ XORN        10 ..... 000111 ..... . .............          @r_r_ri
 XORNcc      10 ..... 010111 ..... . .............          @r_r_ri
 ADDC        10 ..... 001000 ..... . .............          @r_r_ri
 ADDCcc      10 ..... 011000 ..... . .............          @r_r_ri
+MULX        10 ..... 001001 ..... . .............          @r_r_ri
 
 Tcc         10 0 cond:4 111010 rs1:5 imm:1 cc:1 00000 rs2_or_imm:7
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 27375c74ec..b3ce3947f3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4183,6 +4183,7 @@ TRANS(SUB, ALL, do_arith, a, tcg_gen_sub_tl, tcg_gen_subi_tl)
 TRANS(ANDN, ALL, do_arith, a, tcg_gen_andc_tl, NULL)
 TRANS(ORN, ALL, do_arith, a, tcg_gen_orc_tl, NULL)
 TRANS(XORN, ALL, do_arith, a, tcg_gen_eqv_tl, NULL)
+TRANS(MULX, 64, do_arith, a, tcg_gen_mul_tl, tcg_gen_muli_tl)
 
 TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
 TRANS(ANDcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_and_tl, tcg_gen_andi_tl)
@@ -4654,11 +4655,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


