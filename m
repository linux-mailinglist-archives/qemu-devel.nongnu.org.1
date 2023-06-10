Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93D72A9A8
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 09:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sY8-0002ex-30; Sat, 10 Jun 2023 02:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY1-0002bj-Tn; Sat, 10 Jun 2023 02:58:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY0-0005tU-6K; Sat, 10 Jun 2023 02:58:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 75F0DBE21;
 Sat, 10 Jun 2023 09:57:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EFD39B28E;
 Sat, 10 Jun 2023 09:57:58 +0300 (MSK)
Received: (nullmailer pid 1107496 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Milan Zamazal <mzamazal@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/16] docs: Fix trivial typos in vhost-user.rst
Date: Sat, 10 Jun 2023 09:57:39 +0300
Message-Id: <9c36407a4445de1f3e69d7a7a30e86dbb75a94e6.1686379708.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686379708.git.mjt@tls.msk.ru>
References: <cover.1686379708.git.mjt@tls.msk.ru>
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

From: Milan Zamazal <mzamazal@redhat.com>

Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/system/devices/vhost-user.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
index 86128114fa..a80e95a48a 100644
--- a/docs/system/devices/vhost-user.rst
+++ b/docs/system/devices/vhost-user.rst
@@ -38,13 +38,13 @@ system memory as defined by the ``-m`` argument.
 Example
 =======
 
-First start you daemon.
+First start your daemon.
 
 .. parsed-literal::
 
   $ virtio-foo --socket-path=/var/run/foo.sock $OTHER_ARGS
 
-The you start your QEMU instance specifying the device, chardev and
+Then you start your QEMU instance specifying the device, chardev and
 memory objects.
 
 .. parsed-literal::
-- 
2.39.2


