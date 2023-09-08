Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28337989B1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 17:15:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedBX-0002SB-Gx; Fri, 08 Sep 2023 11:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qedBM-0002QV-UO
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qedBH-0001Tj-U1
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 11:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694186038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gYrLMThQM5KOMhERSu2q73qQFhrksK2EbMY5hyt6dAI=;
 b=etcGsr/2GJLmqsTA/dybqiwxlJEaMMvxgrmaAiXjRblZMObX1AnMxeQujc1OFD6ErpEnze
 RiPPbw7EO+GSWATG5WT5UOgoYxUw2W2xuYS9h5SGe5mFa4x1PcyyQPkrTos9SNidttKRg6
 GfDY7B1vLDBnjgSgYR94V9mpVdiCrDk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-WEoRTAxTPTSA6GEn6KivBQ-1; Fri, 08 Sep 2023 11:13:56 -0400
X-MC-Unique: WEoRTAxTPTSA6GEn6KivBQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1bf78ff0745so27487195ad.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 08:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694186036; x=1694790836;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYrLMThQM5KOMhERSu2q73qQFhrksK2EbMY5hyt6dAI=;
 b=OV5HSntM9xYcSA/tm6/KyWbBYfNdl4dVoLnfqJrBXXqT6l+zF7JkDlsLno0a9gSi4Y
 mCWJE2jfO7zc2PewOFVvLlFw1CGdhQgS+11fgTdO18S6LBnrISCDTn6iWnz0Yhp2L+Cm
 zZ10WDPNr7pKDrNr5w7zRMvsPTcGoO+Uw3kmgZPWHYic3ll93Fa6vbvwiVyHymsBiKLO
 cvX0LsTlVgzTqc0mzkSYNGN7L/oY1qPjoF4iClZc+zQkRYgGnr/LnzVI60BpzHq8CrTz
 vJupNssY13T134vzffN1A97uto3yR5mVyeVSRWypv/SsjArpcejv6hrM154+ejBexfKG
 Jhqg==
X-Gm-Message-State: AOJu0Yy3Hd8Ba+nzl4UID4F8a1m1ATlDdsSSrP7fKwac44OMyXJO7uqq
 esvZoCIfzuOWGIn1jo6OswBS71IeluBHGWrAYerzF84jswDgwQQr6hRkmDu6ONz8VmJ/+WWzFMh
 hTKW++X82cSbh9b4=
X-Received: by 2002:a17:902:dacc:b0:1b8:a3e8:51d0 with SMTP id
 q12-20020a170902dacc00b001b8a3e851d0mr3151795plx.45.1694186035347; 
 Fri, 08 Sep 2023 08:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa9150R5SyyrFIAd5Qps048+fbtztbEpLnKvWdg2XsUxBeNnQYgXgjBzAp7ecTLN8BLDn0pw==
X-Received: by 2002:a17:902:dacc:b0:1b8:a3e8:51d0 with SMTP id
 q12-20020a170902dacc00b001b8a3e851d0mr3151769plx.45.1694186034925; 
 Fri, 08 Sep 2023 08:13:54 -0700 (PDT)
Received: from smtpclient.apple ([115.96.141.163])
 by smtp.gmail.com with ESMTPSA id
 ju4-20020a170903428400b001bf20c806adsm1717940plb.50.2023.09.08.08.13.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Sep 2023 08:13:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] mem/x86: add processor address space check for VM memory
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
Date: Fri, 8 Sep 2023 20:43:44 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1574DF3A-7E1F-4C4F-9087-6E8DEE456906@redhat.com>
References: <20230908095024.270946-1-anisinha@redhat.com>
 <77284898-c540-31ac-d438-ebff52f6d75d@redhat.com>
 <1911B17C-24F2-406B-9ED4-DCF98E794A09@redhat.com>
 <730648ed-55ac-aa2c-58d2-d79224aeb586@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 08-Sep-2023, at 7:46 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 08.09.23 16:12, Ani Sinha wrote:
>>> On 08-Sep-2023, at 3:58 PM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 08.09.23 11:50, Ani Sinha wrote:
>>>> Depending on the number of available address bits of the current =
processor, a
>>>> VM can only use a certain maximum amount of memory and no more. =
This change
>>>> makes sure that a VM is not configured to have more memory than =
what it can use
>>>> with the current processor settings when started. Additionally, the =
change adds
>>>> checks during memory hotplug to ensure that the VM does not end up =
getting more
>>>> memory than what it can actually use after hotplug.
>>>> Currently, both the above checks are only for pc (x86) platform.
>>>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1235403
>>>> CC: imammedo@redhat.com
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>>  hw/i386/pc.c           | 45 =
++++++++++++++++++++++++++++++++++++++++++
>>>>  hw/mem/memory-device.c |  6 ++++++
>>>>  include/hw/boards.h    |  9 +++++++++
>>>>  3 files changed, 60 insertions(+)
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index 54838c0c41..f84e4c4916 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -31,6 +31,7 @@
>>>>  #include "hw/i386/topology.h"
>>>>  #include "hw/i386/fw_cfg.h"
>>>>  #include "hw/i386/vmport.h"
>>>> +#include "hw/mem/memory-device.h"
>>>>  #include "sysemu/cpus.h"
>>>>  #include "hw/block/fdc.h"
>>>>  #include "hw/ide/internal.h"
>>>> @@ -1006,6 +1007,17 @@ void pc_memory_init(PCMachineState *pcms,
>>>>          exit(EXIT_FAILURE);
>>>>      }
>>>>  +    /*
>>>> +     * check if the VM started with more ram configured than max =
physical
>>>> +     * address available with the current processor.
>>>> +     */
>>>> +    if (machine->ram_size > maxphysaddr + 1) {
>>>> +        error_report("Address space limit 0x%"PRIx64" < 0x%"PRIx64
>>>> +                     " (max configured memory), phys-bits too low =
(%u)",
>>>> +                     maxphysaddr, machine->ram_size, =
cpu->phys_bits);
>>>> +        exit(EXIT_FAILURE);
>>>> +    }
>>>=20
>>> ... I know that this used to be a problem in the past, but nowadays =
we already do have similar checks in place?
>>>=20
>>> $ ./build/qemu-system-x86_64 -m 4T -machine q35,memory-backend=3Dmem0 =
-object memory-backend-ram,id=3Dmem0,size=3D4T,reserve=3Doff
>>> qemu-system-x86_64: Address space limit 0xffffffffff < 0x5077fffffff =
phys-bits too low (40)
>> So you are saying that this is OK and should be allowed? On a 32 bit =
processor that can access only 4G memory, I am spinning up a 10G VM.
>=20
> Would that 32bit process have PAE (Physical Address Extension) and =
still be able to access that memory?


You are sidestepping my point. Sure, we can improve the condition check =
by checking for PAE CPUID etc but that is not the issue I am trying too =
point out. What if the processor did not have PAE? Would we allow a VM =
to have memory size which the processor can=E2=80=99t access? There is =
no such check today it would seem.


