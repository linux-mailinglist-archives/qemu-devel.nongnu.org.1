Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D74719382
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c4p-0004Hv-Rr; Thu, 01 Jun 2023 02:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4n-0004H7-JD
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:25 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4l-000762-Sy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685601983; x=1717137983;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KihC+dgXoto8EsPZ7B7+rYy+MeCePUN/hrcJxPBQAUs=;
 b=XLkwc+GQR4k6bwZUi9qT7gFW00X1+AEJtpOvbH+30D4TJ53+kv7v347R
 oiHd7A3lq3co7uLGAkb/x7VmbMQPLW9vN+Ju+F7iwoY5zADBAYhFZYqVE
 g9yGhIqj6yoVoy/X5/iwqUEMAChO5WAYlf9lbjgdwkHpFk06pGSWFzoiB
 l0k+6g/3gG06+w0iS6lS4oK7p48Re1xradTyKnn9y3oAsAAeVHSOF1Lql
 tarYX6BoJ77EZEBe4Ztr/Dvj1QMKcrGNAFz3Alq86pWy1+09cNYWzxJDl
 7kTy7GPHp6qaTx8dW1P7meu/3OXA0eKi9SlZaHmJns8hasEa74JmokbOt w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421249321"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="421249321"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953953058"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953953058"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v2 1/4] util: Add iova_tree_foreach_range_data
Date: Thu,  1 Jun 2023 14:33:17 +0800
Message-Id: <20230601063320.139308-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601063320.139308-1-zhenzhong.duan@intel.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/qemu/iova-tree.h | 17 +++++++++++++++--
 util/iova-tree.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 8528e5c98fbc..8bbf049dc3f7 100644
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
+ * @func: the iterator for the mappings, return true to stop
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


