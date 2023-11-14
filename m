Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FDE7EA89D
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2isN-0001Qy-Qg; Mon, 13 Nov 2023 21:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isL-0001Q3-PX
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:10:01 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isJ-0007cN-2o
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 21:10:01 -0500
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-5c184b3bbc4so1507277a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 18:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927797; x=1700532597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKng5jW02pfTHM8qdP5SDtXR0Tx7XEwnbKFIYpevwgw=;
 b=ZJD+Q0HHzibOc4tshZvlKF5ng6NfpWZOokXfELxfBV5oWXdMGGfq98CO0WyRk/DiEH
 Q+zdT5+xJv43ml12zogbE+k7sORorbUa1dUSQlRFr3Idpx2GSXe9f20mLG7G8mkC98tW
 6AvtNIi/hQR9PlrfehO8Kl8p01yqphBN8vBhViTi2jJjxrYfCCaXayMU4T7YIM0jclZ0
 MsEI2AS2Eowh1HmsVsm/5bbhaQh2jZC+1QhvXxwCGAu8ZiXc2YsvgI+s7GFVWFD/sIvG
 35At6nMR8YcKxWBSVibfwXW+8yWfXAmF1f+vDva3Wrc6Lx+EWt6tB0bVzrtjNZqikDBl
 SUzA==
X-Gm-Message-State: AOJu0Yww3w/4VCeHrJY4UFSY2ivz+PkmeBjb3ovXJgXMpodn0igWWEhI
 JIXcwBxb3PK5i1aXQprSRRrCfAsl/wF9Jw==
X-Google-Smtp-Source: AGHT+IFPHKYXRxig3YZ6/NdufQnSjhVrgOplFvuUcwq4isRvQy5PasPdMmVh0UStoRrmeaJw2yH3jw==
X-Received: by 2002:a05:6a20:4424:b0:169:7d6f:9f22 with SMTP id
 ce36-20020a056a20442400b001697d6f9f22mr10622495pzb.54.1699927797673; 
 Mon, 13 Nov 2023 18:09:57 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:56 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v5 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Date: Mon, 13 Nov 2023 18:09:22 -0800
Message-ID: <20231114020927.62315-13-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.215.172; envelope-from=osy86dev@gmail.com;
 helo=mail-pg1-f172.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/bios-tables-test.c | 43 ++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 71af5cf69f..bb4ebf00c1 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1447,6 +1447,28 @@ static void test_acpi_piix4_tcg_numamem(void)
 
 uint64_t tpm_tis_base_addr;
 
+static test_data tcg_tpm_test_data(const char *machine)
+{
+    if (g_strcmp0(machine, "virt") == 0) {
+        test_data data = {
+            .machine = "virt",
+            .tcg_only = true,
+            .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+            .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+            .cd =
+               "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+            .ram_start = 0x40000000ULL,
+            .scan_len = 128ULL * 1024 * 1024,
+        };
+        return data;
+    } else {
+        test_data data = {
+            .machine = machine,
+        };
+        return data;
+    }
+}
+
 static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
                               uint64_t base, enum TPMVersion tpm_version)
 {
@@ -1454,7 +1476,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
                                           machine, tpm_if);
     char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
     TPMTestState test;
-    test_data data = {};
+    test_data data = tcg_tpm_test_data(machine);
     GThread *thread;
     const char *suffix = tpm_version == TPM_VERSION_2_0 ? "tpm2" : "tpm12";
     char *args, *variant = g_strdup_printf(".%s.%s", tpm_if, suffix);
@@ -1474,13 +1496,14 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
     thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
     tpm_emu_test_wait_cond(&test);
 
-    data.machine = machine;
     data.variant = variant;
 
     args = g_strdup_printf(
+        " %s"
         " -chardev socket,id=chr,path=%s"
         " -tpmdev emulator,id=dev,chardev=chr"
         " -device tpm-%s,tpmdev=dev",
+        g_strcmp0(machine, "virt") == 0 ? "-cpu cortex-a57" : "",
         test.addr->u.q_unix.path, tpm_if);
 
     test_acpi_one(args, &data);
@@ -1506,6 +1529,16 @@ static void test_acpi_q35_tcg_tpm12_tis(void)
     test_acpi_tcg_tpm("q35", "tis", 0xFED40000, TPM_VERSION_1_2);
 }
 
+static void test_acpi_q35_tcg_tpm2_crb(void)
+{
+    test_acpi_tcg_tpm("q35", "crb", 0xFED40000, TPM_VERSION_2_0);
+}
+
+static void test_acpi_virt_tcg_tpm2_crb(void)
+{
+    test_acpi_tcg_tpm("virt", "crb-device", 0xFED40000, TPM_VERSION_2_0);
+}
+
 static void test_acpi_tcg_dimm_pxm(const char *machine)
 {
     test_data data = {};
@@ -2212,6 +2245,9 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/tpm12-tis",
                                test_acpi_q35_tcg_tpm12_tis);
             }
+            if (tpm_model_is_available("-machine q35", "tpm-crb")) {
+                qtest_add_func("acpi/q35/tpm2-crb", test_acpi_q35_tcg_tpm2_crb);
+            }
             qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
             qtest_add_func("acpi/q35/no-acpi-hotplug",
                            test_acpi_q35_tcg_no_acpi_hotplug);
@@ -2301,6 +2337,9 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
             }
         }
+        if (tpm_model_is_available("-machine virt", "tpm-crb")) {
+            qtest_add_func("acpi/virt/tpm2-crb", test_acpi_virt_tcg_tpm2_crb);
+        }
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
2.41.0


