Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 550407C8D9D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYJ-0006vJ-S0; Fri, 13 Oct 2023 15:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNY1-0006dN-TG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNXu-0001dY-QH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8sv+78KTJhHOiCUg6jfT+/hp9K/9RBZWBgneYLcY6g=;
 b=aNjdGOwL86aSfeIaKCd87ib48eD7BmWMIfW9R5210Rcm273YnuQzrS9wrgQ63Hxgz+ndDi
 ZQcp5s9P/LOqKEroSv7LjgOMxYL3dYIbEqujYEsTNbzUZlW8Kn7xiKQbOdtLmY5QtohQVc
 R/DXXI/3IrNjxQuoUgOx0+TKRB1h1fw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-y0adCPpANvCk1EGO0FPNyQ-1; Fri, 13 Oct 2023 15:09:52 -0400
X-MC-Unique: y0adCPpANvCk1EGO0FPNyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3046D3C025BA;
 Fri, 13 Oct 2023 19:09:51 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8BBE40C6F79;
 Fri, 13 Oct 2023 19:09:49 +0000 (UTC)
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
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/25] python/machine: remove unused sock_dir argument
Date: Fri, 13 Oct 2023 15:09:21 -0400
Message-ID: <20231013190941.3699288-7-jsnow@redhat.com>
In-Reply-To: <20231013190941.3699288-1-jsnow@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By using a socketpair for all of the sockets managed by the VM class and
its extensions, we don't need the sock_dir argument anymore, so remove
it.

We only added this argument so that we could specify a second, shorter
temporary directory for cases where the temp/log dirs were "too long" as
a socket name on macOS. We don't need it for this class now. In one
case, avocado testing takes over responsibility for creating an
appropriate sockdir.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230928044943.849073-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py             | 18 ------------------
 python/qemu/machine/qtest.py               |  5 +----
 tests/avocado/acpi-bits.py                 |  5 +----
 tests/avocado/avocado_qemu/__init__.py     |  2 +-
 tests/avocado/machine_aspeed.py            |  5 ++++-
 tests/qemu-iotests/iotests.py              |  2 +-
 tests/qemu-iotests/tests/copy-before-write |  3 +--
 7 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 4156b8cf7d..d539e91268 100644
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
         self._console_file: Optional[socket.SocketIO] = None
         self._remove_files: List[str] = []
@@ -335,9 +329,6 @@ def args(self) -> List[str]:
         return self._args
 
     def _pre_launch(self) -> None:
-        if self._console_set:
-            self._remove_files.append(self._console_address)
-
         if self._qmp_set:
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
@@ -937,15 +928,6 @@ def temp_dir(self) -> str:
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
index 8180d3ab01..4f5ede85b2 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -135,17 +135,14 @@ def __init__(self,
                  wrapper: Sequence[str] = (),
                  name: Optional[str] = None,
                  base_temp_dir: str = "/var/tmp",
-                 sock_dir: Optional[str] = None,
                  qmp_timer: Optional[float] = None):
         # pylint: disable=too-many-arguments
 
         if name is None:
             name = "qemu-%d" % os.getpid()
-        if sock_dir is None:
-            sock_dir = base_temp_dir
         super().__init__(binary, args, wrapper=wrapper, name=name,
                          base_temp_dir=base_temp_dir,
-                         sock_dir=sock_dir, qmp_timer=qmp_timer)
+                         qmp_timer=qmp_timer)
         self._qtest: Optional[QEMUQtestProtocol] = None
         self._qtest_sock_pair: Optional[
             Tuple[socket.socket, socket.socket]] = None
diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index bb3f818689..eca13dc518 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -92,17 +92,14 @@ def __init__(self,
                  base_temp_dir: str = "/var/tmp",
                  debugcon_log: str = "debugcon-log.txt",
                  debugcon_addr: str = "0x403",
-                 sock_dir: Optional[str] = None,
                  qmp_timer: Optional[float] = None):
         # pylint: disable=too-many-arguments
 
         if name is None:
             name = "qemu-bits-%d" % os.getpid()
-        if sock_dir is None:
-            sock_dir = base_temp_dir
         super().__init__(binary, args, wrapper=wrapper, name=name,
                          base_temp_dir=base_temp_dir,
-                         sock_dir=sock_dir, qmp_timer=qmp_timer)
+                         qmp_timer=qmp_timer)
         self.debugcon_log = debugcon_log
         self.debugcon_addr = debugcon_addr
         self.base_temp_dir = base_temp_dir
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 0172a359b7..0589534f28 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -322,7 +322,7 @@ def require_multiprocess(self):
     def _new_vm(self, name, *args):
         self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
         vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
-                         sock_dir=self._sd.name, log_dir=self.logdir)
+                         log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
         self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index 90f1b7cb77..f691ee3fb8 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -247,7 +247,10 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
         image_path = self.fetch_asset(image_url, asset_hash=image_hash,
                                       algorithm='sha256')
 
-        socket = os.path.join(self.vm.sock_dir, 'swtpm-socket')
+        # force creation of VM object, which also defines self._sd
+        vm = self.vm
+
+        socket = os.path.join(self._sd.name, 'swtpm-socket')
 
         subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
                         '--tpmstate', f'dir={self.vm.temp_dir}',
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ef66fbd62b..145c682713 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -823,7 +823,7 @@ def __init__(self, path_suffix=''):
         super().__init__(qemu_prog, qemu_opts, wrapper=wrapper,
                          name=name,
                          base_temp_dir=test_dir,
-                         sock_dir=sock_dir, qmp_timer=timer)
+                         qmp_timer=timer)
         self._num_drives = 0
 
     def _post_shutdown(self) -> None:
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


