Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B57839DD
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYKmz-0007uh-1j; Tue, 22 Aug 2023 02:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKmw-0007uY-Mt
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKmu-0008FP-5a
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692685366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGIKIYyjjVBSwVO0jS1FKcz42Jpl+fd5aFYvkHdZp/4=;
 b=cbD9fScYWaLyaPKeEkFeEYm0pFeiioHtiK/MnEwYTqRInZOJUKBtUJqq0iSBSUXybN9CtN
 9gmkjTNYPToUTsMG4z80ESc0IAyFbZMu41EnfZ9G5aiaVscM0gVuyjfyiYWl4AyeS92ze3
 Grx/IKtNAkJknpMLTEJtimsl5wz8KCc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-W-EqI-r_ODGQKRN4mOqwwg-1; Tue, 22 Aug 2023 02:22:42 -0400
X-MC-Unique: W-EqI-r_ODGQKRN4mOqwwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 663DD8030A9;
 Tue, 22 Aug 2023 06:22:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 057F9140E96E;
 Tue, 22 Aug 2023 06:22:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F320E21E690D; Tue, 22 Aug 2023 08:22:39 +0200 (CEST)
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
Date: Tue, 22 Aug 2023 08:22:39 +0200
In-Reply-To: <20230818095041.1973309-3-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Fri, 18 Aug 2023 05:49:45 -0400")
Message-ID: <87bkez7g0g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> Introduce tdx-guest object which implements the interface of
> CONFIDENTIAL_GUEST_SUPPORT, and will be used to create TDX VMs (TDs) by
>
>   qemu -machine ...,confidential-guest-support=tdx0	\
>        -object tdx-guset,id=tdx0

Typo: tdx-guest

> It has only one property 'attributes' with fixed value 0 and not
> configurable so far.

This must refer to TdxGuest member @attributes.

"Property" suggests QOM property, which @attributes isn't, at least not
in this patch.  Will it become a QOM property later in this series?

Hmm, @attributes appears to remain unused until PATCH 14.  Recommend to
delay its addition until then.

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> changes from RFC-V4
> - make @attributes not user-settable
> ---
>  configs/devices/i386-softmmu/default.mak |  1 +
>  hw/i386/Kconfig                          |  5 +++
>  qapi/qom.json                            | 12 +++++++
>  target/i386/kvm/meson.build              |  2 ++
>  target/i386/kvm/tdx.c                    | 40 ++++++++++++++++++++++++
>  target/i386/kvm/tdx.h                    | 19 +++++++++++
>  6 files changed, 79 insertions(+)
>  create mode 100644 target/i386/kvm/tdx.c
>  create mode 100644 target/i386/kvm/tdx.h
>
> diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
> index 598c6646dfc0..9b5ec59d65b0 100644
> --- a/configs/devices/i386-softmmu/default.mak
> +++ b/configs/devices/i386-softmmu/default.mak
> @@ -18,6 +18,7 @@
>  #CONFIG_QXL=n
>  #CONFIG_SEV=n
>  #CONFIG_SGA=n
> +#CONFIG_TDX=n
>  #CONFIG_TEST_DEVICES=n
>  #CONFIG_TPM_CRB=n
>  #CONFIG_TPM_TIS_ISA=n
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 9051083c1e78..929f6c3f0e85 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -10,6 +10,10 @@ config SGX
>      bool
>      depends on KVM
>  
> +config TDX
> +    bool
> +    depends on KVM
> +
>  config PC
>      bool
>      imply APPLESMC
> @@ -26,6 +30,7 @@ config PC
>      imply QXL
>      imply SEV
>      imply SGX
> +    imply TDX
>      imply TEST_DEVICES
>      imply TPM_CRB
>      imply TPM_TIS_ISA
> diff --git a/qapi/qom.json b/qapi/qom.json
> index e0b2044e3d20..2ca7ce7c0da5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -866,6 +866,16 @@
>              'reduced-phys-bits': 'uint32',
>              '*kernel-hashes': 'bool' } }
>  
> +##
> +# @TdxGuestProperties:
> +#
> +# Properties for tdx-guest objects.
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'TdxGuestProperties',
> +  'data': { }}
> +
>  ##
>  # @ThreadContextProperties:
>  #
> @@ -944,6 +954,7 @@
>      'sev-guest',
>      'thread-context',
>      's390-pv-guest',
> +    'tdx-guest',
>      'throttle-group',
>      'tls-creds-anon',
>      'tls-creds-psk',
> @@ -1010,6 +1021,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'tdx-guest':                  'TdxGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',

Actually useful only when CONFIG_TDX is on, but can't make it
conditional here, as CONFIG_TDX is poisoned.

> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> index 40fbde96cac6..21ab03fe1349 100644
> --- a/target/i386/kvm/meson.build
> +++ b/target/i386/kvm/meson.build
> @@ -11,6 +11,8 @@ i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
>  
>  i386_softmmu_kvm_ss.add(when: 'CONFIG_SEV', if_false: files('sev-stub.c'))
>  
> +i386_softmmu_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
> +
>  i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
>  
>  i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_softmmu_kvm_ss)
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> new file mode 100644
> index 000000000000..d3792d4a3d56
> --- /dev/null
> +++ b/target/i386/kvm/tdx.c
> @@ -0,0 +1,40 @@
> +/*
> + * QEMU TDX support
> + *
> + * Copyright Intel
> + *
> + * Author:
> + *      Xiaoyao Li <xiaoyao.li@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object_interfaces.h"
> +
> +#include "tdx.h"
> +
> +/* tdx guest */
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
> +                                   tdx_guest,
> +                                   TDX_GUEST,
> +                                   CONFIDENTIAL_GUEST_SUPPORT,
> +                                   { TYPE_USER_CREATABLE },
> +                                   { NULL })
> +
> +static void tdx_guest_init(Object *obj)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    tdx->attributes = 0;
> +}
> +
> +static void tdx_guest_finalize(Object *obj)
> +{
> +}
> +
> +static void tdx_guest_class_init(ObjectClass *oc, void *data)
> +{
> +}
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> new file mode 100644
> index 000000000000..415aeb5af746
> --- /dev/null
> +++ b/target/i386/kvm/tdx.h
> @@ -0,0 +1,19 @@
> +#ifndef QEMU_I386_TDX_H
> +#define QEMU_I386_TDX_H
> +
> +#include "exec/confidential-guest-support.h"
> +
> +#define TYPE_TDX_GUEST "tdx-guest"
> +#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
> +
> +typedef struct TdxGuestClass {
> +    ConfidentialGuestSupportClass parent_class;
> +} TdxGuestClass;
> +
> +typedef struct TdxGuest {
> +    ConfidentialGuestSupport parent_obj;
> +
> +    uint64_t attributes;    /* TD attributes */
> +} TdxGuest;
> +
> +#endif /* QEMU_I386_TDX_H */

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


