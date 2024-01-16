Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723682EA20
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:35:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdxn-0000Ng-4c; Tue, 16 Jan 2024 02:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxa-00005x-Rx
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:11 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPdxX-00046E-HB
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705390447; x=1736926447;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hHzSlIHBs1Sa8almQ7WO1KqK41saKKNuT3QqQ7B7XnE=;
 b=h4M7G7I90djDB9UXlvzk8C4vay3u3E86l4d4faEXUaZsQMDeYZMUOj8/
 jP9bKKnLCVIPXBWD4YG5BRUt9aKWfEGjQYCIARlQvpKHl9jvV0jf/j0nm
 3quG/SLvjycfVvMcRLUO4A76z+YVDJYYOPtGpteFQfQJZqc40WezeaQbf
 4FpihMs7k7kPw+6RA6qJcUynhp5tm6X+Zzt0h/UQEL60ItvmTvQLwvCxr
 ZKmmOvbBphF7zI52ApJLaEqgKYPM/IVE1I6Z+kPB0m4akcBwpZvFzW4dv
 OnXEOHraPxhXDntjjl1o5QMGktXzc1arRR0RPIqlehjgL+pi3khSosfH5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6875773"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="6875773"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 23:34:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="854266421"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; d="scan'208";a="854266421"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 23:34:04 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 6/9] hw/core: Reorder included header in machine.c
Date: Tue, 16 Jan 2024 15:46:44 +0800
Message-Id: <20240116074647.3644821-7-zhao1.liu@linux.intel.com>
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
 hw/core/machine.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index fb5afdcae4cc..00f2f24ee79e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -11,26 +11,27 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/accel.h"
-#include "sysemu/replay.h"
+
+#include "audio/audio.h"
+#include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "hw/mem/nvdimm.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
+#include "migration/global_state.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qemu/accel.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/cpus.h"
+#include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "sysemu/xen.h"
-#include "sysemu/qtest.h"
-#include "hw/pci/pci_bridge.h"
-#include "hw/mem/nvdimm.h"
-#include "migration/global_state.h"
-#include "exec/confidential-guest-support.h"
-#include "hw/virtio/virtio-pci.h"
-#include "hw/virtio/virtio-net.h"
-#include "audio/audio.h"
 
 GlobalProperty hw_compat_8_2[] = {};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
-- 
2.34.1


