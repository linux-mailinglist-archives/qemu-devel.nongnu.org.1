Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0CD7D9031
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHXS-0006QE-Rb; Fri, 27 Oct 2023 03:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwHXQ-0006Og-Ru
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qwHXO-0003W9-Ot
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698392745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8x8QxrlpTuuxdYCw4K0l4sQ5Ew6OnYHsxurOjHZ0So=;
 b=UT17WJg3sWNejg1QThTZxHm5XU25s2EMy0lAAqj/mg57PTVGojOOlhG09PpGCnij9fWIq/
 a0iaw9UkQfM8nctg8erpFC/uvIdYNn1mS5w5qLAQ3iKiWYQZSoLE3taOLil8LAk9ZYsuJK
 IiQZOJHRVSC6Qsa1to03g+y8+G1MEok=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-KCag8uFOO1iYGlVkBjv2Gg-1; Fri, 27 Oct 2023 03:45:44 -0400
X-MC-Unique: KCag8uFOO1iYGlVkBjv2Gg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7740517a478so256257485a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698392743; x=1698997543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8x8QxrlpTuuxdYCw4K0l4sQ5Ew6OnYHsxurOjHZ0So=;
 b=jEaJc5eaCFZaxtwMvO07J9uTKprBDKOk05wWfqPZF6vmeUMtHWJvvmCF+3luNzJYRK
 aZS9dzmvtM1xLN+pq/OdfV2UK4mxHwRUX+SN6srw9lN0cPgAfjPJcfgfwMfTNrD4f1nU
 N4M8Nec0MK8tRHghy2kT2qGvErmrUyMHHGvnpF8MDCqOywy96p3O41Et/YW9AzhlCktS
 coAcReT4irM6GjA2oxKinykuwL3lcAB98RYyghSAtet6EpjYZXsij6TlFu7ugq+jErt+
 2PvjhlLPZ1uGVJAUhxL1tHjbhDAw1QX3Bp6z8x/CP6W+nfSH1i+BWUkvZXVF8hKakp9O
 OY8A==
X-Gm-Message-State: AOJu0YxPlpNLoiMIKsVmWf0rTN4bft3mSwq7fVp5mQ91eutT4A1MUh2C
 WoDCY5wjHQEsiXM9lzf908XpMCWbtoVyLzGUc5kLDeugcq8iyT2aigBIqAkd4ZSqsNiHZde/sJ+
 NLHEilBvPqdtMgYk=
X-Received: by 2002:a05:620a:4e:b0:775:9e9d:6186 with SMTP id
 t14-20020a05620a004e00b007759e9d6186mr1701493qkt.18.1698392743668; 
 Fri, 27 Oct 2023 00:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkgQP6M8QxrGoAI0C29j1Ztp8bNwQmAq+w3eBoZBVTUUGuYRAy4C0foKaMywyyNBWhrBdrww==
X-Received: by 2002:a05:620a:4e:b0:775:9e9d:6186 with SMTP id
 t14-20020a05620a004e00b007759e9d6186mr1701467qkt.18.1698392743302; 
 Fri, 27 Oct 2023 00:45:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 de41-20020a05620a372900b0077891d2d12dsm353137qkb.43.2023.10.27.00.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:45:42 -0700 (PDT)
Message-ID: <d4e5771e-08e4-46b5-97d4-570b4883e4f7@redhat.com>
Date: Fri, 27 Oct 2023 09:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
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
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67444B3A1BE0FAE6934ABAD592DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/27/23 08:17, Duan, Zhenzhong wrote:
> Hi Markus,
> 
>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Thursday, October 26, 2023 9:27 PM
>> Subject: Re: [PATCH v3 00/37] vfio: Adopt iommufd
>>
>> Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
>>
>>> Hi,
>>>
>>> Thanks all for giving guides and comments on previous series, here is
>>> the v3 of pure iommufd support part.
>>>
>>> Based on Cédric's suggestion, this series includes an effort to remove
>>> spapr code from container.c, now all spapr functions are moved to spapr.c
>>> or spapr_pci_vfio.c, but there are still a few trival check on
>>> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
>>> callbacks and duplicate code just to remove them. Some functions are moved
>>> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
>>> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
>>> functions to those spapr functions moved.
>>
>> [...]
>>
>>> qemu code:
>> https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v3
>>> Based on vfio-next, commit id: fd0e1c8bc1
>>
>> I fetched this, and get several compile errors with Clang (but not with
>> GCC):
>>
>>     FAILED: libqemu-x86_64-softmmu.fa.p/hw_vfio_common.c.o
>>     clang -m64 -mcx16 -Ilibqemu-x86_64-softmmu.fa.p -I. -I.. -Itarget/i386 -
>> I../target/i386 -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -
>> I/usr/include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 -
>> I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -
>> I/usr/include/sysprof-4 -I/usr/include/nss3 -I/usr/include/nspr4 -
>> I/usr/include/PCSC -fcolor-diagnostics -Wall -Winvalid-pch -Werror -std=gnu11 -
>> O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -
>> Wstrict-prototypes -Wredundant-decls -Wold-style-definition -Wtype-limits -
>> Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body
>> -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wmissing-format-
>> attribute -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-
>> negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
>> tautological-type-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-not-
>> at-end -Wthread-safety -isystem /work/armbru/qemu/linux-headers -isystem
>> linux-headers -iquote . -iquote /work/armbru/qemu -iquote
>> /work/armbru/qemu/include -iquote /work/armbru/qemu/host/include/x86_64 -
>> iquote /work/armbru/qemu/host/include/generic -iquote
>> /work/armbru/qemu/tcg/i386 -pthread -D_GNU_SOURCE -
>> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-
>> common -fwrapv -fsanitize-coverage-allowlist=instrumentation-filter -
>> fsanitize=fuzzer-no-link -fPIE -isystem../linux-headers -isystemlinux-headers -
>> DNEED_CPU_H '-DCONFIG_TARGET="x86_64-softmmu-config-target.h"' '-
>> DCONFIG_DEVICES="x86_64-softmmu-config-devices.h"' -MD -MQ libqemu-
>> x86_64-softmmu.fa.p/hw_vfio_common.c.o -MF libqemu-x86_64-
>> softmmu.fa.p/hw_vfio_common.c.o.d -o libqemu-x86_64-
>> softmmu.fa.p/hw_vfio_common.c.o -c ../hw/vfio/common.c
>>     ../hw/vfio/common.c:682:40: error: variable 'hostwin' is uninitialized when
>> used here [-Werror,-Wuninitialized]
>>             hwaddr pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>                                            ^~~~~~~
>>     ../hw/vfio/common.c:578:31: note: initialize the variable 'hostwin' to silence
>> this warning
>>         VFIOHostDMAWindow *hostwin;
>>                                   ^
>>                                    = NULL
>>     ../hw/vfio/common.c:785:33: error: variable 'hostwin' is uninitialized when
>> used here [-Werror,-Wuninitialized]
>>             pgmask = (1ULL << ctz64(hostwin->iova_pgsizes)) - 1;
>>                                     ^~~~~~~
>>     ../hw/vfio/common.c:783:35: note: initialize the variable 'hostwin' to silence
>> this warning
>>             VFIOHostDMAWindow *hostwin;
>>                                       ^
>>                                        = NULL
>>     2 errors generated.
>>     FAILED: tests/unit/test-resv-mem.p/test-resv-mem.c.o
>>     clang -m64 -mcx16 -Itests/unit/test-resv-mem.p -Itests/unit -I../tests/unit -I. -
>> Iqapi -Itrace -Iui -Iui/shader -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -
>> I/usr/include/sysprof-4 -fcolor-diagnostics -Wall -Winvalid-pch -Werror -
>> std=gnu11 -O2 -g -fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-
>> prototypes -Wstrict-prototypes -Wredundant-decls -Wold-style-definition -
>> Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -
>> Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -
>> Wmissing-format-attribute -Wno-initializer-overrides -Wno-missing-include-dirs -
>> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
>> tautological-type-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-not-
>> at-end -Wthread-safety -isystem /work/armbru/qemu/linux-headers -isystem
>> linux-headers -iquote . -iquote /work/armbru/qemu -iquote
>> /work/armbru/qemu/include -iquote /work/armbru/qemu/host/include/x86_64 -
>> iquote /work/armbru/qemu/host/include/generic -iquote
>> /work/armbru/qemu/tcg/i386 -pthread -D_GNU_SOURCE -
>> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-
>> common -fwrapv -fsanitize-coverage-allowlist=instrumentation-filter -
>> fsanitize=fuzzer-no-link -fPIE -MD -MQ tests/unit/test-resv-mem.p/test-resv-
>> mem.c.o -MF tests/unit/test-resv-mem.p/test-resv-mem.c.o.d -o tests/unit/test-
>> resv-mem.p/test-resv-mem.c.o -c ../tests/unit/test-resv-mem.c
>>     ../tests/unit/test-resv-mem.c:42:9: error: variable 'i' set but not used [-
>> Werror,-Wunused-but-set-variable]
>>         int i = 0;
>>             ^
>>     1 error generated.
>>
>> Delete @i, please.
> 
> Thanks for your report, I'll fix it and build with both compilers next time.

a compile on a fedora rawhide also reports :

../hw/vfio/iommufd.c: In function ‘vfio_get_info_iova_range’:
../hw/vfio/iommufd.c:370:27: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
   370 |     info->allowed_iovas = (uint64_t)(info + 1);
       |                           ^
../hw/vfio/iommufd.c:377:19: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   377 |     iova_ranges = (struct iommu_iova_range *)info->allowed_iovas;
       |                   ^
cc1: all warnings being treated as errors


> About second error, I'll send a separate patch as it's unrelated to this series.


Since this is a big series, I suggest that you take this patch in your build
environment,


diff --git a/meson.build b/meson.build
index 72a57288a026325d5ff753131c037e99f6f35c1a..c946cbef5b29e23475dc4cf345655e0466cbfade 100644
--- a/meson.build
+++ b/meson.build
@@ -462,6 +462,9 @@ warn_flags = [
    '-Wno-tautological-type-limit-compare',
    '-Wno-psabi',
    '-Wno-gnu-variable-sized-type-not-at-end',
+  '-Wshadow=local',
+  '-Wno-error=shadow=local',
+  '-Wno-error=shadow=compatible-local',
  ]
  
  if targetos != 'darwin'


Thanks,

C.


