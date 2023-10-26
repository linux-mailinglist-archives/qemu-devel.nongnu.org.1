Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6351B7D79A1
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA0-0003oE-Hx; Wed, 25 Oct 2023 20:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9T-0001QT-0R
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:07 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9P-0008Cn-RO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5aa481d53e5so299672a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279781; x=1698884581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ht05l455lxmDw3bU8/EY1KEqMWEE3s1dKBaVsXGD9Q=;
 b=DIGoIWThDKKanJ7ADqq9P2YuOqg2/KcKDyrxTwEJN9VcDLoOLRSiRZBpZtBtO4+vKn
 s5D5G9ljhROgPfIrs6ry9qrsZOFzM/1XOd7vZMJK1yPouxNtWXxxG8//wQp3Fijtgu3V
 pad6hFe6CGH21ycbhehZIO8Mk0jmStzXfZ70+xTsWb1VV1YHflox3n3XFzZ7ElsAMr83
 OefLWrk3fBi2z95JRWM7oaLJOE935/KYzuPc4bZTX/kKQA3KNUcDy1qTWV1LeBOjWEj1
 8FV2NdPrxMzugk3xyaJepy+hVa2uqbb6xhdiamNHJAJ1ql0pBd1R5Zog/Q81gcXFcxBj
 ny1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279781; x=1698884581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ht05l455lxmDw3bU8/EY1KEqMWEE3s1dKBaVsXGD9Q=;
 b=Bs++xbZ0aSivXoJrfuxu6/rb8F4Dmjf/sIfKrde+LxKy/AcW0iUz0PZfRNU9lYkJy+
 z6/Z2EY3n/n7JxZEkbcoLvCbf6qsM/YDvgoQUEH1wvbuT+LdTrz90FhsDwiYjlSbEIG5
 85tI7Pe1KwVXXkeAvB3HAdKB0/oKYOVv57X2fscifKDDl1vIAS82G5bQ1qQLNJmdWdAV
 McX+OiN1ssByt9uwykgObn2B5UGLWAV8MuL0Uvvzinv5jzfquS4UZTIShEsOMUg0Dh0p
 oBv3BlPhkVdmqw4pLX/cwm33w0w+pm22S7QgAt5UxSLsHnZ4JEzCYDqnslyoafmGtTQE
 XzbA==
X-Gm-Message-State: AOJu0YzIrhx+gZ6ytCBYu1HqIxiXxj33HMvcR0LUkPjLRtzSPL9/8RVE
 2uPuWOfNFHUNd382JCuz7pI33xKZJ1n0kATmfOw=
X-Google-Smtp-Source: AGHT+IE+9qE+kzWhScnTu6Ad7aq74KSmU01TBjgCrwgE2JaAEdfnMhn0P+SXqoQtkOAlRaluqbX2+A==
X-Received: by 2002:a17:90a:19cb:b0:27d:4b71:ed17 with SMTP id
 11-20020a17090a19cb00b0027d4b71ed17mr14220184pjj.29.1698279781295; 
 Wed, 25 Oct 2023 17:23:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 65/94] target/sparc: Move ADDRALIGN* to decodetree
Date: Wed, 25 Oct 2023 17:15:13 -0700
Message-Id: <20231026001542.1141412-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 56 ++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b15ede5fd4..f70423895e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -252,6 +252,9 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
+
+    ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
+    ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d40d664f16..5d2be34135 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2747,18 +2747,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
     }
 }
 
-static void gen_alignaddr(TCGv dst, TCGv s1, TCGv s2, bool left)
-{
-    TCGv tmp = tcg_temp_new();
-
-    tcg_gen_add_tl(tmp, s1, s2);
-    tcg_gen_andi_tl(dst, tmp, -8);
-    if (left) {
-        tcg_gen_neg_tl(tmp, tmp);
-    }
-    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
-}
-
 static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 {
     TCGv t1, t2, shift;
@@ -4246,6 +4234,36 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+
+    tcg_gen_add_tl(tmp, s1, s2);
+    tcg_gen_andi_tl(dst, tmp, -8);
+    tcg_gen_neg_tl(tmp, tmp);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, tmp, 0, 3);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
+TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5148,21 +5166,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x010: /* VIS I array8 */
                 case 0x012: /* VIS I array16 */
                 case 0x014: /* VIS I array32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 0);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x01a: /* VIS I alignaddrl */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_alignaddr(cpu_dst, cpu_src1, cpu_src2, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
                     CHECK_FPU_FEATURE(dc, VIS2);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


