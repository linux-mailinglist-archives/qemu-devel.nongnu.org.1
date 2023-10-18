Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A27CEAF7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESj-0001r8-SU; Wed, 18 Oct 2023 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESX-0001Pi-Mk
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESU-0004TS-VZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:08 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so4161913b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665926; x=1698270726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6n7GVKKY6z8LBEya5tH0c0VXc67EOQvAcHfVl9Ri+0=;
 b=iL8rtsQOtwHTiulIopu522qZPTVu79DyJsy1UTpX7XSeR3JuUVNpsqmP10bxsRJEuh
 g2tA5SY4Dqu9B1GoGe1fxELhVGby4VLRHRZtQwpFOu2ECrA4Qsg47t/I3PSQ/0Zp4McF
 Bz7hwxmK0AzBXWGeqPY0M5ownq0Rv4fuQt/brtNNZp6BCFmDvbT3iXfGCkBbiy4HizPz
 uqXesec1pyyOTET0dtY460mHNmHfCKd2bd1QueEUFPBK+IVb2ruy+HOTxKnqQlKfynQI
 A5zoMKdNm/EoWMFEDewykhpdfMyJwm0W4hpDNBBDy7PiWnj6GHzwyxon6+9PobdanC/i
 WH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665926; x=1698270726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6n7GVKKY6z8LBEya5tH0c0VXc67EOQvAcHfVl9Ri+0=;
 b=liUZus9Mz548CZ57qXintR1PgiU9Y6wjVRPkc8Fiko7OyVuA2ky/3SH8yXM1X1WJys
 PoUtRKYvCFK76Ix6dm8cumDcLK6ubm+X2CkZlrVWlYT4Pvl9AmeKtWXD6yKYy1b9Lmnx
 RjHOiT+ejFKvVcBD9gWAqlIfuVpRgNqrnILqcZq5pZ05VuTyqE1g6d2HY4W7F4iptsM0
 TbVfpNPWP6eXkekYporCs/JreSEse9asGbCssMMvdUG6XZ/BAaXJ27JuHi+yVhanAy9b
 2nSSZ9V4IPYI3sJGB+10Mbl8FXQmi1nrat2NtlyNYf1hr9bND0pgpd1jDcMe4AAaV5kV
 Zqvg==
X-Gm-Message-State: AOJu0Yx99OLAw+b8bDZbue5aalXvDJPeH4aGvn7Hsymvu5GZUMOX79X9
 /PcoeC7pjPgkIv9H8/PCKB1qepSEk9y6OcS+yO8=
X-Google-Smtp-Source: AGHT+IHkHSvxNT+6XrrN85o41UfZfbh2uNkNK6wzjI/BvUsiMwemfwq5uKTqrkn6CwU9HdjR+d8Cyg==
X-Received: by 2002:a05:6a20:3d8b:b0:158:1387:6a95 with SMTP id
 s11-20020a056a203d8b00b0015813876a95mr454354pzi.19.1697665925737; 
 Wed, 18 Oct 2023 14:52:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:52:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 35/61] target/hppa: Decode d for bb instructions
Date: Wed, 18 Oct 2023 14:51:09 -0700
Message-Id: <20231018215135.1561375-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index e21a206466..33da82b7c8 100644
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


