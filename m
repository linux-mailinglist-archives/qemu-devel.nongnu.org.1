Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11423727C49
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CWW-000059-Dp; Thu, 08 Jun 2023 06:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWM-0008VC-Az
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:35 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWI-0007r9-O3
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686218730; x=1717754730;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OaIkrpT4BJ2w/bnS1O5gHV/Ymm37eAt1QkoERXNUudw=;
 b=TyH2348QyE4Tmn1j+UvjHHH3GwXml4M3a8iG7amoaqWuIMpCABr92Hh2
 I+k/CWT8Ndz2o3Ch8eONPHu4g/r5jYh/m6sudeUmI87zn+4Au0uQHTIzW
 66Mj5Ycq2y/oQpFxFVPhQH4CmT3xONKxyB1u8sqqtiHfF8HERbMwgwVRe
 5JXRLCbhCrm24rhjCblFQrRVu2vCUFQjIO6poV2dSi9sc2OS1l2qPUVqD
 PHGvIukdx+uxGjaPIcZvEcOpB4y3ccMCM+naE44IYX6yHTf5hrP4A5RRs
 CcRf0mqIJgR3qA63xA35utwZqzanmertl7oTvtZt5bHjAuBqFvLykhjdh A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337624405"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="337624405"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956652033"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="956652033"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v3 1/5] util: Add iova_tree_foreach_range_data
Date: Thu,  8 Jun 2023 17:52:27 +0800
Message-Id: <20230608095231.225450-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608095231.225450-1-zhenzhong.duan@intel.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mga17.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This function is a variant of iova_tree_foreach and support tranversing
a range to trigger callback with a private data.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/qemu/iova-tree.h | 17 +++++++++++++++--
 util/iova-tree.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 8528e5c98fbc..df3dba79e671 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -39,6 +39,7 @@ typedef struct DMAMap {
     IOMMUAccessFlags perm;
 } QEMU_PACKED DMAMap;
 typedef gboolean (*iova_tree_iterator)(DMAMap *map);
+typedef gboolean (*iova_tree_iterator_2)(DMAMap *map, gpointer *private);
 
 /**
  * iova_tree_new:
@@ -131,11 +132,23 @@ const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
  * @iterator: the interator for the mappings, return true to stop
  *
  * Iterate over the iova tree.
- *
- * Return: 1 if found any overlap, 0 if not, <0 if error.
  */
 void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator);
 
+/**
+ * iova_tree_foreach_range_data:
+ *
+ * @tree: the iova tree to iterate on
+ * @range: the iova range to iterate in
+ * @func: the interator for the mappings, return true to stop
+ * @private: parameter passed to @func
+ *
+ * Iterate over an iova range in iova tree.
+ */
+void iova_tree_foreach_range_data(IOVATree *tree, DMAMap *range,
+                                  iova_tree_iterator_2 func,
+                                  gpointer *private);
+
 /**
  * iova_tree_alloc_map:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 536789797e47..a3cbd5198410 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -42,6 +42,12 @@ typedef struct IOVATreeFindIOVAArgs {
     const DMAMap *result;
 } IOVATreeFindIOVAArgs;
 
+typedef struct IOVATreeIterator {
+    DMAMap *range;
+    iova_tree_iterator_2 func;
+    gpointer *private;
+} IOVATreeIterator;
+
 /**
  * Iterate args to the next hole
  *
@@ -164,6 +170,31 @@ void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator)
     g_tree_foreach(tree->tree, iova_tree_traverse, iterator);
 }
 
+static gboolean iova_tree_traverse_range(gpointer key, gpointer value,
+                                         gpointer data)
+{
+    DMAMap *map = key;
+    IOVATreeIterator *iterator = data;
+    DMAMap *range = iterator->range;
+
+    g_assert(key == value);
+
+    if (iova_tree_compare(map, range, NULL)) {
+        return false;
+    }
+
+    return iterator->func(map, iterator->private);
+}
+
+void iova_tree_foreach_range_data(IOVATree *tree, DMAMap *range,
+                                  iova_tree_iterator_2 func,
+                                  gpointer *private)
+{
+    IOVATreeIterator iterator = {range, func, private};
+
+    g_tree_foreach(tree->tree, iova_tree_traverse_range, &iterator);
+}
+
 void iova_tree_remove(IOVATree *tree, DMAMap map)
 {
     const DMAMap *overlap;
-- 
2.34.1


