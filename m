Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7893736955
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:31:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYd3-0005y0-Lv; Tue, 20 Jun 2023 06:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYd1-0005xW-DT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:27 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qBYcz-00025J-BX
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687257025; x=1718793025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XtGF3rDPdMt7poim1y2TNhlQXEggOR07qVtZUaWbAbg=;
 b=AowuhHZrrNMi5wG5ENsF3kYR0l8+nYkdb6MkP83XsqM1yUoUtuDcK33l
 qWO7kGxP/EL2ffDMJF6lEs3Jb8G42u4l+Wi1tU3PC6J5fLNFQTumXOC+R
 ZJsc4+fj4QiqdW99wcaiZaubCSwnGJp7HRZBeVlcn8LKNSUywiVDrz+66
 Y717uX2Po47uMjiZUyiCR+13ymo6hwb5U4/z2IUa0c3MfSm2DAYmunCD+
 gvd1V7HqIJxnD+CjjjK4j9/MmVePapI0YWiH8TbrqYUvEmrQJx8GMMi3d
 KFvZFGD3Et3GkICxenT9G/C3LHCQLYW5u5E584z70kSc3+WRnA2SGnQUM g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="423488456"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="423488456"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 03:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="714002236"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="714002236"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by orsmga002.jf.intel.com with ESMTP; 20 Jun 2023 03:30:20 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 1/4] machine: Add helpers to get cores/threads per socket
Date: Tue, 20 Jun 2023 18:39:55 +0800
Message-Id: <20230620103958.3907565-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga06.intel.com
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

The number of cores/threads per socket are needed for smbios, and are
also useful for other modules.

Provide the helpers to wrap the calculation of cores/threads per socket
so that we can avoid calculation errors caused by other modules miss
topology changes.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
v3:
 * The new patch to wrap the calculation of cores/threads per socket.
---
 include/hw/boards.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a385010909d5..40ee22fd93e3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -384,6 +384,18 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+static inline
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+{
+    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+}
+
+static inline
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+{
+    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
+}
+
 extern GlobalProperty hw_compat_8_0[];
 extern const size_t hw_compat_8_0_len;
 
-- 
2.34.1


