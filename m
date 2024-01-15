Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A282D625
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOM-00030G-T5; Mon, 15 Jan 2024 04:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOK-0002yd-Nb
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:24 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOJ-00083y-7Y
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311383; x=1736847383;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ae3UEVtEQon0zcDRm0hrrOZyUSj7p14La3m7kAvib84=;
 b=fRKfdd2e2fWshXxtMzQIrog21OrVqiGGkwfKb5pK2CzgOPUpjMGJyaoF
 nFc2luRkEXTLLRxdsYv2UittKYVkcAOSdikzYu8mtdcTsKhEplAsT0yyi
 kdzAJVdJ3bSuuzmU06lTEUVhGy0WsMDv8Eba1JqfKwUtD5GrRwqjmxY2B
 H5eZ+0PCy5ASagLDYIXRVJJXLoB7uko94npnCsnutnMPzXvSxdW1768OY
 MBPCrxeiNjDouRvh2EEago2+f6C810lXEEFUbQJCO9RQxW6VlN+ENdzrN
 yGhs0jAPQQ122J/YQd+chm999HMjffd738aHzxycLOSK0z6swSezJkhkS Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439827"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594178"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594178"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:20 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/11] hw/core: Cleanup unused included headers in numa.c
Date: Mon, 15 Jan 2024 17:48:51 +0800
Message-Id: <20240115094852.3597165-11-zhao1.liu@linux.intel.com>
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

Remove unused header in numa.c:
* sysemu/hostmem.h
* exec/cpu-common.h
* exec/ramlist.h
* qemu/bitmap.h
* hw/core/cpu.h
* hw/mem/pc-dimm.h
* migration/vmstate.h

Though sysemu/numa.h has been included by sysemu/hostmem.h which is
included by hw/boards.h, to keep the dependency clear, still directly
include sysemu/numa.h in this file.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/numa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0ff..ab3f2858ac51 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -23,20 +23,14 @@
  */
 
 #include "qemu/osdep.h"
+
 #include "qemu/units.h"
-#include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
-#include "exec/cpu-common.h"
-#include "exec/ramlist.h"
-#include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
 #include "sysemu/qtest.h"
-#include "hw/core/cpu.h"
-#include "hw/mem/pc-dimm.h"
-#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
-- 
2.34.1


