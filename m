Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A57FA352
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:45:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cqI-0001kG-Dg; Mon, 27 Nov 2023 09:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqD-0001hB-EX
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:05 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqB-0002X4-AT
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701096243; x=1732632243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q09iBhDyS3OMei81R4AkLL93z/3CC1BQeZX923N/BRQ=;
 b=euFscJ1j11C/nvh5A9+w02odeO0eU8rCVLXTNq3Ms2WTAOYhbF2bmsin
 g+VL4eKMwKVlLnlJu1jK1a2q9Y+R1kj6DweSjUQbmrzEdcuHt8Atf2yRq
 C37jXlDPclYALS9UDqrgBg3hj0IALHLRTjc3yrw4NSFcwcjrndV+iOX23
 uZxFuZLrgvfVoIjoBCamJ8u17JhrcZ0gRBXM03OAGBuJ2ZY0eHAVP56lV
 jVVJzf600IJ0XwHIOG4wJx+slIakO43QXv0wN9oNWil1nnQH4aJUr3a1X
 KvxfogtvETwHDsPDi/26nouLb4rqQZjKxgDrgVV8pbY9BI2UaOv/3t5/v w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396623379"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="396623379"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 06:44:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1099796693"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="1099796693"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2023 06:44:00 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] hw/cpu/cluster: Cleanup unused included header in
 cluster.c
Date: Mon, 27 Nov 2023 22:56:11 +0800
Message-Id: <20231127145611.925817-3-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
References: <20231127145611.925817-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Remove unused header (qemu/module.h and qemu/cutils.h) in cluster.c,
and reorder the remaining header files (except qemu/osdep.h) in
alphabetical order.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cpu/cluster.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index e444b7c29d1b..61289a840d46 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -19,12 +19,11 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/qdev-properties.h"
-#include "hw/core/cpu.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
-#include "qemu/cutils.h"
 
 static Property cpu_cluster_properties[] = {
     DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
-- 
2.34.1


