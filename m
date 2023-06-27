Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D9740071
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGY-0000Yi-88; Tue, 27 Jun 2023 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGS-0000GK-Vv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:10:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGL-0005qq-Ko
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:10:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fa99742be2so24583625e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882192; x=1690474192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AouWM1m7VIgcxf/wQ9k/4ktgNJVDqALSrdqBKb0paEY=;
 b=wvW1HvP5yacSa0TCKJyExmhxaw2dfkqufC6nOxOHNAL6jR649ZIw2e7bYk825U85J/
 vkXUaTLLCLIrOmcDM/cLqXLpfUQd8Cjn9WEWkwJwFKcm3nFmFRvM4TOu9qhPvhFX/s5F
 dklH0YcRLh8NPqjV7DFe4FvufX2aunp1zMUVk1gNJ1FBFndENTnOKbEjc5D/Yao8XLr2
 LaKSwawvb/JEVWT+MQZ+Kxi8dm/QAN96XN2DF74kc65fzATATPcXQs76TyMS+Vk7YzBw
 H86EYZL7C8gvA0DPFeL9rlD6F6dNzHx0SCA5nQyh41vwOc/hAzOJHlqQgppbmRfjl9AY
 DTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882192; x=1690474192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AouWM1m7VIgcxf/wQ9k/4ktgNJVDqALSrdqBKb0paEY=;
 b=i/tzrzSujsVTFGNNTnGd06MrWUtES5ibsOVL5gdlNPgQYEKC5lxctg5xBYVdLWhcLr
 U0iPBrV0Cmlr80elcQhRZwyJKd3fukoyTEJwSvKU2PqIDVPQIXQhYRQ3fpE2hlEh1nBy
 u+04NeyqLkbYy2jnzac7doGkuNJ3piscZTfpk8wNyeoDpskYzmNve6qQFXLguOwF9S6h
 c2GYgCPT95Mun7jJHP2xKKZKVCOdp+9nqyt2T2/U37rRocTrU/tU4HK9GHQb5FornViL
 RMWZk9ADvLuNVWe7fkPDoW8fr2zXpNTCifzoljOYQHlIBmQJ5/EhAB2Bmpk75G5ie87C
 8qIA==
X-Gm-Message-State: AC+VfDwhxACEI6Ammis6VhbSNtRY/TSP8BBChpoX4g9uHXpiA3WMts3J
 5ovFbxpvBmsgdTmo/mlY9dO4UQ==
X-Google-Smtp-Source: ACHHUZ69iGGTivZ/JtP7+MCpcmJZhtMqOtXMtVcsIt4JlBVqvG2uP9yd0qadcQY6nZN/PE4rsgc3tw==
X-Received: by 2002:a1c:7705:0:b0:3fa:c3e8:901a with SMTP id
 t5-20020a1c7705000000b003fac3e8901amr3686273wmi.25.1687882192195; 
 Tue, 27 Jun 2023 09:09:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003fba2734f1esm2525151wmc.1.2023.06.27.09.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BE23F1FFC8;
 Tue, 27 Jun 2023 17:09:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 16/36] tests/avocado: update firmware to enable sbsa-ref/max
Date: Tue, 27 Jun 2023 17:09:23 +0100
Message-Id: <20230627160943.2956928-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Update prebuilt firmware images to have TF-A with FEAT_FGT support
enabled. This allowed us to enable test for "max" cpu in sbsa-ref
machine.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - re-enable for CI
---
 tests/avocado/machine_aarch64_sbsaref.py | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 0a79fa7ab6..cce6ef9f65 100644
--- a/tests/avocado/machine_aarch64_sbsaref.py
+++ b/tests/avocado/machine_aarch64_sbsaref.py
@@ -29,23 +29,23 @@ def fetch_firmware(self):
         """
         Flash volumes generated using:
 
-        - Fedora GNU Toolchain version 12.2.1 20220819 (Red Hat Cross 12.2.1-2)
+        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 13.1.1-2)
 
         - Trusted Firmware-A
-          https://github.com/ARM-software/arm-trusted-firmware/tree/5fdb2e54
+          https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
 
         - Tianocore EDK II
-          https://github.com/tianocore/edk2/tree/494127613b
-          https://github.com/tianocore/edk2-non-osi/tree/41876073
-          https://github.com/tianocore/edk2-platforms/tree/8efa4f42
+          https://github.com/tianocore/edk2/tree/0f9283429dd4
+          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
+          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04
         """
 
         # Secure BootRom (TF-A code)
         fs0_xz_url = (
-            "https://fileserver.linaro.org/s/ATnSmq6k8SoXgbH/"
+            "https://fileserver.linaro.org/s/HrYMCjP7MEccjRP/"
             "download/SBSA_FLASH0.fd.xz"
         )
-        fs0_xz_hash = "a210a09692bcbe0a3743ffd0df44e80e0c7ad8ab"
+        fs0_xz_hash = "447eff64a90b84ce47703c6ec41fbfc25befaaea"
         tar_xz_path = self.fetch_asset(fs0_xz_url, asset_hash=fs0_xz_hash)
         archive.extract(tar_xz_path, self.workdir)
         fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
@@ -93,15 +93,15 @@ def test_sbsaref_edk2_firmware(self):
 
         # AP Trusted ROM
         wait_for_console_pattern(self, "Booting Trusted Firmware")
-        wait_for_console_pattern(self, "BL1: v2.8(release):v2.8")
+        wait_for_console_pattern(self, "BL1: v2.9(release):v2.9")
         wait_for_console_pattern(self, "BL1: Booting BL2")
 
         # Trusted Boot Firmware
-        wait_for_console_pattern(self, "BL2: v2.8(release)")
+        wait_for_console_pattern(self, "BL2: v2.9(release)")
         wait_for_console_pattern(self, "Booting BL31")
 
         # EL3 Runtime Software
-        wait_for_console_pattern(self, "BL31: v2.8(release)")
+        wait_for_console_pattern(self, "BL31: v2.9(release)")
 
         # Non-trusted Firmware
         wait_for_console_pattern(self, "UEFI firmware (version 1.0")
@@ -136,21 +136,18 @@ def boot_alpine_linux(self, cpu):
         self.vm.launch()
         wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
 
-    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")
     def test_sbsaref_alpine_linux_cortex_a57(self):
         """
         :avocado: tags=cpu:cortex-a57
         """
         self.boot_alpine_linux("cortex-a57")
 
-    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")
     def test_sbsaref_alpine_linux_neoverse_n1(self):
         """
         :avocado: tags=cpu:max
         """
         self.boot_alpine_linux("neoverse-n1")
 
-    @skip("requires TF-A update to handle FEAT_FGT")
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
-- 
2.39.2


