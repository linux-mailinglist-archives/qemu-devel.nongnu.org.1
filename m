Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440E673B742
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwl-0001M9-DI; Fri, 23 Jun 2023 08:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwJ-0001AQ-RF
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwD-0000UB-8z
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3112902f785so1715129f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523452; x=1690115452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBdNTeWY2HuOCU9nu+Z3lWX8HamSwCQjIvaXqYAw/FM=;
 b=cxAUoZ9QqI5vpS0Gf2MwXF96k47tsBIYETssMEAeR/6PVVyCDclikStNnXkjx8jEaq
 5dkTwIBzNHv4rPbznJfZwBQVQScBWuxUGRGIfTXSbdPY0VJy3wXz8NhxtaGKDt2VQuQe
 RQRHOyw+R3Cg4jxt9Aq8owKAeEJuTsrwr4zjGwQEa2PQS0YdbUYJxERZQiBFGcfkZXLe
 1U+L8kWLZ26YRR82GVoLHa8zshMUblXGaq6qs9DdrXx4lw2kuLJq0X7oFDgeycdne2/A
 5eobd08aeaafITnlD6Q+LuijM5592ZdbyXAmRvxDpy1CrCAKvLSF2OAKp+qWsZMt86l7
 38QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523452; x=1690115452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KBdNTeWY2HuOCU9nu+Z3lWX8HamSwCQjIvaXqYAw/FM=;
 b=kwOLedQGFYp0OLv1N87j86C7sxHwpcmaTb+L6UC1J4QiQ2wffH2bMZLCYw+/kKwyKU
 wYQknVVeuR/hfggalorkYzzMfaVyR5tsucqeKK7e+Kpo/4kbM13jMYYdoUxKcKnXr+WO
 9V7qlgp1caM4qvCc7jc8f9SoDaPRYyGb+0dY8GZo8PLKNfVVZP4Qmq1GcyGRoD0VmH16
 vfspynKX0sEc6zByrZ8m6s7uLXz/qgrCZS6cnArMpSMfQboqw9UWz57n9TA8/gVpRtfc
 0nn5oU1GKeobTW57j3QHkssO5xVUPkq8t7LQ5Vjy6EUgtOdqflB8vTCokRjoVyAqqVMc
 j7uA==
X-Gm-Message-State: AC+VfDwf5zC5uqh+UU1rPdW4SlF0juvVpXUd4cAia5AKsvsq6W4YjVsi
 GezIiJ2vS0PWtXctG9pvzGR8jQ==
X-Google-Smtp-Source: ACHHUZ5i8O5Q6q3CyIXDseXZlDtBiedSnCr1W1Zj/UIjiFQNpR5QQMWmq2wyhGajyI5ojT6JIAbS3Q==
X-Received: by 2002:adf:e403:0:b0:311:10ae:123e with SMTP id
 g3-20020adfe403000000b0031110ae123emr21026341wrm.2.1687523451874; 
 Fri, 23 Jun 2023 05:30:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a5d6390000000b003113943bb66sm9344371wru.110.2023.06.23.05.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EF031FFC8;
 Fri, 23 Jun 2023 13:21:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 17/26] tests/avocado: update firmware to enable sbsa-ref/max
Date: Fri, 23 Jun 2023 13:20:51 +0100
Message-Id: <20230623122100.1640995-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Update prebuilt firmware images to have TF-A with FEAT_FGT support
enabled. This allowed us to enable test for "max" cpu in sbsa-ref
machine.

Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-Id: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
index 0a79fa7ab6..35f8042416 100644
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
@@ -150,7 +150,7 @@ def test_sbsaref_alpine_linux_neoverse_n1(self):
         """
         self.boot_alpine_linux("neoverse-n1")
 
-    @skip("requires TF-A update to handle FEAT_FGT")
+    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")
     def test_sbsaref_alpine_linux_max(self):
         """
         :avocado: tags=cpu:max
-- 
2.39.2


