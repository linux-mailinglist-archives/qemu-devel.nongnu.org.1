Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9CB955F8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Sep 2025 12:04:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqs-0003ZO-J6; Tue, 23 Sep 2025 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqH-0002tf-Q6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:51 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpx-0000vq-EK
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 85895804AB;
 Tue, 23 Sep 2025 13:01:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-NS8w6Lav; Tue, 23 Sep 2025 13:01:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621683;
 bh=93Nacz31F3vYWBwTltKjooVc2hmLufJ+L0mCrokfsvE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=L9wwfGdQwpwPRwMY+doCDjbxhuOcZ9d2P3XIU1WdwOC0Kqe4P+39DgI7gIdDXLuMd
 D/6D03McB86Q7rm2UADmDLKBVkcZalMThK9sN7FQHxpq0c2OKTDFRQzWdxE7zLrvde
 WKFKGWQsU0FPH7N7guHqbRfR6A5WewSxssv3HenQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 19/19] tests/functional: add test_x86_64_tap_migration
Date: Tue, 23 Sep 2025 13:01:10 +0300
Message-ID: <20250923100110.70862-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add test for a new backend-transfer migration of virtio-net/tap, with fd
passing through unix socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/test_x86_64_tap_migration.py | 344 ++++++++++++++++++
 1 file changed, 344 insertions(+)
 create mode 100644 tests/functional/test_x86_64_tap_migration.py

diff --git a/tests/functional/test_x86_64_tap_migration.py b/tests/functional/test_x86_64_tap_migration.py
new file mode 100644
index 0000000000..5337df8aff
--- /dev/null
+++ b/tests/functional/test_x86_64_tap_migration.py
@@ -0,0 +1,344 @@
+#!/usr/bin/env python3
+#
+# Functional test that tests TAP local migration
+# with fd passing
+#
+# Copyright (c) Yandex Technologies LLC, 2025
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+import subprocess
+from subprocess import run
+import signal
+from typing import Tuple
+
+from qemu_test import (
+    LinuxKernelTest,
+    Asset,
+    exec_command_and_wait_for_pattern,
+)
+from qemu_test.decorators import skipWithoutSudo
+
+GUEST_IP = "10.0.1.2"
+GUEST_IP_MASK = f"{GUEST_IP}/24"
+GUEST_MAC = "d6:0d:75:f8:0f:b7"
+HOST_IP = "10.0.1.1"
+HOST_IP_MASK = f"{HOST_IP}/24"
+TAP_ID = "tap0"
+TAP_MAC = "e6:1d:44:b5:03:5d"
+
+
+def del_tap() -> None:
+    run(
+        ["sudo", "ip", "tuntap", "del", TAP_ID, "mode", "tap", "multi_queue"],
+        check=True,
+    )
+
+
+def init_tap() -> None:
+    run(
+        ["sudo", "ip", "tuntap", "add", "dev", TAP_ID, "mode", "tap", "multi_queue"],
+        check=True,
+    )
+    run(["sudo", "ip", "link", "set", "dev", TAP_ID, "address", TAP_MAC], check=True)
+    run(["sudo", "ip", "addr", "add", HOST_IP_MASK, "dev", TAP_ID], check=True)
+    run(["sudo", "ip", "link", "set", TAP_ID, "up"], check=True)
+
+
+def parse_ping_line(line: str) -> float:
+    # suspect lines like
+    # [1748524876.590509] 64 bytes from 94.245.155.3 \
+    #      (94.245.155.3): icmp_seq=1 ttl=250 time=101 ms
+    spl = line.split()
+    return float(spl[0][1:-1])
+
+
+def parse_ping_output(out) -> Tuple[bool, float, float]:
+    lines = [x for x in out.split("\n") if x.startswith("[")]
+
+    try:
+        first_no_ans = next(
+            (ind for ind in range(len(lines)) if lines[ind][20:26] == "no ans")
+        )
+    except StopIteration:
+        return False, parse_ping_line(lines[0]), parse_ping_line(lines[-1])
+
+    last_no_ans = next(
+        (ind for ind in range(len(lines) - 1, -1, -1) if lines[ind][20:26] == "no ans")
+    )
+
+    return (
+        True,
+        parse_ping_line(lines[first_no_ans]),
+        parse_ping_line(lines[last_no_ans]),
+    )
+
+
+def wait_migration_finish(source_vm, target_vm):
+    migr_events = (
+        ("MIGRATION", {"data": {"status": "completed"}}),
+        ("MIGRATION", {"data": {"status": "failed"}}),
+    )
+
+    source_e = source_vm.events_wait(migr_events)["data"]
+    target_e = target_vm.events_wait(migr_events)["data"]
+
+    source_s = source_vm.cmd("query-status")["status"]
+    target_s = target_vm.cmd("query-status")["status"]
+
+    assert (
+        source_e["status"] == "completed"
+        and target_e["status"] == "completed"
+        and source_s == "postmigrate"
+        and target_s == "paused"
+    ), f"""Migration failed:
+    SRC status: {source_s}
+    SRC event: {source_e}
+    TGT status: {target_s}
+    TGT event:{target_e}"""
+
+
+@skipWithoutSudo()
+class VhostUserBlkFdMigration(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        (
+            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/vmlinuz"
+        ),
+        "d4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129",
+    )
+
+    ASSET_INITRD = Asset(
+        (
+            "https://archives.fedoraproject.org/pub/archive/fedora/linux/releases"
+            "/31/Server/x86_64/os/images/pxeboot/initrd.img"
+        ),
+        "277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b",
+    )
+
+    ASSET_ALPINE_ISO = Asset(
+        (
+            "https://dl-cdn.alpinelinux.org/"
+            "alpine/v3.22/releases/x86_64/alpine-standard-3.22.1-x86_64.iso"
+        ),
+        "96d1b44ea1b8a5a884f193526d92edb4676054e9fa903ad2f016441a0fe13089",
+    )
+
+    def setUp(self):
+        super().setUp()
+
+        init_tap()
+
+        self.outer_ping_proc = None
+
+    def tearDown(self):
+        try:
+            del_tap()
+
+            if self.outer_ping_proc:
+                self.stop_outer_ping()
+        finally:
+            super().tearDown()
+
+    def start_outer_ping(self) -> None:
+        assert self.outer_ping_proc is None
+        self.outer_ping_log = self.scratch_file("ping.log")
+        with open(self.outer_ping_log, "w") as f:
+            self.outer_ping_proc = subprocess.Popen(
+                ["ping", "-i", "0", "-O", "-D", GUEST_IP],
+                text=True,
+                stdout=f,
+            )
+
+    def stop_outer_ping(self) -> str:
+        assert self.outer_ping_proc
+        self.outer_ping_proc.send_signal(signal.SIGINT)
+
+        self.outer_ping_proc.communicate(timeout=5)
+        self.outer_ping_proc = None
+
+        with open(self.outer_ping_log) as f:
+            return f.read()
+
+    def stop_ping_and_check(self, stop_time, resume_time):
+        ping_res = self.stop_outer_ping()
+
+        discon, a, b = parse_ping_output(ping_res)
+
+        if not discon:
+            text = f"STOP: {stop_time}, RESUME: {resume_time}," f"PING: {a} - {b}"
+            if a > stop_time or b < resume_time:
+                self.fail(f"PING failed: {text}")
+            self.log.info(f"PING: no packets lost: {text}")
+            return
+
+        text = (
+            f"STOP: {stop_time}, RESUME: {resume_time}," f"PING: disconnect: {a} - {b}"
+        )
+        self.log.info(text)
+        eps = 0.01
+        if a < stop_time - eps or b > resume_time + eps:
+            self.fail(text)
+
+    def one_ping_from_guest(self, vm) -> None:
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ping -c 1 -W 1 {HOST_IP}",
+            "1 packets transmitted, 1 packets received",
+            "1 packets transmitted, 0 packets received",
+            vm=vm,
+        )
+        self.wait_for_console_pattern("# ", vm=vm)
+
+    def one_ping_from_host(self) -> None:
+        run(["ping", "-c", "1", "-W", "1", GUEST_IP])
+
+    def setup_shared_memory(self):
+        shm_path = f"/dev/shm/qemu_test_{os.getpid()}"
+
+        try:
+            with open(shm_path, "wb") as f:
+                f.write(b"\0" * (1024 * 1024 * 1024))  # 1GB
+        except Exception as e:
+            self.fail(f"Failed to create shared memory file: {e}")
+
+        return shm_path
+
+    def prepare_and_launch_vm(self, shm_path, vhost, incoming=False, vm=None):
+        if not vm:
+            vm = self.vm
+
+        vm.set_console()
+        vm.add_args("-accel", "kvm")
+        vm.add_args("-device", "pcie-pci-bridge,id=pci.1,bus=pcie.0")
+        vm.add_args("-m", "1G")
+
+        vm.add_args(
+            "-object",
+            f"memory-backend-file,id=ram0,size=1G,mem-path={shm_path},share=on",
+        )
+        vm.add_args("-machine", "memory-backend=ram0")
+
+        vm.add_args(
+            "-drive", f"file={self.ASSET_ALPINE_ISO.fetch()},media=cdrom,format=raw"
+        )
+
+        vm.add_args("-S")
+
+        if incoming:
+            vm.add_args("-incoming", "defer")
+
+        vm_s = "target" if incoming else "source"
+        self.log.info(f"Launching {vm_s} VM")
+        vm.launch()
+
+        self.set_migration_capabilities(vm)
+        self.add_virtio_net(vm, vhost)
+
+    def add_virtio_net(self, vm, vhost: bool):
+        netdev_params = {
+            "id": "netdev.1",
+            "vhost": vhost,
+            "type": "tap",
+            "ifname": "tap0",
+            "script": "no",
+            "downscript": "no",
+            "queues": 4,
+            "vnet_hdr": True,
+        }
+
+        vm.cmd("netdev_add", netdev_params)
+
+        vm.cmd(
+            "device_add",
+            driver="virtio-net-pci",
+            romfile="",
+            id="vnet.1",
+            netdev="netdev.1",
+            mq=True,
+            vectors=18,
+            bus="pci.1",
+            mac=GUEST_MAC,
+            disable_legacy="off",
+        )
+
+    def set_migration_capabilities(self, vm):
+        capabilities = [
+            {"capability": "events", "state": True},
+            {"capability": "x-ignore-shared", "state": True},
+        ]
+        vm.cmd("migrate-set-capabilities", {"capabilities": capabilities})
+        vm.cmd("migrate-set-parameters",
+               {"backend-transfer": ["virtio-net-tap"]})
+
+    def setup_guest_network(self) -> None:
+        exec_command_and_wait_for_pattern(self, "ip addr", "# ")
+        exec_command_and_wait_for_pattern(
+            self,
+            f"ip addr add {GUEST_IP_MASK} dev eth0 && ip link set eth0 up && echo OK",
+            "OK",
+        )
+        self.wait_for_console_pattern("# ")
+
+    def do_test_tap_fd_migration(self, vhost):
+        self.require_accelerator("kvm")
+        self.set_machine("q35")
+
+        socket_dir = self.socket_dir()
+        migration_socket = os.path.join(socket_dir.name, "migration.sock")
+
+        shm_path = self.setup_shared_memory()
+
+        self.prepare_and_launch_vm(shm_path, vhost)
+        self.vm.cmd("cont")
+        self.wait_for_console_pattern("login:")
+        exec_command_and_wait_for_pattern(self, "root", "# ")
+
+        self.setup_guest_network()
+
+        self.one_ping_from_guest(self.vm)
+        self.one_ping_from_host()
+        self.start_outer_ping()
+
+        # Get some successful pings before migration
+        time.sleep(0.5)
+
+        target_vm = self.get_vm(name="target")
+        self.prepare_and_launch_vm(shm_path, vhost, incoming=True, vm=target_vm)
+
+        target_vm.cmd("migrate-incoming", {"uri": f"unix:{migration_socket}"})
+
+        self.log.info("Starting migration")
+        freeze_start = time.time()
+        self.vm.cmd("migrate", {"uri": f"unix:{migration_socket}"})
+
+        self.log.info("Waiting for migration completion")
+        wait_migration_finish(self.vm, target_vm)
+
+        target_vm.cmd("cont")
+        freeze_end = time.time()
+
+        self.vm.shutdown()
+
+        self.log.info("Verifying PING on target VM after migration")
+        self.one_ping_from_guest(target_vm)
+        self.one_ping_from_host()
+
+        # And a bit more pings after source shutdown
+        time.sleep(0.3)
+        self.stop_ping_and_check(freeze_start, freeze_end)
+
+        target_vm.shutdown()
+
+    def test_tap_fd_migration(self):
+        self.do_test_tap_fd_migration(False)
+
+    def test_tap_fd_migration_vhost(self):
+        self.do_test_tap_fd_migration(True)
+
+
+if __name__ == "__main__":
+    LinuxKernelTest.main()
-- 
2.48.1


