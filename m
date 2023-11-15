Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7018F7ED36D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:52:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mrf-0003Kg-1j; Wed, 15 Nov 2023 15:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Mrc-0003IH-5v
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:51:56 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Mra-0004QD-Dl
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:51:55 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33139ecdca7so71831f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081512; x=1700686312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WUOuiVx0sbzDsigWcQKOEegvye4SJYDrqQTnsd5ZUSk=;
 b=SIJ07cFZOmdapY2YYVCXxHHYyhzuT6bU/4QHpa0HbLLixwnthwSB3Gdr5mPihSJALX
 lQgzGlEmjcwsepAeVHDFWK0v1g4OUCCP9wlHo8gPbBCfkFIXLrfW3zfGXjeaDprsnY7X
 KQMDGir+LgnykUFYXRLtlq5X1HYRqKy+HiCTtpSQUdDdzIz3pwSpy1BddZIpgbKfwXoJ
 GVJtyXRTtGdYOWvaCLgRMDBU63cOvj6tXrjSojBWYZF0XKbOGTEiIyyztLwiewQmH68D
 UDc5GuH2e5e4Ny5R7ep7y2VfcNTtfzeEp+rOURCEuFoHmsWAh6JOkVyCCS1QVBVULwH4
 +rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081512; x=1700686312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WUOuiVx0sbzDsigWcQKOEegvye4SJYDrqQTnsd5ZUSk=;
 b=idt7nxfY0LBIHU6fTEKsy5cRLgnBLkjsfx3KNYwRZu8KuCbCR/+jPEKqbwAi1VX7rm
 XzMA5F+/Hxq4DQXvgzeL5iGf7QSG9qJkLNnPHHknUMazKxWBLDie9gepVefUy3eTQf2I
 oTpNv4rXTbRURAY9TQYgtuy+L2LlSB6WknM/kViaVTpJ3wRY0gSH3YAaUT5yYXnlDF8s
 8b+jcdTxXnB5X0CZjDrKnMwVhV07uoz/hw8aNmiVSdK5L+5jEzhxqU674nGm8OgO2cTO
 GppPyzAK5cfp9c52m62whMa/GRtl9pcME+vlCgtDkrdzLeG561EjJl2H6vjCEiQT+jKr
 QTDA==
X-Gm-Message-State: AOJu0YwPWopLu6bRTOXkpNiSyzjpNwXcZH/p2gz4bl/QWHdZGpjiEGDK
 K9qYabqaEC4OUjB0sxqLZkYUFyGi94FBJ6RsgIE=
X-Google-Smtp-Source: AGHT+IEDUrhB5/7GmTmv/9fjiBt6/lfv6Bflndxpnz5i6h5R2VuWEttprPuHqPoLvOeYklAuzs8tDw==
X-Received: by 2002:a5d:4576:0:b0:32f:7bf6:db01 with SMTP id
 a22-20020a5d4576000000b0032f7bf6db01mr7880224wrc.67.1700081512126; 
 Wed, 15 Nov 2023 12:51:52 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a5d674a000000b0032d09f7a713sm11484002wrw.18.2023.11.15.12.51.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 12:51:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-8.2? v2] tests/avocado: Make fetch_asset() unconditionally
 require a crypto hash
Date: Wed, 15 Nov 2023 21:51:49 +0100
Message-ID: <20231115205149.90765-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

In a perfect world we'd have reproducible tests,
but then we'd be sure we run the same binaries.
If a binary artifact isn't hashed, we have no idea
what we are running. Therefore enforce hashing for
all our artifacts.

With this change, unhashed artifacts produce:

  $ avocado run tests/avocado/multiprocess.py
   (1/2) tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64:
   ERROR: QemuBaseTest.fetch_asset() missing 1 required positional argument: 'asset_hash' (0.19 s)

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
Based-on: <20231115145852.494052-1-thuth@redhat.com>
  "tests/avocado/multiprocess: Add asset hashes to silence warnings"
Based-on: <20231114143531.291820-1-thuth@redhat.com>
    "tests/avocado/intel_iommu: Add asset hashes to avoid warnings"
Supersedes: <20231115153247.89486-1-philmd@linaro.org>

v2: Fixed type in subject (Alex)
---
 tests/avocado/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index d71e989db6..304c428168 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -254,7 +254,7 @@ def setUp(self, bin_prefix):
             self.cancel("No QEMU binary defined or found in the build tree")
 
     def fetch_asset(self, name,
-                    asset_hash=None, algorithm=None,
+                    asset_hash, algorithm=None,
                     locations=None, expire=None,
                     find_only=False, cancel_on_missing=True):
         return super().fetch_asset(name,
-- 
2.41.0


