Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A4C78569B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:16:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYlpO-0006QW-Q1; Wed, 23 Aug 2023 07:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYlpM-0006Oe-3s
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYlpJ-00045z-4m
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692789302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qmmvp+YGxgpgaXsqa3fvEWCbGNwivYNkTQGkc5KmHVo=;
 b=U8NmK3JFTgawRLYv7t9KWhcuOTpbv9gA1KNYJ2N0T9HJQ2cdHV6gwK042hYQcYqlu23xLl
 2f09yzCmu47g7Ewz98uaTN7WCeu+j2aXvVZhWFCnaOU30favvcRL8ISqkMbP2oIL62eRAH
 NqjOkTmf9RTrUpkRqOip6gNuN/7hQ7g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-4r2N1Os8M166plyxb1F4sw-1; Wed, 23 Aug 2023 07:14:56 -0400
X-MC-Unique: 4r2N1Os8M166plyxb1F4sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF6C4185A791;
 Wed, 23 Aug 2023 11:14:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 836402026D76;
 Wed, 23 Aug 2023 11:14:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D84F21E690D; Wed, 23 Aug 2023 13:14:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Eduardo Habkost <eduardo@habkost.net>,  Laszlo
 Ersek <lersek@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 02/58] i386: Introduce tdx-guest object
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-3-xiaoyao.li@intel.com>
 <87bkez7g0g.fsf@pond.sub.org>
 <a94957f6-cde2-c5ac-0391-d1df245dc25f@intel.com>
Date: Wed, 23 Aug 2023 13:14:54 +0200
In-Reply-To: <a94957f6-cde2-c5ac-0391-d1df245dc25f@intel.com> (Xiaoyao Li's
 message of "Wed, 23 Aug 2023 15:27:03 +0800")
Message-ID: <87h6oqxb69.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/22/2023 2:22 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> Introduce tdx-guest object which implements the interface of
>>> CONFIDENTIAL_GUEST_SUPPORT, and will be used to create TDX VMs (TDs) by
>>>
>>>    qemu -machine ...,confidential-guest-support=tdx0	\
>>>         -object tdx-guset,id=tdx0
>>
>> Typo: tdx-guest
>
> Will fix it.
>
>>> It has only one property 'attributes' with fixed value 0 and not
>>> configurable so far.
>>
>> This must refer to TdxGuest member @attributes.
>> "Property" suggests QOM property, which @attributes isn't, at least not
>> in this patch.  Will it become a QOM property later in this series?
>
> At least not in this series. Maybe in the future there is request to directly configure the whole attributes via QOM property, but none from now.
>
> I will change the description of it to avoid confusion.
>
>> Hmm, @attributes appears to remain unused until PATCH 14.  Recommend to
>> delay its addition until then.
>
> IMHO, it's not suitable to introduce it in patch 14. Using a separate patch seems unnecessary. I'll leave it in this patch unless strong objection on it.

Not worth arguing about.

>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>> changes from RFC-V4
>>> - make @attributes not user-settable
>>> ---
>>>   configs/devices/i386-softmmu/default.mak |  1 +
>>>   hw/i386/Kconfig                          |  5 +++
>>>   qapi/qom.json                            | 12 +++++++
>>>   target/i386/kvm/meson.build              |  2 ++
>>>   target/i386/kvm/tdx.c                    | 40 ++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.h                    | 19 +++++++++++
>>>   6 files changed, 79 insertions(+)
>>>   create mode 100644 target/i386/kvm/tdx.c
>>>   create mode 100644 target/i386/kvm/tdx.h
>>>
>>> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
>>> index 598c6646dfc0..9b5ec59d65b0 100644
>>> --- a/configs/devices/i386-softmmu/default.mak
>>> +++ b/configs/devices/i386-softmmu/default.mak
>>> @@ -18,6 +18,7 @@
>>>   #CONFIG_QXL=n
>>>   #CONFIG_SEV=n
>>>   #CONFIG_SGA=n
>>> +#CONFIG_TDX=n
>>>   #CONFIG_TEST_DEVICES=n
>>>   #CONFIG_TPM_CRB=n
>>>   #CONFIG_TPM_TIS_ISA=n
>>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>>> index 9051083c1e78..929f6c3f0e85 100644
>>> --- a/hw/i386/Kconfig
>>> +++ b/hw/i386/Kconfig
>>> @@ -10,6 +10,10 @@ config SGX
>>>       bool
>>>       depends on KVM
>>>   +config TDX
>>> +    bool
>>> +    depends on KVM
>>> +
>>>   config PC
>>>       bool
>>>       imply APPLESMC
>>> @@ -26,6 +30,7 @@ config PC
>>>       imply QXL
>>>       imply SEV
>>>       imply SGX
>>> +    imply TDX
>>>       imply TEST_DEVICES
>>>       imply TPM_CRB
>>>       imply TPM_TIS_ISA
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index e0b2044e3d20..2ca7ce7c0da5 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -866,6 +866,16 @@
>>>               'reduced-phys-bits': 'uint32',
>>>               '*kernel-hashes': 'bool' } }
>>>   +##
>>> +# @TdxGuestProperties:
>>> +#
>>> +# Properties for tdx-guest objects.
>>> +#
>>> +# Since: 8.2
>>> +##
>>> +{ 'struct': 'TdxGuestProperties',
>>> +  'data': { }}
>>> +
>>>   ##
>>>   # @ThreadContextProperties:
>>>   #
>>> @@ -944,6 +954,7 @@
>>>       'sev-guest',
>>>       'thread-context',
>>>       's390-pv-guest',
>>> +    'tdx-guest',
>>>       'throttle-group',
>>>       'tls-creds-anon',
>>>       'tls-creds-psk',
>>> @@ -1010,6 +1021,7 @@
>>>         'secret_keyring':             { 'type': 'SecretKeyringProperties',
>>>                                         'if': 'CONFIG_SECRET_KEYRING' },
>>>         'sev-guest':                  'SevGuestProperties',
>>> +      'tdx-guest':                  'TdxGuestProperties',
>>>         'thread-context':             'ThreadContextProperties',
>>>         'throttle-group':             'ThrottleGroupProperties',
>>>         'tls-creds-anon':             'TlsCredsAnonProperties',
>>
>> Actually useful only when CONFIG_TDX is on, but can't make it
>> conditional here, as CONFIG_TDX is poisoned.
>
> In fact, I just followed what SEV did.

Yup.

> To me, it looks OK to make it conditional on CONFIG_TDX. Could you please elaborate "but can't make it conditional here, as CONFIG_TDX is poisoned." ?

CONFIG_TDX is one of the macros that can only be used in
target-dependent code.  Enforced by config-poison.h's

    #pragma GCC poison CONFIG_TDX

The code generated from qom.json is target-independent.

To use 'if': 'CONFIG_TDX', we'd have to move the definition to a
target-dependent QAPI module, say qom-machine.json.  Sadly, that's more
trouble than it's worth.

[...]


