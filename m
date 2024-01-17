Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FB28307AD
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:13:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6f3-0004od-66; Wed, 17 Jan 2024 09:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6f1-0004kb-0C; Wed, 17 Jan 2024 09:12:55 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6ex-0002na-RT; Wed, 17 Jan 2024 09:12:54 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6dac8955af0so6355766b3a.0; 
 Wed, 17 Jan 2024 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500770; x=1706105570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24tQcxqPqeU/relh2eghfjT90bWoGXR7lUeha6JIv0o=;
 b=NK9OOPPVkk7t0ognlxR7Wio0yOxHCDTXxVw4dnmzNRdxB2/2HaAIXhXATwOOqI6fwQ
 48H/rQSaSYCTgCciOij+7ko11jNid0VerUqsJJJ06iMfkcGNIh50IxAFWy1cBE0TpsvR
 wd0dtsDiVqv05yBkWBZYqIQld0MMDpTnXMdpUzrxlZIzkB3FhI9HOGrKR+cMo/rmfH0e
 kIE9KWZhNqrlrrGLqCcmB30t3A+jKKHUCJJnl6CHXjDuYbqVKsWR9iRjMv9/SdQ2YHei
 luW8zfbwi3h6LUBM7yrvBI6aheOFh7whzSOemB6mCGkW9lUAqppXUsFblFnvoooaFx0Q
 VaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500770; x=1706105570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24tQcxqPqeU/relh2eghfjT90bWoGXR7lUeha6JIv0o=;
 b=ojivvfybj1t8hjzy9rOqCPiPcvHVSsxV6/fXbFPWdSDmAtYs6lBJDqiRGm2lPATosh
 UcMNIKjar6l6EKjrZ12T+zJQfmha9M2abwZxkb1fJvNFXVe0UHDIMsMid8KYyH8vMGyW
 05DLQgxsG2gRotZaZAAMCri0V+KVg5s9GQXamwLZPVPq0Y9EWsF/ogr/elbzk8TRTKf7
 nNQkP+k+aTS0ngoUs5QyoX/idBTjiOu90wYB6AG4JEwvZVGfFF49J2cZEIHyyyPbqtmG
 9NUJtVmFiIoZ57lbrHN2xSPvFclu2+dVhe32G7w8DEX+vf99OoSkG126x3eskAm4JRAM
 Fq2A==
X-Gm-Message-State: AOJu0Yz8SXyOCql71iORZA604LNsqoAnUMcVppAO95jjct/Y11SJ5szb
 4i0kKNzoYMtzQscCh/SMsDBygqUn9SY=
X-Google-Smtp-Source: AGHT+IHkx5dYI2jcp4eJk4GKngvt63wyWQixHNQduzSYm3H//fA+0SC1/5MYmsagVIf6ch4OeNiF5w==
X-Received: by 2002:a05:6a20:ce4d:b0:19a:e502:1624 with SMTP id
 id13-20020a056a20ce4d00b0019ae5021624mr2999987pzb.10.1705500769627; 
 Wed, 17 Jan 2024 06:12:49 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:12:49 -0800 (PST)
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
Subject: [PATCH v2 2/8] tests/avocado: Mark x86-64 boot_linux.py TCG tests as
 long runtime
Date: Thu, 18 Jan 2024 00:12:17 +1000
Message-ID: <20240117141224.90462-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

Re-testing gitlab CI shows the ppc64 and s390x boot_linux tests take
100-150 seconds each. The x86-64 TCG tests take a similar ~100s each,
and are the longest-running avocado tests in gitlab.
From avocado-system-centos:

  boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg:  PASS (112.34 s)
  boot_linux.py:BootLinuxX8664.test_pc_q35_tcg:  PASS (97.05 s)
  boot_linux.py:BootLinuxPPC64.test_pseries_tcg:  PASS (148.86 s)
  boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg:  PASS (149.83 s)

So mark the x86-64 tests as SPEED=slow as well.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

The other way we could go is enabling them all since ppc64 and s390s are
now much faster than when they were originally disabled; or to only
enable q35, giving at least one boot_linux.py test.

[https://gitlab.com/npiggin/qemu/-/jobs/5842257510 for results]
---
 tests/avocado/boot_linux.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index de4c8805f7..7c9cf6ae15 100644
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
 
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_pc_i440fx_tcg(self):
         """
         :avocado: tags=machine:pc
@@ -39,6 +43,7 @@ def test_pc_i440fx_kvm(self):
         self.vm.add_args("-accel", "kvm")
         self.launch_and_wait(set_up_ssh_connection=False)
 
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
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
 
     @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_pseries_tcg(self):
@@ -108,8 +107,7 @@ class BootLinuxS390X(LinuxTest):
     """
     :avocado: tags=arch:s390x
     """
-
-    timeout = 240
+    timeout = 480
 
     @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
     def test_s390_ccw_virtio_tcg(self):
-- 
2.42.0


