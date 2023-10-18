Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D407CE237
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vF-00053V-9O; Wed, 18 Oct 2023 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8ta-0002nO-Em
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tT-0006pc-QF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwPAwv5Y3eXXEHBw1lpcidsmEhKEgP+6i9xKOvqMojk=;
 b=aOe6Ztw+1AOKSjSd2xIvS36CuidxvMc0bhV5Y00q87XsqnTdeEUrtSkPkyTWkanHBfBPMp
 b/8r25w4HB6OL0s0n8YaABoZfdCxkk871Z51zmOFwi1SynyHBVux7wlk3/ZNTdTtKvmFfF
 Q5TSSbXEN577z4RjT+rwL4kMIN8LN44=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-pSnTike8PYGkNRqgZJH39Q-1; Wed, 18 Oct 2023 11:55:10 -0400
X-MC-Unique: pSnTike8PYGkNRqgZJH39Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso46844835e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644508; x=1698249308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwPAwv5Y3eXXEHBw1lpcidsmEhKEgP+6i9xKOvqMojk=;
 b=jMbK8EH13rFYaP4+JTMGTTIIMLWjoYfm8JTImmB7jT7gJL5v9berbr59k6ITRmg2gr
 g9h9K8PlEVIInm7mCzks+3cpLmtpFml05onER81ksR06o6f+ZXy6s4kyhLaHqWECoViT
 aHei/l0ZQu/Cu40kK0qZcAfiwfYBcShzacKZaa+NqkWvtsE+YfKt/0g1l7zNFdr/Kg3E
 vkeojTw+FJvNmYwLbxSFk8B+Vq0Kz+uh1zKqG+KhXc7f3GOXDSeyFKf9WUAnhW/EtqcH
 YU3QiAPppp06R+2bfnlVrCjTb5zc4P4ptZArsCkFJsEVwVO73C8sbOebhO+jN48XfKYb
 eTWQ==
X-Gm-Message-State: AOJu0YzRtVFMa8ZkP7wLcilNXWX4LQSzDBVlH4x+75mwJPaK/compxxJ
 W+WMH0/YVwflA/KXI6IgPQUL/vxNBuRD55j/hg2ro4sM034s2tmMBt+o0i2YoN7MR8QTiTDFosb
 jhLu9XDslN/zTZRqdh5MjfuFP2zbxqic2imjwe+IRIqyiHCFhqf5wtx/VMaTeDrT0r15uZa0=
X-Received: by 2002:a05:600c:484f:b0:406:4573:81d2 with SMTP id
 j15-20020a05600c484f00b00406457381d2mr4167930wmo.39.1697644508230; 
 Wed, 18 Oct 2023 08:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzya3+CF4r2P3FwfyBiyrvL+luU6Y8pG7jD5xXNaGfnXJUnHFJByBvsHDydhqzs31OJ6r2UA==
X-Received: by 2002:a05:600c:484f:b0:406:4573:81d2 with SMTP id
 j15-20020a05600c484f00b00406457381d2mr4167902wmo.39.1697644507567; 
 Wed, 18 Oct 2023 08:55:07 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm1969364wmf.39.2023.10.18.08.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 25/83] tests: bios-tables-test: Add ACPI table binaries for
 smbios type4 thread count test
Message-ID: <fc33930bd407244456561ffa64bbb1b9233f5007.1697644299.git.mst@redhat.com>
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
+ * Disassembly of /tmp/aml-1NP791, Wed Aug 23 21:51:31 2023
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
+ * Disassembly of /tmp/aml-2JP791, Wed Aug 23 21:51:31 2023
+ *
+ * ACPI Data Table [APIC]
+ *
+ * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
+ */
+
+[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
+[004h 0004   4]                 Table Length : 00000220
+[008h 0008   1]                     Revision : 03
+[009h 0009   1]                     Checksum : 63
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

+[1D4h 0468   1]                Subtable Type : 00 [Processor Local APIC]
+[1D5h 0469   1]                       Length : 08
+[1D6h 0470   1]                 Processor ID : 35
+[1D7h 0471   1]                Local Apic ID : 6A
+[1D8h 0472   4]        Flags (decoded below) : 00000000
+                           Processor Enabled : 0
+                      Runtime Online Capable : 0
+
+[1DCh 0476   1]                Subtable Type : 01 [I/O APIC]
+[1DDh 0477   1]                       Length : 0C
+[1DEh 0478   1]                  I/O Apic ID : 00
+[1DFh 0479   1]                     Reserved : 00
+[1E0h 0480   4]                      Address : FEC00000
+[1E4h 0484   4]                    Interrupt : 00000000
+
+[1E8h 0488   1]                Subtable Type : 02 [Interrupt Source Override]
+[1E9h 0489   1]                       Length : 0A
+[1EAh 0490   1]                          Bus : 00
+[1EBh 0491   1]                       Source : 00
+[1ECh 0492   4]                    Interrupt : 00000002
+[1F0h 0496   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0
+
+[1F2h 0498   1]                Subtable Type : 02 [Interrupt Source Override]
+[1F3h 0499   1]                       Length : 0A
+[1F4h 0500   1]                          Bus : 00
+[1F5h 0501   1]                       Source : 05
+[1F6h 0502   4]                    Interrupt : 00000005
+[1FAh 0506   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[1FCh 0508   1]                Subtable Type : 02 [Interrupt Source Override]
+[1FDh 0509   1]                       Length : 0A
+[1FEh 0510   1]                          Bus : 00
+[1FFh 0511   1]                       Source : 09
+[200h 0512   4]                    Interrupt : 00000009
+[204h 0516   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[206h 0518   1]                Subtable Type : 02 [Interrupt Source Override]
+[207h 0519   1]                       Length : 0A
+[208h 0520   1]                          Bus : 00
+[209h 0521   1]                       Source : 0A
+[20Ah 0522   4]                    Interrupt : 0000000A
+[20Eh 0526   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[210h 0528   1]                Subtable Type : 02 [Interrupt Source Override]
+[211h 0529   1]                       Length : 0A
+[212h 0530   1]                          Bus : 00
+[213h 0531   1]                       Source : 0B
+[214h 0532   4]                    Interrupt : 0000000B
+[218h 0536   2]        Flags (decoded below) : 000D
+                                    Polarity : 1
+                                Trigger Mode : 3
+
+[21Ah 0538   1]                Subtable Type : 04 [Local APIC NMI]
+[21Bh 0539   1]                       Length : 06
+[21Ch 0540   1]                 Processor ID : FF
+[21Dh 0541   2]        Flags (decoded below) : 0000
+                                    Polarity : 0
+                                Trigger Mode : 0
+[21Fh 0543   1]         Interrupt Input LINT : 01

...

DSDT:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20200925 (64-bit version)
+ * Copyright (c) 2000 - 2020 Intel Corporation
+ *
+ * Disassembling to symbolic ASL+ operators
+ *
+ * Disassembly of /tmp/aml-00O791, Wed Aug 23 21:51:31 2023
+ *
+ * Original Table Header:
+ *     Signature        "DSDT"
+ *     Length           0x00003271 (12913)
+ *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
+ *     Checksum         0xAF
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

+            Processor (C035, 0x35, 0x00000000, 0x00)
+            {
+                Method (_STA, 0, Serialized)  // _STA: Status
+                {
+                    Return (CSTA (0x35))
+                }
+
+                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
+                {
+                     0x00, 0x08, 0x35, 0x6A, 0x01, 0x00, 0x00, 0x00   // ..5j....
+                })
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
+                {
+                    CEJ0 (0x35)
+                }
+
+                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
+                {
+                    COST (0x35, Arg0, Arg1, Arg2)
+                }
+            }

...

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-14-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 tests/data/acpi/q35/APIC.thread-count       | Bin 0 -> 544 bytes
 tests/data/acpi/q35/DSDT.thread-count       | Bin 0 -> 12913 bytes
 tests/data/acpi/q35/FACP.thread-count       | Bin 0 -> 244 bytes
 4 files changed, 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 4d139d7f6b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/APIC.thread-count",
-"tests/data/acpi/q35/DSDT.thread-count",
-"tests/data/acpi/q35/FACP.thread-count",
diff --git a/tests/data/acpi/q35/APIC.thread-count b/tests/data/acpi/q35/APIC.thread-count
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c27e87fcf1c04a2e75f9a20f2bc6a28f19aadf66 100644
GIT binary patch
literal 544
zcmXxe*-pYh7(n4^X=@iyb^*5m0Ri{zURpKajdcxrrJx3VN*;wLL1%j6B=dhKlgVWI
z@i3C65UELc8x0<0IEo{wmLY`DtrcRvNOXlj!$8x-l!ca!wu6p~OCGvDdRg>y800Zs
z#7qg7%eYcWzTsx8n5$u4Vxf-329}ywZsBShD;=zMvDU-23taExMu?l2xOIi{8tVgW
z3~~Dgn=!WTuzim^kJx#_?lbmAxch>8uekq)2k&?|#-k5B{=}0nJe}g%H=h4!jkKP#
eg`TFbwhmpkt<321y#Mmm1<ryXDa-j)Py7K+#~uLy

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.thread-count b/tests/data/acpi/q35/DSDT.thread-count
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a24b04cbdbf09383b933a42a2a15182545543a87 100644
GIT binary patch
literal 12913
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
Pm7vcgZUt5Fe;xh|kQQ*J

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/FACP.thread-count b/tests/data/acpi/q35/FACP.thread-count
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


