Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D409D720488
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55oF-0001ac-Cz; Fri, 02 Jun 2023 10:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q55nt-0001WV-Jz
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:30:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gudkov.andrei@huawei.com>)
 id 1q55nr-0007N1-9v
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:30:57 -0400
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXlk7574Lz67fBs;
 Fri,  2 Jun 2023 22:29:03 +0800 (CST)
Received: from DESKTOP-0LHM7NF.huawei.com (10.199.58.101) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 15:30:47 +0100
To: <qemu-devel@nongnu.org>
CC: <eduardo@habkost.net>, <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, 
 <wangyanan55@huawei.com>, <eblake@redhat.com>, <armbru@redhat.com>, Andrei
 Gudkov <gudkov.andrei@huawei.com>
Subject: [PATCH v2] qmp: Report page size in query-memory-size-summary
Date: Fri, 2 Jun 2023 17:30:31 +0300
Message-ID: <fb7211cf5e51e56d57e534093202a366d12e155b.1685715838.git.gudkov.andrei@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.58.101]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=gudkov.andrei@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrei Gudkov <gudkov.andrei@huawei.com>
From:  Andrei Gudkov via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Some commands (query-migrate and calc-dirty-rate) report values
in units of pages. However, currently the only place where we can
get page size is through query-migrate and only after migration
has started. query-memory-size-summary seems like an appropritate
place where it should be reported instead.

Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/machine.json          | 8 ++++++--
 hw/core/machine-qmp-cmds.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 37660d8f2a..b53afc1352 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1125,10 +1125,13 @@
 #     field is omitted if target doesn't support memory hotplug (i.e.
 #     CONFIG_MEM_DEVICE not defined at build time).
 #
+# @page-size: size of target page in bytes (since 8.1)
+#
 # Since: 2.11
 ##
 { 'struct': 'MemoryInfo',
-  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
+  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size',
+              'page-size': 'size' } }
 
 ##
 # @query-memory-size-summary:
@@ -1139,7 +1142,8 @@
 # Example:
 #
 # -> { "execute": "query-memory-size-summary" }
-# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+# <- { "return": { "page-size": 4096, "base-memory": 34359738368,
+#      "plugged-memory": 0 } }
 #
 # Since: 2.11
 ##
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b..b768ff372f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -27,6 +27,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "exec/target_page.h"
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
@@ -289,6 +290,8 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
     mem_info->has_plugged_memory =
         mem_info->plugged_memory != (uint64_t)-1;
 
+    mem_info->page_size = qemu_target_page_size();
+
     return mem_info;
 }
 
-- 
2.30.2


