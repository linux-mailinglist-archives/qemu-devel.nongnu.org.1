Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CD7AE9D9
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4sk-0001X7-DB; Tue, 26 Sep 2023 06:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql4sh-0001Wa-If
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:01:27 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql4sf-0002qF-OC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:01:27 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="133516945"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="133516945"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:01:21 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F573CA1F6
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 19:01:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B0368BF3EE
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 19:01:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 06EA46B4CD;
 Tue, 26 Sep 2023 19:01:17 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 1/2] migration: Fix rdma migration failed
Date: Tue, 26 Sep 2023 18:01:02 +0800
Message-Id: <20230926100103.201564-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27898.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27898.006
X-TMASE-Result: 10--1.412000-10.000000
X-TMASE-MatchedRID: zpx2FW2iGB2FwUteYPHGhodlc1JaOB1TtOtXYgbXjdcK5I+5JVbn7g0I
 08nED9RP8cvWsIenGsqYOOZE3xC5+gx38j2cF8Y5Zj7E6vHnuNZxXefgn/TNQ4XsbVsdXVIhaxZ
 lX1gwMFvZGePDijvWaMF/GAwb/oaoAxYKB0LOn5pO5y1KmK5bJRSLgSFq3Tnjl0Ik8/WjLEv6sR
 z1g/tlo+LzNWBegCW2wgn7iDBesS0nRE+fI6etkpx9gakZ+XoSPGjvsBBe5M+ONC7g5fTwXYyD7
 ekdnr7jE8Mj4Gc7fjny6BFf8rbc46RQp5GRTugVRcPGl3YXpvlrhczDbcasiMBgvHuudtHysNDy
 bdOqCWh6WkJecb4mO8MYFnUbyvVJ/YPqDH/SjOk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.47; envelope-from=lizhijian@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
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

Migration over RDMA failed since
commit: 294e5a4034 ("multifd: Only flush once each full round of memory")
with erors:
qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.

migration with RDMA is different from tcp. RDMA has its own control
message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.

find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic(
RAM_SAVE_FLAG_MULTIFD_FLUSH) to destination and cause migration to fail
even though multifd is disabled.

This change make migrate_multifd_flush_after_each_section() return true
when multifd is disabled, that also means RAM_SAVE_FLAG_MULTIFD_FLUSH
will not be sent to destination any more when multifd is disabled.

Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
CC: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---

V2: put that check at the entry of migrate_multifd_flush_after_each_section() # Peter
---
 migration/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..327bcf2fbe 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -368,7 +368,7 @@ bool migrate_multifd_flush_after_each_section(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->multifd_flush_after_each_section;
+    return !migrate_multifd() || s->multifd_flush_after_each_section;
 }
 
 bool migrate_postcopy(void)
-- 
2.31.1


