Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F67A76D9
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitBJ-0002P5-H2; Wed, 20 Sep 2023 05:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qitBF-0002Os-2g
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:07:33 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qitBD-000769-Aw
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:07:32 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="112169234"
X-IronPort-AV: E=Sophos;i="6.02,161,1688396400"; d="scan'208";a="112169234"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 18:04:25 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D1DBC53C0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 18:04:23 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F86DD5E31
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 18:04:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 84AA320079DE3;
 Wed, 20 Sep 2023 18:04:21 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 1/2] migration: Fix rdma migration failed
Date: Wed, 20 Sep 2023 17:04:11 +0800
Message-Id: <20230920090412.726725-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27886.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27886.006
X-TMASE-Result: 10-2.297000-10.000000
X-TMASE-MatchedRID: KMMnXaORctwfx149IVy3SQXGi/7cli9j9v33UW8WNYAGKrU/PL/UzM8O
 alpDJEQlKOl0BKq+GP3F1xiPPtcfNVR/KlnDpLSljplZJ6bbMPvDCscXmnDN78C5DTEMxpeQfiq
 1gj2xET+PqQJ9fQR1zloV9mdiYeILNrsgG44+2ESeAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
 5d3cxkNSjP2C1ICtW8I8mYibu59R+c9H8E6x39yq653F7bLuweAeDbdFiAXMvEKfGlkN1947lMH
 9WJSaiPfXXYWshnKeV5e508+Jajcu4zq2MCCj3QFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
 HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137; envelope-from=lizhijian@fujitsu.com;
 helo=esa11.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Destination will fail with:
qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.

migrate with RDMA is different from tcp. RDMA has its own control
message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.

find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic to
destination and cause migration to fail.

Since there's no existing subroutine to indicate whether it's migrated
by RDMA or not, and RDMA is not compatible with multifd, we use
migrate_multifd() here.

Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 migration/ram.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..89ae28e21a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1399,7 +1399,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (!migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main(f);
                 if (ret < 0) {
-- 
2.31.1


