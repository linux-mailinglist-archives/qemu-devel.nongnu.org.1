Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13597C8F3F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmX-0002cX-TT; Fri, 13 Oct 2023 17:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm7-0001Nl-DC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm5-0001XF-D8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso649714b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232768; x=1697837568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kTNjNuwiDDC9iwCgH8a1SDO2GFjbjTqvujftlbwQE4=;
 b=eC0t5uDp0W6ZzfXQAsK+ft3ELYV+2LM6v9/ZLlLr0IpYdF6XALky8JXUmKxXLH2gK7
 ZCjLnmmTkHIkzut4pheRQO5Fg5IpUAC13yOlzBf00+G3GvXvcO7jtaVuuc65UyP6ZFGr
 rddvRWTSDnkEATqDNMd01UoYJKXv2KUzTkOgHOY8Chjy2WgHAGs5xCvZQLtlurwANLLx
 v0ZH5d+v1DhLxiSAOMb5qA/QqJhIAgOHWkz2ZrC/JFZdWQSO+XR7mQFYeLdUKT7htbgv
 1P2W3OnEUGG4tnQzPynbgBKeiFtCuKBqMsxItByWwLEsvBwiedgSbVS5FVZ41khGjDy5
 vNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232768; x=1697837568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kTNjNuwiDDC9iwCgH8a1SDO2GFjbjTqvujftlbwQE4=;
 b=PvvodPFszolJse7JdarOXHYM+JThahjVe6YMS9qX1kA2fAZHvdfampalUSvm96ZJ2b
 W7EqIWNKfZ4OaNkV04yVFeXB9LtH2ZG04rtciJQijJkjStGbi0UNZ3rh/HJHXzfGW4/q
 4NzeT4rGHbCrRMvpF83qCEv8zPm+DDctvUO6YjdDqZ1duYhEMR+QrMfamUry4Zv0EbN7
 GwAIrZ/0TkRKyfervK6cqP0fB7rOvVKvx6QhL1BMtihLkbVDxu4rZtI5pOdylmL6O1s1
 eG5siV/i+UuLXBSZF6nqmIQta0GRr025pX2rc2k2Hhyt4NxtC3zXyACmauYMsjf9yYXC
 W6Jg==
X-Gm-Message-State: AOJu0Yw9JzhjxDlo49DtF/bTKg+/TATkq4reK69ldnf6EBg1oqqhFf3l
 xnRTZApn32wC2v61nrgT2J2/9kGxnhrytRdtmhc=
X-Google-Smtp-Source: AGHT+IGoYb+Ow6yz5oINzZtpw34AE8/wDc+7a3yDbSyiXXYNA6JIVg0QZa1QEObITRo8eu/yueiuCw==
X-Received: by 2002:a05:6a00:88b:b0:690:ce30:47ba with SMTP id
 q11-20020a056a00088b00b00690ce3047bamr30706888pfj.10.1697232768044; 
 Fri, 13 Oct 2023 14:32:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 65/85] target/sparc: Move gen_fop_FF insns to decodetree
Date: Fri, 13 Oct 2023 14:28:26 -0700
Message-Id: <20231013212846.165724-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Move FSQRTs, FiTOs, FsTOi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 47 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 541b95c2dd..5dd05bb211 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -239,6 +239,9 @@ FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
 FNEGd       10 ..... 110100 00000 0 0000 0110 .....        @r_r2
 FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
+FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
+FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 605a218255..bad929d2da 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1523,20 +1523,6 @@ static void gen_op_clear_ieee_excp_and_FTT(void)
     tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
 }
 
-static void gen_fop_FF(DisasContext *dc, int rd, int rs,
-                              void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4790,6 +4776,27 @@ TRANS(FABSs, ALL, do_ff, a, gen_helper_fabss)
 TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
 TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
 
+static bool do_env_ff(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tcg_env, tmp);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
+TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
+TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -4951,10 +4958,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2: /* V9 fmovd */
                 case 0x6: /* V9 fnegd */
                 case 0xa: /* V9 fabsd */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
-                    break;
+                case 0xc4: /* fitos */
+                case 0xd1: /* fstoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x2a: /* fsqrtd */
                     gen_fop_DD(dc, rd, rs2, gen_helper_fsqrtd);
                     break;
@@ -5010,9 +5017,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
                     break;
-                case 0xc4: /* fitos */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fitos);
-                    break;
                 case 0xc6: /* fdtos */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
                     break;
@@ -5042,9 +5046,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd1: /* fstoi */
-                    gen_fop_FF(dc, rd, rs2, gen_helper_fstoi);
-                    break;
                 case 0xd2: /* fdtoi */
                     gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
                     break;
-- 
2.34.1


