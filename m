Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FF82D624
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:37:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOK-0002xz-Ig; Mon, 15 Jan 2024 04:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOI-0002xq-Ht
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:22 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOG-00083y-UC
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311380; x=1736847380;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bEuuzhlR+r/Qy0aq8IIdnaQz63UEvVOGDNMZ/dCZ9KE=;
 b=LqVcmKMIyMjSzNHatrUKdWXgwO+bYAkjDfLKKeGsSSpnxryTADVWCkV9
 4OYVQGSUUzGgqI4qQz3u5XzbH/nLm3cJ4/+TBD/xTrpP1lYJ6WCfvyNDH
 voHZZ0i3VqHF5MmOaHmqJE9FhJEoEs668K1pxqhdOllzhySBLFcle1lF0
 B9LGtql9bAQY/pLx50ZTE8BfHGgQ6bjTnUafkeJJKYoJk2asuuW5lIHWa
 JhRv6aoBWZCIUQpl0Wi4J7MuopcLs5YkIvEdkapm6YehEd59SleEq7FRc
 CHTLtnbuxKrQmIJtpAdkMZLlIGRa3bjQ6ROgTf1vm/i02tQOIBAmfCWFv A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439814"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594175"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594175"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:18 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/11] hw/core: Reorder included headers in null-machine.c
Date: Mon, 15 Jan 2024 17:48:50 +0800
Message-Id: <20240115094852.3597165-10-zhao1.liu@linux.intel.com>
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
 hw/core/null-machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index a0c7acc19cc3..3d411de3396a 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -13,9 +13,9 @@
 
 #include "qemu/osdep.h"
 
-#include "qemu/error-report.h"
-#include "hw/boards.h"
 #include "exec/address-spaces.h"
+#include "hw/boards.h"
+#include "qemu/error-report.h"
 
 static void machine_none_init(MachineState *mch)
 {
-- 
2.34.1


