Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 580657BF4EC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YJ-0004wu-Bh; Tue, 10 Oct 2023 03:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YA-0004db-Vt; Tue, 10 Oct 2023 03:53:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7Y8-0005HT-PN; Tue, 10 Oct 2023 03:53:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-692d2e8c003so4670019b3a.1; 
 Tue, 10 Oct 2023 00:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924383; x=1697529183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KpFJaUa6C+kEpWe/K0V38sdkDOIqd7glVdiqnCv3zc=;
 b=Jjy4cjLg7x4WYsRE3tK8qN0UrMdN7RUvTooVTHXPUDQkXiley57GEY3EcMexbDzqKc
 YqWu0P/60nJNqb7skyzJS5WhQfW7wtFG1V2VubsJi64QmE4GltUieY9xigU+7NcFddM4
 UoTnwBtZRoXOo8RhQs1CViXeeVIWpQB29RHIhCAeO4DcaZbeg/Wt1TN2lFlwOIwIImp8
 kxbarbSzxvWsz1EBRIaZSRW6nOSd2bWNEmUkvYvFiBR0X+7pz9NCkQ8iyOG3OdufzFBZ
 scdkSicviSKMl8dqqwRbskbt5Wttcz/EWTD0lN7EP5JdAwypZrWaf4ymkFkfyCvEwIor
 Gjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924383; x=1697529183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KpFJaUa6C+kEpWe/K0V38sdkDOIqd7glVdiqnCv3zc=;
 b=Dzggs8ozPLa0O1bjwbNkMj1uhtw0n5CyV5rYV0CMcWsK4GNITnr5HCppFutZa6qNcL
 ePbnjIlg3NiimDM9eo+LGt6iplrUEdktChupeF7PHInrVevlzBQngzx9USP3Wp3Bby/x
 wE9lfQUs1/p+qA/k1GJ17lX5OwOYzY5+AVMJxDXXFlZJe94EMhFlRZgyM3YrkpyhvBx7
 SEpr4xksO9+fl/lnVK5h25TOFOOEl5pN55jQGpIGSzcg3/TlJ+BzOaZWIUy1mVEAaiJL
 zqGMEvAHPS0KInHMTXwt13IhKFf0m9nl98mq6mzevt1hi4IDJund8gwEl0m0fwHN+q5c
 6mwA==
X-Gm-Message-State: AOJu0Yx0FUUpiy1ZiY6lhcw8LLHWLySeTqMt3wNvU/h4EKMEDq0GYR0T
 wVmpIO5R5zaZq+BBgTwp5sDqTyZpUIM=
X-Google-Smtp-Source: AGHT+IFfEh/MnNmOiX/0yd818trsgjzupkLNvORDhtgjTcRjEp1z6bIkw007XhbwXc7H2oy7e+La9A==
X-Received: by 2002:a05:6a20:8e28:b0:140:d536:d434 with SMTP id
 y40-20020a056a208e2800b00140d536d434mr22360904pzj.10.1696924382867; 
 Tue, 10 Oct 2023 00:53:02 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 04/11] tests/avocado: ppc add hypervisor tests
Date: Tue, 10 Oct 2023 17:52:31 +1000
Message-ID: <20231010075238.95646-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The powernv and pseries machines both provide hypervisor facilities,
which is a large and complicated set of features that don't get much
system testing in CI.

Add a new test case for these which runs QEMU KVM inside the target.
---
 tests/avocado/ppc_hv_tests.py | 173 ++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 tests/avocado/ppc_hv_tests.py

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
new file mode 100644
index 0000000000..16aac1d35d
--- /dev/null
+++ b/tests/avocado/ppc_hv_tests.py
@@ -0,0 +1,173 @@
+# Tests that specifically try to exercise hypervisor features of the
+# target machines. powernv supports the Power hypervisor ISA, and
+# pseries supports the nested-HV hypervisor spec.
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado import skipIf
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern, exec_command
+import os
+import time
+import subprocess
+
+# Alpine is a light weight distro that supports QEMU. These tests boot
+# that on the machine then run a QEMU guest inside it in KVM mode,
+# that runs the same Alpine distro image.
+# QEMU packages are downloaded and installed on each test. That's not a
+# large download, but it may be more polite to create qcow2 image with
+# QEMU already installed and use that.
+class HypervisorTest(QemuSystemTest):
+
+    timeout = 600
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
+            cmd = "isoinfo -i %s -R -x %s" % (iso, path)
+            subprocess.run(cmd.split(), stdout=outfile)
+
+        os.chdir(cwd)
+
+        # Return complete path to extracted file.  Because callers to
+        # extract_from_iso() specify 'path' with a leading slash, it is
+        # necessary to use os.path.relpath() as otherwise os.path.join()
+        # interprets it as an absolute path and drops the self.workdir part.
+        return os.path.normpath(os.path.join(self.workdir, filename))
+
+    def do_start_alpine(self):
+        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
+
+        # Alpine use sha256 so I recalculated this myself
+        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
+        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
+                                    algorithm = "sha256")
+
+        vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
+        initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
+
+        self.vm.set_console()
+        self.vm.add_args("-kernel", vmlinuz)
+        self.vm.add_args("-initrd", initramfs)
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=hvc0')
+        self.require_accelerator("tcg")
+
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.vm.add_args("-smp", "4", "-m", "2g")
+        self.vm.add_args("-drive", f"file={iso_path},format=raw,if=none,id=drive0")
+#        self.vm.add_args("-drive", f"file={iso_path},format=raw")
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
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
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
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
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
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
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


