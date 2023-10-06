Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5B7BBBF5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomxd-0006Ug-EF; Fri, 06 Oct 2023 11:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxb-0006UB-Sk; Fri, 06 Oct 2023 11:41:51 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxY-0003W6-W4; Fri, 06 Oct 2023 11:41:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 2389F5E910;
 Fri,  6 Oct 2023 18:41:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-emhXSxcY; Fri, 06 Oct 2023 18:41:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606903;
 bh=wTcyjx92aXx2sVGdLGZxJJJod8uOvmF/D/xvuHmRDF0=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=f++/vqsvqZat4l9E5JILC6JX150dHweAoiBwcz0ki12HqL6qovGoYXwPU3dbpnJ82
 5y/+pMXjnIEcTShhksHFgkmPg0GEbtXjkOet8t36JUtK2ygWrbD37Z00heo0UHFwZf
 PIMvS4RIKekcMDFh14jTOx+xmkCzvL+r2taSeleo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v7 02/15] qmp_shell.py: _fill_completion() use .command()
 instead of .cmd()
Date: Fri,  6 Oct 2023 18:41:12 +0300
Message-Id: <20231006154125.1068348-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We just want to ignore failure, so we don't need low level .cmd(). This
helps further renaming .command() to .cmd().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 python/qemu/qmp/qmp_shell.py | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index 619ab42ced..988d79c01b 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -91,14 +91,21 @@
 import sys
 from typing import (
     IO,
+    Dict,
     Iterator,
     List,
     NoReturn,
     Optional,
     Sequence,
+    cast,
 )
 
-from qemu.qmp import ConnectError, QMPError, SocketAddrT
+from qemu.qmp import (
+    ConnectError,
+    ExecuteError,
+    QMPError,
+    SocketAddrT,
+)
 from qemu.qmp.legacy import (
     QEMUMonitorProtocol,
     QMPBadPortError,
@@ -194,11 +201,12 @@ def close(self) -> None:
         super().close()
 
     def _fill_completion(self) -> None:
-        cmds = self.cmd('query-commands')
-        if 'error' in cmds:
-            return
-        for cmd in cmds['return']:
-            self._completer.append(cmd['name'])
+        try:
+            cmds = cast(List[Dict[str, str]], self.command('query-commands'))
+            for cmd in cmds:
+                self._completer.append(cmd['name'])
+        except ExecuteError:
+            pass
 
     def _completer_setup(self) -> None:
         self._completer = QMPCompleter()
-- 
2.34.1


