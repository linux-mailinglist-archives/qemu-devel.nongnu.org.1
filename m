Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0270882D626
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:37:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJOH-0002wE-AY; Mon, 15 Jan 2024 04:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOE-0002uy-NM
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:18 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rPJOC-00084H-Nq
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705311376; x=1736847376;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/1Uxm7TXZFuEah25rWzAdZsTGu5hTcUNKhbNsRucjwU=;
 b=Y1vYvHeVkwT7y3Vj7CsALSBPO1GokHT3Uz2f1dvS5NN0lSpFVqY1EnE9
 F2mx6/y82SU4CjcCFtZvTV+FhqLNEzBbW0keZRYwwooeS0P/mk3ymebTH
 KAs0+EXsxLuoe/Kcgxlzx2d5SvrtTFO+OABqdsNIsQfbVcouiFpKIjVwu
 RF4pMj4U4UHFKVNjLCio8tajqWcS7Pyi/Eil9TEyPyr13cAU6EP2KyXup
 +OX0c+v4CiIfGteJmhpkQYfmsD7EOv6CaeEAejyKTG44v7r/V3Mm23DCe
 PonfQbWCLE22lkEc5INT/lRSfy7KwJHdW8VJzq7ECsmqX2pXlAewduBwn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398439758"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="398439758"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 01:36:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030594162"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030594162"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 15 Jan 2024 01:36:11 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/11] hw/core: Cleanup unused included headers in
 machine-qmp-cmds.c
Date: Mon, 15 Jan 2024 17:48:46 +0800
Message-Id: <20240115094852.3597165-6-zhao1.liu@linux.intel.com>
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

Remove unused headers in machine-qmp-cmds.c:
* qemu/main-loop.h
* qemu/uuid.h
* sysemu/hostmem.h

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine-qmp-cmds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b7b..1b2b4cce5386 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+
 #include "hw/acpi/vmgenid.h"
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
@@ -19,10 +20,7 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
-#include "qemu/main-loop.h"
-#include "qemu/uuid.h"
 #include "qom/qom-qobject.h"
-#include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
-- 
2.34.1


