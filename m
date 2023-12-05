Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7A805FA2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEE-0007PV-SM; Tue, 05 Dec 2023 15:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcED-0007OK-9a
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEB-0002Eq-H9
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c0a11a914so28309195e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808870; x=1702413670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZO+XHJPkvwBo8PTtuDhgEKDXcm5kj7GqMfllU0coabQ=;
 b=Tzm09t4AZ0BK1ijJXrr4YwigdYfwRumLUAMLAnXdiMWANR8mNIT/LbU9hY51mngl03
 neKSD1Ja6RdpuBggbWfC/SSTQ+3Rg0+kdTSDtZQfQS77OEIPvAKgayrNz5Iw0oEo12xH
 pv5OlIQ/rqNqoHiVRP4OFAo1Qx3muuYWJhKZ8dBAMLLCGvYbkPNfBRtkmNQ8aEsJ4nGq
 J+F3f1xih6O09RenbKN6To4l7icNRZE0VbLfKpUEsn2GTyltK6a6dRuGnP81ucT7AhzO
 wXAL2XNWWrhGf5jxCngDijPa/SEX7nBYm15yDGZy54ZZqj1uVHfEaFX9hKHLiI3eN4U7
 aURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808870; x=1702413670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZO+XHJPkvwBo8PTtuDhgEKDXcm5kj7GqMfllU0coabQ=;
 b=tlbYbhBBAzVP0/Z1ucG/lJ2Irp6B4FyrzLKxJLUtX250WXzNyxdtufOZWWCzoCLRZu
 vO3wAKW2doionpBoQ8fpAzXTEEDpu19l2B7LZMEvmI20jyjpdw9B+ZpVWJwvcH0oSBvL
 KQaeBAF3inusT/6CS/cU0KtiFn2Wvq+5CKfoG8C40uaeLqN+sPGNW0+OQ+ZiWKoVECWv
 BLblX/143oLRJuW7gnoGmel9OLmlukZfE7wcSnrcQb4f3GjQSBuM688/hbC2r9VV1GOm
 yyrElSftWwozCjz9yi8r0rPR3HUG3oHUHDjt8AeU6MedTQg6UTp/p+s/X/2v6LwZI8Nu
 vlnw==
X-Gm-Message-State: AOJu0YxIB+WWlgYqk7exEfA86+ciKNqBG8JpWspQnCOHFJJoLuEOVMLQ
 9IiIdoPzUcRjHNXo5nqBANolWA==
X-Google-Smtp-Source: AGHT+IEl1EKPZ0Dcx8ON7Xq/2Pnw2jkPAQc9LuG7gm6SYO2Jha9knKrj3xZYLrAGZckT5a1bm8k6MQ==
X-Received: by 2002:a05:600c:22d1:b0:40b:5e59:b7a8 with SMTP id
 17-20020a05600c22d100b0040b5e59b7a8mr969692wmg.133.1701808870236; 
 Tue, 05 Dec 2023 12:41:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c3b8400b0040b40468c98sm23481841wms.10.2023.12.05.12.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E47065FBCE;
 Tue,  5 Dec 2023 20:41:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 11/11] tests/avocado: remove skips from replay_kernel
Date: Tue,  5 Dec 2023 20:41:06 +0000
Message-Id: <20231205204106.95531-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/replay_kernel.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 1eaa36444c..c54e96c9ff 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -98,8 +98,6 @@ def test_i386_pc(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -135,8 +133,6 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
-    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -152,7 +148,6 @@ def test_mips64el_malta(self):
 
         :avocado: tags=arch:mips64el
         :avocado: tags=machine:malta
-        :avocado: tags=flaky
         """
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20130217T032700Z/pool/main/l/linux-2.6/'
@@ -200,8 +195,6 @@ def test_arm_virt(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=1)
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_arm_cubieboard_initrd(self):
         """
         :avocado: tags=arch:arm
@@ -354,7 +347,6 @@ def test_m68k_mcf5208evb(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'sanity-clause.elf')
 
-    @skip("Test currently broken") # Console stuck as of 5.2-rc1
     def test_microblaze_s3adsp1800(self):
         """
         :avocado: tags=arch:microblaze
@@ -389,7 +381,6 @@ def test_or1k_sim(self):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'vmlinux')
 
-    @skip("nios2 emulation is buggy under record/replay")
     def test_nios2_10m50(self):
         """
         :avocado: tags=arch:nios2
-- 
2.39.2


