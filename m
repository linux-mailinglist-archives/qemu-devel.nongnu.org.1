Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8C7ABD4C
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 04:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjsTQ-0007EN-4n; Fri, 22 Sep 2023 22:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjsTN-0007EE-Rv
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 22:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qjsTL-00072r-Va
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 22:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695436458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ih0k5758FKoM2N0N3dOwvAJtAE+IdPiQD9JO833lUaU=;
 b=YJVCq2vAfqkP+9SyLyEs13A9GgzbQSApfVhfpvq31ZrMrDvY9RFTqznFrWBL+0arEx/urE
 HXL5ta/O/EtxmDWciMAQhJhH7LXZZ6reKV80GlxSpWvnRO3omSKCdUfp5rS1e8pxcKNXDV
 S47TN5Qa9b1sdYVGa3pfFoaoC57Zslk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-6adz0qkqNguzeM6HaHzeJg-1; Fri, 22 Sep 2023 22:34:16 -0400
X-MC-Unique: 6adz0qkqNguzeM6HaHzeJg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-56c2d67da6aso2640457a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 19:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695436455; x=1696041255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ih0k5758FKoM2N0N3dOwvAJtAE+IdPiQD9JO833lUaU=;
 b=h+18y0/G3NuDlfMJam+2RFUeHRy1yoM8xv53YmWeZTXedMo1bdK1fW9jJWyBCRirKY
 H0sAILTEhpOvl/32eS7bfgTVTYIh/1Rrs4AX1xShCdOkloZLEDXmKhWywv2bSgMytbhp
 nCg/mmLtGP+R722gHRf2Bdvv3Ch6jTGeyjr5EFaUk5yKYKUGrmb/6ar34PrmEuy6VL5H
 9Nprs5trIOArHy71Kfps1VS8TP4qmwD0AJjMnAGqNvMS12Spm3PaIHDJWAhGmYtsUGsL
 Cv2zwnJ2lQYkz6xL3ObYd7tHMyGiMtjNYHVjzFlqkBFgneeIU+zzjhu09XF1ft/WI/Ko
 k6zA==
X-Gm-Message-State: AOJu0YxXl8eYB8+Y3op6lSrqwUyy7xW8yxhVdVWKerPcBr1Gg8O1pxpu
 +tBR+SDeDxZCQYPsAZd5qlBhUdm0m51UuIh67+48WIUgCfqe23By8Rzn83gUTbVuYNBkCUPB1Ht
 E9zTVh8Ql6KWY3xI=
X-Received: by 2002:a05:6a21:3e07:b0:157:609f:6057 with SMTP id
 bk7-20020a056a213e0700b00157609f6057mr1170469pzc.27.1695436455133; 
 Fri, 22 Sep 2023 19:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5+hl0Ri8haj/2VG6ca56LJTmTWHVEEcg0qASahDioX6tYfVcQqIOS05xTcyAnYFlfQCLfIQ==
X-Received: by 2002:a05:6a21:3e07:b0:157:609f:6057 with SMTP id
 bk7-20020a056a213e0700b00157609f6057mr1170452pzc.27.1695436454869; 
 Fri, 22 Sep 2023 19:34:14 -0700 (PDT)
Received: from localhost.localdomain ([115.96.126.30])
 by smtp.googlemail.com with ESMTPSA id
 iy3-20020a170903130300b001b9d335223csm194435plb.26.2023.09.22.19.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 19:34:14 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] hw/i386: changes towards enabling -Wshadow=local
Date: Sat, 23 Sep 2023 08:03:34 +0530
Message-Id: <20230923023334.41537-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Code changes that addresses all compiler complaints coming from enabling
-Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
other local variables or parameters. These makes the code confusing and/or adds
bugs that are difficult to catch.

CC: Markus Armbruster <armbru@redhat.com>
CC: Philippe Mathieu-Daude <philmd@linaro.org>
CC: mst@redhat.com
Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/acpi-microvm.c | 12 ++++++------
 hw/i386/intel_iommu.c  |  8 ++++----
 hw/i386/pc.c           |  1 -
 hw/i386/x86.c          |  2 --
 4 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index a075360d85..6e4f8061eb 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -78,18 +78,18 @@ static void acpi_dsdt_add_virtio(Aml *scope,
             hwaddr base = VIRTIO_MMIO_BASE + index * 512;
             hwaddr size = 512;
 
-            Aml *dev = aml_device("VR%02u", (unsigned)index);
-            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
-            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+            Aml *adev = aml_device("VR%02u", (unsigned)index);
+            aml_append(adev, aml_name_decl("_HID", aml_string("LNRO0005")));
+            aml_append(adev, aml_name_decl("_UID", aml_int(index)));
+            aml_append(adev, aml_name_decl("_CCA", aml_int(1)));
 
             Aml *crs = aml_resource_template();
             aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
             aml_append(crs,
                        aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
                                      AML_EXCLUSIVE, &irq, 1));
-            aml_append(dev, aml_name_decl("_CRS", crs));
-            aml_append(scope, dev);
+            aml_append(adev, aml_name_decl("_CRS", crs));
+            aml_append(scope, adev);
         }
     }
 }
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..c1fb69170f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3770,9 +3770,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     while (remain >= VTD_PAGE_SIZE) {
         IOMMUTLBEvent event;
         uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
-        uint64_t size = mask + 1;
+        uint64_t sz = mask + 1;
 
-        assert(size);
+        assert(sz);
 
         event.type = IOMMU_NOTIFIER_UNMAP;
         event.entry.iova = start;
@@ -3784,8 +3784,8 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
         memory_region_notify_iommu_one(n, &event);
 
-        start += size;
-        remain -= size;
+        start += sz;
+        remain -= sz;
     }
 
     assert(!remain);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3db0743f31..e7a233e886 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1116,7 +1116,6 @@ void pc_memory_init(PCMachineState *pcms,
 
     if (machine->device_memory) {
         uint64_t *val = g_malloc(sizeof(*val));
-        PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
         uint64_t res_mem_end = machine->device_memory->base;
 
         if (!pcmc->broken_reserved_end) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f034df8bf6..b3d054889b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -365,8 +365,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
-        MachineState *ms = MACHINE(x86ms);
-
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-- 
2.39.1


