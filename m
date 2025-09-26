Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B9BA3B5B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 14:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27qm-0008EP-JD; Fri, 26 Sep 2025 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27qh-0008Dc-LP; Fri, 26 Sep 2025 08:46:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27qZ-0006kV-N1; Fri, 26 Sep 2025 08:46:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4132C157F4E;
 Fri, 26 Sep 2025 15:45:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A5627290F0C;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 06/38] python: backport 'Use @asynciocontextmanager'
Date: Fri, 26 Sep 2025 15:45:06 +0300
Message-ID: <20250926124540.2221746-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

This removes a non-idiomatic use of a "coroutine callback" in favor of
something a bit more standardized.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@commit 97f7ffa3be17a50544b52767d14b6fd478c07b9e
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 0408b8d7a086486f5c1887798be744b2d73bcda9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 4aff0ea423..56e6dfa5a7 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -15,6 +15,7 @@
 
 import asyncio
 from asyncio import StreamReader, StreamWriter
+from contextlib import asynccontextmanager
 from enum import Enum
 from functools import wraps
 import logging
@@ -22,6 +23,7 @@
 from ssl import SSLContext
 from typing import (
     Any,
+    AsyncGenerator,
     Awaitable,
     Callable,
     Generic,
@@ -318,9 +320,8 @@ async def start_server(self, address: SocketAddrT,
             This exception will wrap a more concrete one. In most cases,
             the wrapped exception will be `OSError`.
         """
-        await self._session_guard(
-            self._do_start_server(address, ssl),
-            'Failed to establish connection')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_start_server(address, ssl)
         assert self.runstate == Runstate.CONNECTING
 
     @upper_half
@@ -343,12 +344,10 @@ async def accept(self) -> None:
         """
         if self._accepted is None:
             raise QMPError("Cannot call accept() before start_server().")
-        await self._session_guard(
-            self._do_accept(),
-            'Failed to establish connection')
-        await self._session_guard(
-            self._establish_session(),
-            'Failed to establish session')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_accept()
+        async with self._session_guard('Failed to establish session'):
+            await self._establish_session()
         assert self.runstate == Runstate.RUNNING
 
     @upper_half
@@ -373,12 +372,10 @@ async def connect(self, address: Union[SocketAddrT, socket.socket],
             protocol-level failure occurs while establishing a new
             session, the wrapped error may also be an `QMPError`.
         """
-        await self._session_guard(
-            self._do_connect(address, ssl),
-            'Failed to establish connection')
-        await self._session_guard(
-            self._establish_session(),
-            'Failed to establish session')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_connect(address, ssl)
+        async with self._session_guard('Failed to establish session'):
+            await self._establish_session()
         assert self.runstate == Runstate.RUNNING
 
     @upper_half
@@ -399,7 +396,8 @@ async def disconnect(self) -> None:
     # Section: Session machinery
     # --------------------------
 
-    async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
+    @asynccontextmanager
+    async def _session_guard(self, emsg: str) -> AsyncGenerator[None, None]:
         """
         Async guard function used to roll back to `IDLE` on any error.
 
@@ -416,10 +414,9 @@ async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
         :raise ConnectError:
             When any other error is encountered in the guarded block.
         """
-        # Note: After Python 3.6 support is removed, this should be an
-        # @asynccontextmanager instead of accepting a callback.
         try:
-            await coro
+            # Caller's code runs here.
+            yield
         except BaseException as err:
             self.logger.error("%s: %s", emsg, exception_summary(err))
             self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-- 
2.47.3


