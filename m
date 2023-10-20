Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFD7D1777
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:50:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwOy-0001tK-3Q; Fri, 20 Oct 2023 16:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOw-0001pC-52
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwOt-0001Be-Td
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:21 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b5cac99cfdso1157015b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834838; x=1698439638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFd9Qh9JL6hOySCuo3z5YneGJwqmFS+MfoCbYZFAQuw=;
 b=gBm06ICHR8rAcziMlETWL1/VU8FGsZ1WR+L2WLIfXNZD7ABupqbh428kXC5C2sym/g
 j7HjY7QS3iPvPB5sA7aqTGvroMB0kRB8VTIFEz9agnfako6ReKWODml5OXW4r0UbxMcN
 nm4TKvie7aC0gWNkpMY2/E3eYwLde/GAKdbmR4ujEa7IAflfQCECUUcOQ+0uRpvfjQ8F
 TqfgCVluy5xX/Nytklt3NVkroEzZLoGOSiIAxUdDkRdytYVVudC5fIPE+y4nqlHKD6O7
 YiYxp0ChPuKmNh54yOCgYnZahvkyYptiD00BBZoN2KKxlMIx7O0ETUO2q6paLjWRifCP
 Nd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834838; x=1698439638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFd9Qh9JL6hOySCuo3z5YneGJwqmFS+MfoCbYZFAQuw=;
 b=WCvCdV3rg5y8uw+qNL/BLFSmwFcIqQiDjz4aZTZ49gk1tUgBzPXZtOsevEhS8wzt83
 sgpWv+1iJVJB5zpA3qGqABO/8Xnik1sdCCBZLmtRuozaQGoSHbEe0wGIptxpEzQQgoeZ
 8fkXwJ3Fokj9/JKMgcU5XmqDEEtRpAXc11QvgLh7zpzMCvdAKoLh20xTtfMl3j+CO40J
 kCttPb4adH+gpes7Y/SKFKdpdClfeMTYdxFWTh0KBPwAnhHZ/GmjQC/DUbX6pAQeNXja
 X3HZdEAsXS+nStGsfjL1LzFoR1TUCZ2lrCY17R071H+8KwKTQRXHjf7kFUsWJ739RCR4
 vDrw==
X-Gm-Message-State: AOJu0YzvRYPXpeoC14Zo5hf1cGz/Az7WhcckRWxMt9qpUe81+NLHry7q
 wpPkMPCFfD3TjnGSEus9236l69fUmdQ4+6CmyZM=
X-Google-Smtp-Source: AGHT+IHvuOkkUjJiCp2Qj+WvSAvC1ne3XGyO3owI9+MW+88EvK+RpMDC6v+ZXkqqouz6lpEpGWkXDQ==
X-Received: by 2002:a05:6a00:134b:b0:690:422f:4f17 with SMTP id
 k11-20020a056a00134b00b00690422f4f17mr3186059pfu.4.1697834838633; 
 Fri, 20 Oct 2023 13:47:18 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 51/65] target/hppa: Replace tcg_gen_*_tl with tcg_gen_*_i64
Date: Fri, 20 Oct 2023 13:43:17 -0700
Message-Id: <20231020204331.139847-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index fdd5fbdf0e..16d42ae328 100644
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


