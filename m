Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8473962D17
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Aug 2024 17:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjL2m-0003Q9-1j; Wed, 28 Aug 2024 11:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL2k-0003OT-7A
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjL2f-0000bs-8a
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 11:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724860624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SPk6uyYxbZkxcxAIb/VxPqP2xzp8u7op2yhusmhwy70=;
 b=V+sVhlBJgkhRwAnvG/vdtzesdFaIcx7e6aJ/oNDaPUWWsiJpOOoca7F9rEjRfx/OawrXby
 2QXMVWRlBjo8g72GfAgOCZuct89yQPJB9vN4oTQYQ05yyiElvQCd40mKfVc3bwBAhOur/Q
 ne3XCOiq0i7dR51qC12KX0YqU6pZfNo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-E8OJtFfaOPKbZUl7NRioJg-1; Wed, 28 Aug 2024 11:57:00 -0400
X-MC-Unique: E8OJtFfaOPKbZUl7NRioJg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-709474fc9edso11749698a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 08:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724860620; x=1725465420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPk6uyYxbZkxcxAIb/VxPqP2xzp8u7op2yhusmhwy70=;
 b=k0GHEvmdFzKoC8QsQTgAuN0BwkZVg0SPf8hOOiIKzTlF4i2PYoxFcn9aDlpUVCCveR
 o7NjOSBnoxjQBcOWiYKtiCsqOZGgoQb0Sq32Dk2ag/ETsWC3OKXN3NUehQMfe4xp5X5F
 ww4WX32ISWBNaMSK/0bD68fRj6Rd9WJLRCh1grIpohRrc4Ok+t5zybUBtsRetQFVVB32
 EUF36yDlmsHIx3gJlxtWXi+aVybA681PTp4RYBC5z0EziXXTb6XsHE0bMHwN+j73JXvz
 Ml5Aj0QS4mvwpd/0Pjt0EQ4cVMV2QiVU2RdtWNh6eB6dwHen0nIMP/wHDPQxV26gCWVm
 DQMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUigjwBm9OGMMPUr133ls66w3F//eRkllPa23k129kmxt8lXjN9OhKK1JRj4LEeqV/2kfx7AzTXVilq@nongnu.org
X-Gm-Message-State: AOJu0YwEpc5z9F8C6jUO0u6dF1VTNVScU9hlY+mTGEjHJk3Za5sHxwgz
 7EQemyyCY9eRLSBK4lxc/VCJBrT+JDNCAzzMax0iotANBEJbJ8u70cNjAsBcNkFo3bsR2+77KBl
 SUhtuTUyl/LpXVhFELYWWytCWMewn+QnA2wnWhuHc1qpZvaomB0u7
X-Received: by 2002:a05:6830:2693:b0:704:466b:15a2 with SMTP id
 46e09a7af769-70f5c3b9958mr11008a34.20.1724860619869; 
 Wed, 28 Aug 2024 08:56:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP4fC2LAg1Q8iKsrwowjBDkrw9snEnEjLKmhIirkbwgilz8vFeF36+ixUw9kixt7Ifr9Ny+A==
X-Received: by 2002:a05:6830:2693:b0:704:466b:15a2 with SMTP id
 46e09a7af769-70f5c3b9958mr10976a34.20.1724860619387; 
 Wed, 28 Aug 2024 08:56:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03b5f4ffsm2968197a34.49.2024.08.28.08.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 08:56:58 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:56:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/7] memory: Do not create circular reference with
 subregion
Message-ID: <Zs9IxoRdu6CcZRrx@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-6-a24c6dfa4ceb@daynix.com> <Zsydli9ME1u79A9X@x1n>
 <CAFEAcA_uT3Db22V=Anqci_k6zOaAV7Qua2S1OVFxW_DQyh3bAA@mail.gmail.com>
 <Zszain3SH5cl9ohH@x1n>
 <161cb8ff-1479-4fc4-8803-d665e757007a@daynix.com>
 <Zs36od036pyxvQlZ@x1n>
 <de2229bc-876e-47b2-8a59-18fe7ffe3936@daynix.com>
 <Zs8hcLPU62Hj8x-W@x1n>
 <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eb79a40f-f9c9-47b3-bfd0-0198e6036714@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 28, 2024 at 11:02:06PM +0900, Akihiko Odaki wrote:
> On 2024/08/28 22:09, Peter Xu wrote:
> > On Wed, Aug 28, 2024 at 02:33:59PM +0900, Akihiko Odaki wrote:
> > > On 2024/08/28 1:11, Peter Xu wrote:
> > > > On Tue, Aug 27, 2024 at 01:14:51PM +0900, Akihiko Odaki wrote:
> > > > > On 2024/08/27 4:42, Peter Xu wrote:
> > > > > > On Mon, Aug 26, 2024 at 06:10:25PM +0100, Peter Maydell wrote:
> > > > > > > On Mon, 26 Aug 2024 at 16:22, Peter Xu <peterx@redhat.com> wrote:
> > > > > > > > 
> > > > > > > > On Fri, Aug 23, 2024 at 03:13:11PM +0900, Akihiko Odaki wrote:
> > > > > > > > > memory_region_update_container_subregions() used to call
> > > > > > > > > memory_region_ref(), which creates a reference to the owner of the
> > > > > > > > > subregion, on behalf of the owner of the container. This results in a
> > > > > > > > > circular reference if the subregion and container have the same owner.
> > > > > > > > > 
> > > > > > > > > memory_region_ref() creates a reference to the owner instead of the
> > > > > > > > > memory region to match the lifetime of the owner and memory region. We
> > > > > > > > > do not need such a hack if the subregion and container have the same
> > > > > > > > > owner because the owner will be alive as long as the container is.
> > > > > > > > > Therefore, create a reference to the subregion itself instead ot its
> > > > > > > > > owner in such a case; the reference to the subregion is still necessary
> > > > > > > > > to ensure that the subregion gets finalized after the container.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > > > > > ---
> > > > > > > > >     system/memory.c | 8 ++++++--
> > > > > > > > >     1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/system/memory.c b/system/memory.c
> > > > > > > > > index 5e6eb459d5de..e4d3e9d1f427 100644
> > > > > > > > > --- a/system/memory.c
> > > > > > > > > +++ b/system/memory.c
> > > > > > > > > @@ -2612,7 +2612,9 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
> > > > > > > > > 
> > > > > > > > >         memory_region_transaction_begin();
> > > > > > > > > 
> > > > > > > > > -    memory_region_ref(subregion);
> > > > > > > > > +    object_ref(mr->owner == subregion->owner ?
> > > > > > > > > +               OBJECT(subregion) : subregion->owner);
> > > > > > > > 
> > > > > > > > The only place that mr->refcount is used so far is the owner with the
> > > > > > > > object property attached to the mr, am I right (ignoring name-less MRs)?
> > > > > > > > 
> > > > > > > > I worry this will further complicate refcounting, now we're actively using
> > > > > > > > two refcounts for MRs..
> > > > > 
> > > > > The actor of object_ref() is the owner of the memory region also in this
> > > > > case. We are calling object_ref() on behalf of mr->owner so we use
> > > > > mr->refcount iff mr->owner == subregion->owner. In this sense there is only
> > > > > one user of mr->refcount even after this change.
> > > > 
> > > > Yes it's still one user, but it's not that straightforward to see, also
> > > > it's still an extension to how we use mr->refcount right now.  Currently
> > > > it's about "true / false" just to describe, now it's a real counter.
> > > > 
> > > > I wished that counter doesn't even exist if we'd like to stick with device
> > > > / owner's counter.  Adding this can definitely also make further effort
> > > > harder if we want to remove mr->refcount.
> > > 
> > > I don't think it will make removing mr->refcount harder. With this change,
> > > mr->refcount will count the parent and container. If we remove mr->refcount,
> > > we need to trigger object_finalize() in a way other than checking
> > > mr->refcount, which can be achieved by simply evaluating OBJECT(mr)->parent
> > > && mr->container.
> > > 
> > > > 
> > > > > 
> > > > > > > > 
> > > > > > > > Continue discussion there:
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/r/067b17a4-cdfc-4f7e-b7e4-28c38e1c10f0@daynix.com
> > > > > > > > 
> > > > > > > > What I don't see is how mr->subregions differs from mr->container, so we
> > > > > > > > allow subregions to be attached but not the container when finalize()
> > > > > > > > (which is, afaict, the other way round).
> > > > > > > > 
> > > > > > > > It seems easier to me that we allow both container and subregions to exist
> > > > > > > > as long as within the owner itself, rather than start heavier use of
> > > > > > > > mr->refcount.
> > > > > > > 
> > > > > > > I don't think just "same owner" necessarily will be workable --
> > > > > > > you can have a setup like:
> > > > > > >      * device A has a container C_A
> > > > > > >      * device A has a child-device B
> > > > > > >      * device B has a memory region R_B
> > > > > > >      * device A's realize method puts R_B into C_A
> > > > > > > 
> > > > > > > R_B's owner is B, and the container's owner is A,
> > > > > > > but we still want to be able to get rid of A (in the process
> > > > > > > getting rid of B because it gets unparented and unreffed,
> > > > > > > and R_B and C_A also).
> > > > > > 
> > > > > > For cross-device references, should we rely on an explicit call to
> > > > > > memory_region_del_subregion(), so as to detach the link between C_A and
> > > > > > R_B?
> > > > > 
> > > > > Yes, I agree.
> > > > > 
> > > > > > 
> > > > > > My understanding so far: logically when MR finalize() it should guarantee
> > > > > > both (1) mr->container==NULL, and (2) mr->subregions empty.  That's before
> > > > > > commit 2e2b8eb70fdb7dfb and could be the ideal world (though at the very
> > > > > > beginning we don't assert on ->container==NULL yet).  It requires all
> > > > > > device emulations to do proper unrealize() to unlink all the MRs.
> > > > > > 
> > > > > > However what I'm guessing is QEMU probably used to have lots of devices
> > > > > > that are not following the rules and leaking these links.  Hence we have
> > > > > > had 2e2b8eb70fdb7dfb, allowing that to happen as long as it's safe, and
> > > > > > it's justified by comment in 2e2b8eb70fdb7dfb on why it's safe.
> > > > > > 
> > > > > > What I was thinking is this comment seems to apply too to mr->container, so
> > > > > > that it should be safe too to unlink ->container the same way as its own
> > > > > > subregions. >
> > > > > > IIUC that means for device-internal MR links we should be fine leaving
> > > > > > whatever link between MRs owned by such device; the device->refcount
> > > > > > guarantees none of them will be visible in any AS.  But then we need to
> > > > > > always properly unlink the MRs when the link is across >1 device owners,
> > > > > > otherwise it's prone to leak.
> > > > > 
> > > > > There is one principle we must satisfy in general: keep a reference to a
> > > > > memory region if it is visible to the guest.
> > > > > 
> > > > > It is safe to call memory_region_del_subregion() and to trigger the
> > > > > finalization of subregions when the container is not referenced because they
> > > > > are no longer visible. This is not true for the other way around; even when
> > > > > subregions are not referenced by anyone else, they are still visible to the
> > > > > guest as long as the container is visible to the guest. It is not safe to
> > > > > unref and finalize them in such a case.
> > > > > 
> > > > > A memory region and its owner will leak if a memory region kept visible for
> > > > > a too long period whether the chain of reference contains a
> > > > > container/subregion relationship or not.
> > > > 
> > > > Could you elaborate why it's still visible to the guest if
> > > > owner->refcount==0 && mr->container!=NULL?
> > > > 
> > > > Firstly, mr->container != NULL means the MR has an user indeed.  It's the
> > > > matter of who's using it.  If that came from outside this device, it should
> > > > require memory_region_ref(mr) before hand when adding the subregion, and
> > > > that will hold one reference on the owner->refcount.
> > > > 
> > > > Here owner->refcount==0 means there's no such reference, so it seems to me
> > > > it's guaranteed to not be visible to anything outside of this device / owner.
> > > > Then from that POV it's safe to unlink when the owner is finalizing just
> > > > like what we do with mr->subregions, no?
> > > 
> > > An object is alive during instance_finalize even though its refcount == 0.
> > > We can't assume all memory regions are dead even if owner->refcount == 0
> > > because of that.
> > 
> > When you referred to "an object", do you mean the MR being finalized here?
> > 
> > IIUC when the MR reaches its finalize(), it should mean it's not live
> > anymore.
> > 
> > We have two forms of MR usages right now: either embeded in another Object
> > / Device, or dynamically, like VFIOQuirk.
> > 
> > When used embeded, the MR is only finalized when being removed from the
> > object's property list, that should only happen when the object / device
> > triggered finalize().  Since the MR will use the owner->refcount so I
> > suppose it means the MR is not live anymore.
> > 
> > When used dynamically, object_unparent() is needed but that should only
> > happen when the object / owner is during finalize(), per document:
> > 
> >          If however the memory region is part of a dynamically allocated
> >          data structure, you should call object_unparent() to destroy the
> >          memory region before the data structure is freed.  For an example
> >          see VFIOMSIXInfo and VFIOQuirk in hw/vfio/pci.c.
> > 
> > Then the MR is also not live.
> > 
> > > In particular, docs/devel/memory.rst says you can call object_unparent()
> > > in the instance_finalize of the owner. This assumes a memory region will
> > > not vanish during the execution of the function unless object_unparent()
> > > is already called for the memory region.
> > 
> > Yes, the MR will not vanish during finalize() of the owner object. However
> > I don't think it's "live"?  Again, it's based on my definition of
> > "liveness" as "taking one refcount of its owner", here the owner refcount
> > is zero.  IOW, I don't expect it to be accessible anywhere from any address
> > space (e.g. address_space_map()), because they'll all use
> > memory_region_ref() and that'll ultimately stops the owner from being
> > finalized.
> 
> I am calling the fact that embedded memory regions are accessible in
> instance_finalize() "live". A device can perform operations on its memory
> regions during instance_finalize() and we should be aware of that.

This part is true.  I suppose we should still suggest device finalize() to
properly detach MRs, and that should normally be done there.

> 
> object_unparent() is such an example. instance_finalize() of a device can
> call object_unparent() for a subregion and for its container. If we
> automatically finalize the container when calling object_unparent() for the
> subregion, calling object_unparent() for its container will result in the
> second finalization, which is not good.

IMHO we don't finalize the container at all - what I suggested was we call
del_subregion() for the case where container != NULL.  Since in this case
both container & mr belong to the same owner, it shouldn't change any
refcount, but only remove the link.

However I think I see what you pointed out.  I wonder why we remove all
properties now before reaching instance_finalze(): shouldn't finalize() be
allowed to access some of the properties?

It goes back to this commit:

commit 76a6e1cc7cc3ad022e7159b37b291b75bc4615bf
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Jun 11 11:58:30 2014 +0200

    qom: object: delete properties before calling instance_finalize
    
    This ensures that the children's unparent callback will still
    have a usable parent.
    
    Reviewed-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

From this series (as the 1st patch there):

https://lore.kernel.org/qemu-devel/1406716032-21795-1-git-send-email-pbonzini@redhat.com/

I can't say I fully understand the commit yet so far.. because it seems
this patch was trying to pave way so that MR's unparent() can have a usable
parent.  However... I don't think mr implemented unparent() at all..
while it just sounds more reasonable that properties shouldn't be
auto-removed before calling instance_finalize() from my gut feeling.

I tried to revert 76a6e1cc7c ("qom: object: delete properties before
calling instance_finalize"), "make check" all passes here.  I am a bit
confused on where it applies, and whether we should revert it.

If with 76a6e1cc7cc reverted, I think your concern should go away because
then properties (including MRs) will only be detached after owner's
instance_finalize().  Again, I wished Paolo could chime in as he should
know the best.

Thanks,

-- 
Peter Xu


