Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38A7DEA33
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:38:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcb-000081-CB; Wed, 01 Nov 2023 21:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMaw-0006O5-Em
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMau-0001v0-OW
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso3089645ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888838; x=1699493638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrEK8meCb9Gn67PXtTISMWJ2KT8p8ZhsOvKemM4KQPs=;
 b=zwI1bgZtrGbLN1qL2NBr71Yq+ZyBJLDpb51sVkZeX5nTLR/2NRUU63x6IYuQ0ffhBQ
 wzPTZYfvT6XqAR6gb7fGo5JrS2yqDyACXH9SpATPnzP4wL+2+AKeQdPRByeXG35o7Lga
 ZvBo545FozYNgI/3eoo2x8bUapAWBmg2E8cWvnEVlbVEVA6uHGjbMB0PSQc4i2uBk2mx
 an7HwivZ4qaDSxuZhdxUNnpbFUNAGUuvxJunrE3yCWvLFhTpjAtZ5rt12Nfg/KpuLN5X
 ZfyKMEda1HzfsK8HnIZFlYo27coR2femTlYOhqyQLtTWBUA+8PKs17NSnh2agwxtbFao
 QeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888838; x=1699493638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrEK8meCb9Gn67PXtTISMWJ2KT8p8ZhsOvKemM4KQPs=;
 b=BbbmaciCI2mVniUX2lFgGcFbQ0Gtb930rBG+RO5JYqi1A3akWi3jJVOSWp7sEjetQ7
 jjS6uDsWBfs1KQ7COELo7OmOaaaxTTtOS4pVmC+oaYT3qiqctmFY8nRWaV2q1mOb63f3
 qFZgApqvX2d5YKG/DR9VpkymeYSWE2uPj6ncPc/vZyay/N4oJtFmhtq2IyUpswqzxB8h
 wj6R/4lXYxaJg4IrF18LMz+BzdcznuFnumSwDq2Etdq9wEEpNqd3BQk6wQlmVjHXg5QT
 gxkknNywph4SOHaoYP8vucP1hNHkFCHV3h2Q2Qu+WGGiOvep8jLNnUEXdfpwQQibnbUS
 4UZQ==
X-Gm-Message-State: AOJu0Yz4smQkJkoP4WdFTx53/EfpP6i3ELJw03zjRtK91E0ONTIMS80Q
 uaprzHuYwap6Sfh+f6yqLKGidiizkAitLecz8co=
X-Google-Smtp-Source: AGHT+IEr4bplxdZTXuJ8RnLb9mMy12lKw7oKdBSPGbJRp6Pm4miEVPbUtkaPiszhyydDZNwtCDfEKA==
X-Received: by 2002:a17:902:dac4:b0:1cc:51b8:80f7 with SMTP id
 q4-20020a170902dac400b001cc51b880f7mr9421558plx.26.1698888838115; 
 Wed, 01 Nov 2023 18:33:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:33:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 45/88] target/hppa: Decode d for bb instructions
Date: Wed,  1 Nov 2023 18:29:33 -0700
Message-Id: <20231102013016.369010-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index f2b2933c88..e326f63866 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3172,13 +3172,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
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
@@ -3194,14 +3193,13 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
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


