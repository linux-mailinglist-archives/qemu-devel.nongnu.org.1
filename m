Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF78BCF66A
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aEJ-0005Y2-9m; Sat, 11 Oct 2025 10:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aEG-0005Te-9P; Sat, 11 Oct 2025 10:05:48 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aE5-0005dJ-9O; Sat, 11 Oct 2025 10:05:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4E2EFC01A8;
 Sat, 11 Oct 2025 17:04:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-KS88SNBf; Sat, 11 Oct 2025 17:04:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191498;
 bh=EjDlYN/YV/1Al0fTsGpd9EuPX946XXrIIrx4bLAmmms=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TGHv7LO2T2stLzxJDezipniDaqfGqBaUP6g1ny9aoUSWiA5R1CQyN0PizWQv6zOVB
 BgF4UDLfKJDjMnQ8IM6y3Wfz86HxWvuwe5/M2grOD1zCEzLtYQj5pwy3FUCOjSlOtR
 HSiD4bZBhqAlgHDU3Xt4+mJL+dB8zbRmu0z9lwmU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 28/33] qapi/transaction.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:34 +0300
Message-ID: <20251011140441.297246-29-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru>
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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


