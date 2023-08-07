Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8639877275E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT11p-0000Ge-EL; Mon, 07 Aug 2023 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-00008v-SB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT110-0005TU-H8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso38483815e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417721; x=1692022521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8IbTNuSWmbWoR5bYA9YvXkfK8gqg1QeL2k9kCrgnNA=;
 b=kIUTS94AbtuEcmId9cZSsc3vaqc4GKcotoVJx0XICluSA6XMiF0MTJ1PZwyY7r2b0J
 MGiUjv0DFrqhzppQ4aQvQfjB5htj/acEN+2UV+wMIRtgPIJHJF3Mn+a3H8MA3zydFhw1
 6+0Ue2xdWZBfiz/9L4ur0IfpFKuxkXmsbeHlNx/38ulh6I61lFC8lTrHroUuQH+2eVWK
 8lg9oaR7Or/quOeuqlEk76oVnHpBGF0EuKcdUu8OC+xYt6EOzyvnJTOnexPjYqz/E8i1
 aR9ouYxL2+S/T7Mlw87T/exHy+QgXO3SluOUhDLDy1zz4+6vfhF3riOy6B6Dm5P9e7JX
 eYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417721; x=1692022521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8IbTNuSWmbWoR5bYA9YvXkfK8gqg1QeL2k9kCrgnNA=;
 b=LrUPWwfN73YggCa509F1dTQYbeD1HYcaccZTrGvMqm3nYZnjG3//RO2eQApWKyBqCQ
 Eloe/q4Qykllm3+8+vAAp+HhAwJF5MIBJSYUITkzD29Qb9P64fdE+FR7cuh4bC9QdNOs
 CapMKr+hkyq2nWpzSWi10uIs4hvX1Rotb2YcMYkWgkEuM+7Vd/+B1WQeuRnvdafYimOc
 n94KuKuzGZYhGrp/9iGGkMUeSpbSwP2E9QkvWFFr/7PHZDWxo2jfatPfSuY42sMgxjAX
 T9JXF5Q4ek68ZX1opZv8ZynN5skwnthLXr9ecHgiTPJIjE2Kv0j0tJW216VY4/v0lf/E
 hM7g==
X-Gm-Message-State: AOJu0YyCVFSuf82iuOT5WSgudKYYG9Qgv9LzWNqvSb6BRjLCFpSApfJv
 5wdSp1ZAccOlG/uczxXu27XToQ==
X-Google-Smtp-Source: AGHT+IGwbWzX6J4R63e18q7vtMcODVJDNkz3/t3pNWPpndtr+uerfaE1asFqipLAiNvf9ZX1IftX2Q==
X-Received: by 2002:a7b:ca57:0:b0:3fe:22a9:907 with SMTP id
 m23-20020a7bca57000000b003fe22a90907mr6490374wml.20.1691417720866; 
 Mon, 07 Aug 2023 07:15:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/15] target/arm/ptw: Only fold in NSTable bit effects in
 Secure state
Date: Mon,  7 Aug 2023 15:15:07 +0100
Message-Id: <20230807141514.19075-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

When we do a translation in Secure state, the NSTable bits in table
descriptors may downgrade us to NonSecure; we update ptw->in_secure
and ptw->in_space accordingly.  We guard that check correctly with a
conditional that means it's only applied for Secure stage 1
translations.  However, later on in get_phys_addr_lpae() we fold the
effects of the NSTable bits into the final descriptor attributes
bits, and there we do it unconditionally regardless of the CPU state.
That means that in Realm state (where in_secure is false) we will set
bit 5 in attrs, and later use it to decide to output to non-secure
space.

We don't in fact need to do this folding in at all any more (since
commit 2f1ff4e7b9f30c): if an NSTable bit was set then we have
already set ptw->in_space to ARMSS_NonSecure, and in that situation
we don't look at attrs bit 5.  The only thing we still need to deal
with is the real NS bit in the final descriptor word, so we can just
drop the code that ORed in the NSTable bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4c60de753dd..6e736bacd77 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1886,11 +1886,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * Extract attributes from the (modified) descriptor, and apply
      * table descriptors. Stage 2 table descriptors do not include
      * any attribute fields. HPD disables all the table attributes
-     * except NSTable.
+     * except NSTable (which we have already handled).
      */
     attrs = new_descriptor & (MAKE_64BIT_MASK(2, 10) | MAKE_64BIT_MASK(50, 14));
     if (!regime_is_stage2(mmu_idx)) {
-        attrs |= !ptw->in_secure << 5; /* NS */
         if (!param.hpd) {
             attrs |= extract64(tableattrs, 0, 2) << 53;     /* XN, PXN */
             /*
-- 
2.34.1


