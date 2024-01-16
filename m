Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EBC82EA23
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxh-00007R-GB; Tue, 16 Jan 2024 02:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxV-0008UY-DB
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:06 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxS-00046M-Dj
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390442; x=1736926442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X+6c34e/8F3duGc2w/FpbZOJxiKJuKbR/1Ow21zAjAE=;
 b=BaOLkM0fkRz3eh7GGwk7MueZQDTV55K6WEZpjA6L/5gOR6HQ9ZoqjrS+
 fxsh/W4Hhsj3TVL8VJ6d/UI5IL8CoGWNzVSzRy3Fb7yE+iJuWbzHNGB+u
 R6cM1ZDfKNXkkOrTWKfzf1ie4s3H0nCQIR8cgG51tiayWNE7LdeBvEMq3
 Te/13RzH31gcXPGTFRZcDA6n+1+Qi5tUc5AwsIIx0nNtNHwlNVMwyLol4
 QG/kh4tkXr0IrUy3gmADKE6QEuCS7llZCiqOlV7i0mJMU55cd1b3HLpCu
 O+eiWYPLVK3xr8y+jVPjPF+SeuEAHp4CeOCddQhdKP104UCRXmcGTVYi1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875720"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875720"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:33:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266403"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266403"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:33:56 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 2/9] hw/core: Cleanup unused included headers in
 cpu-common.c
Date: Tue, 16 Jan 2024 15:46:40 +0800
Message-Id: <20240116074647.3644821-3-zhao1.liu@linux.intel.com>
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

Remove unused headers in cpu-common.c:
* qemu/notify.h
* exec/cpu-common.h
* qemu/error-report.h
* qemu/qemu-print.h

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/cpu-common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 3ccfe882e2c3..a27f0e4cf216 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -22,13 +22,9 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "sysemu/hw_accel.h"
-#include "qemu/notify.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
-#include "exec/cpu-common.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-- 
2.34.1


