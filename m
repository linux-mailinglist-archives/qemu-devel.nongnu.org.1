Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C07AE9DA
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4sl-0001X8-La; Tue, 26 Sep 2023 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql4sh-0001Wb-La
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:01:27 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql4sg-0002qN-1H
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:01:27 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="121418336"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="121418336"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:01:22 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EAE33D29F4
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 19:01:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1E06127FF5
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 19:01:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E44F6B4CE;
 Tue, 26 Sep 2023 19:01:18 +0900 (JST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/2] migration/rdma: zore out head.repeat to make the error
 more clear
Date: Tue, 26 Sep 2023 18:01:03 +0800
Message-Id: <20230926100103.201564-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230926100103.201564-1-lizhijian@fujitsu.com>
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27898.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27898.006
X-TMASE-Result: 10--2.625200-10.000000
X-TMASE-MatchedRID: plCaRSPAyU3Pl7LciQedThlxrtI3TxRkWmOfr3aLpwgJUkv4UwDKC8eq
 jwfsQKsdEMFbZCyHyy1oVBGpf4JXIy/7QU2czuUNA9lly13c/gGOVGny5q72huuLH9BII+4qghU
 rQpNGkuDi8zVgXoAltr8hWd4lAsFlC24oEZ6SpSmcfuxsiY4QFFggWFCgmjZaKcCOJdct2GVSVn
 qwSPdVCiZNRCaDEI1Qd0CYXkdSYPHX1tsqFN3y7JZdI79RX+WSC8qU4QE+NZdeLWAU60mafpsNE
 GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
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

Previously, we got a confusion error that complains
the RDMAControlHeader.repeat:
qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.

Actually, it's caused by an unexpected RDMAControlHeader.type.
After this patch, error will become:
qemu-system-x86_64: Unknown control message QEMU FILE

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

---
V2: add reviewed-by tags
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


