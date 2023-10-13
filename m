Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DAC7C8F45
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm3-0000f1-Rd; Fri, 13 Oct 2023 17:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm0-0000Ni-4z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPly-0001Rx-4l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:43 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so819204b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232761; x=1697837561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aG12dm4H7LGm59k37NqP0UjWYK5kSkeXIcoPQWQ8b0E=;
 b=lEkVXB5waKLLmO/ZFz+7xsvLvdxlXryXsTD5f8RV750fV1WfN+0urq0vKFfNSKv4Up
 TIhNoLGFyEyxYC0YI/18nl9Lbe2Y3ON9ThKm5sttqkig7iRm6VI6/Y1mQQUWAgDm4yfS
 GxXbv1e/qZ8Kfru5Pflt4N95Cn9f6/SljMQW2Ku1nkJ+qP5BXUIyXyTGk6P1ScO7pFYs
 VrF0Rk0ZbOj8LEjsbzQ8Zg4+cmQWKnMcA13RXlxuP0iWEiJ5x70M51l6PWvaBcwVNGFY
 /+KLihLncpCFXttTBv/dJs07GT+VG+zeiUouOrmXh5MA6skXrNF9yh1oX+s/iLznc0Qw
 jBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232761; x=1697837561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aG12dm4H7LGm59k37NqP0UjWYK5kSkeXIcoPQWQ8b0E=;
 b=Ml/RRbnReZ8Jimy7Lq3fuBAMonmxU3BfkROjwE6Se234foVbefllJ6EA0/e2YzyNfP
 NV80QV8juAVO4TnOa55MujUd+M4JDMV5qeoD3JeQ8WVCaiqBY9jMxzJIv3SAc1xP/hrR
 rr6moRHXBV/qgsE0BmOhlL1luDBQThBakbPBaEqvfh4ObkaNHVEMH02S8znP1SB+PFB2
 kthFjgIuTX4Uhq9IBVLkhAu1j5kyU1DylZLjPbvkEb1ZZWpVRcTOPQqQATbOYecUYX3s
 mNHdBiIefmPgd9R3w4b+mexQpmWYnwhsUTgSaQBjpzaTVNGIFppEDiah5jIVo8BYPRqS
 +A/w==
X-Gm-Message-State: AOJu0YxPC//xDGriaMTuUa/QAEhbIGjDuXRiLc7OKRmZi9kVL+1Jb0gp
 jXRZzqBiowJtf86hDy2DZmykgJejPP3ugmBL+UY=
X-Google-Smtp-Source: AGHT+IEbnGnmhqie5aTPIp6PHeRTv2I+nK2Cyq7BsKgC3wDWuNy7K09L28vlENcnuA18C9iksMhUhQ==
X-Received: by 2002:a05:6a00:14d3:b0:68f:c261:ddfe with SMTP id
 w19-20020a056a0014d300b0068fc261ddfemr31381061pfu.28.1697232760813; 
 Fri, 13 Oct 2023 14:32:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 57/85] target/sparc: Move BMASK to decodetree
Date: Fri, 13 Oct 2023 14:28:18 -0700
Message-Id: <20231013212846.165724-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f6ac8672c8..1418e45172 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -249,6 +249,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
+
+    BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0392ef7cda..d0efe9f72b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4294,6 +4294,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
 TRANS(ALIGNADDR, VIS1, do_rrr, a, gen_op_alignaddr)
 TRANS(ALIGNADDRL, VIS1, do_rrr, a, gen_op_alignaddrl)
 
+static void gen_op_bmask(TCGv dst, TCGv s1, TCGv s2)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_add_tl(dst, s1, s2);
+    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, dst, 32, 32);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(BMASK, VIS2, do_rrr, a, gen_op_bmask)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -4823,7 +4835,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5188,15 +5199,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x014: /* VIS I array32 */
                 case 0x018: /* VIS I alignaddr */
                 case 0x01a: /* VIS I alignaddrl */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x019: /* VIS II bmask */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    tcg_gen_add_tl(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_deposit_tl(cpu_gsr, cpu_gsr, cpu_dst, 32, 32);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-- 
2.34.1


