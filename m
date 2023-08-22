Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E6783BA5
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:21:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMcV-0005gn-Ve; Tue, 22 Aug 2023 04:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYMcT-0005gL-6d
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYMcP-0002i6-6o
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692692404;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agB6Opzb6rPqaDWBwKZ/5qpL5CbpESEPdnuQeYUz9NM=;
 b=BuRTbQ5qowCPKoz9SqcIwRC+c9Xn83eEHUY6IILWfOMXCUcyWgyehasu1EoLNAGTBUeL3c
 V05sers4Ttx2CRmkUxSlmLGSyeHtgX7Lf7k6DQLgt6IALjjTbwShzkRzaJBirUiCpG9VZ/
 YChQbDKV0/0/pa957Xp2hTQi7psw3No=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-lh7E7-x2MCOTsUUBb6SUfA-1; Tue, 22 Aug 2023 04:20:00 -0400
X-MC-Unique: lh7E7-x2MCOTsUUBb6SUfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 952813C11A04;
 Tue, 22 Aug 2023 08:19:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC4812166B26;
 Tue, 22 Aug 2023 08:19:56 +0000 (UTC)
Date: Tue, 22 Aug 2023 09:19:54 +0100
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
Subject: Re: [PATCH v2 06/58] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Message-ID: <ZORvqthhRG+38OlC@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-7-xiaoyao.li@intel.com>
 <ZOMkYvm9vsQs8sas@redhat.com>
 <226923bc-755c-f4db-a381-f00088c6614e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <226923bc-755c-f4db-a381-f00088c6614e@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Tue, Aug 22, 2023 at 03:31:44PM +0800, Xiaoyao Li wrote:
> On 8/21/2023 4:46 PM, Daniel P. Berrangé wrote:
> > On Fri, Aug 18, 2023 at 05:49:49AM -0400, Xiaoyao Li wrote:
> > > KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
> > > IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
> > > TDX context. It will be used to validate user's setting later.
> > > 
> > > Since there is no interface reporting how many cpuid configs contains in
> > > KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
> > > and abort when it exceeds KVM_MAX_CPUID_ENTRIES.
> > > 
> > > Besides, introduce the interfaces to invoke TDX "ioctls" at different
> > > scope (KVM, VM and VCPU) in preparation.
> > > 
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > ---
> > > changes from v1:
> > >    - Make the error message more clear;
> > > 
> > > changes from RFC v4:
> > >    - start from nr_cpuid_configs = 6 for the loop;
> > >    - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
> > > ---
> > >   target/i386/kvm/kvm.c      |  2 -
> > >   target/i386/kvm/kvm_i386.h |  2 +
> > >   target/i386/kvm/tdx.c      | 93 ++++++++++++++++++++++++++++++++++++++
> > >   3 files changed, 95 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > index d6b988d6c2d1..ec5c07bffd38 100644
> > > --- a/target/i386/kvm/kvm.c
> > > +++ b/target/i386/kvm/kvm.c
> > > @@ -1751,8 +1751,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
> > >   static Error *invtsc_mig_blocker;
> > > -#define KVM_MAX_CPUID_ENTRIES  100
> > > -
> > >   static void kvm_init_xsave(CPUX86State *env)
> > >   {
> > >       if (has_xsave2) {
> > > diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> > > index ea3a5b174ac0..769eadbba56c 100644
> > > --- a/target/i386/kvm/kvm_i386.h
> > > +++ b/target/i386/kvm/kvm_i386.h
> > > @@ -13,6 +13,8 @@
> > >   #include "sysemu/kvm.h"
> > > +#define KVM_MAX_CPUID_ENTRIES  100
> > > +
> > >   #define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
> > >   #ifdef CONFIG_KVM
> > > diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> > > index 77e33ae01147..255c47a2a553 100644
> > > --- a/target/i386/kvm/tdx.c
> > > +++ b/target/i386/kvm/tdx.c
> > > @@ -12,14 +12,107 @@
> > >    */
> > >   #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > >   #include "qapi/error.h"
> > >   #include "qom/object_interfaces.h"
> > > +#include "sysemu/kvm.h"
> > >   #include "hw/i386/x86.h"
> > > +#include "kvm_i386.h"
> > >   #include "tdx.h"
> > > +static struct kvm_tdx_capabilities *tdx_caps;
> > > +
> > > +enum tdx_ioctl_level{
> > > +    TDX_PLATFORM_IOCTL,
> > > +    TDX_VM_IOCTL,
> > > +    TDX_VCPU_IOCTL,
> > > +};
> > > +
> > > +static int __tdx_ioctl(void *state, enum tdx_ioctl_level level, int cmd_id,
> > > +                        __u32 flags, void *data)
> > 
> > Names with an initial double underscore are reserved for us by the
> > platform implementation, so shouldn't be used in userspace app
> > code.
> 
> How about tdx_ioctl_internal() ?

Sure, that's fine.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


