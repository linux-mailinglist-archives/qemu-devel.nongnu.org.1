Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37247786C04
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ex-0000GV-Up; Thu, 24 Aug 2023 05:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eR-0006JD-Aw
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00050p-Ga
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:29:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so4076400f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869328; x=1693474128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gSt7Jf92i8R5HQEoB62ZPc6BWF+QtO19rPh3tNmtHqE=;
 b=FdJjoiP1w0OiLRkmiIkt8l72VkQsvsAf2etHK5JdrFm5v9hKTKPhXmwigtps+mhhqE
 FrHL7O/oGYnrQKJidUWWr0Su7fOzV54h+jLE0N4a6ReOIJ3bMra/U2GahKMZ7cg5NV31
 BZeEKdyUyVgaMKn7C1Xh5u5GwDLiw4wG5Jp+VtccsjRzAGKw3JlwmxLEN3XHs+vgXftF
 Zo2k7gWrjLTx6/7NsaEZhB1JDOfccpFsZ0MQWTIQ9Df/c+kkgv5YOV+T3F+3X6Ib1Lz7
 ISZgQfC8czzoY7qFr1p587Si+BuFubZxTU48RfIabbIbjZABbXsuKdklrVWP/nNMxctS
 yi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869328; x=1693474128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSt7Jf92i8R5HQEoB62ZPc6BWF+QtO19rPh3tNmtHqE=;
 b=K3KngI21WMxKssLD1HO7Zf58AV7rjYeSHzPySAwluObGZjmTbK6HJbvYnacZVb26fw
 zfWQaDkZQt+nXNWKC/LH+FeNk78gteE504ahXYvs6nvVkzeWvDXK0X7kVa39FwJuQspe
 EL1j8joEVaN4ZCiBv8BJwaL7Agv3vMhgSt/KpCfrLRcFs5HOcOuRopRB13h7Z7OsOGI5
 9E6+LNYNGJqfQujXs9LTf5/QIfahb6yGkJgN7Ir7WeTJlpH/o950VnCW2gi6G3+8zAmO
 6t/pwSnm+DJy8pvy3Z3RBVy1I1MDK/3P4tIg8tE31A8zgvBOBT2UnbWeenJtnQv7ygGp
 llhg==
X-Gm-Message-State: AOJu0YxQpGh9doMWmsic2JtvQ8H3mDifdXtVoUmdpz/s1QjC6HqGLshu
 GF27LAMNOnY36QX+/P8I3dhfkW/KW2PMBsgaTmI=
X-Google-Smtp-Source: AGHT+IHcbQzMUoVWTwUzP4yNOuPKTnA6rJl/lQtuiP/29vYM7uHvj+ztP2HrJV2Ipv4Lc9Q5IAuJJw==
X-Received: by 2002:a5d:68cc:0:b0:319:8c35:37b with SMTP id
 p12-20020a5d68cc000000b003198c35037bmr11419270wrw.7.1692869327896; 
 Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/35] target/arm/ptw: Only fold in NSTable bit effects in
 Secure state
Date: Thu, 24 Aug 2023 10:28:21 +0100
Message-Id: <20230824092836.2239644-21-peter.maydell@linaro.org>
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
Message-id: 20230807141514.19075-9-peter.maydell@linaro.org
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


