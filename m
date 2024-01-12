Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C79182BEFB
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:10:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQl-0007Sm-Rh; Fri, 12 Jan 2024 06:10:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQg-0007Od-DX
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:27 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQa-0003QO-Mh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33674f60184so5934332f8f.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057815; x=1705662615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dq5oqNsNmMR7A1CfAzhNbrNcpN1yewprCED11pWmUvs=;
 b=ZmGPfMAP5Hz54B3CYpHONq5Mk1bcsfhKsQSa+q/VWXQV2trqwzHofMUJlP6LbA6vDN
 s51W3/t30lL8O3M6Ox5+4wwsCVwPCeZizzU5JFZtWfB5AueGY/xR5mUYP4GxwLz+OkDs
 9mqh2l25qmTN7rzzCOzkQJRaEqhe4pL5JxW3CM7W93Bno1fa5VLk/64stkokCfp/r2Ow
 E6sTuVKiIRMSzm4UdJ9DDDclnCNyyQ/mgab0E1YbPpikZMBgoHG7Gufd9pTjiA4IdlkC
 y3x0VO4ycooiWTMryz0SaLegcZjD8xm/fvxnKZqBpcF+WFJkYA01wpHC4WPe7khcQREe
 IHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057815; x=1705662615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dq5oqNsNmMR7A1CfAzhNbrNcpN1yewprCED11pWmUvs=;
 b=iwm592B2HmOCC9Z9jX62sl2hri+jQ02IDDhx8toNrswtOKQ+sQVw2zu/E6EE0ZUO5M
 t7FgEhk93TTk4wHE5BhBCOV2u9iu6T6HyzCVzCSSHOFSESH+GdtOAkOeBxfRYrm51ma9
 nvAezMaXk5RMWFhneaZTZ+2ct9tYEB4Dp5OX0NnxHTzUVPeNGjNQ+cAg9HBw1Z1VDh0d
 BWrl3VzMc3Iq99KHE1WixqUn3V4J/+U1iG+q6IGLZWdTAwvILLpzl1e6R0MAXd9cnVdv
 l62vyFyJW1h2d73WQYJNyMa8XlvH/id4tt3Z1w05QjRXBLYrgqJKYHd/YuVe60c5PcmC
 Mbgw==
X-Gm-Message-State: AOJu0YwHnI+9eNGWEE/5c8rOdBroOyOIKBE/2PYlXGjPtZbfD38NYR8l
 5BLzL0GJhXaE1uv13m7bYkygOazFpdsgQw==
X-Google-Smtp-Source: AGHT+IGeAaSJUzFIZk7fNa0iuXqXzmSfLU81sb4d9C8NkLvLuBTk/SJKK+YW3Y1zfsIaXUhfArGwcQ==
X-Received: by 2002:a05:6000:14d:b0:337:4c30:b0b with SMTP id
 r13-20020a056000014d00b003374c300b0bmr571489wrx.77.1705057814960; 
 Fri, 12 Jan 2024 03:10:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b6-20020adfee86000000b00337478efa4fsm3546702wro.60.2024.01.12.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0285D5F9CE;
 Fri, 12 Jan 2024 11:04:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 22/22] Revert "tests/avocado: remove skips from replay_kernel"
Date: Fri, 12 Jan 2024 11:04:35 +0000
Message-Id: <20240112110435.3801068-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

This reverts commit c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed.

While the fixes for #2010 and #2013 have improved things locally it
seems GitLab still continues to be flaky.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 6fdcbd6ac3d..1eaa36444cb 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -98,10 +98,13 @@ def test_i386_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
         :avocado: tags=machine:pc
+        :avocado: tags=flaky
         """
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/29/Everything/x86_64/os/images/pxeboot'
@@ -132,6 +135,8 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -147,6 +152,7 @@ def test_mips64el_malta(self):
 
         :avocado: tags=arch:mips64el
         :avocado: tags=machine:malta
+        :avocado: tags=flaky
         """
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20130217T032700Z/pool/main/l/linux-2.6/'
@@ -194,10 +200,13 @@ def test_arm_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
+        :avocado: tags=flaky
         """
         deb_url = ('https://apt.armbian.com/pool/main/l/'
                    'linux-5.10.16-sunxi/linux-image-current-sunxi_21.02.2_armhf.deb')
@@ -345,6 +354,7 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
+    @skip("Test currently broken") # Console stuck as of 5.2-rc1
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
@@ -379,6 +389,7 @@ def test_or1k_sim(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'vmlinux')
 
+    @skip("nios2 emulation is buggy under record/replay")
     def test_nios2_10m50(self):
         """
         :avocado: tags=arch:nios2
-- 
2.39.2


