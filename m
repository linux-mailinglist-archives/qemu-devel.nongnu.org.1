Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7D7D2E8C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:36:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qurM6-0007kB-0U; Mon, 23 Oct 2023 05:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurM2-0007YJ-9i
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:36:10 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qurLy-0005VZ-5n
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698053766; x=1729589766;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aBuL0BuijXl9jyu2ljEksmLwgpXnUY19FR5QR44TviQ=;
 b=aYQfQFs31kGghqDhYL6UHkDzRZJoFZ6XhO1s94ipqSHwZ14G80tOr9tl
 wNPAReQDZX+AR2OysK3iQswFbCkRQGAu9yxEFwcLTVJviG61jJ96v9IQ+
 YAIvO1QRm7FhZ38shDYL41XoYK5i1vWV9wy7xlgLinPfeAyfRM7bjIHfG
 RBuvhxQQpxWE8bjOIRPqFNMTd1VqeWyWO/PV7p71+Z5KOGoYz3L1He9G6
 +N+WbwvT5+8rJOoPt9c9WepMph2nE7vAjIAtfpX6YeuBDW6mkyWn4GvJz
 8x32xbzo62hrWBgvq+e5kp90m9VIBtQJI3uwFv36yqZuG8kIPRS6OmRiJ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8359719"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8359719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 02:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707883382"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; d="scan'208";a="707883382"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 02:35:46 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 16/16] tests: bios-tables-test: Add ACPI table binaries for
 smbios type4 thread count2 test
Date: Mon, 23 Oct 2023 17:46:35 +0800
Message-Id: <20231023094635.1588282-17-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
References: <20231023094635.1588282-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 5 and 6.

Changes in the tables:
FACP:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20200925 (64-bit version)
+ * Copyright (c) 2000 - 2020 Intel Corporation
+ *
+ * Disassembly of /tmp/aml-CNE3C2, Mon Oct 23 15:25:01 2023
+ *
+ * ACPI Data Table [FACP]
+ *
+ * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
+ */
+
+[000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
+[004h 0004   4]                 Table Length : 000000F4
+[008h 0008   1]                     Revision : 03
+[009h 0009   1]                     Checksum : B3
+[00Ah 0010   6]                       Oem ID : "BOCHS "
+[010h 0016   8]                 Oem Table ID : "BXPC    "
+[018h 0024   4]                 Oem Revision : 00000001
+[01Ch 0028   4]              Asl Compiler ID : "BXPC"
+[020h 0032   4]        Asl Compiler Revision : 00000001
+
+[024h 0036   4]                 FACS Address : 00000000
+[028h 0040   4]                 DSDT Address : 00000000
+[02Ch 0044   1]                        Model : 01
+[02Dh 0045   1]                   PM Profile : 00 [Unspecified]
+[02Eh 0046   2]                SCI Interrupt : 0009
+[030h 0048   4]             SMI Command Port : 000000B2
+[034h 0052   1]            ACPI Enable Value : 02
+[035h 0053   1]           ACPI Disable Value : 03
+[036h 0054   1]               S4BIOS Command : 00
+[037h 0055   1]              P-State Control : 00
+[038h 0056   4]     PM1A Event Block Address : 00000600
+[03Ch 0060   4]     PM1B Event Block Address : 00000000
+[040h 0064   4]   PM1A Control Block Address : 00000604
+[044h 0068   4]   PM1B Control Block Address : 00000000
+[048h 0072   4]    PM2 Control Block Address : 00000000
+[04Ch 0076   4]       PM Timer Block Address : 00000608
+[050h 0080   4]           GPE0 Block Address : 00000620
+[054h 0084   4]           GPE1 Block Address : 00000000
+[058h 0088   1]       PM1 Event Block Length : 04
+[059h 0089   1]     PM1 Control Block Length : 02
+[05Ah 0090   1]     PM2 Control Block Length : 00
+[05Bh 0091   1]        PM Timer Block Length : 04
+[05Ch 0092   1]            GPE0 Block Length : 10
+[05Dh 0093   1]            GPE1 Block Length : 00
+[05Eh 0094   1]             GPE1 Base Offset : 00
+[05Fh 0095   1]                 _CST Support : 00
+[060h 0096   2]                   C2 Latency : 0FFF
+[062h 0098   2]                   C3 Latency : 0FFF
+[064h 0100   2]               CPU Cache Size : 0000
+[066h 0102   2]           Cache Flush Stride : 0000
+[068h 0104   1]            Duty Cycle Offset : 00
+[069h 0105   1]             Duty Cycle Width : 00
+[06Ah 0106   1]          RTC Day Alarm Index : 00
+[06Bh 0107   1]        RTC Month Alarm Index : 00
+[06Ch 0108   1]            RTC Century Index : 32
+[06Dh 0109   2]   Boot Flags (decoded below) : 0002
+               Legacy Devices Supported (V2) : 0
+            8042 Present on ports 60/64 (V2) : 1
+                        VGA Not Present (V4) : 0
+                      MSI Not Supported (V4) : 0
+                PCIe ASPM Not Supported (V4) : 0
+                   CMOS RTC Not Present (V5) : 0
+[06Fh 0111   1]                     Reserved : 00
+[070h 0112   4]        Flags (decoded below) : 000484A5
+      WBINVD instruction is operational (V1) : 1
+              WBINVD flushes all caches (V1) : 0
+                    All CPUs support C1 (V1) : 1
+                  C2 works on MP system (V1) : 0
+            Control Method Power Button (V1) : 0
+            Control Method Sleep Button (V1) : 1
+        RTC wake not in fixed reg space (V1) : 0
+            RTC can wake system from S4 (V1) : 1
+                        32-bit PM Timer (V1) : 0
+                      Docking Supported (V1) : 0
+               Reset Register Supported (V2) : 1
+                            Sealed Case (V3) : 0
+                    Headless - No Video (V3) : 0
+        Use native instr after SLP_TYPx (V3) : 0
+              PCIEXP_WAK Bits Supported (V4) : 0
+                     Use Platform Timer (V4) : 1
+               RTC_STS valid on S4 wake (V4) : 0
+                Remote Power-on capable (V4) : 0
+                 Use APIC Cluster Model (V4) : 1
+     Use APIC Physical Destination Mode (V4) : 0
+                       Hardware Reduced (V5) : 0
+                      Low Power S0 Idle (V5) : 0
+
+[074h 0116  12]               Reset Register : [Generic Address Structure]
+[074h 0116   1]                     Space ID : 01 [SystemIO]
+[075h 0117   1]                    Bit Width : 08
+[076h 0118   1]                   Bit Offset : 00
+[077h 0119   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[078h 0120   8]                      Address : 0000000000000CF9
+
+[080h 0128   1]         Value to cause reset : 0F
+[081h 0129   2]    ARM Flags (decoded below) : 0000
+                              PSCI Compliant : 0
+                       Must use HVC for PSCI : 0
+
+[083h 0131   1]          FADT Minor Revision : 00
+[084h 0132   8]                 FACS Address : 0000000000000000
+[08Ch 0140   8]                 DSDT Address : 0000000000000000
+[094h 0148  12]             PM1A Event Block : [Generic Address Structure]
+[094h 0148   1]                     Space ID : 01 [SystemIO]
+[095h 0149   1]                    Bit Width : 20
+[096h 0150   1]                   Bit Offset : 00
+[097h 0151   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[098h 0152   8]                      Address : 0000000000000600
+
+[0A0h 0160  12]             PM1B Event Block : [Generic Address Structure]
+[0A0h 0160   1]                     Space ID : 00 [SystemMemory]
+[0A1h 0161   1]                    Bit Width : 00
+[0A2h 0162   1]                   Bit Offset : 00
+[0A3h 0163   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0A4h 0164   8]                      Address : 0000000000000000
+
+[0ACh 0172  12]           PM1A Control Block : [Generic Address Structure]
+[0ACh 0172   1]                     Space ID : 01 [SystemIO]
+[0ADh 0173   1]                    Bit Width : 10
+[0AEh 0174   1]                   Bit Offset : 00
+[0AFh 0175   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0B0h 0176   8]                      Address : 0000000000000604
+
+[0B8h 0184  12]           PM1B Control Block : [Generic Address Structure]
+[0B8h 0184   1]                     Space ID : 00 [SystemMemory]
+[0B9h 0185   1]                    Bit Width : 00
+[0BAh 0186   1]                   Bit Offset : 00
+[0BBh 0187   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0BCh 0188   8]                      Address : 0000000000000000
+
+[0C4h 0196  12]            PM2 Control Block : [Generic Address Structure]
+[0C4h 0196   1]                     Space ID : 00 [SystemMemory]
+[0C5h 0197   1]                    Bit Width : 00
+[0C6h 0198   1]                   Bit Offset : 00
+[0C7h 0199   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0C8h 0200   8]                      Address : 0000000000000000
+
+[0D0h 0208  12]               PM Timer Block : [Generic Address Structure]
+[0D0h 0208   1]                     Space ID : 01 [SystemIO]
+[0D1h 0209   1]                    Bit Width : 20
+[0D2h 0210   1]                   Bit Offset : 00
+[0D3h 0211   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0D4h 0212   8]                      Address : 0000000000000608
+
+[0DCh 0220  12]                   GPE0 Block : [Generic Address Structure]
+[0DCh 0220   1]                     Space ID : 01 [SystemIO]
+[0DDh 0221   1]                    Bit Width : 80
+[0DEh 0222   1]                   Bit Offset : 00
+[0DFh 0223   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0E0h 0224   8]                      Address : 0000000000000620
+
+[0E8h 0232  12]                   GPE1 Block : [Generic Address Structure]
+[0E8h 0232   1]                     Space ID : 00 [SystemMemory]
+[0E9h 0233   1]                    Bit Width : 00
+[0EAh 0234   1]                   Bit Offset : 00
+[0EBh 0235   1]         Encoded Access Width : 00 [Undefined/Legacy]
+[0ECh 0236   8]                      Address : 0000000000000000

...

APIC:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20200925 (64-bit version)
+ * Copyright (c) 2000 - 2020 Intel Corporation
+ *
+ * Disassembly of /tmp/aml-WKE3C2, Mon Oct 23 15:25:01 2023
+ *
+ * ACPI Data Table [APIC]
+ *
+ * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
+ */
+
+[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
+[004h 0004   4]                 Table Length : 00000CA6
+[008h 0008   1]                     Revision : 03
+[009h 0009   1]                     Checksum : 2C
+[00Ah 0010   6]                       Oem ID : "BOCHS "
+[010h 0016   8]                 Oem Table ID : "BXPC    "
+[018h 0024   4]                 Oem Revision : 00000001
+[01Ch 0028   4]              Asl Compiler ID : "BXPC"
+[020h 0032   4]        Asl Compiler Revision : 00000001
+
+[024h 0036   4]           Local Apic Address : FEE00000
+[028h 0040   4]        Flags (decoded below) : 00000001
+                         PC-AT Compatibility : 1
+
+[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
+[02Dh 0045   1]                       Length : 08
+[02Eh 0046   1]                 Processor ID : 00
+[02Fh 0047   1]                Local Apic ID : 00
+[030h 0048   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+                      Runtime Online Capable : 0
+
+[034h 0052   1]                Subtable Type : 00 [Processor Local APIC]
+[035h 0053   1]                       Length : 08
+[036h 0054   1]                 Processor ID : 01
+[037h 0055   1]                Local Apic ID : 01
+[038h 0056   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+                      Runtime Online Capable : 0

[snip]

+[434h 1076   1]                Subtable Type : 00 [Processor Local APIC]
+[435h 1077   1]                       Length : 08
+[436h 1078   1]                 Processor ID : 81
+[437h 1079   1]                Local Apic ID : 81
+[438h 1080   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+                      Runtime Online Capable : 0
+
+[43Ch 1084   1]                Subtable Type : 09 [Processor Local x2APIC]
+[43Dh 1085   1]                       Length : 10
+[43Eh 1086   2]                     Reserved : 0000
+[440h 1088   4]          Processor x2Apic ID : 00000100
+[444h 1092   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+[448h 1096   4]                Processor UID : 00000082

[snip]

+[C4Ch 3148   1]                Subtable Type : 09 [Processor Local x2APIC]
+[C4Dh 3149   1]                       Length : 10
+[C4Eh 3150   2]                     Reserved : 0000
+[C50h 3152   4]          Processor x2Apic ID : 00000181
+[C54h 3156   4]        Flags (decoded below) : 00000000
+                           Processor Enabled : 0
+[C58h 3160   4]                Processor UID : 00000103
+
+[C5Ch 3164   1]                Subtable Type : 01 [I/O APIC]
+[C5Dh 3165   1]                       Length : 0C
+[C5Eh 3166   1]                  I/O Apic ID : 00
+[C5Fh 3167   1]                     Reserved : 00
+[C60h 3168   4]                      Address : FEC00000
+[C64h 3172   4]                    Interrupt : 00000000
+
+[C68h 3176   1]                Subtable Type : 02 [Interrupt Source Override]
+[C69h 3177   1]                       Length : 0A
+[C6Ah 3178   1]                          Bus : 00
+[C6Bh 3179   1]                       Source : 00
+[C6Ch 3180   4]                    Interrupt : 00000002
+[C70h 3184   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0

[snip]

+[C90h 3216   1]                Subtable Type : 02 [Interrupt Source Override]
+[C91h 3217   1]                       Length : 0A
+[C92h 3218   1]                          Bus : 00
+[C93h 3219   1]                       Source : 0B
+[C94h 3220   4]                    Interrupt : 0000000B
+[C98h 3224   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[C9Ah 3226   1]                Subtable Type : 0A [Local x2APIC NMI]
+[C9Bh 3227   1]                       Length : 0C
+[C9Ch 3228   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0
+[C9Eh 3230   4]                Processor UID : FFFFFFFF
+[CA2h 3234   1]         Interrupt Input LINT : 01
+[CA3h 3235   3]                     Reserved : 000000

...

DSDT:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20200925 (64-bit version)
+ * Copyright (c) 2000 - 2020 Intel Corporation
+ *
+ * Disassembling to symbolic ASL+ operators
+ *
+ * Disassembly of /tmp/aml-CDE3C2, Mon Oct 23 15:25:01 2023
+ *
+ * Original Table Header:
+ *     Signature        "DSDT"
+ *     Length           0x000083EA (33770)
+ *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
+ *     Checksum         0x01
+ *     OEM ID           "BOCHS "
+ *     OEM Table ID     "BXPC    "
+ *     OEM Revision     0x00000001 (1)
+ *     Compiler ID      "BXPC"
+ *     Compiler Version 0x00000001 (1)
+ */
+DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
+{
+    Scope (\)
+    {
+        OperationRegion (DBG, SystemIO, 0x0402, One)
+        Field (DBG, ByteAcc, NoLock, Preserve)
+        {
+            DBGB,   8
+        }
+
+        Method (DBUG, 1, NotSerialized)
+        {
+            ToHexString (Arg0, Local0)
+            ToBuffer (Local0, Local0)
+            Local1 = (SizeOf (Local0) - One)
+            Local2 = Zero
+            While ((Local2 < Local1))
+            {
+                DBGB = DerefOf (Local0 [Local2])
+                Local2++
+            }
+
+            DBGB = 0x0A
+        }
+    }

[snip]

+            Processor (C000, 0x00, 0x00000000, 0x00)
+            {
+                Method (_STA, 0, Serialized)  // _STA: Status
+                {
+                    Return (CSTA (Zero))
+                }
+
+                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                {
+                     0x00, 0x08, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00   // ........
+                })
+                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
+                {
+                    COST (Zero, Arg0, Arg1, Arg2)
+                }
+            }

[snip]

+            Processor (C081, 0x81, 0x00000000, 0x00)
+            {
+                Method (_STA, 0, Serialized)  // _STA: Status
+                {
+                    Return (CSTA (0x81))
+                }
+
+                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                {
+                     0x00, 0x08, 0x81, 0x81, 0x01, 0x00, 0x00, 0x00   // ........
+                })
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
+                {
+                    CEJ0 (0x81)
+                }
+
+                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
+                {
+                    COST (0x81, Arg0, Arg1, Arg2)
+                }
+            }

...

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v2:
 * Rebuilt the binaries to match the changes for the change in "thread
   count2" test case.
---
 tests/data/acpi/q35/APIC.thread-count2      | Bin 0 -> 3238 bytes
 tests/data/acpi/q35/DSDT.thread-count2      | Bin 0 -> 33770 bytes
 tests/data/acpi/q35/FACP.thread-count2      | Bin 0 -> 244 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/q35/APIC.thread-count2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ac200ab7aa6e2fc4b6995ba0dfc1a77ae32e0412 100644
GIT binary patch
literal 3238
zcmXxmWmuJI9E9-!M9(>ZVz+{diQP>If(43!4Ju%FCv513Zg;2K-R*X_Zg+Qg=sv^D
za)I~zqdtJwf5<K_%-x?1BxL3k<rb8r<&+lZriGU{0DNYF4-VHh0;q9uYJ9w!kf7G7
zqb4S*b?d72>Zy^48jY&4n3|NNCMT;YDQf-tYJ&!9YO30>q1vdC+PJaWq>0+JsoJcW
z+Pt~iqJ`SBrP`{M+Pbycrj6RRt=g`g+P=N2p9>=C>2ik-YR8Uhr%q}{hT6Ha+NF!y
zwX52#o7%m*+M|b>nW^^dsrKrn_U^6r>7(}TtM==s_V2F_7@!Uus16#W4j!xy8KMpy
zsty~b4j-<L7@>|Fsg4?@jvlRMWvSWOYEF)ttN$mFF=OPsJT*UG9XnPnC{POv)p6t0
z@#EDA6V!<l)k%}oq9V1pSe-msoiar&DN(0RRi{l;r%zXB%uq{9)tNKZS+msHv(-6s
z)VXujdGply^VPC4wY*$ius~h7P+hc0t*B5dE7hthb@5_#$r5$xQgzufb@_62#R_%h
zN_EvLb@gg>%^G#>T6Ntzb^UsE!v=NZMs?FBb@OI*%NBL(R(0Dpb^CU8#}0MpPIcEV
zwYplZsbQn3;h*rp=cDX6`)Hd7f*(J|=AodEwRte;-8K&gy~pMOp^vk9Na*8j9u)cn
zn}>xy(dL1n_u4!(^gf#hhd#;X;h|5qd4T9sY#t)|RGSBhKF#J~qEEMZpy)Gf9xD1w
zn+J<N%jV&t&$fBM=yPlyGWuMb2aP_@=3%4Hw|U^`3v3=b`a+urkG{y};iE6Mc>w84
zY#u`TQajDQ%ucs2w|OALE3UA4DCsM09!z?_onc>P^MLZ>SKB<K^ffjQDt)cZ!%AOg
z^T5*A+dQ=N4K@!heWT68OW$Pk0Mj?yJjC=ZHV-m=tIfkq-)8eb)3@6^)bt%T4>o<L
z&BIOKW%Gd3ciTMV^gT8YI(@Ir!%p94^T5;h+dTC212zvn{h-amPd{XH0O$iYhk$<A
z&axk|v+YN14n%mxV>X9^e%$6@&`;QT_LFwL{glli;pabXb5Q7KYz_<ktj&R;pR+kM
z^z$|chkn84@X#;X93c87n?ppuY-^B!S8NRv@T#qW0uI_5D&UZ<!2({hHC({!wgwD%
z!`6@iZ`v9(;4NFj2E1)+;DC2*4IS{Vt-%A{vo(Cc`?dx!`~_%h2!RjnGX5~a%SYjj
zdr)qFY-=EaPize(@TslA1U|DX{PmyPmG&2QmHnlyK?T0DHLSqbwgwjX#@5gR-`W~n
z;5%Ex3w&>DfPo)u4KeVetw9EUvNg=W&$b2{_{G*x1HalDY~VLr!wvjyYrug&Yz;Z^
zr>#K;{<1afz~8n89{9)B&;$S48hqfet>Fib*!lw?ApG3<`_&%;fp)cjAKZC<yvDBG
t`Q-3*IKXd>_*i)31D_HTLsR$^jsE`>3!k9(B_-89#llw~2`~JH{{h;7;sF2v

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/q35/DSDT.thread-count2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8 100644
GIT binary patch
literal 33770
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
W4K?P5bh;rgg0D$>4X$`mvGaehF-gM!

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/FACP.thread-count2 b/tests/data/acpi/q35/FACP.thread-count2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31fa5dd19c213034eef4eeefa6a04e61dadd8a2a 100644
GIT binary patch
literal 244
zcmZ>BbPo8!z`($~*~#D8BUr&HBEVSz2pEB4AU24G0Y(N+hD|^Y6El!tgNU*~X%LSC
z$X0-fGcm9T0LA|E|L2FOWMD92VqjR>!otAF!NBm72O<iWged~jj0!*k$y^{03>bk1
YBHITON2VDSAnpK(F*YFF1LDH~0O^Si0RR91

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index d17d80e21ab9..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.thread-count2",
-"tests/data/acpi/q35/DSDT.thread-count2",
-"tests/data/acpi/q35/FACP.thread-count2",
-- 
2.34.1


