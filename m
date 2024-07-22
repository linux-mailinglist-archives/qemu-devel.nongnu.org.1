Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF49387FB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jul 2024 06:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkNG-000652-My; Mon, 22 Jul 2024 00:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMh-0003e8-0U; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMd-0001uv-OD; Mon, 22 Jul 2024 00:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621373; x=1753157373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F5ChYdPZM2RGJKn48h9r2WBfiqQ8M0QNQ/FSXybAwHA=;
 b=oRHulWbPGYJiVZlBdEVj4jSGE/edbXgmuvOhZXt5IWKTr8L42tsEUKFH
 IO6SUW4ybCEY4u6LMzPp4+h7+Yk0TsPy7SutE3T8fAS+GpDtP9M8z6NFr
 LmdYjbQk6QjyqoP96PvkSZr9jkg0dvPzo4XClwvTS/SdCoPyqrfg6LB64
 PJvoRXoPG649LxxNqbnGTGTHXevKC0NpTF48CvztXEJW7pxUjnu1SuhxU
 P2YYmmo3ofhqICLjlinWMl+xC9RtHn6/E2Z0GTu7uzBWCfq97HljsOoA0
 mKh3nvUtnodB2XzwSwTRKGCOkENY/4GvH7JlPgUw/7eQriB7KCsePqRCL g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168068754"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="168068754"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:30 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id C2341D9227;
 Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1ED36BF3CE;
 Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B0C3A2007CAAE;
 Mon, 22 Jul 2024 13:09:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3E8911A000C;
 Mon, 22 Jul 2024 12:09:25 +0800 (CST)
To: qemu-devel@nongnu.org, Jeff Cody <codyprime@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	qemu-block@nongnu.org
Subject: [PATCH 10/13] block/vhdx: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:39 -0400
Message-ID: <20240722040742.11513-11-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-6.119200-10.000000
X-TMASE-MatchedRID: x/wzmLbLaAVrFdvBEmTnvE7nLUqYrlslFIuBIWrdOePfUZT83lbkEKRV
 r7nyVRs2TuaHtZS0liiAMuqetGVetsgO3bswsOnS3QfwsVk0UbuGrPnef/I+ersPurXJ/Jd+c9f
 FCs3N06jHTBjQFZuitxfyaog4dF1iwXweWJLhLSPy8FPuj0a6XdcJHibXPW41cND6xqjxBBo6Vi
 EPIPnfcw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.49; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

use range_overlaps_range() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 block/vhdx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a1350626..c31661b946b6 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -32,6 +32,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qemu/range.h"
 
 /* Options for VHDX creation */
 
@@ -231,15 +232,16 @@ void vhdx_guid_generate(MSGUID *guid)
 static int vhdx_region_check(BDRVVHDXState *s, uint64_t start, uint64_t length)
 {
     int ret = 0;
-    uint64_t end;
     VHDXRegionEntry *r;
+    Range range1, range2;
 
-    end = start + length;
+    range_init_nofail(&range1, start, length);
     QLIST_FOREACH(r, &s->regions, entries) {
-        if (!((start >= r->end) || (end <= r->start))) {
+        range_init_nofail(&range2, r->start, r->end - r->start);
+        if (range_overlaps_range(&range1, &range2)) {
             error_report("VHDX region %" PRIu64 "-%" PRIu64 " overlaps with "
-                         "region %" PRIu64 "-%." PRIu64, start, end, r->start,
-                         r->end);
+                         "region %" PRIu64 "-%." PRIu64, start, start + length,
+                         r->start, r->end);
             ret = -EINVAL;
             goto exit;
         }
-- 
2.41.0


