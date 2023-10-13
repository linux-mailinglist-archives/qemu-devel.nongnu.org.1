Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52ED7C8DA7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYM-0006zB-5M; Fri, 13 Oct 2023 15:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYK-0006xc-Ft
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNY5-0001tR-4x
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJ7wl0Ii06+M3pV66TBNc0GtswGn7yjmI2vwYEHWBIg=;
 b=QDHs/YrWOBh+awiDlO5RA3v7rWpEQQF4cQj8pCJYleTL8bIs03FyY/ryB25PgSOdLomsnP
 mQi576SrN9RGp13fZmF2XjV2UqNfK7VMCa9DB7XyI9GJwaqUq7gF1KJeaRY1+pCAp0RsEf
 Jtx80kMAagYR/SJA+ntAxombN532uAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-FXReLPtdMmqGpbsaF9VE1A-1; Fri, 13 Oct 2023 15:10:02 -0400
X-MC-Unique: FXReLPtdMmqGpbsaF9VE1A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93CB28039C1;
 Fri, 13 Oct 2023 19:10:01 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6EB40C6CA0;
 Fri, 13 Oct 2023 19:10:00 +0000 (UTC)
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
Subject: [PULL 14/25] python: rename QEMUMonitorProtocol.cmd() to cmd_raw()
Date: Fri, 13 Oct 2023 15:09:29 -0400
Message-ID: <20231013190941.3699288-15-jsnow@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Having cmd() and command() methods in one class doesn't look good.
Rename cmd() to cmd_raw(), to show its meaning better.

We also want to rename command() to cmd() in future, so this commit is
a necessary step.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-5-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py | 2 +-
 python/qemu/qmp/legacy.py      | 4 ++--
 tests/qemu-iotests/iotests.py  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index d539e91268..50bba33729 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -702,7 +702,7 @@ def qmp(self, cmd: str,
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
index 145c682713..0c061d8986 100644
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
2.41.0


