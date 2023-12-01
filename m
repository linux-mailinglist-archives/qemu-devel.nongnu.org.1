Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43542801416
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 21:12:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r99qe-0002FL-1r; Fri, 01 Dec 2023 15:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r99qR-0002C3-KM
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:10:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r99qP-0000YN-RT
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 15:10:39 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33332096330so605860f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 12:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701461435; x=1702066235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kVcPK636IKoCmLj7cFIPYNJoGycc7hzLNcQT6ZBeFus=;
 b=M024XVhSNk933AP2oftyDFByGGqaNcUoOgE4IKn0g0A4qqP3n32AdjDD4MpMkyNSMY
 vBpO2QoX1TPrVDC4LU5Js1AVq97EyA1bXPmt8kTVd2gZ8NKPHJheBCchqxqhEIBqVRWk
 NJchUzjaU7Qnj9yq2zXRpeJNCB7ZMjBOmYVq3UJIjOZ2OXml3gehfjJIkigZPV2ZE26Y
 4URdOMLs9NJQI0OXZEYvku0voGJDFeUdTuP5f9qxKxVwbjNlEQrf9pX5RulqTIdBi0VJ
 T9+sC8KzKVXn0/Rw7NMjXk2IPZIRO11m9L47kVnKdQIcLSnCHZ7G97eJYNGp3hXHLACp
 SdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701461435; x=1702066235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kVcPK636IKoCmLj7cFIPYNJoGycc7hzLNcQT6ZBeFus=;
 b=Zo3bCRgNb9LfrVpqwFIIICNSWta1W0YRxHhTDkBNZ5v8uNb2RLD3HBH/fjtnfv9JcF
 hecQUdspmtPo3Fqwb57308EHfGEuJXptmPldkgHUcIvkmGofC+or9+zxhA7XDMzz61Yu
 KoSl76c5TFbdJkSc8/BOxVXyC/k+JuyocAakRLPWSNt1IfOtBpBP9xHvqnA7ipERoQwa
 AG0CSKkf8R6gLxRjL39zbmvCo7+IK3H3zcWDIlOUTVI6FGlOaWcz2mowPsACz1Wd9F4f
 74uX9s+ZUfOgp4xeayFNTDDhz5/72Bz91Xr7SAHa95NsXikS3Ifd8i5bfpq3aHx6c5Nm
 pv/w==
X-Gm-Message-State: AOJu0YyAk321Xre8Lt2VorC/j+oOftSKrXxcJ1zvpu0jy/UKPsN1F8b5
 fRt5Io4W/eFjblEHnQd8nTrpaA==
X-Google-Smtp-Source: AGHT+IHjhv5pCr/J84wVTFt7jYsYcPtUpW9Zy+fWCcsahJ3GIBErkDgNSRxVahInJPZhCyzwdtsiGg==
X-Received: by 2002:a5d:4091:0:b0:333:161f:9fec with SMTP id
 o17-20020a5d4091000000b00333161f9fecmr1208496wrp.12.1701461435101; 
 Fri, 01 Dec 2023 12:10:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x1-20020adfdd81000000b0033318b927besm5004511wrl.42.2023.12.01.12.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 12:10:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBE295FB5F;
 Fri,  1 Dec 2023 20:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] tests/avocado: mark
 ReplayKernelNormal.test_mips64el_malta as flaky
Date: Fri,  1 Dec 2023 20:10:27 +0000
Message-Id: <20231201201027.2689404-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

I missed this when going through the recent failure logs. I can run
the test 30 times without failure locally but it seems to hang pretty
reliably on GitLab's CI infra-structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/avocado/replay_kernel.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index af086eab08..c37afa662c 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -119,6 +119,8 @@ def test_mips_malta(self):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_mips64el_malta(self):
         """
         This test requires the ar tool to extract "data.tar.gz" from
@@ -134,6 +136,7 @@ def test_mips64el_malta(self):
 
         :avocado: tags=arch:mips64el
         :avocado: tags=machine:malta
+        :avocado: tags=flaky
         """
         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20130217T032700Z/pool/main/l/linux-2.6/'
-- 
2.39.2


