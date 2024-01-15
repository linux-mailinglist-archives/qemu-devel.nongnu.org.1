Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C582D61F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:37:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOa-0003B1-LL; Mon, 15 Jan 2024 04:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOY-00039R-9V
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:38 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOV-00083y-8c
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311395; x=1736847395;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pt2MYm30g9vvm1ADggzKeJz7RrkeGL5GZzLkhLInohU=;
 b=eHfh1i5EQhfXAcqLdCrUmQCZzXk6BQ3GsrTxTmsGnBv0lHSe2EiLDhZk
 HZr/UcNLJ0ogXQU2JXtYm2A1EtLldh2R2j0/PC4EyLAy1YHBu01r/cQG1
 bFQ+yayz+CIFvREBGmaKB4NWq9ONkp1kqwIBQGApv6ocota//xyTl+RLE
 VO593Vfibkp1mjV3dimke4YxIc/g16xd4DZtFjQzGCukfu8l4b1tEs6rJ
 TMxz56+NjGTH7kKnQyLVjq7i0wfLAhNylMJWwlDPvSWpxOtfTNEhS+FM/
 8l0fCJWYmjnzPNJgLjkli9HsnS/UafLLl86BRqmj6O5CD7Gc8ro6Es3U6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439854"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439854"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594181"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594181"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:22 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/11] hw/core: Reorder included headers in numa.c
Date: Mon, 15 Jan 2024 17:48:52 +0800
Message-Id: <20240115094852.3597165-12-zhao1.liu@linux.intel.com>
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

Reorder the header files (except qemu/osdep.h) in alphabetical order.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/numa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index ab3f2858ac51..aff080d48aa1 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -24,18 +24,18 @@
 
 #include "qemu/osdep.h"
 
-#include "qemu/units.h"
+#include "hw/boards.h"
+#include "hw/mem/memory-device.h"
 #include "sysemu/numa.h"
-#include "qemu/error-report.h"
+#include "sysemu/qtest.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
-#include "sysemu/qtest.h"
-#include "hw/boards.h"
-#include "hw/mem/memory-device.h"
-#include "qemu/option.h"
+#include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
+#include "qemu/option.h"
+#include "qemu/units.h"
 
 QemuOptsList qemu_numa_opts = {
     .name = "numa",
-- 
2.34.1


