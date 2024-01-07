Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6FB826538
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWYG-00042A-Qq; Sun, 07 Jan 2024 12:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWYE-0003nf-G3; Sun, 07 Jan 2024 12:03:06 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWYB-0007eR-RN; Sun, 07 Jan 2024 12:03:06 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso873790a12.0; 
 Sun, 07 Jan 2024 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646981; x=1705251781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+0rM9qJPg4QbTubFG4ojGHqeBLJn3I6TDRx1YClZ58=;
 b=WPhOUb0yDxtvw97w59ztbjcc7l68YHFhnOkAYMe43mKg35ecmp8l/5N/Npw+rJLpvJ
 rlj2NvkteQ8a8twG46nQcl3yndY/jb1KBrdhc+TcSNuL10PJDa/OzqLeE1nVAFDyE6jK
 bsVwWrCewxOfNuTTJLxtdUF/3Zysk0XdDKZDlTos16ythPsKHbMw6TQ8KwTsiG55obKl
 PAlpl/bHpaU+ZHtTgP2/VDZA0YVR6BUj46R2uRqIva7KJVFdTWnMBB/rlt0L9fLu5pwX
 uwq6bWZM+AyEbZuKvxk2z+JDKqUWJ5TXSiSlVzYSP85xkY/TWZNuV8nsJS+o6twUFhL3
 tcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646982; x=1705251782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+0rM9qJPg4QbTubFG4ojGHqeBLJn3I6TDRx1YClZ58=;
 b=aEykk9YRevqoE5BItAtG4y+QIeREqfAu8D+qr1GgfvGQL2958FrGUtGmvqbebhRFBA
 w+zazCUsYnzH+vGUqvobZjqcTORP5Lk93qr5kIBvQcheaVIzNQ7CfK9SSAHlW14vtOcE
 UI2WWzTqoztAc/AgMDSjCDD+wM6Su4jAGqLRLQDhVVE1ZbO1/E0isGnkVM+pgiLYl1Bm
 oDZPPbC/Jm5dIsG1RoZ39IoY8pLhEatcxk+MiyL29XJE4c32VjBgwlKBheqvUSMrTs/Q
 OygnvopsYzVQlCT0Xd3cUugJn/m/Rz0htHT+8FflosQyT9YJjluzcTELQ4O+yC/31FKK
 Miug==
X-Gm-Message-State: AOJu0YzJdnYkw16l6JUQeYD8lxZrLwCkshIje1bkrgEWWkJXw0e9dK89
 kOwSi/XjjUNawbpImQi+tPCedfazzxM=
X-Google-Smtp-Source: AGHT+IH15G21xWxWnA1HQbWfdVHTKPLtH3+2SHgJcyyLk9cPtxGnfzwDVYKFBn/yVWTIAd5PCdBU1w==
X-Received: by 2002:a17:902:e752:b0:1d4:e0e6:694 with SMTP id
 p18-20020a170902e75200b001d4e0e60694mr3656247plf.31.1704646981650; 
 Sun, 07 Jan 2024 09:03:01 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:02:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 8/9] tests/avocado: ppc add hypervisor tests
Date: Mon,  8 Jan 2024 03:01:18 +1000
Message-ID: <20240107170119.82222-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The powernv and pseries machines both provide hypervisor facilities
that are supported by KVM. This is a large and complicated set of
features that don't get much system-level testing in ppc tests.

Add a new test case for these which runs QEMU KVM inside the target.
This downloads an Alpine VM image, boots it and downloads and installs
the qemu package, then boots a virtual machine under it, re-using the
original Alpine VM image.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                   |   1 +
 tests/avocado/ppc_hv_tests.py | 201 ++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)
 create mode 100644 tests/avocado/ppc_hv_tests.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 395f26ba86..ffe91a2bc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1509,6 +1509,7 @@ F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
 F: tests/avocado/ppc_pseries.py
+F: tests/avocado/ppc_hv_tests.py
 
 PowerNV (Non-Virtualized)
 M: Cédric Le Goater <clg@kaod.org>
diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
new file mode 100644
index 0000000000..2162d6bd68
--- /dev/null
+++ b/tests/avocado/ppc_hv_tests.py
@@ -0,0 +1,201 @@
+# Tests that specifically try to exercise hypervisor features of the
+# target machines. powernv supports the Power hypervisor ISA, and
+# pseries supports the nested-HV hypervisor spec.
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado import skipIf, skipUnless
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern, exec_command
+import os
+import time
+import subprocess
+
+deps = ["xorriso"] # dependent tools needed in the test setup/box.
+
+def which(tool):
+    """ looks up the full path for @tool, returns None if not found
+        or if @tool does not have executable permissions.
+    """
+    paths=os.getenv('PATH')
+    for p in paths.split(os.path.pathsep):
+        p = os.path.join(p, tool)
+        if os.path.exists(p) and os.access(p, os.X_OK):
+            return p
+    return None
+
+def missing_deps():
+    """ returns True if any of the test dependent tools are absent.
+    """
+    for dep in deps:
+        if which(dep) is None:
+            return True
+    return False
+
+# Alpine is a light weight distro that supports QEMU. These tests boot
+# that on the machine then run a QEMU guest inside it in KVM mode,
+# that runs the same Alpine distro image.
+# QEMU packages are downloaded and installed on each test. That's not a
+# large download, but it may be more polite to create qcow2 image with
+# QEMU already installed and use that.
+@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+@skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
+@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
+class HypervisorTest(QemuSystemTest):
+
+    timeout = 1000
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
+    panic_message = 'Kernel panic - not syncing'
+    good_message = 'VFS: Cannot open root device'
+
+    def extract_from_iso(self, iso, path):
+        """
+        Extracts a file from an iso file into the test workdir
+
+        :param iso: path to the iso file
+        :param path: path within the iso file of the file to be extracted
+        :returns: path of the extracted file
+        """
+        filename = os.path.basename(path)
+
+        cwd = os.getcwd()
+        os.chdir(self.workdir)
+
+        with open(filename, "w") as outfile:
+            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" %
+                  (iso, path, filename)
+            subprocess.run(cmd.split(),
+                           stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+
+        os.chdir(cwd)
+
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_iso() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir, filename))
+
+    def setUp(self):
+        super().setUp()
+
+        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
+
+        # Alpine use sha256 so I recalculated this myself
+        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
+        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
+                                    algorithm = "sha256")
+
+        self.iso_path = iso_path
+        self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
+        self.initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
+
+    def do_start_alpine(self):
+        self.vm.set_console()
+        self.vm.add_args("-kernel", self.vmlinuz)
+        self.vm.add_args("-initrd", self.initramfs)
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.require_accelerator("tcg")
+
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.vm.add_args("-smp", "4", "-m", "2g")
+        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,id=drive0")
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'localhost login:')
+        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command(self, 'setup-alpine -qe')
+        wait_for_console_pattern(self, 'localhost:~#')
+
+    def do_stop_alpine(self):
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'alpine:~#')
+        self.vm.wait()
+
+    def do_setup_kvm(self):
+        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'apk update')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'apk add qemu-system-ppc64')
+        wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'modprobe kvm-hv')
+        wait_for_console_pattern(self, 'alpine:~#')
+
+    # This uses the host's block device as the source file for guest block
+    # device for install media. This is a bit hacky but allows reuse of the
+    # iso without having a passthrough filesystem configured.
+    def do_test_kvm(self, hpt=False):
+        if hpt:
+            append = 'disable_radix'
+        else:
+            append = ''
+        exec_command(self, 'qemu-system-ppc64 -nographic -smp 2 -m 1g '
+                           '-machine pseries,x-vof=on,accel=kvm '
+                           '-machine cap-cfpc=broken,cap-sbbc=broken,'
+                                    'cap-ibs=broken,cap-ccf-assist=off '
+                           '-drive file=/dev/nvme0n1,format=raw,readonly=on '
+                           '-initrd /media/nvme0n1/boot/initramfs-lts '
+                           '-kernel /media/nvme0n1/boot/vmlinuz-lts '
+                           '-append \'usbcore.nousb ' + append + '\'')
+        # Alpine 3.18 kernel seems to crash in XHCI USB driver.
+        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'localhost login:')
+        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command(self, 'poweroff >& /dev/null')
+        wait_for_console_pattern(self, 'localhost:~#')
+        wait_for_console_pattern(self, 'reboot: Power down')
+        time.sleep(1)
+        exec_command(self, '') # console has strange issue after qemu exit
+        exec_command(self, 'reset')
+        exec_command(self, 'echo VM finished')
+        wait_for_console_pattern(self, 'VM finished')
+
+    def test_hv_pseries(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
+        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_stop_alpine()
+
+    def test_hv_pseries_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
+        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_stop_alpine()
+
+    def test_hv_powernv(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+        self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
+                         '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
+                         '-netdev', 'user,id=net0,hostfwd=::20022-:22,hostname=alpine')
+        self.do_start_alpine()
+        self.do_setup_kvm()
+        self.do_test_kvm()
+        self.do_test_kvm(True)
+        self.do_stop_alpine()
-- 
2.42.0


