Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE0278449B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:44:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSaN-0004pr-Ba; Tue, 22 Aug 2023 10:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYSaI-0004pf-DR
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYSaF-0003AF-Sy
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692715334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fibOIifOIoCYjZF01dSrqWuwFTP4vh92xbvCgHNrUfI=;
 b=R10feiXqZ4lXbEM4A8TMX1hQ9Pi5lInzGjeT45bIkjvZ/KwLYHWj+Yag4vcM171EiMyXen
 oB8O18vGzoKR+Bxh1iza1hKKMn/rENmY77fGZmIv/DYDyN8AcMxTE//Ei73RjyjQtoWxgJ
 VHvihQgcSQujg0aeQc+jm7wUcOlSeto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-x8Mv49SCOw2_F7ayOxTfzQ-1; Tue, 22 Aug 2023 10:42:11 -0400
X-MC-Unique: x8Mv49SCOw2_F7ayOxTfzQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B84E68D40D9;
 Tue, 22 Aug 2023 14:42:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDA314A9004;
 Tue, 22 Aug 2023 14:42:07 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:42:05 +0100
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
Subject: Re: [PATCH v2 18/58] i386/tdx: Validate TD attributes
Message-ID: <ZOTJPUPtYnBMI0W9@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-19-xiaoyao.li@intel.com>
 <ZOMrd6f0URDYp/0r@redhat.com>
 <c1ad3974-876a-9d29-9a59-f54ae4f8b09e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1ad3974-876a-9d29-9a59-f54ae4f8b09e@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Aug 22, 2023 at 10:30:47PM +0800, Xiaoyao Li wrote:
> On 8/21/2023 5:16 PM, Daniel P. Berrangé wrote:
> > On Fri, Aug 18, 2023 at 05:50:01AM -0400, Xiaoyao Li wrote:
> > > Validate TD attributes with tdx_caps that fixed-0 bits must be zero and
> > > fixed-1 bits must be set.
> > > 
> > > Besides, sanity check the attribute bits that have not been supported by
> > > QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> > > TD support lands in QEMU.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >   target/i386/kvm/tdx.c | 27 +++++++++++++++++++++++++--
> > >   1 file changed, 25 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> > > index 629abd267da8..73da15377ec3 100644
> > > --- a/target/i386/kvm/tdx.c
> > > +++ b/target/i386/kvm/tdx.c
> > > @@ -32,6 +32,7 @@
> > >                                        (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
> > >                                        (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
> > > +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
> > >   #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
> > >   #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
> > >   #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
> > > @@ -462,13 +463,32 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
> > >       return 0;
> > >   }
> > > -static void setup_td_guest_attributes(X86CPU *x86cpu)
> > > +static int tdx_validate_attributes(TdxGuest *tdx)
> > > +{
> > > +    if (((tdx->attributes & tdx_caps->attrs_fixed0) | tdx_caps->attrs_fixed1) !=
> > > +        tdx->attributes) {
> > > +            error_report("Invalid attributes 0x%lx for TDX VM (fixed0 0x%llx, fixed1 0x%llx)",
> > > +                          tdx->attributes, tdx_caps->attrs_fixed0, tdx_caps->attrs_fixed1);
> > > +            return -EINVAL;
> > > +    }
> > > +
> > > +    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
> > > +        error_report("Current QEMU doesn't support attributes.debug[bit 0] for TDX VM");
> > > +        return -EINVAL;
> > > +    }
> > 
> > Use error_setg() in both cases, passing in a 'Error **errp' object,
> > and 'return -1' instead of returning an errno value.
> > 
> 
> why return -1 instead of -EINVAL?

Returning errno values is useful if the method isn't providing an
"Error **errp" parameter, because it lets the caller report a
more detailed error message via strerror(). Once you add a Error **
parameter though, there is almost never any reason for the caller
to care about the original errno value, and so we use 0 / -1 as
success/fail indicators.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


