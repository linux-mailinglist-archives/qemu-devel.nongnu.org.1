Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D027708D0
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IS-0000OZ-Aj; Fri, 04 Aug 2023 15:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IP-0000Nw-VJ; Fri, 04 Aug 2023 15:17:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IO-0006xV-CZ; Fri, 04 Aug 2023 15:17:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AACE81845B;
 Fri,  4 Aug 2023 22:17:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2BA031B89E;
 Fri,  4 Aug 2023 22:16:51 +0300 (MSK)
Received: (nullmailer pid 1875714 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 41/63] util/interval-tree: Use qatomic_read for
 left/right while searching
Date: Fri,  4 Aug 2023 22:16:24 +0300
Message-Id: <20230804191647.1875608-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Fixes a race condition (generally without optimization) in which
the subtree is re-read after the protecting if condition.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 055b86e0f0b4325117055d8d31c49011258f4af3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 4c0baf108f..5a0ad21b2d 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -745,8 +745,9 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
          * Loop invariant: start <= node->subtree_last
          * (Cond2 is satisfied by one of the subtree nodes)
          */
-        if (node->rb.rb_left) {
-            IntervalTreeNode *left = rb_to_itree(node->rb.rb_left);
+        RBNode *tmp = qatomic_read(&node->rb.rb_left);
+        if (tmp) {
+            IntervalTreeNode *left = rb_to_itree(tmp);
 
             if (start <= left->subtree_last) {
                 /*
@@ -765,8 +766,9 @@ static IntervalTreeNode *interval_tree_subtree_search(IntervalTreeNode *node,
             if (start <= node->last) {     /* Cond2 */
                 return node; /* node is leftmost match */
             }
-            if (node->rb.rb_right) {
-                node = rb_to_itree(node->rb.rb_right);
+            tmp = qatomic_read(&node->rb.rb_right);
+            if (tmp) {
+                node = rb_to_itree(tmp);
                 if (start <= node->subtree_last) {
                     continue;
                 }
@@ -814,8 +816,9 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
 IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
                                           uint64_t start, uint64_t last)
 {
-    RBNode *rb = node->rb.rb_right, *prev;
+    RBNode *rb, *prev;
 
+    rb = qatomic_read(&node->rb.rb_right);
     while (true) {
         /*
          * Loop invariants:
@@ -840,7 +843,7 @@ IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
             }
             prev = &node->rb;
             node = rb_to_itree(rb);
-            rb = node->rb.rb_right;
+            rb = qatomic_read(&node->rb.rb_right);
         } while (prev == rb);
 
         /* Check if the node intersects [start;last] */
-- 
2.39.2


