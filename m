Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB07CBB09
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRp-0005hd-Tz; Tue, 17 Oct 2023 02:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR2-0003iL-Mp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQq-0005Bv-5t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:19:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so2672894b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523595; x=1698128395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpV7NV2fb6Fg7/mV9avD2pYgApmI6/Iok+MPeSBfXOk=;
 b=WJ9yJhPLShlvtwhxPk4fH9eRoHrg24Yph87chXMansCP6RvBc3Cj3IZyft+sBCawkz
 4kVU+dEh+d9a8N9Yw7zcgMTsGr5e1zVRF72qtTp4q0iPwgwCMaX8Cg5Tma7/GivlktRn
 fahJdCuXccuG4XDrnUPt3EwopqrazXX9UI2VZ/pEtmkT3dcecrZoKJtZE8W8TUNq1LUp
 k7Rad88NMQC9pOg3sLVNevVER8YVSj1yVt+RbBSM0BcZWlbPWC0n7JLyoB5lpy2tDPIk
 dY39CA32zwi9fDh1vWMZ3y2g0FIsXmVN2jfu3b2jmQF0bIyKSAFUmeXmHp6vLfud3F3v
 1APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523595; x=1698128395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpV7NV2fb6Fg7/mV9avD2pYgApmI6/Iok+MPeSBfXOk=;
 b=wUa2f7qh2VCxwZ1E/VQ618edxdnXWL5FLQvZ5KN9VJLsEaY91hHl3HkgQQJCjR6XD8
 h8zApgyARJioXzjPKySTOhFexg1YNatN/f27GBERKPL5A/Np3GbjpjX+NfIdMXeMgOOX
 1fCImzRRYA+mhgOygwpUKxvoLvGG9XRkEhQA4zteMY0zBYyvfqCD0p0KYrmurHwEL+Rc
 F/w0lfDsfv0/zB1YecbwSC+xTQhowJhFZ5mBgeedHhHZ/0uu6El8YUe9D84udvca0AoX
 iwt7EqTG/qEHs9gfFMFaJZ4soNsGpWrhqueB547FTLYL0h9sEd/NFwo0P6TiN+RqvHND
 ulYw==
X-Gm-Message-State: AOJu0Yw6oxHFnaXHz9bm6KchCgd72Z1oWxJthTeNkhHFEEhNkrq7X+Ig
 D9Z1ab+fO+l2jI4ZI+4ilAbH9/qhzrdyBr2AD9k=
X-Google-Smtp-Source: AGHT+IG1zZ6wXjvPze7YpD8ViArW7i5fgpaPLvkQBC7szwSvpBEyvSZ3rruorV7oEj4T6yHyxLIFsQ==
X-Received: by 2002:a05:6a20:54a6:b0:161:aef5:6395 with SMTP id
 i38-20020a056a2054a600b00161aef56395mr1243652pzk.24.1697523594713; 
 Mon, 16 Oct 2023 23:19:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 81/90] target/sparc: Move FqTOd, FqTOx to decodetree
Date: Mon, 16 Oct 2023 23:12:35 -0700
Message-Id: <20231017061244.681584-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/sparc/translate.c  | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index d890d97f12..249f03a075 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -257,6 +257,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
@@ -264,6 +265,7 @@ FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 3d073c8b22..a0506a91f0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,7 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
@@ -1626,20 +1627,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr))
-{
-    TCGv_i64 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i32))
 {
@@ -4879,6 +4866,30 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
+static bool do_env_dq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    dst = gen_dest_fpr_D(dc, a->rd);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
+TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5162,11 +5173,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                 case 0xc7: /* fqtos */
                 case 0xd3: /* fqtoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
-                    break;
+                case 0x83: /* V9 fqtox */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
@@ -5192,10 +5201,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x83: /* V9 fqtox */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


