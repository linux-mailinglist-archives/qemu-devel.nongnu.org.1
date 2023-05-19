Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E44708E40
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 05:26:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzqjn-00049H-2n; Thu, 18 May 2023 23:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzqja-00047J-Ix
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:24:51 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1pzqjU-0006cb-2s
 for qemu-devel@nongnu.org; Thu, 18 May 2023 23:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684466683; x=1716002683;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0cIz8/h5dPAjcY/AdSHYa8g04LLTvOa/mmw/kGGpqCs=;
 b=P5FQEPn2ZNY/lCL4XfPcvcFLwATTGPRRqT1BTrxXoyXgxQ/ZItHoQ4Sb
 +FCfnDYfeh5pGRbAjITw7Yun/LhTBszuG3JRpbNyOxRAJp51ODATiNUeV
 u0XNXobmeC2sLjvCqkV+bwZdWumVYejLd75VVEut52ZaHf3l2iJwg/u6O
 AH0WMuwy2WBp0oaGa5Tn5cI+YYVRjXasXers5R2e4Nh2O4bv4rnmuvMWe
 Z9mUBBBXnhHUQdDifkN60YeGK/qEcR3g3dpaIPMQa4Dt9mqIhlGrrj5es
 vmCV762plJIwZQCJIoiZn8PS1+N/WQLwSXO0WunbrB4G7OnHFtykzdv2b w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351107247"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="351107247"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 20:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="1032451401"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="1032451401"
Received: from wufei-optiplex-7090.sh.intel.com ([10.238.200.247])
 by fmsmga005.fm.intel.com with ESMTP; 18 May 2023 20:24:36 -0700
From: Fei Wu <fei2.wu@intel.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com,
 thuth@redhat.com
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH] Makefile: add file entry to ctags
Date: Fri, 19 May 2023 11:27:16 +0800
Message-Id: <20230519032716.1477615-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=fei2.wu@intel.com;
 helo=mga04.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's more convenient to jump among files with --extra=+fq.

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3c7d67142f..ffb3bcd4f4 100644
--- a/Makefile
+++ b/Makefile
@@ -239,8 +239,8 @@ ctags:
 		rm -f "$(SRC_PATH)/"tags, 	\
 		"CTAGS", "Remove old tags")
 	$(call quiet-command, \
-		$(find-src-path) -exec ctags 		\
-		-f "$(SRC_PATH)/"tags --append {} +,	\
+		$(find-src-path) -exec ctags --extra=+fq	\
+		-f "$(SRC_PATH)/"tags --append {} +,		\
 		"CTAGS", "Re-index $(SRC_PATH)")
 
 .PHONY: gtags
-- 
2.25.1


