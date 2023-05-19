Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCCD70F1E0
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kX3-000171-Pa; Wed, 24 May 2023 05:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q1kX1-00016e-LJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:43 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q1kX0-0000dr-0v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:43 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="117781870"
X-IronPort-AV: E=Sophos;i="6.00,188,1681138800"; d="scan'208";a="117781870"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 18:11:37 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9524DCD6C2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D5F80D3F2D
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:33 +0900 (JST)
Received: from cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5B4802007CAA5
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:33 +0900 (JST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (unknown [10.167.33.114])
 by cn.fujitsu.com (Postfix) with ESMTP id 3FAC04D8AD59;
 Fri, 19 May 2023 16:57:19 +0800 (CST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 16:57:19 +0800
Received: from localhost.localdomain (10.167.226.45) by
 G08CNEXHBPEKD10.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 16:57:19 +0800
From: Li Zhijian <lizhijian@cn.fujitsu.com>
To: <Jonathan.Cameron@huawei.com>, <qemu-devel@nongnu.org>
CC: <ben.widawsky@intel.com>, <dan.j.williams@intel.com>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH 1/2] docs/cxl: Correct CFMW number
Date: Fri, 19 May 2023 16:58:01 +0800
Message-ID: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-yoursite-MailScanner-ID: 3FAC04D8AD59.A04CE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27646.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27646.006
X-TMASE-Result: 10-4.112000-10.000000
X-TMASE-MatchedRID: a/NQqtkq7zoK3XsS78iVZKJVTu7sjgg1wwUOMx+/uQNOaDdl7pggvQTg
 sjIJUJZIIvrftAIhWmLy9zcRSkKatfH/uuICyxMCLV6LoOnjWZms4IQYg+G3CNspzL3HlL8hU5z
 8XnT4Vkji8zVgXoAltvbGdFF9BGjiC24oEZ6SpSmcfuxsiY4QFFMJQmIMMhF0aJKVtBOvry2tjI
 XO5FYzSzon8SHqc6a/1Z2AA2kLsxIJM5kWfx01eUOexVgQs3hj9gycg79CNJGQJ517SGaXY9VGK
 sGTt2/S6yORifnpUaoNUYeVfcC2R3iZNoNUzKgUYDttQUGqHZU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.48; envelope-from=lizhijian@fujitsu.com;
 helo=esa2.hc1455-7.c3s2.iphmx.com
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

The 'Notes:' in this document mentioned CFMW{0-2}, but the figure missed
CFMW2.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
I'm totally new to CXL, so i have little confidence to this change :)
---
 docs/system/devices/cxl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index dce43476129..d3577a4d6da 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -162,7 +162,7 @@ Example system Topology. x marks the match in each decoder level::
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
   |   |          | |                                  | |          |   |
-  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
+  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
   |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
   |   |          | |  memory accesses across HB0/HB1  | |          |   |
   |   |__________| |_____x____________________________| |__________|   |
@@ -247,7 +247,7 @@ Example topology involving a switch::
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
   |   |          | |                                  | |          |   |
-  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
+  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
   |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
   |   |          | |  memory accesses across HB0/HB1  | |          |   |
   |   |____x_____| |__________________________________| |__________|   |
-- 
2.31.1




