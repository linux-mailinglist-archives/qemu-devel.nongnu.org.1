Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C616AEF32D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Jul 2025 11:24:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXCM-0007BX-RW; Tue, 01 Jul 2025 05:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXCJ-0007Ae-QR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWXCG-000058-7W
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751361753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c82TwcmL6p/OmbHJu7kTaEncL6FZUKhOU6c1vF317k=;
 b=ArSmqTkGy6vpO65WmLoJldbOjBgjSvicwbr8jlXHTU7bqVet1aCdURWadiII44n9oaREHj
 8nMKWaH+p8PiiyBN/nraj3NQUM9es9HSrzadZjUxto0CYEpnOBG5p+Dly7uzr5nc4qC2SJ
 m8R+lSqxBb6vR0Fm2OpRdHHYKT9kykE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-NwGlS_PcNkSV2opRaZ7wBA-1; Tue, 01 Jul 2025 05:22:32 -0400
X-MC-Unique: NwGlS_PcNkSV2opRaZ7wBA-1
X-Mimecast-MFC-AGG-ID: NwGlS_PcNkSV2opRaZ7wBA_1751361751
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-453691d0a1dso17681985e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751361749; x=1751966549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3c82TwcmL6p/OmbHJu7kTaEncL6FZUKhOU6c1vF317k=;
 b=Jg84R7qiidfostV7mOM5Es6d77FVDJkFOv6xd9lwmWa+SaY6/12Oa8uvPK3DGJST6F
 HpNpfguAEYajy52QCqHxeV/zYoiZJ6l1A4ZWLp6EmvoUtJ+OG6sfO1yrMymw2WkJWeeY
 en2jEnUxPn/bZ1KH+kdRPmymLlq2OLihlelpOk0gEfrui3YdCKiCUfP+8LWnFpFWXpVv
 jZIshsS3uOlTjTjYTHWmcIW2mbYWfijFzuKa1Bk6lNOc9GNSW5FJBGmojkqZ3S/Fonn4
 0KHvBKiOSFkwOMO2gZefIBB5/t9ZF4Mxr/CMQ2F4sqj/+I01YgVJP2uChuyorymsxKZp
 Tt8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVdOoui5bKg50OfY85vqRI4p6OpVV1DKtfkVMtLRNQM3wmie7iOFxczeej8M1BfpqMG8s2aQ5P+GIk@nongnu.org
X-Gm-Message-State: AOJu0YzqNG0lQlZHRs+Bm/8NU1Nw/El5lcfPv56+yeJTn2GyocKiiYQL
 xwQqUFTedamHRDAmOUWGDEQtuTDUWyAu/fsuFloboET/REmD9x/HlEwyVq8LmqQrXefs1gIldjF
 1IwrRQ/krq/CI2/HA2oCacALAXzmR2W/li3kchWuJ9xn60R4eqDMMXIyW
X-Gm-Gg: ASbGncuCYOLPaMTurBAo3I7BaDXu9YMRbtrcd4TxoBdIA2aXLBcZDzsf2XE3ZhqQ5YJ
 S5vkYywhIiOFHuc0/5+oaw3J3hG6BgWxq91sPaGj41Vcsqkn/CPdOeG9gTCERQdvDpnIRYVGkQ3
 DUrRN6zR14pFCVlNAE3sX0Etkka6taJUtCWgx33hSF6UeCk+Lr6HNg8HsURsgqOkeOc7NKbm0Cw
 QG5KO0xEWPZA6k5pUxDcCDxJMwh63YmfC2eUcoUmxytVYeXuZn+mUE0QXvZjeEPdpl0oeLm/8gw
 BFI1Ve/IAjvpIM+FVewAJ2H3BEsCRwraHLUvD6tRrGq7u5cTQyH3rQtnhmHBXQUPyLqu1A==
X-Received: by 2002:a05:600c:4f93:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-453a5dff801mr38194765e9.13.1751361749005; 
 Tue, 01 Jul 2025 02:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Udr9wy63cnPQHOmAZlmAKx8C91MtPiRJS9KUCNz1ZqKqOGn8VBZYlDc+USPu6t4Mz3DmmQ==
X-Received: by 2002:a05:600c:4f93:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-453a5dff801mr38194285e9.13.1751361748409; 
 Tue, 01 Jul 2025 02:22:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538f88efffsm131737455e9.17.2025.07.01.02.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 02:22:27 -0700 (PDT)
Message-ID: <3e537f1d-a3ad-4651-a4cd-047d585e0e8d@redhat.com>
Date: Tue, 1 Jul 2025 11:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/32] tests/qtest/bios-tables-test: Update ARM DSDT
 reference blobs
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
References: <20250627095620.3300028-1-eric.auger@redhat.com>
 <20250627095620.3300028-20-eric.auger@redhat.com>
 <f502c91e-ffea-4b39-bedf-9503fc45e568@redhat.com>
 <20250630133105.00002f43@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250630133105.00002f43@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Jonathan,

On 6/30/25 2:31 PM, Jonathan Cameron wrote:
> On Fri, 27 Jun 2025 12:00:51 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi,
>>
>> On 6/27/25 11:55 AM, Eric Auger wrote:
>>> Changes relate to the introduction of pieces related to
>>> acpi-index static support along with root ports with no hotplug.
>>>
>>> +
>>> +    Scope (\_SB.PCI0)
>>> +    {
>>> +        Method (EDSM, 5, Serialized)
>>> +        {
>>> +            If ((Arg2 == Zero))
>>> +            {
>>> +                Local0 = Buffer (One)
>>> +                    {
>>> +                         0x00                                             // .
>>> +                    }
>>> +                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
>>> +                {
>>> +                    Return (Local0)
>>> +                }
>>> +
>>> +                If ((Arg1 < 0x02))
>>> +                {
>>> +                    Return (Local0)
>>> +                }
>>> +
>>> +                Local0 [Zero] = 0x81
>>> +                Return (Local0)
>>> +            }
>>> +
>>> +            If ((Arg2 == 0x07))
>>> +            {
>>> +                Local0 = Package (0x02)
>>> +                    {
>>> +                        Zero,
>>> +                        ""
>>> +                    }
>>> +                Local1 = DerefOf (Arg4 [Zero])
>>> +                Local0 [Zero] = Local1
>>> +                Return (Local0)
>>> +            }
>>> +        }
>>> +
>>> +        Device (S00)
>>> +        {
>>> +            Name (_ADR, Zero)  // _ADR: Address
>>> +        }
>>> +
>>> +        Device (S08)
>>> +        {
>>> +            Name (_ADR, 0x00010000)  // _ADR: Address
>>> +        }
>>> +
>>> +        Device (S10)
>>> +        {
>>> +            Name (_ADR, 0x00020000)  // _ADR: Address
>>> +        }
>>> +    }  
>> after regenerating the blobs using
>>
>> ../tests/data/acpi/rebuild-expected-aml.sh
>>
>> I still get an error :
>> Using expected file 'tests/data/acpi/aarch64/virt/DSDT'
>> acpi-test: Warning! DSDT binary file mismatch. Actual
>> [aml:/tmp/aml-2YB972], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
>> See source file tests/qtest/bios-tables-test.c for instructions on how
>> to update expected files.
>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-O0B972.dsl,
>> aml:/tmp/aml-2YB972], Expected [asl:/tmp/asl-NO6872.dsl,
>> aml:tests/data/acpi/aarch64/virt/DSDT].
>>
>> ../..
>>
>> -
>> -        Device (S10)
>> -        {
>> -            Name (_ADR, 0x00020000)  // _ADR: Address
>> -        }
>>      }
>>  }
>>  
>> **
>> ERROR:../tests/qtest/bios-tables-test.c:554:test_acpi_asl: assertion
>> failed: (all_tables_match)
>>
>> (test program exited with status code -6)
>>
>>
>> I don't get what is wrong.
>>
>> Thoughts?
> I've hit so many problems over time with regenerating these I tend
> to just blow away the build directory whenever this sort of
> issue happens to make sure it's building a clean set.
thank you for the review again and thanks for trying to help here.

Unfortunately I have make clean distclean and retried
../tests/data/acpi/rebuild-expected-aml.sh
and then
make check V=2
it still reports the above mismatch.

I need to have a look at the scripts

Eric
>
> Otherwise, no idea!
>
> Jonathan
>
>> Eric
>>>  }
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> above changes are reported after running make check V=2
>>> then I launched ../tests/data/acpi/rebuild-expected-aml.sh from the
>>> build directory and it putput those reference blobs.
>>>
>>> But I run make check V=2 after committing those changes I get and error
>>> which looks totally unexpected to me:
>>>
>>> acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-LZSL82], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
>>> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
>>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-FTSL82.dsl, aml:/tmp/aml-LZSL82], Expected [asl:/tmp/asl-ZAWL82.dsl, aml:tests/data/acpi/aarch64/virt/DSDT].
>>> --- /tmp/asl-ZAWL82.dsl	2025-06-27 03:34:45.518848387 -0400
>>> +++ /tmp/asl-FTSL82.dsl	2025-06-27 03:34:45.514848036 -0400
>>> @@ -1,30 +1,30 @@
>>>  /*
>>>   * Intel ACPI Component Architecture
>>>   * AML/ASL+ Disassembler version 20210604 (64-bit version)
>>>   * Copyright (c) 2000 - 2021 Intel Corporation
>>>   *
>>>   * Disassembling to symbolic ASL+ operators
>>>   *
>>> - * Disassembly of tests/data/acpi/aarch64/virt/DSDT, Fri Jun 27 03:34:45 2025
>>> + * Disassembly of /tmp/aml-LZSL82, Fri Jun 27 03:34:45 2025
>>>   *
>>>   * Original Table Header:
>>>   *     Signature        "DSDT"
>>> - *     Length           0x000014BE (5310)
>>> + *     Length           0x000014AD (5293)
>>>   *     Revision         0x02
>>> - *     Checksum         0x8C
>>> + *     Checksum         0xEA
>>>   *     OEM ID           "BOCHS "
>>>   *     OEM Table ID     "BXPC    "
>>>   *     OEM Revision     0x00000001 (1)
>>>   *     Compiler ID      "BXPC"
>>>   *     Compiler Version 0x00000001 (1)
>>>   */
>>>  DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
>>>  {
>>>      Scope (\_SB)
>>>      {
>>>          Device (C000)
>>>          {
>>>              Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
>>>              Name (_UID, Zero)  // _UID: Unique ID
>>>          }
>>>
>>> @@ -1929,24 +1929,19 @@
>>>                      }
>>>                  Local1 = DerefOf (Arg4 [Zero])
>>>                  Local0 [Zero] = Local1
>>>                  Return (Local0)
>>>              }
>>>          }
>>>
>>>          Device (S00)
>>>          {
>>>              Name (_ADR, Zero)  // _ADR: Address
>>>          }
>>>
>>>          Device (S08)
>>>          {
>>>              Name (_ADR, 0x00010000)  // _ADR: Address
>>>          }
>>> -
>>> -        Device (S10)
>>> -        {
>>> -            Name (_ADR, 0x00020000)  // _ADR: Address
>>> -        }
>>>      }
>>>  }
>>> ---
>>>  tests/qtest/bios-tables-test-allowed-diff.h   |   5 -----
>>>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5158 -> 5310 bytes
>>>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5244 -> 5379 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6519 -> 6654 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7603 -> 7768 bytes
>>>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5360 -> 5495 bytes
>>>  6 files changed, 5 deletions(-)
>>>
>>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>>> index abe00ad4ee..dfb8523c8b 100644
>>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>>> @@ -1,6 +1 @@
>>>  /* List of comma-separated changed AML files to ignore */
>>> -"tests/data/acpi/aarch64/virt/DSDT",
>>> -"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
>>> -"tests/data/acpi/aarch64/virt/DSDT.memhp",
>>> -"tests/data/acpi/aarch64/virt/DSDT.pxb",
>>> -"tests/data/acpi/aarch64/virt/DSDT.topology",
>>> diff --git a/tests/data/acpi/aarch64/virt/DSDT b/tests/data/acpi/aarch64/virt/DSDT
>>> index acab6e65febbc210158d4c39be0680bbb90250f5..b897d667971500da4732000091a6f0828d05d89e 100644
>>> GIT binary patch
>>> delta 173
>>> zcmZ3cu}_oBCD<iop9lj3Q_n^&8IgJccg`5S_+Y2_0B27F5pPykmtbGs1!j}87zzZL
>>> z85t55NKKlYAt=lxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
>>> zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YMl8!DxJPZts
>>> OU=c&8G!Fv<69WJ)j4yfs
>>>
>>> delta 19
>>> acmdm|xlDu0CD<iIO@x7g>C8qh84&<COa$Tp
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt b/tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt
>>> index 54c27e7d95b4956ed1b5dee0d299ccb08dc2a73e..2cef095bcc1bb404f8cd9ec77a879ed81c191875 100644
>>> GIT binary patch
>>> delta 156
>>> zcmeyP(X7Sg66_MfEXu&Zv}_|+kx0FO8%K;@e6Uk|fU~E8h&QXNORz8R0<+0k3<ZMB
>>> zj0_12q$W+y5ESMTxL|(rX|QRP??mxezLJNXeU~IGV4s@F#k3@$fUB`1fq`L3!UCDe
>>> zSzPP|Laa;-ybK8i%^f)m42cDa5XtB!?qCChc#e2Smmr4dCjMXpi+GNB4o8<D9tH+R
>>> F1_1j$EA9XQ
>>>
>>> delta 19
>>> acmZqH`lG?+66_LEBf`MI)VYzXNCW^oYz1ck
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.memhp b/tests/data/acpi/aarch64/virt/DSDT.memhp
>>> index 4330bc97cba0950191c45ac833533db7a190db81..372ca3d7fb1e2927c7c12f97eec406d597f294ab 100644
>>> GIT binary patch
>>> delta 156
>>> zcmexv^v{^fCD<k8pCkhV6Zb~0T*-O?H;x#+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
>>> z85t55NKKlYAt=lxaKZfK(_qso--+U{d?gP%`z}dXz&<sTi)l$h0as&30t3U6gatB_
>>> zv$)s`gjksvco`B3nmckB7!nH-A(GKe+`$G0@f`7vE<p^@P5i+I7V#YM9F8tQJPZts  
>>> F3;>E4EZYD8  
>>>
>>> delta 19
>>> acmexo{N0GlCD<jTT#|u->Fq|YTuA^&WCm0K
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.pxb b/tests/data/acpi/aarch64/virt/DSDT.pxb
>>> index 7fdbc03e2bf9fb7d35704779253de36e362f0bf9..c2779882494e16920787b8ab7b4cb3c3b70f224b 100644
>>> GIT binary patch
>>> delta 168
>>> zcmdmNeZz*!CD<h-LXLrf$!jCmN?BzA7p@q+_+Y2_0B27F5pPykmtbGs1!j}87zzZL
>>> z85t55NKKl&K}IZRNx}m5shM0%OA-pW8aomg7?va~keQst#a<x9%EZ9SkWkRvk;A}{
>>> uSda*jjBer%HZX|ih<9`eVu)^%2{y2RaCjIP7#YxH`GXCiN_iL<m>2+L6)WZd
>>>
>>> delta 19
>>> acmca%v)P)<CD<iovn&Gx)9sC1D`f#g-Uey_
>>>
>>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.topology b/tests/data/acpi/aarch64/virt/DSDT.topology
>>> index 969b4f6560d3ae39f5b7e0064b7122905476fce8..ebbeedc1ed30d811315c350f4cb42f8aa265af73 100644
>>> GIT binary patch
>>> delta 156
>>> zcmeyM`CW_4CD<jTT$F)<>HJ2nXCn0iZX7Xs@xe~<0nVNVBHpa7F2TOM3(O{GF%$?g
>>> zGcqJBkeW0(Lr|DY;DY(dr@^LGz7xe?`AQyk_Fa;&fPHEv7t@l20<Ol61O|pB2@7N<  
>>> zXK}F?2(dCT@G>M6G<W1MFeDZvLL{S`xPuK0;yL0SU4j^*oA`qbEaExhIUHSrco-NM  
>>> F8359@EocA$
>>>
>>> delta 19
>>> acmeya^+A)%CD<k8g9rly)25AF&qM%8i3Z^S
>>>  
>>


