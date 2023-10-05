Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9997B9DE7
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:57:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOqA-0000AJ-Vv; Thu, 05 Oct 2023 09:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpv-0008WN-U3; Thu, 05 Oct 2023 09:56:20 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpo-0001wZ-Bt; Thu, 05 Oct 2023 09:56:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8C53761199;
 Thu,  5 Oct 2023 16:56:09 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qtYmoW4Oi4Y0-qQsAwHAs; Thu, 05 Oct 2023 16:56:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696514168;
 bh=f9XlzrFQee7Z3f0e7OySwpMTh7Xh4VyJA74uMaRrsWc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TR8lfP//mMke/sbLvUNe3A+T67A6nODY6KZEmBFPRpcam3qFG1pQLpgYJZotA0sBW
 +IF2qgXyny8Ka6nRHEqYZjEYTZapdv3wMx4TrXLeUM9yaubxwwh42l3qBi4KAl7TrU
 bP+dpBPvzFSVIHeefrbYKXVsL4eNek2NzYJDrqNQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v6 04/14] python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
Date: Thu,  5 Oct 2023 16:55:40 +0300
Message-Id: <20231005135550.331657-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005135550.331657-1-vsementsov@yandex-team.ru>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Having cmd() and command() methods in one class doesn't look good.
Rename cmd() to cmd_raw(), to show its meaning better.

We also want to rename command() to cmd() in future, so this commit is
a necessary step.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 python/qemu/machine/machine.py | 2 +-
 python/qemu/qmp/legacy.py      | 4 ++--
 tests/qemu-iotests/iotests.py  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 35d5a672db..dd1a79cb37 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -692,7 +692,7 @@ def qmp(self, cmd: str,
             conv_keys = True
 
         qmp_args = self._qmp_args(conv_keys, args)
-        ret = self._qmp.cmd(cmd, args=qmp_args)
+        ret = self._qmp.cmd_raw(cmd, args=qmp_args)
         if cmd == 'quit' and 'error' not in ret and 'return' in ret:
             self._quit_issued = True
         return ret
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index fe115e301c..e5fa1ce9c4 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -194,8 +194,8 @@ def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
             )
         )
 
-    def cmd(self, name: str,
-            args: Optional[Dict[str, object]] = None) -> QMPMessage:
+    def cmd_raw(self, name: str,
+                args: Optional[Dict[str, object]] = None) -> QMPMessage:
         """
         Build a QMP command and send it to the QMP Monitor.
 
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ef66fbd62b..8ffd9fb660 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -460,7 +460,7 @@ def __init__(self, *args: str, instance_id: str = 'a', qmp: bool = False):
     def qmp(self, cmd: str, args: Optional[Dict[str, object]] = None) \
             -> QMPMessage:
         assert self._qmp is not None
-        return self._qmp.cmd(cmd, args)
+        return self._qmp.cmd_raw(cmd, args)
 
     def get_qmp(self) -> QEMUMonitorProtocol:
         assert self._qmp is not None
-- 
2.34.1


