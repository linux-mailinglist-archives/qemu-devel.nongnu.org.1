Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D997ACDD46
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 13:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmgn-0001bN-8T; Wed, 04 Jun 2025 07:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMmgk-0001aD-OO
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:53:46 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uMmgi-0008H3-S2
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:53:46 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bC5Tz1TDbz6H859;
 Wed,  4 Jun 2025 19:49:43 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id AB7E91402EA;
 Wed,  4 Jun 2025 19:53:38 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Jun 2025 13:53:37 +0200
To: <mst@redhat.com>
CC: <anisinha@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <prime.zeng@hisilicon.com>,
 <qemu-devel@nongnu.org>, <shameerali.kolothum.thodi@huawei.com>,
 <wangyanan55@huawei.com>, <yangyicong@hisilicon.com>, <maobibo@loongson.cn>,
 <gaosong@loongson.cn>, <jiaxun.yang@flygoat.com>
Subject: [PATCH v6 2/4] hw/acpi/aml-build: Set identical implementation flag
 for PPTT processor nodes
Date: Wed, 4 Jun 2025 12:52:31 +0100
Message-ID: <20250604115233.1234-3-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250604115233.1234-1-alireza.sanaee@huawei.com>
References: <20250604115233.1234-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Yicong Yang <yangyicong@hisilicon.com>

Per ACPI 6.5 Table 5.158: Processor Structure Flags, the identical
implementation flag indicates whether all the children processors
of this node share the same identical implementation revision.
Currently Linux support parsing this field [1] and maybe used to
identify the heterogeneous platform. Since qemu only support
homogeneous emulation, set this flag for all the processor node
to indicates the facts when building the PPTT table. Node leaf
is an exception since spec says this flag should be ignored
on leaf nodes by OSPM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 hw/acpi/aml-build.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index f8f93a9f66..560cee12a2 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2173,7 +2173,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             core_id = -1;
             socket_offset = table_data->len - pptt_start;
             build_processor_hierarchy_node(table_data,
-                (1 << 0), /* Physical package */
+                (1 << 0) | /* Physical package */
+                (1 << 4), /* Identical Implementation */
                 0, socket_id, NULL, 0);
         }
 
@@ -2184,7 +2185,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = -1;
                 cluster_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     socket_offset, cluster_id, NULL, 0);
             }
         } else {
@@ -2202,7 +2204,8 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 core_id = cpus->cpus[n].props.core_id;
                 core_offset = table_data->len - pptt_start;
                 build_processor_hierarchy_node(table_data,
-                    (0 << 0), /* Not a physical package */
+                    (0 << 0) | /* Not a physical package */
+                    (1 << 4), /* Identical Implementation */
                     cluster_offset, core_id, NULL, 0);
             }
 
-- 
2.43.0


