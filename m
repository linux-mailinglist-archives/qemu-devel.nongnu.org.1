Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC3BCF610
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a89-0006OI-Be; Sat, 11 Oct 2025 09:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7h-0006HY-PL
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:05 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7R-0004kN-Lh
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:58:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 52700C017A;
 Sat, 11 Oct 2025 16:58:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-4yAO3J29; Sat, 11 Oct 2025 16:58:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191094;
 bh=9E/JVW0uw8uTCppIO66nEpAS+hp8/t959JvxxH++TCk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0PlzVlFDhb+uhkqDDbI825FM8hCPh07EH3qb4u4IWeyEpGDaZFyOoNB5cDU45VmLN
 uktzQcOqPBpHxvG9tX8zb4vANPURc8dtOUwJiCooSroAtdMYZtb5NDdWx6m45ufVYX
 WZBw29ebHhIcYQDdbQthIchtQHYb13DzqibpA9CQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Subject: [PATCH 17/33] qapi/misc.json: reflow docs to width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 16:57:14 +0300
Message-ID: <20251011135754.294521-34-vsementsov@yandex-team.ru>
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
 qapi/misc.json | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 28c641fe2f..456241bcfd 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -34,8 +34,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "add_client", "arguments": { "protocol": "vnc",
-#                                                  "fdname": "myclient" } }
+#     -> { "execute": "add_client",
+#          "arguments": { "protocol": "vnc", "fdname": "myclient" } }
 #     <- { "return": {} }
 ##
 { 'command': 'add_client',
@@ -288,7 +288,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "get-win32-socket",
-#          "arguments": { "info": "abcd123..", "fdname": "skclient" } }
+#          "arguments": { "info": "abcd123..",
+#                         "fdname": "skclient" } }
 #     <- { "return": {} }
 ##
 { 'command': 'get-win32-socket', 'data': {'info': 'str', 'fdname': 'str'}, 'if': 'CONFIG_WIN32' }
@@ -374,7 +375,8 @@
 #
 # .. qmp-example::
 #
-#     -> { "execute": "remove-fd", "arguments": { "fdset-id": 1, "fd": 3 } }
+#     -> { "execute": "remove-fd",
+#          "arguments": { "fdset-id": 1, "fd": 3 } }
 #     <- { "return": {} }
 ##
 { 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
@@ -564,7 +566,8 @@
 #
 #     <- { "event": "RTC_CHANGE",
 #          "data": { "offset": 78 },
-#          "timestamp": { "seconds": 1267020223, "microseconds": 435656 } }
+#          "timestamp": { "seconds": 1267020223,
+#                         "microseconds": 435656 } }
 ##
 { 'event': 'RTC_CHANGE',
   'data': { 'offset': 'int', 'qom-path': 'str' } }
@@ -594,7 +597,8 @@
 #                    "vfu-qom-path": "/objects/vfu1",
 #                    "dev-id": "sas1",
 #                    "dev-qom-path": "/machine/peripheral/sas1" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'VFU_CLIENT_HANGUP',
   'data': { 'vfu-id': 'str', 'vfu-qom-path': 'str',
-- 
2.48.1


