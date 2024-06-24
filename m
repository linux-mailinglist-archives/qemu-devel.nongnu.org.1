Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9A915144
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 17:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlCU-0004Sm-CB; Mon, 24 Jun 2024 11:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLlCR-0004SG-L7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLlCN-0003K0-Ng
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719241298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axG6iQmge2g3Gxbz5QmmA7dei39mT0fRpl/CXp5SCDA=;
 b=ZAtIl5sW3gy3GzRoFuXgCcKYfOXJXxKOCpQJ7Im3SHRe2LRnhgy6IF8/YQw71G85HN8gxn
 MKiUsiZdjLvfJe+OHezxn3pBT50HjMRJAGlmaTrysZhoHn8dxdxmFkpsL0gKoMIlppC2wz
 EZBMAXq9S8akb8sMuO4bO6MRiyqb2ko=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-ieZ6HrthMwibpDN3zCKgHQ-1; Mon,
 24 Jun 2024 11:01:35 -0400
X-MC-Unique: ieZ6HrthMwibpDN3zCKgHQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD9CE19560BF; Mon, 24 Jun 2024 15:01:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E60641956087; Mon, 24 Jun 2024 15:01:24 +0000 (UTC)
Date: Mon, 24 Jun 2024 16:01:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
Message-ID: <ZnmKQeMtOq8dyWjC@redhat.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-26-xiaoyao.li@intel.com>
 <ZmGTXP36B76IRalJ@redhat.com>
 <90739246-f008-4cf2-bcf5-8a243e2b13d4@intel.com>
 <SJ0PR11MB674430CD121A9F91D818A67092C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a5d434b5-c1c2-451c-9181-3c9eacbc2999@intel.com>
 <Zmv2DQQMndYq4LmY@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmv2DQQMndYq4LmY@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 14, 2024 at 08:49:57AM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 14, 2024 at 09:04:33AM +0800, Xiaoyao Li wrote:
> > On 6/13/2024 4:35 PM, Duan, Zhenzhong wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Li, Xiaoyao <xiaoyao.li@intel.com>
> > > > Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
> > > > tdx-guest object
> > > > 
> > > > On 6/6/2024 6:45 PM, Daniel P. Berrangé wrote:
> > > > > Copying  Zhenzhong Duan as my point relates to the proposed libvirt
> > > > > TDX patches.
> > > > > 
> > > > > On Thu, Feb 29, 2024 at 01:36:46AM -0500, Xiaoyao Li wrote:
> > > > > > Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it
> > > > disables
> > > > > > EPT violation conversion to #VE on guest TD access of PENDING pages.
> > > > > > 
> > > > > > Some guest OS (e.g., Linux TD guest) may require this bit as 1.
> > > > > > Otherwise refuse to boot.
> > > > > > 
> > > > > > Add sept-ve-disable property for tdx-guest object, for user to configure
> > > > > > this bit.
> > > > > > 
> > > > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > > Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > ---
> > > > > > Changes in v4:
> > > > > > - collect Acked-by from Markus
> > > > > > 
> > > > > > Changes in v3:
> > > > > > - update the comment of property @sept-ve-disable to make it more
> > > > > >     descriptive and use new format. (Daniel and Markus)
> > > > > > ---
> > > > > >    qapi/qom.json         |  7 ++++++-
> > > > > >    target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
> > > > > >    2 files changed, 30 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > index 220cc6c98d4b..89ed89b9b46e 100644
> > > > > > --- a/qapi/qom.json
> > > > > > +++ b/qapi/qom.json
> > > > > > @@ -900,10 +900,15 @@
> > > > > >    #
> > > > > >    # Properties for tdx-guest objects.
> > > > > >    #
> > > > > > +# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
> > > > > > +#     of EPT violation conversion to #VE on guest TD access of PENDING
> > > > > > +#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
> > > > > > +#     be set, otherwise they refuse to boot.
> > > > > > +#
> > > > > >    # Since: 9.0
> > > > > >    ##
> > > > > >    { 'struct': 'TdxGuestProperties',
> > > > > > -  'data': { }}
> > > > > > +  'data': { '*sept-ve-disable': 'bool' } }
> > > > > 
> > > > > So this exposes a single boolean property that gets mapped into one
> > > > > specific bit in the TD attributes:
> > > > > 
> > > > > > +
> > > > > > +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error
> > > > **errp)
> > > > > > +{
> > > > > > +    TdxGuest *tdx = TDX_GUEST(obj);
> > > > > > +
> > > > > > +    if (value) {
> > > > > > +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> > > > > > +    } else {
> > > > > > +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
> > > > > > +    }
> > > > > > +}
> > > > > 
> > > > > If I look at the documentation for TD attributes
> > > > > 
> > > > >     https://download.01.org/intel-sgx/latest/dcap-
> > > > latest/linux/docs/Intel_TDX_DCAP_Quoting_Library_API.pdf
> > > > > 
> > > > > Section "A.3.4. TD Attributes"
> > > > > 
> > > > > I see "TD attributes" is a 64-bit int, with 5 bits currently
> > > > > defined "DEBUG", "SEPT_VE_DISABLE", "PKS", "PL", "PERFMON",
> > > > > and the rest currently reserved for future use. This makes me
> > > > > wonder about our modelling approach into the future ?
> > > > > 
> > > > > For the AMD SEV equivalent we've just directly exposed the whole
> > > > > field as an int:
> > > > > 
> > > > >        'policy' : 'uint32',
> > > > > 
> > > > > For the proposed SEV-SNP patches, the same has been done again
> > > > > 
> > > > > https://lists.nongnu.org/archive/html/qemu-devel/2024-
> > > > 06/msg00536.html
> > > > > 
> > > > >        '*policy': 'uint64',
> > > > > 
> > > > > 
> > > > > The advantage of exposing individual booleans is that it is
> > > > > self-documenting at the QAPI level, but the disadvantage is
> > > > > that every time we want to expose ability to control a new
> > > > > bit in the policy we have to modify QEMU, libvirt, the mgmt
> > > > > app above libvirt, and whatever tools the end user has to
> > > > > talk to the mgmt app.
> > > > > 
> > > > > If we expose a policy int, then newly defined bits only require
> > > > > a change in QEMU, and everything above QEMU will already be
> > > > > capable of setting it.
> > > > > 
> > > > > In fact if I look at the proposed libvirt patches, they have
> > > > > proposed just exposing a policy "int" field in the XML, which
> > > > > then has to be unpacked to set the individual QAPI booleans
> > > > > 
> > > > > 
> > > > https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/WXWX
> > > > EESYUA77DP7YIBP55T2OPSVKV5QW/
> > > > > 
> > > > > On balance, I think it would be better if QEMU just exposed
> > > > > the raw TD attributes policy as an uint64 at QAPI, instead
> > > > > of trying to unpack it to discrete bool fields. This gives
> > > > > consistency with SEV and SEV-SNP, and with what's proposed
> > > > > at the libvirt level, and minimizes future changes when
> > > > > more policy bits are defined.
> > > > 
> > > > The reasons why introducing individual bit of sept-ve-disable instead of
> > > > a raw TD attribute as a whole are that
> > > > 
> > > > 1. other bits like perfmon, PKS, KL are associated with cpu properties,
> > > > e.g.,
> > > > 
> > > > 	perfmon -> pmu,
> > > > 	pks -> pks,
> > > > 	kl -> keylokcer feature that QEMU currently doesn't support
> > > > 
> > > > If allowing configuring attribute directly, we need to deal with the
> > > > inconsistence between attribute vs cpu property.
> > > 
> > > What about defining those bits associated with cpu properties reserved
> > > But other bits work as Daniel suggested way.
> > 
> > I don't understand. Do you mean we provide the interface to configure raw 64
> > bit attributes while some bits of it are reserved?
> 
> Just have a mask of what bits are permitted to be set, and report an
> error if the user sets non-permitted bits.

Looking at the IGVM patches, the CnofidentialGuestSupport class is
gaining a "set_guest_policy" method, which takes a "uint64_t policy".

If (when) IGVM support is extended to cover TDX too, then we're
going to need to accept the user providing the policy in integer
format via the IGVM file metadata. This will require adding code
to check for any inconsistency between the policy bitmask, and
the CPU flags.

  https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg04037.html

so to me this is another reason to just expose the policy as an
integer in the QAPI/QOM structure too. Everywhere just wants to
be working with policy in integer format.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


