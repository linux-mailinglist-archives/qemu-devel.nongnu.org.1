Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7637FA34F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:44:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cqJ-0001nY-5k; Mon, 27 Nov 2023 09:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqE-0001kf-Hk
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:06 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r7cqB-0002X0-AL
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701096243; x=1732632243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IQfImQG4moP9qan3oDU5QGVMINhdkRXqhe/QcRm3GjU=;
 b=VWJYSh2hZmJWabJVgvnvFL+/fs4Kmw1Z46x+gaBJqZiQPtI0bMduQboA
 qmySe+evoXb3WRj4etuMwIdMw4TpIJRTnLvDE63g1PzIm3SjjZZjFKbdf
 v3Lt4mYmPxWe5kAjOoRMK6/1zR9fik+kmwXSScq+nMV5lGeWTwyiqthc/
 7grGwic/AIAJPNS7cRDodw9NdG5ZMsAQpOI/Hey3tt8A6Pbcl8Ue5A5V+
 UvIH53RjO0l8ercr9hUH0TfQMIWr5VYnF19ujbQXdzGcnhngvFzLqDRuk
 A/h3isDvy+rrSBu9yyaWWSOya3JVT9C2cLhCc1GdPT0ZeyKBDdiK6biId Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="396623370"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="396623370"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 06:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1099796689"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; d="scan'208";a="1099796689"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga005.fm.intel.com with ESMTP; 27 Nov 2023 06:43:58 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] hw/cpu/core: Cleanup unused included header in core.c
Date: Mon, 27 Nov 2023 22:56:10 +0800
Message-Id: <20231127145611.925817-2-zhao1.liu@linux.intel.com>
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

Remove unused header (qemu/module.h and sysemu/cpus.h) in core.c,
and reorder the remaining header files (except qemu/osdep.h) in
alphabetical order.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/cpu/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 987607515574..495a5c30ffe1 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -8,12 +8,11 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "hw/boards.h"
 #include "hw/cpu/core.h"
-#include "qapi/visitor.h"
-#include "qemu/module.h"
 #include "qapi/error.h"
-#include "sysemu/cpus.h"
-#include "hw/boards.h"
+#include "qapi/visitor.h"
 
 static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
-- 
2.34.1


