Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D204E80C445
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcML-0001Ni-8S; Mon, 11 Dec 2023 04:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMJ-0001NA-4J
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:51 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMH-0004KO-7p
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3334a701cbbso4403722f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286027; x=1702890827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qst3b8dDcHZQs8ozQAiOtNvMPl3loOjgqonGZQxnJ2I=;
 b=Uix2VsulIQiqCdUXALIUkRyOelg7/0gGPG4nyyksMNeZNYcMHNWGa8n5bDsJdxCGoi
 x24TiYY0gBlUu2Nf5nbt14JXg8YVsMBiXK6FG+WtMXeper1G+AIyShFwR84W1gEu4Skv
 I2NXWCqdVn/bUrxVnZIbHOE9etusYGK90iy4sc7GzUlvDkMq9fwEiXn1bYvzU/NiWrLB
 d5IPfcCW95Hvyn5sQwwXNp/7R2Fxi/2vif1llG6UGu6qz9PLio5RJLWWZ6E0vITZykdt
 vFmU6paOHUUojvtT+/XcdQyCqn/K0ZvDUPnK+bM0IxPIWXVU6UGXR2ixrEFecvVGauoe
 n2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286027; x=1702890827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qst3b8dDcHZQs8ozQAiOtNvMPl3loOjgqonGZQxnJ2I=;
 b=tO2fxpdcGR6NHQQux0d8mHdgn0v/NSukbXO/yFJmkW3NmIbplwPVtJ1XCYvfeN+1nJ
 RPl311jCc2HPccHFVajIOQb7MW8iiHTNOAY1nQWdS304dILRNPr+gfQ+o17zaDbVNhI8
 mK62xWaiY4Rw+0n/YJg3VZbJkFN5ft4uCu97xonVBKiKDEdJgLF+CDyCrCInjpphPFLH
 Xp4VOABNWUG40GOl5rRDCDb3T1T3eoLv+HHbvlpQbUL4td/ZXH4ZnS36VQq529+PccPX
 QBR/nnSRqhDQwrtaMpXGYHJRxDGO8eO8fRvAp3dYsGD5QvFKW8CBKm3LwsClShVICHTO
 Qlxw==
X-Gm-Message-State: AOJu0Yy8N/Dd+P3mNEcfL6TgLXcYKj4YAzVU2zhCifw+rG8fjDRbDrhx
 Lv/nPMT0ntVt71TN4IFQ0KfpBA==
X-Google-Smtp-Source: AGHT+IEUYp/4dnbHoHQ5yGTQbPpeucWtVvb3eORWDYXlOme+XV1oTeO1m509QjInJeMwilWFLDC8lA==
X-Received: by 2002:a05:6000:1e86:b0:336:ac7:e07b with SMTP id
 dd6-20020a0560001e8600b003360ac7e07bmr1734969wrb.186.1702286027062; 
 Mon, 11 Dec 2023 01:13:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d1-20020adfe881000000b003334926fb81sm2992362wrm.90.2023.12.11.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 30C195FBD3;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
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
Subject: [PATCH v2 01/16] tests/avocado: add a simple i386 replay kernel test
Date: Mon, 11 Dec 2023 09:13:30 +0000
Message-Id: <20231211091346.14616-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

There are a number of bugs against 32 bit x86 on the tracker. Lets at
least establish a baseline pure kernel boot can do record/replay
before we start looking at the devices.

Message-Id: <20231205204106.95531-2-alex.bennee@linaro.org>
Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/replay_kernel.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index c37afa662c..1eaa36444c 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -82,6 +82,22 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
 
 class ReplayKernelNormal(ReplayKernelBase):
 
+    def test_i386_pc(self):
+        """
+        :avocado: tags=arch:i386
+        :avocado: tags=machine:pc
+        """
+        kernel_url = ('https://storage.tuxboot.com/20230331/i386/bzImage')
+        kernel_hash = 'a3e5b32a354729e65910f5a1ffcda7c14a6c12a55e8213fb86e277f1b76ed956'
+        kernel_path = self.fetch_asset(kernel_url,
+                                       asset_hash=kernel_hash,
+                                       algorithm = "sha256")
+
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'VFS: Cannot open root device'
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
     # See https://gitlab.com/qemu-project/qemu/-/issues/2010
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
     def test_x86_64_pc(self):
-- 
2.39.2


