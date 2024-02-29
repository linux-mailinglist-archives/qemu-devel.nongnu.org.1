Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D986CF04
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 17:27:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjEr-0006me-Vk; Thu, 29 Feb 2024 11:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfjEj-0006m2-VB
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:26:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfjEh-0006zA-Mj
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:26:21 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlxMS6PsKz6K8sx;
 Fri,  1 Mar 2024 00:22:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A4880140B63;
 Fri,  1 Mar 2024 00:26:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:26:16 +0000
To: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
 <ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
CC: <linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
 <daniel@linux.ibm.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH 1/2] hmat acpi: Do not add Memory Proximity Domain Attributes
 Structure targetting non existent memory.
Date: Thu, 29 Feb 2024 16:25:44 +0000
Message-ID: <20240229162545.7887-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
References: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

If qemu is started with a proximity node containing CPUs alone,
it will provide one of these structures to say memory in this
node is directly connected to itself.

This description is arguably pointless even if there is memory
in the node.  If there is no memory present, and hence no SRAT
entry it breaks Linux HMAT passing and the table is rejected.

https://elixir.bootlin.com/linux/latest/source/drivers/acpi/numa/hmat.c#L444

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/hmat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index 3042d223c8..723ae28d32 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
     build_append_int_noprefix(table_data, 0, 4); /* Reserved */
 
     for (i = 0; i < numa_state->num_nodes; i++) {
+        /*
+         * Linux rejects whole HMAT table if a node with no memory
+         * has one of these structures listing it as a target.
+         */
+        if (!numa_state->nodes[i].node_mem) {
+            continue;
+        }
         flags = 0;
 
         if (numa_state->nodes[i].initiator < MAX_NODES) {
-- 
2.39.2


