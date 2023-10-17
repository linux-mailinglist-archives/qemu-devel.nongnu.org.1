Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC697CC355
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjLj-0002xP-T2; Tue, 17 Oct 2023 08:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLh-0002rE-Hf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:39:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjLf-0007Ak-Sj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:39:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so62815685e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546338; x=1698151138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJX9i0nIU+Mw/wIFVSG+iH4rzUP5e2e0zAqC7vjLugA=;
 b=fYBLYVWA71l31ocam9Zj3UnX6ykqmMNWskK1bQOpqp1TFX1EOCd50HRDcE90MD9ctY
 U0LX9oSAFjGQEttRVMZH5TEO+9KEvI/AS7WWNkEEoOQjsA7gT9ijliCUuCAnLjy2NZCD
 jksbLRB+MAi8cFn9YYfBoRHk0DN1qOsZ2HCLoyvHyes76KDGdUxk2pcBrAlfyac1S/G8
 r3PR6yduanLD4frfAAItw2nQE4hmsdxqXVFoetChp+KVZxITMAiXVg7k6Bjs3WN9WvpU
 6d0vgeWWG9C9Y3hN1z4CUUNccGD7sgOlNSTZgTu90gY1Rqv/ciIb2dJLtvtbzVVvJTi0
 sURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546338; x=1698151138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJX9i0nIU+Mw/wIFVSG+iH4rzUP5e2e0zAqC7vjLugA=;
 b=lWCl3MHOiO8Ytd9cR0y6IwCRoqNXCsIqaQ8DgVrK7CYu689FQEE+1bYNac7GDxA8Ew
 2ojPHKAFFJTKq6KJwZCVOeBd39UycCmWUa68ocn8JcLCeaWfFzIWDJYOV11Nk1Bfkb4X
 C/Rg/H3yqhF0G69B/K5i7FbBVNs4rZY0W9vRMBUujnKs8ni4PQOuIVqbGJ/7KzqWrKEE
 oLWzeKi8sgtGZ2ho3+NAb3AZoQAMgT5OGWwkgcT3qQwBDSXiimQWypJKUdmp+yC8sDFq
 SiRoGCtUl34ptl1cLLoUTG0Bocbct5L+RWNBCYjJEUp33VbwqAUAbtZObp+XqKhaW6hU
 yB5w==
X-Gm-Message-State: AOJu0YySVRnnbNr9CoH4N6qE+rYs01hw8pbdksofnFCMi/Ra784XNk6P
 28rzyrNg4N5lJZXtl9ngc15+tjce3cxOQdO6+1mQKg==
X-Google-Smtp-Source: AGHT+IE6LfPyYoZxfFRmNlTm3Hl0IjW5HMM51KyNhDpXPo9nf3KOz5cS7p1doR0DKM4KZKhc9SzOCg==
X-Received: by 2002:a5d:4b50:0:b0:32d:9fc9:d14c with SMTP id
 w16-20020a5d4b50000000b0032d9fc9d14cmr2035478wrs.47.1697546338173; 
 Tue, 17 Oct 2023 05:38:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a5d4383000000b0032da022855fsm1593717wrq.111.2023.10.17.05.38.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 05:38:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] target/loongarch: Use i128 for 128-bit load/store in
 VST[X]/XVST
Date: Tue, 17 Oct 2023 14:38:48 +0200
Message-ID: <20231017123849.40834-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017123849.40834-1-philmd@linaro.org>
References: <20231017123849.40834-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/translate.c                |  6 +++++
 target/loongarch/insn_trans/trans_vec.c.inc | 30 +++++++--------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 21f4db6fbd..c6edfc800f 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -61,6 +61,12 @@ static inline void set_vreg64(TCGv_i64 src, int regno, int index)
                    offsetof(CPULoongArchState, fpr[regno].vreg.D(index)));
 }
 
+static inline void get_vreg128(TCGv_i128 dest, int regno, int index)
+{
+    tcg_gen_ld_i128(dest, tcg_env,
+                    offsetof(CPULoongArchState, fpr[regno].vreg.Q(index)));
+}
+
 static inline int plus_1(DisasContext *ctx, int x)
 {
     return x + 1;
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 98f856bb29..dd41f5e48e 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -5285,7 +5285,6 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv addr;
     TCGv_i128 val;
-    TCGv_i64 ah, al;
 
     if (!avail_LSX(ctx)) {
         return false;
@@ -5297,14 +5296,10 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
     val = tcg_temp_new_i128();
-    ah = tcg_temp_new_i64();
-    al = tcg_temp_new_i64();
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    get_vreg64(ah, a->vd, 1);
-    get_vreg64(al, a->vd, 0);
-    tcg_gen_concat_i64_i128(val, al, ah);
+    get_vreg128(val, a->vd, 0);
     tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
 
     return true;
@@ -5342,7 +5337,6 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
 static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 {
     TCGv addr, src1, src2;
-    TCGv_i64 ah, al;
     TCGv_i128 val;
 
     if (!avail_LSX(ctx)) {
@@ -5356,13 +5350,9 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
-    ah = tcg_temp_new_i64();
-    al = tcg_temp_new_i64();
 
     addr = make_address_x(ctx, src1, src2);
-    get_vreg64(ah, a->vd, 1);
-    get_vreg64(al, a->vd, 0);
-    tcg_gen_concat_i64_i128(val, al, ah);
+    get_vreg128(val, a->vd, 0);
     tcg_gen_qemu_st_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
 
     return true;
@@ -5484,18 +5474,16 @@ static void gen_xvld(DisasContext *ctx, int vreg, TCGv addr)
 
 static void gen_xvst(DisasContext * ctx, int vreg, TCGv addr)
 {
-    int i;
+    MemOp mop = MO_128 | MO_TE;
     TCGv temp = tcg_temp_new();
-    TCGv dest = tcg_temp_new();
+    TCGv_i128 dest = tcg_temp_new_i128();
 
-    get_vreg64(dest, vreg, 0);
-    tcg_gen_qemu_st_i64(dest, addr, ctx->mem_idx, MO_TEUQ);
+    get_vreg128(dest, vreg, 0);
+    tcg_gen_qemu_st_i128(dest, addr, ctx->mem_idx, mop);
 
-    for (i = 1; i < 4; i++) {
-        tcg_gen_addi_tl(temp, addr, 8 * i);
-        get_vreg64(dest, vreg, i);
-        tcg_gen_qemu_st_i64(dest, temp, ctx->mem_idx, MO_TEUQ);
-    }
+    tcg_gen_addi_tl(temp, addr, 16);
+    get_vreg128(dest, vreg, 1);
+    tcg_gen_qemu_st_i128(dest, temp, ctx->mem_idx, mop);
 }
 
 TRANS(xvld, LASX, gen_lasx_memory, gen_xvld)
-- 
2.41.0


