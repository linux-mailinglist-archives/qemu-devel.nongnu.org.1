Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7575399F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8Z-0000Ia-5f; Fri, 14 Jul 2023 07:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8X-0000IH-5M; Fri, 14 Jul 2023 07:39:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8V-0004AB-NN; Fri, 14 Jul 2023 07:39:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B04F713D92;
 Fri, 14 Jul 2023 14:38:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B25DC14BA1;
 Fri, 14 Jul 2023 14:38:39 +0300 (MSK)
Received: (nullmailer pid 1186213 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 06/29] tree-wide spelling fixes in comments and some
 messages: docs
Date: Fri, 14 Jul 2023 14:38:11 +0300
Message-Id: <20230714113834.1186117-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/about/deprecated.rst    | 2 +-
 docs/devel/qapi-code-gen.rst | 2 +-
 docs/devel/qom.rst           | 2 +-
 docs/system/devices/nvme.rst | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 02ea5a839f..7dc95dab7a 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -371,3 +371,3 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
-has indicated plans for such kind of reimplemention unfortunately.
+has indicated plans for such kind of reimplementation unfortunately.
 
diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 7f78183cd4..b0852da97b 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1369,3 +1369,3 @@ anymore, and return or event data member (enumeration) values that
 can't be sent anymore makes no difference to clients, except for
-introspection.  The latter can conceivably confuse clients, so tread
+introspection.  The latter can conceivably confuse clients, so treat
 carefully.
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0b506426d7..9918fac7f2 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -32,3 +32,3 @@ Creating a QOM class
 
-A simple minimal device implementation may look something like bellow:
+A simple minimal device implementation may look something like below:
 
diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index a8bb8d729c..2a3af268f7 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -234,3 +234,3 @@ parameters:
 ``fdp.nruh`` (default: ``0``)
-  Set the number of Reclaim Unit Handles. This is a mandatory paramater and
+  Set the number of Reclaim Unit Handles. This is a mandatory parameter and
   must be non-zero.
-- 
2.39.2


