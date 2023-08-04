Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D457708D2
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IU-0000Pu-Iw; Fri, 04 Aug 2023 15:17:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IS-0000PH-EM; Fri, 04 Aug 2023 15:17:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IR-0006xt-0H; Fri, 04 Aug 2023 15:17:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DBA821845C;
 Fri,  4 Aug 2023 22:17:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 709CC1B89F;
 Fri,  4 Aug 2023 22:16:51 +0300 (MSK)
Received: (nullmailer pid 1875717 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 42/63] util/interval-tree: Use qatomic_set_mb in
 rb_link_node
Date: Fri,  4 Aug 2023 22:16:25 +0300
Message-Id: <20230804191647.1875608-11-mjt@tls.msk.ru>
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

Ensure that the stores to rb_left and rb_right are complete before
inserting the new node into the tree.  Otherwise a concurrent reader
could see garbage in the new leaf.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 4c8baa02d36379507afd17bdea87aabe0aa32ed3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: s/qatomic_set_mb/qatomic_mb_set/ for 8.0 - it was renamed later)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index 5a0ad21b2d..2000cd2935 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -128,7 +128,11 @@ static inline void rb_link_node(RBNode *node, RBNode *parent, RBNode **rb_link)
     node->rb_parent_color = (uintptr_t)parent;
     node->rb_left = node->rb_right = NULL;
 
-    qatomic_set(rb_link, node);
+    /*
+     * Ensure that node is initialized before insertion,
+     * as viewed by a concurrent search.
+     */
+    qatomic_mb_set(rb_link, node);
 }
 
 static RBNode *rb_next(RBNode *node)
-- 
2.39.2


