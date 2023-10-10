Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D37BF4D7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7VS-0008Ox-JA; Tue, 10 Oct 2023 03:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VP-0008O1-2U
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:15 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq7VK-0004o3-Cu
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:50:14 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53d82bea507so394417a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696924208; x=1697529008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJhi36jVylnj85gu6IQc1ZcAE1kH76mXKOCIios85AY=;
 b=qEGgL0AWm+HeJOAXc6t6IQsPDKvgzW96BJMaZixySWL+TeAz4jfnrHcwXEBnGW0Rlu
 roC3a6o9qKTJqAIzmQelIJKUv71Q38Lwm79NHAGy0p3+3KAYAEQfFhZ4DD3haN6n7Tiq
 qwnYGiY9AxGVtV9AlNnX5FG44KBOuXanqr6MhIK2QRpU4wcJ4bofiC+o4wmMT1CG2AIO
 wKYx/0V2dhMWPWoVoPww/tZ6gx2+GklUc8LrwelZ4uAKGfW56KX+L6i9FfR0iVUTcCLS
 Rb0l3GranegmLojexc29MMuE0BunJWyW8RPCvQavch6D4e09iQYz/TugggPsh8wyEErD
 fPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924208; x=1697529008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FJhi36jVylnj85gu6IQc1ZcAE1kH76mXKOCIios85AY=;
 b=i52tkqCRn6jRgJz9QzeWhedyXpDC6ZS+4nwzUyyhgnaxNCgS6Q1QkqZn+qq4/Bz+7Z
 n3XnHUwuxSvh+5k02rj23r5OLCL/bo2D02SpsSINk+2fIndBXOC33Fi2KXz/7xyY93KZ
 u7xRVNrrHRadBHP47SIz8uBclKiug5j3aaIyLXjzCe+lIbA0WmMEpvo9niIYvl/eieQP
 O/vk64svheo/nOH/cJyjd3sQyAsl04gxg1czpdrN6jY/A8w94lKhqWWPSF69twCZ6Kke
 lYw6dB4/lWFaHbM+Jh++wcDh2Q/KE5aNxGSItPBEIj2C7e4RpWbGFLFTZoc955rKKNMQ
 QwRg==
X-Gm-Message-State: AOJu0YyW/Zo8grof/emCHhI98tYhq7mIzjnZMvKbDp1SYyk9C+611Tus
 9ZTJO3qXdzT2yIp166jGV54LU1MXpGGsFWPKCdAlBw==
X-Google-Smtp-Source: AGHT+IFVgI2xqatFWscv0PnIeGYbb4LpnbM0EIlDStGkK15CLtZCb/cUWX0GZO+Wy0qHg5G387NnoQ==
X-Received: by 2002:a17:907:7603:b0:9b2:b633:ada2 with SMTP id
 jx3-20020a170907760300b009b2b633ada2mr15704652ejc.36.1696924208060; 
 Tue, 10 Oct 2023 00:50:08 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 lr5-20020a170906fb8500b009adcb6c0f0esm8004696ejb.193.2023.10.10.00.50.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 00:50:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 2/4] tests/qtest: Use qtest_get_arch_bits()
Date: Tue, 10 Oct 2023 09:49:50 +0200
Message-ID: <20231010074952.79165-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010074952.79165-1-philmd@linaro.org>
References: <20231010074952.79165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/arm-cpu-features.c | 49 ++++++++++++++++------------------
 tests/qtest/bios-tables-test.c | 16 +++++------
 2 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index a8a4c668ad..b6c1b430c1 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -462,7 +462,7 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
     assert_has_not_feature(qts, "max", "kvm-steal-time");
 
-    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+    if (qtest_get_arch_bits() == 64) {
         assert_has_feature_enabled(qts, "max", "aarch64");
         assert_has_feature_enabled(qts, "max", "sve");
         assert_has_feature_enabled(qts, "max", "sve128");
@@ -507,7 +507,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
     assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
     assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
-    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+    if (qtest_get_arch_bits() == 64) {
         bool kvm_supports_steal_time;
         bool kvm_supports_sve;
         char max_name[8], name[8];
@@ -636,34 +636,31 @@ int main(int argc, char **argv)
                             NULL, test_query_cpu_model_expansion);
     }
 
-    if (!g_str_equal(qtest_get_arch(), "aarch64")) {
-        goto out;
-    }
-
-    /*
-     * For now we only run KVM specific tests with AArch64 QEMU in
-     * order avoid attempting to run an AArch32 QEMU with KVM on
-     * AArch64 hosts. That won't work and isn't easy to detect.
-     */
-    if (qtest_has_accel("kvm")) {
+    if (qtest_get_arch_bits() == 64) {
         /*
-         * This tests target the 'host' CPU type, so register it only if
-         * KVM is available.
+         * For now we only run KVM specific tests with AArch64 QEMU in
+         * order avoid attempting to run an AArch32 QEMU with KVM on
+         * AArch64 hosts. That won't work and isn't easy to detect.
          */
-        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
-                            NULL, test_query_cpu_model_expansion_kvm);
+        if (qtest_has_accel("kvm")) {
+            /*
+             * This tests target the 'host' CPU type, so register it only if
+             * KVM is available.
+             */
+            qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
+                                NULL, test_query_cpu_model_expansion_kvm);
 
-        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-off",
-                            NULL, sve_tests_sve_off_kvm);
+            qtest_add_data_func("/arm/kvm/query-cpu-model-expansion/sve-off",
+                                NULL, sve_tests_sve_off_kvm);
+        }
+
+        if (qtest_has_accel("tcg")) {
+            qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-vq-8",
+                                NULL, sve_tests_sve_max_vq_8);
+            qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-off",
+                                NULL, sve_tests_sve_off);
+        }
     }
 
-    if (qtest_has_accel("tcg")) {
-        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-vq-8",
-                            NULL, sve_tests_sve_max_vq_8);
-        qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-off",
-                            NULL, sve_tests_sve_off);
-    }
-
-out:
     return g_test_run();
 }
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f8e03dfd46..7e708d78b3 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2089,7 +2089,7 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/piix4/nohpet", test_acpi_piix4_tcg_nohpet);
 
             /* i386 does not support memory hotplug */
-            if (strcmp(arch, "i386")) {
+            if (qtest_get_arch_bits() == 64) {
                 qtest_add_func("acpi/piix4/memhp", test_acpi_piix4_tcg_memhp);
                 qtest_add_func("acpi/piix4/dimmpxm",
                                test_acpi_piix4_tcg_dimm_pxm);
@@ -2127,7 +2127,7 @@ int main(int argc, char *argv[])
                            test_acpi_q35_tcg_acpi_hmat_noinitiator);
 
             /* i386 does not support memory hotplug */
-            if (strcmp(arch, "i386")) {
+            if (qtest_get_arch_bits() == 64) {
                 qtest_add_func("acpi/q35/memhp", test_acpi_q35_tcg_memhp);
                 qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
                 qtest_add_func("acpi/q35/acpihmat",
@@ -2164,15 +2164,13 @@ int main(int argc, char *argv[])
                            test_acpi_microvm_ioapic2_tcg);
             qtest_add_func("acpi/microvm/oem-fields",
                            test_acpi_microvm_oem_fields);
-            if (has_tcg) {
-                if (strcmp(arch, "x86_64") == 0) {
-                    qtest_add_func("acpi/microvm/pcie",
-                                   test_acpi_microvm_pcie_tcg);
+            if (has_tcg && qtest_get_arch_bits() == 64) {
+                qtest_add_func("acpi/microvm/pcie",
+                               test_acpi_microvm_pcie_tcg);
 #ifdef CONFIG_POSIX
-                    qtest_add_func("acpi/microvm/acpierst",
-                                   test_acpi_microvm_acpi_erst);
+                qtest_add_func("acpi/microvm/acpierst",
+                               test_acpi_microvm_acpi_erst);
 #endif
-                }
             }
         }
     } else if (strcmp(arch, "aarch64") == 0) {
-- 
2.41.0


