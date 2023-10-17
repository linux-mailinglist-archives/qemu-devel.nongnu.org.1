Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5347CBB0E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRx-0005yy-0h; Tue, 17 Oct 2023 02:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR2-0003ip-Sd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQq-0005CB-Rq
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:19:58 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ae2896974bso3333682b6e.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523595; x=1698128395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OjJ5AiU0xH1P7f5G96IVpR77EbKjVVCmfo3WnB7jEk=;
 b=sd3iGbSATMxPFFmfTr62O0QGrotYI9idbpZLflhA1pyELYN8UuyLJYnES1gZjPOH7p
 F5B1pd6m3QVqChGbAV3DvwXS3BINXQf9U2flBzIAmCmCiWDHNFBZRgZfeOWhkjFBQgHF
 X3x8XW1HJIX6dXaMK5GI2r1nhHSrwyEgj5UPrmJSxCUNvEPIUCtC6S161+2sEapjRNCO
 ulTDLxT5gR54/2S8PIt3y6Kc087LCl26v1pJXjUTdMrZjZ/OdUCGYR3o4M5QEWx/OAq1
 yb2qcj6ISHmSbp58Ir1Y7GFi5YfcU9pm59HxuvxjtNg3qoh3gABM4kT23bZYTny9eW/3
 PhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523595; x=1698128395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OjJ5AiU0xH1P7f5G96IVpR77EbKjVVCmfo3WnB7jEk=;
 b=FBgBQyMvDruhy19bGI+9yCWIS2I26Fa9xHvC9wc1OS1rKj3PRgzzJqI5z/wJ4wrqIK
 AyTQdzbERL+m0HrrPdGt/QIInTFOe4XjqW7ZKJ8DxKLWyTcOuXK0fO0tV2kR8g5OjUuD
 6bFKH8A9UIf6VvdQcFA839ohvRvvUce9mgOXXqJjHkbsvHLRyRiWhx4jqThX9wzJ4mj9
 6Qr14GTodBU8qNv3MsUM+PZ9roL7P0zpNa9aSzkLVsNK/Oo//DuZiy/UyjAhKFAfan3j
 Ge9iEgks5u0w15cPD1UDhX+rU1UUEKjX89m1bV3cZyAv5b3lT+wEahwVqEch8kRPPST/
 U0hA==
X-Gm-Message-State: AOJu0Yy+x0Wl54wjgehTuYC4n4Lg+VoBx1BrClo/YXPFftTkXaRdt2o3
 KOlnl/bf6RZx+E1v2glAwdEfgTF9Gv8CTta2ciQ=
X-Google-Smtp-Source: AGHT+IG5k1gaEFb6HVHnlNv3inO1v7lmnJjQYCNdS85KCT8mQdMydgIYO/KeLcNV+7X5JxSLTRNo8w==
X-Received: by 2002:a05:6808:30a2:b0:3a8:1c07:17d3 with SMTP id
 bl34-20020a05680830a200b003a81c0717d3mr1941995oib.19.1697523595569; 
 Mon, 16 Oct 2023 23:19:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 82/90] target/sparc: Move FiTOq, FsTOq to decodetree
Date: Mon, 16 Oct 2023 23:12:36 -0700
Message-Id: <20231017061244.681584-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 target/sparc/translate.c  | 44 +++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 249f03a075..0b54384af7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -266,6 +266,8 @@ FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a0506a91f0..ecaf1c02bd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1627,19 +1627,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i64))
 {
@@ -4890,6 +4877,29 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
+static bool do_env_qf(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i32))
+{
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
+TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5175,15 +5185,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xd3: /* fqtoi */
                 case 0xcb: /* fqtod */
                 case 0x83: /* V9 fqtox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
-                    break;
                 case 0xcd: /* fstoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fstoq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-- 
2.34.1


