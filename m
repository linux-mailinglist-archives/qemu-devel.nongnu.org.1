Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3937C8DA6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYM-0006zJ-A8; Fri, 13 Oct 2023 15:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNY5-0006fL-AI
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXv-0001g0-Ee
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxgTEoBavOn4bsrLaLlgOod3d59bBtFgJHbxexkR54s=;
 b=hoY8z9At8haalzFRVzPVfKJNL9agbgO73blf3OkD+rpk03XIdumI6keuO1X3k7r55oeGo/
 PDx0OYzwzGUY4WNajDkEYKs8wP2vkTrO+I2dCDeENxz+dGEU6DxTv49a2XLUfTiCMVYifz
 lFrQpHFRp2t99Au9NsS0eF1U4HG6KaQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-gMv1fUy1OkSI5r3m9cSsRQ-1; Fri, 13 Oct 2023 15:10:00 -0400
X-MC-Unique: gMv1fUy1OkSI5r3m9cSsRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 062A41029F41;
 Fri, 13 Oct 2023 19:09:59 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9B1640C6CA1;
 Fri, 13 Oct 2023 19:09:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 12/25] qmp_shell.py: _fill_completion() use .command() instead
 of .cmd()
Date: Fri, 13 Oct 2023 15:09:27 -0400
Message-ID: <20231013190941.3699288-13-jsnow@redhat.com>
In-Reply-To: <20231013190941.3699288-1-jsnow@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We just want to ignore failure, so we don't need low level .cmd(). This
helps further renaming .command() to .cmd().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-3-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
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
2.41.0


