Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C26859E3B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 09:31:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3G-0000R8-Vy; Mon, 19 Feb 2024 03:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2u-0000KJ-JQ; Mon, 19 Feb 2024 03:30:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz2q-0002Aq-23; Mon, 19 Feb 2024 03:30:38 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d911c2103aso20588405ad.0; 
 Mon, 19 Feb 2024 00:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331432; x=1708936232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zcVzYG/97Y2i91MMCzd4nuy9jQZI+cZ1UCqveYJ9kuo=;
 b=EhFReaUCKsYYOQM31RJtQZXVCmNPBuPUdoZLYKKnwzU/T9UbDa0jrYkpG95/99AUAZ
 0QmQwu29sGQRGBXmPSt1n9CNmQd71j4UJaYVC6+ym+pnsX0WQ0mNOXyhEstISkTEqVfx
 S/sJZ8nGF2+cBi7nxImrEDBXrYga8d0A7dH/Fdu/h8yU3zAJP/x8HoVv4emUMWsI2dnV
 T0JBweIjkz5edPkDfRdznipWd4h8uUhO7W6IUpfi6FXxlGjZcQn1Bx2FA7FK8vviPOB5
 0dewc/WriCKB7wEhpBYv2v50ebWaVwIu3gUj9VKjnnixXrEsc4jWd8/iKcAbmMpP8smC
 Zm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331432; x=1708936232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcVzYG/97Y2i91MMCzd4nuy9jQZI+cZ1UCqveYJ9kuo=;
 b=qRU1X1Yq8BCgOwTlairG9VHgpFXTsrd+6y+RgfIZ9YEnckPEMMHgjueI3ZZBd9EIhl
 3dz29hWcPJRno15eZRr2a1WGWRTsI/MVIpi+kbLWSJDVx5E8KgR1AbBxNM5VPHvHPYXK
 tPLAZ1JBntUr9x4cSxEeFgmZj607A9x/xWQM6TVfTgQCSGUPEy10VGJFNEvBTw30WE05
 FeENIKaDcS9qQ9Wnjc77IvsUsUYyG64Vrqgr7/0AsIFsMw+i9JYREXZH9hOVuRFI2y1P
 XcQb/Z0g2Mg6YvlR6MpfUVWvPfG2Y1zLWtPhdjV7tbo2Z1gFCCbqQwmQiThtkw1WeGTz
 Ghig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0QD+/9XkN5t+Qjjri0iktP82ChLEVfnCNpkgl8SMpyVXoQgM+XWzRpM3HYFoUxa2yU87qLkFnbuOduiRv2uPXqiXn
X-Gm-Message-State: AOJu0Yy4+eU4Nt4Kw1eXpdVL0kqkcDGJFwLu/RPQNl/kfhRg8Q7ZgS2Y
 Q9+jrqoqcmF88ugzapOz00CN7BQJgAh+SzI4r/iTMaTkz5IJdnKiYb2iIQK5
X-Google-Smtp-Source: AGHT+IFR3+2059ZhE/wRYiT/met58WbVIhNcjYUrMRpndaFGE0WMXz+HX7xoAcGvpp7LCRtesVbs8g==
X-Received: by 2002:a17:903:22ca:b0:1db:cbff:f7d6 with SMTP id
 y10-20020a17090322ca00b001dbcbfff7d6mr4150794plg.44.1708331432534; 
 Mon, 19 Feb 2024 00:30:32 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:30:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Warner Losh <imp@bsdimp.com>
Subject: [PULL 09/49] tests/avocado: Add FreeBSD distro boot tests for ppc
Date: Mon, 19 Feb 2024 18:28:58 +1000
Message-ID: <20240219082938.238302-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

FreeBSD project provides qcow2 images that work well for testing QEMU.
Add pseries tests for HPT and Radix, KVM and TCG. This uses a short
term VM image, because FreeBSD has not set up long term builds for
ppc64 at present.

Other architectures could be added so this does not get a ppc_ prefix
but is instead named similarly to boot_linux.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Unfortunately the latest stable (14.0) x86-64 VM image does not seem to
output to console by default and I've not been able to find a reliable
way to edit the filesystem to change the boot loader options, or use
console input in the test case to change it on the fly.
---
 tests/avocado/boot_freebsd.py | 174 ++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 tests/avocado/boot_freebsd.py

diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py
new file mode 100644
index 0000000000..c01cd06cca
--- /dev/null
+++ b/tests/avocado/boot_freebsd.py
@@ -0,0 +1,174 @@
+# Functional tests that boot FreeBSD in various configurations
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+import subprocess
+
+from avocado import skipUnless
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+from avocado_qemu import exec_command
+from avocado.utils import archive
+from avocado.utils import process
+from avocado.utils.path import find_command
+
+@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+class BootFreeBSDPPC64(QemuSystemTest):
+    """
+    :avocado: tags=arch:ppc64
+    """
+
+    timeout = 360
+
+    def setUp(self):
+        super().setUp()
+
+        # We need zstd for all the tests
+        # See https://github.com/avocado-framework/avocado/issues/5609
+        zstd = find_command('zstd', False)
+        if zstd is False:
+            self.cancel('Could not find "zstd", which is required to '
+                        'decompress rootfs')
+        tar = find_command('tar', False)
+        if tar is False:
+            self.cancel('Could not find "tar", which is required to '
+                        'decompress rootfs')
+
+        drive_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/disk.qcow2.zst')
+        drive_hash = '95d863dbbc4b60f4899d1ef21d6489fca05bf03d'
+        drive_path_zstd = self.fetch_asset(drive_url, asset_hash=drive_hash)
+        self.drive_path = os.path.join(self.workdir, 'disk.qcow2')
+
+        cmd = f"{zstd} -d {drive_path_zstd} -o {self.drive_path}"
+        process.run(cmd)
+
+        kernel_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/kernel.txz')
+        kernel_hash = '31d14c2dc658858830a7acab5128a5b91ea548cf'
+        kernel_path_txz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.kernel_path = os.path.join(self.workdir, 'kernel')
+
+        with open(self.kernel_path, "w") as outfile:
+            cmd = f"{tar} OJxf {kernel_path_txz} ./boot/kernel/kernel"
+            subprocess.run(cmd.split(), stdout=outfile)
+
+    def set_pseries_devices(self):
+        self.vm.add_args('-drive', f"file={self.drive_path},format=qcow2,if=virtio")
+        self.vm.add_args('-net', 'nic,model=virtio')
+
+    def set_powernv_devices(self):
+        self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
+                         '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
+                         '-netdev', 'user,id=net0,hostfwd=::20022-:22,hostname=freebsd')
+        self.vm.add_args("-drive", f"file={self.drive_path},format=qcow2,if=none,id=drive0")
+        self.vm.add_args("-kernel", self.kernel_path)
+
+    def run_pseries_test(self, force_HPT=False):
+        if force_HPT:
+            self.vm.add_args('-m', '4g')
+        else:
+            self.vm.add_args('-m', '1g')
+        self.vm.add_args('-smp', '4')
+        self.set_pseries_devices()
+        self.vm.set_console()
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'Hit [Enter] to boot immediately, or any other key for command prompt.')
+        if force_HPT:
+            exec_command(self, 'x')
+            wait_for_console_pattern(self, 'OK')
+            exec_command(self, 'set radix_mmu=0')
+            exec_command(self, 'boot')
+            wait_for_console_pattern(self, 'cas: selected hash MMU', 'panic:')
+        else:
+            exec_command(self, '')
+            wait_for_console_pattern(self, 'cas: selected radix MMU', 'panic:')
+
+        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT', 'panic:')
+        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs', 'panic:')
+        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'resizewin: timeout reading from terminal')
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'Uptime:', 'panic:')
+        self.vm.wait()
+
+    # powernv does not have a bootloader so must load the kernel directly
+    # and work around manual specification of the root device. Also can't
+    # specify options like radix_mmu the same way (todo: work out how it
+    # is done, and add HPT test).
+    def run_powernv_test(self, force_HPT=False):
+        self.vm.add_args('-m', '8g')
+        self.vm.add_args('-smp', '4')
+        self.set_powernv_devices()
+        self.vm.set_console()
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT', 'panic:')
+        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs', 'panic:')
+        wait_for_console_pattern(self, '<empty line>    Abort manual input')
+        exec_command(self, 'ufs:diskid/DISK-1234s3')
+
+        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
+        exec_command(self, 'root')
+        wait_for_console_pattern(self, 'resizewin: timeout reading from terminal')
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'Uptime:', 'panic:')
+        wait_for_console_pattern(self, 'OPAL: Shutdown request', 'panic:')
+        self.vm.wait()
+
+    def test_pseries_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.vm.add_args("-cpu", "power10")
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.run_pseries_test()
+
+    def test_pseries_hpt_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.run_pseries_test(force_HPT=True)
+
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.run_pseries_test()
+
+    def test_pseries_hpt_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.vm.add_args("-accel", "kvm")
+        self.run_pseries_test(force_HPT=True)
+
+    # powernv9 works, powernv10 fails
+    def test_powernv(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv9
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.vm.add_args("-accel", "tcg,thread=multi")
+        self.run_powernv_test()
-- 
2.42.0


