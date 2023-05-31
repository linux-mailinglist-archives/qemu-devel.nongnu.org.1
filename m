Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E56718AD6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S8N-0005Ya-RP; Wed, 31 May 2023 16:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8L-0005Wt-OM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:25 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S8J-0006pJ-Kn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:09:25 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f3b314b1d7so6985380e87.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563761; x=1688155761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=607LSsafa2oxkAIBHPCzkGNm8IQM/g1yzIcaBkYZjtM=;
 b=ZtgC7E2si61n7MtFqHudhreB2BIs4jgYhZaLvkRObaqbc0uIyZasQnbBfQF2Gfp03e
 oz5qIpSsLF3qr0RYv9LeH7QBxPYfyOHQrYO9qmKoRYi73oWWytS7fb8Pmj+jUorPDohv
 Rn1biIj23AxQwrcMVIp8Neyw2mrBfymobpYzDvW9ZYxGbFWNKWc1b29If0p7k+nxjwdR
 jWacDKZtuYhKVnq9OX3HBFBySl77k5CkxNZc4vubsj9TqsVIVS0OxE3z6STJR1tOunJG
 NaUWRwJYgpkmAeP7YhG0ReGf/aMhhc0P/83anLAAsxFWWF7HAdjPsMxPwQ2W9/pgnaCv
 JReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563761; x=1688155761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=607LSsafa2oxkAIBHPCzkGNm8IQM/g1yzIcaBkYZjtM=;
 b=QQGiR+aup5GBpvt/y5m4JYpd6sjCKmU8cZClPgSOOPg+ghkna6jV+VGQosoGqM+qOW
 473sApv/V6ysm3eMKTHcn4ChvLY+clkrVnHpvnm2XOJ1bod4Zy15OIoCNaO/SCkiGfWp
 N7lCO4Pl+VGRoTmqnMs4ML1M/8T9uZenl98VQIHd7DNQh2Gj/KBgLgEBzhJOKJ6sSljl
 gvKCh4ZS2hLzNT55zeQ1D8SUaD7Xo2rKq3vZiJk75h7Xzc8lPaQflAnImPkCoJJsSajm
 2ZEZodUcabbTICHeFXkfvDIaJLgno02sux3LUukvulRAVoabDiVNyOqvGyKKrT4cT+r5
 1UCw==
X-Gm-Message-State: AC+VfDzRF5xOcIFZYRhmOZHnJPLRdA+8yFyf3+0ZACloW+8puunGT6G3
 3NT4y8yvQ/ZA1LatVPwRju/Q2g==
X-Google-Smtp-Source: ACHHUZ4YQCVlLXxKmG40VVUpEbYlRhm5iH1YEUPKdXq05pLq/XUOzOtGyPKtAfLai0EmqM1Uq8dlkQ==
X-Received: by 2002:a19:c214:0:b0:4f3:bb14:bd40 with SMTP id
 l20-20020a19c214000000b004f3bb14bd40mr80346lfc.36.1685563756572; 
 Wed, 31 May 2023 13:09:16 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a7bc40a000000b003f606869603sm25434925wmi.6.2023.05.31.13.09.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:09:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>
Subject: [PATCH 1/3] tests/vm: Pass project source path to build_image()
Date: Wed, 31 May 2023 22:09:04 +0200
Message-Id: <20230531200906.17790-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531200906.17790-1-philmd@linaro.org>
References: <20230531200906.17790-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

To be able to use artifacts from the repository,
always pass the repository source path when building
a VM image.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/Makefile.include | 1 +
 tests/vm/basevm.py        | 4 ++--
 tests/vm/centos           | 2 +-
 tests/vm/centos.aarch64   | 2 +-
 tests/vm/freebsd          | 2 +-
 tests/vm/haiku.x86_64     | 2 +-
 tests/vm/netbsd           | 2 +-
 tests/vm/openbsd          | 2 +-
 tests/vm/ubuntuvm.py      | 2 +-
 9 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f0f5d32fb0..ff63038d85 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -117,6 +117,7 @@ vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
 		$(if $(LOG_CONSOLE),--log-console) \
+		--source-path $(SRC_PATH) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
 		--snapshot \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 23229e23d1..8ec021ddcf 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -261,7 +261,7 @@ def ssh_check(self, *cmd):
     def ssh_root_check(self, *cmd):
         self._ssh_do(self._config["root_user"], cmd, True)
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         raise NotImplementedError
 
     def exec_qemu_img(self, *args):
@@ -636,7 +636,7 @@ def main(vmcls, config=None):
                 sys.stderr.writelines(["Image file exists: %s\n" % args.image,
                                       "Use --force option to overwrite\n"])
                 return 1
-            return vm.build_image(args.image)
+            return vm.build_image(args.image, args.source_path)
         if args.build_qemu:
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
diff --git a/tests/vm/centos b/tests/vm/centos
index 097a9ca14d..009faceb9e 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -30,7 +30,7 @@ class CentosVM(basevm.BaseVM):
         make docker-test-quick@centos8 {verbose} J={jobs} NETWORK=1;
     """
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         cimg = self._download_with_cache("https://cloud.centos.org/centos/8-stream/x86_64/images/CentOS-Stream-GenericCloud-8-20220125.1.x86_64.qcow2")
         img_tmp = img + ".tmp"
         subprocess.check_call(['cp', '-f', cimg, img_tmp])
diff --git a/tests/vm/centos.aarch64 b/tests/vm/centos.aarch64
index 3f58de1e64..ce09a41b31 100755
--- a/tests/vm/centos.aarch64
+++ b/tests/vm/centos.aarch64
@@ -72,7 +72,7 @@ class CentosAarch64VM(basevm.BaseVM):
         # Call down to the base class method.
         super(CentosAarch64VM, self).boot(img, extra_args=extra_args)
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         cimg = self._download_with_cache(self.image_link)
         img_tmp = img + ".tmp"
         subprocess.run(['cp', '-f', cimg, img_tmp])
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 11de6473f4..6a0d7a4569 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -82,7 +82,7 @@ class FreeBSDVM(basevm.BaseVM):
         gmake --output-sync -j{jobs} {target} {verbose};
     """
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         self.print_step("Downloading disk image")
         cimg = self._download_with_cache(self.link, sha256sum=self.csum)
         tmp_raw = img + ".tmp.raw"
diff --git a/tests/vm/haiku.x86_64 b/tests/vm/haiku.x86_64
index 71cf75a9a3..7ee343415d 100755
--- a/tests/vm/haiku.x86_64
+++ b/tests/vm/haiku.x86_64
@@ -93,7 +93,7 @@ class HaikuVM(basevm.BaseVM):
         make --output-sync -j{jobs} {target} {verbose};
     """
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         self.print_step("Downloading disk image")
         tarball = self._download_with_cache(self.link, sha256sum=self.csum)
 
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c7e3f1e735..5bc5ca54ca 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -79,7 +79,7 @@ class NetBSDVM(basevm.BaseVM):
     # take more than a minute to be established.
     ipv6 = False
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         cimg = self._download_with_cache(self.link, sha512sum=self.csum)
         img_tmp = img + ".tmp"
         iso = img + ".install.iso"
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6b4fc29793..1464c52014 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -73,7 +73,7 @@ class OpenBSDVM(basevm.BaseVM):
     """
     poweroff = "halt -p"
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         self.print_step("Downloading install iso")
         cimg = self._download_with_cache(self.link, sha256sum=self.csum)
         img_tmp = img + ".tmp"
diff --git a/tests/vm/ubuntuvm.py b/tests/vm/ubuntuvm.py
index 6689ad87aa..1311fce4be 100644
--- a/tests/vm/ubuntuvm.py
+++ b/tests/vm/ubuntuvm.py
@@ -22,7 +22,7 @@ def __init__(self, args, config=None):
         self.login_prompt = "ubuntu-{}-guest login:".format(self.arch)
         basevm.BaseVM.__init__(self, args, config)
 
-    def build_image(self, img):
+    def build_image(self, img, src_path):
         """Build an Ubuntu VM image.  The child class will
            define the install_cmds to init the VM."""
         os_img = self._download_with_cache(self.image_link,
-- 
2.38.1


