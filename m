Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA8826537
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWXV-0001GX-SP; Sun, 07 Jan 2024 12:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXS-0001FW-Ja; Sun, 07 Jan 2024 12:02:18 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXJ-0007YF-On; Sun, 07 Jan 2024 12:02:18 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d427518d52so6946315ad.0; 
 Sun, 07 Jan 2024 09:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646927; x=1705251727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kj6bMelHOZKOZ/ZOY2z83t9J8QZg9iW/5VS5Z2WSRII=;
 b=G17vmy3QqiLXTpbPNyw4Qk87++x8QwT52INeF2vdDkV5GnzcjsW6VQSsrckLr1dXPT
 XmCU9KxtQLg2JQjKKqx36y6FNmBPy9teSRbpyMhBBtNNdRi0sBKru9u6paIGMqO9bzwh
 jlGolevMzOKzScOcNliX3IgGOOWhrqTjeIBhfbe0vG3Jx8PELMmsF4sYxt1fRVm9L/th
 CZWKZ1Ebh3yGsKhe33If83VDumKTNZkbSnU0ixMaEMT1MjZp/PV22Ud2sY2UBqT1rL/7
 znUV3HI6n560qPno35WlrfVSqf5Yy36Qdc1oo+YoeBHV0bTD6ayAku8H5ym/MYfxLzpa
 wW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646927; x=1705251727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kj6bMelHOZKOZ/ZOY2z83t9J8QZg9iW/5VS5Z2WSRII=;
 b=Yu69mNDIkdU44GS8kUvUioz19agfGMVSJQNGrJQUAHsjdCgk/9RFqIP6/BnSUM97Rm
 NQL47dQxb3FWKeKj2zIZqVQBIuRXdNOxikR/uUyGose+UzbA4K1B8kDS6zVHD3nMbqTS
 3nlj/8ukpG4XQajPqOTfwnXpZMftpqFNXElFRgSvzm9ePLwW8XVxa8fNqQLEE3aScPVe
 ap+8f8LPGqwnXejW/SBtOce1HcRXC1cfd6jn+6U3qblvfk5UIYGVKEmTbSnsWxrqpNht
 oDufd3RVtiJZ8o8uGEQB3kNpAQ7/N3dcxU/o0hLO+uHYQ9ScBijsakk1slCkKOHhvnQT
 xFww==
X-Gm-Message-State: AOJu0YzkhBW5hF1MZImBl487jUYpNfs9+dpGyL9NH5p9WfM7pqvzl2Zw
 vvc7W+Mo5Jl8WPONfrbwZTv5Rpw//g0=
X-Google-Smtp-Source: AGHT+IGqvRMVvyZedFAjJWc+B9puN2iImBgdWGvzV/n/tqwDvaLTsPDUVJh8BNTVucRIGG2FiqR8Vw==
X-Received: by 2002:a17:902:d48e:b0:1d4:df39:687a with SMTP id
 c14-20020a170902d48e00b001d4df39687amr3286523plg.14.1704646927596; 
 Sun, 07 Jan 2024 09:02:07 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:02:03 -0800 (PST)
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
Subject: [PATCH 4/9] tests/avocado: Enable replay_linux.py on ppc64 pseries
Date: Mon,  8 Jan 2024 03:01:14 +1000
Message-ID: <20240107170119.82222-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

Add a ppc64 pseries test. This tends to hang in the replay phase near
the end of the trace due to a missing event, so it is marked flaky.

spapr-vscsi IO is extremely slow when running in record-replay modes,
particularly when driven by SLOF. This causes tests to time-out even
after an hour, so this uses guestfish to extract the kernel and initrd
and boot them directly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 76 ++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 270ccc1eae..82daba9f3f 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -11,8 +11,9 @@
 import os
 import logging
 import time
+import subprocess
 
-from avocado import skipUnless
+from avocado import skipIf, skipUnless
 from avocado_qemu import BUILD_DIR
 from avocado.utils import cloudinit
 from avocado.utils import network
@@ -191,3 +192,76 @@ def test_virt_gicv3(self):
         self.run_rr(shift=3,
                     args=(*self.get_common_args(),
                           "-machine", "virt,gic-version=3"))
+
+# ppc64 pseries test.
+#
+# This machine tends to fail replay and hang very close to the end of the
+# trace, with missing events, which is still an open issue.
+#
+# spapr-scsi IO driven by SLOF/grub is extremely slow in record/replay mode,
+# so jump through some hoops to boot the kernel directly. With this, the test
+# runs in about 5 minutes (modulo hang), which suggests other machines may
+# have similar issues and could benefit from bypassing bootloaders.
+#
+ppc_deps = ["guestfish"] # dependent tools needed in the test setup/box.
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
+def ppc_missing_deps():
+    """ returns True if any of the test dependent tools are absent.
+    """
+    for dep in ppc_deps:
+        if which(dep) is None:
+            return True
+    return False
+
+@skipIf(ppc_missing_deps(), 'dependencies (%s) not installed' % ','.join(ppc_deps))
+@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'known failure in trace replay')
+class ReplayLinuxPPC64(ReplayLinux):
+    """
+    :avocado: tags=arch:ppc64
+    :avocado: tags=accel:tcg
+    """
+
+    hdd = 'scsi-hd'
+    cd = 'scsi-cd'
+    bus = None
+
+    def setUp(self):
+        super().setUp()
+
+        # kernel, initramfs, and kernel cmdline are all taken by hand from
+        # the Fedora image.
+        self.kernel="vmlinuz-5.3.7-301.fc31.ppc64le"
+        self.initramfs="initramfs-5.3.7-301.fc31.ppc64le.img"
+        cmd = "guestfish --ro -a %s run "
+              ": mount /dev/sda2 / "
+              ": copy-out /boot/%s %s "
+              ": copy-out /boot/%s %s "
+              % (self.boot_path, self.kernel, self.workdir,
+                 self.initramfs, self.workdir)
+        subprocess.run(cmd.split())
+
+    def test_pseries(self):
+        """
+        :avocado: tags=machine:pseries
+        """
+        kernel=os.path.normpath(os.path.join(self.workdir, self.kernel))
+        initramfs=os.path.normpath(os.path.join(self.workdir, self.initramfs))
+        cmdline="root=UUID=8a409ee6-3cb3-4b06-a266-39e2dae3e5fa ro "
+                "no_timer_check net.ifnames=0 console=tty1 "
+                "console=ttyS0,115200n8"
+        self.run_rr(shift=1, args=("-device", "spapr-vscsi",
+                                   "-machine", "x-vof=on",
+                                   "-kernel", kernel,
+                                   "-initrd", initramfs,
+                                   "-append", cmdline))
-- 
2.42.0


