Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212E7825F0
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY0lc-0005ZN-3i; Mon, 21 Aug 2023 05:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY0lS-0005WB-K6
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY0lQ-0006vV-1n
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692608394;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oUNFPBwuacrfKR5wY4zXtbeCoielBgq1hU50/mf0WdI=;
 b=akOlJKrta+QOuReXC++DLNZpT1fwjM5d5oMHXe18SJoK0g3b3x96J9odHaXJB0afHIsby0
 tGZhoFYiiVDZiCox2H0VW2z6TgnuNZZ6UTAH0vpxAlV3/jH1uoeoIJT3wIcnn40QpFxecI
 uXEfa1d2kVhoT3P6hXLhAo6aJIJLx7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-kUh68BOcP_y6u4hycSuLmg-1; Mon, 21 Aug 2023 04:59:51 -0400
X-MC-Unique: kUh68BOcP_y6u4hycSuLmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59BA185A78B;
 Mon, 21 Aug 2023 08:59:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41B7B40D2843;
 Mon, 21 Aug 2023 08:59:46 +0000 (UTC)
Date: Mon, 21 Aug 2023 09:59:43 +0100
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
Subject: Re: [PATCH v2 15/58] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Message-ID: <ZOMnf8n8BksktlGg@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-16-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-16-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On Fri, Aug 18, 2023 at 05:49:58AM -0400, Xiaoyao Li wrote:
> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
> EPT violation conversion to #VE on guest TD access of PENDING pages.
> 
> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
> Otherwise refuse to boot.
> 
> Add sept-ve-disable property for tdx-guest object, for user to configure
> this bit.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  qapi/qom.json         |  4 +++-
>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 2ca7ce7c0da5..cc08b9a98df9 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -871,10 +871,12 @@
>  #
>  # Properties for tdx-guest objects.
>  #
> +# @sept-ve-disable: bit 28 of TD attributes (default: 0)

This description isn't very useful as it forces the user to go off and
read the TDX specification to find out what bit 28 means. You've got a
more useful description in the commit message, so please use that
in the docs too. eg something like this

  @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
                    of EPT violation conversion to #VE on guest
                    TD access of PENDING pages. Some guest OS (e.g.
		    Linux TD guest) may require this set, otherwise
                    they refuse to boot.

> +#
>  # Since: 8.2
>  ##
>  { 'struct': 'TdxGuestProperties',
> -  'data': { }}
> +  'data': { '*sept-ve-disable': 'bool' } }
>  
>  ##
>  # @ThreadContextProperties:
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 3d313ed46bd1..22130382c0c5 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -32,6 +32,8 @@
>                                       (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
>                                       (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
>  
> +#define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
> +
>  #define TDX_ATTRIBUTES_MAX_BITS      64
>  
>  static FeatureMask tdx_attrs_ctrl_fields[TDX_ATTRIBUTES_MAX_BITS] = {
> @@ -501,6 +503,24 @@ out:
>      return r;
>  }
>  
> +static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    return !!(tdx->attributes & TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE);
> +}
> +
> +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
> +{
> +    TdxGuest *tdx = TDX_GUEST(obj);
> +
> +    if (value) {
> +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> +    } else {
> +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> +    }
> +}
> +
>  /* tdx guest */
>  OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>                                     tdx_guest,
> @@ -516,6 +536,10 @@ static void tdx_guest_init(Object *obj)
>      qemu_mutex_init(&tdx->lock);
>  
>      tdx->attributes = 0;
> +
> +    object_property_add_bool(obj, "sept-ve-disable",
> +                             tdx_guest_get_sept_ve_disable,
> +                             tdx_guest_set_sept_ve_disable);
>  }
>  
>  static void tdx_guest_finalize(Object *obj)
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


