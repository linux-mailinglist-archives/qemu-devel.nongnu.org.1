Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13D805F9E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:42:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcEC-0007Nx-IN; Tue, 05 Dec 2023 15:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcEA-0007NF-5o
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:10 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAcE8-0002E3-CL
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:41:09 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33349b3f99aso76837f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 12:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701808867; x=1702413667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dc4DC6j7/1Sz+Ur/zdr+xWcs+c/Czka+caIepOUIoFE=;
 b=qoifM3vmWlx6eNJ0e5Ix//uFhEquDcc42gmLS+7MU4COBOVWT0fC2InFmOLTdbU+uq
 Iagmrd/i12vuBrWL+5kDYT1mSw/kRlU/Pm+8SW6etWvMFwDpvvSn2S4es9obCFw6wXIL
 8F1VfVG9C3yaPEwvUyCQmlJS7qD0wKwONErSvnJQobN8wfUpTdVu4SooasboOL43QsX1
 gxuZoeVA5vGxRL06uQ4ncggvYNjkcFPYg6Pyse2OZpmyoYrMKH9Kblk9J0aq8d8vX2ZX
 LuTBJeXgx1TIvikTwJqg6rUmgxL6OdtVFGCjHaKjb7lRoNHFA7aXOkzieOipcIap7sdo
 DOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701808867; x=1702413667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dc4DC6j7/1Sz+Ur/zdr+xWcs+c/Czka+caIepOUIoFE=;
 b=t9zU2Bja1dQok1HMOCNKSZv0qN8/8r6ncFuDL47PP8XhxuWnphju571YnjJ3qDrQFo
 UPQoqPv2rxLFw+e6UmyexZW2eEeNSyno20N0eapoI+3w7BMMSpF9qCTr9Nv1YOQ6ROag
 8JjptMFw6SILSBSa9SFfj4T3YBXgunh4Ji9XwF/fre6uCpwXzTC8tb8g9QAu/e2RT81q
 nWl5ZOk3d4+qs2QTTajP09GYDS2VVNH/jzx4wOql1+FOvM6XjZzidfvHGFCi4xZ1YjRM
 SAiTqV9b0DrKr0DkLvePN33W92y0auvE+huJ78+KPfq7OCnweWIKKQ45Hk+VTT8EnaeR
 HzSg==
X-Gm-Message-State: AOJu0YzFjMgSbloRv/rnyOWDu99XC4wB4kCPzPEtBB5nc+diV39ptgSu
 M3oZ/ec1UtNdBJPQswPhoJDBtg==
X-Google-Smtp-Source: AGHT+IE+ViipkQvP/0pMQKe5dVUxH/76MrbYk2OLv9z+zJ7LQLRa8zzrMuBjy9kY9OPoAQL4MRF9qg==
X-Received: by 2002:a5d:67c6:0:b0:333:3cf1:cb84 with SMTP id
 n6-20020a5d67c6000000b003333cf1cb84mr3314839wrw.139.1701808866828; 
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j1-20020a5d5641000000b0033349de2622sm6333379wrw.94.2023.12.05.12.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 12:41:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2678D5FBB8;
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
Subject: [PATCH 01/11] tests/avocado: add a simple i386 replay kernel test
Date: Tue,  5 Dec 2023 20:40:56 +0000
Message-Id: <20231205204106.95531-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205204106.95531-1-alex.bennee@linaro.org>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


