Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9407145D0
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 09:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3XmH-0006C0-2l; Mon, 29 May 2023 03:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q3Xm9-00069y-Cp
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:58:46 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q3Xm6-0007px-Sv
 for qemu-devel@nongnu.org; Mon, 29 May 2023 03:58:45 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="106360418"
X-IronPort-AV: E=Sophos;i="6.00,200,1681138800"; d="scan'208";a="106360418"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 16:58:38 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E7F4D29E6
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 16:58:36 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D5350BF3FC
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 16:58:35 +0900 (JST)
Received: from cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6C71840FC5
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 16:58:35 +0900 (JST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (unknown [10.167.33.114])
 by cn.fujitsu.com (Postfix) with ESMTP id 8E16F4D6A36E;
 Mon, 29 May 2023 15:58:29 +0800 (CST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 15:58:29 +0800
Received: from localhost.localdomain (10.167.234.230) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.1.2507.23 via Frontend Transport; Mon, 29 May 2023 15:58:29 +0800
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <jonathan.cameron@huawei.com>, <fan.ni@samsung.com>
CC: <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] hw/clx: Fix CFMW config memory leak
Date: Mon, 29 May 2023 15:59:56 +0800
Message-ID: <20230529075956.2235870-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-yoursite-MailScanner-ID: 8E16F4D6A36E.AFDBC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27658.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27658.005
X-TMASE-Result: 10--0.927900-10.000000
X-TMASE-MatchedRID: pKBGOCB50KMFdjShemonXhF4zyLyne+ATJDl9FKHbrktorPLNYrwZMd4
 2TTaKPtTvSDAR06P0XC8+0aV2iA4JqdtnATHT3tNoHDoEp2TszGd2Wz0X3OaLZsoi2XrUn/J8m+
 hzBStantdY+ZoWiLImydET58jp62SDiYVKtpudAHgHzoGBSqzP++6+AXiHMTVr6vbi+l/a2VKE5
 gEuapvApc2lgo9FoFXpzKhbumbF2a4QEZfjSR28pmrkQT8gOYdil5sxKTVSYqWZc+DJChxinkTU
 bacU3J4RMF/R2LIqGTsMhWBS7uYKg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.36.225;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Only 'fw' pointer is marked as g_autofree, so we shoud free other
resource manually in error path.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/cxl/cxl-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3e..dd1a7c83f71 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -48,7 +48,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
     if (object->size % (256 * MiB)) {
         error_setg(errp,
                    "Size of a CXL fixed memory window must be a multiple of 256MiB");
-        return;
+        goto err_free;
     }
     fw->size = object->size;
 
@@ -57,7 +57,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
             cxl_interleave_granularity_enc(object->interleave_granularity,
                                            errp);
         if (*errp) {
-            return;
+            goto err_free;
         }
     } else {
         /* Default to 256 byte interleave */
@@ -68,6 +68,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
                                              g_steal_pointer(&fw));
 
     return;
+
+err_free:
+    for (i = 0; i < fw->num_targets && fw->targets[i]; i++) {
+        g_free(fw->targets[i]);
+    }
+    g_free(fw->targets);
 }
 
 void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
-- 
2.31.1




