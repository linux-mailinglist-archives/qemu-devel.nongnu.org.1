Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408A7CE214
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8uf-0003Lm-Eu; Wed, 18 Oct 2023 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sw-0002Qo-EX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ss-0006WB-JD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SyAexu+rZaWuvzKgCKPZbnaS1iRHy97AiNuxjIJnXXg=;
 b=BiumW/nRpbkfSiSKsiVm+sB+sI4FBxmM54FF8R0Y/ccdLJY0TLrM554+CEBZSveMl8GytY
 54rrQKDzNZwvbuAn+KrsVO4c8aT2o63rWAIPnaN0SxmK4Or7MKRrBCeiOiq4+2K/B7rsbc
 tnRFKIwmjwITVNo3vbSM5F+C9FaDIEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-XCtzNZ6lNFGhZSWk_g1C5A-1; Wed, 18 Oct 2023 11:54:56 -0400
X-MC-Unique: XCtzNZ6lNFGhZSWk_g1C5A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d9602824dso3892424f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644494; x=1698249294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyAexu+rZaWuvzKgCKPZbnaS1iRHy97AiNuxjIJnXXg=;
 b=TJZWNjB76TxAhN3GfahPGn3Dd1VJ3eY9YZ0zB+NbtpRO+sxWUTAyOXZrwvS8a2VdL6
 c3xY9MKwANHAs6IP3b6Qnm5evXypaJePeDbJfVGRwlfYiGboUhwBRiLym/Ei+KFniATf
 DyWDkhmVyRQv9f4eRCRxejeA2CknB/nqlnYHoIUxqlbymNRSYlBMAuUuisuVUv1Vz7EC
 faKAn5HX/xwyBpXa8vRLJa+6gGDX8kxfWkVNEuiXz9uS6nu+Izerb10QRy3b1zRcrfeH
 BJsIQZrWfrFxuC6sdbkZy5AWIsFA35rvCul6cfPylR4g+Govjv32KupdgKS1cfga1/Ls
 +M6Q==
X-Gm-Message-State: AOJu0YzvPxRFcVlSyFOHQL09ufEOkwVV9hk9I1PCi/M0G2bpRCKZghif
 hstTEO2Q56CV9e2ziqkGSsfs2Z1+1bs48xRYu6uqGL5+B32Dnk83gkzhix/hJmvoP1kM+0DvJkz
 MeWQB/1NnvG74I1h49elf9sTDV1M4hy/EVElaXXLCdAkQsZ6x6wXWY0VsQljA3Ffz08dsTvg=
X-Received: by 2002:a5d:4b8d:0:b0:32d:b2e0:ed76 with SMTP id
 b13-20020a5d4b8d000000b0032db2e0ed76mr4229936wrt.49.1697644494083; 
 Wed, 18 Oct 2023 08:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQVn4lN7GXLEGROheXdT5AyxHef1Ow+3hCtPd4lJ5YN3NrD6ehcIoK/dqaw4Uy85Kqc6rnBw==
X-Received: by 2002:a5d:4b8d:0:b0:32d:b2e0:ed76 with SMTP id
 b13-20020a5d4b8d000000b0032db2e0ed76mr4229904wrt.49.1697644493387; 
 Wed, 18 Oct 2023 08:54:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adffec7000000b0031980294e9fsm2372868wrs.116.2023.10.18.08.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:52 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/83] tests: bios-tables-test: Update ACPI table binaries for
 smbios core count2 test
Message-ID: <9d09a20bf422a8587b74cd468b6d2838e285d95a.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

Change the core count2 from 275 to 260.

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 5 and 6.

Changes in the tables:
APIC:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/q35/APIC.core-count2, Wed Aug 23 16:29:51 2023
+ * Disassembly of /tmp/aml-KQDX91, Wed Aug 23 16:29:51 2023
  *
  * ACPI Data Table [APIC]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
-[004h 0004   4]                 Table Length : 000009AE
+[004h 0004   4]                 Table Length : 00000CA6
 [008h 0008   1]                     Revision : 03
-[009h 0009   1]                     Checksum : CE
+[009h 0009   1]                     Checksum : FA
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

 [024h 0036   4]           Local Apic Address : FEE00000
 [028h 0040   4]        Flags (decoded below) : 00000001
                          PC-AT Compatibility : 1

 [02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
 [02Dh 0045   1]                       Length : 08
 [02Eh 0046   1]                 Processor ID : 00
 [02Fh 0047   1]                Local Apic ID : 00
 [030h 0048   4]        Flags (decoded below) : 00000001
                            Processor Enabled : 1
@@ -1051,1256 +1051,1136 @@
 [42Ch 1068   1]                Subtable Type : 00 [Processor Local APIC]
 [42Dh 1069   1]                       Length : 08
 [42Eh 1070   1]                 Processor ID : 80
 [42Fh 1071   1]                Local Apic ID : 80
 [430h 1072   4]        Flags (decoded below) : 00000001
                            Processor Enabled : 1
                       Runtime Online Capable : 0

 [434h 1076   1]                Subtable Type : 00 [Processor Local APIC]
 [435h 1077   1]                       Length : 08
 [436h 1078   1]                 Processor ID : 81
 [437h 1079   1]                Local Apic ID : 81
 [438h 1080   4]        Flags (decoded below) : 00000001
                            Processor Enabled : 1
                       Runtime Online Capable : 0

-[43Ch 1084   1]                Subtable Type : 00 [Processor Local APIC]
-[43Dh 1085   1]                       Length : 08
-[43Eh 1086   1]                 Processor ID : 82
-[43Fh 1087   1]                Local Apic ID : 82
-[440h 1088   4]        Flags (decoded below) : 00000001
-                           Processor Enabled : 1
-                      Runtime Online Capable : 0
-
-[444h 1092   1]                Subtable Type : 00 [Processor Local APIC]
-[445h 1093   1]                       Length : 08
-[446h 1094   1]                 Processor ID : 83
-[447h 1095   1]                Local Apic ID : 83
-[448h 1096   4]        Flags (decoded below) : 00000001
-                           Processor Enabled : 1
-                      Runtime Online Capable : 0

[snip]

-
-[964h 2404   1]                Subtable Type : 01 [I/O APIC]
-[965h 2405   1]                       Length : 0C
-[966h 2406   1]                  I/O Apic ID : 00
-[967h 2407   1]                     Reserved : 00
-[968h 2408   4]                      Address : FEC00000
-[96Ch 2412   4]                    Interrupt : 00000000
-
-[970h 2416   1]                Subtable Type : 02 [Interrupt Source Override]
-[971h 2417   1]                       Length : 0A
-[972h 2418   1]                          Bus : 00
-[973h 2419   1]                       Source : 00
-[974h 2420   4]                    Interrupt : 00000002
-[978h 2424   2]        Flags (decoded below) : 0000
+[43Ch 1084   1]                Subtable Type : 09 [Processor Local x2APIC]
+[43Dh 1085   1]                       Length : 10
+[43Eh 1086   2]                     Reserved : 0000
+[440h 1088   4]          Processor x2Apic ID : 00000100
+[444h 1092   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+[448h 1096   4]                Processor UID : 00000082
+
+[44Ch 1100   1]                Subtable Type : 09 [Processor Local x2APIC]
+[44Dh 1101   1]                       Length : 10
+[44Eh 1102   2]                     Reserved : 0000
+[450h 1104   4]          Processor x2Apic ID : 00000101
+[454h 1108   4]        Flags (decoded below) : 00000001
+                           Processor Enabled : 1
+[458h 1112   4]                Processor UID : 00000083
+

[snip]

+
+[C68h 3176   1]                Subtable Type : 02 [Interrupt Source Override]
+[C69h 3177   1]                       Length : 0A
+[C6Ah 3178   1]                          Bus : 00
+[C6Bh 3179   1]                       Source : 00
+[C6Ch 3180   4]                    Interrupt : 00000002
+[C70h 3184   2]        Flags (decoded below) : 0000
                                     Polarity : 0
                                 Trigger Mode : 0

-[97Ah 2426   1]                Subtable Type : 02 [Interrupt Source Override]
-[97Bh 2427   1]                       Length : 0A
-[97Ch 2428   1]                          Bus : 00
-[97Dh 2429   1]                       Source : 05
-[97Eh 2430   4]                    Interrupt : 00000005
-[982h 2434   2]        Flags (decoded below) : 000D
+[C72h 3186   1]                Subtable Type : 02 [Interrupt Source Override]
+[C73h 3187   1]                       Length : 0A
+[C74h 3188   1]                          Bus : 00
+[C75h 3189   1]                       Source : 05
+[C76h 3190   4]                    Interrupt : 00000005
+[C7Ah 3194   2]        Flags (decoded below) : 000D
                                     Polarity : 1
                                 Trigger Mode : 3

-[984h 2436   1]                Subtable Type : 02 [Interrupt Source Override]
-[985h 2437   1]                       Length : 0A
-[986h 2438   1]                          Bus : 00
-[987h 2439   1]                       Source : 09
-[988h 2440   4]                    Interrupt : 00000009
-[98Ch 2444   2]        Flags (decoded below) : 000D
+[C7Ch 3196   1]                Subtable Type : 02 [Interrupt Source Override]
+[C7Dh 3197   1]                       Length : 0A
+[C7Eh 3198   1]                          Bus : 00
+[C7Fh 3199   1]                       Source : 09
+[C80h 3200   4]                    Interrupt : 00000009
+[C84h 3204   2]        Flags (decoded below) : 000D
                                     Polarity : 1
                                 Trigger Mode : 3

-[98Eh 2446   1]                Subtable Type : 02 [Interrupt Source Override]
-[98Fh 2447   1]                       Length : 0A
-[990h 2448   1]                          Bus : 00
-[991h 2449   1]                       Source : 0A
-[992h 2450   4]                    Interrupt : 0000000A
-[996h 2454   2]        Flags (decoded below) : 000D
+[C86h 3206   1]                Subtable Type : 02 [Interrupt Source Override]
+[C87h 3207   1]                       Length : 0A
+[C88h 3208   1]                          Bus : 00
+[C89h 3209   1]                       Source : 0A
+[C8Ah 3210   4]                    Interrupt : 0000000A
+[C8Eh 3214   2]        Flags (decoded below) : 000D
                                     Polarity : 1
                                 Trigger Mode : 3

-[998h 2456   1]                Subtable Type : 02 [Interrupt Source Override]
-[999h 2457   1]                       Length : 0A
-[99Ah 2458   1]                          Bus : 00
-[99Bh 2459   1]                       Source : 0B
-[99Ch 2460   4]                    Interrupt : 0000000B
-[9A0h 2464   2]        Flags (decoded below) : 000D
+[C90h 3216   1]                Subtable Type : 02 [Interrupt Source Override]
+[C91h 3217   1]                       Length : 0A
+[C92h 3218   1]                          Bus : 00
+[C93h 3219   1]                       Source : 0B
+[C94h 3220   4]                    Interrupt : 0000000B
+[C98h 3224   2]        Flags (decoded below) : 000D
                                     Polarity : 1
                                 Trigger Mode : 3

-[9A2h 2466   1]                Subtable Type : 0A [Local x2APIC NMI]
-[9A3h 2467   1]                       Length : 0C
-[9A4h 2468   2]        Flags (decoded below) : 0000
+[C9Ah 3226   1]                Subtable Type : 0A [Local x2APIC NMI]
+[C9Bh 3227   1]                       Length : 0C
+[C9Ch 3228   2]        Flags (decoded below) : 0000
                                     Polarity : 0
                                 Trigger Mode : 0
-[9A6h 2470   4]                Processor UID : FFFFFFFF
-[9AAh 2474   1]         Interrupt Input LINT : 01
-[9ABh 2475   3]                     Reserved : 000000
+[C9Eh 3230   4]                Processor UID : FFFFFFFF
+[CA2h 3234   1]         Interrupt Input LINT : 01
+[CA3h 3235   3]                     Reserved : 000000

...

DSDT:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of tests/data/acpi/q35/DSDT.core-count2, Wed Aug 23 16:29:51 2023
+ * Disassembly of /tmp/aml-6DDX91, Wed Aug 23 16:29:51 2023
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00007EEF (32495)
+ *     Length           0x000083EA (33770)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0x52
+ *     Checksum         0x01
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

@@ -4196,107 +4196,32 @@
                 }

                 If ((Arg0 == 0x0101))
                 {
                     Notify (C101, Arg1)
                 }

                 If ((Arg0 == 0x0102))
                 {
                     Notify (C102, Arg1)
                 }

                 If ((Arg0 == 0x0103))
                 {
                     Notify (C103, Arg1)
                 }
-
-                If ((Arg0 == 0x0104))
-                {
-                    Notify (C104, Arg1)
-                }
-
-                If ((Arg0 == 0x0105))
-                {
-                    Notify (C105, Arg1)
-                }
-
-                If ((Arg0 == 0x0106))
-                {
-                    Notify (C106, Arg1)
-                }
-

[snip]

-                If ((Arg0 == 0x0112))
-                {
-                    Notify (C112, Arg1)
-                }
             }

             Method (CSTA, 1, Serialized)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                 \_SB.PCI0.PRES.CSEL = Arg0
                 Local0 = Zero
                 If ((\_SB.PCI0.PRES.CPEN == One))
                 {
                     Local0 = 0x0F
                 }

                 Release (\_SB.PCI0.PRES.CPLK)
                 Return (Local0)
             }

@@ -4306,33 +4231,33 @@
                 \_SB.PCI0.PRES.CSEL = Arg0
                 \_SB.PCI0.PRES.CEJ0 = One
                 Release (\_SB.PCI0.PRES.CPLK)
             }

             Method (CSCN, 0, Serialized)
             {
                 Acquire (\_SB.PCI0.PRES.CPLK, 0xFFFF)
                 Name (CNEW, Package (0xFF) {})
                 Local3 = Zero
                 Local4 = One
                 While ((Local4 == One))
                 {
                     Local4 = Zero
                     Local0 = One
                     Local1 = Zero
-                    While (((Local0 == One) && (Local3 < 0x0113)))
+                    While (((Local0 == One) && (Local3 < 0x0104)))
                     {
                         Local0 = Zero
                         \_SB.PCI0.PRES.CSEL = Local3
                         \_SB.PCI0.PRES.CCMD = Zero
                         If ((\_SB.PCI0.PRES.CDAT < Local3))
                         {
                             Break
                         }

                         If ((Local1 == 0xFF))
                         {
                             Local4 = One
                             Break
                         }

                         Local3 = \_SB.PCI0.PRES.CDAT
@@ -7220,3281 +7145,3281 @@

                 Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
                 {
                      0x00, 0x08, 0x81, 0x81, 0x01, 0x00, 0x00, 0x00   // ........
                 })
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                 {
                     CEJ0 (0x81)
                 }

                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (0x81, Arg0, Arg1, Arg2)
                 }
             }

-            Processor (C082, 0x82, 0x00000000, 0x00)
+            Device (C082)
             {
+                Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
+                Name (_UID, 0x82)  // _UID: Unique ID
                 Method (_STA, 0, Serialized)  // _STA: Status
                 {
                     Return (CSTA (0x82))
                 }

-                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                Name (_MAT, Buffer (0x10)  // _MAT: Multiple APIC Table Entry
                 {
-                     0x00, 0x08, 0x82, 0x82, 0x01, 0x00, 0x00, 0x00   // ........
+                    /* 0000 */  0x09, 0x10, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00,  // ........
+                    /* 0008 */  0x01, 0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x00   // ........
                 })
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                 {
                     CEJ0 (0x82)
                 }

                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (0x82, Arg0, Arg1, Arg2)
                 }
             }

-            Processor (C083, 0x83, 0x00000000, 0x00)
+            Device (C083)
             {
+                Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
+                Name (_UID, 0x83)  // _UID: Unique ID
                 Method (_STA, 0, Serialized)  // _STA: Status
                 {
                     Return (CSTA (0x83))
                 }

-                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                Name (_MAT, Buffer (0x10)  // _MAT: Multiple APIC Table Entry
                 {
-                     0x00, 0x08, 0x83, 0x83, 0x01, 0x00, 0x00, 0x00   // ........
+                    /* 0000 */  0x09, 0x10, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00,  // ........
+                    /* 0008 */  0x01, 0x00, 0x00, 0x00, 0x83, 0x00, 0x00, 0x00   // ........
                 })
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                 {
                     CEJ0 (0x83)
                 }

                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (0x83, Arg0, Arg1, Arg2)
                 }
             }

-            Processor (C084, 0x84, 0x00000000, 0x00)
+            Device (C084)
             {
+                Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
+                Name (_UID, 0x84)  // _UID: Unique ID
                 Method (_STA, 0, Serialized)  // _STA: Status
                 {
                     Return (CSTA (0x84))
                 }

-                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                Name (_MAT, Buffer (0x10)  // _MAT: Multiple APIC Table Entry
                 {
-                     0x00, 0x08, 0x84, 0x84, 0x01, 0x00, 0x00, 0x00   // ........
+                    /* 0000 */  0x09, 0x10, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00,  // ........
+                    /* 0008 */  0x01, 0x00, 0x00, 0x00, 0x84, 0x00, 0x00, 0x00   // ........
                 })
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                 {
                     CEJ0 (0x84)
                 }

                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (0x84, Arg0, Arg1, Arg2)
                 }
             }

[snip]

-            Processor (C0FE, 0xFE, 0x00000000, 0x00)
+            Device (C0FE)
             {
+                Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
+                Name (_UID, 0xFE)  // _UID: Unique ID
                 Method (_STA, 0, Serialized)  // _STA: Status
                 {
                     Return (CSTA (0xFE))
                 }

-                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                Name (_MAT, Buffer (0x10)  // _MAT: Multiple APIC Table Entry
                 {
-                     0x00, 0x08, 0xFE, 0xFE, 0x01, 0x00, 0x00, 0x00   // ........
+                    /* 0000 */  0x09, 0x10, 0x00, 0x00, 0x7C, 0x01, 0x00, 0x00,  // ....|...
+                    /* 0008 */  0x01, 0x00, 0x00, 0x00, 0xFE, 0x00, 0x00, 0x00   // ........
                 })
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
                 {
                     CEJ0 (0xFE)
                 }

                 Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
                 {
                     COST (0xFE, Arg0, Arg1, Arg2)
                 }
             }

...

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-11-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/q35/APIC.core-count2        | Bin 2478 -> 3238 bytes
 tests/data/acpi/q35/DSDT.core-count2        | Bin 32495 -> 33770 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0f95d1344b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.core-count2",
-"tests/data/acpi/q35/DSDT.core-count2",
diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/q35/APIC.core-count2
index f5da2eb1e8a93d961b39f665f2e8b02acf1aeb3c..4f2428443430b7da8321e9edd816219deb7929a2 100644
GIT binary patch
literal 3238
zcmXxmby$@L7>4l=5IyGriroq-c6Un%f(43!4Ju%FCoFWS>+W#f-LAWJ9j?3EZMyH~
zdB%0*{(jUSTwd=(R#8FDzT_ZCIGkOWlV6;cT~d^j7QV#=LBKN&f<s4Y8VLe5E>4Y)
zR}&J{TD8=~M74HpwN4#15>ca3H5OBolGNm6H6=x@TUV`DPfbl#>(^HsG*BBhR2wx?
z8#h*)G*O#2Rhu<an>SZmv`|~NR9m%DTenu*v{Bo(RrPxbBI)UJyLM{(_G*U?YDR|I
zv7_3lliInn+NF!ywX52#o7%m*+M|csv!~jtm)g6x+NY1&x3Ai-pW45_I$(f0aG*M9
zkUDs<I%J4Cbf`LPm^ys8I%0%6a-=$Hl$x2TW@V|_*=mmdpF~EFmUDB}ygYTx7&Sj%
zEhtdOj#bBvQ^${2CrnT$PE-pE)uJMG(j;~AWVN_hoiat8I#r!EO`SenEh$lF%ur{}
zRA<dnXU|sW%u(mgRp-r9OH0+VGIjoZb-@C4;X<{%T&<{3D=XDSi`2!7)g?>RrAyUi
z%hct|)fFq$l`GX%tJKx2)irC>wQJRN>(uq@)eRfejT_ZXo7Byl)h%1pty|S?+tlsb
z)g3$3ojcX4Dz&<rMpMIg;RDad*m3r;HV1;wA7^tY@bNYW1Mjjq9C)|Q0l_EO91?t@
z%|XE@*&G&pvdw|Pr`Q}Ce5%dC!Fy~D58i8YfbeNHhX|i;bCB>EHirqHX>*|PSvH3X
zpKWun@HsYz3!iIq!0>rChYX)@bI|YwHir#gXmjB3MK*^HUu<*m@Fg~f4_|6?0P$ru
zhY(+Gr`cE7>GqX22QqvGSJ@m&e6`KN#QW?F`x=`A%IB}OIi&bHn}dq4w>hl%2Aczm
zZ?rkI_$Hf!i*L3$y!aNI1B`FAImGxjn}dvRw>ixC4x0mw@3cA8_%54+jqkQO-1r`w
z1CH;tIpp|0n}d$;w>j+i0h<GlAGA62_#vBvj~})<{P+=@0l@ohh5$cmXWEb1S@z>L
z0};N0Cv1iSKWQ@<_$fQre%j8npRpMdzW!O8LBY@23=4kVW?=9OHbaA7v>6=ylFjho
zmu&_JzhW~)_*I)h!mrs36Mo%hpzr~kp~44k1`EGoGhFyhn*qab*$f$e+h)-4J2u0H
z-?bSy{GQFw;rDF@4}V}YeE36~0mO%Fh7f;bm)alOW%egF0~x-8Pi=-0e`Yh7_;b75
z{=%-XzqBjuuWSZ2d<9?I3@iS|W?=ERHbaZQvl(3cz0L6AA8ZB~|7bJB_$Qk|#y{H(
zGycV9pz*IZLydp48EpK!&2ZyCYz7?vX*1;bFPlNfhi!%(|7|ny_#d00$N$<4K0abI
z{P?KN9{`wl>^*-7V0Io?+3Y;7wrh4inQz?Bj}GEv;XfXDN=yu!!c#Q*|5Ggd0(~qg
Qspcsbe)rMvE&PGOe_jvc0RR91

literal 2478
zcmXZeWl$DT6oBC+KKO#RP*m&=4D137us{*TMz9O9Td}*lI}y7Jv9Q1{3{VuiJJ3D6
zcW3rK=bgE`Kkn?0^$7~_i#2JQO`>n0pMP*Z-_RhxeEMajX`0NUrln+LYSc8evO;TX
zw6Q^3TQnHZ&JOME(P%`I3C(7-SkS=%9Ualh37wtM#RXkm(ajCBWWlUiF<Umwo*i@K
zKzDb{nG<v6LJtqjog4Gy!Mu6V(-S!t&6qzwU7!FKEQo~)Vd279qzD!*ip7dy@#0vb
z1ePp`rAlGx(paVpmMx23URbUimM@PLDqzKm=<SV_Dq-cySfvV9t%}vEVfE@*qXyQj
ziM48B?b=wU4*K|@uP^%XofzxZrR&wh`t`9v1N8UDfB<aR5F0hZ#*MK_6KvWP0|PNA
z2%9y-=FKrU7+bW!kPvLy5?i&x&`@mM8r!tNwr#OpJ8a(`J9NN~9Wg8nJ9WbFaEyq+
z&YiJK7wp;<yLH3v-LXdx?Aa50^}^o0u}>fD+ZQ7vv0p!oio*W=alil^I1mR7!oh=a
z$PgSl6o(DN;lpvn2pl;QM~%YKqjAg_96J`HqjB6g96uf>Ou&f~andB5JQ=4<!KqVm
z+BBR#9cRqInKN<LESx<X=gh&mb8+50oIf8IEWm{eanT}Nycm}(!KF)a*)m+d99OKs
zl`C=8DqOu9*Q~*{YjNE=T)!SSY`~2hanmN;ycxG_!L3_y+cw<39b;l}#}15*#hp8G
z*Dl<>8~5zNy?b%rKHR?_4;;XQ2l3D$JbW0B9KoYU@z^muejHDnz>_C2E)Gwf!uWVR
zeHzc4!Lw)a+&Mgd9upGq!Ueo|5iecB%a`%W6--RTq$Iq06|Y^x>(}wd4ZL|1Z{5P%
zxAD#$yn7e#-NXC$F*z9@Jivz!@zEoE{1{VGFf|pQJi(_=F)a<BJ;UeEF+Ck$yug<)
z@zpDQ{TkoA!MAVm-8+2$9zT4*k00^VC;a>wzkI>3U-8>F{Qez({J@_-@z*c>{Tu)M
z!M}eoBSSQ~XxcwrnMG-d%su)dZKYb2wpJ}l+o%?$ZB>iX2GydpooZ3qUbQG~R4q!I
zREyGP)uOaTwJ7bNT9kHFElNA77Nwn4i_$KtMQK;nqO_apOda&|(&92?wKnUw3^ExE
cx{flL^j|P0v%Z1JV#%D$`qTgPOMjvEANV#K5C8xG

diff --git a/tests/data/acpi/q35/DSDT.core-count2 b/tests/data/acpi/q35/DSDT.core-count2
index b47891ec10be131a59bf404242241c054ac902f8..3a0cb8c581c8cc630a2ec21712b7f8b75fcad1c8 100644
GIT binary patch
delta 7005
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

delta 7056
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
ZlW2a)MB^pZD}71jE|N{G^!-rU?ElXEg<t>x

-- 
MST


