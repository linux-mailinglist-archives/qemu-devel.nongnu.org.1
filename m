Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E207DF8E2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfK-0003X2-9X; Thu, 02 Nov 2023 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003Gd-CT
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybea-0002jg-1o
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso675569f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946726; x=1699551526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5xpBWX8lLUIutpUTurxJzEpPMbyD23jwWMi+2vGNS60=;
 b=FhhHsbeU0SCstI3fV2MOVjblXrjNSm+Qvi3NFeuJ3MwhR6F4E6CV7k7OvvIrI/nXG+
 2QFV0BVvMVUZMx+D67JBQkwYGJkbn9zj46ZRfsT51zSYBCqPc4yzhpJJmkSqP7NrsPgn
 e9FHhbgSrs9Xk1ekTP/Cvsx9B4fnw9UDzPTHchyo4ppCICrRnYmVBTB9wODeJqdJ8WIN
 XtghnIfk29JudWuUkeXUbupBO8XFOfCbjELU60WjF/Kfjlfvb/3S43yHUXaMq8VSV3dW
 zkAqUBdeVkiwseY1nzIknEpU++OAHDCmU70y1W9SEMv+6k79MWW0f55qx/A620Zq5lrf
 kCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946726; x=1699551526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xpBWX8lLUIutpUTurxJzEpPMbyD23jwWMi+2vGNS60=;
 b=DzCIbPfOQTiPE6fMLz9cChBKjE4qG/oXqetE0QuezHG+xd6AfoTTd7AIn2Tx9T66th
 Xfxe0Ko1DAIkWuAZQTdXgqLH5H4JoDnkgqQ9hq5MyqIVc1wzKpx2MpzzhWqUPLPOP+ix
 UnQlcGvpfe31JMmaWA9GYbId+epsBVXNFGcEbLWmz7V8poVtBn2AjZmdIlpcrvFX9SSD
 EH3KckPKd7TC9zoHb9Mn+VElmCpV8M1kByaHiPrjN4VsV+LEcMFOMpCKUtSBwlOdqBLa
 dbA5uR6VB3G9bKVuUYQaAE1WyM49lqfKguFmV4YvL0H6w7naITr1+Z8nzn7T8J7bYpME
 hbTA==
X-Gm-Message-State: AOJu0Yy1yejNJy/km96uKzQgjKtpsWmznOF9gIw7/AipsScczvrcNiaZ
 NO0Kkgb8jDdtX7SCDoqKRdWJamo4GKUQoopIDKo=
X-Google-Smtp-Source: AGHT+IFk+nDHc3vq/H+HMXyAH9/wYCiYee3Pk+qk4Dy+X12IcI2A78c2Tc0O+2t/t49Ls4QBsNc4Ew==
X-Received: by 2002:a5d:4a4c:0:b0:32d:d2ef:b0c1 with SMTP id
 v12-20020a5d4a4c000000b0032dd2efb0c1mr14633953wrs.33.1698946725814; 
 Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/33] docs/specs/vmgenid: Convert to rST
Date: Thu,  2 Nov 2023 17:38:17 +0000
Message-Id: <20231102173835.609985-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Convert docs/specs/vmgenid.txt to rST format.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-9-peter.maydell@linaro.org
---
 MAINTAINERS            |   2 +-
 docs/specs/index.rst   |   1 +
 docs/specs/vmgenid.rst | 246 +++++++++++++++++++++++++++++++++++++++++
 docs/specs/vmgenid.txt | 245 ----------------------------------------
 4 files changed, 248 insertions(+), 246 deletions(-)
 create mode 100644 docs/specs/vmgenid.rst
 delete mode 100644 docs/specs/vmgenid.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d654cc1277..397c3967f6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2437,7 +2437,7 @@ S: Orphan
 R: Ani Sinha <ani@anisinha.ca>
 F: hw/acpi/vmgenid.c
 F: include/hw/acpi/vmgenid.h
-F: docs/specs/vmgenid.txt
+F: docs/specs/vmgenid.rst
 F: tests/qtest/vmgenid-test.c
 
 LED
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 7a56ccb2155..b3f482b0aa5 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -31,3 +31,4 @@ guest hardware that is specific to QEMU.
    standard-vga
    virt-ctlr
    vmcoreinfo
+   vmgenid
diff --git a/docs/specs/vmgenid.rst b/docs/specs/vmgenid.rst
new file mode 100644
index 00000000000..9a3cefcd828
--- /dev/null
+++ b/docs/specs/vmgenid.rst
@@ -0,0 +1,246 @@
+Virtual Machine Generation ID Device
+====================================
+
+..
+   Copyright (C) 2016 Red Hat, Inc.
+   Copyright (C) 2017 Skyport Systems, Inc.
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.
+   See the COPYING file in the top-level directory.
+
+The VM generation ID (``vmgenid``) device is an emulated device which
+exposes a 128-bit, cryptographically random, integer value identifier,
+referred to as a Globally Unique Identifier, or GUID.
+
+This allows management applications (e.g. libvirt) to notify the guest
+operating system when the virtual machine is executed with a different
+configuration (e.g. snapshot execution or creation from a template).  The
+guest operating system notices the change, and is then able to react as
+appropriate by marking its copies of distributed databases as dirty,
+re-initializing its random number generator etc.
+
+
+Requirements
+------------
+
+These requirements are extracted from the "How to implement virtual machine
+generation ID support in a virtualization platform" section of
+`the Microsoft Virtual Machine Generation ID specification
+<http://go.microsoft.com/fwlink/?LinkId=260709>`_ dated August 1, 2012.
+
+- **R1a** The generation ID shall live in an 8-byte aligned buffer.
+
+- **R1b** The buffer holding the generation ID shall be in guest RAM,
+  ROM, or device MMIO range.
+
+- **R1c** The buffer holding the generation ID shall be kept separate from
+  areas used by the operating system.
+
+- **R1d** The buffer shall not be covered by an AddressRangeMemory or
+  AddressRangeACPI entry in the E820 or UEFI memory map.
+
+- **R1e** The generation ID shall not live in a page frame that could be
+  mapped with caching disabled. (In other words, regardless of whether the
+  generation ID lives in RAM, ROM or MMIO, it shall only be mapped as
+  cacheable.)
+
+- **R2** to **R5** [These AML requirements are isolated well enough in the
+  Microsoft specification for us to simply refer to them here.]
+
+- **R6** The hypervisor shall expose a _HID (hardware identifier) object
+  in the VMGenId device's scope that is unique to the hypervisor vendor.
+
+
+QEMU Implementation
+-------------------
+
+The above-mentioned specification does not dictate which ACPI descriptor table
+will contain the VM Generation ID device.  Other implementations (Hyper-V and
+Xen) put it in the main descriptor table (Differentiated System Description
+Table or DSDT).  For ease of debugging and implementation, we have decided to
+put it in its own Secondary System Description Table, or SSDT.
+
+The following is a dump of the contents from a running system::
+
+  # iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
+
+  Intel ACPI Component Architecture
+  ASL+ Optimizing Compiler version 20150717-64
+  Copyright (c) 2000 - 2015 Intel Corporation
+
+  Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
+  00000198 (0x0000C6)
+  ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 BXPC 00000001)
+  Acpi table [SSDT] successfully installed and loaded
+  Pass 1 parse of [SSDT]
+  Pass 2 parse of [SSDT]
+  Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
+
+  Parsing completed
+  Disassembly completed
+  ASL Output:    ./SSDT.dsl - 1631 bytes
+  # cat SSDT.dsl
+  /*
+   * Intel ACPI Component Architecture
+   * AML/ASL+ Disassembler version 20150717-64
+   * Copyright (c) 2000 - 2015 Intel Corporation
+   *
+   * Disassembling to symbolic ASL+ operators
+   *
+   * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 00:19:37 2017
+   *
+   * Original Table Header:
+   *     Signature        "SSDT"
+   *     Length           0x000000CA (202)
+   *     Revision         0x01
+   *     Checksum         0x4B
+   *     OEM ID           "BOCHS "
+   *     OEM Table ID     "VMGENID"
+   *     OEM Revision     0x00000001 (1)
+   *     Compiler ID      "BXPC"
+   *     Compiler Version 0x00000001 (1)
+   */
+  DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
+  {
+      Name (VGIA, 0x07FFF000)
+      Scope (\_SB)
+      {
+          Device (VGEN)
+          {
+              Name (_HID, "QEMUVGID")  // _HID: Hardware ID
+              Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
+              Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
+              Method (_STA, 0, NotSerialized)  // _STA: Status
+              {
+                  Local0 = 0x0F
+                  If ((VGIA == Zero))
+                  {
+                      Local0 = Zero
+                  }
+
+                  Return (Local0)
+              }
+
+              Method (ADDR, 0, NotSerialized)
+              {
+                  Local0 = Package (0x02) {}
+                  Index (Local0, Zero) = (VGIA + 0x28)
+                  Index (Local0, One) = Zero
+                  Return (Local0)
+              }
+          }
+      }
+
+      Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
+      {
+          Notify (\_SB.VGEN, 0x80) // Status Change
+      }
+  }
+
+
+Design Details:
+---------------
+
+Requirements R1a through R1e dictate that the memory holding the
+VM Generation ID must be allocated and owned by the guest firmware,
+in this case BIOS or UEFI.  However, to be useful, QEMU must be able to
+change the contents of the memory at runtime, specifically when starting a
+backed-up or snapshotted image.  In order to do this, QEMU must know the
+address that has been allocated.
+
+The mechanism chosen for this memory sharing is writable fw_cfg blobs.
+These are data object that are visible to both QEMU and guests, and are
+addressable as sequential files.
+
+More information about fw_cfg can be found in :doc:`fw_cfg`.
+
+Two fw_cfg blobs are used in this case:
+
+``/etc/vmgenid_guid``
+
+- contains the actual VM Generation ID GUID
+- read-only to the guest
+
+``/etc/vmgenid_addr``
+
+- contains the address of the downloaded vmgenid blob
+- writable by the guest
+
+
+QEMU sends the following commands to the guest at startup:
+
+1. Allocate memory for vmgenid_guid fw_cfg blob.
+2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI variable as
+   shown above in the iasl dump).  Note that this change is not propagated
+   back to QEMU.
+3. Write the address of vmgenid_guid back to QEMU's copy of vmgenid_addr
+   via the fw_cfg DMA interface.
+
+After step 3, QEMU is able to update the contents of vmgenid_guid at will.
+
+Since BIOS or UEFI does not necessarily run when we wish to change the GUID,
+the value of VGIA is persisted via the VMState mechanism.
+
+As spelled out in the specification, any change to the GUID executes an
+ACPI notification.  The exact handler to use is not specified, so the vmgenid
+device uses the first unused one:  ``\_GPE._E05``.
+
+
+Endian-ness Considerations:
+---------------------------
+
+Although not specified in Microsoft's document, it is assumed that the
+device is expected to use little-endian format.
+
+All GUID passed in via command line or monitor are treated as big-endian.
+GUID values displayed via monitor are shown in big-endian format.
+
+
+GUID Storage Format:
+--------------------
+
+In order to implement an OVMF "SDT Header Probe Suppressor", the contents of
+the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There is also
+significant padding in order to align and fill a memory page, as shown in the
+following diagram::
+
+  +----------------------------------+
+  | SSDT with OEM Table ID = VMGENID |
+  +----------------------------------+
+  | ...                              |       TOP OF PAGE
+  | VGIA dword object ---------------|-----> +---------------------------+
+  | ...                              |       | fw-allocated array for    |
+  | _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
+  | ...                              |       +---------------------------+
+  | ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
+  | ...                              |       |     suppressor            |
+  +----------------------------------+       | 36: padding for 8-byte    |
+                                             |     alignment             |
+                                             | 40: GUID                  |
+                                             | 56: padding to page size  |
+                                             +---------------------------+
+                                             END OF PAGE
+
+
+Device Usage:
+-------------
+
+The device has one property, which may be only be set using the command line:
+
+``guid``
+  sets the value of the GUID.  A special value ``auto`` instructs
+  QEMU to generate a new random GUID.
+
+For example::
+
+  QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
+  QEMU  -device vmgenid,guid=auto
+
+The property may be queried via QMP/HMP::
+
+  (QEMU) query-vm-generation-id
+  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
+
+Setting of this parameter is intentionally left out from the QMP/HMP
+interfaces.  There are no known use cases for changing the GUID once QEMU is
+running, and adding this capability would greatly increase the complexity.
diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
deleted file mode 100644
index 80ff69f31cc..00000000000
--- a/docs/specs/vmgenid.txt
+++ /dev/null
@@ -1,245 +0,0 @@
-VIRTUAL MACHINE GENERATION ID
-=============================
-
-Copyright (C) 2016 Red Hat, Inc.
-Copyright (C) 2017 Skyport Systems, Inc.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.
-See the COPYING file in the top-level directory.
-
-===
-
-The VM generation ID (vmgenid) device is an emulated device which
-exposes a 128-bit, cryptographically random, integer value identifier,
-referred to as a Globally Unique Identifier, or GUID.
-
-This allows management applications (e.g. libvirt) to notify the guest
-operating system when the virtual machine is executed with a different
-configuration (e.g. snapshot execution or creation from a template).  The
-guest operating system notices the change, and is then able to react as
-appropriate by marking its copies of distributed databases as dirty,
-re-initializing its random number generator etc.
-
-
-Requirements
-------------
-
-These requirements are extracted from the "How to implement virtual machine
-generation ID support in a virtualization platform" section of the
-specification, dated August 1, 2012.
-
-
-The document may be found on the web at:
-  http://go.microsoft.com/fwlink/?LinkId=260709
-
-R1a. The generation ID shall live in an 8-byte aligned buffer.
-
-R1b. The buffer holding the generation ID shall be in guest RAM, ROM, or device
-     MMIO range.
-
-R1c. The buffer holding the generation ID shall be kept separate from areas
-     used by the operating system.
-
-R1d. The buffer shall not be covered by an AddressRangeMemory or
-     AddressRangeACPI entry in the E820 or UEFI memory map.
-
-R1e. The generation ID shall not live in a page frame that could be mapped with
-     caching disabled. (In other words, regardless of whether the generation ID
-     lives in RAM, ROM or MMIO, it shall only be mapped as cacheable.)
-
-R2 to R5. [These AML requirements are isolated well enough in the Microsoft
-          specification for us to simply refer to them here.]
-
-R6. The hypervisor shall expose a _HID (hardware identifier) object in the
-    VMGenId device's scope that is unique to the hypervisor vendor.
-
-
-QEMU Implementation
--------------------
-
-The above-mentioned specification does not dictate which ACPI descriptor table
-will contain the VM Generation ID device.  Other implementations (Hyper-V and
-Xen) put it in the main descriptor table (Differentiated System Description
-Table or DSDT).  For ease of debugging and implementation, we have decided to
-put it in its own Secondary System Description Table, or SSDT.
-
-The following is a dump of the contents from a running system:
-
-# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
-
-Intel ACPI Component Architecture
-ASL+ Optimizing Compiler version 20150717-64
-Copyright (c) 2000 - 2015 Intel Corporation
-
-Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
-00000198 (0x0000C6)
-ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 BXPC
-00000001)
-Acpi table [SSDT] successfully installed and loaded
-Pass 1 parse of [SSDT]
-Pass 2 parse of [SSDT]
-Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
-
-Parsing completed
-Disassembly completed
-ASL Output:    ./SSDT.dsl - 1631 bytes
-# cat SSDT.dsl
-/*
- * Intel ACPI Component Architecture
- * AML/ASL+ Disassembler version 20150717-64
- * Copyright (c) 2000 - 2015 Intel Corporation
- *
- * Disassembling to symbolic ASL+ operators
- *
- * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 00:19:37 2017
- *
- * Original Table Header:
- *     Signature        "SSDT"
- *     Length           0x000000CA (202)
- *     Revision         0x01
- *     Checksum         0x4B
- *     OEM ID           "BOCHS "
- *     OEM Table ID     "VMGENID"
- *     OEM Revision     0x00000001 (1)
- *     Compiler ID      "BXPC"
- *     Compiler Version 0x00000001 (1)
- */
-DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, "BOCHS ",
-"VMGENID", 0x00000001)
-{
-    Name (VGIA, 0x07FFF000)
-    Scope (\_SB)
-    {
-        Device (VGEN)
-        {
-            Name (_HID, "QEMUVGID")  // _HID: Hardware ID
-            Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
-            Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
-            Method (_STA, 0, NotSerialized)  // _STA: Status
-            {
-                Local0 = 0x0F
-                If ((VGIA == Zero))
-                {
-                    Local0 = Zero
-                }
-
-                Return (Local0)
-            }
-
-            Method (ADDR, 0, NotSerialized)
-            {
-                Local0 = Package (0x02) {}
-                Index (Local0, Zero) = (VGIA + 0x28)
-                Index (Local0, One) = Zero
-                Return (Local0)
-            }
-        }
-    }
-
-    Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
-    {
-        Notify (\_SB.VGEN, 0x80) // Status Change
-    }
-}
-
-
-Design Details:
----------------
-
-Requirements R1a through R1e dictate that the memory holding the
-VM Generation ID must be allocated and owned by the guest firmware,
-in this case BIOS or UEFI.  However, to be useful, QEMU must be able to
-change the contents of the memory at runtime, specifically when starting a
-backed-up or snapshotted image.  In order to do this, QEMU must know the
-address that has been allocated.
-
-The mechanism chosen for this memory sharing is writable fw_cfg blobs.
-These are data object that are visible to both QEMU and guests, and are
-addressable as sequential files.
-
-More information about fw_cfg can be found in "docs/specs/fw_cfg.txt"
-
-Two fw_cfg blobs are used in this case:
-
-/etc/vmgenid_guid - contains the actual VM Generation ID GUID
-                  - read-only to the guest
-/etc/vmgenid_addr - contains the address of the downloaded vmgenid blob
-                  - writable by the guest
-
-
-QEMU sends the following commands to the guest at startup:
-
-1. Allocate memory for vmgenid_guid fw_cfg blob.
-2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI variable as
-   shown above in the iasl dump).  Note that this change is not propagated
-   back to QEMU.
-3. Write the address of vmgenid_guid back to QEMU's copy of vmgenid_addr
-   via the fw_cfg DMA interface.
-
-After step 3, QEMU is able to update the contents of vmgenid_guid at will.
-
-Since BIOS or UEFI does not necessarily run when we wish to change the GUID,
-the value of VGIA is persisted via the VMState mechanism.
-
-As spelled out in the specification, any change to the GUID executes an
-ACPI notification.  The exact handler to use is not specified, so the vmgenid
-device uses the first unused one:  \_GPE._E05.
-
-
-Endian-ness Considerations:
----------------------------
-
-Although not specified in Microsoft's document, it is assumed that the
-device is expected to use little-endian format.
-
-All GUID passed in via command line or monitor are treated as big-endian.
-GUID values displayed via monitor are shown in big-endian format.
-
-
-GUID Storage Format:
---------------------
-
-In order to implement an OVMF "SDT Header Probe Suppressor", the contents of
-the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There is also
-significant padding in order to align and fill a memory page, as shown in the
-following diagram:
-
-+----------------------------------+
-| SSDT with OEM Table ID = VMGENID |
-+----------------------------------+
-| ...                              |       TOP OF PAGE
-| VGIA dword object ---------------|-----> +---------------------------+
-| ...                              |       | fw-allocated array for    |
-| _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
-| ...                              |       +---------------------------+
-| ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
-| ...                              |       |     suppressor            |
-+----------------------------------+       | 36: padding for 8-byte    |
-                                           |     alignment             |
-                                           | 40: GUID                  |
-                                           | 56: padding to page size  |
-                                           +---------------------------+
-                                           END OF PAGE
-
-
-Device Usage:
--------------
-
-The device has one property, which may be only be set using the command line:
-
-  guid - sets the value of the GUID.  A special value "auto" instructs
-         QEMU to generate a new random GUID.
-
-For example:
-
-  QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
-  QEMU  -device vmgenid,guid=auto
-
-The property may be queried via QMP/HMP:
-
-  (QEMU) query-vm-generation-id
-  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
-
-Setting of this parameter is intentionally left out from the QMP/HMP
-interfaces.  There are no known use cases for changing the GUID once QEMU is
-running, and adding this capability would greatly increase the complexity.
-- 
2.34.1


