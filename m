Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419BE7176AE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4F0K-0004Ge-Fx; Wed, 31 May 2023 02:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4EzR-00049D-Ie
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:07:23 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4EzP-0005oz-HZ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:07:21 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="98299975"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; d="scan'208";a="98299975"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 15:07:16 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4D0ACF1C0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:07:13 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2CF6DCFADC
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:07:13 +0900 (JST)
Received: from cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A72AF2007CA89
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:07:12 +0900 (JST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (unknown [10.167.33.114])
 by cn.fujitsu.com (Postfix) with ESMTP id 55D804D6A37B;
 Wed, 31 May 2023 14:07:08 +0800 (CST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.209) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 14:07:08 +0800
Received: from localhost.localdomain (10.167.234.230) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 14:07:08 +0800
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <jonathan.cameron@huawei.com>, <fan.ni@samsung.com>
CC: <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Date: Wed, 31 May 2023 14:07:06 +0800
Message-ID: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 55D804D6A37B.AD91C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.005
X-TMASE-Result: 10--0.224800-10.000000
X-TMASE-MatchedRID: ZBUQelTRKbUqkDtMyFKcp7+a7Hw+x9qZBGvINcfHqhfAuQ0xDMaXkH4q
 tYI9sRE/L2EYbInFI5vqAmmrrRzbHxHdGMlurS25Fb9swyIOkeGOVGny5q72hkFZ5x7UXdoEo8W
 MkQWv6iVJeFvFlVDkf46HM5rqDwqt2WlyHtKvbFIeoQAgC++xmxNw6JXSd3kWcKy+fAoEidpKBX
 Yq7SZseDLhhWWxrJaWfXULAKdDzopNmTCIWMGIL5dKOFpo1Tpk9UElV5SMCCrLt16YWtxzeF9Np
 ZbddHv73iGQYUPZme7O51vq1xhTsg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137; envelope-from=lizhijian@fujitsu.com;
 helo=esa11.hc1455-7.c3s2.iphmx.com
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

Allocate targets and targets[n] resources when all sanity checks are
passed to avoid memory leaks.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
V3: allocte further resource when we can't fail # Philippe
V2: Delete unnecesarry check
---
 hw/cxl/cxl-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3e..f0920da956d 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -39,12 +39,6 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         return;
     }
 
-    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
-    for (i = 0, target = object->targets; target; i++, target = target->next) {
-        /* This link cannot be resolved yet, so stash the name for now */
-        fw->targets[i] = g_strdup(target->value);
-    }
-
     if (object->size % (256 * MiB)) {
         error_setg(errp,
                    "Size of a CXL fixed memory window must be a multiple of 256MiB");
@@ -64,6 +58,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->enc_int_gran = 0;
     }
 
+    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
+    for (i = 0, target = object->targets; target; i++, target = target->next) {
+        /* This link cannot be resolved yet, so stash the name for now */
+        fw->targets[i] = g_strdup(target->value);
+    }
+
     cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
                                              g_steal_pointer(&fw));
 
-- 
2.31.1




