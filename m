Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC17D1B12
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ea-0003Kk-0U; Sat, 21 Oct 2023 01:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eQ-0002qD-9n
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:54 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eO-00018p-Kw
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:54 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57de6e502fcso906994eaf.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866551; x=1698471351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCBYXApxSIdghuI/qlMU2hqEbFXCl70ucXr5x/f3RzQ=;
 b=zpp+lWm1DkDRjSXa+YrRCb8c8quq093lIGNDRSr/zrUYsxVEuB8zSN5dIxBZxn6s4N
 MtceZYDadGoTeteKVj9XCDCUtfqSqJwSRhdqgDrlFnGj0eTlOdAwu8Wbo+IScBOKLpr7
 y+gtZJjPTO6Mq73Y4c3J8eutupd5YVDQIC718cOsMk/X4Idq2CPQvmQAnXRFLfVLmGlk
 MaJ/LXcUH0w60CXu10V2JM9Q8tKYBJGOnjs48L4cFQP/H1JbKSvI1vdsdpoiv17ioH0w
 Dvx8Usg1jDdKJF583+vYReIS8ft9IOvJLzT/o2KawRCHmB1BFLxaMbiB2SPDxhFqFcik
 G/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866551; x=1698471351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCBYXApxSIdghuI/qlMU2hqEbFXCl70ucXr5x/f3RzQ=;
 b=RiH1NzXGgj+MwO4VwbVBkdlOtSKbfOYcjP0Wr3GA76vLnrbKaYYyEGEbYIjjSv5gQJ
 W+eofVCRG9YaG2JhYtctQaUGJouRWpnUQ1O7lMGEr1mBG3DTSrDPN3O86GjWuDe2bcwh
 zjxFFs4tcx/hfXD/U+F8Y2uHM94ZqhU3+FHgRE2SDJaps7lnYR70H46ytb3Hs4jqctnC
 PZgGtdtTOn8+/8l5dm+nAYu11xBHw2uYuup7BzO3P8BxsX1q2XRhdcbswpGStFWyXPSm
 K2ADBmzBQpGB0BMYARiXTzcGrpPZdk2gJLSq618/zomxzAgmzaRDRsHdIQO489esUpLW
 69Tg==
X-Gm-Message-State: AOJu0YysE007El0Ty16GNFGkWpQExtwnmcfog4/bQJqwFn5jrhI0+jhj
 pkO+aJK1S4vHVNi0U/25xuwCymAM0voTjEqzmhY=
X-Google-Smtp-Source: AGHT+IE73SNCTC0bKxR9dIeAfSeyiVRgCZlOebBMXhWjUjGMh+ShOOsq5RciieAZG0vrtgZESwVy7Q==
X-Received: by 2002:a05:6870:2893:b0:1e9:da6f:a161 with SMTP id
 gy19-20020a056870289300b001e9da6fa161mr4749040oab.3.1697866551284; 
 Fri, 20 Oct 2023 22:35:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 62/90] target/sparc: Move BMASK to decodetree
Date: Fri, 20 Oct 2023 22:31:30 -0700
Message-Id: <20231021053158.278135-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
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
index 855627b55e..9ea5e09dfc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -255,6 +255,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
+
+    BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 92a6988fae..bccebfc953 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4370,6 +4370,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
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
@@ -4920,7 +4932,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5285,15 +5296,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


