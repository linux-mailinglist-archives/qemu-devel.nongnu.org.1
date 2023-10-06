Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B8C7BBBF3
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomxm-0006a4-H6; Fri, 06 Oct 2023 11:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxk-0006Zg-87; Fri, 06 Oct 2023 11:42:00 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxh-0003a0-Dx; Fri, 06 Oct 2023 11:41:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 4E432612D6;
 Fri,  6 Oct 2023 18:41:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-ekm6zP1O; Fri, 06 Oct 2023 18:41:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606914;
 bh=vriEVmnV7bxdNkfzgFbXT3kUTaRfJytH+aS0ELJMAdY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QGVyZ7V2hax5NWPwMtAXeL7BZ/wpQnMUK9yiwocd28m5rDBTVDWoPRwoHlSpgaSL0
 oLnyFnaIXCsA3LCTSP0ylJD8Nxu/3amWOk16UiNos5UZVb3LHCdxjWgx7hK/O7opar
 4+6YeNtdFq+d3a1QCwCFTlzgjk+OZcdil7m7f+mw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Subject: [PATCH v7 07/15] iotests: QemuStorageDaemon: add cmd() method like in
 QEMUMachine.
Date: Fri,  6 Oct 2023 18:41:17 +0300
Message-Id: <20231006154125.1068348-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add similar method for consistency.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8ffd9fb660..6cc50f0b50 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -38,7 +38,7 @@
 from contextlib import contextmanager
 
 from qemu.machine import qtest
-from qemu.qmp.legacy import QMPMessage, QEMUMonitorProtocol
+from qemu.qmp.legacy import QMPMessage, QMPReturnValue, QEMUMonitorProtocol
 from qemu.utils import VerboseProcessError
 
 # Use this logger for logging messages directly from the iotests module
@@ -466,6 +466,11 @@ def get_qmp(self) -> QEMUMonitorProtocol:
         assert self._qmp is not None
         return self._qmp
 
+    def cmd(self, cmd: str, args: Optional[Dict[str, object]] = None) \
+            -> QMPReturnValue:
+        assert self._qmp is not None
+        return self._qmp.cmd(cmd, **(args or {}))
+
     def stop(self, kill_signal=15):
         self._p.send_signal(kill_signal)
         self._p.wait()
-- 
2.34.1


