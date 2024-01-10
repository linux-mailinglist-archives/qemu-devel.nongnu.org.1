Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E282A423
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKH-0004pF-Gp; Wed, 10 Jan 2024 17:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhK3-0004f0-6T
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:24 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhK1-0002v6-Dc
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:18 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-429c00bf0efso736381cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926716; x=1705531516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UglnfSI98W1O26WExoHEv4U96HoZn03cAysbwbueFqA=;
 b=XtCk1QobpOCT8gQGPWkcJUqcrTRbiNeaFDPHoXSTa1nmCxewq8jbTmP5UaAZBwJlnw
 e8jsHAUgwjF+BkNc0pRaNuiu21wYM6+odpZ/ZF+VTGbrAMWvx4oqRcL9ue2dqeV3moUf
 JUhSNQq0aMclNcJd4E2QU88lg2ofO5HaqAMUkqd/kV1Fg7xtSphbi/d12i7le69tuiDK
 ZEsX70xi7RJbg7ItZ/BNV55JYShQorSU0qSdAPl4odC7WrszUoMI57F5PXHJYilRgTxy
 O9Wmo267v51Wk+ixjMgNOvm4OO/cwAcLye8eOBcdl22ki+4Qk/ywAtGLWRMvs8EV5DT0
 uqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926716; x=1705531516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UglnfSI98W1O26WExoHEv4U96HoZn03cAysbwbueFqA=;
 b=VTwhkoD7m7KB31z0WvLoW1MjoE5e5OblJnj8bPj1oPJyeoDci4QBYzr984wIMIA8fj
 wC5xEf+l9VQGJHKbohBIj5Vo/QbEuCX58+TLuVCLQtHQmVifBoKL37Zk4GV6Fuvg0pzJ
 apfnNycNGA8tEPuDGOFY+hiP0vptx+oAfM+8s6XNVTpt/4bKgHOXKMIQoIG0muzYtcgN
 qDdljAXbvKURrxsD9kfp/1ceu8IGqoYUa837ciOl9Qwnu4+fQS2VZWOeOSQ8oIzbdcPd
 joa2p5jD4c47jvAu5rlai2VqfoNCxvxAwzxyAbaodqtf/IeTxwC7IzNtYiybemMaXnpQ
 NHhQ==
X-Gm-Message-State: AOJu0YxS2qZzC4ARDJKHzZqp7EFwZkjy+KFkzQnqp5iDUvKd3oCL+z8I
 6Mj9DEGlZP/FiA1XEZn/T+wsJlM/qd3z0MAKdhhaPIYgFWhDkK/k
X-Google-Smtp-Source: AGHT+IEMLGQF3NArf0UuRpkVsNCPecDhKLkSw2SS7v0uDIFDUsxoL8qP0sgLh/Z5xZRo5zIu0YRMkw==
X-Received: by 2002:a05:622a:1a90:b0:429:b349:65a7 with SMTP id
 s16-20020a05622a1a9000b00429b34965a7mr396964qtc.8.1704926716062; 
 Wed, 10 Jan 2024 14:45:16 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 08/38] target/alpha: Pass immediate value to
 gen_bcond_internal()
Date: Thu, 11 Jan 2024 09:43:38 +1100
Message-Id: <20240110224408.10444-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82d.google.com
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

Simplify gen_bcond() by passing an immediate value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 1/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108205247.83234-1-philmd@linaro.org>
---
 target/alpha/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..89e630a7cc 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -453,13 +453,13 @@ static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 }
 
 static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
-                                        TCGv cmp, int32_t disp)
+                                        TCGv cmp, uint64_t imm, int32_t disp)
 {
     uint64_t dest = ctx->base.pc_next + (disp << 2);
     TCGLabel *lab_true = gen_new_label();
 
     if (use_goto_tb(ctx, dest)) {
-        tcg_gen_brcondi_i64(cond, cmp, 0, lab_true);
+        tcg_gen_brcondi_i64(cond, cmp, imm, lab_true);
 
         tcg_gen_goto_tb(0);
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
@@ -472,11 +472,11 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 
         return DISAS_NORETURN;
     } else {
-        TCGv_i64 z = load_zero(ctx);
+        TCGv_i64 i = tcg_constant_i64(imm);
         TCGv_i64 d = tcg_constant_i64(dest);
         TCGv_i64 p = tcg_constant_i64(ctx->base.pc_next);
 
-        tcg_gen_movcond_i64(cond, cpu_pc, cmp, z, d, p);
+        tcg_gen_movcond_i64(cond, cpu_pc, cmp, i, d, p);
         return DISAS_PC_UPDATED;
     }
 }
@@ -484,15 +484,8 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
                                int32_t disp, int mask)
 {
-    if (mask) {
-        TCGv tmp = tcg_temp_new();
-        DisasJumpType ret;
-
-        tcg_gen_andi_i64(tmp, load_gpr(ctx, ra), 1);
-        ret = gen_bcond_internal(ctx, cond, tmp, disp);
-        return ret;
-    }
-    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra), disp);
+    return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
+                              mask, disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -533,7 +526,7 @@ static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
     DisasJumpType ret;
 
     gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, disp);
+    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
     return ret;
 }
 
-- 
2.34.1


