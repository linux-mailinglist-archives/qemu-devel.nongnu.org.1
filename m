Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF47E2C67
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:53:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04h6-00065H-Lb; Mon, 06 Nov 2023 13:51:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h2-0005zC-Ec
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gz-0000yl-5b
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:24 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso36880095e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296679; x=1699901479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIqdfI1rvGTDtr96W/cBcKJ1TJ7DmV0zgw8mFEB58m8=;
 b=DrYk7V3PnJ2Loc8CZ+e+yUsAGvAGSw99lBsND5rH4I2seEeXLtoN4pNeWrDjGKvgev
 fRLKjvRZiAiVGXxw4eFzu1ljaezE3zzhRA9Z14Cw/em1LaLNpyz1zNiPDvjm56ZdQ5Oz
 xN75smVjqtAjlID1M2ccpcK1fN1OoXOSYexQLEW6RCV0Tb3sPXPdoYLnYAQ4zvjnO9o5
 992xDN2a1ovCDN01m2F99h/E6MZ1wb3xedgZHMNS2Wn0eFTZ0ewKut/s+69doJ6eBqil
 1/SJlDGLpY2CKdDAeSjjw/eIF/YemNah27tOSfA7hx5R3m8ac8T9y2kijK63M3OYCFYx
 Bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296679; x=1699901479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIqdfI1rvGTDtr96W/cBcKJ1TJ7DmV0zgw8mFEB58m8=;
 b=E9wCdYJ8dRe2jkgRZ6RAJWJYU1a/2NYkMjaYMuCiEHBsEQ8v8bWbTTEU60wIQqnNef
 2NsKZejgYDY1dl5vT+Y9c+xeW6iQchEBf16+NvUz2z8C0r8Nkg/7fjnDXJw0xwVH1UGz
 l91kDTzsZcqNn9khzh9LoI9/yaeiDBUEAZLUaKCQcB0V77QyKOikX6mdmIKOxvF1nsaA
 RBVsnuEae5VDHLlU9sakMhokXWhDt6ansbuhD7zRcnNOsET3cj/rk3ohrcZtZwzy7B7U
 upMnCUMxbwlsQ8cJU0iKxqtDx9zKsyi4G2Afjxj259/FdSV//UhCaStUZeeX4JFdO1PZ
 3Y+g==
X-Gm-Message-State: AOJu0YyQMcvi/jRJKnk1FPJBuPNsaSbERKbHtLc4ZgT8lAPuUszBZV7R
 ZfiuGq6GEAvRBdAkiyF1qK1eiD4Mqb8iYFnQVbKC9g==
X-Google-Smtp-Source: AGHT+IHs6VFXcNO+9yGuXrtXQlD7TsFfqVm50reBh3nHbdARYk47yfqPCxIyMCP3jSt7UGID+4hwQw==
X-Received: by 2002:a05:600c:198a:b0:402:98cd:a3e9 with SMTP id
 t10-20020a05600c198a00b0040298cda3e9mr521120wmq.32.1699296679460; 
 Mon, 06 Nov 2023 10:51:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a16-20020a5d5710000000b0031aef72a021sm284214wrv.86.2023.11.06.10.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1C8836575A;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/22] tests/avocado: update the tcg_plugins test
Date: Mon,  6 Nov 2023 18:50:57 +0000
Message-Id: <20231106185112.2755262-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

There are a number of things that are broken on the test currently so
lets fix that up:

  - replace retired Debian kernel for tuxrun_baseline one
  - remove "detected repeat instructions test" since ea185a55
  - log total counted instructions/memory accesses

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-8-alex.bennee@linaro.org>
---
 tests/avocado/tcg_plugins.py | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tests/avocado/tcg_plugins.py b/tests/avocado/tcg_plugins.py
index 642d2e49e3..15fd87b2c1 100644
--- a/tests/avocado/tcg_plugins.py
+++ b/tests/avocado/tcg_plugins.py
@@ -54,13 +54,11 @@ def run_vm(self, kernel_path, kernel_command_line,
 class PluginKernelNormal(PluginKernelBase):
 
     def _grab_aarch64_kernel(self):
-        kernel_url = ('http://security.debian.org/'
-                      'debian-security/pool/updates/main/l/linux-signed-arm64/'
-                      'linux-image-4.19.0-12-arm64_4.19.152-1_arm64.deb')
-        kernel_sha1 = '2036c2792f80ac9c4ccaae742b2e0a28385b6010'
-        kernel_deb = self.fetch_asset(kernel_url, asset_hash=kernel_sha1)
-        kernel_path = self.extract_from_deb(kernel_deb,
-                                            "/boot/vmlinuz-4.19.0-12-arm64")
+        kernel_url = ('https://storage.tuxboot.com/20230331/arm64/Image')
+        kernel_sha256 = 'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7'
+        kernel_path = self.fetch_asset(kernel_url,
+                                       asset_hash=kernel_sha256,
+                                       algorithm = "sha256")
         return kernel_path
 
     def test_aarch64_virt_insn(self):
@@ -88,6 +86,10 @@ def test_aarch64_virt_insn(self):
             m = re.search(br"insns: (?P<count>\d+)", s)
             if "count" not in m.groupdict():
                 self.fail("Failed to find instruction count")
+            else:
+                count = int(m.group("count"))
+                self.log.info(f"Counted: {count} instructions")
+
 
     def test_aarch64_virt_insn_icount(self):
         """
@@ -111,9 +113,13 @@ def test_aarch64_virt_insn_icount(self):
 
         with plugin_log as lf, \
              mmap.mmap(lf.fileno(), 0, access=mmap.ACCESS_READ) as s:
-            m = re.search(br"detected repeat execution @ (?P<addr>0x[0-9A-Fa-f]+)", s)
-            if m is not None and "addr" in m.groupdict():
-                self.fail("detected repeated instructions")
+
+            m = re.search(br"insns: (?P<count>\d+)", s)
+            if "count" not in m.groupdict():
+                self.fail("Failed to find instruction count")
+            else:
+                count = int(m.group("count"))
+                self.log.info(f"Counted: {count} instructions")
 
     def test_aarch64_virt_mem_icount(self):
         """
@@ -145,3 +151,5 @@ def test_aarch64_virt_mem_icount(self):
                 callback = int(m[1])
                 if inline != callback:
                     self.fail("mismatched access counts")
+                else:
+                    self.log.info(f"Counted {inline} memory accesses")
-- 
2.39.2


