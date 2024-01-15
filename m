Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC3282D61A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:36:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOF-0002uk-Dz; Mon, 15 Jan 2024 04:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOB-0002uO-QQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:15 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJO9-00083u-V4
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311373; x=1736847373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GJeci8mK7yn0nRNGrhm8Z6i51j2QxMraNbK/U8jSyYs=;
 b=Ae7APvq/zJK+29egmZpqfaE+qg1v8+5VhAFfN0N/iVWi/zQtRETDjJJZ
 p+nfV5cbf3q/K4Uf2V0YRPxNbZ4pTjFINHDhdai+zmDAGKAu7zJoVMj+g
 2/SzFwX3FBARG+V5RiFykxVMX/z6enpCNX24RXqtCz5vXCVasLffDeUSI
 ju6TLGFbdm/CR6ubkzMmNCYDGY3WSg4vUsR1hamqT/qGfYxYl97wNGKuz
 3wabgXYwMSXC175zBJKMXLfd+1dsppXsukWxVLNSate0DAnXdifmSvY5K
 oE4k+00nuZNQUev2+d5ItfSmSEzYBIy9y2CTWwZxmNrPv+kUrlUbwABuv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439710"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439710"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594149"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594149"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:05 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/11] hw/core: Cleanup unused included headers in cpu-common.c
Date: Mon, 15 Jan 2024 17:48:43 +0800
Message-Id: <20240115094852.3597165-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove unused headers in cpu-common.c:
* qemu/notify.h
* qemu/log.h
* qemu/main-loop.h
* exec/cpu-common.h
* qemu/error-report.h
* qemu/qemu-print.h

Though hw/core/cpu.h has been included by sysemu/hw_accel.h, to keep
the dependency clear, still directly include hw/core/cpu.h in this file.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/cpu-common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 3ccfe882e2c3..bb21dfc03029 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -19,16 +19,11 @@
  */
 
 #include "qemu/osdep.h"
+
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "sysemu/hw_accel.h"
-#include "qemu/notify.h"
-#include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "exec/log.h"
-#include "exec/cpu-common.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-- 
2.34.1


