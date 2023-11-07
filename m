Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66EF7E3402
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:14:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRS-00049B-7n; Mon, 06 Nov 2023 22:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRL-0003yV-Pc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:43 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRJ-0001MT-Rd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:43 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc316ccc38so42306835ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326460; x=1699931260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wrEK8meCb9Gn67PXtTISMWJ2KT8p8ZhsOvKemM4KQPs=;
 b=OMuZe5KCpEUdyQyN6wQu+maoiAZ+KvlgyVn1aD7lnq5g+XTHG9ISL/1xFzPfSK2I9Q
 bPa5dTnY3xROdR32ywl7V+U+LGwDsdzSvCFtdw586clsiladRM3LPZY6KKFKLgstcB75
 NxZ/qcQJdWgPUtIwPdWYY+rJg6c/AAkb5duAZNIfIC8sgzCM7pmg//j5Ppq/+XNVwA6j
 2ODtKDFs0ITIucjdnIFdYmYVlS+6+bqSSiePV/ZnLPgw610Xs5s2IRRQI2iUBHvc2VHB
 s2vWQoBmaK3K8a87wx7ZONY8bt62O/mIWY/2EI8E1auXGaSCzLPA2OeQehWjYZLW/bLl
 NhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326460; x=1699931260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wrEK8meCb9Gn67PXtTISMWJ2KT8p8ZhsOvKemM4KQPs=;
 b=Zio6O7XHNIouUMEODktBMuUEFtayZSTZbq8fYmcRPe/zXxhT0QSNNMI8nuGriF7GTT
 CYF9RhEMGAPvLPDgZ5xe4zWcXEVJ9mKLqxQuMBtdmcoYBBNuw+oAy5XonVZP33x1T06r
 TJMXDGhtbQMBudI/5vjQcOQad5tqM7+3fAL00ZK/DEFFvilLmVWSn+LISLMKLZ7Ix5F0
 4hhB2cIuYne1ID7sq1ZeFsbZWrp2bIpzx8gh9YZ3PwOgsavsIN/b0r2I4Ve2k5i0dCNE
 zhDmWpXMa7PFgY0Cj0QF1rh9ZQVtXl+l9giE7n/27/SS8szcHutLATzghLveJtxxdmmp
 VD2g==
X-Gm-Message-State: AOJu0YxIDd/TYmfQh4T30gdTe6TmxG8QCpkgO3Ul/d6DM/kDvxQ9OKe0
 Wuh/OxtWISpW5yFxHRIhKPbEnnOCDotsXJx3I5Q=
X-Google-Smtp-Source: AGHT+IEMURNq6pz8/7/bFkcoixFlGwI12xb1fyJF7lNRC1rKxvasJLe8k3zikb1Pa9uWcTsjA/ftKQ==
X-Received: by 2002:a17:90b:fc2:b0:27d:8ad:69f9 with SMTP id
 gd2-20020a17090b0fc200b0027d08ad69f9mr23514486pjb.2.1699326460515; 
 Mon, 06 Nov 2023 19:07:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/85] target/hppa: Decode d for bb instructions
Date: Mon,  6 Nov 2023 19:03:25 -0800
Message-Id: <20231107030407.8979-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


