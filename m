Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215517C503E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXF-0001UC-Ad; Wed, 11 Oct 2023 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX4-0001IF-L4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX0-0005AD-IB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32799639a2aso6389339f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020411; x=1697625211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNLSv//wR6uRCDovOJDJ5d1PCh7jcwjttvZeRMsQErI=;
 b=fou8euu/hWCUrenPxikhQbXrfaEHl7cdfOImoO0llOeY2iy83TLdoxDITcMldlVdTj
 xGE8aPKRPd0rH8mteEq+73iJ8KaPenshhNt2iYQUVLR6Va4fw7WTZv8EH9tqE+ZMNdET
 rqdt4DrBpw1OwarRe7dGN/78ijoH4QIyw4gwiMyHvYPPhA9aQcW9/eRP1Nc1ZAt1w4j5
 bKQ7oiA5fY2Hx5UDrQITZIOYWq8wm8JmbpSZzqGbz+L2XtM2z5+5mI+Yct7/q0hfERsX
 2UQN6UzKYu/74G6RO5un5WcsDCp68tRwFkNEjaCYRKsZTD1x8UIF1Yhr67OHTdAXKGJY
 A/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020411; x=1697625211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNLSv//wR6uRCDovOJDJ5d1PCh7jcwjttvZeRMsQErI=;
 b=jq90kBSmX8gS3P9dt6IXh+qMFXNv4SqIa2VpU++b8mOcgw4I5rNWXpplYDZaHf3hMv
 1NJHJlikG5EdJNNgJjpR8xJWt/jtE3quUtdat2P0Gj5j7IaK0JEGF3fNSr/PvFHTBWCv
 Zp6Js4CLdEoJbPb4q8IU8u9HDEnU8CbOJmJvxaGo8Xm1jiWg0eJ9hLHfQ+/Pa5+OlV9k
 8yI+4UUZLbqVkYEeDqqPi/Ea3a0QOJ5RlntK9udQIN81fuqqDeUaLNt4wvKjnbnIG8OP
 DDEP0KoybLUEEmV0Q/tEnaV5J3lTFwWEbPxN3Se/XyXQbgOUv3NN1PcB/rg2A9ohNP/V
 5iLQ==
X-Gm-Message-State: AOJu0YzsTCkiZteIhy1pkQ/RD77Eh2v8kXA7xSjTbvqzK9C7/AZP4RJg
 j0/YG0NwllQTmpXJL3Iz97oz8w==
X-Google-Smtp-Source: AGHT+IERdxUixou9cUeyAxW2i/kkobT8A9hLjEFKWeGuehBvsGbD0qSeVtnGj5CtdVp26t+FGnFYtw==
X-Received: by 2002:a5d:5c0e:0:b0:32c:c35c:2eea with SMTP id
 cc14-20020a5d5c0e000000b0032cc35c2eeamr4243920wrb.6.1697020410899; 
 Wed, 11 Oct 2023 03:33:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000024c00b0032d88e370basm950574wrz.34.2023.10.11.03.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:30 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 346BB1FFBC;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org (open list:SBSA-REF)
Subject: [PULL 01/25] tests/avocado: update firmware to enable OpenBSD test on
 sbsa-ref
Date: Wed, 11 Oct 2023 11:33:05 +0100
Message-Id: <20231011103329.670525-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Update prebuilt firmware images:
- Neoverse V1/N2 cpu support
- non-secure EL2 virtual timer
- XHCI controller in DSDT

With those changes we can now run OpenBSD as part of sbsa-ref tests.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <20230927120050.210187-2-marcin.juszkiewicz@linaro.org>
[AJB: fix whitespace and longline]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-2-alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index a794245e7e..b272053eaf 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -28,33 +28,33 @@ def fetch_firmware(self):
         """
         Flash volumes generated using:
 
-        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 13.1.1-2)
+        - Fedora GNU Toolchain version 13.2.1 20230728 (Red Hat 13.2.1-1)
 
         - Trusted Firmware-A
-          https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
+          https://github.com/ARM-software/arm-trusted-firmware/tree/7c3ff62d
 
         - Tianocore EDK II
           https://github.com/tianocore/edk2/tree/0f9283429dd4
-          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
-          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04
+          https://github.com/tianocore/edk2/tree/ad1c0394b177
+          https://github.com/tianocore/edk2-platforms/tree/d03a60523a60
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
-            "https://fileserver.linaro.org/s/HrYMCjP7MEccjRP/"
+            "https://fileserver.linaro.org/s/rE43RJyTfxPtBkc/"
             "download/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "447eff64a90b84ce47703c6ec41fbfc25befaaea"
+        fs0_xz_hash = "cdb8e4ffdaaa79292b7b465693f9e5fae6b7062d"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash)
         archive.extract(tar_xz_path, self.workdir)
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
 
         # Non-secure rom (UEFI and EFI variables)
         fs1_xz_url = (
-            "https://fileserver.linaro.org/s/t8foNnMPz74DZZy/"
+            "https://fileserver.linaro.org/s/AGWPDXbcqJTKS4R/"
             "download/SBSA_FLASH1.fd.xz"
         )
-        fs1_xz_hash = "13a9a262953787c7fc5a9155dfaa26e703631e02"
+        fs1_xz_hash = "411155ae6984334714dff08d5d628178e790c875"
         tar_xz_path = self.fetch_asset(fs1_xz_url, asset_hash=fs1_xz_hash)
         archive.extract(tar_xz_path, self.workdir)
         fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
@@ -144,7 +144,7 @@ def test_sbsaref_alpine_linux_cortex_a57(self):
 
     def test_sbsaref_alpine_linux_neoverse_n1(self):
         """
-        :avocado: tags=cpu:max
+        :avocado: tags=cpu:neoverse-n1
         """
         self.boot_alpine_linux("neoverse-n1")
 
@@ -152,4 +152,54 @@ def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
         """
-        self.boot_alpine_linux("max,pauth-impdef=on")
+        self.boot_alpine_linux("max")
+
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_openbsd73(self, cpu):
+        self.fetch_firmware()
+
+        img_url = (
+            "https://cdn.openbsd.org/pub/OpenBSD/7.3/arm64/miniroot73.img"
+        )
+
+        img_hash = "7fc2c75401d6f01fbfa25f4953f72ad7d7c18650056d30755c44b9c129b707e5"
+        img_path = self.fetch_asset(img_url, algorithm="sha256", asset_hash=img_hash)
+
+        self.vm.set_console()
+        self.vm.add_args(
+            "-cpu",
+            cpu,
+            "-drive",
+            f"file={img_path},format=raw",
+            "-device",
+            "virtio-rng-pci,rng=rng0",
+            "-object",
+            "rng-random,id=rng0,filename=/dev/urandom",
+        )
+
+        self.vm.launch()
+        wait_for_console_pattern(self,
+                                 "Welcome to the OpenBSD/arm64"
+                                 " 7.3 installation program.")
+
+    def test_sbsaref_openbsd73_cortex_a57(self):
+        """
+        :avocado: tags=cpu:cortex-a57
+        """
+        self.boot_openbsd73("cortex-a57")
+
+    def test_sbsaref_openbsd73_neoverse_n1(self):
+        """
+        :avocado: tags=cpu:neoverse-n1
+        """
+        self.boot_openbsd73("neoverse-n1")
+
+    def test_sbsaref_openbsd73_max(self):
+        """
+        :avocado: tags=cpu:max
+        """
+        self.boot_openbsd73("max")
+
-- 
2.39.2


