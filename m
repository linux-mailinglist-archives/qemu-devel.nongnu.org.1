Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6677A5FD4
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY8Q-0005v0-RJ; Tue, 19 Sep 2023 06:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiY8I-0005ru-Nj
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qiY8B-0003lE-1I
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K0ccfBsWZGIYWgJW4XRIihbZeeQTvcYtm71mF04eyDA=;
 b=BYkv3bz14ZrwVAwY8yQb/Q0WE2m+TeKvylDB1pitKHtTulZBc78XqMgesEH1Ng6qWoXCbC
 WGZ1uf6FW8UXrcH5HAJMMmf34DLOl5t90AyHTscazK8hzOdR0v3T9nKZp/OsUrSAdnkcgx
 Ob0viziB9YN3qxVUN5SYRE8ANTdIV+A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-1ncEgCdXMfqB82fVKXZAgA-1; Tue, 19 Sep 2023 06:38:48 -0400
X-MC-Unique: 1ncEgCdXMfqB82fVKXZAgA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-573fdb618eeso5333556a12.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 03:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695119928; x=1695724728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K0ccfBsWZGIYWgJW4XRIihbZeeQTvcYtm71mF04eyDA=;
 b=UphEtArbM2joMQNSaQHTsBZJENcDG+9QVDuHVgHn1Zo4YBZBgu1INZW22b3tp9QaX/
 8XRNOi7NVcum4HSElS72BecnEoGaeWJvL8b83LqpZ4Q3YF5o+dH+8m7JZDUKxhMIbuKZ
 enaLrvU2EwkutI5G+8CJlMGAP+/9ux629axUCW+O3eTBp4UPLK71R66CeQSqFi0Z62vZ
 9S6GRhoUmQNi0WzmKxY0HAKL4QGUD4R0IDdTecvXHef5EUFvHvtdShkfYX2rtIPyscLk
 HiQPbaFlsoZudOf7BSit92GwRdWb6B4iSSuuX0D2dH3ildLVJLmyMkXHo7rAx46d8MIV
 h7EA==
X-Gm-Message-State: AOJu0YxxiquiM/nGD9PIuCuYuL4LT1GuJX4z4zWVLaOXB2slf4sZyNz3
 YPuidHhvi48daPypR5vbVvaqh0mNh8v9lelebsH6mp765jxeg08blmQallHLJsWbssHozqThwJY
 hJZ/rCCEaHtc/qf8=
X-Received: by 2002:a17:903:124c:b0:1bf:13fa:e75 with SMTP id
 u12-20020a170903124c00b001bf13fa0e75mr14349640plh.51.1695119927822; 
 Tue, 19 Sep 2023 03:38:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFx3VCYLnj03rsuA6xCQytS5avNW6mWbeuFRLzxewr3IrP5ZfPLRARADlzokpMubN0ESFT3A==
X-Received: by 2002:a17:903:124c:b0:1bf:13fa:e75 with SMTP id
 u12-20020a170903124c00b001bf13fa0e75mr14349620plh.51.1695119927518; 
 Tue, 19 Sep 2023 03:38:47 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.182])
 by smtp.googlemail.com with ESMTPSA id
 l20-20020a170903005400b001c420afa03bsm8675496pla.109.2023.09.19.03.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 03:38:47 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: philmd@linaro.org, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386/pc: improve physical address space bound check for
 32-bit systems
Date: Tue, 19 Sep 2023 16:08:37 +0530
Message-Id: <20230919103838.249317-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

32-bit systems do not have a reserved memory for hole64 and memory hotplug is
not supported on those systems. Therefore, the maximum limit of the guest
physical address coincides with the end of "above 4G memory space" region.
Make sure that the end of "above 4G memory" is still addressible by the
guest processor with its available address bits. For example, previously this
was allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G

Now it is no longer allowed:

$ ./qemu-system-x86_64 -cpu pentium -m size=10G
qemu-system-x86_64: Address space limit 0xffffffff < 0x2bfffffff phys-bits too low (32)

After calling CPUID with EAX=0x80000001, all AMD64 compliant processors
have the longmode-capable-bit turned on in the extended feature flags (bit 29)
in EDX. The absence of CPUID longmode can be used to differentiate between
32-bit and 64-bit processors and is the recommended approach. QEMU takes this
approach elsewhere (for example, please see x86_cpu_realizefn()) and with
this change, pc_max_used_gpa() also takes the same approach to detect 32-bit
processors.

Finally, a new compatibility flag is introduced to retain the old behavior
for pc_max_used_gpa() for macines 8.1 and older.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc.c         | 17 ++++++++++++++---
 hw/i386/pc_piix.c    |  4 ++++
 include/hw/i386/pc.h |  3 +++
 3 files changed, 21 insertions(+), 3 deletions(-)

changelog:
v2: removed memory hotplug region from max_gpa. added compat knobs.

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 54838c0c41..fea97ee258 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -907,10 +907,20 @@ static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
 static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
-    /* 32-bit systems don't have hole64 thus return max CPU address */
-    if (cpu->phys_bits <= 32) {
-        return ((hwaddr)1 << cpu->phys_bits) - 1;
+    /*
+     * 32-bit systems don't have hole64 and does not support
+     * memory hotplug.
+     */
+    if (pcmc->fixed_32bit_mem_addr_check) {
+        if (!(cpu->env.features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM)) {
+            return pc_above_4g_end(pcms) - 1;
+        }
+    } else {
+        if (cpu->phys_bits <= 32) {
+            return ((hwaddr)1 << cpu->phys_bits) - 1;
+        }
     }
 
     return pc_pci_hole64_start() + pci_hole64_size - 1;
@@ -1867,6 +1877,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     pcmc->resizable_acpi_blob = true;
+    pcmc->fixed_32bit_mem_addr_check = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8321f36f97..f100a5de8b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -517,9 +517,13 @@ DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
 
 static void pc_i440fx_8_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     pc_i440fx_8_2_machine_options(m);
     m->alias = NULL;
     m->is_default = false;
+    pcmc->fixed_32bit_mem_addr_check = false;
+
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0fabece236..5a70d163d0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -129,6 +129,9 @@ struct PCMachineClass {
 
     /* resizable acpi blob compat */
     bool resizable_acpi_blob;
+
+    /* fixed 32-bit processor address space bound check for memory */
+    bool fixed_32bit_mem_addr_check;
 };
 
 #define TYPE_PC_MACHINE "generic-pc-machine"
-- 
2.39.1


