Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE17C8F69
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPpI-0008Qr-WB; Fri, 13 Oct 2023 17:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpG-0008Pc-R7
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:06 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpF-0002Tz-7F
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:06 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2b1af964dso668645b6e.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232964; x=1697837764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d4OTimUwEnksdNnRK0H8Zulm+aaGFwh/dtN2Bqo4Xvc=;
 b=g6PwW6kn01+kRoJpGVigvM3AblKlKB2ctSattlt8QcJuG175VuSqUAP4oTNLqSTZvd
 dpzPbBvvV2o8u64jDRIxJx1b5Ghovqu6NbiDkgwwAW62LywjbSxxlDpEk6rfo6KDldtn
 zWiw0ym26COsH2kQmtmHiFOHviWe4tLpvDRTEuXOrSV/cAqLc4MyvZdkzPDs9MHtH5lI
 YVqsgA992Zt9fe+PWbeJdrFPg7MmbSQq0C0f3kk92O3Iodhm+Dvh/wbBpGdZkQeRdGgZ
 Nxz/hrMPMu0GmJw3qGDpoEIHx0BkQUjW/9217jnTaPYWgd6y49lSv325Q24v6OO9Fhry
 HZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232964; x=1697837764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4OTimUwEnksdNnRK0H8Zulm+aaGFwh/dtN2Bqo4Xvc=;
 b=qnoFuwCnlA3DVQEDD7RdyxfCRQkvXQDXJtzLCWI7P7CyiX8UAOwm2COgY3b6ZfEHrj
 YVsoxhBaCC2AVF2G5Jo9BmBIDoekUSTkK0e902zCSuhKYStBM32WKppZhoKh1Gl74kwd
 JE1aGNnxf1THSaIuXx3ty9l5NOr2jH8RTqHhe/An0Vue4Qb5gwr3c+9tjJCdG9m2Mid/
 dYYyL7bpuoYdXOpoIAdcnZrwRqAyU6TCrhazyOnEQZIS/UF9nQvJIUhAf0RGKTfZ3he6
 QkAuCEE9bnDgNpo6zD7RmutNiVh9/fDsIEx/R4fbFL+KVM34+GA8eG/yCcNGvl07BYTu
 FdCw==
X-Gm-Message-State: AOJu0Yw/tcoV4xE9sHFwZWBJbgZV5HML/6g+YQhZpgthn/8hgbMC75au
 IulWPcxbN2rnoTDOxywZQ+hKMjooYlfVy8Juj4U=
X-Google-Smtp-Source: AGHT+IFs3jM1Nyo1NyxdwcE+p6cVHtz9KY4zZhmLZCylj+Gvk9ZWqy4eCJVdKynIpRInf+MJovb7bQ==
X-Received: by 2002:a05:6358:e49e:b0:15c:e2c9:d1ca with SMTP id
 by30-20020a056358e49e00b0015ce2c9d1camr35028976rwb.1.1697232963847; 
 Fri, 13 Oct 2023 14:36:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b0068790c41ca2sm1123984pfb.27.2023.10.13.14.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 83/85] target/sparc: Move FPACK16, FPACKFIX to decodetree
Date: Fri, 13 Oct 2023 14:28:44 -0700
Message-Id: <20231013212846.165724-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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
 target/sparc/translate.c  | 55 ++++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9333c8ba3b..14daaa4a92 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -338,6 +338,8 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
     FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
+    FPACK16     10 ..... 110110 00000 0 0011 1011 .....    @r_r2
+    FPACKFIX    10 ..... 110110 00000 0 0011 1101 .....    @r_r2
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1a9fa18d64..a7e2bcfb53 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -690,6 +690,24 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_shli_tl(dst, dst, 2);
 }
 
+static void gen_op_fpack16(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpack16(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_fpackfix(TCGv_i32 dst, TCGv_i64 src)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpackfix(dst, cpu_gsr, src);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 {
 #ifdef TARGET_SPARC64
@@ -4573,6 +4591,26 @@ TRANS(FABSs, ALL, do_ff, a, gen_helper_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_fd(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i32, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FPACK16, VIS1, do_fd, a, gen_op_fpack16)
+TRANS(FPACKFIX, VIS1, do_fd, a, gen_op_fpackfix)
+
 static bool do_env_ff(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
 {
@@ -5247,10 +5285,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_src1_64, cpu_dst_64;
+                TCGv_i64 cpu_dst_64;
                 TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rs2 = GET_FIELD(insn, 27, 31);
                 int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
@@ -5333,21 +5370,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x02a: /* VIS I fcmpeq16 */
                 case 0x02c: /* VIS I fcmpgt32 */
                 case 0x02e: /* VIS I fcmpeq32 */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x03b: /* VIS I fpack16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpack16(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
                 case 0x03d: /* VIS I fpackfix */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


