Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B77282729C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKN-0004Hl-Rs; Mon, 08 Jan 2024 10:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKL-0004Ga-42
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKH-0001d8-GW
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33678156e27so1931683f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726844; x=1705331644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCcg7ysSyOpy/NHtcycGrXvCgSegX/kK/v3WtacdHyY=;
 b=j0FXqPgotKUB+gP1zd3Wgzkh8Lp4s5pV5kV4A+WCacIdHiPPYUf9J1X7qgrwMADSlN
 o/xoTppEi+QbFNd/wpJPXUbXHJY39aL3/6G8a2K2rZZqJp7S/Pc2rCjCi+Udg9bix/qC
 kmcOS1rd5QKutNYK/kWLu35Ba5oCHXVO3QRya8taDXQDMt0bWPfuMrD1ZeptNVKrR4nB
 9LvJqfB+/dRlB3amHriR9NMUyfUTwsznEtjSF+ctPA5w+KVJZG7p/OGU5tzYNc41iltC
 RNf8g7yNNQacoj8LzVsqzogobp1ap4M8SLl0lFG5pa0eCRvc/TmJyWXL1kaByiF8oPJ3
 ZPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726844; x=1705331644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCcg7ysSyOpy/NHtcycGrXvCgSegX/kK/v3WtacdHyY=;
 b=gkmyn2LF/9V/S6n4Fyw+TPY6zMKH/7TIzHQy4nOMwfJETnF5NNIWKq/gKpJ5Q/AtOt
 UPR3LASNGKTyss9uCtr9VI9On5mW6bPryZYxlNJ2SMPwM1g+ZKmRKnhsv7JAoc3eDMyN
 bqlK8zk8K+zM6sd0POyytu4/sZeIEb1vjdYUKeDQvSR/FVSUGKJhc5Z9e2kr858LQoev
 jDQJBDlpmjQiaixo2uCvRDvaS2AirANkONXaP7Jn82piQZfHAM6uqOQBCIVGGVgKU6jG
 mBBq384+d6YELl4TCHXwybNiCBVd+j258HKQNKae+HXUkd4ksEw+E3OFyJc5WPgSPP+L
 S7LQ==
X-Gm-Message-State: AOJu0YxSaoI0ePWoDTCwq84C7TBeHZAYkezvDYL6e7ytqDW2FhB81mZ1
 RLIsfvpvWbyxgb87VFMYwo3epGDIpUNP6w==
X-Google-Smtp-Source: AGHT+IHO7TN/2B0xs17i1KQU9cO+wTzTrLElycVCv7GjDG0S/COOrW6Id/vyk+51O3n0m/xpbYZzMQ==
X-Received: by 2002:a5d:4d01:0:b0:336:7e06:390e with SMTP id
 z1-20020a5d4d01000000b003367e06390emr2009413wrt.134.1704726843906; 
 Mon, 08 Jan 2024 07:14:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o5-20020adfca05000000b00336ee9edbb3sm8028968wrh.94.2024.01.08.07.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:14:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2BEA5F951;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 13/13] tests/avocado: remove skips from replay_kernel
Date: Mon,  8 Jan 2024 15:13:52 +0000
Message-Id: <20240108151352.2199097-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

With the latest fixes for #2010 and #2013 these tests look pretty
stable now. Of course the only way to be really sure is to run it in
the CI infrastructure and see what breaks.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-14-alex.bennee@linaro.org>

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 1eaa36444cb..6fdcbd6ac3d 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -98,13 +98,10 @@ def test_i386_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
         :avocado: tags=machine:pc
-        :avocado: tags=flaky
         """
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
@@ -135,8 +132,6 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -152,7 +147,6 @@ def test_mips64el_malta(self):
 
         :avocado: tags=arch:mips64el
         :avocado: tags=machine:malta
-        :avocado: tags=flaky
         """
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20130217T032700Z/pool/main/l/linux-2.6/'
@@ -200,13 +194,10 @@ def test_arm_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
-        :avocado: tags=flaky
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
@@ -354,7 +345,6 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
-    @skip("Test currently broken") # Console stuck as of 5.2-rc1
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
@@ -389,7 +379,6 @@ def test_or1k_sim(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'vmlinux')
 
-    @skip("nios2 emulation is buggy under record/replay")
     def test_nios2_10m50(self):
         """
         :avocado: tags=arch:nios2
-- 
2.39.2


