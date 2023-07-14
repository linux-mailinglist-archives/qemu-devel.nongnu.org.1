Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD3753F52
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0X-0007Fb-OS; Fri, 14 Jul 2023 11:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0V-0007DS-9B
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0R-00075l-IQ
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso18887325e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZJ5X1Cn1l4/BJNDm0G2PsxEkjY7Sczg3wp18DaMO6sk=;
 b=YG86nj2BPvHiITTp/JcuvLzObZnUKdGuFbwlLvEK1cJ0AUR7ZkzpVOF55vNYwoIlPK
 I1huFhFvtuzfL+Lk/w8wEl23gq2whaNl4k23M0VINVHvjiWOZ269n7qmu1g/dImZ3Xy0
 /Tkor88EPnKidTP3BpIgKL67HzJ3s72+KyOTenFNcbp38H1ozlyEWkF9sHb7CiBwpe9M
 AuOBIRoXu4N5DvktbOJ1IzlgQy/ZZEWH+MHztLIYsKjalZ54+AEtBPvfG+dMqWNJaNco
 L4O3acOvHNLHhEwa8zfIh6wfEbDx2wmFZe58dzQHQs1m9xsdYUZR1BvC6P6rUg17OeKJ
 pgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJ5X1Cn1l4/BJNDm0G2PsxEkjY7Sczg3wp18DaMO6sk=;
 b=KLxRlGCmlfBNbrFwekuCV7p2bf1bEDCPIGsWyWKMTupk01uZWquCXlFmJVe+rp3dtF
 Y1dLEtdckS45snin7qv7MD340nmaLdWtLqb2Ja1eKnOQZlwCvefZInvUiXAblVD1fpBe
 ccEaQAfx8KLWb3qmz+C5jWGbVKFZJ1vFDynyHBJQ0sRw3j+ECg5alOkW6pjTJlLahNFA
 7UNakc9Xp37Bvm4j2S1ehGicbUBrPXKMLNoizR2xh95qu50WeYKrdRwZ5KBrC0O+JIdu
 TYTXJPQKME11CE8C97ghhkbWlFOtQGEqbg5SqxbMAw4ZNpQeJYqm2J3FQ2okufH5YV+D
 mZcA==
X-Gm-Message-State: ABy/qLbffZ3vLFePhZSyy3A6856aXGiagZWmVJCTnxtc1sUdlUZFr+BP
 GzNBLbn3X/nUJo5nq4wPoumBILRCSyNXnhfLBQg=
X-Google-Smtp-Source: APBJJlF8e/rloGpYZr5BfiJWhXDgt9fIOq/EfN/YkEkL7jgzWJvqeOIN+5oUGp/xSXDXpfV6cjtZoQ==
X-Received: by 2002:adf:f08b:0:b0:316:cbb4:4e46 with SMTP id
 n11-20020adff08b000000b00316cbb44e46mr4467148wro.3.1689349614273; 
 Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 07/14] target/arm/ptw: Only fold in NSTable bit effects in
 Secure state
Date: Fri, 14 Jul 2023 16:46:41 +0100
Message-Id: <20230714154648.327466-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/ptw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9e45160e1ba..c30d3fe69a0 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1884,11 +1884,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


