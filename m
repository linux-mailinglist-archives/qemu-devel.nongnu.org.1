Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D87BCF6A3
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7a8b-0006Wi-0q; Sat, 11 Oct 2025 09:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7i-0006Hh-GK
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:05 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7a7U-0004kw-VS
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 09:59:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0E4EEC017E;
 Sat, 11 Oct 2025 16:58:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uvMPBZ1FEOs0-jI08XM7C; Sat, 11 Oct 2025 16:58:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191095;
 bh=/q6rjoxdfB/1Xm73ZxRH85WAZxNcGltDxx8lvKX3FXI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HOqN6UYW+8/hVC6CbhnTKueFh5WVx+dl4dHBWxlsEEuz9benNs+ssnCDWAEFg4QlQ
 AKjtFcSBxw3t8AlslM66cM2Ur8a4lH1cArAhPCJlFpD5b56Z6MFcHslzJb8ChFhhqt
 UTMrSu17vLMYdPN48wxCrWOgtywW0KQbzXZxNku0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 19/33] qapi/qdev.json: docs: width=70 and two spaces between
 sentences
Date: Sat, 11 Oct 2025 16:57:17 +0300
Message-ID: <20251011135754.294521-37-vsementsov@yandex-team.ru>
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
 qapi/qdev.json | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index e14a0c9259..9c4b498319 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -100,8 +100,8 @@
 #    process is signaled with a `DEVICE_DELETED` event.  Guest reset
 #    will automatically complete removal for all devices.  If a
 #    guest-side error in the hot removal process is detected, the
-#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR` event
-#    is sent.  Some errors cannot be detected.
+#    device will not be removed and a `DEVICE_UNPLUG_GUEST_ERROR`
+#    event is sent.  Some errors cannot be detected.
 #
 # Since: 0.14
 #
@@ -114,7 +114,8 @@
 # .. qmp-example::
 #
 #     -> { "execute": "device_del",
-#          "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
+#          "arguments": {
+#            "id": "/machine/peripheral-anon/device[0]" } }
 #     <- { "return": {} }
 ##
 { 'command': 'device_del', 'data': {'id': 'str'} }
@@ -138,7 +139,8 @@
 #     <- { "event": "DEVICE_DELETED",
 #          "data": { "device": "virtio-net-pci-0",
 #                    "path": "/machine/peripheral/virtio-net-pci-0" },
-#          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#          "timestamp": { "seconds": 1265044230,
+#                         "microseconds": 450486 } }
 ##
 { 'event': 'DEVICE_DELETED',
   'data': { '*device': 'str', 'path': 'str' } }
@@ -160,7 +162,8 @@
 #     <- { "event": "DEVICE_UNPLUG_GUEST_ERROR",
 #          "data": { "device": "core1",
 #                    "path": "/machine/peripheral/core1" },
-#          "timestamp": { "seconds": 1615570772, "microseconds": 202844 } }
+#          "timestamp": { "seconds": 1615570772,
+#                         "microseconds": 202844 } }
 ##
 { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
   'data': { '*device': 'str', 'path': 'str' } }
-- 
2.48.1


