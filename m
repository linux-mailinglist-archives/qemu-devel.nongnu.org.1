Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43863718B6A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Sfl-0005y4-4A; Wed, 31 May 2023 16:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4Sfh-0005sZ-Bi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4SfY-0004th-VF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685565824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZcGayvwUM1HGQBT6wPG68afCyKhTqRWG5bfnWhNbMY=;
 b=JlUpqO68SAbK5KPlpFcKcJLeQPxTNLicBqXkqND5xREJYUkv8Er7Ut/4HAB4WhhiXhwLCZ
 uwJIupJwfCayj5mhKxHLlsfcR1J6hPsSFbp5UYKygZ/RSj47WbWWTOKBVgEzwHPvdoypnK
 FBxXZNLu4WJJgQfVTQ58rU3TJPFQorQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-85Ll0ROEPJyhq20iz0C-ZQ-1; Wed, 31 May 2023 16:43:40 -0400
X-MC-Unique: 85Ll0ROEPJyhq20iz0C-ZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C738101A531;
 Wed, 31 May 2023 20:43:40 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26272029F6D;
 Wed, 31 May 2023 20:43:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 1/5] python/qmp: allow sockets to be passed to connect()
Date: Wed, 31 May 2023 16:43:34 -0400
Message-Id: <20230531204338.1656158-2-jsnow@redhat.com>
In-Reply-To: <20230531204338.1656158-1-jsnow@redhat.com>
References: <20230531204338.1656158-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Allow existing sockets to be passed to connect(). The changes are pretty
minimal, and this allows for far greater flexibility in setting up
communications with an endpoint.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20230517163406.2593480-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/protocol.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 22e60298d2..d534db4631 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -370,7 +370,7 @@ async def accept(self) -> None:
 
     @upper_half
     @require(Runstate.IDLE)
-    async def connect(self, address: SocketAddrT,
+    async def connect(self, address: Union[SocketAddrT, socket.socket],
                       ssl: Optional[SSLContext] = None) -> None:
         """
         Connect to the server and begin processing message queues.
@@ -615,7 +615,7 @@ async def _do_accept(self) -> None:
         self.logger.debug("Connection accepted.")
 
     @upper_half
-    async def _do_connect(self, address: SocketAddrT,
+    async def _do_connect(self, address: Union[SocketAddrT, socket.socket],
                           ssl: Optional[SSLContext] = None) -> None:
         """
         Acting as the transport client, initiate a connection to a server.
@@ -634,9 +634,17 @@ async def _do_connect(self, address: SocketAddrT,
         # otherwise yield.
         await asyncio.sleep(0)
 
-        self.logger.debug("Connecting to %s ...", address)
-
-        if isinstance(address, tuple):
+        if isinstance(address, socket.socket):
+            self.logger.debug("Connecting with existing socket: "
+                              "fd=%d, family=%r, type=%r",
+                              address.fileno(), address.family, address.type)
+            connect = asyncio.open_connection(
+                limit=self._limit,
+                ssl=ssl,
+                sock=address,
+            )
+        elif isinstance(address, tuple):
+            self.logger.debug("Connecting to %s ...", address)
             connect = asyncio.open_connection(
                 address[0],
                 address[1],
@@ -644,13 +652,14 @@ async def _do_connect(self, address: SocketAddrT,
                 limit=self._limit,
             )
         else:
+            self.logger.debug("Connecting to file://%s ...", address)
             connect = asyncio.open_unix_connection(
                 path=address,
                 ssl=ssl,
                 limit=self._limit,
             )
+
         self._reader, self._writer = await connect
-
         self.logger.debug("Connected.")
 
     @upper_half
-- 
2.40.1


