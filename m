Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41FCBCF652
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aEB-0005GG-Kb; Sat, 11 Oct 2025 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDe-0004Sz-An; Sat, 11 Oct 2025 10:05:11 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDS-0005Oj-6T; Sat, 11 Oct 2025 10:05:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 81B3EC0189;
 Sat, 11 Oct 2025 17:04:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-ZZNULLvi; Sat, 11 Oct 2025 17:04:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191487;
 bh=XaNPKEYFvprDxxt9TryZMmnN05KO5P9DtdGM+QisyJ4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xDKVWieEoj3P1ad2p35REN0iW+acWJNw4dzqAcRgaZg89ZsLvMPOncxfAEsRGrHRD
 uiBTtQCi+ynFjxeZsuozXBkOflzk+ZZcOjKwSSnEN+GPchIY8dUo/EMA71+IrgF+dL
 D0ATCzSz5lTs+6SXtn6rDC2syd+5pnGzAGDxNMSM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v2 06/33] qapi/block.json: docs: width=70 and two spaces
 between sentences
Date: Sat, 11 Oct 2025 17:04:12 +0300
Message-ID: <20251011140441.297246-7-vsementsov@yandex-team.ru>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 qapi/block.json | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e..4398c801ee 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -240,7 +240,8 @@
 #          "arguments": { "id": "ide0-1-0" } }
 #
 #     <- { "error": { "class": "GenericError",
-#                     "desc": "Tray of device 'ide0-1-0' is not open" } }
+#                     "desc": "Tray of device 'ide0-1-0' is not open"
+#     } }
 #
 #     -> { "execute": "blockdev-open-tray",
 #          "arguments": { "id": "ide0-1-0" } }
@@ -350,7 +351,8 @@
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "ide0-1-0",
-#                         "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
+#                         "filename":
+#                           "/srv/images/Fedora-12-x86_64-DVD.iso",
 #                         "format": "raw" } }
 #     <- { "return": {} }
 #
@@ -359,17 +361,17 @@
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
-#                         "filename": "/srv/images/ro.img",
+#                         "filename": "ro.img",
 #                         "format": "raw",
 #                         "read-only-mode": "retain" } }
 #
 #     <- { "error":
 #          { "class": "GenericError",
-#            "desc": "Could not open '/srv/images/ro.img': Permission denied" } }
+#            "desc": "Could not open 'ro.img': Permission denied" } }
 #
 #     -> { "execute": "blockdev-change-medium",
 #          "arguments": { "id": "floppyA",
-#                         "filename": "/srv/images/ro.img",
+#                         "filename": "ro.img",
 #                         "format": "raw",
 #                         "read-only-mode": "read-only" } }
 #
@@ -407,7 +409,8 @@
 #                    "id": "/machine/unattached/device[22]",
 #                    "tray-open": true
 #          },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_TRAY_MOVED',
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
@@ -430,7 +433,8 @@
 #          "data": { "id": "pr-helper0",
 #                    "connected": true
 #          },
-#          "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1519840375,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
-- 
2.48.1


