Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E07D2723
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwu-00066D-4z; Sun, 22 Oct 2023 19:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwr-0005zn-M2
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwp-0007f3-BW
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso2599685b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017610; x=1698622410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2uiFjB7wZ3QcG+U3cbOpLr5qA6cMv9LYi+QqKoNBLQ=;
 b=qMscsYqHoQiGIMCoFDwA53LFP/2Ww/sHGZvmxXWCo9f/jSO7XCY1gSklkm95emolAu
 IaX/bwmr7NwZJWnkZTgYUxcT9TEwzt3l+aVCEWD1IEK2ZPnUbpHaMyBRhsuucHMKHvsi
 jFnaYoi3OW7vaHDB9fIRaPGbNLFa1CiMfp1hNIhphAUoyxgmeR6df3sB9XbLGaM89xCQ
 5Al2PYBGI0a8hNbANtunzO1UvCuMZJJz+tPRxDzQWvZXHp64GFXtN/P4YvA2jWi91Zuv
 atChklyKLqliKn/FSCyHXFIh2SFKafFDr8TKC/Sl2MyhuWLbE0WHOyNQ81j9KWMlawMf
 AMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017610; x=1698622410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2uiFjB7wZ3QcG+U3cbOpLr5qA6cMv9LYi+QqKoNBLQ=;
 b=dFvFF/+FmScvCV7P6jUHyeN2zggsKAs2RsN4sK6ZzTRfbhp+LwXxbgqfFUMGlIJKY3
 Z2aDNZJkdwXZLE/3j7LPe4Z84WGteGY/QLvfpqeeh1z4dO1k7o9EhyzQjDYGaOTLn/ST
 BpISlGZ5PdI74RnV9I7JU/+5SBZ4bIjLlin61QcTjAvGIuz6MVz3n/5tjKv3zYbmfoZK
 VAVsvk2ny032PqrKtP9RaB/aHVjyZyp44aRw7BYvKrgmV1kbEdKJ8C5omVzRJy3I7lMi
 dxX6bSv5O0qD1cfRm26EwoYPcfrshfDm6Nt3m95QgMFjyAgeUqW3PKslg0FU6i2zlabP
 2icA==
X-Gm-Message-State: AOJu0Yyt/m/2/BDtwUb61X6LEYWexIYeVB61+oWG8OkioTU+1zugtCZS
 DWma+yNiDVuno6r2vVq3mWcmDsIg/Ew+yjwV1OA=
X-Google-Smtp-Source: AGHT+IFNP/SStYIMxkwS1tV5IMuu/fbYhh7GjY29ADggNanpcb8WJz1rMUiQjsJAhHfmvvcvkLg7Ag==
X-Received: by 2002:aa7:88cd:0:b0:6b8:a6d6:f51a with SMTP id
 k13-20020aa788cd000000b006b8a6d6f51amr10091072pff.31.1698017609988; 
 Sun, 22 Oct 2023 16:33:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 66/94] target/sparc: Move BMASK to decodetree
Date: Sun, 22 Oct 2023 16:29:04 -0700
Message-Id: <20231022232932.80507-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
index 6a8835b8cc..922ced3b4b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4261,6 +4261,18 @@ static void gen_op_alignaddrl(TCGv dst, TCGv s1, TCGv s2)
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
@@ -4800,7 +4812,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 {
     unsigned int opc, rs1, rs2, rd;
     TCGv cpu_src1 __attribute__((unused));
-    TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32;
     TCGv_i64 cpu_src1_64, cpu_src2_64;
     TCGv_i32 cpu_dst_32 __attribute__((unused));
@@ -5165,15 +5176,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


