Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B938E7A76DA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:08:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitBM-0002PZ-1c; Wed, 20 Sep 2023 05:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qitBK-0002PM-Sy
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:07:38 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qitBI-00076h-59
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 05:07:38 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="120600402"
X-IronPort-AV: E=Sophos;i="6.02,161,1688396400"; d="scan'208";a="120600402"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 18:04:26 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B30E9DB4C9
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 18:04:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 00A2BCF7C3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 18:04:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4664420079DE3;
 Wed, 20 Sep 2023 18:04:23 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 2/2] migration/rdma: zore out head.repeat to make the error
 more clear
Date: Wed, 20 Sep 2023 17:04:12 +0800
Message-Id: <20230920090412.726725-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230920090412.726725-1-lizhijian@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27886.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27886.006
X-TMASE-Result: 10--1.385700-10.000000
X-TMASE-MatchedRID: uf8KE2NGjd/Pl7LciQedThlxrtI3TxRkWmOfr3aLpwhXGTbsQqHbkr8F
 Hrw7frluf146W0iUu2umUJpFI8DJTQptKxOf4+lkFWovz5bBLuZ9LQinZ4QefCP/VFuTOXUTPvB
 STRncWKuOhzOa6g8KrctN2aw9ovk3O+fazB/hfuG+zgPhrwbGbj80gxOr8kkGXzZUn+CiLNMPZ6
 wX+r/FDnfw4IwIjIlLStbgstrO1lx6VXXn3wwvNRXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
 0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
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

Previously, we got a confusion error that complains
the RDMAControlHeader.repeat:
qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.

Actually, it's caused by an unexpected RDMAControlHeader.type.
After this patch, error will become:
qemu-system-x86_64: Unknown control message QEMU FILE

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 migration/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a2a3db35b1..3073d9953c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2812,7 +2812,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         size_t remaining = iov[i].iov_len;
         uint8_t * data = (void *)iov[i].iov_base;
         while (remaining) {
-            RDMAControlHeader head;
+            RDMAControlHeader head = {};
 
             len = MIN(remaining, RDMA_SEND_INCREMENT);
             remaining -= len;
-- 
2.31.1


