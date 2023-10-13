Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5197C8D8E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYu-0008Km-9t; Fri, 13 Oct 2023 15:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYW-0007Kw-Nj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYH-0001zJ-34
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xFtf4Yd0bb3Y8zYTnVPaNGv5cj//QNA285qIPF9jAI=;
 b=TVqAWoNeVbROb1s/KmiTqDECusHcOuMTDuU4Xsl5V3HZ8QlMbTGdZc+XuNM6P0vp/icA+/
 Y5Isr7vM4tfCUy9507mRaRR6WrvL+PEgJSXdoqL5PJZZMpR0m0fco93hS+VUSWzAYAkuaZ
 VqV0Z6Gy6tYJD4+JRkmjT6DbRfNy/GU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-0gJx9rJ5PFyMuCY1sX6unQ-1; Fri, 13 Oct 2023 15:10:04 -0400
X-MC-Unique: 0gJx9rJ5PFyMuCY1sX6unQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF72D3C17703;
 Fri, 13 Oct 2023 19:10:02 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2DD740C6CA0;
 Fri, 13 Oct 2023 19:10:01 +0000 (UTC)
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
Subject: [PULL 15/25] python/qemu: rename command() to cmd()
Date: Fri, 13 Oct 2023 15:09:30 -0400
Message-ID: <20231013190941.3699288-16-jsnow@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Use a shorter name. We are going to move in iotests from qmp() to
command() where possible. But command() is longer than qmp() and don't
look better. Let's rename.

You can simply grep for '\.command(' and for 'def command(' to check
that everything is updated (command() in tests/docker/docker.py is
unrelated).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-id: 20231006154125.1068348-6-vsementsov@yandex-team.ru
[vsementsov: also update three occurrences in
   tests/avocado/machine_aspeed.py and keep r-b]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/testing.rst                    |  10 +-
 python/qemu/machine/machine.py            |   8 +-
 python/qemu/qmp/legacy.py                 |   2 +-
 python/qemu/qmp/qmp_shell.py              |   2 +-
 python/qemu/utils/qemu_ga_client.py       |   2 +-
 python/qemu/utils/qom.py                  |   8 +-
 python/qemu/utils/qom_common.py           |   2 +-
 python/qemu/utils/qom_fuse.py             |   6 +-
 scripts/cpu-x86-uarch-abi.py              |   8 +-
 scripts/device-crash-test                 |   8 +-
 scripts/render_block_graph.py             |   8 +-
 tests/avocado/avocado_qemu/__init__.py    |   4 +-
 tests/avocado/cpu_queries.py              |   5 +-
 tests/avocado/hotplug_cpu.py              |  10 +-
 tests/avocado/info_usernet.py             |   4 +-
 tests/avocado/machine_arm_integratorcp.py |   6 +-
 tests/avocado/machine_aspeed.py           |  12 +-
 tests/avocado/machine_m68k_nextcube.py    |   4 +-
 tests/avocado/machine_mips_malta.py       |   6 +-
 tests/avocado/machine_s390_ccw_virtio.py  |  28 ++---
 tests/avocado/migration.py                |  10 +-
 tests/avocado/pc_cpu_hotplug_props.py     |   2 +-
 tests/avocado/version.py                  |   4 +-
 tests/avocado/virtio_check_params.py      |   6 +-
 tests/avocado/virtio_version.py           |   5 +-
 tests/avocado/x86_cpu_model_versions.py   |  13 +-
 tests/migration/guestperf/engine.py       | 144 +++++++++++-----------
 tests/qemu-iotests/256                    |  34 ++---
 tests/qemu-iotests/257                    |  34 ++---
 29 files changed, 200 insertions(+), 195 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index f3e2472189..b0680cbb22 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1014,8 +1014,8 @@ class.  Here's a simple usage example:
       """
       def test_qmp_human_info_version(self):
           self.vm.launch()
-          res = self.vm.command('human-monitor-command',
-                                command_line='info version')
+          res = self.vm.cmd('human-monitor-command',
+                            command_line='info version')
           self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
 
 To execute your test, run:
@@ -1065,15 +1065,15 @@ and hypothetical example follows:
           first_machine.launch()
           second_machine.launch()
 
-          first_res = first_machine.command(
+          first_res = first_machine.cmd(
               'human-monitor-command',
               command_line='info version')
 
-          second_res = second_machine.command(
+          second_res = second_machine.cmd(
               'human-monitor-command',
               command_line='info version')
 
-          third_res = self.get_vm(name='third_machine').command(
+          third_res = self.get_vm(name='third_machine').cmd(
               'human-monitor-command',
               command_line='info version')
 
diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 50bba33729..eae193eb00 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -707,16 +707,16 @@ def qmp(self, cmd: str,
             self._quit_issued = True
         return ret
 
-    def command(self, cmd: str,
-                conv_keys: bool = True,
-                **args: Any) -> QMPReturnValue:
+    def cmd(self, cmd: str,
+            conv_keys: bool = True,
+            **args: Any) -> QMPReturnValue:
         """
         Invoke a QMP command.
         On success return the response dict.
         On failure raise an exception.
         """
         qmp_args = self._qmp_args(conv_keys, args)
-        ret = self._qmp.command(cmd, **qmp_args)
+        ret = self._qmp.cmd(cmd, **qmp_args)
         if cmd == 'quit':
             self._quit_issued = True
         return ret
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index e5fa1ce9c4..22a2b5616e 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -207,7 +207,7 @@ def cmd_raw(self, name: str,
             qmp_cmd['arguments'] = args
         return self.cmd_obj(qmp_cmd)
 
-    def command(self, cmd: str, **kwds: object) -> QMPReturnValue:
+    def cmd(self, cmd: str, **kwds: object) -> QMPReturnValue:
         """
         Build and send a QMP command to the monitor, report errors if any
         """
diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index 988d79c01b..98e684e9e8 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -202,7 +202,7 @@ def close(self) -> None:
 
     def _fill_completion(self) -> None:
         try:
-            cmds = cast(List[Dict[str, str]], self.command('query-commands'))
+            cmds = cast(List[Dict[str, str]], self.cmd('query-commands'))
             for cmd in cmds:
                 self._completer.append(cmd['name'])
         except ExecuteError:
diff --git a/python/qemu/utils/qemu_ga_client.py b/python/qemu/utils/qemu_ga_client.py
index d8411bb2d0..9a665e6e99 100644
--- a/python/qemu/utils/qemu_ga_client.py
+++ b/python/qemu/utils/qemu_ga_client.py
@@ -64,7 +64,7 @@
 class QemuGuestAgent(QEMUMonitorProtocol):
     def __getattr__(self, name: str) -> Callable[..., Any]:
         def wrapper(**kwds: object) -> object:
-            return self.command('guest-' + name.replace('_', '-'), **kwds)
+            return self.cmd('guest-' + name.replace('_', '-'), **kwds)
         return wrapper
 
 
diff --git a/python/qemu/utils/qom.py b/python/qemu/utils/qom.py
index bcf192f477..426a0f245f 100644
--- a/python/qemu/utils/qom.py
+++ b/python/qemu/utils/qom.py
@@ -84,7 +84,7 @@ def __init__(self, args: argparse.Namespace):
         self.value = args.value
 
     def run(self) -> int:
-        rsp = self.qmp.command(
+        rsp = self.qmp.cmd(
             'qom-set',
             path=self.path,
             property=self.prop,
@@ -129,7 +129,7 @@ def __init__(self, args: argparse.Namespace):
         self.prop = tmp[1]
 
     def run(self) -> int:
-        rsp = self.qmp.command(
+        rsp = self.qmp.cmd(
             'qom-get',
             path=self.path,
             property=self.prop
@@ -231,8 +231,8 @@ def _list_node(self, path: str) -> None:
             if item.child:
                 continue
             try:
-                rsp = self.qmp.command('qom-get', path=path,
-                                       property=item.name)
+                rsp = self.qmp.cmd('qom-get', path=path,
+                                   property=item.name)
                 print(f"  {item.name}: {rsp} ({item.type})")
             except ExecuteError as err:
                 print(f"  {item.name}: <EXCEPTION: {err!s}> ({item.type})")
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index 80da1b2304..dd2c8b1908 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -140,7 +140,7 @@ def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
         """
         :return: a strongly typed list from the 'qom-list' command.
         """
-        rsp = self.qmp.command('qom-list', path=path)
+        rsp = self.qmp.cmd('qom-list', path=path)
         # qom-list returns List[ObjectPropertyInfo]
         assert isinstance(rsp, list)
         return [ObjectPropertyInfo.make(x) for x in rsp]
diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index 8dcd59fcde..cf7e344bd5 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -137,7 +137,7 @@ def read(self, path: str, size: int, offset: int, fh: IO[bytes]) -> bytes:
         if path == '':
             path = '/'
         try:
-            data = str(self.qmp.command('qom-get', path=path, property=prop))
+            data = str(self.qmp.cmd('qom-get', path=path, property=prop))
             data += '\n'  # make values shell friendly
         except ExecuteError as err:
             raise FuseOSError(EPERM) from err
@@ -152,8 +152,8 @@ def readlink(self, path: str) -> Union[bool, str]:
             return False
         path, prop = path.rsplit('/', 1)
         prefix = '/'.join(['..'] * (len(path.split('/')) - 1))
-        return prefix + str(self.qmp.command('qom-get', path=path,
-                                             property=prop))
+        return prefix + str(self.qmp.cmd('qom-get', path=path,
+                                         property=prop))
 
     def getattr(self, path: str,
                 fh: Optional[IO[bytes]] = None) -> Mapping[str, object]:
diff --git a/scripts/cpu-x86-uarch-abi.py b/scripts/cpu-x86-uarch-abi.py
index 893afd1b35..f6baeeff24 100644
--- a/scripts/cpu-x86-uarch-abi.py
+++ b/scripts/cpu-x86-uarch-abi.py
@@ -69,7 +69,7 @@
 shell = QEMUMonitorProtocol(sock)
 shell.connect()
 
-models = shell.command("query-cpu-definitions")
+models = shell.cmd("query-cpu-definitions")
 
 # These QMP props don't correspond to CPUID fatures
 # so ignore them
@@ -93,9 +93,9 @@
 models = {}
 
 for name in sorted(names):
-    cpu = shell.command("query-cpu-model-expansion",
-                        { "type": "static",
-                          "model": { "name": name }})
+    cpu = shell.cmd("query-cpu-model-expansion",
+                    { "type": "static",
+                      "model": { "name": name }})
 
     got = {}
     for (feature, present) in cpu["model"]["props"].items():
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 353aa575d7..da8b56edd9 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -269,14 +269,14 @@ def formatTestCase(t):
 
 def qomListTypeNames(vm, **kwargs):
     """Run qom-list-types QMP command, return type names"""
-    types = vm.command('qom-list-types', **kwargs)
+    types = vm.cmd('qom-list-types', **kwargs)
     return [t['name'] for t in types]
 
 
 def infoQDM(vm):
     """Parse 'info qdm' output"""
     args = {'command-line': 'info qdm'}
-    devhelp = vm.command('human-monitor-command', **args)
+    devhelp = vm.cmd('human-monitor-command', **args)
     for l in devhelp.split('\n'):
         l = l.strip()
         if l == '' or l.endswith(':'):
@@ -304,9 +304,9 @@ class QemuBinaryInfo(object):
             # there's no way to query DeviceClass::user_creatable using QMP,
             # so use 'info qdm':
             self.no_user_devs = set([d['name'] for d in infoQDM(vm, ) if d['no-user']])
-            self.machines = list(m['name'] for m in vm.command('query-machines'))
+            self.machines = list(m['name'] for m in vm.cmd('query-machines'))
             self.user_devs = self.alldevs.difference(self.no_user_devs)
-            self.kvm_available = vm.command('query-kvm')['enabled']
+            self.kvm_available = vm.cmd('query-kvm')['enabled']
         finally:
             vm.shutdown()
 
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 8f731a5cfe..3e1a2e3fa7 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -43,13 +43,13 @@ def render_block_graph(qmp, filename, format='png'):
     representation in @format into "@filename.@format"
     '''
 
-    bds_nodes = qmp.command('query-named-block-nodes')
+    bds_nodes = qmp.cmd('query-named-block-nodes')
     bds_nodes = {n['node-name']: n for n in bds_nodes}
 
-    job_nodes = qmp.command('query-block-jobs')
+    job_nodes = qmp.cmd('query-block-jobs')
     job_nodes = {n['device']: n for n in job_nodes}
 
-    block_graph = qmp.command('x-debug-query-block-graph')
+    block_graph = qmp.cmd('x-debug-query-block-graph')
 
     graph = Digraph(comment='Block Nodes Graph')
     graph.format = format
@@ -94,7 +94,7 @@ class LibvirtGuest():
     def __init__(self, name):
         self.name = name
 
-    def command(self, cmd):
+    def cmd(self, cmd):
         # only supports qmp commands without parameters
         m = {'execute': cmd}
         ar = ['virsh', 'qemu-monitor-command', self.name, json.dumps(m)]
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 0589534f28..d71e989db6 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -408,8 +408,8 @@ class LinuxSSHMixIn:
 
     def ssh_connect(self, username, credential, credential_is_key=True):
         self.ssh_logger = logging.getLogger('ssh')
-        res = self.vm.command('human-monitor-command',
-                              command_line='info usernet')
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='info usernet')
         port = get_info_usernet_hostfwd_port(res)
         self.assertIsNotNone(port)
         self.assertGreater(port, 0)
diff --git a/tests/avocado/cpu_queries.py b/tests/avocado/cpu_queries.py
index cf69f69b11..86c2d5c92d 100644
--- a/tests/avocado/cpu_queries.py
+++ b/tests/avocado/cpu_queries.py
@@ -23,12 +23,13 @@ def test(self):
         self.vm.add_args('-S')
         self.vm.launch()
 
-        cpus = self.vm.command('query-cpu-definitions')
+        cpus = self.vm.cmd('query-cpu-definitions')
         for c in cpus:
             self.log.info("Checking CPU: %s", c)
             self.assertNotIn('', c['unavailable-features'], c['name'])
 
         for c in cpus:
             model = {'name': c['name']}
-            e = self.vm.command('query-cpu-model-expansion', model=model, type='full')
+            e = self.vm.cmd('query-cpu-model-expansion', model=model,
+                            type='full')
             self.assertEquals(e['model']['name'], c['name'])
diff --git a/tests/avocado/hotplug_cpu.py b/tests/avocado/hotplug_cpu.py
index 6374bf1b54..292bb43e4d 100644
--- a/tests/avocado/hotplug_cpu.py
+++ b/tests/avocado/hotplug_cpu.py
@@ -29,9 +29,9 @@ def test(self):
         with self.assertRaises(AssertionError):
             self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
 
-        self.vm.command('device_add',
-                        driver='Haswell-x86_64-cpu',
-                        socket_id=0,
-                        core_id=1,
-                        thread_id=0)
+        self.vm.cmd('device_add',
+                    driver='Haswell-x86_64-cpu',
+                    socket_id=0,
+                    core_id=1,
+                    thread_id=0)
         self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
diff --git a/tests/avocado/info_usernet.py b/tests/avocado/info_usernet.py
index fdc4d90c42..e1aa7a6e0a 100644
--- a/tests/avocado/info_usernet.py
+++ b/tests/avocado/info_usernet.py
@@ -22,8 +22,8 @@ def test_hostfwd(self):
         self.require_netdev('user')
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
         self.vm.launch()
-        res = self.vm.command('human-monitor-command',
-                              command_line='info usernet')
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='info usernet')
         port = get_info_usernet_hostfwd_port(res)
         self.assertIsNotNone(port,
                              ('"info usernet" output content does not seem to '
diff --git a/tests/avocado/machine_arm_integratorcp.py b/tests/avocado/machine_arm_integratorcp.py
index 1ffe1073ef..87f5cf3953 100644
--- a/tests/avocado/machine_arm_integratorcp.py
+++ b/tests/avocado/machine_arm_integratorcp.py
@@ -81,9 +81,9 @@ def test_framebuffer_tux_logo(self):
         self.boot_integratorcp()
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready)
-        self.vm.command('human-monitor-command', command_line='stop')
-        self.vm.command('human-monitor-command',
-                        command_line='screendump %s' % screendump_path)
+        self.vm.cmd('human-monitor-command', command_line='stop')
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screendump_path)
         logger = logging.getLogger('framebuffer')
 
         cpu_count = 1
diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index f691ee3fb8..df31b2a8a8 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -181,8 +181,8 @@ def test_arm_ast2500_evb_buildroot(self):
              'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '0')
-        self.vm.command('qom-set', path='/machine/peripheral/tmp-test',
-                        property='temperature', value=18000);
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon1/temp1_input', '18000')
 
@@ -213,8 +213,8 @@ def test_arm_ast2600_evb_buildroot(self):
              'i2c i2c-3: new_device: Instantiated device lm75 at 0x4d');
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon0/temp1_input', '0')
-        self.vm.command('qom-set', path='/machine/peripheral/tmp-test',
-                        property='temperature', value=18000);
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/hwmon/hwmon0/temp1_input', '18000')
 
@@ -360,8 +360,8 @@ def test_arm_ast2600_evb_sdk(self):
              'i2c i2c-5: new_device: Instantiated device lm75 at 0x4d');
         self.ssh_command_output_contains(
                              'cat /sys/class/hwmon/hwmon19/temp1_input', '0')
-        self.vm.command('qom-set', path='/machine/peripheral/tmp-test',
-                        property='temperature', value=18000);
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000);
         self.ssh_command_output_contains(
                              'cat /sys/class/hwmon/hwmon19/temp1_input', '18000')
 
diff --git a/tests/avocado/machine_m68k_nextcube.py b/tests/avocado/machine_m68k_nextcube.py
index 6790e7d9cd..d6da2fbb01 100644
--- a/tests/avocado/machine_m68k_nextcube.py
+++ b/tests/avocado/machine_m68k_nextcube.py
@@ -43,8 +43,8 @@ def check_bootrom_framebuffer(self, screenshot_path):
         #       'displaysurface_create 1120x832' trace-event.
         time.sleep(2)
 
-        self.vm.command('human-monitor-command',
-                        command_line='screendump %s' % screenshot_path)
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screenshot_path)
 
     @skipUnless(PIL_AVAILABLE, 'Python PIL not installed')
     def test_bootrom_framebuffer_size(self):
diff --git a/tests/avocado/machine_mips_malta.py b/tests/avocado/machine_mips_malta.py
index 92233451c5..9bd54518bf 100644
--- a/tests/avocado/machine_mips_malta.py
+++ b/tests/avocado/machine_mips_malta.py
@@ -71,9 +71,9 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
         framebuffer_ready = 'Console: switching to colour frame buffer device'
         wait_for_console_pattern(self, framebuffer_ready,
                                  failure_message='Kernel panic - not syncing')
-        self.vm.command('human-monitor-command', command_line='stop')
-        self.vm.command('human-monitor-command',
-                        command_line='screendump %s' % screendump_path)
+        self.vm.cmd('human-monitor-command', command_line='stop')
+        self.vm.cmd('human-monitor-command',
+                    command_line='screendump %s' % screendump_path)
         logger = logging.getLogger('framebuffer')
 
         match_threshold = 0.95
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
index e7a2a20ba6..e1f493bc44 100644
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/avocado/machine_s390_ccw_virtio.py
@@ -107,10 +107,10 @@ def test_s390x_devices(self):
                         'dd if=/dev/hwrng of=/dev/null bs=1k count=10',
                         '10+0 records out')
         self.clear_guest_dmesg()
-        self.vm.command('device_del', id='rn1')
+        self.vm.cmd('device_del', id='rn1')
         self.wait_for_crw_reports()
         self.clear_guest_dmesg()
-        self.vm.command('device_del', id='rn2')
+        self.vm.cmd('device_del', id='rn2')
         self.wait_for_crw_reports()
         exec_command_and_wait_for_pattern(self,
                         'dd if=/dev/hwrng of=/dev/null bs=1k count=10',
@@ -132,8 +132,8 @@ def test_s390x_devices(self):
                         '0x0000000c')
         # add another device
         self.clear_guest_dmesg()
-        self.vm.command('device_add', driver='virtio-net-ccw',
-                        devno='fe.0.4711', id='net_4711')
+        self.vm.cmd('device_add', driver='virtio-net-ccw',
+                    devno='fe.0.4711', id='net_4711')
         self.wait_for_crw_reports()
         exec_command_and_wait_for_pattern(self, 'for i in 1 2 3 4 5 6 7 ; do '
                     'if [ -e /sys/bus/ccw/devices/*4711 ]; then break; fi ;'
@@ -141,7 +141,7 @@ def test_s390x_devices(self):
                     '0.0.4711')
         # and detach it again
         self.clear_guest_dmesg()
-        self.vm.command('device_del', id='net_4711')
+        self.vm.cmd('device_del', id='net_4711')
         self.vm.event_wait(name='DEVICE_DELETED',
                            match={'data': {'device': 'net_4711'}})
         self.wait_for_crw_reports()
@@ -151,10 +151,10 @@ def test_s390x_devices(self):
         # test the virtio-balloon device
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:         115640 kB')
-        self.vm.command('human-monitor-command', command_line='balloon 96')
+        self.vm.cmd('human-monitor-command', command_line='balloon 96')
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:          82872 kB')
-        self.vm.command('human-monitor-command', command_line='balloon 128')
+        self.vm.cmd('human-monitor-command', command_line='balloon 128')
         exec_command_and_wait_for_pattern(self, 'head -n 1 /proc/meminfo',
                                           'MemTotal:         115640 kB')
 
@@ -245,7 +245,7 @@ def test_s390x_fedora(self):
                 '12+0 records out')
             with tempfile.NamedTemporaryFile(suffix='.ppm',
                                              prefix='qemu-scrdump-') as ppmfile:
-                self.vm.command('screendump', filename=ppmfile.name)
+                self.vm.cmd('screendump', filename=ppmfile.name)
                 ppmfile.seek(0)
                 line = ppmfile.readline()
                 self.assertEqual(line, b"P6\n")
@@ -261,16 +261,16 @@ def test_s390x_fedora(self):
         # Hot-plug a virtio-crypto device and see whether it gets accepted
         self.log.info("Test hot-plug virtio-crypto device")
         self.clear_guest_dmesg()
-        self.vm.command('object-add', qom_type='cryptodev-backend-builtin',
-                        id='cbe0')
-        self.vm.command('device_add', driver='virtio-crypto-ccw', id='crypdev0',
-                        cryptodev='cbe0', devno='fe.0.2342')
+        self.vm.cmd('object-add', qom_type='cryptodev-backend-builtin',
+                    id='cbe0')
+        self.vm.cmd('device_add', driver='virtio-crypto-ccw', id='crypdev0',
+                    cryptodev='cbe0', devno='fe.0.2342')
         exec_command_and_wait_for_pattern(self,
                         'while ! (dmesg -c | grep Accelerator.device) ; do'
                         ' sleep 1 ; done', 'Accelerator device is ready')
         exec_command_and_wait_for_pattern(self, 'lscss', '0.0.2342')
-        self.vm.command('device_del', id='crypdev0')
-        self.vm.command('object-del', id='cbe0')
+        self.vm.cmd('device_del', id='crypdev0')
+        self.vm.cmd('object-del', id='cbe0')
         exec_command_and_wait_for_pattern(self,
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
index fdc1d234fb..09b62f813e 100644
--- a/tests/avocado/migration.py
+++ b/tests/avocado/migration.py
@@ -30,7 +30,7 @@ class MigrationTest(QemuSystemTest):
 
     @staticmethod
     def migration_finished(vm):
-        return vm.command('query-migrate')['status'] in ('completed', 'failed')
+        return vm.cmd('query-migrate')['status'] in ('completed', 'failed')
 
     def assert_migration(self, src_vm, dst_vm):
         wait.wait_for(self.migration_finished,
@@ -41,10 +41,10 @@ def assert_migration(self, src_vm, dst_vm):
                       timeout=self.timeout,
                       step=0.1,
                       args=(dst_vm,))
-        self.assertEqual(src_vm.command('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.command('query-migrate')['status'], 'completed')
-        self.assertEqual(dst_vm.command('query-status')['status'], 'running')
-        self.assertEqual(src_vm.command('query-status')['status'],'postmigrate')
+        self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
+        self.assertEqual(dst_vm.cmd('query-migrate')['status'], 'completed')
+        self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
+        self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
 
     def do_migrate(self, dest_uri, src_uri=None):
         dest_vm = self.get_vm('-incoming', dest_uri)
diff --git a/tests/avocado/pc_cpu_hotplug_props.py b/tests/avocado/pc_cpu_hotplug_props.py
index 52b878188e..b56f51d02a 100644
--- a/tests/avocado/pc_cpu_hotplug_props.py
+++ b/tests/avocado/pc_cpu_hotplug_props.py
@@ -32,4 +32,4 @@ def test_no_die_id(self):
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
         self.vm.launch()
-        self.assertEquals(len(self.vm.command('query-cpus-fast')), 2)
+        self.assertEquals(len(self.vm.cmd('query-cpus-fast')), 2)
diff --git a/tests/avocado/version.py b/tests/avocado/version.py
index dd775955eb..93ffdf3d97 100644
--- a/tests/avocado/version.py
+++ b/tests/avocado/version.py
@@ -20,6 +20,6 @@ class Version(QemuSystemTest):
     def test_qmp_human_info_version(self):
         self.vm.add_args('-nodefaults')
         self.vm.launch()
-        res = self.vm.command('human-monitor-command',
-                              command_line='info version')
+        res = self.vm.cmd('human-monitor-command',
+                          command_line='info version')
         self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
diff --git a/tests/avocado/virtio_check_params.py b/tests/avocado/virtio_check_params.py
index 4093da8a67..f4314ef824 100644
--- a/tests/avocado/virtio_check_params.py
+++ b/tests/avocado/virtio_check_params.py
@@ -51,8 +51,8 @@ def query_virtqueue(self, vm, dev_type_name):
         error = None
         props = None
 
-        output = vm.command('human-monitor-command',
-                            command_line = 'info qtree')
+        output = vm.cmd('human-monitor-command',
+                        command_line = 'info qtree')
         props_list = DEV_TYPES[dev_type_name].values();
         pattern = self.make_pattern(props_list)
         res = re.findall(pattern, output)
@@ -121,7 +121,7 @@ def test_machine_types(self):
         # collect all machine types except 'none', 'isapc', 'microvm'
         with QEMUMachine(self.qemu_bin) as vm:
             vm.launch()
-            machines = [m['name'] for m in vm.command('query-machines')]
+            machines = [m['name'] for m in vm.cmd('query-machines')]
             vm.shutdown()
         machines.remove('none')
         machines.remove('isapc')
diff --git a/tests/avocado/virtio_version.py b/tests/avocado/virtio_version.py
index c84e48813a..afe5e828b5 100644
--- a/tests/avocado/virtio_version.py
+++ b/tests/avocado/virtio_version.py
@@ -48,7 +48,8 @@ def pci_modern_device_id(virtio_devid):
     return virtio_devid + 0x1040
 
 def devtype_implements(vm, devtype, implements):
-    return devtype in [d['name'] for d in vm.command('qom-list-types', implements=implements)]
+    return devtype in [d['name'] for d in
+                       vm.cmd('qom-list-types', implements=implements)]
 
 def get_pci_interfaces(vm, devtype):
     interfaces = ('pci-express-device', 'conventional-pci-device')
@@ -78,7 +79,7 @@ def run_device(self, devtype, opts=None, machine='pc'):
             vm.add_args('-S')
             vm.launch()
 
-            pcibuses = vm.command('query-pci')
+            pcibuses = vm.cmd('query-pci')
             alldevs = [dev for bus in pcibuses for dev in bus['devices']]
             devfortest = [dev for dev in alldevs
                           if dev['qdev_id'] == 'devfortest']
diff --git a/tests/avocado/x86_cpu_model_versions.py b/tests/avocado/x86_cpu_model_versions.py
index a6edf74c1c..9e07b8a55d 100644
--- a/tests/avocado/x86_cpu_model_versions.py
+++ b/tests/avocado/x86_cpu_model_versions.py
@@ -84,7 +84,8 @@ def test_4_0_alias_compatibility(self):
         # with older QEMU versions that didn't have the versioned CPU model
         self.vm.add_args('-S')
         self.vm.launch()
-        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
+        cpus = dict((m['name'], m) for m in
+                    self.vm.cmd('query-cpu-definitions'))
 
         self.assertFalse(cpus['Cascadelake-Server']['static'],
                          'unversioned Cascadelake-Server CPU model must not be static')
@@ -115,7 +116,8 @@ def test_4_1_alias(self):
         self.vm.add_args('-S')
         self.vm.launch()
 
-        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
+        cpus = dict((m['name'], m) for m in
+                    self.vm.cmd('query-cpu-definitions'))
 
         self.assertFalse(cpus['Cascadelake-Server']['static'],
                          'unversioned Cascadelake-Server CPU model must not be static')
@@ -220,7 +222,8 @@ def test_none_alias(self):
         self.vm.add_args('-S')
         self.vm.launch()
 
-        cpus = dict((m['name'], m) for m in self.vm.command('query-cpu-definitions'))
+        cpus = dict((m['name'], m) for m in
+                    self.vm.cmd('query-cpu-definitions'))
 
         self.assertFalse(cpus['Cascadelake-Server']['static'],
                          'unversioned Cascadelake-Server CPU model must not be static')
@@ -246,8 +249,8 @@ class CascadelakeArchCapabilities(avocado_qemu.QemuSystemTest):
     :avocado: tags=arch:x86_64
     """
     def get_cpu_prop(self, prop):
-        cpu_path = self.vm.command('query-cpus-fast')[0].get('qom-path')
-        return self.vm.command('qom-get', path=cpu_path, property=prop)
+        cpu_path = self.vm.cmd('query-cpus-fast')[0].get('qom-path')
+        return self.vm.cmd('qom-get', path=cpu_path, property=prop)
 
     def test_4_1(self):
         """
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index e69d16a62c..da96ca034a 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -77,7 +77,7 @@ def _cpu_timing(self, pid):
             return TimingRecord(pid, now, 1000 * (stime + utime) / jiffies_per_sec)
 
     def _migrate_progress(self, vm):
-        info = vm.command("query-migrate")
+        info = vm.cmd("query-migrate")
 
         if "ram" not in info:
             info["ram"] = {}
@@ -109,7 +109,7 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
         src_vcpu_time = []
         src_pid = src.get_pid()
 
-        vcpus = src.command("query-cpus-fast")
+        vcpus = src.cmd("query-cpus-fast")
         src_threads = []
         for vcpu in vcpus:
             src_threads.append(vcpu["thread-id"])
@@ -128,82 +128,82 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
         if self._verbose:
             print("Starting migration")
         if scenario._auto_converge:
-            resp = src.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "auto-converge",
-                                     "state": True }
-                               ])
-            resp = src.command("migrate-set-parameters",
-                               cpu_throttle_increment=scenario._auto_converge_step)
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "auto-converge",
+                                 "state": True }
+                           ])
+            resp = src.cmd("migrate-set-parameters",
+                           cpu_throttle_increment=scenario._auto_converge_step)
 
         if scenario._post_copy:
-            resp = src.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "postcopy-ram",
-                                     "state": True }
-                               ])
-            resp = dst.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "postcopy-ram",
-                                     "state": True }
-                               ])
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "postcopy-ram",
+                                 "state": True }
+                           ])
+            resp = dst.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "postcopy-ram",
+                                 "state": True }
+                           ])
 
-        resp = src.command("migrate-set-parameters",
-                           max_bandwidth=scenario._bandwidth * 1024 * 1024)
+        resp = src.cmd("migrate-set-parameters",
+                       max_bandwidth=scenario._bandwidth * 1024 * 1024)
 
-        resp = src.command("migrate-set-parameters",
-                           downtime_limit=scenario._downtime)
+        resp = src.cmd("migrate-set-parameters",
+                       downtime_limit=scenario._downtime)
 
         if scenario._compression_mt:
-            resp = src.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "compress",
-                                     "state": True }
-                               ])
-            resp = src.command("migrate-set-parameters",
-                               compress_threads=scenario._compression_mt_threads)
-            resp = dst.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "compress",
-                                     "state": True }
-                               ])
-            resp = dst.command("migrate-set-parameters",
-                               decompress_threads=scenario._compression_mt_threads)
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "compress",
+                                 "state": True }
+                           ])
+            resp = src.cmd("migrate-set-parameters",
+                           compress_threads=scenario._compression_mt_threads)
+            resp = dst.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "compress",
+                                 "state": True }
+                           ])
+            resp = dst.cmd("migrate-set-parameters",
+                           decompress_threads=scenario._compression_mt_threads)
 
         if scenario._compression_xbzrle:
-            resp = src.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "xbzrle",
-                                     "state": True }
-                               ])
-            resp = dst.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "xbzrle",
-                                     "state": True }
-                               ])
-            resp = src.command("migrate-set-parameters",
-                               xbzrle_cache_size=(
-                                   hardware._mem *
-                                   1024 * 1024 * 1024 / 100 *
-                                   scenario._compression_xbzrle_cache))
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "xbzrle",
+                                 "state": True }
+                           ])
+            resp = dst.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "xbzrle",
+                                 "state": True }
+                           ])
+            resp = src.cmd("migrate-set-parameters",
+                           xbzrle_cache_size=(
+                               hardware._mem *
+                               1024 * 1024 * 1024 / 100 *
+                               scenario._compression_xbzrle_cache))
 
         if scenario._multifd:
-            resp = src.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "multifd",
-                                     "state": True }
-                               ])
-            resp = src.command("migrate-set-parameters",
-                               multifd_channels=scenario._multifd_channels)
-            resp = dst.command("migrate-set-capabilities",
-                               capabilities = [
-                                   { "capability": "multifd",
-                                     "state": True }
-                               ])
-            resp = dst.command("migrate-set-parameters",
-                               multifd_channels=scenario._multifd_channels)
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "multifd",
+                                 "state": True }
+                           ])
+            resp = src.cmd("migrate-set-parameters",
+                           multifd_channels=scenario._multifd_channels)
+            resp = dst.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "multifd",
+                                 "state": True }
+                           ])
+            resp = dst.cmd("migrate-set-parameters",
+                           multifd_channels=scenario._multifd_channels)
 
-        resp = src.command("migrate", uri=connect_uri)
+        resp = src.cmd("migrate", uri=connect_uri)
 
         post_copy = False
         paused = False
@@ -228,7 +228,7 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
 
             if progress._status in ("completed", "failed", "cancelled"):
                 if progress._status == "completed" and paused:
-                    dst.command("cont")
+                    dst.cmd("cont")
                 if progress_history[-1] != progress:
                     progress_history.append(progress)
 
@@ -256,13 +256,13 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             if progress._ram._iterations > scenario._max_iters:
                 if self._verbose:
                     print("No completion after %d iterations over RAM" % scenario._max_iters)
-                src.command("migrate_cancel")
+                src.cmd("migrate_cancel")
                 continue
 
             if time.time() > (start + scenario._max_time):
                 if self._verbose:
                     print("No completion after %d seconds" % scenario._max_time)
-                src.command("migrate_cancel")
+                src.cmd("migrate_cancel")
                 continue
 
             if (scenario._post_copy and
@@ -270,7 +270,7 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
                 not post_copy):
                 if self._verbose:
                     print("Switching to post-copy after %d iterations" % scenario._post_copy_iters)
-                resp = src.command("migrate-start-postcopy")
+                resp = src.cmd("migrate-start-postcopy")
                 post_copy = True
 
             if (scenario._pause and
@@ -278,7 +278,7 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
                 not paused):
                 if self._verbose:
                     print("Pausing VM after %d iterations" % scenario._pause_iters)
-                resp = src.command("stop")
+                resp = src.cmd("stop")
                 paused = True
 
     def _is_ppc64le(self):
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index d7e67f4a05..f34af6cef7 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -40,25 +40,25 @@ with iotests.FilePath('img0') as img0_path, \
     def create_target(filepath, name, size):
         basename = os.path.basename(filepath)
         nodename = "file_{}".format(basename)
-        log(vm.command('blockdev-create', job_id='job1',
-                       options={
-                           'driver': 'file',
-                           'filename': filepath,
-                           'size': 0,
-                       }))
+        log(vm.cmd('blockdev-create', job_id='job1',
+                   options={
+                       'driver': 'file',
+                       'filename': filepath,
+                       'size': 0,
+                   }))
         vm.run_job('job1')
-        log(vm.command('blockdev-add', driver='file',
-                       node_name=nodename, filename=filepath))
-        log(vm.command('blockdev-create', job_id='job2',
-                       options={
-                           'driver': iotests.imgfmt,
-                           'file': nodename,
-                           'size': size,
-                       }))
+        log(vm.cmd('blockdev-add', driver='file',
+                   node_name=nodename, filename=filepath))
+        log(vm.cmd('blockdev-create', job_id='job2',
+                   options={
+                       'driver': iotests.imgfmt,
+                       'file': nodename,
+                       'size': size,
+                   }))
         vm.run_job('job2')
-        log(vm.command('blockdev-add', driver=iotests.imgfmt,
-                       node_name=name,
-                       file=nodename))
+        log(vm.cmd('blockdev-add', driver=iotests.imgfmt,
+                   node_name=name,
+                   file=nodename))
 
     log('--- Preparing images & VM ---\n')
     vm.add_object('iothread,id=iothread0')
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index e7e7a2317e..7d3720b8e5 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -160,26 +160,26 @@ class Drive:
         file_node_name = "file_{}".format(basename)
         vm = self.vm
 
-        log(vm.command('blockdev-create', job_id='bdc-file-job',
-                       options={
-                           'driver': 'file',
-                           'filename': self.path,
-                           'size': 0,
-                       }))
+        log(vm.cmd('blockdev-create', job_id='bdc-file-job',
+                   options={
+                       'driver': 'file',
+                       'filename': self.path,
+                       'size': 0,
+                   }))
         vm.run_job('bdc-file-job')
-        log(vm.command('blockdev-add', driver='file',
-                       node_name=file_node_name, filename=self.path))
+        log(vm.cmd('blockdev-add', driver='file',
+                   node_name=file_node_name, filename=self.path))
 
-        log(vm.command('blockdev-create', job_id='bdc-fmt-job',
-                       options={
-                           'driver': fmt,
-                           'file': file_node_name,
-                           'size': size,
-                       }))
+        log(vm.cmd('blockdev-create', job_id='bdc-fmt-job',
+                   options={
+                       'driver': fmt,
+                       'file': file_node_name,
+                       'size': size,
+                   }))
         vm.run_job('bdc-fmt-job')
-        log(vm.command('blockdev-add', driver=fmt,
-                       node_name=name,
-                       file=file_node_name))
+        log(vm.cmd('blockdev-add', driver=fmt,
+                   node_name=name,
+                   file=file_node_name))
         self.fmt = fmt
         self.size = size
         self.node = name
-- 
2.41.0


