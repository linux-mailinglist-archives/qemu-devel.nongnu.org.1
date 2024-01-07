Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971082653E
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWYZ-0006Jd-NB; Sun, 07 Jan 2024 12:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWYX-0006EK-LT; Sun, 07 Jan 2024 12:03:25 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWYV-0007iS-LJ; Sun, 07 Jan 2024 12:03:25 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28cf491b197so310691a91.1; 
 Sun, 07 Jan 2024 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704647001; x=1705251801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gj5wpFqx12ILIOgzmUxgQDtNTX3qdzeAME6ErSpnIOc=;
 b=H/7dwwlh8WBrvkPyRyts4WdhRHoSwa0cx99ls3PjeNugtWHpfUj5byUeMBx0KPp+2o
 6e6M49VBeOqxcpoIXbdOG2ir8j1dJWyMdk0iPAp5I8xsm9HUGZac2UrOfgL3r+fDcKVI
 IBrXXIeIrfsBEj9+sDfrtdrxtrRj3mK8MWF2bwGSv9plAMIDOiyM2jr5Egc2ZAiO1TGx
 uv7fsHjnR5GfLxThMMGSZfLOk+qO1u3JfW4VAwU2IHxoRUZvlho+fozz6Ylk2kbU0+uI
 vsFfwR/cZjhVFG6wWoZ9+xX1WEiJCXfkbXI9sqvw5ZxN8R2YBPkvSU6hFVJ5RniuddDV
 xpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704647001; x=1705251801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gj5wpFqx12ILIOgzmUxgQDtNTX3qdzeAME6ErSpnIOc=;
 b=MavQsN0UYHTRRVvlQiuzlZdCoTB6+X8jnKjuvCn+1FxWHjXU8NtA6yiXxjmSUUTolk
 6+BDfK3sl3Tf6Yv4nEieIztIltG+dSlofoXp0W33Gex69Vqoe0eobEaJphHFwQUFiJxI
 +zBT+otZz0Sa/UxEe/D3Sf78Ibp1o7gN/5UBJVJb8ffK5ci0/1V9hmdXFJ6lcsnqm/ui
 YtgMKalyXkSf3/NJNmpJiNnbwVndFp8FBWHW0+DXb0WLWc9O8n75Mfgctp9tav7P85Bl
 L1uRn++a2bJywrJOqGFeMYeOylU08F7xP4RQgyb1YKLphYr5rIpYl1ahq5KK7j2gNkIn
 fYMQ==
X-Gm-Message-State: AOJu0YynDeVlvPTtmTTt1vFUkv00FVcaf5icp+cccZ1UsryMrbVIOmLN
 AqmfGAnLisSrTrg9vjnt2+oJ8rqxNSQ=
X-Google-Smtp-Source: AGHT+IHHNb6vX3gycWjeWvOKEFKpWnsSPxfHn88iAAyQXuVswJmntJzLIBqTk0q1TL87Y9YXhUJxuQ==
X-Received: by 2002:a17:903:2309:b0:1d4:ca58:8495 with SMTP id
 d9-20020a170903230900b001d4ca588495mr821414plh.108.1704647001247; 
 Sun, 07 Jan 2024 09:03:21 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:03:10 -0800 (PST)
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
 qemu-ppc@nongnu.org, Warner Losh <imp@bsdimp.com>
Subject: [PATCH 9/9] tests/avocado: Add FreeBSD distro boot tests for ppc
Date: Mon,  8 Jan 2024 03:01:19 +1000
Message-ID: <20240107170119.82222-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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
---
Unfortunately the latest stable (14.0) x86-64 VM image does not seem to
output to console by default and I've not been able to find a reliable
way to edit the filesystem to change the boot loader options, or use
console input in the test case to change it on the fly.

Thanks,
Nick
---
 tests/avocado/boot_freebsd.py | 106 ++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 tests/avocado/boot_freebsd.py

diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py
new file mode 100644
index 0000000000..79c68b149a
--- /dev/null
+++ b/tests/avocado/boot_freebsd.py
@@ -0,0 +1,106 @@
+# Functional tests that boot FreeBSD in various configurations
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
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
+@skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
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
+        drive_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/disk.qcow2.zst')
+        drive_hash = '95d863dbbc4b60f4899d1ef21d6489fca05bf03d'
+        drive_path_zstd = self.fetch_asset(drive_url, asset_hash=drive_hash)
+        drive_path = os.path.join(self.workdir, 'disk.qcow2')
+
+        cmd = f"{zstd} -d {drive_path_zstd} -o {drive_path}"
+        process.run(cmd)
+
+        self.drive_opt = f"file={drive_path},format=qcow2,if=virtio"
+
+    def run_pseries_test(self, force_HPT=False):
+        if force_HPT:
+            self.vm.add_args('-m', '4g')
+        else:
+            self.vm.add_args('-m', '1g')
+        self.vm.add_args('-smp', '4')
+        self.vm.add_args('-drive', self.drive_opt)
+        self.vm.add_args('-net', 'nic,model=virtio')
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
+
+    def test_pseries_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.run_pseries_test()
+
+    def test_pseries_hpt_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.run_pseries_test(force_HPT=True)
+
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.run_pseries_test()
+
+    def test_pseries_hpt_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.run_pseries_test(force_HPT=True)
-- 
2.42.0


