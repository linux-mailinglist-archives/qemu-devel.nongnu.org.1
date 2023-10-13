Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52D7C8F64
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmD-0001yM-DV; Fri, 13 Oct 2023 17:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm9-0001br-6m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:53 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm7-0001Xn-9z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:52 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c4b9e09528so1604689a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232770; x=1697837570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqCqC4DlFu4JsqRYhv8fNVQFIpbt1Oh75jrfAYFYWQA=;
 b=EUG3Hh0Stq1p6gWU0Fte0hB+9sD5dve5JEmTO26mXDGJmTE3FW0gf2li/G+aNBd2yV
 +oTiD4uPM3oKViP0nQ6w1xWlzZ7KS7yx93GP7dt3rmklGgx0+HtMuSnRO2TRs8c7J96R
 k23GVWq5/Nsb7zQKZL4VlFplVaKSJuOW6c3JQndBQOwnRomwjlZ10lqQQ6GXPceM/QcA
 PjRFCs3kOfBSy+Kh6BeK/I+qAfJKUDonX2ygz4dz8YyBpyY5ZzFiTQVc61p19OgT9+i+
 MEmOWq9m5shttZM23fw2GEzkb/lfnsTsvhtYW7jj3iugafKBSyzbz6w2Xksr5/doMYS5
 lxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232770; x=1697837570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqCqC4DlFu4JsqRYhv8fNVQFIpbt1Oh75jrfAYFYWQA=;
 b=Aa/P6IBAveHTn8hawwkvNtcxXzzNFlXiIJZoZhCzSbObpm1qNNIe7ruesm4D3DJGlV
 NuzA7z4V2bus36BJ5o+fP2FsXaov0HAV45KLuc7uheDHyiQRP4rYbim7hCAex/LBwiXG
 4gs7vXVF9egQVbhdiyns60WwakCgTqwA/nZR+b5Mqv1ifybuZzRXosdVLbVN2YQ2gDFj
 SXEuh6RNCGfBGMp9904+BoqoMvyKArfSigfQNh5ZuMXr/i2MU30szAGxvM9Ipk4m1lUX
 l6b5/Wg19OsqbjOgdCG6B0kKWgE6/GC9yhigyeO8ru1yVtpVi5QLAbzROvo+B5RCrRrT
 vThQ==
X-Gm-Message-State: AOJu0YwuQF0eMGikmB3M5VPldJ3wIIQzzu2cscSCOmAZjLwuQgVw8aLO
 oZduoyUNRB8CdwM1TmSRXxAXxFNxvClf7zeT7Wo=
X-Google-Smtp-Source: AGHT+IHXaBGzpgY73LtX/3hBegRLthIE9JbDIlLdUqk/OtGJXTY+H60kuzZV57VefSZ7b5K8GLW/DQ==
X-Received: by 2002:a05:6830:1d47:b0:6bc:96c3:b6ce with SMTP id
 p7-20020a0568301d4700b006bc96c3b6cemr29008902oth.16.1697232769979; 
 Fri, 13 Oct 2023 14:32:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 67/85] target/sparc: Move FSQRTq to decodetree
Date: Fri, 13 Oct 2023 14:28:28 -0700
Message-Id: <20231013212846.165724-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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
index d3badc6db3..31d84f0cb3 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -241,6 +241,7 @@ FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
 FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
+FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 23b287cd38..d318c8a6e3 100644
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
@@ -1555,18 +1556,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4829,6 +4818,27 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
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
@@ -4974,11 +4984,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


