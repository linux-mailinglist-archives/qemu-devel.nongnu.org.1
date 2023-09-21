Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7907A92A5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:36:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFAm-0008Pg-6w; Thu, 21 Sep 2023 04:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjFAQ-0007K9-G9; Thu, 21 Sep 2023 04:36:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjFAN-0001Lm-Ut; Thu, 21 Sep 2023 04:36:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC3A123DB0;
 Thu, 21 Sep 2023 11:35:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 93A7E29A0A;
 Thu, 21 Sep 2023 11:35:14 +0300 (MSK)
Received: (nullmailer pid 509121 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 13/17] docs/cxl: Change to lowercase as others
Date: Thu, 21 Sep 2023 11:35:02 +0300
Message-Id: <20230921083506.509032-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Using the same style as elsewhere for topology / topo

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Link: https://lore.kernel.org/r/20230519085802.2106900-2-lizhijian@cn.fujitsu.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index f12011e230..b742120657 100644
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
+      |  PCI topology | | PCI topology| | PCI topo   | | PCI topo    |
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
2.39.2


