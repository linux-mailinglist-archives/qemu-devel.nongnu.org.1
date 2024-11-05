Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE09BCC12
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 12:43:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hxi-0001oP-PR; Tue, 05 Nov 2024 06:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Hxf-0001jM-Nz
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:43:03 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8Hxd-00018K-2L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:43:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730806981; x=1762342981;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IuMwbEqHYzNU4b0tImQbyd+xY4ayicHaMmQyrbno1BM=;
 b=fYMasCVndkSLiA2XUxNMQzUXy75z//ziXoaZTSnFSe13/VNdywzbamU6
 t3VTxHpEX8oLXmOQu3FDlZtM87b+n6Q3rkzU+YTjeRKa742n628G0QMCB
 MWsMyF0vXQwGoNkMBc42qcIJCumt8uLSoM9QtfWz7wkMe3oNK2O61dYvv
 XhuHqAmq7Lj5z7AAIEBLZRMFGbZ/vzMNQ488YL8Voz0yhwOC/ZnVDcOJ1
 G4eYCgJtyIo1JBnp6sghwctDkALjhTzsnSnnyBjiRqF052xcd/1QUA/cr
 TXJu2CYxKeERKW/3Xyi6bsw+gIoI7PUgzXE7OPXmonaLHyZN2XgVUxHau w==;
X-CSE-ConnectionGUID: JfXkk1yxQyuoaDPDLQT8yQ==
X-CSE-MsgGUID: l1yl6q0xRBao3wrH9UHF9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="48056449"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="48056449"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:42:59 -0800
X-CSE-ConnectionGUID: DUnSpACTR1ikFABROsCcJQ==
X-CSE-MsgGUID: SDYmxzbvR3m6ghio/+GE4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; d="scan'208";a="83505350"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 03:42:55 -0800
Message-ID: <dae753b1-513b-40d8-8393-5c62d1e81f56@intel.com>
Date: Tue, 5 Nov 2024 19:42:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/60] i386: Introduce tdx-guest object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-3-xiaoyao.li@intel.com> <ZynxD6crcL5Qouhe@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZynxD6crcL5Qouhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/2024 6:18 PM, Daniel P. Berrangé wrote:
> On Tue, Nov 05, 2024 at 01:23:10AM -0500, Xiaoyao Li wrote:
>> Introduce tdx-guest object which inherits X86_CONFIDENTIAL_GUEST,
>> and will be used to create TDX VMs (TDs) by
>>
>>    qemu -machine ...,confidential-guest-support=tdx0	\
>>         -object tdx-guest,id=tdx0
>>
>> It has one QAPI member 'attributes' defined, which allows user to set
>> TD's attributes directly.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> Chanegs in v6:
>>   - Make tdx-guest inherits X86_CONFIDENTIAL_GUEST;
>>   - set cgs->require_guest_memfd;
>>   - allow attributes settable via QAPI;
>>   - update QAPI version to since 9.2;
>>
>> Changes in v4:
>>   - update the new qapi `since` filed from 8.2 to 9.0
>>
>> Changes in v1
>>   - make @attributes not user-settable
>> ---
>>   configs/devices/i386-softmmu/default.mak |  1 +
>>   hw/i386/Kconfig                          |  5 +++
>>   qapi/qom.json                            | 15 ++++++++
>>   target/i386/kvm/meson.build              |  2 ++
>>   target/i386/kvm/tdx.c                    | 45 ++++++++++++++++++++++++
>>   target/i386/kvm/tdx.h                    | 19 ++++++++++
>>   6 files changed, 87 insertions(+)
>>   create mode 100644 target/i386/kvm/tdx.c
>>   create mode 100644 target/i386/kvm/tdx.h
>>
>> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
>> index 4faf2f0315e2..bc0479a7e0a3 100644
>> --- a/configs/devices/i386-softmmu/default.mak
>> +++ b/configs/devices/i386-softmmu/default.mak
>> @@ -18,6 +18,7 @@
>>   #CONFIG_QXL=n
>>   #CONFIG_SEV=n
>>   #CONFIG_SGA=n
>> +#CONFIG_TDX=n
>>   #CONFIG_TEST_DEVICES=n
>>   #CONFIG_TPM_CRB=n
>>   #CONFIG_TPM_TIS_ISA=n
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index 32818480d263..86bc10377c4f 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -10,6 +10,10 @@ config SGX
>>       bool
>>       depends on KVM
>>   
>> +config TDX
>> +    bool
>> +    depends on KVM
>> +
>>   config PC
>>       bool
>>       imply APPLESMC
>> @@ -26,6 +30,7 @@ config PC
>>       imply QXL
>>       imply SEV
>>       imply SGX
>> +    imply TDX
>>       imply TEST_DEVICES
>>       imply TPM_CRB
>>       imply TPM_TIS_ISA
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 321ccd708ad1..129b25edf495 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -1008,6 +1008,19 @@
>>               '*host-data': 'str',
>>               '*vcek-disabled': 'bool' } }
>>   
>> +##
>> +# @TdxGuestProperties:
>> +#
>> +# Properties for tdx-guest objects.
>> +#
>> +# @attributes: The 'attributes' of a TD guest that is passed to
>> +#     KVM_TDX_INIT_VM
>> +#
>> +# Since: 9.2
>> +##
> 
> Since QEMU soft-freeze for 9.2 is today, you've missed the
> boat for that. Please update any version tags in this series
> to 10.0, which is the first release of next year.

Noted.

Hope KVM part can get merged not too late. Otherwise, QEMU support will 
land in 10.1, 10.2, or even 11.0.

>> +{ 'struct': 'TdxGuestProperties',
>> +  'data': { '*attributes': 'uint64' } }
>> +
>>   ##
>>   # @ThreadContextProperties:
>>   #
>> @@ -1092,6 +1105,7 @@
>>       'sev-snp-guest',
>>       'thread-context',
>>       's390-pv-guest',
>> +    'tdx-guest',
>>       'throttle-group',
>>       'tls-creds-anon',
>>       'tls-creds-psk',
>> @@ -1163,6 +1177,7 @@
>>                                         'if': 'CONFIG_SECRET_KEYRING' },
>>         'sev-guest':                  'SevGuestProperties',
>>         'sev-snp-guest':              'SevSnpGuestProperties',
>> +      'tdx-guest':                  'TdxGuestProperties',
>>         'thread-context':             'ThreadContextProperties',
>>         'throttle-group':             'ThrottleGroupProperties',
>>         'tls-creds-anon':             'TlsCredsAnonProperties',
>> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
>> index 3996cafaf29f..466bccb9cb17 100644
>> --- a/target/i386/kvm/meson.build
>> +++ b/target/i386/kvm/meson.build
>> @@ -8,6 +8,8 @@ i386_kvm_ss.add(files(
>>   
>>   i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>>   
>> +i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
>> +
>>   i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
>>   
>>   i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>> new file mode 100644
>> index 000000000000..166f53d2b9e3
>> --- /dev/null
>> +++ b/target/i386/kvm/tdx.c
>> @@ -0,0 +1,45 @@
>> +/*
>> + * QEMU TDX support
>> + *
>> + * Copyright Intel
>> + *
>> + * Author:
>> + *      Xiaoyao Li <xiaoyao.li@intel.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory
> 
> FYI, since KVM Forum we decided that we would prefer newly
> created files to just use SPDX tags for license info.

Thanks for the info. Will update it.

>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object_interfaces.h"
>> +
>> +#include "tdx.h"
>> +
>> +/* tdx guest */
>> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>> +                                   tdx_guest,
>> +                                   TDX_GUEST,
>> +                                   X86_CONFIDENTIAL_GUEST,
>> +                                   { TYPE_USER_CREATABLE },
>> +                                   { NULL })
>> +
>> +static void tdx_guest_init(Object *obj)
>> +{
>> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
>> +    TdxGuest *tdx = TDX_GUEST(obj);
>> +
>> +    cgs->require_guest_memfd = true;
>> +    tdx->attributes = 0;
>> +
>> +    object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
>> +                                   OBJ_PROP_FLAG_READWRITE);
>> +}
>> +
>> +static void tdx_guest_finalize(Object *obj)
>> +{
>> +}
>> +
>> +static void tdx_guest_class_init(ObjectClass *oc, void *data)
>> +{
>> +}
>> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
>> new file mode 100644
>> index 000000000000..de687457cae6
>> --- /dev/null
>> +++ b/target/i386/kvm/tdx.h
>> @@ -0,0 +1,19 @@
>> +#ifndef QEMU_I386_TDX_H
>> +#define QEMU_I386_TDX_H
> 
> Missing license info.

Will add it.

thanks!

>> +
>> +#include "confidential-guest.h"
>> +
>> +#define TYPE_TDX_GUEST "tdx-guest"
>> +#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
>> +
>> +typedef struct TdxGuestClass {
>> +    X86ConfidentialGuestClass parent_class;
>> +} TdxGuestClass;
>> +
>> +typedef struct TdxGuest {
>> +    X86ConfidentialGuest parent_obj;
>> +
>> +    uint64_t attributes;    /* TD attributes */
>> +} TdxGuest;
>> +
>> +#endif /* QEMU_I386_TDX_H */
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


