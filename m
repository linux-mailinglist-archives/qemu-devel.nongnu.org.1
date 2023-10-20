Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6327D1765
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM3-0007yM-Fb; Fri, 20 Oct 2023 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLo-0007mG-4O
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLm-0008GK-23
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso1115421b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834644; x=1698439444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvByl24MJI51YSIY+m9lpJLCF2jw0swZvW6LzKcbRvs=;
 b=PJOyGoQg9v1GTcdg20QkrBUd9+Myezkva+gQbJPi4ybeMfpcL/aIUySjSFa4a7pmQb
 TYk+itaCO6Ttuz9MTSqF9MkzcB4dLBKZq3W6N9P1wIWVUzmOTOdBhA2NFfpAjbMdYsR8
 3x4jJvHhNk0iPo52hR2DWz/i8zfNHiyHTNN2381uDVY0ZMB16eL1og0b9tsL7HxmlR0h
 65LlDw83Ifm9B60AKVH8OB7bX2WX4g6yahfRFy+r4U01IRHcDQe2e4VzdJ0ayqEMMQUj
 HAKjVInuFAT6PDp02knnw4Npv6fSVeBI9/KYv388JGDZ0Fc+uLCWoVzrL05i+YFrIzQC
 qSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834644; x=1698439444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvByl24MJI51YSIY+m9lpJLCF2jw0swZvW6LzKcbRvs=;
 b=rZjwTs+xHNz6fBvEzJPsycMZJyuCDhbn59PzcVc6YRpXnD5fx4GSFRvaiG4S9l/3kB
 hf1DLka2yAeV8dFqwKEDVWCNJdTlFXPaWvCwe+TZUHpLOmHrMpHAkIF3hrsxUEOzWz/c
 7W6L7p+/jPoqqEbGNvgufYOzKqy5hQk4rTlv22uqgS8+VmgcBWg66qQ0MIO6+xvUMOsZ
 LlnCPhDTu4QBeckTrPC5+/bZcfr8aCJesq3xkgqACoYNH9q1SJmevjBkn6Aee0/Lvinh
 XpaP3aeMetB5PVN2Ch2oT8+83aBzUfM/V7fjWlh+WclTGm2uK3HucN1Cm9bhtnRNdCYb
 gMoQ==
X-Gm-Message-State: AOJu0YxZMQHk3dpEOQLt75WDAglKgnabhMTcxuVHNxIGqQwit24nnvPN
 2nTocYYu5Q/XaaKUAqlffobKoqbn8Oon3gV31yY=
X-Google-Smtp-Source: AGHT+IECxuqpf9JCgQIIA4fLUcMhfZv81osKVAhPLx/nYshWrgziVRsdaPXhjjknfrg20sDY///Etw==
X-Received: by 2002:a05:6a20:8f01:b0:15e:2d9f:cae0 with SMTP id
 b1-20020a056a208f0100b0015e2d9fcae0mr3309955pzk.10.1697834644636; 
 Fri, 20 Oct 2023 13:44:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:44:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 35/65] target/hppa: Decode d for bb instructions
Date: Fri, 20 Oct 2023 13:43:01 -0700
Message-Id: <20231020204331.139847-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Manipulate the shift count so that the bit to be tested
is always placed at the MSB.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode | 4 ++--
 target/hppa/translate.c  | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index ad454adcbb..b185523021 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -290,8 +290,8 @@ fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
 # Conditional Branches
 ####
 
-bb_sar          110000 00000 r:5 c:1 10 ........... n:1 .  disp=%assemble_12
-bb_imm          110001 p:5   r:5 c:1 10 ........... n:1 .  disp=%assemble_12
+bb_sar          110000 00000 r:5 c:1 1 d:1 ........... n:1 . disp=%assemble_12
+bb_imm          110001 p:5   r:5 c:1 1 d:1 ........... n:1 . disp=%assemble_12
 
 movb            110010 ..... ..... ... ........... . .  @rrb_cf f=0
 movbi           110011 ..... ..... ... ........... . .  @rib_cf f=0
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index df5a6dc896..543a694724 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3151,13 +3151,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
-    bool d = false;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    if (cond_need_ext(ctx, d)) {
+    if (cond_need_ext(ctx, a->d)) {
         /* Force shift into [32,63] */
         tcg_gen_ori_reg(tmp, cpu_sar, 32);
         tcg_gen_shl_reg(tmp, tcg_r, tmp);
@@ -3173,14 +3172,13 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
-    bool d = false;
     int p;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    p = a->p | (cond_need_ext(ctx, d) ? 32 : 0);
+    p = a->p | (cond_need_ext(ctx, a->d) ? 32 : 0);
     tcg_gen_shli_reg(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
-- 
2.34.1


