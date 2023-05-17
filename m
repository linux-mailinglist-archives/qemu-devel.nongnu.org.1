Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F36706E3B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:34:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK6Q-0004AU-IH; Wed, 17 May 2023 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6O-0004AI-PX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6N-0005yp-9q
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tg5ghrFH8r7Mc8ogtoJinO/XybdKcGC7SSuNZBGyTdg=;
 b=SUJ9np3hyZBK7jf//9rON5bg4clQDjkgVXUuaUCRXujtBgAi8KyT2e6GmQOaoQxXpLyq9v
 vBuza/pmSsks6OiHPGfyZCptZFgV0LxbfGpUOlFHOO0cBXLWZJK4kurPPLRL4ybfm9OoaY
 5NYTs/QGcT97ydoiqSc4KzJka6fX7ps=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-e9YFCTvPOISu67AWembI0g-1; Wed, 17 May 2023 12:34:08 -0400
X-MC-Unique: e9YFCTvPOISu67AWembI0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C63D3805F61;
 Wed, 17 May 2023 16:34:07 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7D62166B31;
 Wed, 17 May 2023 16:34:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/5] python/qmp: allow sockets to be passed to connect()
Date: Wed, 17 May 2023 12:34:02 -0400
Message-Id: <20230517163406.2593480-2-jsnow@redhat.com>
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

Allow existing sockets to be passed to connect(). The changes are pretty
minimal, and this allows for far greater flexibility in setting up
communications with an endpoint.

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
2.40.0


