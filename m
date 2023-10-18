Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBB7CE22A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vE-0004yg-VY; Wed, 18 Oct 2023 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ta-0002nN-EO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tR-0006nL-LJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5kG6dSpxbgUtbSPh/RmOVRi7KkFbCQn9wyK/IsVOsMw=;
 b=FkFkYWJ3Z3Tpm++d4rZgvEYy6jlAE4+kcVrmpqlxGo99q42aVoFva1k5/hU4koIFxXopkH
 IvhBHINneF3IEqwEME1/EhLW7tDrf4DmPExfNG6Fb/rjU1MA/oyqvLMmDinG6sIAEnp4Z+
 z7D90p666frY61ZGcXGg8QvKBHKdTT4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-eBQcRv7gOf2n0qcUXB6e5Q-1; Wed, 18 Oct 2023 11:55:25 -0400
X-MC-Unique: eBQcRv7gOf2n0qcUXB6e5Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4077e9112b4so25260005e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644522; x=1698249322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5kG6dSpxbgUtbSPh/RmOVRi7KkFbCQn9wyK/IsVOsMw=;
 b=ioKYbXz/YzRGpznZ77aur92llnuxr+e7L5Zq9cM9y1QnmwF5Pv7iYBDCB67OvBicmz
 LZD4C0ppD/+0WdJbYPTQeio/SYZsDQrFGTkGxOUNEp22QwQt+QXPSR3OeorLQ8qlS0uh
 99MSsPDPJOQ1yVow9r51JUD6yjFVLC/ewqPolkVCJV9DnBrn5n2FXA+bMnNBj2orbsjN
 PtVvVrVCzJt2V0MKVdmFuEANYlvE4xFUJSxbbTFpkGOi6poyAvTbR/fPn6G2yAr2zABN
 r1UkRMi/44NA7ltioNqrgF7T/xQYKI7rvGIFHJLMUEnhyHyX+FWAexFCl+15hLiXcW2W
 ErgA==
X-Gm-Message-State: AOJu0YxJX+CRHblBo27nVBvOo+0yNXX/gd2GCQpeul3D1wxA1Z7UiEqV
 IP8Cewj+z2EYckpwDve9IeckNupAPJhhx5eX/j1Ti/jhw+QtgIH0tWpw/EG6K7jMkpsWYLUxUFJ
 uVwJImGXxokRefW0q4gD1z4oPmdQGIKA16I8gDrwrUwOMtrXX+gbCwfAqTuUTmHgTFyd8zPE=
X-Received: by 2002:a05:600c:4714:b0:407:462a:7e9f with SMTP id
 v20-20020a05600c471400b00407462a7e9fmr4396111wmo.27.1697644521936; 
 Wed, 18 Oct 2023 08:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2Snm+4WD0H329uq62aOF2QwFPZ5HsRWWeNVjcQeQ5dZIHjgXxRVj2rCixp1TWlsz2MgMwQ==
X-Received: by 2002:a05:600c:4714:b0:407:462a:7e9f with SMTP id
 v20-20020a05600c471400b00407462a7e9fmr4396071wmo.27.1697644520946; 
 Wed, 18 Oct 2023 08:55:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 iv7-20020a05600c548700b004064cd71aa8sm2030937wmb.34.2023.10.18.08.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:20 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 28/83] tests: bios-tables-test: Add ACPI table binaries for
 smbios type4 thread count2 test
Message-ID: <7b78c88ebbfa5668971fe487481381e8936fe9df.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
+ * Disassembly of /tmp/aml-WOA191, Wed Aug 23 22:29:53 2023
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
+ * Disassembly of /tmp/aml-UMA191, Wed Aug 23 22:29:53 2023
+ *
+ * ACPI Data Table [APIC]
+ *
+ * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
+ */
+
+[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
+[004h 0004   4]                 Table Length : 00001CE6
+[008h 0008   1]                     Revision : 03
+[009h 0009   1]                     Checksum : CA
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

+[1C8Ch 7308   1]                Subtable Type : 09 [Processor Local x2APIC]
+[1C8Dh 7309   1]                       Length : 10
+[1C8Eh 7310   2]                     Reserved : 0000
+[1C90h 7312   4]          Processor x2Apic ID : 00000381
+[1C94h 7316   4]        Flags (decoded below) : 00000000
+                           Processor Enabled : 0
+[1C98h 7320   4]                Processor UID : 00000207
+
+[1C9Ch 7324   1]                Subtable Type : 01 [I/O APIC]
+[1C9Dh 7325   1]                       Length : 0C
+[1C9Eh 7326   1]                  I/O Apic ID : 00
+[1C9Fh 7327   1]                     Reserved : 00
+[1CA0h 7328   4]                      Address : FEC00000
+[1CA4h 7332   4]                    Interrupt : 00000000
+
+[1CA8h 7336   1]                Subtable Type : 02 [Interrupt Source Override]
+[1CA9h 7337   1]                       Length : 0A
+[1CAAh 7338   1]                          Bus : 00
+[1CABh 7339   1]                       Source : 00
+[1CACh 7340   4]                    Interrupt : 00000002
+[1CB0h 7344   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0
+
+[1CB2h 7346   1]                Subtable Type : 02 [Interrupt Source Override]
+[1CB3h 7347   1]                       Length : 0A
+[1CB4h 7348   1]                          Bus : 00
+[1CB5h 7349   1]                       Source : 05
+[1CB6h 7350   4]                    Interrupt : 00000005
+[1CBAh 7354   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[1CBCh 7356   1]                Subtable Type : 02 [Interrupt Source Override]
+[1CBDh 7357   1]                       Length : 0A
+[1CBEh 7358   1]                          Bus : 00
+[1CBFh 7359   1]                       Source : 09
+[1CC0h 7360   4]                    Interrupt : 00000009
+[1CC4h 7364   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[1CC6h 7366   1]                Subtable Type : 02 [Interrupt Source Override]
+[1CC7h 7367   1]                       Length : 0A
+[1CC8h 7368   1]                          Bus : 00
+[1CC9h 7369   1]                       Source : 0A
+[1CCAh 7370   4]                    Interrupt : 0000000A
+[1CCEh 7374   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[1CD0h 7376   1]                Subtable Type : 02 [Interrupt Source Override]
+[1CD1h 7377   1]                       Length : 0A
+[1CD2h 7378   1]                          Bus : 00
+[1CD3h 7379   1]                       Source : 0B
+[1CD4h 7380   4]                    Interrupt : 0000000B
+[1CD8h 7384   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[1CDAh 7386   1]                Subtable Type : 0A [Local x2APIC NMI]
+[1CDBh 7387   1]                       Length : 0C
+[1CDCh 7388   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0
+[1CDEh 7390   4]                Processor UID : FFFFFFFF
+[1CE2h 7394   1]         Interrupt Input LINT : 01
+[1CE3h 7395   3]                     Reserved : 000000

...

DSDT:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20200925 (64-bit version)
+ * Copyright (c) 2000 - 2020 Intel Corporation
+ *
+ * Disassembling to symbolic ASL+ operators
+ *
+ * Disassembly of /tmp/aml-LWJ191, Wed Aug 23 22:29:53 2023
+ *
+ * Original Table Header:
+ *     Signature        "DSDT"
+ *     Length           0x0000F8B7 (63671)
+ *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
+ *     Checksum         0xB7
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
+
+            Processor (C001, 0x01, 0x00000000, 0x00)
+            {
+                Method (_STA, 0, Serialized)  // _STA: Status
+                {
+                    Return (CSTA (One))
+                }
+
+                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                {
+                     0x00, 0x08, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00   // ........
+                })
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
+                {
+                    CEJ0 (One)
+                }
+
+                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
+                {
+                    COST (One, Arg0, Arg1, Arg2)
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
Message-Id: <20230928125943.1816922-17-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/q35/APIC.thread-count2      | Bin 0 -> 7398 bytes
 tests/data/acpi/q35/DSDT.thread-count2      | Bin 0 -> 63671 bytes
 tests/data/acpi/q35/FACP.thread-count2      | Bin 0 -> 244 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index d17d80e21a..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.thread-count2",
-"tests/data/acpi/q35/DSDT.thread-count2",
-"tests/data/acpi/q35/FACP.thread-count2",
diff --git a/tests/data/acpi/q35/APIC.thread-count2 b/tests/data/acpi/q35/APIC.thread-count2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..2c6ab5d96c275f8e4872ff91ce3006f992ef3c36 100644
GIT binary patch
literal 7398
zcmXxoWpotg7DnMOKp+Y34hin=9^BpC-QA_`?(XjHrQT9^_m;Z5!JW<7Hw*gC!%TiO
zbe%oZ!qG$e?XQ(m(S3bK^&31czwhMH{qi$kSt%tRvnhRa;Lzrz6q}V5Tck*A(W0@%
zip6GU#}+RhTcSj4PEKrYZfss&Y{`<brAoz?E*)E@Ol;Y*vE|CemM<S$p+aoMim{a{
z#a6ByTct{D)vB@8s>N2X9$TYEY|WanwQ9xIt{q#aPHf$}vGH?BIRypbdi7%K*N<(`
zAhuz{*hY<F8#j(^(j>NN)7WOsVw*RQZP6mOWy{!BtzuiZj&0K>wr$(kcI{%@w~y`6
zA+}@3*iM~dJ9m!l(j~TQ*Vt~|V!L;b?a?E)XV2JPy<&U!j_uPYwy-d^Z{OH{@!v^K
z|Nh|t17Zgbj2$#6cJScXAwyz^4vif)EOz+t*byUQM~;jgH7a)W=-4r1V#kh+9XBp^
z{P@@j6JjS$jGZ(ocJk!dDN|ynPK}*5Eq40!*cmfoXU>eBH7j=Z?ASSTV&~3{oi{Ib
z{`}Yl3t|^8j9s)ScJboaB}-zLE{$EbEOz<w*cB^cSFVg*wJLV?>ew}FV%M&XUAHcF
z{rcDq8)7$ZjNP;;cJt=gEn8x@ZjIfxEq43%*d04!ckYbcwJUb_?$|wh*xYiNe`Fr;
z_%NNN57!(Bo<Bl!DDaV*gMp9I91eW6=78X1G=~Hqt2rq6IL%?f$7>D@K0$M6@QIp(
zgHO^N9(=Oq0O3<KhX|jlIY{_4&0)f)YYr4XLvyI`nVN%z&(a(&e75F*;d3;H44<nx
zX!tzMVZ-NZ4jjHfbLjAenuCWg(i}c~vE~5cOEiZNU#j!<Wx7CLt~rpIU+D_Xp~P2e
z4ko@zH`G^a4k*uGqdBDbTFpVl*J%zbzFu=+@eP_oi*M8%Tzr$}@Zy^_2N>U?ImGx@
z%|XVuX$~{KU2~xE9hyUp@6;S@e3#~M<GVEn9N(ik<oI6ALC5!L4m-YIbKvm<nnRBt
z)Es>Lkmm5?hcyAfdo>}zkLW)7QC+AX(*z>(D?P3W1%5&k4E&@Xpr6tM_0yV=@cL&o
zLBabpVZqO80)wB^ga$va2@ZZi6CV7cCP4TlO^EQzI)aqaD>}lI(yKZGmC|cELY30%
zI)atb8#=<3(wjO0meN}~LYC6oI)awcJ37La(z`kWm(qJWLYLC}I)azd2Rg!+(uX<%
zn0W`NBZMh^tY`DX$b5a0`ArYz=udS7GNsRSgfgYibp$h|{d$4l|Ak(tztoHLS2}{4
z($_k|n$kBq0-MseIzpS$cRGTb()T*To6-+D0-Vy1IzpV%Pdb8}($6}=oYF5k0-e&Y
zIzpY&Z#sgV((gLLozfpV0-n;JIzpb(Upj)G(%(A5p3*-$0-w^qIzpe)e>#Gn(g7Xe
zPwAkJHvk!Ae(wDJ#v6eQ^=|(@=seHw(RBXM`-38x@6CMCd7P!QbrD@$7u6+nF-_<B
z{%lR>adA!OaS2W5agL_*I9JnooTuqLE~)7}E~V)_F0JW2E~Du@F01K0E~n`{F0bi4
zuAu2WuBhoeuB7QauB_=iuA=EYuBz!guBPccuCD1kuA%8XuBqufuBG#JZC#-2Xgbg9
z>uNfW^EI8v1)9#|db*LWuN&(In$Gk3hMLafMw-s!#+uIKCYsLUrkc*<W}439=9<pq
z7MjlEmYUAvR+`S^)|$@aHk!`kwwli4cAC!P_L|P)4w}y6j+)NnPMXf+&YI5SE}G8c
zuA0u{Zko>H?wZcy9=eb2sS9;4P3L)iZ%yZMA5G_Rp{Db=ucq_3pB|+9YdX*K12mn-
z12vt;gEXDTgEgJULo}VoLp7bp!!(`8!!@19BQ%}IBQ>4Jqcokzqcxq!V>F$|V>O+}
z<20Se<29Yf6EvO26E&U3lQf;jlQo^kQ#75&Q#GB((=?sO)AejUL(kDOHJ#`6voxK@
zvo)Q^b2OdDb2XjE^E92u^EI8v3pAa_3pJg`i!`0bi#46cOEjIwOEsOx%QT(G%Qc<H
zD>R+QD>a?Rt2CX*t2Ld+Yc!q5Yc-w6>olFm>ouLn8#JBA8#SHBn>3xrn>C%sTQr@=
zTQ!}>+ccfW+x2d}L(_Sl->DDNyY%6Dw?0De(MRf3G~OQ^rL*+Wx`;kT7uCn=V){6p
zt&i8m^$EI!K2hiBlXR{=S?B3fbV+@xE~QV?rS<8$j6Oq`)o1E*`Yc^upRFtCb96<0
zuCAod)0Or4x{AI)SJfBlYWgBwU0<wg=u31>eW|XcFVnU4<+_f(Lf6$->U@2bF3?x&
zdiok&Utg;m=<9SteZ6j^Z_thPjk<}xNjKFu>t^~E-CW<QTj<+#OMSa;rSH(K^_{wn
zzDu{&ck6cg9^GEwt2^lXbVq%^?xY{ko%Msdi+)IV)eq}#dav%TAJIMZqq?VlO!v}{
z>)!ea-A6yE3-wdFuYOwh)6eMsdY>MkpVb5Pb9#_|UJuqU=pp(=JygG>hv}E~aQ%uN
zp<mS_^=o>ReqE2&Z|E`lO+8k>rN`;F^?3b`o}k~=6ZLy~l73%L)*t98`a?Zcf261B
zkM(r@iJqZ9)id>HdY1lN&({0(9Q}o!tH0Fq^jCVm{#q~4-{^(<TfInsrx)w*^%DJq
zUaEi8%k)orx&B$N(7))F`d7V5|E5>#-}M^(hhD4y)a&$LdcFQzZ_xkfjrw1`N&lxe
z>jQd=KB%|ql<D@N_Xj#lZ`XW|=lLC)&+&)eA80<u<6WB1@p!l9b3ERo`5d2BiuVS4
t`Ck*MNM7bQ4|tTFo!Qbn%FX@%qrA)u;?GK!JoG3p^W6tCUzvZA^gm{Z!4Lod

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.thread-count2 b/tests/data/acpi/q35/DSDT.thread-count2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..cd542c4b5cdd79eb5c6f4054e07bd6a11c3c8657 100644
GIT binary patch
literal 63671
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
QIobSYGB<<%R2GE(4_Np=IsgCw

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

-- 
MST


