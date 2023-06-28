Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4347412D9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 15:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVTg-0005Bd-9p; Wed, 28 Jun 2023 09:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTc-0005Av-Ui
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:57 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qEVTb-00088Q-DC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 09:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687959895; x=1719495895;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/p2yXUJZCsxnEMkGSLP23fJhX9cTP2S05PNdFSoPzpY=;
 b=Hn8PaDPFw6ao+L6y9ckHn7M6MJD4AQerq6M3HAkQCicY4m3w3Ezm1hv3
 46Te8vsnZ17JzAX5q7OJqqxGRp04ECbZxdfE4GyUek8KZ9D7sBxvLRSgZ
 wqgFXfTTEU8ye71cmz84QVJyB1S3B088RXcqzk3cLK6AT4oMeS3seTHue
 /WL44jGKU1Cs6Wd2ERG9tKjKhAdNNrbZJT4feJOp8q9S85neNHc944+5T
 NJFiqLABiMO4NraE2GyClZ3J8BXLT1U8oYVTTyR3d14mUUTVH7nPyg4hf
 xkgc7rMj2ROgeeerd+TJfj0mioJHmWmGm1rzfK/Xr4KxPZBJ/1DYG+Dx6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427854116"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="427854116"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 06:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806905470"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; d="scan'208";a="806905470"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2023 06:44:48 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 1/4] machine: Add helpers to get cores/threads per socket
Date: Wed, 28 Jun 2023 21:54:34 +0800
Message-Id: <20230628135437.1145805-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
References: <20230628135437.1145805-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga07.intel.com
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
v4:
 * Put the declarations/definitions after machine_parse_smp_config()
   to avoid missing future topology related changes. (Igor)

v3:
 * The new patch to wrap the calculation of cores/threads per socket.
---
 hw/core/machine-smp.c | 10 ++++++++++
 include/hw/boards.h   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
index 89fe0cda4275..0f4d9b6f7a9f 100644
--- a/hw/core/machine-smp.c
+++ b/hw/core/machine-smp.c
@@ -197,3 +197,13 @@ void machine_parse_smp_config(MachineState *ms,
         return;
     }
 }
+
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
+{
+    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
+}
+
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
+{
+    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
+}
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 6b267c21ce7d..12d9e9d17ce9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -35,6 +35,8 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                Error **errp);
 void machine_parse_smp_config(MachineState *ms,
                               const SMPConfiguration *config, Error **errp);
+unsigned int machine_topo_get_cores_per_socket(const MachineState *ms);
+unsigned int machine_topo_get_threads_per_socket(const MachineState *ms);
 
 /**
  * machine_class_allow_dynamic_sysbus_dev: Add type to list of valid devices
-- 
2.34.1


