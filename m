Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC79F828A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 18:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKh8-0002xU-Hh; Thu, 19 Dec 2024 12:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKgx-0002v0-8e
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKgu-0004Ag-7Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734630722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/65f699+zP0hxZzXVK7O5ivtKVynSZ4cs9bwdZ4NyD0=;
 b=PeiU41tEoC/UEQ95sHNB4wzZh2qpxXZHBVgkPbLQHcscbk13r8Spyv8O53+BrpaSRwYyNV
 bpzwhqGYx8Ey0iSpJ65sMj2pEBpfpDyI8h/o94VnTUdXZBhxZRU0obssk23DlzMQLrymm0
 hEKUayFP+tuja3clFjh95xRYpoIIXHs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-e4tCeR3XMtKyv4rSvegFPA-1; Thu,
 19 Dec 2024 12:51:59 -0500
X-MC-Unique: e4tCeR3XMtKyv4rSvegFPA-1
X-Mimecast-MFC-AGG-ID: e4tCeR3XMtKyv4rSvegFPA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51B0419560B7; Thu, 19 Dec 2024 17:51:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4A9019560A2; Thu, 19 Dec 2024 17:51:47 +0000 (UTC)
Date: Thu, 19 Dec 2024 17:51:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
Message-ID: <Z2RdMJHydsvPpmdH@redhat.com>
References: <20241206112213.88394-1-cohuck@redhat.com>
 <edc12140-6345-4868-938d-c80c4d2c2004@redhat.com>
 <Z1qoa8yXscTSAJ9e@redhat.com> <8734it1bv6.fsf@redhat.com>
 <1fea79e4-7a31-4592-8495-7b18cd82d02b@redhat.com>
 <Z2QE9AqZnpGM5sWD@gezellig> <8634ijrh8q.wl-maz@kernel.org>
 <Z2Q2rWj9cV0W_XVq@gezellig> <86zfkrptmj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86zfkrptmj.wl-maz@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 19, 2024 at 03:41:56PM +0000, Marc Zyngier wrote:
> On Thu, 19 Dec 2024 15:07:25 +0000,
> Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > 
> > On Thu, Dec 19, 2024 at 12:26:29PM +0000, Marc Zyngier wrote:
> > > On Thu, 19 Dec 2024 11:35:16 +0000,
> > > Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > 
> > [...]
> > 
> > > > Consider this:
> > > > 
> > > > Say, there's a serious security issue in a released ARM CPU.  As part of
> > > > the fix, two new CPU flags need to be exposed to the guest OS, call them
> > > > "secflag1" and "secflag2".  Here, the user is configuring a baseline
> > > > model + two extra CPU flags, not to get close to some other CPU model
> > > > but to mitigate itself against a serious security flaw.
> > > 
> > > If there's such a security issue, that the hypervisor's job to do so,
> > > not userspace. 
> > 
> > I don't disagree.  Probably that has always been the case on ARM.  I
> > asked the above based on how QEMU on x86 handles it today.
> > 
> > > See what KVM does for CSV3, for example (and all the
> > > rest of the side-channel stuff).
> > 
> > Noted.  From a quick look in the kernel tree, I assume you're referring
> > to these commits[1].
> > 
> > > You can't rely on userspace for security, that'd be completely
> > > ludicrous.
> > 
> > As Dan Berrangé points out, it's the bog-standard way QEMU deals with
> > some of the CPU-related issues on x86 today.  See this "important CPU
> > flags"[2] section in the QEMU docs.
> 
> I had a look, and we do things quite differently. For example, the
> spec-ctrl equivalent in implemented in FW and in KVM, and is exposed
> by default if the HW is vulnerable. Userspace could hide that the
> mitigation is there, but that's the extent of the configurability.

Whether it is enabled by default or disabled by default isn't a
totally fatal problem. If QEMU can toggle it to the opposite value,
we have the same level of configurability in both cases.

It does, however, have implications for QEMU as if KVM gained support
for exposing the new feature by default and QEMU didn't know about
it, then the guest ABI would have changed without QEMU realizing it.

IOW, it would imply a requirement for timely QEMU updates to match
the kernel, which is something we wouldn't need in x86 world where
the feature is disabled by default. Disable by default is a more
stable approach from QEMU's POV.

> > Mind you, I'm _not_ saying this is how ARM should do it.  I don't know
> > enough about ARM to make such remarks.
> > 
> >     * * *
> > 
> > To reply to your other question on this thread[3] about "which ABI?"  I
> > think Dan is talking about the *guest* ABI: the virtual "chipset" that
> > is exposed to a guest (e.g. PCI(e) topology, ACPI tables, CPU model,
> > etc).  As I understand it, this "guest ABI" should remain predictable,
> > regardless of:
> > 
> >   - whether you're updating KVM, QEMU, or the underlying physical
> >     hardware itself; or
> >   - if the guest is migrated, live or offline
> > 
> > (As you might know, QEMU's "machine types" concept allows to create a
> > stable guest ABI.)
> 
> All of this is under control of QEMU, *except* for the "maximum" of
> the architectural features exposed to the guest. All you can do is
> *downgrade* from there, and only to a limited extent.
> 
> That, in turn has a direct impact on what you call the "CPU model",
> which for the ARM architecture really doesn't exist. All we have is a
> bag of discrete features, with intricate dependencies between them.
> 
> Even ignoring virtualisation: you can readily find two machines using
> the same CPUs (let's say Neoverse-N1), integrated by the same vendor
> (let's say, Ampere), in SoCs that bear the same name (Altra), and
> realise that they have a different feature set. Fun, isn't it?

"Fun" is probably not the word I'd pick :-)

> That's why I don't see CPU models as a viable thing in terms of ABI.
> They are an approximation of what you could have, but the ABI is
> elsewhere.

Right, this makes life quite challenging for QEMU. The premise of named
CPU models (as opposed to -host), is to facilitate the migration of VMs
between heterogenous hardware platforms. That assumes it is possible to
downgrade the CPU on both src + dst, to the common baseline you desire.

If we were to define a named CPU model, for that to be usable, QEMU
would have to be able to query the "maxmimum" architectural features,
and validate that the delta between the host maximum, and the named
CPU model is possible to downgrade. Is arm providing sufficient info
to let QEMU do that ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


