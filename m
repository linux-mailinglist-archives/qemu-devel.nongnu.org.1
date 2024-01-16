Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B3782EA21
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:35:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxi-0000Bb-PN; Tue, 16 Jan 2024 02:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxX-0008W5-0Y
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:08 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxU-00046E-Ug
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390445; x=1736926445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SiSuhcM+8Mn/QlR83zQgTFeaF4doZ0+AzNhvTDapYBc=;
 b=SCPsIbHagjmMBBSeStGo8XRf/ysgt0TxboJOZnh6/BBf1m71j1OYYgNF
 PssquIromVDaF9RwNEWCtCOtKDmL6SiF84+Baze5XBwhPTtjjkb1WOz9l
 0r5RboTcDeZ2eeu2rF2aa7nnyyczgj42Vnll9BCW8I3zDq3H9moUvZphX
 BO9b+bJKSWnb3JwpqYpLVTk8Tn1b05k2WKy3LotpZC1U3wyzAjNR0GU26
 akbV5aIvskLG2HBhCskHHJBmP/V66zadpouDk/zO8wfGMxm700eMPXNzB
 N5u/f+blzJjD8GOxTOZ9x3RyAvsE+hRKQJO9K9bsIrPq3OiPByVX4sBDt A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875730"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875730"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266406"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266406"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:33:58 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/9] hw/core: Reorder included headers in cpu-common.c
Date: Tue, 16 Jan 2024 15:46:41 +0800
Message-Id: <20240116074647.3644821-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
References: <20240116074647.3644821-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.13;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/core/cpu-common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index a27f0e4cf216..23fc58462ffd 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -19,17 +19,18 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
+
+#include "exec/log.h"
+#include "hw/boards.h"
 #include "hw/core/cpu.h"
-#include "sysemu/hw_accel.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "exec/log.h"
+#include "qemu/plugin.h"
+#include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
-#include "hw/boards.h"
-#include "hw/qdev-properties.h"
 #include "trace.h"
-#include "qemu/plugin.h"
 
 CPUState *cpu_by_arch_id(int64_t id)
 {
-- 
2.34.1


