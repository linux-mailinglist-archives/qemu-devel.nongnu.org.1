Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922873DF66
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:37:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlMP-000538-Ta; Mon, 26 Jun 2023 08:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLc-0002vR-I1
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLX-000370-8M
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKjaIiozkxiRm9mjEi731tOdTERFV0G/Qnvcg4DvbFQ=;
 b=JiysKUaWmYAzwRnEQ6qlSNB44QfVJ5Dtr/W7wyhXno8tGWQFtD4c3n2vQtt6ngGgJYa0zh
 zqtc74AH9SH5GBHynnkvhTltedBzHJX2x35WaavfLuu/h/vKOxjCWzZ7JNJo39qqlYayu3
 9/mWo69et1eS2sVIQfhrQpjwVEfEIXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-7k5VDobnPuKvdaWafq-htw-1; Mon, 26 Jun 2023 08:29:27 -0400
X-MC-Unique: 7k5VDobnPuKvdaWafq-htw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so23990445e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782566; x=1690374566;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKjaIiozkxiRm9mjEi731tOdTERFV0G/Qnvcg4DvbFQ=;
 b=BsYo+JcSX/JJ67uhDC15+47mQYPQSj4FRy0oVx1z9rBe67P0BFjdOTDEPBgMi6x3wH
 QP5oeuaEpc5u9uroUXzeqtx+tAzvZaJlHNh2Mo85JAN5Knz4knM8SEMMwJSo8T7FvwN+
 KBRYr6RhyqlIhF0lA8Gevfsu4NFc5oBmDMxi9jM/J+mAKOVSxInLpquqKjJVBuHBBa8f
 4+HWvqnK6T/WSxknAlzOgASdtuWjQGo3sif1PyLxzWD3HC9eNS4fNlk1Ec/e9GvnWBNg
 0cxLqVO7kXKd+YeAV/Bj0Hbumn61cqBb8cxjDGuv9l7brW075aWApjAp/agzPftIGhWX
 91pg==
X-Gm-Message-State: AC+VfDzDvhIaCgeJhh7exNwie2dCI9jhu3YXxROCOkeNaPbJ0QZwUTQl
 nBbQaBM5rt5C8RAnrKa+XnSLi4iq56nGVLsBCuJeRHQP6ZcfRf2N8X+v3WqukTSJsHjFQXn6qFh
 UhXtiz636BHxIAGmmkFHM5+RzXByjr9eylFw9OJstZsiqVUNiYHPM8YgMec4saT01ZXOl
X-Received: by 2002:a7b:c342:0:b0:3f4:d18f:b2fb with SMTP id
 l2-20020a7bc342000000b003f4d18fb2fbmr26607580wmj.8.1687782565859; 
 Mon, 26 Jun 2023 05:29:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5LCmjQ8rBuQ9VMgsMf8S6ZuzWKRBFdsL0Af6fubNnslju45pXWIh/mb/rpq6p1T6iz4EgZJQ==
X-Received: by 2002:a7b:c342:0:b0:3f4:d18f:b2fb with SMTP id
 l2-20020a7bc342000000b003f4d18fb2fbmr26607561wmj.8.1687782565508; 
 Mon, 26 Jun 2023 05:29:25 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 y12-20020a7bcd8c000000b003fa79af15c7sm10624349wmj.2.2023.06.26.05.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:25 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer machine
 models
Message-ID: <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
(32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
models. This is necessary to avoid the following message when launching
a VM with large number of vcpus.

   "SMBIOS 2.1 table length 66822 exceeds 65535"

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/pc.h                        | 1 +
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 hw/i386/pc.c                                | 4 +++-
 hw/i386/pc_piix.c                           | 5 +++++
 hw/i386/pc_q35.c                            | 5 +++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c661e9cc80..6eec0fc51d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,6 +110,7 @@ struct PCMachineClass {
     bool smbios_defaults;
     bool smbios_legacy_mode;
     bool smbios_uuid_encoded;
+    SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
     bool gigabyte_align;
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..81148a604f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/SSDT.dimmpxm",
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fc52772fdd..8d37567e08 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1856,6 +1856,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -1863,7 +1864,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->vmport = ON_OFF_AUTO_OFF;
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
-    pcms->smbios_entry_point_type = SMBIOS_ENTRY_POINT_TYPE_32;
+    pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
 
     /* acpi build is enabled by default if machine supports it */
     pcms->acpi_build_enabled = PC_MACHINE_GET_CLASS(pcms)->has_acpi_build;
@@ -1975,6 +1976,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->default_ram_id = "pc.ram";
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 44146e6ff5..f9947fbc10 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -506,11 +506,16 @@ DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
 
 static void pc_i440fx_8_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_8_1_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
+
+    /* For pc-i44fx-8.0 and older, use SMBIOS 2.8 by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
 DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a9a59ed42b..cf68b80974 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -387,10 +387,15 @@ DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
 
 static void pc_q35_8_0_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_q35_8_1_machine_options(m);
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
+
+    /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
+    pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
 DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
-- 
MST


