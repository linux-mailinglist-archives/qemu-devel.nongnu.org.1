Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708557B8D9D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7pR-0004r6-El; Wed, 04 Oct 2023 15:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pP-0004qo-DB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pC-00059g-4q
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696448785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKJk7XVB2DViVMMKfF/Lt/CVsitRtP9avGJrQHTVjGQ=;
 b=CiTiROXTmhefPyXwTJcF+Z1Wu8w91UXCHH2ap0P+Khyu7K3MqoRcn4bRyCiU/qizi5fUJX
 XSg8u0nxPGwXpIMzqE52xZHBDp4Q31WvXJdd8G48emR2HPDPeO+9nlzc1e09OqMuyFgE8I
 4j7e2BgDAhxq55r8Xtm/ms+lRcAV/8k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-_yoS9iTfP7-Z29OlqBEk6A-1; Wed, 04 Oct 2023 15:46:22 -0400
X-MC-Unique: _yoS9iTfP7-Z29OlqBEk6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D5F12825E9A;
 Wed,  4 Oct 2023 19:46:21 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD4471054FC2;
 Wed,  4 Oct 2023 19:46:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/9] python/machine: use socketpair() for qtest connection
Date: Wed,  4 Oct 2023 15:46:10 -0400
Message-ID: <20231004194613.2900323-7-jsnow@redhat.com>
In-Reply-To: <20231004194613.2900323-1-jsnow@redhat.com>
References: <20231004194613.2900323-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Like the QMP and console sockets, begin using socketpairs for the qtest
connection, too. After this patch, we'll be able to remove the vestigial
sock_dir argument, but that cleanup is best done in its own patch.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230928044943.849073-6-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/qtest.py | 49 +++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
index 1c46138bd0c..8180d3ab017 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -24,6 +24,7 @@
     Optional,
     Sequence,
     TextIO,
+    Tuple,
 )
 
 from qemu.qmp import SocketAddrT
@@ -38,23 +39,41 @@ class QEMUQtestProtocol:
     :param address: QEMU address, can be either a unix socket path (string)
                     or a tuple in the form ( address, port ) for a TCP
                     connection
-    :param server: server mode, listens on the socket (bool)
+    :param sock: An existing socket can be provided as an alternative to
+                 an address. One of address or sock must be provided.
+    :param server: server mode, listens on the socket. Only meaningful
+                   in conjunction with an address and not an existing
+                   socket.
+
     :raise socket.error: on socket connection errors
 
     .. note::
        No connection is established by __init__(), this is done
        by the connect() or accept() methods.
     """
-    def __init__(self, address: SocketAddrT,
+    def __init__(self,
+                 address: Optional[SocketAddrT] = None,
+                 sock: Optional[socket.socket] = None,
                  server: bool = False):
+        if address is None and sock is None:
+            raise ValueError("Either 'address' or 'sock' must be specified")
+        if address is not None and sock is not None:
+            raise ValueError(
+                "Either 'address' or 'sock' must be specified, but not both")
+        if sock is not None and server:
+            raise ValueError("server=True is meaningless when passing socket")
+
         self._address = address
-        self._sock = self._get_sock()
+        self._sock = sock or self._get_sock()
         self._sockfile: Optional[TextIO] = None
+
         if server:
+            assert self._address is not None
             self._sock.bind(self._address)
             self._sock.listen(1)
 
     def _get_sock(self) -> socket.socket:
+        assert self._address is not None
         if isinstance(self._address, tuple):
             family = socket.AF_INET
         else:
@@ -67,7 +86,8 @@ def connect(self) -> None:
 
         @raise socket.error on socket connection errors
         """
-        self._sock.connect(self._address)
+        if self._address is not None:
+            self._sock.connect(self._address)
         self._sockfile = self._sock.makefile(mode='r')
 
     def accept(self) -> None:
@@ -127,29 +147,40 @@ def __init__(self,
                          base_temp_dir=base_temp_dir,
                          sock_dir=sock_dir, qmp_timer=qmp_timer)
         self._qtest: Optional[QEMUQtestProtocol] = None
-        self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
+        self._qtest_sock_pair: Optional[
+            Tuple[socket.socket, socket.socket]] = None
 
     @property
     def _base_args(self) -> List[str]:
         args = super()._base_args
+        assert self._qtest_sock_pair is not None
+        fd = self._qtest_sock_pair[0].fileno()
         args.extend([
-            '-qtest', f"unix:path={self._qtest_path}",
+            '-chardev', f"socket,id=qtest,fd={fd}",
+            '-qtest', 'chardev:qtest',
             '-accel', 'qtest'
         ])
         return args
 
     def _pre_launch(self) -> None:
+        self._qtest_sock_pair = socket.socketpair()
+        os.set_inheritable(self._qtest_sock_pair[0].fileno(), True)
         super()._pre_launch()
-        self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
+        self._qtest = QEMUQtestProtocol(sock=self._qtest_sock_pair[1])
 
     def _post_launch(self) -> None:
         assert self._qtest is not None
         super()._post_launch()
-        self._qtest.accept()
+        if self._qtest_sock_pair:
+            self._qtest_sock_pair[0].close()
+        self._qtest.connect()
 
     def _post_shutdown(self) -> None:
+        if self._qtest_sock_pair:
+            self._qtest_sock_pair[0].close()
+            self._qtest_sock_pair[1].close()
+            self._qtest_sock_pair = None
         super()._post_shutdown()
-        self._remove_if_exists(self._qtest_path)
 
     def qtest(self, cmd: str) -> str:
         """
-- 
2.41.0


