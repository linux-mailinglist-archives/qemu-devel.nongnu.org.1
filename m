Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADA7D2178
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaL-0001ou-RK; Sun, 22 Oct 2023 02:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa6-00012I-Q8
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:58 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa3-0002HH-TS
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:58 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-584042e7f73so1416955eaf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954693; x=1698559493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/eF6Q1p9hNhFbCjsK4WyimB14kKHitG94P/DKFJk6U=;
 b=OJYYggwLNI+9ovuGSKjOaDELVJTsMPermPfhnjTKR0xczjOe/CZnFYxhC5OrIwA1jr
 CfKRsF3JEWxtso1jt0NKjIgzEDbnq5j1BMDRvM8oi79d9mfGcVZ4c0d3i4/1QWdMbttg
 Yyxlucd3eMv2bDwUBPoNlhPKqmekin0X+AQiMhpezxwh5x9K4NKCzbqU79402Z7s8L5B
 1bRNFZB2OEsPwhDU3hj50IDZISqvEwgSZPNe8w6ZB9+fsrgrv1awK3TAn7dADvKusAOX
 i8jY5ZbL8taA0PW4TmrdHIBSbIx2hifNMFXgMRApLKjlsj2InzDICl2mkUZM0htOJRCX
 Qvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954693; x=1698559493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/eF6Q1p9hNhFbCjsK4WyimB14kKHitG94P/DKFJk6U=;
 b=Qa4Wtbi60UP5YBrA8tDSLTQkTIWjrjZXjiEvdkBjIstB7tYXLswh+gV5JW+/7x34t/
 cgLU14smUTI6J64rmz9dfrIdvq3R25ClhMhSfNisnRO66imSh3eJtjoe+AesxHqVPatk
 1ZHYwJKpACBFq2LBYbZlfGa1XM70t/pMUQmaWkBih9pSCmKCabA5+6IUjDIG+hETy51W
 OrSSgDwbMPa72DD/pqQX5REw/Qg919KbCze/wEtpz0K1BZn+SBoenhe/NOtjrOzr6Q+L
 9oB37cUVSwtWD6KY8N6A2+Hb6CWSmTef4yke957ow6wkDJ+ym3C7qkGoDQRFmEZUWTrW
 Cmcg==
X-Gm-Message-State: AOJu0YztG3rdPMK0zhy6P+96Zk6dl+gBkxAXM2pL7S+PE9mBPq/nSaej
 WrlEhFK9u6U/HXWpsk+XtYwJqZCvChFBqW5J1QU=
X-Google-Smtp-Source: AGHT+IGtoNl4EiNkRsJHlmu07Vl7/72s+ORfSTInM3p/sf80D5RjRWIl2kmu113rjqvY7KqB8wbBDA==
X-Received: by 2002:a05:6358:7295:b0:168:d282:90e with SMTP id
 w21-20020a056358729500b00168d282090emr1648384rwf.5.1697954693630; 
 Sat, 21 Oct 2023 23:04:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 62/90] target/sparc: Move BMASK to decodetree
Date: Sat, 21 Oct 2023 23:00:03 -0700
Message-Id: <20231022060031.490251-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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
index f70423895e..db372573a2 100644
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
index 9b9281feb7..f91b7ae0c0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4413,6 +4413,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
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
@@ -4963,7 +4975,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5328,15 +5339,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


