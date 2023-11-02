Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9437DEA6E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:51:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcV-0007nM-MJ; Wed, 01 Nov 2023 21:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-0006Y4-PU
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb6-0001yw-Kb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so12963765ad.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888851; x=1699493651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T0Z6Bkp8qogdaS1vlOBNIHkBVhVkIpu5yMkTET5B8HI=;
 b=EJTeurHaCiGQXtWI0+tpyuWbhYJOOVnyXxQItwbBL0YQT7Ol0t37/jG75UqN1Ss+kS
 JWN/XdXdY19MsbhJZny4SX8Do1NbXD2iBJhlRdC9EFmayhpcB0KuSKMJuMpdvnZsWvlA
 twTs10w7F3pzHt44n/Rkm6RBnWliUJES2odQ5tILEy417kkX/zqZc8GlWFMagCZrk0uc
 hBMMWRWGM829PNrQ+PNANzUuEdifspkRBlw1c6BjQq6mbxNiCwRX8BOg26GAl+H9XpOr
 xrOS/XVlIp86J4cgy0DaW2UF/lz4S+YKwPGcgVFBv0lpeGOTREi1tFxsYPiYJEU9ns31
 b3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888851; x=1699493651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0Z6Bkp8qogdaS1vlOBNIHkBVhVkIpu5yMkTET5B8HI=;
 b=pFmDJmlY/i+h8npKJpkyiVr/rnpAeNA0A6SnEbPSVHe4/mz/hgvm4YDHBstO+bu85R
 mmq4bkoNeT+NMvh22s7nertDwLkkr+VVJr9sZHVedyqFwQP1Nw9fBpLM2L3jMGNetfg5
 RqtcpJO0kAI//4R5+ZI8wdlhvTDkNX/iriyTfOt/XZG9KEQmMyDbbAhdCo9YBi1ZOlSo
 VhVW04jEbOCRPrFGKiOChDctfABdXKCrLULxaYOqTF9xQFT1LQanfSK/Ybws7MyAPOQV
 Nuc7MyfwRYZ9Ds3D7mf8kvIOLWreJ4zJQHyB2vXFeeJlRaVlOK4wLP/Je+yA5+h+3MSB
 Ew/w==
X-Gm-Message-State: AOJu0YwX0rOedV8Xvr5abTQmP/omWOOGdPVOZ3rMq4vuAU6EgPeWZ4C5
 MNqth2NrcKgngw/Uqk0l/GmO4eZGElC5Yc5Huh0=
X-Google-Smtp-Source: AGHT+IHms9JqyWBn5N8wxGvsVoL1Cg4M7XODGTGUQObF4bUN7LCGXc2OcD4686Id0p1Q2ctuSiQI8A==
X-Received: by 2002:a17:903:41c2:b0:1cc:4a66:7db3 with SMTP id
 u2-20020a17090341c200b001cc4a667db3mr6641279ple.4.1698888851059; 
 Wed, 01 Nov 2023 18:34:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 62/88] target/hppa: Replace tcg_gen_*_tl with tcg_gen_*_i64
Date: Wed,  1 Nov 2023 18:29:50 -0700
Message-Id: <20231102013016.369010-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 59d172f355..f570b17ecd 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1338,10 +1338,10 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_andi_tl(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
+    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
-        tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
+        tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
     }
 #endif
 }
@@ -2382,7 +2382,7 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
                       a->data ? offsetof(CPUHPPAState, cr[CR_IOR])
                       : offsetof(CPUHPPAState, cr[CR_IIAOQ]));
     tcg_gen_shli_i64(stl, stl, 32);
-    tcg_gen_or_tl(addr, atl, stl);
+    tcg_gen_or_i64(addr, atl, stl);
 
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
@@ -2939,7 +2939,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
     TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
     /* Special case rb == 0, for the LDI pseudo-op.
-       The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
+       The COPY pseudo-op is handled for free within tcg_gen_addi_i64.  */
     if (a->b == 0) {
         tcg_gen_movi_i64(tcg_rt, a->i);
     } else {
-- 
2.34.1


