Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253D172A9A4
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 09:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sY8-0002gy-JV; Sat, 10 Jun 2023 02:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY5-0002ej-DB; Sat, 10 Jun 2023 02:58:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY3-0005tv-Mc; Sat, 10 Jun 2023 02:58:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C26A4BE23;
 Sat, 10 Jun 2023 09:57:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 618AEB290;
 Sat, 10 Jun 2023 09:57:59 +0300 (MSK)
Received: (nullmailer pid 1107502 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 03/16] spelling: information
Date: Sat, 10 Jun 2023 09:57:41 +0300
Message-Id: <40b89515d026915a0593993712e322addac095b9.1686379708.git.mjt@tls.msk.ru>
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

3 trivial fixes: 2 .json comments which goes to
executables, and 1 .h file comment.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/ui/clipboard.h | 2 +-
 qapi/cryptodev.json    | 2 +-
 qga/qapi-schema.json   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index ce76aa451f..ab6acdbd8a 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -170,7 +170,7 @@ void qemu_clipboard_peer_release(QemuClipboardPeer *peer,
  *
  * @selection: clipboard selection.
  *
- * Return the current clipboard data & owner informations.
+ * Return the current clipboard data & owner information.
  */
 QemuClipboardInfo *qemu_clipboard_info(QemuClipboardSelection selection);
 
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index 77f48a9c21..68289f4984 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -75,7 +75,7 @@
 #
 # @service: supported service types of a crypto device
 #
-# @client: the additional infomation of the crypto device
+# @client: the additional information of the crypto device
 #
 # Since: 8.0
 ##
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 42fb046eb7..b720dd4379 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -931,7 +931,7 @@
 ##
 # @GuestNVMeSmart:
 #
-# NVMe smart informations, based on NVMe specification, section
+# NVMe smart information, based on NVMe specification, section
 # <SMART / Health Information (Log Identifier 02h)>
 #
 # Since: 7.1
-- 
2.39.2


