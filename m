Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634A7CBAF8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdOH-0004JZ-Vq; Tue, 17 Oct 2023 02:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNq-0003Tf-Mt
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:50 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNo-0004o5-4M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:50 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c4bad60a1aso3185612a34.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523407; x=1698128207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gYie/v6IqqLGja8COJ8WBxigcVna1e9VeJJzqC02sY=;
 b=z3EgRe9+wFYNajD9ne0+h7Araz/NCO4yyFQ0iIYy8+wRvPZDPnFXapweyIPD6dP4DX
 9llhv+qR00k6s0QIyIuW0Df0ibV93GZyoRqbv+ueAAFb6v+YVw+Xvwydzo2Vunfknn41
 WL/a51T2RIK6j2Ac3B5JqfoJ27KzRYLJ9mOsCB0VdIeP2uToGuLs5KbuyzmWqTRMLk52
 iaa9MqwM4eRg/eZeWSRh8c2n4xwfUkalZnEgjDxuc8HbLFZe0b/xtoifYk+6lpu0MXbD
 sx+Fsbdsw14DpkhuzpmFs8RC27ho2S39Afg2nOszdz5pcK77FokE7WN4P4/71ij3kCju
 c8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523407; x=1698128207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gYie/v6IqqLGja8COJ8WBxigcVna1e9VeJJzqC02sY=;
 b=jjSNvHt+yqj6h9Xq6kb6SyhhDzPSrvpyA7iR+ZIQHV4e8q0rf+szWdGzVFdreJh2pb
 KFB2SpqeZobNpP20Tl2e+g/Brm6lAsqHUMqChepR/COy5Di3BLRDPumWyTZ7xEwWhh2G
 AqwcqwVqbvWxvTkjXjseFhENhdmhOZruL71mTHrSqOIxctPEItbgf4aldhlYHJnnZBSy
 bPJ55htiV708+no6d0NNl92MYYs1GJoIVZCZJm+OmBiAaEHxNedK18aBV6fgXFeXge8b
 NwrPpRgYdVjXDCFEMrinnPzAS8CnQEXnbuISrADlGelNdezroM3ig9EREUsN6XD9SP3w
 /J2w==
X-Gm-Message-State: AOJu0Yw+4m6JH0map9echXS6+HJ4QYIYq/g2M+59OkcZLKCmNydAZgEa
 yt4dtsVdafjiXtWM2EJtEq+s6MivzaK0E7KrEMI=
X-Google-Smtp-Source: AGHT+IF19pXBJes7YF3biBzAQaPISb38UhxBkdikQhP/UwItRHx/CKac3MGIrAwln97aOXQfWjCPQg==
X-Received: by 2002:a05:6830:4106:b0:6c4:9fda:a1e2 with SMTP id
 w6-20020a056830410600b006c49fdaa1e2mr1974033ott.4.1697523406916; 
 Mon, 16 Oct 2023 23:16:46 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 72/90] target/sparc: Move FSQRTq to decodetree
Date: Mon, 16 Oct 2023 23:12:26 -0700
Message-Id: <20231017061244.681584-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 39 +++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fa95ca056a..7fdd8e37d1 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -240,6 +240,7 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b7eac4a6e5..ffcd630a91 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -71,6 +71,7 @@
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fsqrtq               ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -1640,18 +1641,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_ptr))
-{
-    gen_op_load_fpr_QT1(QFPREG(rs));
-
-    gen(tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -4931,6 +4920,27 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_qq(DisasContext *dc, arg_r_r *a,
+                       void (*func)(TCGv_env))
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    func(tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5076,11 +5086,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x2a: /* fsqrtd */
                 case 0x82: /* V9 fdtox */
                 case 0x88: /* V9 fxtod */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x2b: /* fsqrtq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_QQ(dc, rd, rs2, gen_helper_fsqrtq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x41: /* fadds */
                     gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fadds);
                     break;
-- 
2.34.1


