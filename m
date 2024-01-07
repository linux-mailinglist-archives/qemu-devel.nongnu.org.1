Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C972A82653C
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWX8-0000mY-4j; Sun, 07 Jan 2024 12:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWX5-0000dW-70; Sun, 07 Jan 2024 12:01:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWX3-0007Hk-Ea; Sun, 07 Jan 2024 12:01:54 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3aa0321b5so9656575ad.2; 
 Sun, 07 Jan 2024 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646911; x=1705251711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/NyucbyYBfaGMIB9+/c1AzBImvbiA7o4w9IVqnLoTQ=;
 b=na60ZV7c+TC0ecdT22GkB50Q3tauYQDNR/NEPI04ucvfQ2LhP9qcVCiT/hAbLZBcRR
 H7bCIQ56OiONPYQyvYNb4aqhiZ6noZHpB6vBheShC/7z34uJEeo+3jBexY6wvXH53uJ9
 MTUkx1J0zi61LJjMhgmxLPCUrwRbTikBdCAJbtPfRQF4pyKOMBGlNxJQDkyLxP3Zpl/G
 gGlA1p4q+o04BFT551QCy/JBA4iG4fQHnDkO7TgBU5Ty0544RJUCzqdxsFc9/mI3B4pG
 apFnqeHXE2dJEc6YZchEAR1qfe58j6mhBo2iteVu9814Njl3CbVufsLAWXBsKqwSRcDR
 YHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646911; x=1705251711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/NyucbyYBfaGMIB9+/c1AzBImvbiA7o4w9IVqnLoTQ=;
 b=L4Y8qGWvEgIcFe0s/fsZo8usOeYYV/WUPM0JuL2f0yU490tI4u76l0WH3E6HI/bers
 4b7Rg6LAXUZxhpjwPvFWUs2p7nDvqjS9AoE5BnNvhljo6ymsftW8Fn/8fzgecItahSN2
 5mNAFjS7n1G1MfSJt1BlYqUQnELdaanRUl0hTqJEwzMDbXCSSrjby6oMkJxqe39K5f5B
 4oxupNlc41GoSKa9QYl2cHzB811nfDhUdbr5u8bKdJUmQsngbk9BIYqNM/47iif5OtWl
 J/L2uly2mlMPvR4uiBXBv6W5VDpi868pN7Z0Tym0xMD/HXtV/dZvgIEJIpQhjSIJDiTO
 kL4w==
X-Gm-Message-State: AOJu0YwHZgKBhAvADtcd8cgJXrbVkBFjLecP5CPjlefHGf6c6GJpZAo3
 Pp2lhJ+rF5t3teVZpFyn3yVXB1B9oDw=
X-Google-Smtp-Source: AGHT+IHU92L5QPaHBy/gfFzZqjICKYC2L4MB8zr6CZ2Nt4QHSNmKVX2VUBReUtGB8msAWlyoNMmjuw==
X-Received: by 2002:a17:902:eb8f:b0:1d4:1d90:f75b with SMTP id
 q15-20020a170902eb8f00b001d41d90f75bmr3066663plg.17.1704646911201; 
 Sun, 07 Jan 2024 09:01:51 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:01:49 -0800 (PST)
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
Subject: [PATCH 2/9] tests/avocado: mark boot_linux.py long runtime instead of
 flaky
Date: Mon,  8 Jan 2024 03:01:12 +1000
Message-ID: <20240107170119.82222-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

The ppc64 and s390x tests were first marked skipIf GITLAB_CI by commit
c0c8687ef0f ("tests/avocado: disable BootLinuxPPC64 test in CI"), and
commit 0f26d94ec9e ("tests/acceptance: skip s390x_ccw_vrtio_tcg on
GitLab") due to being very heavy-weight for gitlab CI.

Commit 9b45cc99318 ("docs/devel: rationalise unstable gitlab tests under
FLAKY_TESTS") changed this to being flaky but it isn't really, it just
had a long runtime.

So introduce a new AVOCADO_ALLOW_LONG_RUNTIME variable and make these
tests require it. Re-testing the s390x and ppc64 tests on gitlab shows
about 100-150s runtime each, which is similar to the x86-64 tests.
Since these are among the longest running avocado tests, make x86-64
require long runtime as well.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/testing.rst      | 8 ++++++++
 tests/avocado/boot_linux.py | 8 ++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd132306c1..3a9c1327be 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1346,6 +1346,14 @@ the environment.
 The definition of *large* is a bit arbitrary here, but it usually means an
 asset which occupies at least 1GB of size on disk when uncompressed.
 
+AVOCADO_ALLOW_LONG_RUNTIME
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+Tests which have a long runtime will not be run unless that
+``AVOCADO_ALLOW_LONG_RUNTIME=1`` is exported on the environment.
+
+The definition of *long* is a bit arbitrary here, but it usually means a
+test which takes more than 100 seconds to complete.
+
 AVOCADO_ALLOW_UNTRUSTED_CODE
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 There are tests which will boot a kernel image or firmware that can be
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 7c4769904e..6df0fc0489 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -93,13 +93,11 @@ class BootLinuxPPC64(LinuxTest):
 
     timeout = 360
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_pseries_tcg(self):
         """
         :avocado: tags=machine:pseries
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
@@ -113,13 +111,11 @@ class BootLinuxS390X(LinuxTest):
 
     timeout = 240
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
     def test_s390_ccw_virtio_tcg(self):
         """
         :avocado: tags=machine:s390-ccw-virtio
         :avocado: tags=accel:tcg
-        :avocado: tags=flaky
         """
         self.require_accelerator("tcg")
         self.vm.add_args("-accel", "tcg")
-- 
2.42.0


