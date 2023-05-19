Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066D770F1E1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kX5-00018o-Oc; Wed, 24 May 2023 05:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q1kX3-00018F-Ny
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:45 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com ([207.54.90.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q1kX2-0000dr-5n
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:11:45 -0400
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="117781871"
X-IronPort-AV: E=Sophos;i="6.00,188,1681138800"; d="scan'208";a="117781871"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2023 18:11:37 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id CA5DBCD7E1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 0ABC31582D
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:34 +0900 (JST)
Received: from cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 538CC6CB3C
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 18:11:33 +0900 (JST)
Received: from G08CNEXHBPEKD10.g08.fujitsu.local (unknown [10.167.33.114])
 by cn.fujitsu.com (Postfix) with ESMTP id A7ECB4D8CABA;
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
Subject: [PATCH 2/2] docs/clx: Change to lowercase as others
Date: Fri, 19 May 2023 16:58:02 +0800
Message-ID: <20230519085802.2106900-2-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
References: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-yoursite-MailScanner-ID: A7ECB4D8CABA.A49C1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27646.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27646.005
X-TMASE-Result: 10--2.797300-10.000000
X-TMASE-MatchedRID: H76PVFvSJl4xhcKMC/TCz836paW7ZnFowTlc9CcHMZerwqxtE531VICu
 qghmtWfXFCHhi2BgUo7jTi7tnrhclZ4727V5seKPboT9s9dVCZrM1/5oKB8u2psoi2XrUn/Jn6K
 dMrRsL14qtq5d3cxkNahCE/Dxslu+hWF4CHR7+BQgt48YwZpyKCRQfozVHiV6KnQDLadWR9NlN+
 gj35/8f9wk+zyU1Od9I0EDdr7SnlD2f41qzUd1+xJYk/e1wi1SU/JCITmuhS7oZbNFHtbIdPl43
 iPWIJMPxwTT797Vag8=
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

Using the same style except the 'Topo' abbreviation.

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
I'm not a native speaker, feel free to correct me.
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index d3577a4d6da..56414d25871 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -157,7 +157,7 @@ responsible for allocating appropriate ranges from within the CFMWs
 and exposing those via normal memory configurations as would be done
 for system RAM.
 
-Example system Topology. x marks the match in each decoder level::
+Example system topology. x marks the match in each decoder level::
 
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
@@ -187,8 +187,8 @@ Example system Topology. x marks the match in each decoder level::
        ___________|___   __________|__   __|_________   ___|_________
    (3)|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
       |  Appears in   | | Appears in  | | Appears in | | Appear in   |
-      |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
-      |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
+      |  PCI topology | | PCI topology| | PCI Topo   | | PCI Topo    |
+      |  as 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
       |_______________| |_____________| |____________| |_____________|
             |                  |               |              |
             |                  |               |              |
@@ -272,7 +272,7 @@ Example topology involving a switch::
       |  Root Port 0  |
       |  Appears in   |
       |  PCI topology |
-      |  As 0c:00.0   |
+      |  as 0c:00.0   |
       |___________x___|
                   |
                   |
-- 
2.31.1




