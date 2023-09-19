Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50B7A5AAC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUxs-00024f-9A; Tue, 19 Sep 2023 03:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUxm-00024G-7m
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:16:03 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qiUxh-00025h-8Y
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695107757; x=1726643757;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AfTPzM/A1rZBoZ7ZCoElnmOKlKS+WLX49hc1n0qm6+o=;
 b=hiuhrsiwyezsvR9yexS4zUPbtcbFOaHsaZzIAuthWnNqfwSjauw4sunt
 WT41BBvRzDxrGfvDqRGb4Ba049VzcLZyJZhH5vsXmfFF+sNxIpt9tlnN7
 kIoE3YyQN9Jd4i+DJg5C3o87jeETF/vVhDTa6LRcLz57oJsTMgEPxDo3Y
 mqPzOCKhkagSixpxHsv0YBhqrqrNfdQk7kioWHPYghQUoyhee4MrfvYC6
 TFqrV76FLpyqFZq/cXemLfbk4oVfF0IXv0lVdK0/U9TgY4j553+s8MXGt
 zcqUStGhjK+rqT/lWffjCEgWVnkxIifxs7gLNVBNC5RToMhrDk7rg68c/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446346598"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="446346598"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 00:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="993056821"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; d="scan'208";a="993056821"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2023 00:15:50 -0700
Date: Tue, 19 Sep 2023 15:26:55 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 04/16] tests: bios-tables-test: Add ACPI table binaries
 for type4 count test
Message-ID: <ZQlNPwb1UhUOFOrl@liuzhao-OptiPlex-7080>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-5-zhao1.liu@linux.intel.com>
 <20230915150510.7b3f0f60@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915150510.7b3f0f60@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

On Fri, Sep 15, 2023 at 03:05:10PM +0200, Igor Mammedov wrote:
> Date: Fri, 15 Sep 2023 15:05:10 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 04/16] tests: bios-tables-test: Add ACPI table binaries
>  for type4 count test
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Fri, 25 Aug 2023 11:36:07 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> copy/past mistake in subj?
> 
> shouldn't it be for 'smbios  type4 count'?

Thanks! I just thought the subject is too long and omitted the word
"smbios", I'll correct it as:

"tests: bios-tables-test: Add ACPI table binaries for smbios type4 count test"

-Zhao

> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Following the guidelines in tests/qtest/bios-tables-test.c, this
> > is step 5 and 6.
> > 
> > Changes in the tables:
> > FACP:
> > 
> > +/*
> > + * Intel ACPI Component Architecture
> > + * AML/ASL+ Disassembler version 20200925 (64-bit version)
> > + * Copyright (c) 2000 - 2020 Intel Corporation
> > + *
> > + * Disassembly of /tmp/aml-W37791, Wed Aug 23 10:36:32 2023
> > + *
> > + * ACPI Data Table [FACP]
> > + *
> > + * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
> > + */
> > +
> > +[000h 0000   4]                    Signature : "FACP"    [Fixed ACPI Description Table (FADT)]
> > +[004h 0004   4]                 Table Length : 000000F4
> > +[008h 0008   1]                     Revision : 03
> > +[009h 0009   1]                     Checksum : B3
> > +[00Ah 0010   6]                       Oem ID : "BOCHS "
> > +[010h 0016   8]                 Oem Table ID : "BXPC    "
> > +[018h 0024   4]                 Oem Revision : 00000001
> > +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
> > +[020h 0032   4]        Asl Compiler Revision : 00000001
> > +
> > +[024h 0036   4]                 FACS Address : 00000000
> > +[028h 0040   4]                 DSDT Address : 00000000
> > +[02Ch 0044   1]                        Model : 01
> > +[02Dh 0045   1]                   PM Profile : 00 [Unspecified]
> > +[02Eh 0046   2]                SCI Interrupt : 0009
> > +[030h 0048   4]             SMI Command Port : 000000B2
> > +[034h 0052   1]            ACPI Enable Value : 02
> > +[035h 0053   1]           ACPI Disable Value : 03
> > +[036h 0054   1]               S4BIOS Command : 00
> > +[037h 0055   1]              P-State Control : 00
> > +[038h 0056   4]     PM1A Event Block Address : 00000600
> > +[03Ch 0060   4]     PM1B Event Block Address : 00000000
> > +[040h 0064   4]   PM1A Control Block Address : 00000604
> > +[044h 0068   4]   PM1B Control Block Address : 00000000
> > +[048h 0072   4]    PM2 Control Block Address : 00000000
> > +[04Ch 0076   4]       PM Timer Block Address : 00000608
> > +[050h 0080   4]           GPE0 Block Address : 00000620
> > +[054h 0084   4]           GPE1 Block Address : 00000000
> > +[058h 0088   1]       PM1 Event Block Length : 04
> > +[059h 0089   1]     PM1 Control Block Length : 02
> > +[05Ah 0090   1]     PM2 Control Block Length : 00
> > +[05Bh 0091   1]        PM Timer Block Length : 04
> > +[05Ch 0092   1]            GPE0 Block Length : 10
> > +[05Dh 0093   1]            GPE1 Block Length : 00
> > +[05Eh 0094   1]             GPE1 Base Offset : 00
> > +[05Fh 0095   1]                 _CST Support : 00
> > +[060h 0096   2]                   C2 Latency : 0FFF
> > +[062h 0098   2]                   C3 Latency : 0FFF
> > +[064h 0100   2]               CPU Cache Size : 0000
> > +[066h 0102   2]           Cache Flush Stride : 0000
> > +[068h 0104   1]            Duty Cycle Offset : 00
> > +[069h 0105   1]             Duty Cycle Width : 00
> > +[06Ah 0106   1]          RTC Day Alarm Index : 00
> > +[06Bh 0107   1]        RTC Month Alarm Index : 00
> > +[06Ch 0108   1]            RTC Century Index : 32
> > +[06Dh 0109   2]   Boot Flags (decoded below) : 0002
> > +               Legacy Devices Supported (V2) : 0
> > +            8042 Present on ports 60/64 (V2) : 1
> > +                        VGA Not Present (V4) : 0
> > +                      MSI Not Supported (V4) : 0
> > +                PCIe ASPM Not Supported (V4) : 0
> > +                   CMOS RTC Not Present (V5) : 0
> > +[06Fh 0111   1]                     Reserved : 00
> > +[070h 0112   4]        Flags (decoded below) : 000484A5
> > +      WBINVD instruction is operational (V1) : 1
> > +              WBINVD flushes all caches (V1) : 0
> > +                    All CPUs support C1 (V1) : 1
> > +                  C2 works on MP system (V1) : 0
> > +            Control Method Power Button (V1) : 0
> > +            Control Method Sleep Button (V1) : 1
> > +        RTC wake not in fixed reg space (V1) : 0
> > +            RTC can wake system from S4 (V1) : 1
> > +                        32-bit PM Timer (V1) : 0
> > +                      Docking Supported (V1) : 0
> > +               Reset Register Supported (V2) : 1
> > +                            Sealed Case (V3) : 0
> > +                    Headless - No Video (V3) : 0
> > +        Use native instr after SLP_TYPx (V3) : 0
> > +              PCIEXP_WAK Bits Supported (V4) : 0
> > +                     Use Platform Timer (V4) : 1
> > +               RTC_STS valid on S4 wake (V4) : 0
> > +                Remote Power-on capable (V4) : 0
> > +                 Use APIC Cluster Model (V4) : 1
> > +     Use APIC Physical Destination Mode (V4) : 0
> > +                       Hardware Reduced (V5) : 0
> > +                      Low Power S0 Idle (V5) : 0
> > +
> > +[074h 0116  12]               Reset Register : [Generic Address Structure]
> > +[074h 0116   1]                     Space ID : 01 [SystemIO]
> > +[075h 0117   1]                    Bit Width : 08
> > +[076h 0118   1]                   Bit Offset : 00
> > +[077h 0119   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[078h 0120   8]                      Address : 0000000000000CF9
> > +
> > +[080h 0128   1]         Value to cause reset : 0F
> > +[081h 0129   2]    ARM Flags (decoded below) : 0000
> > +                              PSCI Compliant : 0
> > +                       Must use HVC for PSCI : 0
> > +
> > +[083h 0131   1]          FADT Minor Revision : 00
> > +[084h 0132   8]                 FACS Address : 0000000000000000
> > +[08Ch 0140   8]                 DSDT Address : 0000000000000000
> > +[094h 0148  12]             PM1A Event Block : [Generic Address Structure]
> > +[094h 0148   1]                     Space ID : 01 [SystemIO]
> > +[095h 0149   1]                    Bit Width : 20
> > +[096h 0150   1]                   Bit Offset : 00
> > +[097h 0151   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[098h 0152   8]                      Address : 0000000000000600
> > +
> > +[0A0h 0160  12]             PM1B Event Block : [Generic Address Structure]
> > +[0A0h 0160   1]                     Space ID : 00 [SystemMemory]
> > +[0A1h 0161   1]                    Bit Width : 00
> > +[0A2h 0162   1]                   Bit Offset : 00
> > +[0A3h 0163   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0A4h 0164   8]                      Address : 0000000000000000
> > +
> > +[0ACh 0172  12]           PM1A Control Block : [Generic Address Structure]
> > +[0ACh 0172   1]                     Space ID : 01 [SystemIO]
> > +[0ADh 0173   1]                    Bit Width : 10
> > +[0AEh 0174   1]                   Bit Offset : 00
> > +[0AFh 0175   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0B0h 0176   8]                      Address : 0000000000000604
> > +
> > +[0B8h 0184  12]           PM1B Control Block : [Generic Address Structure]
> > +[0B8h 0184   1]                     Space ID : 00 [SystemMemory]
> > +[0B9h 0185   1]                    Bit Width : 00
> > +[0BAh 0186   1]                   Bit Offset : 00
> > +[0BBh 0187   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0BCh 0188   8]                      Address : 0000000000000000
> > +
> > +[0C4h 0196  12]            PM2 Control Block : [Generic Address Structure]
> > +[0C4h 0196   1]                     Space ID : 00 [SystemMemory]
> > +[0C5h 0197   1]                    Bit Width : 00
> > +[0C6h 0198   1]                   Bit Offset : 00
> > +[0C7h 0199   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0C8h 0200   8]                      Address : 0000000000000000
> > +
> > +[0D0h 0208  12]               PM Timer Block : [Generic Address Structure]
> > +[0D0h 0208   1]                     Space ID : 01 [SystemIO]
> > +[0D1h 0209   1]                    Bit Width : 20
> > +[0D2h 0210   1]                   Bit Offset : 00
> > +[0D3h 0211   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0D4h 0212   8]                      Address : 0000000000000608
> > +
> > +[0DCh 0220  12]                   GPE0 Block : [Generic Address Structure]
> > +[0DCh 0220   1]                     Space ID : 01 [SystemIO]
> > +[0DDh 0221   1]                    Bit Width : 80
> > +[0DEh 0222   1]                   Bit Offset : 00
> > +[0DFh 0223   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0E0h 0224   8]                      Address : 0000000000000620
> > +
> > +[0E8h 0232  12]                   GPE1 Block : [Generic Address Structure]
> > +[0E8h 0232   1]                     Space ID : 00 [SystemMemory]
> > +[0E9h 0233   1]                    Bit Width : 00
> > +[0EAh 0234   1]                   Bit Offset : 00
> > +[0EBh 0235   1]         Encoded Access Width : 00 [Undefined/Legacy]
> > +[0ECh 0236   8]                      Address : 0000000000000000
> > +
> > ...
> > 
> > APIC:
> > 
> > +/*
> > + * Intel ACPI Component Architecture
> > + * AML/ASL+ Disassembler version 20200925 (64-bit version)
> > + * Copyright (c) 2000 - 2020 Intel Corporation
> > + *
> > + * Disassembly of /tmp/aml-687791, Wed Aug 23 10:36:32 2023
> > + *
> > + * ACPI Data Table [APIC]
> > + *
> > + * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
> > + */
> > +
> > +[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
> > +[004h 0004   4]                 Table Length : 00000430
> > +[008h 0008   1]                     Revision : 03
> > +[009h 0009   1]                     Checksum : C5
> > +[00Ah 0010   6]                       Oem ID : "BOCHS "
> > +[010h 0016   8]                 Oem Table ID : "BXPC    "
> > +[018h 0024   4]                 Oem Revision : 00000001
> > +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
> > +[020h 0032   4]        Asl Compiler Revision : 00000001
> > +
> > +[024h 0036   4]           Local Apic Address : FEE00000
> > +[028h 0040   4]        Flags (decoded below) : 00000001
> > +                         PC-AT Compatibility : 1
> > +
> > +[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
> > +[02Dh 0045   1]                       Length : 08
> > +[02Eh 0046   1]                 Processor ID : 00
> > +[02Fh 0047   1]                Local Apic ID : 00
> > +[030h 0048   4]        Flags (decoded below) : 00000001
> > +                           Processor Enabled : 1
> > +                      Runtime Online Capable : 0
> > +
> > +[034h 0052   1]                Subtable Type : 00 [Processor Local APIC]
> > +[035h 0053   1]                       Length : 08
> > +[036h 0054   1]                 Processor ID : 01
> > +[037h 0055   1]                Local Apic ID : 01
> > +[038h 0056   4]        Flags (decoded below) : 00000001
> > +                           Processor Enabled : 1
> > +                      Runtime Online Capable : 0
> > 
> > [snip]
> > 
> > +[3E4h 0996   1]                Subtable Type : 00 [Processor Local APIC]
> > +[3E5h 0997   1]                       Length : 08
> > +[3E6h 0998   1]                 Processor ID : 77
> > +[3E7h 0999   1]                Local Apic ID : 9E
> > +[3E8h 1000   4]        Flags (decoded below) : 00000000
> > +                           Processor Enabled : 0
> > +                      Runtime Online Capable : 0
> > +
> > +[3ECh 1004   1]                Subtable Type : 01 [I/O APIC]
> > +[3EDh 1005   1]                       Length : 0C
> > +[3EEh 1006   1]                  I/O Apic ID : 00
> > +[3EFh 1007   1]                     Reserved : 00
> > +[3F0h 1008   4]                      Address : FEC00000
> > +[3F4h 1012   4]                    Interrupt : 00000000
> > +
> > +[3F8h 1016   1]                Subtable Type : 02 [Interrupt Source Override]
> > +[3F9h 1017   1]                       Length : 0A
> > +[3FAh 1018   1]                          Bus : 00
> > +[3FBh 1019   1]                       Source : 00
> > +[3FCh 1020   4]                    Interrupt : 00000002
> > +[400h 1024   2]        Flags (decoded below) : 0000
> > +                                    Polarity : 0
> > +                                Trigger Mode : 0
> > +
> > +[402h 1026   1]                Subtable Type : 02 [Interrupt Source Override]
> > +[403h 1027   1]                       Length : 0A
> > +[404h 1028   1]                          Bus : 00
> > +[405h 1029   1]                       Source : 05
> > +[406h 1030   4]                    Interrupt : 00000005
> > +[40Ah 1034   2]        Flags (decoded below) : 000D
> > +                                    Polarity : 1
> > +                                Trigger Mode : 3
> > +
> > +[40Ch 1036   1]                Subtable Type : 02 [Interrupt Source Override]
> > +[40Dh 1037   1]                       Length : 0A
> > +[40Eh 1038   1]                          Bus : 00
> > +[40Fh 1039   1]                       Source : 09
> > +[410h 1040   4]                    Interrupt : 00000009
> > +[414h 1044   2]        Flags (decoded below) : 000D
> > +                                    Polarity : 1
> > +                                Trigger Mode : 3
> > +
> > +[416h 1046   1]                Subtable Type : 02 [Interrupt Source Override]
> > +[417h 1047   1]                       Length : 0A
> > +[418h 1048   1]                          Bus : 00
> > +[419h 1049   1]                       Source : 0A
> > +[41Ah 1050   4]                    Interrupt : 0000000A
> > +[41Eh 1054   2]        Flags (decoded below) : 000D
> > +                                    Polarity : 1
> > +                                Trigger Mode : 3
> > +
> > +[420h 1056   1]                Subtable Type : 02 [Interrupt Source Override]
> > +[421h 1057   1]                       Length : 0A
> > +[422h 1058   1]                          Bus : 00
> > +[423h 1059   1]                       Source : 0B
> > +[424h 1060   4]                    Interrupt : 0000000B
> > +[428h 1064   2]        Flags (decoded below) : 000D
> > +                                    Polarity : 1
> > +                                Trigger Mode : 3
> > +
> > +[42Ah 1066   1]                Subtable Type : 04 [Local APIC NMI]
> > +[42Bh 1067   1]                       Length : 06
> > +[42Ch 1068   1]                 Processor ID : FF
> > +[42Dh 1069   2]        Flags (decoded below) : 0000
> > +                                    Polarity : 0
> > +                                Trigger Mode : 0
> > +[42Fh 1071   1]         Interrupt Input LINT : 01
> > +
> > ...
> > 
> > DSDT:
> > 
> > +/*
> > + * Intel ACPI Component Architecture
> > + * AML/ASL+ Disassembler version 20200925 (64-bit version)
> > + * Copyright (c) 2000 - 2020 Intel Corporation
> > + *
> > + * Disassembling to symbolic ASL+ operators
> > + *
> > + * Disassembly of /tmp/aml-8G8791, Wed Aug 23 10:36:32 2023
> > + *
> > + * Original Table Header:
> > + *     Signature        "DSDT"
> > + *     Length           0x0000489D (18589)
> > + *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> > + *     Checksum         0xDB
> > + *     OEM ID           "BOCHS "
> > + *     OEM Table ID     "BXPC    "
> > + *     OEM Revision     0x00000001 (1)
> > + *     Compiler ID      "BXPC"
> > + *     Compiler Version 0x00000001 (1)
> > + */
> > +DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
> > +{
> > +    Scope (\)
> > +    {
> > +        OperationRegion (DBG, SystemIO, 0x0402, One)
> > +        Field (DBG, ByteAcc, NoLock, Preserve)
> > +        {
> > +            DBGB,   8
> > +        }
> > +
> > +        Method (DBUG, 1, NotSerialized)
> > +        {
> > +            ToHexString (Arg0, Local0)
> > +            ToBuffer (Local0, Local0)
> > +            Local1 = (SizeOf (Local0) - One)
> > +            Local2 = Zero
> > +            While ((Local2 < Local1))
> > +            {
> > +                DBGB = DerefOf (Local0 [Local2])
> > +                Local2++
> > +            }
> > +
> > +            DBGB = 0x0A
> > +        }
> > +    }
> > +
> > 
> > [snip]
> > 
> > +
> > +            Processor (C000, 0x00, 0x00000000, 0x00)
> > +            {
> > +                Method (_STA, 0, Serialized)  // _STA: Status
> > +                {
> > +                    Return (CSTA (Zero))
> > +                }
> > +
> > +                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
> > +                {
> > +                     0x00, 0x08, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00   // ........
> > +                })
> > +                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
> > +                {
> > +                    COST (Zero, Arg0, Arg1, Arg2)
> > +                }
> > +            }
> > +
> > +            Processor (C001, 0x01, 0x00000000, 0x00)
> > +            {
> > +                Method (_STA, 0, Serialized)  // _STA: Status
> > +                {
> > +                    Return (CSTA (One))
> > +                }
> > +
> > +                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
> > +                {
> > +                     0x00, 0x08, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00   // ........
> > +                })
> > +                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
> > +                {
> > +                    CEJ0 (One)
> > +                }
> > +
> > +                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
> > +                {
> > +                    COST (One, Arg0, Arg1, Arg2)
> > +                }
> > +            }
> > 
> > [snip]
> > 
> > +            Processor (C077, 0x77, 0x00000000, 0x00)
> > +            {
> > +                Method (_STA, 0, Serialized)  // _STA: Status
> > +                {
> > +                    Return (CSTA (0x77))
> > +                }
> > +
> > +                Name (_MAT, Buffer (0x08)  // _MAT: Multiple APIC Table Entry
> > +                {
> > +                     0x00, 0x08, 0x77, 0x9E, 0x01, 0x00, 0x00, 0x00   // ..w.....
> > +                })
> > +                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
> > +                {
> > +                    CEJ0 (0x77)
> > +                }
> > +
> > +                Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
> > +                {
> > +                    COST (0x77, Arg0, Arg1, Arg2)
> > +                }
> > +            }
> > +        }
> > +    }
> > +
> > ...
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  tests/data/acpi/q35/APIC.type4-count        | Bin 0 -> 1072 bytes
> >  tests/data/acpi/q35/DSDT.type4-count        | Bin 0 -> 18589 bytes
> >  tests/data/acpi/q35/FACP.type4-count        | Bin 0 -> 244 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
> >  4 files changed, 3 deletions(-)
> > 
> > diff --git a/tests/data/acpi/q35/APIC.type4-count b/tests/data/acpi/q35/APIC.type4-count
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..ab60a6ef065d8ce53ae93d311d3777d2d4afb9f6 100644
> > GIT binary patch
> > literal 1072
> > zcmXxjX)mKu7{>9_YU}A{8~a-OZpzsAwwBgf>(n~-!C>rL5ClOG1VQjwyzxDJ5<E};  
> > zagzJ~UFYQFB<IC#bGsZ?jSxO>_Ev|p!(#Wi9Ts`1gb+$r6yp8Et0V-fRH#;?j|Meb
> > z)ap<tp|2h#1L{p^Fr(2AO#x^QM86>P55|BH3=GAfaQqR0!I2mejiE6Z7K`EDe+elf
> > zo_%BjMkQf%GRCA}Y#PR;qa_35voIkW6LT=hipjZ{l834Jm{x%4g_u!{nI)K2irM9u
> > zQ-MD#(OQkUHq5i*uNus+#ezC4bYhVUiyN?{2}_%?tOd*6SkZ=+?O4@`)m>=oM!N?c
> > zJy_F=wf$H(fc1mu975MHHjH577&eV#^8~g`V(S#Tr?G7Y+h?(34m;<uYXQ3#@%J)%
> > zR<LIkd)KjV1N%2|U<(Jg@y`wp?c(qrj_l*;0gfGd$3+@H!ii)2dxDdvICX~8=lJge
> > zXD)H}3g@oz{|(OH;=&y+-s92(E<fVR6Rtkv+KZyfr1aMhrK=5cDM3kEt*lu|di{4Y
> > Q$QL*>8of!Q`;?#f0%hq@0RR91  
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/q35/DSDT.type4-count b/tests/data/acpi/q35/DSDT.type4-count
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..edc23198cdb47a981bcbc82bc8e392b815abb554 100644
> > GIT binary patch
> > literal 18589
> > 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%0ALbj|l0}uT;__N_ymyhGKP{  
> > zR41hRw<@VlNp(qzKh{Z)3F+~7D(NvLJ(i@z6P@&gke>WnB|V{}Cz90nR3|+pq^Eza
> > zlAco1Q%UN7rjwo#(zCx&NzW+hnIsLY=%f`wTKQX*v_eTMk~H{SCp{;m=f6=&&nfA-
> > zBn`dLNiPWL#owu<7nJk@NYS0JX%;pBS2MAMA-4MB23p*=6e(=sJ8Ic4L9p$^V<GFG
> > zzicsl{4)D{OmB{wKZkz~n?X2khS|=LKfv8Thh4h`emKG~{)hdn2fH8tAI<ys{Gz{M
> > z_zcevegxq+E&hS^Wf*_&x#u1H638F<J@3xHg*9)UP52tvEB+t`-zwo8HE?eY>~pTH
> > z+5zYj7HQ$vR@iTjBw?d7-@}Z@$>wF)o;{tkU;_efm}Z-odm4KhP5AYZ%Ia94m@C4!
> > z0v!S;X_Jl6I_q8dUD(_X8?TSdLi%!FwWBd$LhYdYs~y3B<+EU;4p;+t54I6GBOiv!
> > z>dEXC8<qpGfT>Jj26h%D&|9fE(hzCD?beaZ&RN_*7b$e%qgYuDm18mZOq5KQpqr!R  
> > z*f2NX5i<?AvR#g+4ftIX5D7>0p@7b#<*anxgB!W?r753Pv%(QOz>-wnoId5pH0X)<
> > zn)v^l;QwMxrSQhan{?2CZR}GS)LFb4#hYBPvf4kMN<%UH$8h|xp9p(`?G5-SY`3<I
> > znl+<lnDBI4G#24+ua7;d`wN$5+^9CV%1@$#RzolTXiQ}_F;Sd`Rdvn|!1;o$>#&E4
> > z_(rUjQS%f3C;nit_cbFY>`MhVrUAS+kNMgEv)>5zMp(>&(zNYX6M{TgJVV!wx?u);  
> > k4HL_0D`%79y!#9|m3SZ}4*20fB#f^~_-_Ll_+6a;1CLN!@c;k-
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/data/acpi/q35/FACP.type4-count b/tests/data/acpi/q35/FACP.type4-count
> > index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..31fa5dd19c213034eef4eeefa6a04e61dadd8a2a 100644
> > GIT binary patch
> > literal 244
> > zcmZ>BbPo8!z`($~*~#D8BUr&HBEVSz2pEB4AU24G0Y(N+hD|^Y6El!tgNU*~X%LSC  
> > z$X0-fGcm9T0LA|E|L2FOWMD92VqjR>!otAF!NBm72O<iWged~jj0!*k$y^{03>bk1
> > YBHITON2VDSAnpK(F*YFF1LDH~0O^Si0RR91
> > 
> > literal 0
> > HcmV?d00001
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index 0ce6f8fc72ee..dfb8523c8bf4 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,4 +1 @@
> >  /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/q35/APIC.type4-count",
> > -"tests/data/acpi/q35/DSDT.type4-count",
> > -"tests/data/acpi/q35/FACP.type4-count",
> 

