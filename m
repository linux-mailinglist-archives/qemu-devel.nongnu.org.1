Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9283B840
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 04:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqRs-0002Rp-Jk; Wed, 24 Jan 2024 22:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqRq-0002Oj-4B
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:38 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqRn-0001Dr-V5
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153436; x=1737689436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pw70+E9f7yP0q/kg6tok3Z3RGqPvOBZoP8fDG+f0630=;
 b=EncjZcTcDPWZ1Ni1RNXd2A87IBS5R1CMBV3pR4gUgMhAvSFByf/T5cJg
 R/n4bmVOtjjDWdzA2B+MEDdKwqMOBERiPA/5CunpP88cjn5i5DD4npjHm
 b7ud7kVoSdvIZxeFGrlnV5CyXTfyvr+T+27iN3ql6XV0PI+F4/4h3UfMs
 7e/1P/t/FAyR8/wFtkeCmOsKwAVTJipwnhfAI2XK4+jjR10I9VnSJ0zwl
 rzurCrAARd3ENWYDUYELwI8tjV/68wweOpXxsMOpAeFTM/IFdZLTKIYxZ
 d91zr18XHn9nwSgY2Y/KkhUBuL+37a799gX3R0tZvNFFupORNMkpDJ+SK Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9429620"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9429620"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2085967"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:27:23 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 42/66] headers: Add definitions from UEFI spec for volumes,
 resources, etc...
Date: Wed, 24 Jan 2024 22:23:04 -0500
Message-Id: <20240125032328.2522472-43-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add UEFI definitions for literals, enums, structs, GUIDs, etc... that
will be used by TDX to build the UEFI Hand-Off Block (HOB) that is passed
to the Trusted Domain Virtual Firmware (TDVF).

All values come from the UEFI specification [1], PI spec [2] and TDVF
design guide[3].

[1] UEFI Specification v2.1.0 https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
[2] UEFI PI spec v1.8 https://uefi.org/sites/default/files/resources/UEFI_PI_Spec_1_8_March3.pdf
[3] https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/standard-headers/uefi/uefi.h | 198 +++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 include/standard-headers/uefi/uefi.h

diff --git a/include/standard-headers/uefi/uefi.h b/include/standard-headers/uefi/uefi.h
new file mode 100644
index 000000000000..b15aba796156
--- /dev/null
+++ b/include/standard-headers/uefi/uefi.h
@@ -0,0 +1,198 @@
+/*
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
+ *                        <isaku.yamahata at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef HW_I386_UEFI_H
+#define HW_I386_UEFI_H
+
+/***************************************************************************/
+/*
+ * basic EFI definitions
+ * supplemented with UEFI Specification Version 2.8 (Errata A)
+ * released February 2020
+ */
+/* UEFI integer is little endian */
+
+typedef struct {
+    uint32_t Data1;
+    uint16_t Data2;
+    uint16_t Data3;
+    uint8_t Data4[8];
+} EFI_GUID;
+
+typedef enum {
+    EfiReservedMemoryType,
+    EfiLoaderCode,
+    EfiLoaderData,
+    EfiBootServicesCode,
+    EfiBootServicesData,
+    EfiRuntimeServicesCode,
+    EfiRuntimeServicesData,
+    EfiConventionalMemory,
+    EfiUnusableMemory,
+    EfiACPIReclaimMemory,
+    EfiACPIMemoryNVS,
+    EfiMemoryMappedIO,
+    EfiMemoryMappedIOPortSpace,
+    EfiPalCode,
+    EfiPersistentMemory,
+    EfiUnacceptedMemoryType,
+    EfiMaxMemoryType
+} EFI_MEMORY_TYPE;
+
+#define EFI_HOB_HANDOFF_TABLE_VERSION 0x0009
+
+#define EFI_HOB_TYPE_HANDOFF              0x0001
+#define EFI_HOB_TYPE_MEMORY_ALLOCATION    0x0002
+#define EFI_HOB_TYPE_RESOURCE_DESCRIPTOR  0x0003
+#define EFI_HOB_TYPE_GUID_EXTENSION       0x0004
+#define EFI_HOB_TYPE_FV                   0x0005
+#define EFI_HOB_TYPE_CPU                  0x0006
+#define EFI_HOB_TYPE_MEMORY_POOL          0x0007
+#define EFI_HOB_TYPE_FV2                  0x0009
+#define EFI_HOB_TYPE_LOAD_PEIM_UNUSED     0x000A
+#define EFI_HOB_TYPE_UEFI_CAPSULE         0x000B
+#define EFI_HOB_TYPE_FV3                  0x000C
+#define EFI_HOB_TYPE_UNUSED               0xFFFE
+#define EFI_HOB_TYPE_END_OF_HOB_LIST      0xFFFF
+
+typedef struct {
+    uint16_t HobType;
+    uint16_t HobLength;
+    uint32_t Reserved;
+} EFI_HOB_GENERIC_HEADER;
+
+typedef uint64_t EFI_PHYSICAL_ADDRESS;
+typedef uint32_t EFI_BOOT_MODE;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    uint32_t Version;
+    EFI_BOOT_MODE BootMode;
+    EFI_PHYSICAL_ADDRESS EfiMemoryTop;
+    EFI_PHYSICAL_ADDRESS EfiMemoryBottom;
+    EFI_PHYSICAL_ADDRESS EfiFreeMemoryTop;
+    EFI_PHYSICAL_ADDRESS EfiFreeMemoryBottom;
+    EFI_PHYSICAL_ADDRESS EfiEndOfHobList;
+} EFI_HOB_HANDOFF_INFO_TABLE;
+
+#define EFI_RESOURCE_SYSTEM_MEMORY          0x00000000
+#define EFI_RESOURCE_MEMORY_MAPPED_IO       0x00000001
+#define EFI_RESOURCE_IO                     0x00000002
+#define EFI_RESOURCE_FIRMWARE_DEVICE        0x00000003
+#define EFI_RESOURCE_MEMORY_MAPPED_IO_PORT  0x00000004
+#define EFI_RESOURCE_MEMORY_RESERVED        0x00000005
+#define EFI_RESOURCE_IO_RESERVED            0x00000006
+#define EFI_RESOURCE_MEMORY_UNACCEPTED      0x00000007
+#define EFI_RESOURCE_MAX_MEMORY_TYPE        0x00000008
+
+#define EFI_RESOURCE_ATTRIBUTE_PRESENT                  0x00000001
+#define EFI_RESOURCE_ATTRIBUTE_INITIALIZED              0x00000002
+#define EFI_RESOURCE_ATTRIBUTE_TESTED                   0x00000004
+#define EFI_RESOURCE_ATTRIBUTE_SINGLE_BIT_ECC           0x00000008
+#define EFI_RESOURCE_ATTRIBUTE_MULTIPLE_BIT_ECC         0x00000010
+#define EFI_RESOURCE_ATTRIBUTE_ECC_RESERVED_1           0x00000020
+#define EFI_RESOURCE_ATTRIBUTE_ECC_RESERVED_2           0x00000040
+#define EFI_RESOURCE_ATTRIBUTE_READ_PROTECTED           0x00000080
+#define EFI_RESOURCE_ATTRIBUTE_WRITE_PROTECTED          0x00000100
+#define EFI_RESOURCE_ATTRIBUTE_EXECUTION_PROTECTED      0x00000200
+#define EFI_RESOURCE_ATTRIBUTE_UNCACHEABLE              0x00000400
+#define EFI_RESOURCE_ATTRIBUTE_WRITE_COMBINEABLE        0x00000800
+#define EFI_RESOURCE_ATTRIBUTE_WRITE_THROUGH_CACHEABLE  0x00001000
+#define EFI_RESOURCE_ATTRIBUTE_WRITE_BACK_CACHEABLE     0x00002000
+#define EFI_RESOURCE_ATTRIBUTE_16_BIT_IO                0x00004000
+#define EFI_RESOURCE_ATTRIBUTE_32_BIT_IO                0x00008000
+#define EFI_RESOURCE_ATTRIBUTE_64_BIT_IO                0x00010000
+#define EFI_RESOURCE_ATTRIBUTE_UNCACHED_EXPORTED        0x00020000
+#define EFI_RESOURCE_ATTRIBUTE_READ_ONLY_PROTECTED      0x00040000
+#define EFI_RESOURCE_ATTRIBUTE_READ_ONLY_PROTECTABLE    0x00080000
+#define EFI_RESOURCE_ATTRIBUTE_READ_PROTECTABLE         0x00100000
+#define EFI_RESOURCE_ATTRIBUTE_WRITE_PROTECTABLE        0x00200000
+#define EFI_RESOURCE_ATTRIBUTE_EXECUTION_PROTECTABLE    0x00400000
+#define EFI_RESOURCE_ATTRIBUTE_PERSISTENT               0x00800000
+#define EFI_RESOURCE_ATTRIBUTE_PERSISTABLE              0x01000000
+#define EFI_RESOURCE_ATTRIBUTE_MORE_RELIABLE            0x02000000
+
+typedef uint32_t EFI_RESOURCE_TYPE;
+typedef uint32_t EFI_RESOURCE_ATTRIBUTE_TYPE;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    EFI_GUID Owner;
+    EFI_RESOURCE_TYPE ResourceType;
+    EFI_RESOURCE_ATTRIBUTE_TYPE ResourceAttribute;
+    EFI_PHYSICAL_ADDRESS PhysicalStart;
+    uint64_t ResourceLength;
+} EFI_HOB_RESOURCE_DESCRIPTOR;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    EFI_GUID Name;
+
+    /* guid specific data follows */
+} EFI_HOB_GUID_TYPE;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    EFI_PHYSICAL_ADDRESS BaseAddress;
+    uint64_t Length;
+} EFI_HOB_FIRMWARE_VOLUME;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    EFI_PHYSICAL_ADDRESS BaseAddress;
+    uint64_t Length;
+    EFI_GUID FvName;
+    EFI_GUID FileName;
+} EFI_HOB_FIRMWARE_VOLUME2;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    EFI_PHYSICAL_ADDRESS BaseAddress;
+    uint64_t Length;
+    uint32_t AuthenticationStatus;
+    bool ExtractedFv;
+    EFI_GUID FvName;
+    EFI_GUID FileName;
+} EFI_HOB_FIRMWARE_VOLUME3;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+    uint8_t SizeOfMemorySpace;
+    uint8_t SizeOfIoSpace;
+    uint8_t Reserved[6];
+} EFI_HOB_CPU;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+} EFI_HOB_MEMORY_POOL;
+
+typedef struct {
+    EFI_HOB_GENERIC_HEADER Header;
+
+    EFI_PHYSICAL_ADDRESS BaseAddress;
+    uint64_t Length;
+} EFI_HOB_UEFI_CAPSULE;
+
+#define EFI_HOB_OWNER_ZERO                                      \
+    ((EFI_GUID){ 0x00000000, 0x0000, 0x0000,                    \
+        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } })
+
+#endif
-- 
2.34.1


