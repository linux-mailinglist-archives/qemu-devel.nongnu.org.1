Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1557DE1C4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:51:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBc2-0001wt-4X; Wed, 01 Nov 2023 09:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyBby-0001uq-6k
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:50:23 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyBbn-0001Y8-5i
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 09:50:21 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so97741081fa.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698846608; x=1699451408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=65Q39Xa13SVlTaipeikSzc52X5lKj+6VWg/aEmU5DfA=;
 b=YcNSDiOgZYAsBCP+tYyNPsCuek4Iaf8YqhYazkNAavJpg5Vh5Y06TALe02Knaqm0yN
 jb8KCZGYnCqQVnwGF0uvMamqwF3JOXvxIaaYmp4mFCCQhN0kalLpjdnMqKKaXBLediJb
 HUWAnX+oOS+ikcjJ2D+Q+eEKlTYuBV/qXv2sCAI+remCPyqoOZPiGyHqEWBG/dRYu+uS
 HDHBWpUT+v44kFW3KAHiPaCllaCZvxxYhcpnSs+2cXQQnSIVmzcrElANchlESTDKAsfJ
 Y8KookUPFoVAxp7xWL4FBEupad+g3yOBpl1tQai6vM87sHrg+VgcXRne5A1NtidAcwsE
 8XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698846608; x=1699451408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=65Q39Xa13SVlTaipeikSzc52X5lKj+6VWg/aEmU5DfA=;
 b=Wtu80H05+4EQNolElNrHb+RAcDGNDpoWIlC7A9i97WCur+xqNh/3KobQwzBMWsjzO/
 MdNnpeL24Zk6GwYzkOxso+4omD0RFe7V8QFLv2hJNwWMn0GZFSXbfY977iZUSIcSmMg4
 +sIhWIRJElI635ptDwrqqyf9EPIZ7FoC8MNBhFbJnNg0d5INTvIz1mwKllQFDTmH15Hp
 Y8lBW1JTXFh/ooA9Qx+oQstwFeBoarRLpfeKIz9MlNM3s0SqKdfgd7wmQa6zNgZlEBer
 oIIhmiA33LMvBYXR8qgUNeV9IvUI1jyJGBKskKzAPkH8+xs714AYTbApncRGRG5UPmww
 oxUg==
X-Gm-Message-State: AOJu0YzZ185pa7a2ehHD3Xi33q12C2Rss++7sdFF6II39cnKBUnN0cqM
 laJ8iNahoKTnXPCwIJ0sOdutTQ==
X-Google-Smtp-Source: AGHT+IGC2XV3eR3fd+Z1AFtjUm9lqUmtMWLThRBQmUcUSD8QPIzyXKVs3p8LEpZhpqn/Nk7LVFBqxw==
X-Received: by 2002:a2e:9943:0:b0:2c5:21e3:f21a with SMTP id
 r3-20020a2e9943000000b002c521e3f21amr12815356ljj.53.1698846608492; 
 Wed, 01 Nov 2023 06:50:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b004065e235417sm1674382wmq.21.2023.11.01.06.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 06:50:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABF8165736;
 Wed,  1 Nov 2023 13:50:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] tests/avocado: update the tcg_plugins test
Date: Wed,  1 Nov 2023 13:50:03 +0000
Message-Id: <20231101135004.1572916-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


