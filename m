Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E67EE5EF
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gAM-0008Ij-7T; Thu, 16 Nov 2023 12:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1r3gAI-0008Hi-Vc; Thu, 16 Nov 2023 12:28:30 -0500
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1r3gAG-0002W9-SZ; Thu, 16 Nov 2023 12:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AC/pq7elg+KPYfHSJloGfLwZZpYUAD8i0EJrt5jkPTw=; b=YtUUsMZDhOISieUPB55XfiW0is
 ZYyh2QIk/N2h4xNX2dwEJl4sqJrhlRIIDx6zI8xMSicyY/2Qn5jXwNfFL4LGWaVJ2+4DYAJTVzNUM
 8krvnF1A4irPnH/x4x1KG3dTdRbqL3IQEKw4wSMugNBCm8W+1F2VfyILzbKCCYd+6fEPgsrNXB3iF
 aO7XCOkuAhsXlGAId672dSDO8o5S/t+8xG/bkSOPwoBEmoAgs57W7hDpOVkA76BrbRA3QCJLlXAix
 KrOZRxWkT1Oj/R/conISN4hB2uk4RURw2V5I9t/iuuWelyYn3uWj7EghcHfrsmAT5YrkeDxNBX7av
 DmnvIClw==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1r3gA8-000cbp-6v; Thu, 16 Nov 2023 17:28:21 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
 (envelope-from <ben@rainbowdash>) id 1r3gA8-00000003K8I-2w99;
 Thu, 16 Nov 2023 17:28:20 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ben Dooks <ben.dooks@codethink.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
Date: Thu, 16 Nov 2023 17:28:18 +0000
Message-Id: <20231116172818.792364-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
v2:
 - fixes as suggested by Peter Maydell to include icv_fullprio_mask()
---
 hw/intc/arm_gicv3_cpuif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d07b13eb27..ab1a00508e 100644
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
2.37.2.352.g3c44437643


