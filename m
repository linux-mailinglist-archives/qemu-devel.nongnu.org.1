Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B275AF26
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTLH-0005o6-0v; Thu, 20 Jul 2023 09:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTL1-0005lc-24
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTKx-00064f-It
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689858294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGDdiyZFTeDU5P1FXRF8bWWCTt195umPtU7bV4rV+dA=;
 b=erEIR49AqvT8zgaOWVqnfaOinbgsbyaLB8C5n6mI/jkj/h36s6mDQLrsARqphlMpXZrV1Y
 WyuoH5+2GnnXgXYhquDybzhHyEGrZKVKDljBWVVT1VoiBEBMezDKk4YO5oktNBQS0rDVqL
 t8jyDPi0oCTJL69HPnR/X3ngdwyqCUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-NDOAPCJ_OKm9ADU4-QoGRg-1; Thu, 20 Jul 2023 09:04:51 -0400
X-MC-Unique: NDOAPCJ_OKm9ADU4-QoGRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2624936D2D;
 Thu, 20 Jul 2023 13:04:50 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7391121314;
 Thu, 20 Jul 2023 13:04:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 4/4] python/machine: remove unused console socket
 configuration arguments
Date: Thu, 20 Jul 2023 09:04:48 -0400
Message-ID: <20230720130448.921356-5-jsnow@redhat.com>
In-Reply-To: <20230720130448.921356-1-jsnow@redhat.com>
References: <20230720130448.921356-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

By using a socketpair for the console, we don't need the sock_dir
argument for the base class anymore, remove it.

The qtest subclass still uses the argument for the qtest socket for now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py             | 18 ------------------
 python/qemu/machine/qtest.py               |  6 +++---
 tests/qemu-iotests/tests/copy-before-write |  3 +--
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ef9b2dc02e..350aa8bb26 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -127,7 +127,6 @@ def __init__(self,
                  name: Optional[str] = None,
                  base_temp_dir: str = "/var/tmp",
                  monitor_address: Optional[SocketAddrT] = None,
-                 sock_dir: Optional[str] = None,
                  drain_console: bool = False,
                  console_log: Optional[str] = None,
                  log_dir: Optional[str] = None,
@@ -141,7 +140,6 @@ def __init__(self,
         @param name: prefix for socket and log file names (default: qemu-PID)
         @param base_temp_dir: default location where temp files are created
         @param monitor_address: address for QMP monitor
-        @param sock_dir: where to create socket (defaults to base_temp_dir)
         @param drain_console: (optional) True to drain console socket to buffer
         @param console_log: (optional) path to console log file
         @param log_dir: where to create and keep log files
@@ -163,7 +161,6 @@ def __init__(self,
             Tuple[socket.socket, socket.socket]] = None
         self._temp_dir: Optional[str] = None
         self._base_temp_dir = base_temp_dir
-        self._sock_dir = sock_dir
         self._log_dir = log_dir
 
         self._monitor_address = monitor_address
@@ -189,9 +186,6 @@ def __init__(self,
         self._console_index = 0
         self._console_set = False
         self._console_device_type: Optional[str] = None
-        self._console_address = os.path.join(
-            self.sock_dir, f"{self._name}.con"
-        )
         self._console_socket: Optional[socket.socket] = None
         self._remove_files: List[str] = []
         self._user_killed = False
@@ -334,9 +328,6 @@ def args(self) -> List[str]:
         return self._args
 
     def _pre_launch(self) -> None:
-        if self._console_set:
-            self._remove_files.append(self._console_address)
-
         if self._qmp_set:
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
@@ -900,15 +891,6 @@ def temp_dir(self) -> str:
                                               dir=self._base_temp_dir)
         return self._temp_dir
 
-    @property
-    def sock_dir(self) -> str:
-        """
-        Returns the directory used for sockfiles by this machine.
-        """
-        if self._sock_dir:
-            return self._sock_dir
-        return self.temp_dir
-
     @property
     def log_dir(self) -> str:
         """
diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
index 1c46138bd0..22f8045ef6 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -115,8 +115,8 @@ def __init__(self,
                  wrapper: Sequence[str] = (),
                  name: Optional[str] = None,
                  base_temp_dir: str = "/var/tmp",
-                 sock_dir: Optional[str] = None,
-                 qmp_timer: Optional[float] = None):
+                 qmp_timer: Optional[float] = None,
+                 sock_dir: Optional[str] = None):
         # pylint: disable=too-many-arguments
 
         if name is None:
@@ -125,7 +125,7 @@ def __init__(self,
             sock_dir = base_temp_dir
         super().__init__(binary, args, wrapper=wrapper, name=name,
                          base_temp_dir=base_temp_dir,
-                         sock_dir=sock_dir, qmp_timer=qmp_timer)
+                         qmp_timer=qmp_timer)
         self._qtest: Optional[QEMUQtestProtocol] = None
         self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
 
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 2ffe092b31..d3987db942 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -44,8 +44,7 @@ class TestCbwError(iotests.QMPTestCase):
 
         opts = ['-nodefaults', '-display', 'none', '-machine', 'none']
         self.vm = QEMUMachine(iotests.qemu_prog, opts,
-                              base_temp_dir=iotests.test_dir,
-                              sock_dir=iotests.sock_dir)
+                              base_temp_dir=iotests.test_dir)
         self.vm.launch()
 
     def do_cbw_error(self, on_cbw_error):
-- 
2.41.0


