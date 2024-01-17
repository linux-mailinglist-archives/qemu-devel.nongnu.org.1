Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC88307B5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:14:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6f6-00052Y-Sm; Wed, 17 Jan 2024 09:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6f5-0004yh-7n; Wed, 17 Jan 2024 09:12:59 -0500
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6f3-0002o5-DA; Wed, 17 Jan 2024 09:12:58 -0500
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7bc32b04d16so414752339f.0; 
 Wed, 17 Jan 2024 06:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500775; x=1706105575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXhcWhDx2TddmKjfU3X1E7OWdRVTkV38ZDTIkwpRXgc=;
 b=jDhDuZbn/fMWH9BWJsLSPmS2zq1GI48EasGvbh3vgU9CbaL+TaCBuvhZL+EHe2o2jG
 PzOWK5H+bYtJsL4rcOetfJY7XZJ83Qx0CuhgTbQPX5VoBmkFx8p0VMIor4cNQ1Zeau9Y
 0tw1ae3Re4gr6LiTNKcP88FZWr5PQsA4lEFi0da+zeobonIFmHVs5512kyrrU2sJqIn3
 R16NwMM2O2flAHcKRm2k8TJC60YRGuNIwhgtTgMgzOjCqg1Ya/ySIrvxd762s5BuaijB
 wbUeEmqK69LvoGUQ52ckOg9GCsbuuq4ovnVoQkqffp+GbaXxhNF10YbGI+Wa1jwyCMaA
 AKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500775; x=1706105575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXhcWhDx2TddmKjfU3X1E7OWdRVTkV38ZDTIkwpRXgc=;
 b=Jrd5rJkoU1+Fht0oGpV8ee+liRZTnx/PeM/X4s29cGGL489BdbOw+mM+lIUaD4MYte
 iHJ4JJe+qJ6RswQR/qmCYRQ1J90XnaBd8y0/LGcCSlH234GKmA2RrPqsdBR1HfXnmFIG
 Y8L6yMKJsw3aLF8LJ2EDqrNwugmXnNleZZMJTD8xJwUUJ7EeRM2T2YHYCp97/Kq2FIF3
 zTp2ysfIp/gR2v5xkEvgelF8QWL5JTuNUd4XIatzJTCixkh8iBwPfMMIE/zSkiNfiAil
 ELoRl753anI/fmRSCYiV+Qc/fFQgGWay0850RED59CAM8+RBE89Dci0y8uDzm45i8H9K
 RLbQ==
X-Gm-Message-State: AOJu0Ywmw52wOKxnK2BEcYA64JC4RUxdaRlmJ+1sm4JGPDJ8al97hWEi
 cjTXaC2RXMrpoBokC36Ne3ARg4v/Zpg=
X-Google-Smtp-Source: AGHT+IFZr21bKuXTCL5szrVAA1cYsGn+XBuQ6aRdswCrf8o37pBKKUXJuz0hrPcwoc1eUjHTJDindg==
X-Received: by 2002:a5e:8619:0:b0:7bc:1bf9:fd83 with SMTP id
 z25-20020a5e8619000000b007bc1bf9fd83mr9693275ioj.3.1705500774908; 
 Wed, 17 Jan 2024 06:12:54 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:12:54 -0800 (PST)
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
Subject: [PATCH v2 3/8] tests/avocado: Enable replay_linux.py on ppc64 pseries
Date: Thu, 18 Jan 2024 00:12:18 +1000
Message-ID: <20240117141224.90462-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd2a.google.com
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
index f3a43dc98c..1408d13eeb 100644
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
@@ -194,3 +195,76 @@ def test_virt_gicv3(self):
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


