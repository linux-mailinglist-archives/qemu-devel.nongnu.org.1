Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E926E7E41C8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:25:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0N-0004XT-K7; Tue, 07 Nov 2023 09:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzu-0004Dk-PB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzr-0007Yt-6o
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso41718905e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367042; x=1699971842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nzv3ijX6aA4Ef+mTXMoyBo/VonVr+hfDPrYo/eu8U5o=;
 b=we8g5SATC0f0WEFU9jotrEvpRra6ESAJnbd8lK4+nPSN/63kBLwJhyzyACgIDbhk0B
 giIxJKY73UcmTwFW6cr3iFdUKi4XVq6d/+VJu+xQIi1XnON6ZMxXYpanUO/+i+e4pA64
 DxrZbY3vFlw+FDVKMUMVDjhXdaGQmkgUZVhMpXyYDS/3ghEsCETCsjdkyWCu3Q9dFla/
 FFyakwtB7oQo1MHWnhxBy42w+j8mgakKshxM37IwLYwrMX0syu8LKswpLRFXlHRnQ8VA
 adnWlF53qqVzULZo27rDsx4QoiZI2uYAX3K68GJ1n2/QFUiClkr1kMRtAR5PIe0c+6P2
 61gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367042; x=1699971842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nzv3ijX6aA4Ef+mTXMoyBo/VonVr+hfDPrYo/eu8U5o=;
 b=WSkQAbKGPQRwNNl4ot+Mkc2xDQ7+yRz+OC7N5Ng9GNv5G9JY/ikXZDHFK8FYaLQfiH
 ztyULz8HMFq5ysL87UCbvFaasrIo0Rfs0usPAi162WfyE0RVIYTlkZEc1qJVTC1iq1u7
 itKrpSzLwjXV4RzDzm4bYUFbP1TW6GR3ut/5znI7YYCZF8ZnEwr6A796JN7Jl4q3hSUW
 vgaqZ35GkGRrtfuhxZjHQPx/HTsrSwYpXfDEvXTpf3qkk+YHOyxCnNIfO8r8QO/e9lJO
 e0jHgsMzvpZq80L1/GkxLYxtNNbSCSeJTbUQKpJQ5qoE7al7HqQUOLlZP/HeG9XpW8Hq
 cghw==
X-Gm-Message-State: AOJu0YyOfbBBwJiVWgo5xWWOcRJ2wJEc6c7v/RYMsiDQs+gIuZrELPjo
 Wg8coIbAkZ/ceae8Cr/9OVi3Kg==
X-Google-Smtp-Source: AGHT+IHZiFbBOEiNHd37XNfd2owQyZh8LDB/c88LQs83ZvXb0iXDzn61N0UjYDur5ymwOZIlxbmtDw==
X-Received: by 2002:a05:600c:4fc8:b0:404:f9c1:d5d7 with SMTP id
 o8-20020a05600c4fc800b00404f9c1d5d7mr2354983wmq.25.1699367041931; 
 Tue, 07 Nov 2023 06:24:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh5-20020a05600c3d0500b004094e565e71sm16446623wmb.23.2023.11.07.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 446516575D;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 07/23] tests/avocado: update the tcg_plugins test
Date: Tue,  7 Nov 2023 14:23:38 +0000
Message-Id: <20231107142354.3151266-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

There are a number of things that are broken on the test currently so
lets fix that up:

  - replace retired Debian kernel for tuxrun_baseline one
  - remove "detected repeat instructions test" since ea185a55
  - log total counted instructions/memory accesses

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-8-alex.bennee@linaro.org>

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


