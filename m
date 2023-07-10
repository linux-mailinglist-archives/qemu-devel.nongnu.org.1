Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97C74CC9C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 08:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIk17-0000ig-5u; Mon, 10 Jul 2023 02:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIk15-0000iM-D4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIk12-0008KA-ON
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688969094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1rl0OtHmz0g5KomagIf1Tiwra5A2T1sSvU78uSsSVM=;
 b=K6xn/jUWtJRrLg9Txom1sRILnul4t3r5DLTpUrPLRR+7DDxVHczSZsUlSBiY0KQwy3P76L
 JIcTJDiVvNFwm/4L/IUbcoY5SFqd66oRA3W+iyhMgviSIrqDqfwHYGzSKph6QhMyn9QS0r
 o5/CTgCBD4AnNXGjvQKJhlJ21d62jCA=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-wZbhDVW0MTa6vXOxm-u28A-1; Mon, 10 Jul 2023 02:04:53 -0400
X-MC-Unique: wZbhDVW0MTa6vXOxm-u28A-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-c64521ac8d6so4750085276.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 23:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688969092; x=1691561092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1rl0OtHmz0g5KomagIf1Tiwra5A2T1sSvU78uSsSVM=;
 b=UrEjkPgkRR9B8IajiACIfMKo9K1+o7Td7SZsFrEo7yfl6eR6apdR0GNAw1S1y0vUo0
 j3wwTRSkMVvikEc3AETtMLN555CG0xk8ow2xhYZKYXaoItfQiWErghxKNolZLpyia/Dh
 HbJ8N/zahepZSAmZk6l0DzO7UvHHDvMq3npubdxClzQCTF/ZlpnBFli/dvCiN1OQiM8V
 VJK6joAoP+vwywxtTHghTUei451tV+w+MoFb2fEEoCbv6K4/OuSJiRM6dtzmr3Q6x0AP
 3hkHwKdlmhcSFqd1HWfQl+/tnEdNBbXLRfVNHuxwD7bKQDlk47Cwkj9lwFbAz/xHgFJM
 v6iA==
X-Gm-Message-State: ABy/qLZWTkMlVhh7vTF7sCA4BDzlMBk6otNs6p8kgZp/7tn2q6hqzoqr
 071LSQGKHh1Ouv+q8nTvtwVGEtb6wLL2Jr9yKCL6tc5mMx1arMXlTMgHSpsBorxjOEEQ5rw+rfx
 3ykpdC/Dhgo1T2TuCt3WLz+lQ6+42Xjo=
X-Received: by 2002:a25:1543:0:b0:c5d:f2af:5a24 with SMTP id
 64-20020a251543000000b00c5df2af5a24mr9411509ybv.14.1688969092532; 
 Sun, 09 Jul 2023 23:04:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFOa8qZg4gBUbUk4fKMmzkp4cHX0va0ofpsQv7OVQKsBRry/xrveg3FXvPs8T9IP4rVjY9HOBtdja9imvFJHQ=
X-Received: by 2002:a25:1543:0:b0:c5d:f2af:5a24 with SMTP id
 64-20020a251543000000b00c5df2af5a24mr9411495ybv.14.1688969092173; Sun, 09 Jul
 2023 23:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
 <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
 <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
 <CAJaqyWcDLG3zG3-4Ht=ebWh-yAXY=srazwuOv1jy3sR-+dPfqg@mail.gmail.com>
 <88be4f76-f03d-fd50-8eaf-c6f7f7d31810@oracle.com>
In-Reply-To: <88be4f76-f03d-fd50-8eaf-c6f7f7d31810@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Jul 2023 08:04:16 +0200
Message-ID: <CAJaqyWd-Zbe3dSo_biV7z_gQ=stk738B1qS6R8cnoz2RR_awHg@mail.gmail.com>
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eli Cohen <elic@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, Juan Quintela <quintela@redhat.com>, 
 David Gilbert <dgilbert@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jul 8, 2023 at 11:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 7/5/2023 10:46 PM, Eugenio Perez Martin wrote:
> > On Thu, Jul 6, 2023 at 2:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.co=
m> wrote:
> >>
> >>
> >> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
> >>> On Tue, Jun 27, 2023 at 8:36=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
> >>>>> On Fri, Jun 9, 2023 at 12:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> >>>>>>> On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@or=
acle.com> wrote:
> >>>>>>>> Sorry for reviving this old thread, I lost the best timing to fo=
llow up
> >>>>>>>> on this while I was on vacation. I have been working on this and=
 found
> >>>>>>>> out some discrepancy, please see below.
> >>>>>>>>
> >>>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>>>>>>>> Hi!
> >>>>>>>>>
> >>>>>>>>> As mentioned in the last upstream virtio-networking meeting, on=
e of
> >>>>>>>>> the factors that adds more downtime to migration is the handlin=
g of
> >>>>>>>>> the guest memory (pin, map, etc). At this moment this handling =
is
> >>>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sens=
e, the
> >>>>>>>>> destination device waits until all the guest memory / state is
> >>>>>>>>> migrated to start pinning all the memory.
> >>>>>>>>>
> >>>>>>>>> The proposal is to bind it to the char device life cycle (open =
vs
> >>>>>>>>> close),
> >>>>>>>> Hmmm, really? If it's the life cycle for char device, the next g=
uest /
> >>>>>>>> qemu launch on the same vhost-vdpa device node won't make it wor=
k.
> >>>>>>>>
> >>>>>>> Maybe my sentence was not accurate, but I think we're on the same=
 page here.
> >>>>>>>
> >>>>>>> Two qemu instances opening the same char device at the same time =
are
> >>>>>>> not allowed, and vhost_vdpa_release clean all the maps. So the ne=
xt
> >>>>>>> qemu that opens the char device should see a clean device anyway.
> >>>>>> I mean the pin can't be done at the time of char device open, wher=
e the
> >>>>>> user address space is not known/bound yet. The earliest point poss=
ible
> >>>>>> for pinning would be until the vhost_attach_mm() call from SET_OWN=
ER is
> >>>>>> done.
> >>>>> Maybe we are deviating, let me start again.
> >>>>>
> >>>>> Using QEMU code, what I'm proposing is to modify the lifecycle of t=
he
> >>>>> .listener member of struct vhost_vdpa.
> >>>>>
> >>>>> At this moment, the memory listener is registered at
> >>>>> vhost_vdpa_dev_start(dev, started=3Dtrue) call for the last vhost_d=
ev,
> >>>>> and is unregistered in both vhost_vdpa_reset_status and
> >>>>> vhost_vdpa_cleanup.
> >>>>>
> >>>>> My original proposal was just to move the memory listener registrat=
ion
> >>>>> to the last vhost_vdpa_init, and remove the unregister from
> >>>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap woul=
d
> >>>>> be the same, the device should not realize this change.
> >>>> This can address LM downtime latency for sure, but it won't help
> >>>> downtime during dynamic SVQ switch - which still needs to go through=
 the
> >>>> full unmap/map cycle (that includes the slow part for pinning) from
> >>>> passthrough to SVQ mode. Be noted not every device could work with a
> >>>> separate ASID for SVQ descriptors. The fix should expect to work on
> >>>> normal vDPA vendor devices without a separate descriptor ASID, with
> >>>> platform IOMMU underneath or with on-chip IOMMU.
> >>>>
> >>> At this moment the SVQ switch is very inefficient mapping-wise, as it
> >>> unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
> >>> allocated in low regions of the iova space, and then the guest memory
> >>> is allocated in this new IOVA region incrementally.
> >> Yep. The key to build this fast path for SVQ switching I think is to
> >> maintain the identity mapping for the passthrough queues so that QEMU
> >> can reuse the old mappings for guest memory (e.g. GIOVA identity mappe=
d
> >> to GPA) while incrementally adding new mappings for SVQ vrings.
> >>
> >>> We can optimize that if we place SVQ in a free GPA area instead.
> >> Here's a question though: it might not be hard to find a free GPA rang=
e
> >> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit
> >> ranges), but I'm not sure if easy to find a free GIOVA range for the
> >> vIOMMU case - particularly this has to work in the same entire 64bit
> >> IOVA address ranges that (for now) QEMU won't be able to "reserve" a
> >> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can =
be
> >> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu a=
nd
> >> virito-iommu) so that we can call it out as a generic means for SVQ
> >> switching optimization?
> >>
> > In the case vIOMMU allocates a new block we will use the same algorithm=
 as now:
> > * Find a new free IOVA chunk of the same size
> > * Map this new SVQ IOVA, that may or may not be the same as SVQ
> >
> > Since we must go through the translation phase to sanitize guest's
> > available descriptors anyway, it has zero added cost.
> Not sure I followed, this can work but doesn't seem able to reuse the
> old host kernel mappings for guest memory, hence still requires remap of
> the entire host IOVA ranges when SVQ IOVA comes along. I think by
> maintaining 1:1 identity map on guest memory, we don't have to bother
> tearing down existing HVA->HPA mappings in kernel thus save the
> expensive pinning calls at large. I don't clearly see under this scheme,
> how the new SVQ IOVA may work with potential conflict on IOVA space from
> hotplugged memory - in this case the 1:1 IOVA->GPA identity guest memory
> mapping can't be kept.
>

There is no need to maintain the 1:1 for memory mapped after the
pinning. The bigger reason to maintain them is to reduce the downtime
because of pinning. After that, we can reuse the method we're using at
this moment, looking for a new free hole for the new map. ew only need
to pin the new map.

> > Another option would be to move the SVQ vring to a new region, but I
> > don't see any advantage on maintaining 1:1 mapping at that point.
> See above. For pinning avoidance point of view (i.e. QEMU software
> optimization on SVQ switching downtime), I think it's crucial to
> maintain 1:1 mapping and move SVQ vring to a specific region. But I'm
> not sure how complex it will be for QEMU to get it implemented in a
> clean way.
>
> Thanks,
> -Siwei
>
> >
> >> If this QEMU/vIOMMU "hack" is not universally feasible, I would rather
> >> build a fast path in the kernel via a new vhost IOTLB command, say
> >> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
> >> (passthrough) mappings and update to use the SVQ ones in a single batc=
h,
> >> while keeping the pages for guest memory always pinned (the kernel wil=
l
> >> make this decision). This doesn't expose pinning to userspace, and can
> >> also fix downtime issue.
> >>
> >>>    All
> >>> of the "translations" still need to be done, to ensure the guest
> >>> doesn't have access to SVQ vring. That way, qemu will not send all th=
e
> >>> unmaps & maps, only the new ones. And vhost/vdpa does not need to cal=
l
> >>> unpin_user_page / pin_user_pages for all the guest memory.
> >>>
> >>> More optimizations include the batching of the SVQ vrings.
> >> Nods.
> >>
> >>>>> One of the concerns was that it could delay VM initialization, and =
I
> >>>>> didn't profile it but I think that may be the case.
> >>>> Yes, that's the concern here - we should not introduce regression to
> >>>> normal VM boot process/time. In case of large VM it's very easy to s=
ee
> >>>> the side effect if we go this way.
> >>>>
> >>>>>     I'm not sure about
> >>>>> the right fix but I think the change is easy to profile. If that is
> >>>>> the case, we could:
> >>>>> * use a flag (listener->address_space ?) and only register the
> >>>>> listener in _init if waiting for a migration, do it in _start
> >>>>> otherwise.
> >>>> Just doing this alone won't help SVQ mode switch downtime, see the
> >>>> reason stated above.
> >>>>
> >>>>> * something like io_uring, where the map can be done in parallel an=
d
> >>>>> we can fail _start if some of them fails.
> >>>> This can alleviate the problem somehow, but still sub-optimal and no=
t
> >>>> scalable with larger size. I'd like zero or least pinning to be done=
 at
> >>>> the SVQ switch or migration time.
> >>>>
> >>> To reduce even further the pinning at SVQ time we would need to
> >>> preallocate SVQ vrings before suspending the device.
> >> Yep. Preallocate SVQ vrings at the start of migration, but before
> >> suspending the device. This will work under the assumption that we can
> >> reserve or "steal" some ranges from the GPA or GIOVA space...
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>>>>> Actually I think the counterpart vhost_detach_mm() only gets
> >>>>>> handled in vhost_vdpa_release() at device close time is a resultin=
g
> >>>>>> artifact and amiss of today's vhost protocol - the opposite RESET_=
OWNER
> >>>>>> call is not made mandatory hence only seen implemented in vhost-ne=
t
> >>>>>> device today. One qemu instance could well exec(3) another new qem=
u
> >>>>>> instance to live upgrade itself while keeping all emulated devices=
 and
> >>>>>> guest alive. The current vhost design simply prohibits this from h=
appening.
> >>>>>>
> >>>>> Ok, I was not aware of this. Thanks for explaining it!
> >>>>>
> >>>>>>>>>       so all the guest memory can be pinned for all the guest /=
 qemu
> >>>>>>>>> lifecycle.
> >>>>>>>> I think to tie pinning to guest / qemu process life cycle makes =
more
> >>>>>>>> sense. Essentially this pinning part needs to be decoupled from =
the
> >>>>>>>> iotlb mapping abstraction layer, and can / should work as a stan=
dalone
> >>>>>>>> uAPI. Such that QEMU at the destination may launch and pin all g=
uest's
> >>>>>>>> memory as needed without having to start the device, while await=
ing any
> >>>>>>>> incoming migration request. Though problem is, there's no existi=
ng vhost
> >>>>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNE=
R /
> >>>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection a=
gainst
> >>>>>>>> introducing a new but clean vhost uAPI for pinning guest pages, =
subject
> >>>>>>>> to guest's life cycle?
> >>>>>>>>
> >>>>>>> I think that to pin or not pin memory maps should be a kernel
> >>>>>>> decision, not to be driven by qemu.
> >>>>>> It's kernel decision for sure. I am with this part.
> >>>>>>
> >>>>>>> I'm not against it if needed, but
> >>>>>>> let me know if the current "clean at close" address your concerns=
.
> >>>>>> To better facilitate QEMU exec (live update) case, I propose we ad=
d new
> >>>>>> vhost uAPI pair for explicit pinning request - which would live wi=
th
> >>>>>> user mm's, or more precisely qemu instance's lifecycle.
> >>>>>>
> >>>>> Ok I see your problem better now, but I think it should be solved a=
t
> >>>>> kernel level. Does that live update need to forcefully unpin and pi=
n
> >>>>> the memory again,
> >>>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
> >>>> downtime expectation. The exec(3)'d process should inherit the page
> >>>> pinning and/or mlock accounting from the original QEMU process, whil=
e
> >>>> keeping original page pinning intact. Physical page mappings for DMA=
 can
> >>>> be kept as is to avoid the need of reprogramming device, though in t=
his
> >>>> case the existing vhost iotlb entries should be updated to reflect t=
he
> >>>> new HVA in the exec(3)'d QEMU process.
> >>>>
> >>>>>     or that is just a consequence of how it works the
> >>>>> memory listener right now?
> >>>>>
> >>>>> Why not extend the RESET_OWNER to the rest of devices? It seems the
> >>>>> most natural way to me.
> >>>> Not sure, I think RESET_OWNER might be too heavy weighted to impleme=
nt
> >>>> live update, and people are not clear what the exact semantics are b=
y
> >>>> using it (which part of the device state is being reset, and how
> >>>> much)... In addition, people working on iommufd intended to make thi=
s a
> >>>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
> >>>>
> >>>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
> >>>>
> >>>> New uAPI to just change ownership of mm seems a better fit to me...
> >>>>
> >>> I'm not sure about the right solution here, but there are other
> >>> proposals to batch ioctls. But maybe creating a new one fits better.
> >>>
> >>> Thanks!
> >>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>> Thanks!
> >>>>>
> >>>>>
> >>>>>>>> Another concern is the use_va stuff, originally it tags to the d=
evice
> >>>>>>>> level and is made static at the time of device instantiation, wh=
ich is
> >>>>>>>> fine. But others to come just find a new home at per-group level=
 or
> >>>>>>>> per-vq level struct. Hard to tell whether or not pinning is actu=
ally
> >>>>>>>> needed for the latter use_va friends, as they are essentially ti=
ed to
> >>>>>>>> the virtio life cycle or feature negotiation. While guest / Qemu=
 starts
> >>>>>>>> way earlier than that. Perhaps just ignore those sub-device leve=
l use_va
> >>>>>>>> usages? Presumably !use_va at the device level is sufficient to =
infer
> >>>>>>>> the need of pinning for device?
> >>>>>>>>
> >>>>>>> I don't follow this. But I have the feeling that the subject of m=
y
> >>>>>>> original mail is way more accurate if I would have said just "mem=
ory
> >>>>>>> maps".
> >>>>>> I think the iotlb layer in vhost-vdpa just provides the abstractio=
n for
> >>>>>> mapping, not pinning. Although in some case mapping implicitly rel=
ies on
> >>>>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
> >>>>>> semantics. We can do explicit on-demand pinning for cases for e.g.
> >>>>>> warming up device at live migration destination.
> >>>>>>
> >>>>>>
> >>>>>>> I still consider the way to fix it is to actually delegate that t=
o the
> >>>>>>> kernel vdpa, so it can choose if a particular ASID needs the pin =
or
> >>>>>>> not. But let me know if I missed something.
> >>>>>> You can disregard this for now. I will discuss that further with y=
ou
> >>>>>> guys while bind_mm and per-group use_va stuffs are landed.
> >>>>>>
> >>>>>> Thanks!
> >>>>>> -Siwei
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> -Siwei
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> This has two main problems:
> >>>>>>>>> * At this moment the reset semantics forces the vdpa device to =
unmap
> >>>>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
> >>>>>>>>> * This may increase the initialization time. Maybe we can delay=
 it if
> >>>>>>>>> qemu is not the destination of a LM. Anyway I think this should=
 be
> >>>>>>>>> done as an optimization on top.
> >>>>>>>>>
> >>>>>>>>> Any ideas or comments in this regard?
> >>>>>>>>>
> >>>>>>>>> Thanks!
> >>>>>>>>>
>


