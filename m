Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FC777276C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12Z-0002BI-JY; Mon, 07 Aug 2023 10:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT11A-0000Bb-Mm
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005UV-Ej
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:31 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3175d5ca8dbso3501542f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417722; x=1692022522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S38jOsOxbXZJPQo1Nn8IdqFJrWb3K/zbZSPVOOqu/8w=;
 b=qrFYfcE1+fvxA1Nd3TpHbscVnYPF1KANB64ZJ9it3VlB7e9TEH/n4A7+LI18XLHvOm
 FatuujXvNXsWsRkGqmqQiMkwcqXAea3JVCn/SamEgmzkRO/4xE3crNR2C9VmoXBvwcBF
 JKQfcg6/3N9WxeW80zuVnTHGM5ZL5vL24+cy+fFe7Zsmwmz5IXtDDo9qpBj2qoglcPoF
 w0SJqq8pOfca+fd8FSsLczXLeDiQSLk9y8sKNG6fQQ8jxjTLhp9aCarG/m1IdnEOvZn6
 31WbZNSsHSxg1WJJuGYFVl3UuyjbsmpF51Ga+7D8Tj00E4xdzAA9T8MsV+HQqJuOQktt
 xl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417722; x=1692022522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S38jOsOxbXZJPQo1Nn8IdqFJrWb3K/zbZSPVOOqu/8w=;
 b=gf56sCZEbs+uY1OurLTfyd9xJaWe9ULT02a1yQI76oH6sZ8LnXIUU6wiNsRwvnVX85
 DfFH9YQdmbrjROg89KwJfNLEOpE+bndo/X5AcOc6pdZ4ZWfXxG3Pwx0VFnifU/TquUyV
 CK6NRNFN/DL5M0kJMMDDiiYLJs95F+x+Pv1njth7FKNJ2Kl+DDd4Ijrk1GJNXS2xwgYm
 9oAwkckNOy6HZe7E9v18l1Eur8Or7vXb1srwKjGvaq3L7CkiDu+rM67jbqptSwoTPyn2
 WjDjmDaJL8gtcjAL3HGIrPG7Y9mCD59Ad9d4d+Nbmf+M6g9ucHf0BJfD/X2x4xWmBobE
 Gnuw==
X-Gm-Message-State: AOJu0YxeZFZqH5RSroAKV77oiviZKZbD6gQ1xcmz5HRUyYpwUtviHZaK
 flqETHV7GzSqKdmAPK7YiogTslaQzjut+TG4AdA=
X-Google-Smtp-Source: AGHT+IEI4iWB7LicgsNC2xEG25o4mf/gTnuR8+qxnXqJMZebcV/QJQk8Lq0FKgFn9Dy5QWWTtmX9wg==
X-Received: by 2002:adf:f204:0:b0:317:576c:285 with SMTP id
 p4-20020adff204000000b00317576c0285mr5638633wro.7.1691417722426; 
 Mon, 07 Aug 2023 07:15:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/15] target/arm/ptw: Drop S1Translate::out_secure
Date: Mon,  7 Aug 2023 15:15:10 +0100
Message-Id: <20230807141514.19075-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


