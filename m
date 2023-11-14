Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D967EB583
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:28:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2xBT-00081i-1U; Tue, 14 Nov 2023 12:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1r2xBP-0007zT-UR; Tue, 14 Nov 2023 12:26:39 -0500
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1r2xBM-0001vP-M2; Tue, 14 Nov 2023 12:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aByQA5qmzql9xsLx/xcn8ZEzU30AG61TvPWwUn+kHqw=; b=CkzhEHnbCS9Nztqxu+61Hct5K3
 bQX+vtTmwjFaXfBIdiBNSfEoCNhbz3eJ9AIrxrxjbEl1ZmFZYl2AD8YkHJd0smu0fUy4+CHz2EFWt
 Yof8JE5b7YcLDTxhvzFp7IdeHhp2ga3cy/y6tzlV+HbaqumCmhTBojBDKK0B0qg5OpJAWXEODme1x
 n7jGNAkV3fT93ZJc4hn/XWuIG4K48+ocdayl4LnAxzBhCopGETLNTNlyIHltJzj1LycXsES/cEffb
 sq3TYJ5LTT+4IfUbeo0SgoF7BvABx+bR2L5KwEFFougwH7BcFmhQo67m8z5+w0ZgVLoIUgvZ5/o63
 NRRtIZLA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1r2wfu-001nru-Bl; Tue, 14 Nov 2023 16:54:06 +0000
Received: from ben by rainbowdash with local (Exim 4.97)
 (envelope-from <ben@rainbowdash>) id 1r2wft-00000002rNP-3u5E;
 Tue, 14 Nov 2023 16:54:05 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] hw/intc/arm_gicv3: ICC_PMR_EL1 high bits should be RAZ
Date: Tue, 14 Nov 2023 16:54:04 +0000
Message-Id: <20231114165404.681826-1-ben.dooks@codethink.co.uk>
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

The ICC_PMR_ELx bit msak returned from icc_fullprio_mask
should technically also remove any bit above 7 as these
are marked reserved (read 0) and should therefore should
not be written as anything other than 0.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 hw/intc/arm_gicv3_cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d07b13eb27..986044df79 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
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


