Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976DBCF62B
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aAG-0000Er-Vo; Sat, 11 Oct 2025 10:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a8K-0006SO-MF; Sat, 11 Oct 2025 09:59:41 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7t-0004nM-MK; Sat, 11 Oct 2025 09:59:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2562DC0197;
 Sat, 11 Oct 2025 16:58:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-ZPCPUo2i; Sat, 11 Oct 2025 16:58:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191104;
 bh=EjDlYN/YV/1Al0fTsGpd9EuPX946XXrIIrx4bLAmmms=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DZQXMLtVt17T+XS9uw2e109/Ws0b3M09ZkbeHU3qv9wwimy0iUDEh+d5hhdffWBTC
 dtFhuRDQ/OQsWW+OM5agyW9aUsRE659AEpum+2KRo+swEHjLLw3Eq+1KZlazHwVUzX
 /t1z7m9Wy/9iRGJ/l8Y3kA5p3MNMwjYk5CK0cR98=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 28/33] qapi/transaction.json: reflow docs to width=70 and two
 spaces between sentences
Date: Sat, 11 Oct 2025 16:57:36 +0300
Message-ID: <20251011135754.294521-56-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011135754.294521-1-vsementsov@yandex-team.ru>
References: <20251011135754.294521-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 qapi/transaction.json | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/qapi/transaction.json b/qapi/transaction.json
index 4b4eb09bf3..f43da7f30d 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -250,21 +250,24 @@
 #
 #     -> { "execute": "transaction",
 #          "arguments": { "actions": [
-#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd0",
-#                                          "snapshot-file": "/some/place/my-image",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-sync", "data" : { "node-name": "myfile",
-#                                          "snapshot-file": "/some/place/my-image2",
-#                                          "snapshot-node-name": "node3432",
-#                                          "mode": "existing",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-sync", "data" : { "device": "ide-hd1",
-#                                          "snapshot-file": "/some/place/my-image2",
-#                                          "mode": "existing",
-#                                          "format": "qcow2" } },
-#              { "type": "blockdev-snapshot-internal-sync", "data" : {
-#                                          "device": "ide-hd2",
-#                                          "name": "snapshot0" } } ] } }
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "device": "ide-hd0",
+#                            "snapshot-file": "/some/place/my-image",
+#                            "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "node-name": "myfile",
+#                           "snapshot-file": "/some/place/my-image2",
+#                           "snapshot-node-name": "node3432",
+#                           "mode": "existing",
+#                           "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-sync",
+#                "data" : { "device": "ide-hd1",
+#                           "snapshot-file": "/some/place/my-image2",
+#                           "mode": "existing",
+#                           "format": "qcow2" } },
+#              { "type": "blockdev-snapshot-internal-sync",
+#                "data" : { "device": "ide-hd2",
+#                           "name": "snapshot0" } } ] } }
 #     <- { "return": {} }
 ##
 { 'command': 'transaction',
-- 
2.48.1


