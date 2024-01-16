Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440382EA1D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:35:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxn-0000Ou-Nf; Tue, 16 Jan 2024 02:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxd-00009p-M5
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:14 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxc-00046E-0O
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390452; x=1736926452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LZ4YwLh7xZ5qCSwDHmL43Wtq67cj+xVfFSjMvsxICkg=;
 b=LSaAXnLYyrMKknVV+sbDAbcjyHS1kjin0ltUaWKwetbZq5/EJKI0YktM
 HzMT5KfThHS9sjYNn+MPgelmlZ4r90fEAabimJNrnbyT/mUPamvCa4wyS
 hKoOo3J+cklVGzdkZac5vgEI3NRrbDsCEKST+HUhRXVUEGkcRUVY3B8ZO
 DdiDwCqOW7Pvmd7LvdsC87KjkChEqdiVqljVPZ4YGhXzjSaTwdB5D5WKI
 7hhaTmjJehV7ZEh1gW7OGV6WDKXUnlP7VyzgS4O8rR1pRT7q1MB9rJ022
 aZ39486THIZIU0BnS1itFwK16IIrKERV+HfSuA7cd4ueiHpM8hM5dojST Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875788"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875788"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:34:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266434"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266434"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:34:09 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 8/9] hw/core: Cleanup unused included headers in numa.c
Date: Tue, 16 Jan 2024 15:46:46 +0800
Message-Id: <20240116074647.3644821-9-zhao1.liu@linux.intel.com>
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

Remove unused header in numa.c:
* qemu/bitmap.h
* hw/core/cpu.h
* migration/vmstate.h

Note: Though parse_numa_hmat_lb() has the variable named "bitmap_copy",
it doesn't use the normal bitmap ops so that it's safe to exclude
qemu/bitmap.h header.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/numa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0ff..05c5e1b8514c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -28,15 +28,12 @@
 #include "sysemu/numa.h"
 #include "exec/cpu-common.h"
 #include "exec/ramlist.h"
-#include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
 #include "sysemu/qtest.h"
-#include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
-#include "migration/vmstate.h"
 #include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
-- 
2.34.1


