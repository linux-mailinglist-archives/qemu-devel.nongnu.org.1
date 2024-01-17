Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44A8307AE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:13:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6ev-0004h6-NX; Wed, 17 Jan 2024 09:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6et-0004fm-Qp; Wed, 17 Jan 2024 09:12:47 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ6es-0002lj-41; Wed, 17 Jan 2024 09:12:47 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3606dda206aso57612395ab.3; 
 Wed, 17 Jan 2024 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500764; x=1706105564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtUlfVC/CoXaXLT7OI7+r07dsTnTE47z6bChDQn+KEY=;
 b=PIy4AylvYzOlNRC+CB0Jt7q4zp2XwfoQ0t/ks8WQ6oN/6BIpCao83J+jEFGAT2NT3F
 9/qhgmIM6PLx0yUKF/U3VGkSKZNpEqJciEK+HH+smkjhxNUUQZkG3wr/GJjrO9+jhV0x
 QxFvwYn8VIDeiE3RyZ8a+E6rUloMkjl+4kL8SUZOp9jjF2IA/M8cDVL6pkJHj8ThINR/
 FUME4VXmJ9RpFbK49L8bCtqt89qgBjwHkp6+BhB0FVeqV8dsPldpQyo0HExtwz+U2hhZ
 AUl+ympthsY+xwoPgmLnX0GnfoTDBz4VnL31kwcbAkgfwaWTJbahLCXtGX1IwNylXVk+
 2v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500764; x=1706105564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtUlfVC/CoXaXLT7OI7+r07dsTnTE47z6bChDQn+KEY=;
 b=gBZj7qpsIJICPwZVurMEB7Xh7c36STlBpmXMXqREIBA/QcWC034bjeutXmcw6UzU4I
 FJPrqkWxi7Jy0unZfbLp4Sf3nVIbULr0fEdFhhdsgeQVcBJeWuocgD9g/IVW9qcTdZat
 gQu5UUrtcyX+japroEFvUOc29lJ5E4xkPpaMBoPLemshu6Qq4wF5iQQOi7NciaQS0Xor
 Nrk7+k+R4bXk+9ft9Vgyjp1aSNEGXX0Has+gBblC7e3uOzjW6cGnwRSQttrxb9h/Z/R+
 KozAAYJvnBB3XgPIWgEIgn8659K/iWNKMW4DxExUGhz4HT9Xf4s/l7o608XbPlyBfVE0
 jL+A==
X-Gm-Message-State: AOJu0YzM3U4j4T88l43Kh61dD2fOip1mnYWklSLmfX/H1NXRqiQN5QGH
 ZseYE65zNLdUDku1sKrLQEpW8fiBDs4=
X-Google-Smtp-Source: AGHT+IHHBpGNESDzp2UNWd1vJ/+Wg0p0UkOfoJ6XcN/QAX79xGtTCdZ4PZQGGHA3PY3gKZUZbduWKg==
X-Received: by 2002:a92:c561:0:b0:35f:f02f:8fe4 with SMTP id
 b1-20020a92c561000000b0035ff02f8fe4mr12470425ilj.43.1705500764208; 
 Wed, 17 Jan 2024 06:12:44 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 i136-20020a636d8e000000b005cebb10e28fsm11812428pgc.69.2024.01.17.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:12:43 -0800 (PST)
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
Subject: [PATCH v2 1/8] tests/avocado: mark boot_linux.py long runtime instead
 of flaky
Date: Thu, 18 Jan 2024 00:12:16 +1000
Message-ID: <20240117141224.90462-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117141224.90462-1-npiggin@gmail.com>
References: <20240117141224.90462-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x131.google.com
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

So take the SPEED=slow variable from qtests and introduce it to avocado,
and make these tests require it.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/devel/testing.rst      | 11 +++++++++++
 tests/avocado/boot_linux.py |  8 ++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd132306c1..5cdc23b90f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1346,6 +1346,17 @@ the environment.
 The definition of *large* is a bit arbitrary here, but it usually means an
 asset which occupies at least 1GB of size on disk when uncompressed.
 
+SPEED
+^^^^^
+Tests which have a long runtime will not be run unless ``SPEED=slow`` is
+exported on the environment.
+
+The definition of *long* is a bit arbitrary here, and it depends on the
+usefulness of the test too. A unique test is worth spending more time on,
+small variations on existing tests perhaps less so. As a rough guide,
+a test or set of similar tests which take more than 100 seconds to
+complete.
+
 AVOCADO_ALLOW_UNTRUSTED_CODE
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 There are tests which will boot a kernel image or firmware that can be
diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
index 7c4769904e..de4c8805f7 100644
--- a/tests/avocado/boot_linux.py
+++ b/tests/avocado/boot_linux.py
@@ -93,13 +93,11 @@ class BootLinuxPPC64(LinuxTest):
 
     timeout = 360
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
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
+    @skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
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


