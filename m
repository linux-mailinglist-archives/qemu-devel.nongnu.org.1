Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08DE76CD47
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 14:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRBC4-0004lv-Od; Wed, 02 Aug 2023 08:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qRBC0-0004lk-Ie
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qRBBw-0008Pc-At
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690980182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAdaRkGDpOvoDHOj7UdrHnvqVfznFW9cvko7/EDbTL0=;
 b=BroF3rcrskqRNMfsfrqHEs2sfNJ3Yy4zR5WTEe1SDrJqiJNnJ1tO0IdCpHEjYYWXvHy+b3
 inse94dJMGtwO4Vhh0PkgQ+6PnF5mahRbUakXp9mG6Qoa3vZADz2aPe0yMp2EiB4adDZV5
 MSQ6tro8GdztxVXDirXu4ynQZhe95S8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-XmhPD_YfMTGpMQ6uhkWmqA-1; Wed, 02 Aug 2023 08:43:01 -0400
X-MC-Unique: XmhPD_YfMTGpMQ6uhkWmqA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5840ea40c59so82247027b3.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 05:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690980180; x=1691584980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAdaRkGDpOvoDHOj7UdrHnvqVfznFW9cvko7/EDbTL0=;
 b=fs6lsr2vXmq2hvO2cJFHt0bWJumqFo0azn953KSWk89EEMYjsi9wIQGbBnPXINN5Qe
 NG4HYOwhl5RLhYnI++I3IWih8mXAb0FpYFPuMsFv6A2XhNXiX1LkqkOocJuPpqOL8tse
 IkwJZsfAB78sctHYC3vlw2owcwIV5alyWiuwvKjrHQBOAAuQ1TCqRjayB04++uKuEOGQ
 Aim4vgARvAw2iXhABew342Pp4b0VLt4Tav3rPMjMt4oGd++8wRSVM8UBKRY0GMW9zwON
 l9gNnH/P2KtuEa3MibNrLAVweLZ6YRQRs/2nnHF6DqnG0w6VH0XTTj7KYioZm/7oxHmc
 Wdtw==
X-Gm-Message-State: ABy/qLZ4nYpJPkLYq+mviEOmB5PjGFoVLO5+x+LSRXHHXNSIeM7RtMPt
 6Z20OJhISieDDRHEdzbPHXVwF5WjOBKrOTeuYDnmvIOsBVgcBukbyijSXGVGMTuBR959eIjKJAf
 ZwuZFRkoNUTwOvL9ZsnRZjj8DIcEZ2DU=
X-Received: by 2002:a25:d610:0:b0:d0e:fc28:3777 with SMTP id
 n16-20020a25d610000000b00d0efc283777mr14927493ybg.9.1690980180152; 
 Wed, 02 Aug 2023 05:43:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1GmOZjz7GoBQHhu8if7urUw/ZpO7bjrjayXGRigxfxLRKV4Y8Mfa6tinpEJxrsfaf6Cfhrku5IuzZ+PcHMSc=
X-Received: by 2002:a25:d610:0:b0:d0e:fc28:3777 with SMTP id
 n16-20020a25d610000000b00d0efc283777mr14927463ybg.9.1690980179526; Wed, 02
 Aug 2023 05:42:59 -0700 (PDT)
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
 <CAJaqyWd-Zbe3dSo_biV7z_gQ=stk738B1qS6R8cnoz2RR_awHg@mail.gmail.com>
 <8f3d011a-457f-a104-e7a8-4a3e430acd5e@oracle.com>
 <CAJaqyWdaHmDHoZ4SuxsJdNgvh18jMoZkEgC8dhCB7NGZM-S5wg@mail.gmail.com>
 <f55d3d5a-e524-c1e2-1b00-c7f4dc6dc886@oracle.com>
In-Reply-To: <f55d3d5a-e524-c1e2-1b00-c7f4dc6dc886@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Aug 2023 14:42:23 +0200
Message-ID: <CAJaqyWcZFZ_pSWaCcaatc9X=8c+enUEmht9PEb0Wo1R77CjJWw@mail.gmail.com>
Subject: Re: Reducing vdpa migration downtime because of memory pin / maps
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, Longpeng <longpeng2@huawei.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eli Cohen <elic@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, Juan Quintela <quintela@redhat.com>, 
 David Gilbert <dgilbert@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 20, 2023 at 2:49=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 7/19/2023 3:40 AM, Eugenio Perez Martin wrote:
> > On Mon, Jul 17, 2023 at 9:57=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Hey,
> >>
> >> I am now back from the break. Sorry for the delayed response, please s=
ee
> >> in line.
> >>
> >> On 7/9/2023 11:04 PM, Eugenio Perez Martin wrote:
> >>> On Sat, Jul 8, 2023 at 11:14=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 7/5/2023 10:46 PM, Eugenio Perez Martin wrote:
> >>>>> On Thu, Jul 6, 2023 at 2:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>>> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Tue, Jun 27, 2023 at 8:36=E2=80=AFAM Si-Wei Liu <si-wei.liu@or=
acle.com> wrote:
> >>>>>>>> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
> >>>>>>>>> On Fri, Jun 9, 2023 at 12:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@=
oracle.com> wrote:
> >>>>>>>>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> >>>>>>>>>>> On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.li=
u@oracle.com> wrote:
> >>>>>>>>>>>> Sorry for reviving this old thread, I lost the best timing t=
o follow up
> >>>>>>>>>>>> on this while I was on vacation. I have been working on this=
 and found
> >>>>>>>>>>>> out some discrepancy, please see below.
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>>>>>>>>>>>> Hi!
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> As mentioned in the last upstream virtio-networking meeting=
, one of
> >>>>>>>>>>>>> the factors that adds more downtime to migration is the han=
dling of
> >>>>>>>>>>>>> the guest memory (pin, map, etc). At this moment this handl=
ing is
> >>>>>>>>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that =
sense, the
> >>>>>>>>>>>>> destination device waits until all the guest memory / state=
 is
> >>>>>>>>>>>>> migrated to start pinning all the memory.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The proposal is to bind it to the char device life cycle (o=
pen vs
> >>>>>>>>>>>>> close),
> >>>>>>>>>>>> Hmmm, really? If it's the life cycle for char device, the ne=
xt guest /
> >>>>>>>>>>>> qemu launch on the same vhost-vdpa device node won't make it=
 work.
> >>>>>>>>>>>>
> >>>>>>>>>>> Maybe my sentence was not accurate, but I think we're on the =
same page here.
> >>>>>>>>>>>
> >>>>>>>>>>> Two qemu instances opening the same char device at the same t=
ime are
> >>>>>>>>>>> not allowed, and vhost_vdpa_release clean all the maps. So th=
e next
> >>>>>>>>>>> qemu that opens the char device should see a clean device any=
way.
> >>>>>>>>>> I mean the pin can't be done at the time of char device open, =
where the
> >>>>>>>>>> user address space is not known/bound yet. The earliest point =
possible
> >>>>>>>>>> for pinning would be until the vhost_attach_mm() call from SET=
_OWNER is
> >>>>>>>>>> done.
> >>>>>>>>> Maybe we are deviating, let me start again.
> >>>>>>>>>
> >>>>>>>>> Using QEMU code, what I'm proposing is to modify the lifecycle =
of the
> >>>>>>>>> .listener member of struct vhost_vdpa.
> >>>>>>>>>
> >>>>>>>>> At this moment, the memory listener is registered at
> >>>>>>>>> vhost_vdpa_dev_start(dev, started=3Dtrue) call for the last vho=
st_dev,
> >>>>>>>>> and is unregistered in both vhost_vdpa_reset_status and
> >>>>>>>>> vhost_vdpa_cleanup.
> >>>>>>>>>
> >>>>>>>>> My original proposal was just to move the memory listener regis=
tration
> >>>>>>>>> to the last vhost_vdpa_init, and remove the unregister from
> >>>>>>>>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap =
would
> >>>>>>>>> be the same, the device should not realize this change.
> >>>>>>>> This can address LM downtime latency for sure, but it won't help
> >>>>>>>> downtime during dynamic SVQ switch - which still needs to go thr=
ough the
> >>>>>>>> full unmap/map cycle (that includes the slow part for pinning) f=
rom
> >>>>>>>> passthrough to SVQ mode. Be noted not every device could work wi=
th a
> >>>>>>>> separate ASID for SVQ descriptors. The fix should expect to work=
 on
> >>>>>>>> normal vDPA vendor devices without a separate descriptor ASID, w=
ith
> >>>>>>>> platform IOMMU underneath or with on-chip IOMMU.
> >>>>>>>>
> >>>>>>> At this moment the SVQ switch is very inefficient mapping-wise, a=
s it
> >>>>>>> unmap all the GPA->HVA maps and overrides it. In particular, SVQ =
is
> >>>>>>> allocated in low regions of the iova space, and then the guest me=
mory
> >>>>>>> is allocated in this new IOVA region incrementally.
> >>>>>> Yep. The key to build this fast path for SVQ switching I think is =
to
> >>>>>> maintain the identity mapping for the passthrough queues so that Q=
EMU
> >>>>>> can reuse the old mappings for guest memory (e.g. GIOVA identity m=
apped
> >>>>>> to GPA) while incrementally adding new mappings for SVQ vrings.
> >>>>>>
> >>>>>>> We can optimize that if we place SVQ in a free GPA area instead.
> >>>>>> Here's a question though: it might not be hard to find a free GPA =
range
> >>>>>> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52=
bit
> >>>>>> ranges), but I'm not sure if easy to find a free GIOVA range for t=
he
> >>>>>> vIOMMU case - particularly this has to work in the same entire 64b=
it
> >>>>>> IOVA address ranges that (for now) QEMU won't be able to "reserve"=
 a
> >>>>>> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this =
can be
> >>>>>> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm sm=
mu and
> >>>>>> virito-iommu) so that we can call it out as a generic means for SV=
Q
> >>>>>> switching optimization?
> >>>>>>
> >>>>> In the case vIOMMU allocates a new block we will use the same algor=
ithm as now:
> >>>>> * Find a new free IOVA chunk of the same size
> >>>>> * Map this new SVQ IOVA, that may or may not be the same as SVQ
> >>>>>
> >>>>> Since we must go through the translation phase to sanitize guest's
> >>>>> available descriptors anyway, it has zero added cost.
> >>>> Not sure I followed, this can work but doesn't seem able to reuse th=
e
> >>>> old host kernel mappings for guest memory, hence still requires rema=
p of
> >>>> the entire host IOVA ranges when SVQ IOVA comes along. I think by
> >>>> maintaining 1:1 identity map on guest memory, we don't have to bothe=
r
> >>>> tearing down existing HVA->HPA mappings in kernel thus save the
> >>>> expensive pinning calls at large. I don't clearly see under this sch=
eme,
> >>>> how the new SVQ IOVA may work with potential conflict on IOVA space =
from
> >>>> hotplugged memory - in this case the 1:1 IOVA->GPA identity guest me=
mory
> >>>> mapping can't be kept.
> >>>>
> >>> There is no need to maintain the 1:1 for memory mapped after the
> >>> pinning. The bigger reason to maintain them is to reduce the downtime
> >>> because of pinning.
> >> Yes, if guest users don't care about SVQ switching downtime there's no
> >> need to maintain 1:1, and SVQ translation like today should work for
> >> them. However most live migration users who care about downtime during
> >> live migration also care about the downtime for SVQ switching - you
> >> don't want to say that brownout time like 300ms or so in the mid of li=
ve
> >> migration at the cost of complete service loss of 4 to 5 seconds at th=
e
> >> start of migration is a win to them. What I said above has the
> >> presumption that we both are looking at (the possibility of) a
> >> generic/software way to optimize/reduce pinning overhead on the downti=
me
> >> - say what can be done at QEMU level or host kernel to avoid pinning (=
at
> >> SVQ switch) rather than put burden on every hardware vendor to impleme=
nt
> >> a separate ASID for SVQ.
> >>
> > Your assumption is right, let's talk in the example as I think it
> > would be easier to continue this.
> >
> >>> After that, we can reuse the method we're using at
> >>> this moment, looking for a new free hole for the new map. ew only nee=
d
> >>> to pin the new map.
> >> Consider this sequence:
> >> - initially host device uses original GPA for guest memory mapping
> >> - live migration starts off, QEMU's iova tree maps guest memory GPA 1:=
1
> >> to IOVA
> > GPA is already mapped & pinned, there is no need to map it again. all
> > the remapping is done at the moment, and what I'm proposing is to not
> > to do so.
> Right, depending on the specific term but what I was saying is IOVA to
> GPA translation in QEMU's IOVA tree is 1:1 as is.
> >
> >> - SVQ new maps allocated from a free hole on iova tree that happen to
> >> fall just above the IOVA range for guest memory GPA
> >> - new memory hot plugged to guest while migration is still going on in
> >> source host. although this hot plugged memory region sits right above
> >> the guest memory blocks in guest memory space (GPA), it will get new m=
ap
> >> in a separate range (not 1:1 mapped to GPA any more!) from the QEMU io=
va
> >> tree. Since QEMU mediates and translates virtqueue access to memory vi=
a
> >> SVQ (all guest memory maps to the same IOVA for SVQ), so far so good
> >> - for some reason live migration fails before VM is able to be migrate=
d
> >> to the destination host, VM has to resume from the source host immedia=
tely
> >> - since live migration had failed, QEMU will unmap SVQ vrings from the
> >> IOVA tree and then stop shadowing virtqueue access
> >> - the host vDPA device now has incorrect passthrough GPA mapping for t=
he
> >> part of newly plugged guest memory, as that belongs to the IOVA range
> >> where SVQ translation is in use
> >>
> > I'm assuming we can also support <300ms downtime in that case of
> > memory hotplug, and that the pin / unpin of SVQ regions is bearable.
> >
> > As a first step, we can also move the SVQ vrings IOVA in the event of
> > hot-plugging memory. but that would require a restart of the device
> > unless RING_RESET is supported. Would that improve the situation?
> Hmmm, this may help somehow but restart happens to run conflict with our
> goal to remove any (device) reset in favor of suspend&resume for better
> downtime at LM migration source, and in this case SVQ vring movement as
> well. As mentioned in the meeting, device/ring reset usually falls on
> the hardware slow path, reset latency grows linearly with number of
> queues. It's still being evaluated what will work best on the specific
> hardware, but just want to let you aware that we'd like to get rid of
> any latent scalability blocker from the performance path.

So, summarizing the flow for switching to SVQ:
a. Suspend all the device, so we can fetch vq state etc.
b. Get the vq descriptor table group with the new
VHOST_VDPA_GET_VRING_DESC_GROUP.
c. Set the vq group of all descriptors table to ASID 1
d. Reset and set the new address of each vq with _F_RING_RESET. I
think the standard mandates to set all the parameters again, but only
the vq address will be different.
e. re-enable all the vqs
f. Resume the device.

To reduce the overhead per vq, maybe we can also be smarter in the
qemu side of this switch and not change vring IOVA addresses. That
would allow us to get rid of steps d and e. Only the ASID of the
groups of the descriptor tables should be changed, and they might be
just 1 group.

The question now is, it is allowed to change a group ASID after
DRIVER_OK? I guess yes, the same way we can map and unmap memory after
it.

As a first baby step, maybe we can just add the different vring asid,
even resetting the whole device. This would allow us to validate both
device and qemu in this aspect.

Thanks!

> > Another solution is to effectively be smarter in the case of a DMA
> > remap, and not unpin memory that is going to be pin anyway.
> Yes, that's the goal, though not sure what the "smarter" solution that
> could be. Does it look like what I said below with complex IOVA tree tric=
k?
>
> Thanks,
> -Siwei
> >
> >> Although it might not be easy for SVQ vrings and plugged memory to
> >> collide on the same GPA/IOVA range, this is something we should preven=
t
> >> from happening in the first place I'd assume. You can say we only look
> >> from higher IOVA ranges to map SVQ so that the lower range can be
> >> reserved for latent hot plug memory, but this still needs complicated
> >> implementation to deal with IOVA range fragmentation and special
> >> collision prevention from breaking the 1:1 map to guest memory space.
> >>
> >> Regards,
> >> -Siwei
> >>
> >>>>> Another option would be to move the SVQ vring to a new region, but =
I
> >>>>> don't see any advantage on maintaining 1:1 mapping at that point.
> >>>> See above. For pinning avoidance point of view (i.e. QEMU software
> >>>> optimization on SVQ switching downtime), I think it's crucial to
> >>>> maintain 1:1 mapping and move SVQ vring to a specific region. But I'=
m
> >>>> not sure how complex it will be for QEMU to get it implemented in a
> >>>> clean way.
> >>>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>>> If this QEMU/vIOMMU "hack" is not universally feasible, I would ra=
ther
> >>>>>> build a fast path in the kernel via a new vhost IOTLB command, say
> >>>>>> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
> >>>>>> (passthrough) mappings and update to use the SVQ ones in a single =
batch,
> >>>>>> while keeping the pages for guest memory always pinned (the kernel=
 will
> >>>>>> make this decision). This doesn't expose pinning to userspace, and=
 can
> >>>>>> also fix downtime issue.
> >>>>>>
> >>>>>>>      All
> >>>>>>> of the "translations" still need to be done, to ensure the guest
> >>>>>>> doesn't have access to SVQ vring. That way, qemu will not send al=
l the
> >>>>>>> unmaps & maps, only the new ones. And vhost/vdpa does not need to=
 call
> >>>>>>> unpin_user_page / pin_user_pages for all the guest memory.
> >>>>>>>
> >>>>>>> More optimizations include the batching of the SVQ vrings.
> >>>>>> Nods.
> >>>>>>
> >>>>>>>>> One of the concerns was that it could delay VM initialization, =
and I
> >>>>>>>>> didn't profile it but I think that may be the case.
> >>>>>>>> Yes, that's the concern here - we should not introduce regressio=
n to
> >>>>>>>> normal VM boot process/time. In case of large VM it's very easy =
to see
> >>>>>>>> the side effect if we go this way.
> >>>>>>>>
> >>>>>>>>>       I'm not sure about
> >>>>>>>>> the right fix but I think the change is easy to profile. If tha=
t is
> >>>>>>>>> the case, we could:
> >>>>>>>>> * use a flag (listener->address_space ?) and only register the
> >>>>>>>>> listener in _init if waiting for a migration, do it in _start
> >>>>>>>>> otherwise.
> >>>>>>>> Just doing this alone won't help SVQ mode switch downtime, see t=
he
> >>>>>>>> reason stated above.
> >>>>>>>>
> >>>>>>>>> * something like io_uring, where the map can be done in paralle=
l and
> >>>>>>>>> we can fail _start if some of them fails.
> >>>>>>>> This can alleviate the problem somehow, but still sub-optimal an=
d not
> >>>>>>>> scalable with larger size. I'd like zero or least pinning to be =
done at
> >>>>>>>> the SVQ switch or migration time.
> >>>>>>>>
> >>>>>>> To reduce even further the pinning at SVQ time we would need to
> >>>>>>> preallocate SVQ vrings before suspending the device.
> >>>>>> Yep. Preallocate SVQ vrings at the start of migration, but before
> >>>>>> suspending the device. This will work under the assumption that we=
 can
> >>>>>> reserve or "steal" some ranges from the GPA or GIOVA space...
> >>>>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>>>>> Actually I think the counterpart vhost_detach_mm() only gets
> >>>>>>>>>> handled in vhost_vdpa_release() at device close time is a resu=
lting
> >>>>>>>>>> artifact and amiss of today's vhost protocol - the opposite RE=
SET_OWNER
> >>>>>>>>>> call is not made mandatory hence only seen implemented in vhos=
t-net
> >>>>>>>>>> device today. One qemu instance could well exec(3) another new=
 qemu
> >>>>>>>>>> instance to live upgrade itself while keeping all emulated dev=
ices and
> >>>>>>>>>> guest alive. The current vhost design simply prohibits this fr=
om happening.
> >>>>>>>>>>
> >>>>>>>>> Ok, I was not aware of this. Thanks for explaining it!
> >>>>>>>>>
> >>>>>>>>>>>>>         so all the guest memory can be pinned for all the g=
uest / qemu
> >>>>>>>>>>>>> lifecycle.
> >>>>>>>>>>>> I think to tie pinning to guest / qemu process life cycle ma=
kes more
> >>>>>>>>>>>> sense. Essentially this pinning part needs to be decoupled f=
rom the
> >>>>>>>>>>>> iotlb mapping abstraction layer, and can / should work as a =
standalone
> >>>>>>>>>>>> uAPI. Such that QEMU at the destination may launch and pin a=
ll guest's
> >>>>>>>>>>>> memory as needed without having to start the device, while a=
waiting any
> >>>>>>>>>>>> incoming migration request. Though problem is, there's no ex=
isting vhost
> >>>>>>>>>>>> uAPI that could properly serve as the vehicle for that. SET_=
OWNER /
> >>>>>>>>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objecti=
on against
> >>>>>>>>>>>> introducing a new but clean vhost uAPI for pinning guest pag=
es, subject
> >>>>>>>>>>>> to guest's life cycle?
> >>>>>>>>>>>>
> >>>>>>>>>>> I think that to pin or not pin memory maps should be a kernel
> >>>>>>>>>>> decision, not to be driven by qemu.
> >>>>>>>>>> It's kernel decision for sure. I am with this part.
> >>>>>>>>>>
> >>>>>>>>>>> I'm not against it if needed, but
> >>>>>>>>>>> let me know if the current "clean at close" address your conc=
erns.
> >>>>>>>>>> To better facilitate QEMU exec (live update) case, I propose w=
e add new
> >>>>>>>>>> vhost uAPI pair for explicit pinning request - which would liv=
e with
> >>>>>>>>>> user mm's, or more precisely qemu instance's lifecycle.
> >>>>>>>>>>
> >>>>>>>>> Ok I see your problem better now, but I think it should be solv=
ed at
> >>>>>>>>> kernel level. Does that live update need to forcefully unpin an=
d pin
> >>>>>>>>> the memory again,
> >>>>>>>> No, it should avoid the unpin&pin cycle, otherwise it'd defeat t=
he
> >>>>>>>> downtime expectation. The exec(3)'d process should inherit the p=
age
> >>>>>>>> pinning and/or mlock accounting from the original QEMU process, =
while
> >>>>>>>> keeping original page pinning intact. Physical page mappings for=
 DMA can
> >>>>>>>> be kept as is to avoid the need of reprogramming device, though =
in this
> >>>>>>>> case the existing vhost iotlb entries should be updated to refle=
ct the
> >>>>>>>> new HVA in the exec(3)'d QEMU process.
> >>>>>>>>
> >>>>>>>>>       or that is just a consequence of how it works the
> >>>>>>>>> memory listener right now?
> >>>>>>>>>
> >>>>>>>>> Why not extend the RESET_OWNER to the rest of devices? It seems=
 the
> >>>>>>>>> most natural way to me.
> >>>>>>>> Not sure, I think RESET_OWNER might be too heavy weighted to imp=
lement
> >>>>>>>> live update, and people are not clear what the exact semantics a=
re by
> >>>>>>>> using it (which part of the device state is being reset, and how
> >>>>>>>> much)... In addition, people working on iommufd intended to make=
 this a
> >>>>>>>> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OW=
NER:
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
> >>>>>>>>
> >>>>>>>> New uAPI to just change ownership of mm seems a better fit to me=
...
> >>>>>>>>
> >>>>>>> I'm not sure about the right solution here, but there are other
> >>>>>>> proposals to batch ioctls. But maybe creating a new one fits bett=
er.
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -Siwei
> >>>>>>>>
> >>>>>>>>> Thanks!
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>>> Another concern is the use_va stuff, originally it tags to t=
he device
> >>>>>>>>>>>> level and is made static at the time of device instantiation=
, which is
> >>>>>>>>>>>> fine. But others to come just find a new home at per-group l=
evel or
> >>>>>>>>>>>> per-vq level struct. Hard to tell whether or not pinning is =
actually
> >>>>>>>>>>>> needed for the latter use_va friends, as they are essentiall=
y tied to
> >>>>>>>>>>>> the virtio life cycle or feature negotiation. While guest / =
Qemu starts
> >>>>>>>>>>>> way earlier than that. Perhaps just ignore those sub-device =
level use_va
> >>>>>>>>>>>> usages? Presumably !use_va at the device level is sufficient=
 to infer
> >>>>>>>>>>>> the need of pinning for device?
> >>>>>>>>>>>>
> >>>>>>>>>>> I don't follow this. But I have the feeling that the subject =
of my
> >>>>>>>>>>> original mail is way more accurate if I would have said just =
"memory
> >>>>>>>>>>> maps".
> >>>>>>>>>> I think the iotlb layer in vhost-vdpa just provides the abstra=
ction for
> >>>>>>>>>> mapping, not pinning. Although in some case mapping implicitly=
 relies on
> >>>>>>>>>> pinning for DMA purpose, it doesn't have to tie to that in uAP=
I
> >>>>>>>>>> semantics. We can do explicit on-demand pinning for cases for =
e.g.
> >>>>>>>>>> warming up device at live migration destination.
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> I still consider the way to fix it is to actually delegate th=
at to the
> >>>>>>>>>>> kernel vdpa, so it can choose if a particular ASID needs the =
pin or
> >>>>>>>>>>> not. But let me know if I missed something.
> >>>>>>>>>> You can disregard this for now. I will discuss that further wi=
th you
> >>>>>>>>>> guys while bind_mm and per-group use_va stuffs are landed.
> >>>>>>>>>>
> >>>>>>>>>> Thanks!
> >>>>>>>>>> -Siwei
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> Thanks!
> >>>>>>>>>>>
> >>>>>>>>>>>> Regards,
> >>>>>>>>>>>> -Siwei
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> This has two main problems:
> >>>>>>>>>>>>> * At this moment the reset semantics forces the vdpa device=
 to unmap
> >>>>>>>>>>>>> all the memory. So this change needs a vhost vdpa feature f=
lag.
> >>>>>>>>>>>>> * This may increase the initialization time. Maybe we can d=
elay it if
> >>>>>>>>>>>>> qemu is not the destination of a LM. Anyway I think this sh=
ould be
> >>>>>>>>>>>>> done as an optimization on top.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Any ideas or comments in this regard?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Thanks!
> >>>>>>>>>>>>>
>


