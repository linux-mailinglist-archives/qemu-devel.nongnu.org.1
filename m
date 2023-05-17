Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A442706E3F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzK6U-0004C6-IW; Wed, 17 May 2023 12:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6T-0004Bj-5r
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzK6R-0005ze-Lq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+eQZFol/ic3DDC6RMlVjahb8jopKiPmqA+a0nlc4+0=;
 b=FZ/xxw/BDIGZz5jTooBaS2OjzqQiKhdVPSE4WE5Cc5zFIzUlYwFmYAeAeh9vOVbgK1cyti
 TaJ2524cLToQN1VWuSaB16QrCCVZOUukGWeJtfNgGyzKaxNjv+2mCYxhi/0zOw3hMIS9Za
 R4adHClshqXjszIgB1Y7d+btjlVleZo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-NDh4QRMuPq263mJ7PgOE2Q-1; Wed, 17 May 2023 12:34:10 -0400
X-MC-Unique: NDh4QRMuPq263mJ7PgOE2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40EB785A588;
 Wed, 17 May 2023 16:34:09 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9F102166B31;
 Wed, 17 May 2023 16:34:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/5] Revert "python/qmp/protocol: add open_with_socket()"
Date: Wed, 17 May 2023 12:34:06 -0400
Message-Id: <20230517163406.2593480-6-jsnow@redhat.com>
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

This reverts commit a3cfea92e2030926e00a2519d299384ea648e36e.

(It's being rolled back in favor of a different API, which brings the
in-tree and out-of-tree versions of qemu.qmp back in sync.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/protocol.py | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index d534db4631..753182131f 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -297,19 +297,6 @@ async def start_server_and_accept(
         await self.accept()
         assert self.runstate == Runstate.RUNNING
 
-    @upper_half
-    @require(Runstate.IDLE)
-    async def open_with_socket(self, sock: socket.socket) -> None:
-        """
-        Start connection with given socket.
-
-        :param sock: A socket.
-
-        :raise StateError: When the `Runstate` is not `IDLE`.
-        """
-        self._reader, self._writer = await asyncio.open_connection(sock=sock)
-        self._set_state(Runstate.CONNECTING)
-
     @upper_half
     @require(Runstate.IDLE)
     async def start_server(self, address: SocketAddrT,
@@ -357,12 +344,11 @@ async def accept(self) -> None:
             protocol-level failure occurs while establishing a new
             session, the wrapped error may also be an `QMPError`.
         """
-        if not self._reader:
-            if self._accepted is None:
-                raise QMPError("Cannot call accept() before start_server().")
-            await self._session_guard(
-                self._do_accept(),
-                'Failed to establish connection')
+        if self._accepted is None:
+            raise QMPError("Cannot call accept() before start_server().")
+        await self._session_guard(
+            self._do_accept(),
+            'Failed to establish connection')
         await self._session_guard(
             self._establish_session(),
             'Failed to establish session')
-- 
2.40.0


