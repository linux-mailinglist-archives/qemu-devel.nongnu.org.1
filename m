Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E1707EC5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbR0-0001Z9-J0; Thu, 18 May 2023 07:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbQy-0001Yd-Oi
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbQw-0004yh-PR
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684407873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cBd8Wo7vQZ0oYT5HnCN4mF0dOP/BHj5gweYXCk04v88=;
 b=MeWIx0vwB9WLmztiDliGO31681i/GpZTdMG1Y2tF+iqZjVg3+5dRClVsgAi5ks0J6xX/sQ
 Xd9Izebj8IwEYKRvdHYyFR7+SbW/iJx6HVjsVBu5+xbItztO/8bOnPiO468d2QLrQjqRnJ
 sDO2oLBNdXbj4cgHwGookXZL3qQhACk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-7q0MTwZWOYORMQD_oREvig-1; Thu, 18 May 2023 07:04:31 -0400
X-MC-Unique: 7q0MTwZWOYORMQD_oREvig-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5289ceb2331so629715a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684407870; x=1686999870;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cBd8Wo7vQZ0oYT5HnCN4mF0dOP/BHj5gweYXCk04v88=;
 b=lBDcE++kAorg66PcTyDTgsJVmAXIx6glzPZ0HWk0oua0xTsFo1rUt3sZy9foi7MCC1
 A8BVs1+P9JM3s7+v59UAhx244+2nGEuhVvqiJpBCZAYseJc/OyoY/4Z4QrGNnGTmpe0F
 1YzyP4jwr2RDLSO17QAHR5Fu5g+yN+Z9SYCrs0LeseQ7EKibIeNCKoxUd8Y9KREr8XAl
 QperkuK84d108Jk8s7177oCoNCnQw34ube7jSHmbUcLX8kpIz3IutdV82WLbya86THzM
 DEXXsmr3kbjKQcG777ktcQzx9t44SKUcBoWacp8uivnFsHOU7BLogutbIYZZShFfJS9j
 bkCw==
X-Gm-Message-State: AC+VfDzsY1t+USuK1WRM4dllwts9nGWVD/2cEFytUX7jhMNpsPzXIlBM
 ePO+U3FaBRWrTkh14F4FP92nDeAYzolAzrdDp92/jg8/tz3DTXBC9QInKKSLR7hiZFAL0k9WalK
 wN8TghWB7iBvGR54=
X-Received: by 2002:a17:902:f549:b0:1ae:b2a:8ed7 with SMTP id
 h9-20020a170902f54900b001ae0b2a8ed7mr2100673plf.29.1684407870275; 
 Thu, 18 May 2023 04:04:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zgOj50E/2818RpJuoDEDvNR1xEaheF86Dc6A5NgMjGEFh6SwGOb7Jqs5NZUqNXWe/dP02hA==
X-Received: by 2002:a17:902:f549:b0:1ae:b2a:8ed7 with SMTP id
 h9-20020a170902f54900b001ae0b2a8ed7mr2100630plf.29.1684407869850; 
 Thu, 18 May 2023 04:04:29 -0700 (PDT)
Received: from fc37-ani ([115.96.106.170])
 by smtp.googlemail.com with ESMTPSA id
 j13-20020a170902da8d00b001ac94b33ab1sm1101114plx.304.2023.05.18.04.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:04:29 -0700 (PDT)
Date: Thu, 18 May 2023 16:34:23 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, 
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Subject: Re: [PATCH v2 3/3] ACPI: bios-tables-test.c step 5 (update expected
 table binaries)
In-Reply-To: <20230517162545.2191-4-eric.devolder@oracle.com>
Message-ID: <23dcd032-a0b4-4b33-a6f3-1666dc58caa4@redhat.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
 <20230517162545.2191-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On Wed, 17 May 2023, Eric DeVolder wrote:

> Following the guidelines in tests/qtest/bios-tables-test.c, this
> is step 5 and 6.
>
> An examination of all the files impacted (as listed in
> bios-tables-test-allowe-diff.h) shows only the MADT/APIC tables
> bumping revision from 1 to 3, and a corresponding change to
> the checksum. The below diff is typical:
>
>  --- /tmp/asl-1F9641.dsl	2023-05-16 15:18:31.292579156 -0400
>  +++ /tmp/asl-GVD741.dsl	2023-05-16 15:18:31.291579149 -0400
>  @@ -1,32 +1,32 @@
>   /*
>    * Intel ACPI Component Architecture
>    * AML/ASL+ Disassembler version 20230331 (64-bit version)
>    * Copyright (c) 2000 - 2023 Intel Corporation
>    *
>  - * Disassembly of tests/data/acpi/pc/APIC, Tue May 16 15:18:31 2023
>  + * Disassembly of /tmp/aml-R4D741, Tue May 16 15:18:31 2023
>    *
>    * ACPI Data Table [APIC]
>    *
>    * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>    */
>
>   [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
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
>   [02Ch 0044 001h]               Subtable Type : 00 [Processor Local APIC]
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
>  -    0000: 41 50 49 43 78 00 00 00 01 8A 42 4F 43 48 53 20  // APICx.....BOCHS
>  +    0000: 41 50 49 43 78 00 00 00 03 88 42 4F 43 48 53 20  // APICx.....BOCHS
>       0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
>       0020: 01 00 00 00 00 00 E0 FE 01 00 00 00 00 08 00 00  // ................
>       0030: 01 00 00 00 01 0C 00 00 00 00 C0 FE 00 00 00 00  // ................
>       0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 05 05 00  // ................
>       0050: 00 00 0D 00 02 0A 00 09 09 00 00 00 0D 00 02 0A  // ................
>       0060: 00 0A 0A 00 00 00 0D 00 02 0A 00 0B 0B 00 00 00  // ................
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
>  tests/qtest/bios-tables-test-allowed-diff.h   |  14 --------------
>  15 files changed, 14 deletions(-)
>
> diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/microvm/APIC
> index 68dbd44a7e35a356083f086df60f70e424c4249f..672764e711d80402890902ba9ded10915770e84c 100644
> GIT binary patch
> delta 16
> XcmZ>B<8ln}barE4U|=qq$Ylcn95e$)
>
> delta 16
> XcmZ>B<8ln}barE4U|=kn$Ylcn95Mq&
>
> diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/microvm/APIC.ioapic2
> index 3063c52cd3e9bbed29c06031b375900f4a49b9e0..6f24fdb12ce3f1c13df7ff835e475d8023e20d4a 100644
> GIT binary patch
> delta 16
> XcmWFv;&Ke|bPi%*U|?>X$mIb59$W*3
>
> delta 16
> XcmWFv;&Ke|bPi%*U|?*X$mIb59$Ev1
>
> diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/microvm/APIC.pcie
> index 4e8f6ed8d6a866429fc17aecdeafc3fb5ef65fa3..2239ca76a607fb1ff9d392298e2bd6461bba7ecf 100644
> GIT binary patch
> delta 16
> Xcmd1H<8ln}bk1X7U|_DA$dv*BBD@3c
>
> delta 16
> Xcmd1H<8ln}bk1X7U|_77$dv*BBDw?a
>
> diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/pc/APIC
> index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
> GIT binary patch
> delta 16
> Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m
>
> delta 16
> Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k
>
> diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acpihmat
> index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
> GIT binary patch
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t
>
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t
>
> diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/pc/APIC.cphp
> index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
> GIT binary patch
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3
>
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3
>
> diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/pc/APIC.dimmpxm
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/q35/APIC
> index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
> GIT binary patch
> delta 16
> Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m
>
> delta 16
> Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k
>
> diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.acpihmat
> index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
> GIT binary patch
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t
>
> delta 18
> ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t
>
> diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/acpi/q35/APIC.acpihmat-noinitiator
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/q35/APIC.core-count2
> index a255082ef5bc39f0d92d3e372b91f09dd6d0d9a1..f5da2eb1e8a93d961b39f665f2e8b02acf1aeb3c 100644
> GIT binary patch
> delta 19
> acmZ1{yiS<QF~HM#9VY_=^SO;&OE>{I`URQ*
>
> delta 19
> acmZ1{yiS<QF~HM#9VY_=<Ase}OE>{I_yw8(
>
> diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/q35/APIC.cphp
> index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
> GIT binary patch
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3
>
> delta 18
> ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3
>
> diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/q35/APIC.dimmpxm
> index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
> GIT binary patch
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>
>
> delta 18
> ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>
>
> diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/q35/APIC.xapic
> index c1969c35aa12b61d25e0134bbb8d2187ba42d663..83bd28325af9d6d7619015a9701866b8f3f1d754 100644
> GIT binary patch
> delta 19
> acmew-@=t`zF~HNgj*EeTS#2X%2^Ro9-UT)Q
>
> delta 19
> acmew-@=t`zF~HNgj*EeTQDY-l2^Ro9+yyoO
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 66ae44e6b9..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,15 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/microvm/APIC",
> -"tests/data/acpi/microvm/APIC.ioapic2",
> -"tests/data/acpi/microvm/APIC.pcie",
> -"tests/data/acpi/pc/APIC",
> -"tests/data/acpi/pc/APIC.acpihmat",
> -"tests/data/acpi/pc/APIC.cphp",
> -"tests/data/acpi/pc/APIC.dimmpxm",
> -"tests/data/acpi/q35/APIC",
> -"tests/data/acpi/q35/APIC.acpihmat",
> -"tests/data/acpi/q35/APIC.acpihmat-noinitiator",
> -"tests/data/acpi/q35/APIC.core-count2",
> -"tests/data/acpi/q35/APIC.cphp",
> -"tests/data/acpi/q35/APIC.dimmpxm",
> -"tests/data/acpi/q35/APIC.xapic",
> --
> 2.31.1
>
>


