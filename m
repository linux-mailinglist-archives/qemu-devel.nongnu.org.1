Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB780C45F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:21:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcTP-0000FH-BK; Mon, 11 Dec 2023 04:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTL-0000Dq-Ns
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:08 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcTE-0005vS-S5
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:21:07 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3332efd75c9so3888834f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286459; x=1702891259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4pFkSXz9xicXqLvtDSbJYeh1UqesG/1K3uV1P6+ZNM=;
 b=rQlUDDYqwW055fGeROZzlDQ+CM1anTQhjIH89698QMmKMj+nIW8gwRF8LjQSPws/iU
 NeoVq7MsWrj7AjGiIQXJCp3fRojkLWPLmCe6+qL/5EEthbpvT0+WOe21JzHMmZPjkDWa
 QiTPDJn23qm5VwdZlD6Ul3VTRK2BXLTVoTTAq3J2EEux8KA0YDuWWal02IPWu3horx+L
 D/YWAgj3OSEWyLEk/Tnc0k+o5TizNbra0S1HIJagAS74mr9rVk7P/1LJF4SC5dTRkzdE
 VIz4wB5Pm0077aegCZwOPhAjH6JOXSFRYtXsYCJr2pPWj0A7hiRHrDiQO/Dj4U7yoWjW
 je4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286459; x=1702891259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4pFkSXz9xicXqLvtDSbJYeh1UqesG/1K3uV1P6+ZNM=;
 b=N1slzirxBj0RpzdCYl0wFyNnhxrnh8RK6M83Rzul7VUH4Wi2sNGcujze02y7eF6anV
 MS6D4B+aRbXsyzSzeftblhsFYbhZ97nW08EMnsuDWtI1Dpwo0rTY6YFiVQinVus1diVG
 R/AnQlp9MBTaf1fjUBK6Mzt45vApmn8p6D3xek6X6YOWgZev/OrgrojTTxtC4+tF5PhL
 9yXOSC+oPNUHj3U2VOZ0IsFCFzhhMFMeeGHM9UmM2yY98ujR3zuUNrV2qyG2xS4Mhzh9
 +QxlckYWvrIKkwaB1URWp5n4TtA2Ps6j/AbnE/zh+9Jp9eb1p4FungAMuhnw6BCaJalJ
 et8g==
X-Gm-Message-State: AOJu0Yw1Ge2r46jimKYIMoxQH2HHXmMgIvEsX7MYGWD5MfPYS4hMWLBK
 YiDF9/xb34uTq/k1SS6n3pdXaQ==
X-Google-Smtp-Source: AGHT+IHWsAtiqm5O3zmLBimABuP0X/O9Z2kJLORy0oBicRYwqiZqECQvZntbTg2WUqRwjHLIsOUR/Q==
X-Received: by 2002:a05:6000:906:b0:333:92b:5f51 with SMTP id
 cw6-20020a056000090600b00333092b5f51mr845164wrb.70.1702286459122; 
 Mon, 11 Dec 2023 01:20:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0033331f83907sm8074954wrc.65.2023.12.11.01.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:20:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4210E5FBF4;
 Mon, 11 Dec 2023 09:13:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 13/16] tests/avocado: remove skips from replay_kernel
Date: Mon, 11 Dec 2023 09:13:42 +0000
Message-Id: <20231211091346.14616-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Message-Id: <20231205204106.95531-12-alex.bennee@linaro.org>
Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - also drop flaky tags
---
 tests/avocado/replay_kernel.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 1eaa36444c..6fdcbd6ac3 100644
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


