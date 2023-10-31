Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B157DC51C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:02:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfwD-0001RP-42; Tue, 31 Oct 2023 00:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfw0-0001Oa-Cw
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:56 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvw-0005HD-Qg
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:56 -0400
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-28094a3b760so701569a91.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724846; x=1699329646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qd86jWlgzkg+eO1hW65y82qGz6c0d2FhG9aAGpNoykU=;
 b=YJU9CzOZ7WzzyQz0dQRzB2H2RVPWyLkysTEVieBaVL657DRwC8SUKpwU/KRdmTMel1
 QxOsp2cso2V26OVKQbdd7Vw8UVPz1IlpQsUxBIUQm5fxCgfGptSdlDmpy309ZGkl03MK
 5HG+b+oTuYdJv97bVAFhCMlR8HQOONQdz5UiekgRHR3i4wWlOpGfWF9Z9C7oUxotVMgg
 Tysb2aqyipWf9o6qMNEar6IdNmry34q8GUBq1oOWzpHuP87F81KlKmpjlpo9InzW9pnq
 wnUy3G5lpdL81e9cET/N1Batp5U0BEcF7Z9LKvPhxpClRXphivL87Lev302tSyMhn/Np
 g+eg==
X-Gm-Message-State: AOJu0Yw9CGNkVCYtv7CNoclVqkY3PAtPy5je3rFveLNtRu7nro8p+6d6
 vEPPbzloM9BoGYoke6aBDyavDWvNl3hr4A==
X-Google-Smtp-Source: AGHT+IEN3L25/nLjGc4o34zQBER5caCe6tmnJMmGyG+4J/aK5J9tY8OeT4qhdOrDXv82IOkI5OijUA==
X-Received: by 2002:a17:90a:de0b:b0:280:1ffe:5930 with SMTP id
 m11-20020a17090ade0b00b002801ffe5930mr6166016pjv.14.1698724846030; 
 Mon, 30 Oct 2023 21:00:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:45 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 12/14] tests: acpi: implement TPM CRB tests for ARM virt
Date: Mon, 30 Oct 2023 21:00:15 -0700
Message-ID: <20231031040021.65582-13-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.46; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f46.google.com
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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


