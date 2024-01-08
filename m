Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5B827297
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:14:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKC-0004CS-FO; Mon, 08 Jan 2024 10:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0004C9-1h
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:13:58 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrK7-0001Wc-Tf
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:13:57 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3368d1c7b23so1938529f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726834; x=1705331634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXuo8l/nA31Hwk3vdPvJmIYU7WuVY275jbIT2FWOsWk=;
 b=fbXAgWJPYjahZYqelUbD5rFvFE5XoA5rhDWul6ietHWtr08EvhVsXI6bbOtbj+T2p6
 nOyH0aJQ7Dr713nJ7RqwaS4a5K7aV2MhODNM+yzJOrL3I/DK+InCtsdEmG8y3zErFSC6
 FhzeMalnYhnFk9q4C7ZLIlDYv48Dwqb3/dWtZjDh7PkdVWPO5JcQOUrO9EeSBstbuOzp
 UAFV7pqzftjbK5ZHml0jci2iE4tJyNEskgsCM17JjgBV+2knYXdz1gke1wnTvHRS5o2r
 YwQsBhdnUzg7EWiH1hTwTUryfP42IXUF2PB2DT4HJ2TC7NWkHxVpnuWuvG0BzH4scs7g
 k7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726834; x=1705331634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXuo8l/nA31Hwk3vdPvJmIYU7WuVY275jbIT2FWOsWk=;
 b=eO+5gjuyNPv03oKX1q/5hcaZS5kToCbOeySARQ7Z6w/JVu3S7J0iC+1rYukNGY0/kT
 qTBU0Di8szBPxKgm2osMVCUDJdSzu2SpaYZoVwPk/PKqUWBm5rZU6LfxTVrWj6PmNqA3
 YojxuNIaT0rMAwc+vHbxJyfB51jZbFxhLC/oIajzDnPeWyTzYMSrzoTM0Kr8wDrNVj8O
 AiPnuHI0lnjiKf5bBiS2YAg3t7WS+owJJxCrNEe+72YMEycZ4zbOYFyCEIzYNANFXE/Y
 OrOsIVUNAG+b12RLAv15Y1DueB05pTrt5DhHkRm074WR+lDNC3wb41eyIzNUui9T8oeE
 rlWw==
X-Gm-Message-State: AOJu0YyEXOZaWlvutBQx4Z+fhVQalRn3hcrjOqu0AKzxzrRZQlxzJhfW
 RnYtYDG93jhrgIB2ixKtcP8Hn9DbC/IAyQ==
X-Google-Smtp-Source: AGHT+IGUK7/Uk83dZXFKIZPuiffzu4/pZb+Qh1A/PHiIEVOi5OCL1cNPKTcV6KrhqfBaw9kxOTdrBg==
X-Received: by 2002:a5d:5184:0:b0:337:2296:adb0 with SMTP id
 k4-20020a5d5184000000b003372296adb0mr1925590wrv.54.1704726833743; 
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a5-20020adffb85000000b003376af392e5sm2440383wrr.38.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F37B85F93F;
 Mon,  8 Jan 2024 15:13:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/13] tests/avocado: add a simple i386 replay kernel test
Date: Mon,  8 Jan 2024 15:13:40 +0000
Message-Id: <20240108151352.2199097-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
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

There are a number of bugs against 32 bit x86 on the tracker. Lets at
least establish a baseline pure kernel boot can do record/replay
before we start looking at the devices.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-2-alex.bennee@linaro.org>

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index c37afa662c2..1eaa36444cb 100644
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


