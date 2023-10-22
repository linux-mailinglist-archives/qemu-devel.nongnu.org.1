Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C69FD7D273A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:41:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwv-0006JD-4C; Sun, 22 Oct 2023 19:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwq-0005lw-6t
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:32 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwn-0007eY-Dw
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:31 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-584042a01eeso1795070eaf.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017608; x=1698622408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zf8OrxDYo30Q9MsVOMjNHW5+SKEG6z3OxXTmAdjyK0=;
 b=AVtmnDdcsPOfV5ruWMiUGxmkWwS7upIlcZZuaNqdEOBcWMvjJ5Icsvvd4Y2LnEw3Lw
 H6Acrep1RJw6dXQcXzROa0izXRqosOVpnjc4pIeNWGhfvcco2sN2oxywZS5cUrYhU/54
 Q8egDmsQEpDIqSs2BvJaJl82Jc59CRy/gQNcoTclV2rsYf/jGJuwCQhZTNIXkTgLrnqH
 exEkaPAJZQcBvbvJMx9kiMD6KfXKKCKz7EiBeKURrxbrkGs9uat/QZ9WXMdIcy6vwCK9
 ZHLLi4OReV7xXGwML72l/ZcjbUe/utVnMXZCKBpDIqKuX6a9ZHi+GxQ6E3OW6G/WKuP1
 ukbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017608; x=1698622408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zf8OrxDYo30Q9MsVOMjNHW5+SKEG6z3OxXTmAdjyK0=;
 b=shpG9eBTP2glm+pkMAgvkRUhxOghdDuWOTbCnzblH4+Bv6LW4Hts7OmscVMzZZHYP9
 4qhaI5g09/sEG612OaO2DbJpAvc7S7vys5ZKV6kb5JDTkYZgBCJfVCIBe3LhPIdmKD9G
 +va8a7yq6Yz7aDF8Odfocv3QHVYTmDq+FHC9CPDvTmW7IQ7vABLBLVwqbvcKlba0jOpC
 C7429Hiy4DIn03KKLq2DOrxgzWwXK76xYHq3Su99tR+uKa5GWxLrQBcLiSO3phigU5g+
 u3R3qjonfDz35B5BiG3iHHc/rAe41U6BE2hX+aLYbjITY1VAkeLm6IrKjZBknhUAecm7
 O7pA==
X-Gm-Message-State: AOJu0YwuRJ8/rUHxS0y2KN1xsT6228yfJYP0y/0o2qhMY93qxv+zXhVr
 1Pcrt/3uPr1yUsw0QO9Q5smeacrqyYSZJe9dhBs=
X-Google-Smtp-Source: AGHT+IHoZOKKvQ8G0wAPYlHFVFbw6qI0z3RJK5pKJE4HB6eBymVyFR6GH0IM2j0ZDiHOChd4YfsL3g==
X-Received: by 2002:a05:6358:3417:b0:14d:b8d3:97e5 with SMTP id
 h23-20020a056358341700b0014db8d397e5mr9468150rwd.20.1698017608192; 
 Sun, 22 Oct 2023 16:33:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 64/94] target/sparc: Move ARRAY* to decodetree
Date: Sun, 22 Oct 2023 16:29:02 -0700
Message-Id: <20231022232932.80507-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 57 ++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a9630509bd..b15ede5fd4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,10 @@ RETRY       10 00001 111110 00000 0 0000000000000
     EDGE32N     10 ..... 110110 ..... 0 0000 1001 .....    @r_r_r
     EDGE32Lcc   10 ..... 110110 ..... 0 0000 1010 .....    @r_r_r
     EDGE32LN    10 ..... 110110 ..... 0 0000 1011 .....    @r_r_r
+
+    ARRAY8      10 ..... 110110 ..... 0 0001 0000 .....    @r_r_r
+    ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
+    ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5197f1a806..be298f185e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -722,6 +722,25 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+#ifndef TARGET_SPARC64
+static void gen_helper_array8(TCGv dst, TCGv src1, TCGv src2)
+{
+    g_assert_not_reached();
+}
+#endif
+
+static void gen_op_array16(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 1);
+}
+
+static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_helper_array8(dst, src1, src2);
+    tcg_gen_shli_tl(dst, dst, 2);
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -4208,6 +4227,22 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv, TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src1 = gen_load_gpr(dc, a->rs1);
+    TCGv src2 = gen_load_gpr(dc, a->rs2);
+
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
+TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
+TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
+
 static bool do_shift_r(DisasContext *dc, arg_shiftr *a, bool l, bool u)
 {
     TCGv dst, src1, src2;
@@ -5107,30 +5142,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x009: /* VIS II edge32n */
                 case 0x00a: /* VIS I edge32lcc */
                 case 0x00b: /* VIS II edge32ln */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x010: /* VIS I array8 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x012: /* VIS I array16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 1);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x014: /* VIS I array32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1 = gen_load_gpr(dc, rs1);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_helper_array8(cpu_dst, cpu_src1, cpu_src2);
-                    tcg_gen_shli_i64(cpu_dst, cpu_dst, 2);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x018: /* VIS I alignaddr */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1 = gen_load_gpr(dc, rs1);
-- 
2.34.1


