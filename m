Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC5704663
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp6s-0003kq-0i; Tue, 16 May 2023 03:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp6g-0003kY-Pt
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:28:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp6e-00081f-Lv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:28:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f41d087b3bso106331655e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 00:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20221208.gappssmtp.com; s=20221208; t=1684222103; x=1686814103; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkkpinFsNSpl4gvroYjGfSBiHd9AH5pf6UVfznVwtSI=;
 b=ZsGwMDOuNSKvGXTLAA8v09F8z1vawJck5iCYkLA0KvwxP90mMi81RwbdUaQgQOQv6o
 k2grqkiU5H2QGYd0eDn3cOMxh1/BdVYDbMnjI4BgDay1+JLPso9DFV0aFZWBCVeKmlu6
 sabKTqL8QAYcVe1DUaJYGB9TjXB1L9yFLjO3TYbEHSuiBw0LUQmKkLk2eQbQTcYSxP2j
 W1d1xceWAzQRd/9hSkcJ3b846NNe/VZikGrIzU/1eF3C4LejNB8X/L6OQTcfNhBQclQT
 O+dZJ+Q7Gk22z3/ePcrmmI6RROf26uT7bsHFP1m5PVvBOW7ZWa+MDcF+1DRjpl1jiK0s
 5XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222103; x=1686814103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkkpinFsNSpl4gvroYjGfSBiHd9AH5pf6UVfznVwtSI=;
 b=DSIta8eNqakccwA1IF3CTwZ+YxGpOAvclvGe8atNWxxd8A1zb/h++jMMyk/DXJGz2K
 wRQBDbIBxFL+ljD4GGOQxm/n+BFYc0g0pLTbLHU+b80brV/w7sY6GN+W+P8TIinkk7CV
 KEwiv52M0D4foVDeFxeUZSCLXd0HKGDi2zD4/aSzixa7fWYWg1G/AnUksBs+vW++99jG
 ybc8lxvtNY97A9kQMweryQyc9uQ42uHHY1nqZl5x3qjZqtyFy+RMH7+HWbAGucb+HXrq
 chdOYxrN8sDgZM3/fnqu/zfu2hxDtHRUOE+3adtR7lLgho+6JcZVtQA4/iF8s5OB6ycf
 5dtQ==
X-Gm-Message-State: AC+VfDwtO9cphMFdSNtm8Z7CcyIdVIzPVqVN2GHQaZmkUeXCNMucPGGC
 zBpKtFrpgtL+3ikbd+B3eyO9CJ0W/fW8nm07wcITYg==
X-Google-Smtp-Source: ACHHUZ45pvUFe3c1Wu+u7NxwBKSpfpd3wsUEOAmOF/6GSJyqycQBjpxqPVhAuQwnBm0Sg7MQXWD+KXZaInZeImaYZTg=
X-Received: by 2002:a05:600c:217:b0:3f4:f0c2:143 with SMTP id
 23-20020a05600c021700b003f4f0c20143mr10319587wmi.20.1684222102805; Tue, 16
 May 2023 00:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-4-eric.devolder@oracle.com>
In-Reply-To: <20230515203311.2139-4-eric.devolder@oracle.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 May 2023 12:58:11 +0530
Message-ID: <CAARzgwzpWRGfvYBpmnDgjySu_16Y_fMXh3+b9Fggk_EKfP285A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: bios-tables-test.c step 5 (update expected
 table binaries)
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com, 
 imammedo@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::32c;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 2:03=E2=80=AFAM Eric DeVolder <eric.devolder@oracle=
.com> wrote:
>
> Following the guidelines in tests/qtest/bios-tables-test.c, this
> is step 5 and 6.
>
> The MADT/APIC table diffs show (for pc, q35 and microvm) bumping
> revision from 1 to 3 (and checksum changing accordingly):
>
>  Using expected file 'tests/data/acpi/pc/DSDT'
>  acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-9UKC=
51], Expected [aml:tests/data/acpi/pc/APIC].
>  See source file tests/qtest/bios-tables-test.c for instructions on how t=
o update expected files.
>  acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-CFKC51.dsl, aml:=
/tmp/aml-9UKC51], Expected [asl:/tmp/asl-TMFC51.dsl, aml:tests/data/acpi/pc=
/APIC].
>  --- /tmp/asl-TMFC51.dsl        2023-05-15 14:15:26.599183824 -0400
>  +++ /tmp/asl-CFKC51.dsl        2023-05-15 14:15:26.598183818 -0400
>  @@ -1,32 +1,32 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20230331 (64-bit version)
>    * Copyright (c) 2000 - 2023 Intel Corporation
>    *
>  - * Disassembly of tests/data/acpi/pc/APIC, Mon May 15 14:15:26 2023
>  + * Disassembly of /tmp/aml-9UKC51, Mon May 15 14:15:26 2023
>    *
>    * ACPI Data Table [APIC]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue=
 (in hex)
>    */
>
>   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC=
 Description Table (MADT)]
>   [004h 0004 004h]                Table Length : 00000078
>  -[008h 0008 001h]                    Revision : 01
>  -[009h 0009 001h]                    Checksum : 8A
>  +[008h 0008 001h]                    Revision : 03
>  +[009h 0009 001h]                    Checksum : 88
>   [00Ah 0010 006h]                      Oem ID : "BOCHS "
>   [010h 0016 008h]                Oem Table ID : "BXPC    "
>   [018h 0024 004h]                Oem Revision : 00000001
>   [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>   [020h 0032 004h]       Asl Compiler Revision : 00000001
>
>   [024h 0036 004h]          Local Apic Address : FEE00000
>   [028h 0040 004h]       Flags (decoded below) : 00000001
>                            PC-AT Compatibility : 1
>
>   [02Ch 0044 001h]               Subtable Type : 00 [Processor Local APIC=
]
>   [02Dh 0045 001h]                      Length : 08
>   [02Eh 0046 001h]                Processor ID : 00
>   [02Fh 0047 001h]               Local Apic ID : 00
>   [030h 0048 004h]       Flags (decoded below) : 00000001
>                              Processor Enabled : 1
>  @@ -81,24 +81,24 @@
>   [06Bh 0107 001h]                      Source : 0B
>   [06Ch 0108 004h]                   Interrupt : 0000000B
>   [070h 0112 002h]       Flags (decoded below) : 000D
>                                       Polarity : 1
>                                   Trigger Mode : 3
>
>   [072h 0114 001h]               Subtable Type : 04 [Local APIC NMI]
>   [073h 0115 001h]                      Length : 06
>   [074h 0116 001h]                Processor ID : FF
>   [075h 0117 002h]       Flags (decoded below) : 0000
>                                       Polarity : 0
>                                   Trigger Mode : 0
>   [077h 0119 001h]        Interrupt Input LINT : 01
>
>   Raw Table Data: Length 120 (0x78)
>
>  -    0000: 41 50 49 43 78 00 00 00 01 8A 42 4F 43 48 53 20  // APICx....=
.BOCHS
>  +    0000: 41 50 49 43 78 00 00 00 03 88 42 4F 43 48 53 20  // APICx....=
.BOCHS
>       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    .=
...BXPC
>       0020: 01 00 00 00 00 00 E0 FE 01 00 00 00 00 08 00 00  // .........=
.......
>       0030: 01 00 00 00 01 0C 00 00 00 00 C0 FE 00 00 00 00  // .........=
.......
>       0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 05 05 00  // .........=
.......
>       0050: 00 00 0D 00 02 0A 00 09 09 00 00 00 0D 00 02 0A  // .........=
.......
>       0060: 00 0A 0A 00 00 00 0D 00 02 0A 00 0B 0B 00 00 00  // .........=
.......
>       0070: 0D 00 04 06 FF 00 00 01                          // ........
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
>  tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
>  tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
>  tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
>  tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
>  tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
>  tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
>  tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
>  tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
>  tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
>  tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
>  15 files changed, 4 deletions(-)
>
> diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/microvm/APIC
> index 68dbd44a7e35a356083f086df60f70e424c4249f..672764e711d80402890902ba9=
ded10915770e84c 100644
> GIT binary patch
> delta 16
> XcmZ>B<8ln}barE4U|=3Dqq$Ylcn95e$)
>
> delta 16
> XcmZ>B<8ln}barE4U|=3Dkn$Ylcn95Mq&
>
> diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/micro=
vm/APIC.ioapic2
> index 3063c52cd3e9bbed29c06031b375900f4a49b9e0..6f24fdb12ce3f1c13df7ff835=
e475d8023e20d4a 100644
> GIT binary patch
> delta 16
> XcmWFv;&Ke|bPi%*U|?>X$mIb59$W*3
>
> delta 16
> XcmWFv;&Ke|bPi%*U|?*X$mIb59$Ev1
>
> diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/microvm/=
APIC.pcie
> index 4e8f6ed8d6a866429fc17aecdeafc3fb5ef65fa3..2239ca76a607fb1ff9d392298=
e2bd6461bba7ecf 100644
> GIT binary patch
> delta 16
> Xcmd1H<8ln}bk1X7U|_DA$dv*BBD@3c
>
> delta 16
> Xcmd1H<8ln}bk1X7U|_77$dv*BBDw?a
>
> diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/pc/APIC
> index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75=
483ef4bec455d74 100644
> GIT binary patch
> delta 16
> Xcmb=3DZ;BpM`bgp1vU|{Z;$dv~GB#s0m
>
> delta 16
> Xcmb=3DZ;BpM`bgp1vU|{T;$dv~GB#Z<k
>
> diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.a=
cpihmat
> index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2a=
fbff70edf221291 100644
> GIT binary patch
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t
>
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t
>
> diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/pc/APIC.cphp
> index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f=
78eeda6d7b8bbdb 100644
> GIT binary patch
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3
>
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3
>
> diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/pc/APIC.di=
mmpxm
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970=
d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/q35/APIC
> index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75=
483ef4bec455d74 100644
> GIT binary patch
> delta 16
> Xcmb=3DZ;BpM`bgp1vU|{Z;$dv~GB#s0m
>
> delta 16
> Xcmb=3DZ;BpM`bgp1vU|{T;$dv~GB#Z<k
>
> diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC=
.acpihmat
> index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2a=
fbff70edf221291 100644
> GIT binary patch
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t
>
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t
>
> diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/a=
cpi/q35/APIC.acpihmat-noinitiator
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970=
d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/q35/A=
PIC.core-count2
> index a255082ef5bc39f0d92d3e372b91f09dd6d0d9a1..f5da2eb1e8a93d961b39f665f=
2e8b02acf1aeb3c 100644
> GIT binary patch
> delta 19
> acmZ1{yiS<QF~HM#9VY_=3D^SO;&OE>{I`URQ*
>
> delta 19
> acmZ1{yiS<QF~HM#9VY_=3D<Ase}OE>{I_yw8(
>
> diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/q35/APIC.cph=
p
> index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f=
78eeda6d7b8bbdb 100644
> GIT binary patch
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3
>
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3
>
> diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/q35/APIC.=
dimmpxm
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970=
d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/q35/APIC.xa=
pic
> index c1969c35aa12b61d25e0134bbb8d2187ba42d663..83bd28325af9d6d7619015a97=
01866b8f3f1d754 100644
> GIT binary patch
> delta 19
> acmew-@=3Dt`zF~HNgj*EeTS#2X%2^Ro9-UT)Q
>
> delta 19
> acmew-@=3Dt`zF~HNgj*EeTQDY-l2^Ro9+yyoO
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 1e5e354ecf..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,5 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/pc/APIC",
> -"tests/data/acpi/q35/APIC",
> -"tests/data/acpi/microvm/APIC",
> -"tests/data/acpi/virt/APIC",
> --
> 2.31.1
>

