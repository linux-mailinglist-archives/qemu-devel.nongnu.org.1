Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAE7DAB00
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyub-0002IF-6i; Sun, 29 Oct 2023 02:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuZ-0002Hh-3L
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:35 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyuX-0001qw-H4
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:34 -0400
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1cc20df5187so13299065ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559472; x=1699164272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nuscoz291z8WpcIaXKhR38XyrQtqiMMj+7E51FRZ7cM=;
 b=FoIByUWsXZw1tQU4VJQF5Evq67/85MPnecSRrprPmq+DFBrVuEpyWzHUA52g9IKv/y
 FtTooN+ksIU/Km6kxDu1iHnt6Wk3A3mi9RXlqySi3hOkHt7cHIs7szfPTjkQGb3xJa/W
 KfZren/olfR9Qe+ZmBZfXKu1qy0sourYmQ4zZWm0N1Bq5/X5k8riXWgxDyXQtfFKpq/T
 A3MeFVBF2VMS0QgTmvjLBB2OqNodZRKcAUqvup64eo5hkrdUfxyoSAQ/24PkWcoXMaKX
 KT5u/48kutOcPE2QVVFSnrtTrCR0MSFq99haRtDsPy3RoxvOoR7FaIXr0mmNKssNcYAW
 9SaQ==
X-Gm-Message-State: AOJu0YxV+Fa6xEPrsbLDc26qVCgfq0ISuFOnAFSTYmOSWwE7rQaS1FeK
 qcdjYNMy+LfGtZP11EJyDOVrpVcd/kpYVg==
X-Google-Smtp-Source: AGHT+IGZg6DjETtPW7DgBbZjDrlp7dfMdIRa2lhpjXzOhAH27uKl8WTEIxvjqkQfy3mRrKv8JkbVTQ==
X-Received: by 2002:a17:902:ecd0:b0:1c6:362:3553 with SMTP id
 a16-20020a170902ecd000b001c603623553mr9103735plh.31.1698559471944; 
 Sat, 28 Oct 2023 23:04:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:31 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Date: Sat, 28 Oct 2023 23:03:25 -0700
Message-ID: <20231029060404.71196-13-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.178; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f178.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 tests/qtest/bios-tables-test.c | 43 ++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 9f4bc15aab..c63bad0205 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1345,6 +1345,28 @@ static void test_acpi_piix4_tcg_numamem(void)
 
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
@@ -1352,7 +1374,7 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
                                           machine, tpm_if);
     char *tmp_path = g_dir_make_tmp(tmp_dir_name, NULL);
     TPMTestState test;
-    test_data data = {};
+    test_data data = tcg_tpm_test_data(machine);
     GThread *thread;
     const char *suffix = tpm_version == TPM_VERSION_2_0 ? "tpm2" : "tpm12";
     char *args, *variant = g_strdup_printf(".%s.%s", tpm_if, suffix);
@@ -1372,13 +1394,14 @@ static void test_acpi_tcg_tpm(const char *machine, const char *tpm_if,
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
@@ -1404,6 +1427,16 @@ static void test_acpi_q35_tcg_tpm12_tis(void)
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
@@ -2110,6 +2143,9 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/tpm12-tis",
                                test_acpi_q35_tcg_tpm12_tis);
             }
+            if (tpm_model_is_available("-machine q35", "tpm-crb")) {
+                qtest_add_func("acpi/q35/tpm2-crb", test_acpi_q35_tcg_tpm2_crb);
+            }
             qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
             qtest_add_func("acpi/q35/no-acpi-hotplug",
                            test_acpi_q35_tcg_no_acpi_hotplug);
@@ -2191,6 +2227,9 @@ int main(int argc, char *argv[])
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


