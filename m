Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3857CEA83
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVi-0002Dx-M9; Wed, 18 Oct 2023 17:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVf-0002CW-51
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:23 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVd-00053Q-Jc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:22 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6cd1918afb2so460729a34.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666120; x=1698270920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kK32N3vgLhgiOtEEROoXYbcFL4Ddcs6GJ1O6rcXX12s=;
 b=fQZ1dvXwbMAU8bVaEqQyqB5sNx2hblDRJpoc7fUfluVqSCjyFEannUQO4quXWb9LjS
 pxmxC7pLW7cd7GaqJxVA/oVE7rUMmNGMIN3paXALSeULkSQ7vELdyT+aBmQDqMZHMCI8
 7TtRewvzGbbRteix8DPKVAVvJD4sX1wyzI00A+AowIoJLGTc0SVo5UEc8muho3/HKXcF
 OR4Nw4V7dA9/gef+zfXQoBPAMMDLCzg8NsA8RJgpj6kLsim6kz3xeZ37rslHry3vCngj
 NGiSYst8fyzvBflMepUpgPIBMUpp3/T8PKHFIstIOTnrI67ufSxNlfgQc0N7Cf8mPvGh
 SSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666120; x=1698270920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kK32N3vgLhgiOtEEROoXYbcFL4Ddcs6GJ1O6rcXX12s=;
 b=VWAFiqe2MNl3AikMY/HaM2R3np31HakM65npVkCTAUi+rLGzVo5GA9hqJnO1T0iLzT
 Iehc7R4P46lcASxuhUIMKRaJngAkHsFv240gRlcbsoMw3GnJqivdXw8c+yNuZeQF+EMc
 U+DOnat6DWwZZAMGVTJAovqXhzLv19m49fj9eVQeFMe97AWko+MpdUqYXq8yvpIAY0T0
 mKEcGBbGSy0BTw3Zd5lazmMtSEE5y1O0si+aFP809jhDo0Tur0Zn7iGQWEAD3p7zoyjP
 AYAk5h3TkmZmZ149TEzLIjP/tV4Q/P+NeQshmx9R+qYi4owxOvWJrzg8bCUYu/vMOuZn
 udpg==
X-Gm-Message-State: AOJu0Yyfc8c/9D3lOn0QS8SF3AGDY9f9c1r50oYnRf8tZjFw/56JFd4N
 1Bd1iD+v3AXCc1PQrnW01A9MdIodGiKlr1THo3Q=
X-Google-Smtp-Source: AGHT+IFhbvI+52dPP4FnSypjKXed+LCDbJi1/eLA3cypu9xCIZjMVetEghzXf9J178Bw79Zrv+W8aA==
X-Received: by 2002:a9d:63c1:0:b0:6b5:f457:adaa with SMTP id
 e1-20020a9d63c1000000b006b5f457adaamr545139otl.29.1697666120491; 
 Wed, 18 Oct 2023 14:55:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 50/61] target/hppa: Replace tcg_gen_*_tl with tcg_gen_*_i64
Date: Wed, 18 Oct 2023 14:51:24 -0700
Message-Id: <20231018215135.1561375-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 4a2bfb7757..366a8f1acc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1325,10 +1325,10 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
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
@@ -2361,7 +2361,7 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
                       a->data ? offsetof(CPUHPPAState, cr[CR_IOR])
                       : offsetof(CPUHPPAState, cr[CR_IIAOQ]));
     tcg_gen_shli_i64(stl, stl, 32);
-    tcg_gen_or_tl(addr, atl, stl);
+    tcg_gen_or_i64(addr, atl, stl);
 
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
@@ -2911,7 +2911,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
     TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
     /* Special case rb == 0, for the LDI pseudo-op.
-       The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
+       The COPY pseudo-op is handled for free within tcg_gen_addi_i64.  */
     if (a->b == 0) {
         tcg_gen_movi_i64(tcg_rt, a->i);
     } else {
-- 
2.34.1


