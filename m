Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26D9BCD62
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 14:08:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8JHX-0000T3-98; Tue, 05 Nov 2024 08:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JHS-0000BQ-75
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:34 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8JHQ-0002kA-0I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 08:07:33 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so42045365e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730812050; x=1731416850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvCwniH1d5vJ2TSLTLYsHQTeRtQ/cjS0HoIHKDsL7Ck=;
 b=mh9Om4HcUnhQbbqBtfWrPlfkyUJYJUQwDjZdqCWZpyH4hzrzjTqAJygG+wrxtvfLD+
 Qds/2PkhtIV02a8aa6bIuTJQIGzdVYqbOeWLaR5Zvn25nVD72iU+ykLZFPEW0r4WUHxL
 MWkjmpZjOxmfidfRQnca4RRhEDbjrIjl4hPK4EpxJt7S+9yqzYCFdHxfAvLvHxEpGdaL
 6TVn6SSZmdow21aBNl0NHeuUK0EjqzDF73bkILE22Ej27ef3biVr0QEaKtGr/gnB47FE
 qRorleVlzIdmVcZ+cH32II9TG4O5DKcpvHKSLESjLHUzDOqoINLYP4p0BkuS7O701wYG
 drEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730812050; x=1731416850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvCwniH1d5vJ2TSLTLYsHQTeRtQ/cjS0HoIHKDsL7Ck=;
 b=rjECd7D30h6J/Dyfvgypw5p9L4Q49uPOd2vigH6mvyYrXi7GMcd41JmPPpR7wR5oD9
 vQ5XdWISbUEWdTFiEMBnGB4JlK55WYXpxcHwsbTAksG3J97UhtGdj34u9GMxd8QiFEML
 qfWE/XPgI34gx+Iz9Fip8ENSczUqjPTWz0Lg+f1U5tSCXcgyuPA0i6LPYKQbnZ4N01/5
 lUa5ADMRN/jBw4mXxdVqFI8w5ZGoxXThcd4Rj4IyOw5CkpFhGrE7MKiQsznOJ3chuBoE
 zCBF0QLVQzFgjb0xk5rppiTOrYof0Psi9Tlfhp6oyW9d8rn5vfpwON9Ij0P1LtagPw/e
 Vsaw==
X-Gm-Message-State: AOJu0YwqvcJ7yZI6UkewWSf6kscdYGKRCsQqKnHDn8NQKf4SVwHs3fjn
 ALpQqYeoMvc3s+HW/NhtiJ/vJlGrhMD7KTPnxaFkn2PBsfFTIQfGw6uFiRtqRwffqgsg6WakQZY
 nado=
X-Google-Smtp-Source: AGHT+IFiBXplWnZ1Fvahpkn2VJVAZ0FwQVQC1I0VUBiJwTFqVRKJrUyYFPY+CVCCdJcFRzBp6JFG3g==
X-Received: by 2002:a05:600c:4fd3:b0:431:52b7:a485 with SMTP id
 5b1f17b1804b1-431bb98fc9fmr209119645e9.19.1730812050247; 
 Tue, 05 Nov 2024 05:07:30 -0800 (PST)
Received: from localhost.localdomain (86.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac387sm194360095e9.1.2024.11.05.05.07.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 05:07:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/19] tests/functional: Explicit endianness of microblaze
 assets
Date: Tue,  5 Nov 2024 14:04:30 +0100
Message-ID: <20241105130431.22564-19-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105130431.22564-1-philmd@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The archive used in test_microblaze_s3adsp1800.py (testing a
big-endian target) contains a big-endian kernel. Rename using
the _BE suffix.

Similarly, the archive in test_microblazeel_s3adsp1800 (testing
a little-endian target) contains a little-endian kernel. Rename
using _LE suffix.

These changes will help when adding cross-endian kernel tests.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_microblaze_s3adsp1800.py   | 6 +++---
 tests/functional/test_microblazeel_s3adsp1800.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 4f692ffdb1a..2b2f7822707 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
-    def test_microblaze_s3adsp1800(self):
+    def test_microblaze_s3adsp1800_be(self):
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
+        file_path = self.ASSET_IMAGE_BE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/day17/ballerina.bin')
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index faa3927f2e9..1aee5149fb1 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -17,14 +17,14 @@ class MicroblazeelMachine(QemuSystemTest):
 
     timeout = 90
 
-    ASSET_IMAGE = Asset(
+    ASSET_IMAGE_LE = Asset(
         ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
         'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
 
-    def test_microblazeel_s3adsp1800(self):
+    def test_microblazeel_s3adsp1800_le(self):
         self.require_netdev('user')
         self.set_machine('petalogix-s3adsp1800')
-        file_path = self.ASSET_IMAGE.fetch()
+        file_path = self.ASSET_IMAGE_LE.fetch()
         archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/day13/xmaton.bin')
-- 
2.45.2


