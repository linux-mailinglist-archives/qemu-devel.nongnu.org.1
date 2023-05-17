Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9A9706E3C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK6S-0004Ba-W4; Wed, 17 May 2023 12:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6R-0004Ap-34
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6P-0005zE-Jc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3G6SEwUqL/VqKHEG8+ZvTfBprd0ImLbUb63chGTd/Fg=;
 b=em+dvdnWpnymq9qb451kUrkh8vhgNIqVd2o1WbRrX+eUUs5cidYTIYN9NXLWTFSf5Dl1y8
 Sa03YT2qVL1XwkNM5qXQ9A8CY97blRcxS2brFLsAcZ5lVSEtEiZp9DBf6UoVmTYry/RRM6
 lVvK9/wYxSI5w5f+Txcy+7xcjujfpLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-_oiPjXriNTSotOBikZj2Gg-1; Wed, 17 May 2023 12:34:09 -0400
X-MC-Unique: _oiPjXriNTSotOBikZj2Gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF61101A555;
 Wed, 17 May 2023 16:34:08 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 922502166B31;
 Wed, 17 May 2023 16:34:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/5] python/qmp/legacy: remove open_with_socket() calls
Date: Wed, 17 May 2023 12:34:05 -0400
Message-Id: <20230517163406.2593480-5-jsnow@redhat.com>
In-Reply-To: <20230517163406.2593480-1-jsnow@redhat.com>
References: <20230517163406.2593480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Favor using connect() when passing a socket instead of
open_with_socket(). Simultaneously, update constructor calls to use the
combined address argument for QEMUMonitorProtocol().

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py |  7 ++++---
 python/qemu/qmp/legacy.py      | 29 ++++++++++++-----------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index cc636cb6bd..c16a0b6fed 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -337,16 +337,17 @@ def _pre_launch(self) -> None:
             self._remove_files.append(self._console_address)
 
         if self._qmp_set:
-            sock = None
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
                 sock = self._sock_pair[1]
             if isinstance(self._monitor_address, str):
                 self._remove_files.append(self._monitor_address)
 
+            sock_or_addr = self._monitor_address or sock
+            assert sock_or_addr is not None
+
             self._qmp_connection = QEMUMonitorProtocol(
-                address=self._monitor_address,
-                sock=sock,
+                sock_or_addr,
                 server=bool(self._monitor_address),
                 nickname=self._name
             )
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index b1eb3f360f..e1e9383978 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -68,34 +68,31 @@ class QEMUMonitorProtocol:
     Provide an API to connect to QEMU via QEMU Monitor Protocol (QMP)
     and then allow to handle commands and events.
 
-    :param address:  QEMU address, can be either a unix socket path (string)
-                     or a tuple in the form ( address, port ) for a TCP
-                     connection or None
-    :param sock:     a socket or None
+    :param address:  QEMU address, can be a unix socket path (string), a tuple
+                     in the form ( address, port ) for a TCP connection, or an
+                     existing `socket.socket` object.
     :param server:   Act as the socket server. (See 'accept')
+                     Not applicable when passing a socket directly.
     :param nickname: Optional nickname used for logging.
     """
 
     def __init__(self,
-                 address: Optional[SocketAddrT] = None,
-                 sock: Optional[socket.socket] = None,
+                 address: Union[SocketAddrT, socket.socket],
                  server: bool = False,
                  nickname: Optional[str] = None):
 
-        assert address or sock
+        if server and isinstance(address, socket.socket):
+            raise ValueError(
+                "server argument should be False when passing a socket")
+
         self._qmp = QMPClient(nickname)
         self._aloop = asyncio.get_event_loop()
         self._address = address
-        self._sock = sock
         self._timeout: Optional[float] = None
 
         if server:
-            if sock:
-                assert self._sock is not None
-                self._sync(self._qmp.open_with_socket(self._sock))
-            else:
-                assert self._address is not None
-                self._sync(self._qmp.start_server(self._address))
+            assert not isinstance(self._address, socket.socket)
+            self._sync(self._qmp.start_server(self._address))
 
     _T = TypeVar('_T')
 
@@ -150,13 +147,11 @@ def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
         :return: QMP greeting dict, or None if negotiate is false
         :raise ConnectError: on connection errors
         """
-        addr_or_sock = self._address or self._sock
-        assert addr_or_sock is not None
         self._qmp.await_greeting = negotiate
         self._qmp.negotiate = negotiate
 
         self._sync(
-            self._qmp.connect(addr_or_sock)
+            self._qmp.connect(self._address)
         )
         return self._get_greeting()
 
-- 
2.40.0


