Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88EBA3B19
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 14:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27qy-0008Fi-Hl; Fri, 26 Sep 2025 08:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27qp-0008Es-1y; Fri, 26 Sep 2025 08:47:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27qb-0006jX-Hz; Fri, 26 Sep 2025 08:47:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E4BE157F4D;
 Fri, 26 Sep 2025 15:45:40 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 90AFE290F0B;
 Fri, 26 Sep 2025 15:45:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 05/38] python: backport 'drop Python3.6 workarounds'
Date: Fri, 26 Sep 2025 15:45:05 +0300
Message-ID: <20250926124540.2221746-5-mjt@tls.msk.ru>
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

From: John Snow <jsnow@redhat.com>

Now that the minimum version is 3.7, drop some of the 3.6-specific hacks
we've been carrying. A single remaining compatibility hack concerning
3.6's lack of @asynccontextmanager is addressed in the following commit.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@3e8e34e594cfc6b707e6f67959166acde4b421b8
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit f9d2e0a3bd7ba2a693a892881f91cf53fa90cc71)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index a4ffdfad51..4aff0ea423 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -36,13 +36,10 @@
 from .error import QMPError
 from .util import (
     bottom_half,
-    create_task,
     exception_summary,
     flush,
-    is_closing,
     pretty_traceback,
     upper_half,
-    wait_closed,
 )
 
 
@@ -663,8 +660,8 @@ async def _establish_session(self) -> None:
         reader_coro = self._bh_loop_forever(self._bh_recv_message, 'Reader')
         writer_coro = self._bh_loop_forever(self._bh_send_message, 'Writer')
 
-        self._reader_task = create_task(reader_coro)
-        self._writer_task = create_task(writer_coro)
+        self._reader_task = asyncio.create_task(reader_coro)
+        self._writer_task = asyncio.create_task(writer_coro)
 
         self._bh_tasks = asyncio.gather(
             self._reader_task,
@@ -689,7 +686,7 @@ def _schedule_disconnect(self) -> None:
         if not self._dc_task:
             self._set_state(Runstate.DISCONNECTING)
             self.logger.debug("Scheduling disconnect.")
-            self._dc_task = create_task(self._bh_disconnect())
+            self._dc_task = asyncio.create_task(self._bh_disconnect())
 
     @upper_half
     async def _wait_disconnect(self) -> None:
@@ -825,13 +822,13 @@ async def _bh_close_stream(self, error_pathway: bool = False) -> None:
         if not self._writer:
             return
 
-        if not is_closing(self._writer):
+        if not self._writer.is_closing():
             self.logger.debug("Closing StreamWriter.")
             self._writer.close()
 
         self.logger.debug("Waiting for StreamWriter to close ...")
         try:
-            await wait_closed(self._writer)
+            await self._writer.wait_closed()
         except Exception:  # pylint: disable=broad-except
             # It's hard to tell if the Stream is already closed or
             # not. Even if one of the tasks has failed, it may have
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 2d9ebbd20b..562be008d5 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -40,7 +40,7 @@
 from .message import DeserializationError, Message, UnexpectedTypeError
 from .protocol import ConnectError, Runstate
 from .qmp_client import ExecInterruptedError, QMPClient
-from .util import create_task, pretty_traceback
+from .util import pretty_traceback
 
 
 # The name of the signal that is used to update the history list
@@ -225,7 +225,7 @@ def cb_send_to_server(self, raw_msg: str) -> None:
         """
         try:
             msg = Message(bytes(raw_msg, encoding='utf-8'))
-            create_task(self._send_to_server(msg))
+            asyncio.create_task(self._send_to_server(msg))
         except (DeserializationError, UnexpectedTypeError) as err:
             raw_msg = format_json(raw_msg)
             logging.info('Invalid message: %s', err.error_message)
@@ -246,7 +246,7 @@ def kill_app(self) -> None:
         Initiates killing of app. A bridge between asynchronous and synchronous
         code.
         """
-        create_task(self._kill_app())
+        asyncio.create_task(self._kill_app())
 
     async def _kill_app(self) -> None:
         """
@@ -393,7 +393,7 @@ def run(self, debug: bool = False) -> None:
                                    handle_mouse=True,
                                    event_loop=event_loop)
 
-        create_task(self.manage_connection(), self.aloop)
+        self.aloop.create_task(self.manage_connection())
         try:
             main_loop.run()
         except Exception as err:
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index ca6225e9cd..0b3e781373 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -1,25 +1,15 @@
 """
 Miscellaneous Utilities
 
-This module provides asyncio utilities and compatibility wrappers for
-Python 3.6 to provide some features that otherwise become available in
-Python 3.7+.
-
-Various logging and debugging utilities are also provided, such as
-`exception_summary()` and `pretty_traceback()`, used primarily for
-adding information into the logging stream.
+This module provides asyncio and various logging and debugging
+utilities, such as `exception_summary()` and `pretty_traceback()`, used
+primarily for adding information into the logging stream.
 """
 
 import asyncio
 import sys
 import traceback
-from typing import (
-    Any,
-    Coroutine,
-    Optional,
-    TypeVar,
-    cast,
-)
+from typing import TypeVar, cast
 
 
 T = TypeVar('T')
@@ -79,95 +69,6 @@ def bottom_half(func: T) -> T:
     return func
 
 
-# -------------------------------
-# Section: Compatibility Wrappers
-# -------------------------------
-
-
-def create_task(coro: Coroutine[Any, Any, T],
-                loop: Optional[asyncio.AbstractEventLoop] = None
-                ) -> 'asyncio.Future[T]':
-    """
-    Python 3.6-compatible `asyncio.create_task` wrapper.
-
-    :param coro: The coroutine to execute in a task.
-    :param loop: Optionally, the loop to create the task in.
-
-    :return: An `asyncio.Future` object.
-    """
-    if sys.version_info >= (3, 7):
-        if loop is not None:
-            return loop.create_task(coro)
-        return asyncio.create_task(coro)  # pylint: disable=no-member
-
-    # Python 3.6:
-    return asyncio.ensure_future(coro, loop=loop)
-
-
-def is_closing(writer: asyncio.StreamWriter) -> bool:
-    """
-    Python 3.6-compatible `asyncio.StreamWriter.is_closing` wrapper.
-
-    :param writer: The `asyncio.StreamWriter` object.
-    :return: `True` if the writer is closing, or closed.
-    """
-    if sys.version_info >= (3, 7):
-        return writer.is_closing()
-
-    # Python 3.6:
-    transport = writer.transport
-    assert isinstance(transport, asyncio.WriteTransport)
-    return transport.is_closing()
-
-
-async def wait_closed(writer: asyncio.StreamWriter) -> None:
-    """
-    Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
-
-    :param writer: The `asyncio.StreamWriter` to wait on.
-    """
-    if sys.version_info >= (3, 7):
-        await writer.wait_closed()
-        return
-
-    # Python 3.6
-    transport = writer.transport
-    assert isinstance(transport, asyncio.WriteTransport)
-
-    while not transport.is_closing():
-        await asyncio.sleep(0)
-
-    # This is an ugly workaround, but it's the best I can come up with.
-    sock = transport.get_extra_info('socket')
-
-    if sock is None:
-        # Our transport doesn't have a socket? ...
-        # Nothing we can reasonably do.
-        return
-
-    while sock.fileno() != -1:
-        await asyncio.sleep(0)
-
-
-def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
-    """
-    Python 3.6-compatible `asyncio.run` wrapper.
-
-    :param coro: A coroutine to execute now.
-    :return: The return value from the coroutine.
-    """
-    if sys.version_info >= (3, 7):
-        return asyncio.run(coro, debug=debug)
-
-    # Python 3.6
-    loop = asyncio.get_event_loop()
-    loop.set_debug(debug)
-    ret = loop.run_until_complete(coro)
-    loop.close()
-
-    return ret
-
-
 # ----------------------------
 # Section: Logging & Debugging
 # ----------------------------
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index 56c4d441f9..c254c77b17 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -8,7 +8,6 @@
 
 from qemu.qmp import ConnectError, Runstate
 from qemu.qmp.protocol import AsyncProtocol, StateError
-from qemu.qmp.util import asyncio_run, create_task
 
 
 class NullProtocol(AsyncProtocol[None]):
@@ -124,7 +123,7 @@ async def _runner():
             if allow_cancellation:
                 return
             raise
-    return create_task(_runner())
+    return asyncio.create_task(_runner())
 
 
 @contextmanager
@@ -271,7 +270,7 @@ async def _watcher():
                     msg=f"Expected state '{state.name}'",
                 )
 
-        self.runstate_watcher = create_task(_watcher())
+        self.runstate_watcher = asyncio.create_task(_watcher())
         # Kick the loop and force the task to block on the event.
         await asyncio.sleep(0)
 
@@ -589,7 +588,8 @@ async def _asyncTearDown(self):
     async def testSmoke(self):
         with TemporaryDirectory(suffix='.qmp') as tmpdir:
             sock = os.path.join(tmpdir, type(self.proto).__name__ + ".sock")
-            server_task = create_task(self.server.start_server_and_accept(sock))
+            server_task = asyncio.create_task(
+                self.server.start_server_and_accept(sock))
 
             # give the server a chance to start listening [...]
             await asyncio.sleep(0)
-- 
2.47.3


