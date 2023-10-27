Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C285F7D9A48
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:44:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwN7e-0004CZ-K8; Fri, 27 Oct 2023 09:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwN7b-0004C1-Er
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwN7Y-0000U3-O3
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698414207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFodn3jUrvzE60t2wwFnjcoQLPR4fKIdcW5g0EOQ8s4=;
 b=AHRTmmDRKYItCFx/+xVZFkUOoaZU1C51+gntwkjHRGnxz4PAozR06xPLpwecIUZi1IeNxp
 wuOD5emllnD4TTn37IigTt+T58Ec0ztRLSiQEiyy7sVUq02G2gu8eWiQR83Vbf+1ZvAk9H
 NJFNZGweorJow8Ji0zGT+ubpvC/rEYQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-QaOhOCM_Mbe8JIxWccGz2g-1; Fri, 27 Oct 2023 09:43:25 -0400
X-MC-Unique: QaOhOCM_Mbe8JIxWccGz2g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d857105b6so24955716d6.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698414205; x=1699019005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFodn3jUrvzE60t2wwFnjcoQLPR4fKIdcW5g0EOQ8s4=;
 b=X8hLcm8aop6GfncIHd3xsv+At0cN/NU3wLkV7yhXFu6twlOtJZGg5sI+cj0jU1qTQH
 RZelcN+OFuIm/tY42hNYJGhzMgg0vzH1slhCaPNPz49hFks4jJwRpKS0L9bcUTIG1f91
 zMEZDwV1dT0kgwfvzMoXRsM8rF50WRZaHKqdV1QF1r9i0ID7e/VFehbV0swaVnHNdj4w
 aghZSDWzGqzRbfccdjw/9rE3FBIgyNddoMxdTb/zBAA5dX8Nwtm7vSuFOc3LhlZ8NAxc
 LbsZldSYmeoUvIAZka92b/7nP6vlgfm92Q1KJNSXqogmYobW80OHtqtyAtmmdTD6/qXc
 N2lw==
X-Gm-Message-State: AOJu0YxXRzqjTr6WBotCEv/AmtSvnnHyrUCvcI1IZ+/reshNyyOfeKGc
 DBXF0u/QOAbRVpINVfmLkEudl7Sf87SqIq+/qa1XLZrVBlFhaJCEnKsuDSOD5boUUpuSjCc4TzI
 FK2SFYs6SBJOMDLk=
X-Received: by 2002:a05:6214:301b:b0:66d:12fe:207d with SMTP id
 ke27-20020a056214301b00b0066d12fe207dmr2909855qvb.5.1698414204894; 
 Fri, 27 Oct 2023 06:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiRCHw+RgHITWBih4FPDivgzilnw7of+kooqPONbqnSWNcdToFMU65E4yR9mxUjCgI4nlgGQ==
X-Received: by 2002:a05:6214:301b:b0:66d:12fe:207d with SMTP id
 ke27-20020a056214301b00b0066d12fe207dmr2909828qvb.5.1698414204612; 
 Fri, 27 Oct 2023 06:43:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 mn6-20020a0562145ec600b0065b29403540sm609139qvb.127.2023.10.27.06.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 06:43:24 -0700 (PDT)
Message-ID: <5ab25987-e67d-4e43-a9f0-86b4a1234646@redhat.com>
Date: Fri, 27 Oct 2023 15:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <87o7gla508.fsf@pond.sub.org>
 <SJ0PR11MB67444B3A1BE0FAE6934ABAD592DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d4e5771e-08e4-46b5-97d4-570b4883e4f7@redhat.com>
 <SJ0PR11MB6744E698D21BFECA2A5B427B92DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744E698D21BFECA2A5B427B92DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 10/27/23 10:16, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Friday, October 27, 2023 3:46 PM
>> Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
>>
>> On 10/27/23 08:17, Duan, Zhenzhong wrote:
>>> Hi Markus,
>>>
>>>> -----Original Message-----
>>>> From: Markus Armbruster <armbru@redhat.com>
>>>> Sent: Thursday, October 26, 2023 9:27 PM
>>>> Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
>>>>
>>>> Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> Thanks all for giving guides and comments on previous series, here is
>>>>> the v3 of pure iommufd support part.
>>>>>
>>>>> Based on Cédric's suggestion, this series includes an effort to remove
>>>>> spapr code from container.c, now all spapr functions are moved to spapr.c
>>>>> or spapr_pci_vfio.c, but there are still a few trival check on
>>>>> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce
>> many
>>>>> callbacks and duplicate code just to remove them. Some functions are moved
>>>>> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
>>>>> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
>>>>> functions to those spapr functions moved.
>>>>
>>>> [...]
>>>>
>>>>> qemu code:
>>>> https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v3
>>>>> Based on vfio-next, commit id: fd0e1c8bc1
>>>>
>>>> I fetched this, and get several compile errors with Clang (but not with
>>>> GCC):
>>>>
>>>>      FAILED: libqemu-x86_64-softmmu.fa.p/hw_vfio_common.c.o
>>>>      clang -m64 -mcx16 -Ilibqemu-x86_64-softmmu.fa.p -I. -I.. -Itarget/i386 -
>>>> I../target/i386 -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -
>>>> I/usr/include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 -
>>>> I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -
>>>> I/usr/include/sysprof-4 -I/usr/include/nss3 -I/usr/include/nspr4 -
>>>> I/usr/include/PCSC -fcolor-diagnostics -Wall -Winvalid-pch -Werror -
>> std=gnu11 -
>>>> O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-
>> prototypes -
>>>> Wstrict-prototypes -Wredundant-decls -Wold-style-definition -Wtype-limits -
>>>> Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-
>> body
>>>> -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wmissing-format-
>>>> attribute -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-
>>>> negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
>>>> tautological-type-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-
>> not-
>>>> at-end -Wthread-safety -isystem /work/armbru/qemu/linux-headers -isystem
>>>> linux-headers -iquote . -iquote /work/armbru/qemu -iquote
>>>> /work/armbru/qemu/include -iquote
>> /work/armbru/qemu/host/include/x86_64 -
>>>> iquote /work/armbru/qemu/host/include/generic -iquote
>>>> /work/armbru/qemu/tcg/i386 -pthread -D_GNU_SOURCE -
>>>> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-
>>>> common -fwrapv -fsanitize-coverage-allowlist=instrumentation-filter -
>>>> fsanitize=fuzzer-no-link -fPIE -isystem../linux-headers -isystemlinux-headers -
>>>> DNEED_CPU_H '-DCONFIG_TARGET="x86_64-softmmu-config-target.h"' '-
>>>> DCONFIG_DEVICES="x86_64-softmmu-config-devices.h"' -MD -MQ libqemu-
>>>> x86_64-softmmu.fa.p/hw_vfio_common.c.o -MF libqemu-x86_64-
>>>> softmmu.fa.p/hw_vfio_common.c.o.d -o libqemu-x86_64-
>>>> softmmu.fa.p/hw_vfio_common.c.o -c ../hw/vfio/common.c
>>>>      ../hw/vfio/common.c:682:40: error: variable 'hostwin' is uninitialized when
>>>> used here [-Werror,-Wuninitialized]
>>>>              hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>>>                                             ^~~~~~~
>>>>      ../hw/vfio/common.c:578:31: note: initialize the variable 'hostwin' to
>> silence
>>>> this warning
>>>>          VFIOHostDMAWindow *hostwin;
>>>>                                    ^
>>>>                                     = NULL
>>>>      ../hw/vfio/common.c:785:33: error: variable 'hostwin' is uninitialized when
>>>> used here [-Werror,-Wuninitialized]
>>>>              pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>>>                                      ^~~~~~~
>>>>      ../hw/vfio/common.c:783:35: note: initialize the variable 'hostwin' to
>> silence
>>>> this warning
>>>>              VFIOHostDMAWindow *hostwin;
>>>>                                        ^
>>>>                                         = NULL
>>>>      2 errors generated.
>>>>      FAILED: tests/unit/test-resv-mem.p/test-resv-mem.c.o
>>>>      clang -m64 -mcx16 -Itests/unit/test-resv-mem.p -Itests/unit -I../tests/unit -I.
>> -
>>>> Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include
>> -
>>>> I/usr/include/sysprof-4 -fcolor-diagnostics -Wall -Winvalid-pch -Werror -
>>>> std=gnu11 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -
>> Wmissing-
>>>> prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-definition -
>>>> Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-
>> qualifiers -
>>>> Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -
>>>> Wmissing-format-attribute -Wno-initializer-overrides -Wno-missing-include-
>> dirs -
>>>> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -
>> Wno-
>>>> tautological-type-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-
>> not-
>>>> at-end -Wthread-safety -isystem /work/armbru/qemu/linux-headers -isystem
>>>> linux-headers -iquote . -iquote /work/armbru/qemu -iquote
>>>> /work/armbru/qemu/include -iquote
>> /work/armbru/qemu/host/include/x86_64 -
>>>> iquote /work/armbru/qemu/host/include/generic -iquote
>>>> /work/armbru/qemu/tcg/i386 -pthread -D_GNU_SOURCE -
>>>> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-
>>>> common -fwrapv -fsanitize-coverage-allowlist=instrumentation-filter -
>>>> fsanitize=fuzzer-no-link -fPIE -MD -MQ tests/unit/test-resv-mem.p/test-resv-
>>>> mem.c.o -MF tests/unit/test-resv-mem.p/test-resv-mem.c.o.d -o
>> tests/unit/test-
>>>> resv-mem.p/test-resv-mem.c.o -c ../tests/unit/test-resv-mem.c
>>>>      ../tests/unit/test-resv-mem.c:42:9: error: variable 'i' set but not used [-
>>>> Werror,-Wunused-but-set-variable]
>>>>          int i = 0;
>>>>              ^
>>>>      1 error generated.
>>>>
>>>> Delete @i, please.
>>>
>>> Thanks for your report, I'll fix it and build with both compilers next time.
>>
>> a compile on a fedora rawhide also reports :
>>
>> ../hw/vfio/iommufd.c: In function ‘vfio_get_info_iova_range’:
>> ../hw/vfio/iommufd.c:370:27: error: cast from pointer to integer of different size
>> [-Werror=pointer-to-int-cast]
>>    370 |     info->allowed_iovas = (uint64_t)(info + 1);
>>        |                           ^
>> ../hw/vfio/iommufd.c:377:19: error: cast to pointer from integer of different size
>> [-Werror=int-to-pointer-cast]
>>    377 |     iova_ranges = (struct iommu_iova_range *)info->allowed_iovas;
>>        |                   ^
>> cc1: all warnings being treated as errors
> 
> I failed to understand this warning, is your env a 32bit fedora?

it's not a rawhide but a 32bit indeed.

Thanks,

C.


> 
>>
>>
>>> About second error, I'll send a separate patch as it's unrelated to this series.
>>
>>
>> Since this is a big series, I suggest that you take this patch in your build
>> environment,
> 
> Got it, will do, thanks for your suggestions.
> 
> BRs.
> Zhenzhong
> 
>>
>>
>> diff --git a/meson.build b/meson.build
>> index
>> 72a57288a026325d5ff753131c037e99f6f35c1a..c946cbef5b29e23475dc4cf3456
>> 55e0466cbfade 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -462,6 +462,9 @@ warn_flags = [
>>     '-Wno-tautological-type-limit-compare',
>>     '-Wno-psabi',
>>     '-Wno-gnu-variable-sized-type-not-at-end',
>> +  '-Wshadow=local',
>> +  '-Wno-error=shadow=local',
>> +  '-Wno-error=shadow=compatible-local',
>>   ]
>>
>>   if targetos != 'darwin'
>>
>>
>> Thanks,
>>
>> C.
> 


