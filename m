Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13726B41431
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 07:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfnE-0006Mj-8g; Wed, 03 Sep 2025 01:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmi-0006F4-Sx
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmg-0006Sm-Bj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6gKCmGtM4v/7K8Q4fJ0OL1dh2KHpJ2JMgXdjAgZP6A=;
 b=eKWmAJRsb5qYNieoudutsu1xmPh6ot6pdOVH2wHNRwViRv8TQI6/dZGhWYjNKf/jJ6f6hf
 pkoNNKWGQGzhLzTfQalOAE6gyZLrkHZiv+ZAKdCIborkLhGyQDqGk7Bb6lJqL6QF8kNALC
 ngSHtJ8Rj6PqQJWDkicxcj1TK6TXcgE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-4l8Up2UgNdq7gvCTHaWssg-1; Wed,
 03 Sep 2025 01:11:46 -0400
X-MC-Unique: 4l8Up2UgNdq7gvCTHaWssg-1
X-Mimecast-MFC-AGG-ID: 4l8Up2UgNdq7gvCTHaWssg_1756876306
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9200919560B4; Wed,  3 Sep 2025 05:11:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 275EF19560B1; Wed,  3 Sep 2025 05:11:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Adam Dorsey <adam.dorsey@twosixtech.com>,
 Adam Dorsey <adam@dorseys.email>
Subject: [PATCH v2 07/18] python: backport 'feat: allow setting read buffer
 limit'
Date: Wed,  3 Sep 2025 01:11:13 -0400
Message-ID: <20250903051125.3020805-8-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Adam Dorsey <adam.dorsey@twosixtech.com>

Expose the limit parameter of the underlying StreamReader and StreamWriter
instances.

This is helpful for the use case of transferring files in and out of a VM
via the QEMU guest agent's guest-file-open, guest-file-read, guest-file-write,
and guest-file-close methods, as it allows pushing the buffer size up to the
guest agent's limit of 48MB per transfer.

Signed-off-by: Adam Dorsey <adam@dorseys.email>
cherry picked from commit 9ba6a698344eb3b570fa4864e906c54042824cd6
cherry picked from commit e4d0d3f835d82283ee0e48438d1b154e18303491
[Squashed in linter fixups. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/protocol.py   | 25 ++++++++++++++++---------
 python/qemu/qmp/qmp_client.py | 18 ++++++++++++++----
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 958aeca08ac..3d5eb553aad 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -53,6 +53,9 @@
 UnixAddrT = str
 SocketAddrT = Union[UnixAddrT, InternetAddrT]
 
+# Maximum allowable size of read buffer, default
+_DEFAULT_READBUFLEN = 64 * 1024
+
 
 class Runstate(Enum):
     """Protocol session runstate."""
@@ -202,22 +205,26 @@ class AsyncProtocol(Generic[T]):
         will log to 'qemu.qmp.protocol', but each individual connection
         can be given its own logger by giving it a name; messages will
         then log to 'qemu.qmp.protocol.${name}'.
+    :param readbuflen:
+        The maximum read buffer length of the underlying StreamReader
+        instance.
     """
     # pylint: disable=too-many-instance-attributes
 
     #: Logger object for debugging messages from this connection.
     logger = logging.getLogger(__name__)
 
-    # Maximum allowable size of read buffer
-    _limit = 64 * 1024
-
     # -------------------------
     # Section: Public interface
     # -------------------------
 
-    def __init__(self, name: Optional[str] = None) -> None:
+    def __init__(
+        self, name: Optional[str] = None,
+        readbuflen: int = _DEFAULT_READBUFLEN
+    ) -> None:
         self._name: Optional[str]
         self.name = name
+        self.readbuflen = readbuflen
 
         # stream I/O
         self._reader: Optional[StreamReader] = None
@@ -574,7 +581,7 @@ async def _do_start_server(self, address: SocketAddrT,
                 port=address[1],
                 ssl=ssl,
                 backlog=1,
-                limit=self._limit,
+                limit=self.readbuflen,
             )
         else:
             coro = asyncio.start_unix_server(
@@ -582,7 +589,7 @@ async def _do_start_server(self, address: SocketAddrT,
                 path=address,
                 ssl=ssl,
                 backlog=1,
-                limit=self._limit,
+                limit=self.readbuflen,
             )
 
         # Allow runstate watchers to witness 'CONNECTING' state; some
@@ -637,7 +644,7 @@ async def _do_connect(self, address: Union[SocketAddrT, socket.socket],
                               "fd=%d, family=%r, type=%r",
                               address.fileno(), address.family, address.type)
             connect = asyncio.open_connection(
-                limit=self._limit,
+                limit=self.readbuflen,
                 ssl=ssl,
                 sock=address,
             )
@@ -647,14 +654,14 @@ async def _do_connect(self, address: Union[SocketAddrT, socket.socket],
                 address[0],
                 address[1],
                 ssl=ssl,
-                limit=self._limit,
+                limit=self.readbuflen,
             )
         else:
             self.logger.debug("Connecting to file://%s ...", address)
             connect = asyncio.open_unix_connection(
                 path=address,
                 ssl=ssl,
-                limit=self._limit,
+                limit=self.readbuflen,
             )
 
         self._reader, self._writer = await connect
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index a87fb565ab5..d826331b6d5 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -170,6 +170,12 @@ class QMPClient(AsyncProtocol[Message], Events):
 
     :param name: Optional nickname for the connection, used for logging.
 
+    :param readbuflen:
+        The maximum buffer length for reads and writes to and from the QMP
+        server, in bytes. Default is 10MB. If `QMPClient` is used to
+        connect to a guest agent to transfer files via ``guest-file-read``/
+        ``guest-file-write``, increasing this value may be required.
+
     Basic script-style usage looks like this::
 
       qmp = QMPClient('my_virtual_machine_name')
@@ -203,14 +209,18 @@ async def run(self, address='/tmp/qemu.socket'):
     #: Logger object used for debugging messages.
     logger = logging.getLogger(__name__)
 
-    # Read buffer limit; 10MB like libvirt default
-    _limit = 10 * 1024 * 1024
+    # Read buffer default limit; 10MB like libvirt default
+    _readbuflen = 10 * 1024 * 1024
 
     # Type alias for pending execute() result items
     _PendingT = Union[Message, ExecInterruptedError]
 
-    def __init__(self, name: Optional[str] = None) -> None:
-        super().__init__(name)
+    def __init__(
+        self,
+        name: Optional[str] = None,
+        readbuflen: int = _readbuflen
+    ) -> None:
+        super().__init__(name, readbuflen)
         Events.__init__(self)
 
         #: Whether or not to await a greeting after establishing a connection.
-- 
2.50.1


