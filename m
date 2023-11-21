Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47907F2A52
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:26:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw2-0004It-SZ; Tue, 21 Nov 2023 05:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw0-0004Hs-UZ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvy-0007EY-Ab
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507b9408c61so7320261e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562284; x=1701167084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aWov8zdztLe0Jlc/lkRlL/DlbtZzkn3RPI3Q2gppqQQ=;
 b=vZysZ6HrwMn5/R4nwXCKDzQVbVLIsu3F3zzyP0Y1QUVWfMo5XP1sNMA+/US9/rMAVW
 pCOKRwpleOyT/0DSh0fKt3hyyhLIWFgd8oGqKjr923fBxT8r+rNNaXs+khduK1nAE2S0
 Q+DTi8Ws8+w+GUlyoJqJL95kJKeTTiQTFM4MiwEKmhRRCj1KdnLPfhYVh/Lp1/mbchaG
 anjvLxCxfF7Hzv1ng1LaNxNuaLPwTmOfwkKuBL2Ey5LJkxMgGnNXwTMrIUD3tOHgSX0C
 GNLSz9ec8n82PjZSFftWaMS53HkKgMVtcdZ+cq7Y9FsiXDnwIQMTr1MYQaknrxzj/bsz
 b5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562284; x=1701167084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWov8zdztLe0Jlc/lkRlL/DlbtZzkn3RPI3Q2gppqQQ=;
 b=FdAdVWFRLrzKyKLLcIMkbIs7gGtOy5jeKAlyUi+WU5WaFKCRQeH6/jg3kKGDNdT2Qi
 cSUAJCfw9IW+Q9p2cLAiUlz8GlWKXn6vHEecoqgpP3CHyAW0w9wM5ImjqXupIJys29FZ
 kOVxWHqlyPtOmxMGvgggJrBbk+dEjuG5vBUqrAQnR8lUhdcr6f55mZAavqVFE/55vupG
 YwSfFaDbM2bVQMkkamXjx7omo4XYiwD63wHokz4ClG7ipRiGOlu6qh+JMiDKbHV2NEcL
 7u2fb80gZVzVKCnDJtyxwvKtp2mpQ2IOHv3IJ9g0y6SfB35C3IZaG3leICP1IDp9x8Rl
 YXzw==
X-Gm-Message-State: AOJu0YxWCkbN1tdhhm+Jzze2JqWuqfR1ycvsBlSWNbcISebllLccHOQI
 D5waAYS6mte3WRr8XCaUSpm1ez2WRgEwpgj6+RE=
X-Google-Smtp-Source: AGHT+IGdojh2d9ZIEFJfH8k4PXA0q7rCTshMtSqqw0leBD+w89+iA9AyflLwf6cIA7UMu361mEqZNA==
X-Received: by 2002:a19:6747:0:b0:508:12f5:f808 with SMTP id
 e7-20020a196747000000b0050812f5f808mr7156884lfj.57.1700562284445; 
 Tue, 21 Nov 2023 02:24:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
Date: Tue, 21 Nov 2023 10:24:35 +0000
Message-Id: <20231121102441.3872902-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Ben Dooks <ben.dooks@codethink.co.uk>

The ICC_PMR_ELx and ICV_PMR_ELx bit masks returned from
ic{c,v}_fullprio_mask should technically also remove any
bit above 7 as these are marked reserved (read 0) and should
therefore should not be written as anything other than 0.

This was noted during a run of a proprietary test system and
discused on the mailing list [1] and initially thought not to
be an issue due to RES0 being technically allowed to be
written to and read back as long as the implementation does
not use the RES0 bits. It is very possible that the values
are used in comparison without masking, as pointed out by
Peter in [2], if (cs->hppi.prio >= cs->icc_pmr_el1) may well
do the wrong thing.

Masking these values in ic{c,v}_fullprio_mask() should fix
this and prevent any future problems with playing with the
values.

[1]: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00607.html
[2]: https://lists.nongnu.org/archive/html/qemu-arm/2023-11/msg00737.html

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Message-id: 20231116172818.792364-1-ben.dooks@codethink.co.uk
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d07b13eb270..ab1a00508e6 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -146,7 +146,7 @@ static uint32_t icv_fullprio_mask(GICv3CPUState *cs)
      * with the group priority, whose mask depends on the value of VBPR
      * for the interrupt group.)
      */
-    return ~0U << (8 - cs->vpribits);
+    return (~0U << (8 - cs->vpribits)) & 0xff;
 }
 
 static int ich_highest_active_virt_prio(GICv3CPUState *cs)
@@ -803,7 +803,7 @@ static uint32_t icc_fullprio_mask(GICv3CPUState *cs)
      * with the group priority, whose mask depends on the value of BPR
      * for the interrupt group.)
      */
-    return ~0U << (8 - cs->pribits);
+    return (~0U << (8 - cs->pribits)) & 0xff;
 }
 
 static inline int icc_min_bpr(GICv3CPUState *cs)
-- 
2.34.1


