Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E804786C0F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eu-0008AE-0Q; Thu, 24 Aug 2023 05:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eE-0004Uq-8J
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00051D-MK
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:01 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so5775916f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869329; x=1693474129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rLfi7iwoUxJ42LFstDjsa56QpNDGkJ2EfgGmjg+R5ng=;
 b=gp/+/RePpuSG+wcjMG+bGMJbv1ehxwX65Kb7ORcWzwsw7fR9eeVIx62EY8XXJdBi0t
 wpbpoYe5rkuUJyK1alLQBdS74uuSR4eXj4kh9UrbEGzt5jxk9pJfBHo5oN5lCCK7zmkj
 w0W1wByJsCDyNDTzX3Ot8b4eIxg+oFuBZivEDt7DizzA0gKlEpiVReMwQFlIvJxzIBiQ
 PDRDze2R9xP2Kn23MOKwd5PrfkiKj0ztLgf6YOca8BdnVYPJ0+el3T9tw8rVgTMO3Mqk
 2/1vPXJKVPn9Y/kMAzi7KyjGOeNMqqR3aGdiOolZCzWxsmcMWUaWPOQY4wezgm1pno1k
 1VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869329; x=1693474129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLfi7iwoUxJ42LFstDjsa56QpNDGkJ2EfgGmjg+R5ng=;
 b=eozIdafPwbhCuUT9a+GhTlQdHT7BPJCjl5tQOVubrim1xrSpyQXavSEdwWLRFUlJVy
 HWbMD1u66rP0HZWJ7mRpqO6ydrcl84vE5Thl4jMm0eyd/doIgz9D9xd1OLUfOYPN1XKW
 uzu0r2kQE2DLUwOhHktcZX+cFiwPWGqHvAownwXFfk80NaeNygY5ZYgzM97VQnEnUomP
 LpljE3W1rF4jJYanFqltsLU2Ryscq1W4XHTJdenqPpT3cSAXPsUtzjfbO0iejUj+mpSP
 EavTZDOjw/KlD/aeAh0c2nzniU4jmxiCAhYphhcsBVr6guU29p7i23NEfxTwZcYzGUhA
 BSKw==
X-Gm-Message-State: AOJu0Yxdin1Hcen/m9pUDmR9idJcpz3vFQYLliJFEU2wOZ/LnXU/5/Li
 1FaaVJyiaB6oX18QychLLl65RBG0TbXRjVy2234=
X-Google-Smtp-Source: AGHT+IFfeRQmMdPXPuCGmC0HduNILXva7hq7suKGroWLA1xMHRAhXkbNmrWibRtK6Y9UUrEqrPdy1w==
X-Received: by 2002:a05:6000:889:b0:31a:d6cb:7f9e with SMTP id
 cs9-20020a056000088900b0031ad6cb7f9emr10911942wrb.21.1692869329202; 
 Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/35] target/arm/ptw: Drop S1Translate::out_secure
Date: Thu, 24 Aug 2023 10:28:24 +0100
Message-Id: <20230824092836.2239644-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

We only use S1Translate::out_secure in two places, where we are
setting up MemTxAttrs for a page table load. We can use
arm_space_is_secure(ptw->out_space) instead, which guarantees
that we're setting the MemTxAttrs secure and space fields
consistently, and allows us to drop the out_secure field in
S1Translate entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-12-peter.maydell@linaro.org
---
 target/arm/ptw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 78bc679deef..312ccabe92e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -63,7 +63,6 @@ typedef struct S1Translate {
      * Stage 2 is indicated by in_mmu_idx set to ARMMMUIdx_Stage2{,_S}.
      */
     bool in_s1_is_el0;
-    bool out_secure;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -553,7 +552,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         pte_attrs = s2.cacheattrs.attrs;
         ptw->out_host = NULL;
         ptw->out_rw = false;
-        ptw->out_secure = s2.f.attrs.secure;
         ptw->out_space = s2.f.attrs.space;
     } else {
 #ifdef CONFIG_TCG
@@ -572,7 +570,6 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
         ptw->out_rw = full->prot & PAGE_WRITE;
         pte_attrs = full->pte_attrs;
-        ptw->out_secure = full->attrs.secure;
         ptw->out_space = full->attrs.space;
 #else
         g_assert_not_reached();
@@ -630,8 +627,8 @@ static uint32_t arm_ldl_ptw(CPUARMState *env, S1Translate *ptw,
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
-            .secure = ptw->out_secure,
             .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
@@ -676,8 +673,8 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
     } else {
         /* Page tables are in MMIO. */
         MemTxAttrs attrs = {
-            .secure = ptw->out_secure,
             .space = ptw->out_space,
+            .secure = arm_space_is_secure(ptw->out_space),
         };
         AddressSpace *as = arm_addressspace(cs, attrs);
         MemTxResult result = MEMTX_OK;
-- 
2.34.1


