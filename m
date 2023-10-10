Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED77BF4F3
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YL-0005C2-NE; Tue, 10 Oct 2023 03:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YI-0004wc-Q3; Tue, 10 Oct 2023 03:53:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YG-0005Ib-St; Tue, 10 Oct 2023 03:53:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-69fc829d7b1so2322084b3a.1; 
 Tue, 10 Oct 2023 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924390; x=1697529190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HUbZ3BEaIDQPcjinhz07GtBsmP9XjGNwVpI8n08oeI=;
 b=MZVTgSBn6usBtBbmwwpRib3tVs36RxYpxp0TqjvKNtpFOFBglu652BwMkZPmG0b/ke
 EmJcQN2rwW2/MSc3QtQ4XDNvqM/dDYtTFNjR3yUPiIhJGnbmh2wAZL1OSLVe5cqq2Itz
 eKNslsRhwETKNWAehUTc2vrcSX7sp2PNiCzzrPpRfz+8vy9GvAca+aV6lUt1hpq9EKv+
 FYP1XemFB6OMt5P+k9PCElLu8l10Tz+5grr3DfxoEcLrPHlVTUjB3H5VFsuciL7dwxVO
 zLtiGQXHI5uwum3XZUAOcBL4onm4zHbiAMszhULNfpxeqqMoHsQbLH4JN/jD0WfdjhOP
 p5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924390; x=1697529190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HUbZ3BEaIDQPcjinhz07GtBsmP9XjGNwVpI8n08oeI=;
 b=vQUNM+WvwnVauqT6doSpxRVJ1uAjQl8lQVVvm9zGeue8uU3YkUT1th6qEAR8Oc/QyK
 58n1Lx9GgVFErwjgowaAzYqBeKZTDC7QS2vdwpHdlJZgW6vD9max1mukT9rUo95zRqKK
 ZdKLXENqbOQ9RuWDUWs5Nju/fAX2Br3c8xqC915yUU3IyVkDqSZTKxxaMATaY7jMT5Sc
 Hg30uqOqC5pVTxX/1prYHSlD1g0ThQ9UpVcUp9DTjb+Amyb+HGHJQpJZVi5/yUD3IfYF
 wW00sZdNsJs0NAfVHH6jmQWgNjNc9BA/ubJ/nFhWezwpMDvvDKHgX+h9ZUsPpe6/JLWE
 Mg0g==
X-Gm-Message-State: AOJu0YxoXU5nAPolGGU7+DTwZXiRa0wPmKqyZQbYDMsZ6RfjBNoh0t2b
 6UnYWkNK9IDKkxat7s3IVxIpTQvqO4M=
X-Google-Smtp-Source: AGHT+IERyVgKMM7QeIBkJ99lcWv5MIr6x+un5MXHC9f+zKGh507QnPNlb+bHCAqcC8GAfux8ltOyoQ==
X-Received: by 2002:a05:6a00:1da2:b0:69f:1791:70b with SMTP id
 z34-20020a056a001da200b0069f1791070bmr8574619pfw.34.1696924390520; 
 Tue, 10 Oct 2023 00:53:10 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [RFC PATCH 06/11] tests/avocado: Add FreeBSD distro boot tests for ppc
Date: Tue, 10 Oct 2023 17:52:33 +1000
Message-ID: <20231010075238.95646-7-npiggin@gmail.com>
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

FreeBSD project provides qcow2 images that work well for testing QEMU.
Add pseries tests for HPT and Radix, KVM and TCG.

Other architectures could be added so this does not get a ppc_ prefix
but is instead named similarly to boot_linux.

Cc: Warner Losh <imp@bsdimp.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

CC'ing Warner to check if it's okay for us to use these images and
any comments or suggestions. avocado tests have many Linux boots so we'd
do much better to expand test coverage by adding some other systems.
---
 tests/avocado/boot_freebsd.py | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 tests/avocado/boot_freebsd.py

diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py
new file mode 100644
index 0000000000..9a499a28ad
--- /dev/null
+++ b/tests/avocado/boot_freebsd.py
@@ -0,0 +1,109 @@
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
+from avocado import skipIf
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+from avocado_qemu import exec_command
+from avocado.utils import archive
+from avocado.utils import process
+from avocado.utils.path import find_command
+
+class BootFreeBSDPPC64(QemuSystemTest):
+    """
+    :avocado: tags=arch:ppc64
+    """
+
+    timeout = 360
+
+    def run_pseries_test(self, force_HPT=False):
+        # We need zstd for all the tuxrun tests
+        # See https://github.com/avocado-framework/avocado/issues/5609
+        zstd = find_command('zstd', False)
+        if zstd is False:
+            self.cancel('Could not find "zstd", which is required to '
+                        'decompress rootfs')
+        self.zstd = zstd
+
+        drive_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/a2440348eed75bb7682579af0905b652747fd016/powerpc/powerpc64le/disk.qcow2.zst')
+        drive_hash = '8ab11a05ccab3d44215fd4667a70454ed10a203f'
+        drive_path_zstd = self.fetch_asset(drive_url, asset_hash=drive_hash)
+        drive_path = os.path.join(self.workdir, 'disk.qcow2')
+        # archive.zstd_uncompress(drive_path_zstd, drive_path)
+
+        cmd = f"{self.zstd} -d {drive_path_zstd} -o {drive_path}"
+        process.run(cmd)
+
+        drive = f"file={drive_path},format=qcow2,if=virtio"
+
+        self.vm.set_console()
+        if force_HPT:
+            self.vm.add_args('-m', '4g')
+        else:
+            self.vm.add_args('-m', '1g')
+        self.vm.add_args('-smp', '4')
+        self.vm.add_args('-drive', drive)
+        self.vm.add_args('-net', 'nic,model=virtio')
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
+            wait_for_console_pattern(self, 'cas: selected radix MMU')
+
+        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT #0 a244034: Mon Sep 25 02:05:22 UTC 2023', 'panic:')
+        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs')
+        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
+
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_pseries_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.run_pseries_test()
+
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_pseries_hpt_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.run_pseries_test(force_HPT=True)
+
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_pseries_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.run_pseries_test()
+
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
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


