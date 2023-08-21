Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FE4782643
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1Ei-0004aQ-RK; Mon, 21 Aug 2023 05:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1Eh-0004aB-H9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1Ef-0004fQ-1K
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692610207;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4TLTFC4X1BaALVGXBpCe1Lrd+0Q2ev3VUQOJTssT89Q=;
 b=DwMja8arJFNo9UttWUBe4cdW/LXH+aR1B7b+ZYqwTdjFPz9j/WvupuA0hzLORsMH9VjIHm
 0tGtHJhH3CduDDnkLrUq8N7UDm6JWo6eFe0CGgfe30GLm9QAvxg70LfloCtNEn8Rsh40gV
 6GexRL72ZWsF0zV4hjA/3JfFlGkWNdc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-V5F0DPpzOReCZ1U8h5eYsQ-1; Mon, 21 Aug 2023 05:30:03 -0400
X-MC-Unique: V5F0DPpzOReCZ1U8h5eYsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8241B38008B0;
 Mon, 21 Aug 2023 09:30:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 077081121314;
 Mon, 21 Aug 2023 09:29:58 +0000 (UTC)
Date: Mon, 21 Aug 2023 10:29:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 20/58] i386/tdx: Allows
 mrconfigid/mrowner/mrownerconfig for TDX_INIT_VM
Message-ID: <ZOMulbt2Z9+9EEkv@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-21-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-21-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 05:50:03AM -0400, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> When creating TDX vm, three sha384 hash values can be provided for
> TDX attestation.
> 
> So far they were hard coded as 0. Now allow user to specify those values
> via property mrconfigid, mrowner and mrownerconfig. Choose hex-encoded
> string as format since it's friendly for user to input.
> 
> example
> -object tdx-guest, \
>   mrconfigid=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef, \
>   mrowner=fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210, \
>   mrownerconfig=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> TODO:
>  - community requests to use base64 encoding if no special reason
> ---
>  qapi/qom.json         | 11 ++++++++++-
>  target/i386/kvm/tdx.c | 13 +++++++++++++
>  target/i386/kvm/tdx.h |  3 +++
>  3 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index cc08b9a98df9..87c1d440f331 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -873,10 +873,19 @@
>  #
>  # @sept-ve-disable: bit 28 of TD attributes (default: 0)
>  #
> +# @mrconfigid: MRCONFIGID SHA384 hex string of 48 * 2 length (default: 0)
> +#
> +# @mrowner: MROWNER SHA384 hex string of 48 * 2 length (default: 0)
> +#
> +# @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)

Per previous patch, I suggest these should all be passed in base64
instead of hex. Also 'default: 0' makes no sense for a string,
which would be 'default: nil', and no need to document that as
the default is implicit from the fact that its an optional string
field. So eg

  @mrconfigid: base64 encoded MRCONFIGID SHA384 digest

> +#
>  # Since: 8.2
>  ##
>  { 'struct': 'TdxGuestProperties',
> -  'data': { '*sept-ve-disable': 'bool' } }
> +  'data': { '*sept-ve-disable': 'bool',
> +            '*mrconfigid': 'str',
> +            '*mrowner': 'str',
> +            '*mrownerconfig': 'str' } }
>  
>  ##
>  # @ThreadContextProperties:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 73da15377ec3..33d015a08c34 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -521,6 +521,13 @@ int tdx_pre_create_vcpu(CPUState *cpu)
>      init_vm->cpuid.nent = kvm_x86_arch_cpuid(env, init_vm->cpuid.entries, 0);
>      init_vm->attributes = tdx_guest->attributes;
>  
> +    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrconfigid) != sizeof(tdx_guest->mrconfigid));
> +    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrowner) != sizeof(tdx_guest->mrowner));
> +    QEMU_BUILD_BUG_ON(sizeof(init_vm->mrownerconfig) != sizeof(tdx_guest->mrownerconfig));
> +    memcpy(init_vm->mrconfigid, tdx_guest->mrconfigid, sizeof(tdx_guest->mrconfigid));
> +    memcpy(init_vm->mrowner, tdx_guest->mrowner, sizeof(tdx_guest->mrowner));
> +    memcpy(init_vm->mrownerconfig, tdx_guest->mrownerconfig, sizeof(tdx_guest->mrownerconfig));
> +
>      do {
>          r = tdx_vm_ioctl(KVM_TDX_INIT_VM, 0, init_vm);
>      } while (r == -EAGAIN);
> @@ -575,6 +582,12 @@ static void tdx_guest_init(Object *obj)
>      object_property_add_bool(obj, "sept-ve-disable",
>                               tdx_guest_get_sept_ve_disable,
>                               tdx_guest_set_sept_ve_disable);
> +    object_property_add_sha384(obj, "mrconfigid", tdx->mrconfigid,
> +                               OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_sha384(obj, "mrowner", tdx->mrowner,
> +                               OBJ_PROP_FLAG_READWRITE);
> +    object_property_add_sha384(obj, "mrownerconfig", tdx->mrownerconfig,
> +                               OBJ_PROP_FLAG_READWRITE);
>  }
>  
>  static void tdx_guest_finalize(Object *obj)
> diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
> index 46a24ee8c7cc..68f8327f2231 100644
> --- a/target/i386/kvm/tdx.h
> +++ b/target/i386/kvm/tdx.h
> @@ -21,6 +21,9 @@ typedef struct TdxGuest {
>  
>      bool initialized;
>      uint64_t attributes;    /* TD attributes */
> +    uint8_t mrconfigid[48];     /* sha348 digest */
> +    uint8_t mrowner[48];        /* sha348 digest */
> +    uint8_t mrownerconfig[48];  /* sha348 digest */
>  } TdxGuest;
>  
>  #ifdef CONFIG_TDX
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


