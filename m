Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97726826535
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWXF-0000vL-W5; Sun, 07 Jan 2024 12:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXD-0000tr-Jr; Sun, 07 Jan 2024 12:02:03 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXB-0007PZ-Lo; Sun, 07 Jan 2024 12:02:03 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3606dc4fdf2so8549935ab.0; 
 Sun, 07 Jan 2024 09:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646919; x=1705251719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VTKTEfNoVO9bVyk+W0ucnkOnsixCuWHxy7rwA2EEgo=;
 b=YnldBlBn+gtTQIWOxyKi/iU9zJXYHRXNG0lhm02eJW0kP/0dG6iRQ0CfbFEwcQIy0P
 e5yU5A17qK7JuDcmT208pKjM7okWXk+YWoTtodIONk3VdZZX83OiIdPgQSB2lmO4ZHDJ
 0dCLOnzkIzcZAmhTkMXrYkKCod66nShJD6duoy+w56DZKvO7PTP5HWzE/0RhLd+BVoP/
 02g2mHCrdqua94RPaLafYBRvvVT1QlgXeaL6VhXEFbB0kz2P/zBxwEs9YoYmZpAHf3n6
 F0/sN/BVzu7CC4hB0wwbR5lMmowDGb6jtV2WDiumZAExdp1cf7+6HchaAXpOvIbSO5db
 REow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646919; x=1705251719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VTKTEfNoVO9bVyk+W0ucnkOnsixCuWHxy7rwA2EEgo=;
 b=Vgk8mflE/OOgumOnGNfOYZmnl8ykcBy75xKG5rCke2CArkHGRVbZGqjG6vLOHvAKv3
 awm37JgEdP8L2h1ZcwzPj4ByO299Hfgl/J3yde44/i+vtssLy2WE1sTMbsKi7PEHb7SE
 i4soAiRXCyWwuDrrV4dxq+NA9+ZDrYlomWXsaMbMHlcBeUsEgk7qEQrLBLCnVvi/FEDK
 wKeGcVSTOFxMqZOqfhyyemdixFGcxazzv514UdqJCtpCGV+FmQLqp6WxzIxxIYhtf1A/
 41CTyGn0DIoykUUQE2Hu5/OXbCvsSEUosxs/3Q1ORMC4ypaDu0283jxB6S8OIESyqEzW
 behQ==
X-Gm-Message-State: AOJu0YxgMPKmRdw6L4aWfwyYYomiVbp3Rk1yQJyyhv8uNtl2ggtIDBp7
 qLBFhb65F6XuoOR3mEYkbg7U+/Fat98=
X-Google-Smtp-Source: AGHT+IHdoJAYW1Ki2NzNk3oXJbZghk3GbA8Mc6g+5AigdPkacEAYnD4BIG4A7yMgqRJFdogrsZDQuA==
X-Received: by 2002:a05:6e02:152a:b0:35f:cc60:6245 with SMTP id
 i10-20020a056e02152a00b0035fcc606245mr4906915ilu.2.1704646918631; 
 Sun, 07 Jan 2024 09:01:58 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:01:56 -0800 (PST)
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
Subject: [PATCH 3/9] tests/avocado: Mark x86-64 boot_linux.py TCG tests as
 long runtime
Date: Mon,  8 Jan 2024 03:01:13 +1000
Message-ID: <20240107170119.82222-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12a.google.com
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

Re-testing gitlab CI shows the x86-64 TCG tests take ~100s each, are
the longest-running tests. They are close to the ~150s taken by the
disabled ppc64 and s390x tests. From avocado-system-centos:

  boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg:  PASS (112.34 s)
  boot_linux.py:BootLinuxX8664.test_pc_q35_tcg:  PASS (97.05 s)
  boot_linux.py:BootLinuxPPC64.test_pseries_tcg:  PASS (148.86 s)
  boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg:  PASS (149.83 s)

So disable the x86-64 tests as well.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

The other way we could go is enabling them all since ppc64 and s390s are
now much faster than when they were originally disabled; or to only
enable q35, giving at least one boot_linux.py test.

[Test time results from here https://gitlab.com/npiggin/qemu/-/jobs/5842257510]

Thanks,
Nick
---
 tests/avocado/boot_linux.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 6df0fc0489..a4a78122ac 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -14,6 +14,9 @@
 
 from avocado import skipUnless
 
+# We don't run TCG tests in CI, as booting the current Fedora OS in TCG tests
+# is very heavyweight (~100s per test). There are lighter weight distros which
+# we use in the machine_aarch64_virt.py, tux_baseline.py, etc.
 
 class BootLinuxX8664(LinuxTest):
     """
@@ -21,6 +24,7 @@ class BootLinuxX8664(LinuxTest):
     """
     timeout = 480
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_pc_i440fx_tcg(self):
         """
         :avocado: tags=machine:pc
@@ -39,6 +43,7 @@ def test_pc_i440fx_kvm(self):
         self.vm.add_args("-accel", "kvm")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_pc_q35_tcg(self):
         """
         :avocado: tags=machine:q35
@@ -58,9 +63,6 @@ def test_pc_q35_kvm(self):
         self.launch_and_wait(set_up_ssh_connection=False)
 
 
-# For Aarch64 we only boot KVM tests in CI as booting the current
-# Fedora OS in TCG tests is very heavyweight. There are lighter weight
-# distros which we use in the machine_aarch64_virt.py tests.
 class BootLinuxAarch64(LinuxTest):
     """
     :avocado: tags=arch:aarch64
@@ -84,14 +86,11 @@ def test_virt_kvm(self):
         self.launch_and_wait(set_up_ssh_connection=False)
 
 
-# See the tux_baseline.py tests for almost the same coverage in a lot
-# less time.
 class BootLinuxPPC64(LinuxTest):
     """
     :avocado: tags=arch:ppc64
     """
-
-    timeout = 360
+    timeout = 480
 
     @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_pseries_tcg(self):
@@ -108,8 +107,7 @@ class BootLinuxS390X(LinuxTest):
     """
     :avocado: tags=arch:s390x
     """
-
-    timeout = 240
+    timeout = 480
 
     @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_s390_ccw_virtio_tcg(self):
-- 
2.42.0


