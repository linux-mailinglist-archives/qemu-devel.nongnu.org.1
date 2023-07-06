Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D6749511
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 07:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHHq0-00060b-Q0; Thu, 06 Jul 2023 01:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHHpt-00060F-2Q
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qHHpq-0005wJ-0h
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 01:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688622440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ooDMQGOR3dXb720VlTQu+TVDvIUMdLy+L1SwQYCr7o=;
 b=HqAN8KUZunJU4Kfmx7HKZ5cl7ykNDX5FaJi9MZnJWe4/c4md8caDHhk+1VoHPFZGm4yX/X
 Z/qc68F9kg3hFmStRhnnNxp+aZ7t0RfPThP177/+wHnKA9uXmymMsfpLCep0ZqN4Mfmyzo
 aLrBr5PU6oDzXwgtWSBnB5q8Jwy8h5Y=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-RxxqJnVYO6qlY69WmtXogA-1; Thu, 06 Jul 2023 01:47:19 -0400
X-MC-Unique: RxxqJnVYO6qlY69WmtXogA-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-570553a18deso4156747b3.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 22:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688622438; x=1691214438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ooDMQGOR3dXb720VlTQu+TVDvIUMdLy+L1SwQYCr7o=;
 b=lW1x4jh0M6Q/gu9lICYK3hUzNgtxYL5Rz1Vhf/BpEw3i28OeQojDqvT+0YUUGlrj4e
 6kaHqsA+SWWCbTljLROLzmBpQC+WDv+L53VNkPQEECpnMYM45IDt1C85d30fNdP+rSWO
 3qqZ7TMkxNPqlurN0tbN1h1B89ETIyAWxDjKm6vNsG/es72SfumjWkrSsc+gUS2+pVXe
 pJ/EDt/ngLSzLLygtS5jPJk9Lt343DruapT+jiSYEQvmQ1MCKEOZOyWiU8B2HoMSnVh+
 wAd46ugsnRYsMglKazo/1Ufew97f1volnTw9L922ax2S54l4vWeI1H7CS8rWZzAfh4YQ
 zyWw==
X-Gm-Message-State: ABy/qLY7wIkPXOlMpo7EXJV7+T0BgE+1ePVem7856XT2w0EUhyulcwYP
 JynhHEtCcsO6GzJI70VOCDEzuBbZ2G+P6PAhsGZCgsKGcyvl41b0QFwodVSa8NM+Ick5xmj0cLz
 QKL36hZK4K6Q2IeMjkz3VRrPZgHdXBkQ=
X-Received: by 2002:a25:9c42:0:b0:c67:5adb:36fc with SMTP id
 x2-20020a259c42000000b00c675adb36fcmr869508ybo.38.1688622438284; 
 Wed, 05 Jul 2023 22:47:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBZzSeIOg/7JUsU7F5Sgf2b43q+rpNs9Msy5nGT8unoZVSLl5MYFV+yhmdLO1NatUdjksHm8quABPaMOnLKs8=
X-Received: by 2002:a25:9c42:0:b0:c67:5adb:36fc with SMTP id
 x2-20020a259c42000000b00c675adb36fcmr869492ybo.38.1688622437878; Wed, 05 Jul
 2023 22:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
 <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
 <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
In-Reply-To: <a73797a7-a71d-9ac9-f92b-6bfad2c79058@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 6 Jul 2023 07:46:41 +0200
Message-ID: <CAJaqyWcDLG3zG3-4Ht=ebWh-yAXY=srazwuOv1jy3sR-+dPfqg@mail.gmail.com>
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

On Thu, Jul 6, 2023 at 2:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 7/5/2023 11:03 AM, Eugenio Perez Martin wrote:
> > On Tue, Jun 27, 2023 at 8:36=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
> >>> On Fri, Jun 9, 2023 at 12:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> >>>>> On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> Sorry for reviving this old thread, I lost the best timing to foll=
ow up
> >>>>>> on this while I was on vacation. I have been working on this and f=
ound
> >>>>>> out some discrepancy, please see below.
> >>>>>>
> >>>>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>>>>>> Hi!
> >>>>>>>
> >>>>>>> As mentioned in the last upstream virtio-networking meeting, one =
of
> >>>>>>> the factors that adds more downtime to migration is the handling =
of
> >>>>>>> the guest memory (pin, map, etc). At this moment this handling is
> >>>>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense,=
 the
> >>>>>>> destination device waits until all the guest memory / state is
> >>>>>>> migrated to start pinning all the memory.
> >>>>>>>
> >>>>>>> The proposal is to bind it to the char device life cycle (open vs
> >>>>>>> close),
> >>>>>> Hmmm, really? If it's the life cycle for char device, the next gue=
st /
> >>>>>> qemu launch on the same vhost-vdpa device node won't make it work.
> >>>>>>
> >>>>> Maybe my sentence was not accurate, but I think we're on the same p=
age here.
> >>>>>
> >>>>> Two qemu instances opening the same char device at the same time ar=
e
> >>>>> not allowed, and vhost_vdpa_release clean all the maps. So the next
> >>>>> qemu that opens the char device should see a clean device anyway.
> >>>> I mean the pin can't be done at the time of char device open, where =
the
> >>>> user address space is not known/bound yet. The earliest point possib=
le
> >>>> for pinning would be until the vhost_attach_mm() call from SET_OWNER=
 is
> >>>> done.
> >>> Maybe we are deviating, let me start again.
> >>>
> >>> Using QEMU code, what I'm proposing is to modify the lifecycle of the
> >>> .listener member of struct vhost_vdpa.
> >>>
> >>> At this moment, the memory listener is registered at
> >>> vhost_vdpa_dev_start(dev, started=3Dtrue) call for the last vhost_dev=
,
> >>> and is unregistered in both vhost_vdpa_reset_status and
> >>> vhost_vdpa_cleanup.
> >>>
> >>> My original proposal was just to move the memory listener registratio=
n
> >>> to the last vhost_vdpa_init, and remove the unregister from
> >>> vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
> >>> be the same, the device should not realize this change.
> >> This can address LM downtime latency for sure, but it won't help
> >> downtime during dynamic SVQ switch - which still needs to go through t=
he
> >> full unmap/map cycle (that includes the slow part for pinning) from
> >> passthrough to SVQ mode. Be noted not every device could work with a
> >> separate ASID for SVQ descriptors. The fix should expect to work on
> >> normal vDPA vendor devices without a separate descriptor ASID, with
> >> platform IOMMU underneath or with on-chip IOMMU.
> >>
> > At this moment the SVQ switch is very inefficient mapping-wise, as it
> > unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
> > allocated in low regions of the iova space, and then the guest memory
> > is allocated in this new IOVA region incrementally.
> Yep. The key to build this fast path for SVQ switching I think is to
> maintain the identity mapping for the passthrough queues so that QEMU
> can reuse the old mappings for guest memory (e.g. GIOVA identity mapped
> to GPA) while incrementally adding new mappings for SVQ vrings.
>
> >
> > We can optimize that if we place SVQ in a free GPA area instead.
> Here's a question though: it might not be hard to find a free GPA range
> for the non-vIOMMU case (allocate iova from beyond the 48bit or 52bit
> ranges), but I'm not sure if easy to find a free GIOVA range for the
> vIOMMU case - particularly this has to work in the same entire 64bit
> IOVA address ranges that (for now) QEMU won't be able to "reserve" a
> specific IOVA ranges for SVQ from the vIOMMU. Do you foresee this can be
> done for every QEMU emulated vIOMMU (intel-iommu amd-iommu, arm smmu and
> virito-iommu) so that we can call it out as a generic means for SVQ
> switching optimization?
>

In the case vIOMMU allocates a new block we will use the same algorithm as =
now:
* Find a new free IOVA chunk of the same size
* Map this new SVQ IOVA, that may or may not be the same as SVQ

Since we must go through the translation phase to sanitize guest's
available descriptors anyway, it has zero added cost.

Another option would be to move the SVQ vring to a new region, but I
don't see any advantage on maintaining 1:1 mapping at that point.

> If this QEMU/vIOMMU "hack" is not universally feasible, I would rather
> build a fast path in the kernel via a new vhost IOTLB command, say
> INVALIDATE_AND_UPDATE_ALL, to atomically flush all existing
> (passthrough) mappings and update to use the SVQ ones in a single batch,
> while keeping the pages for guest memory always pinned (the kernel will
> make this decision). This doesn't expose pinning to userspace, and can
> also fix downtime issue.
>
> >   All
> > of the "translations" still need to be done, to ensure the guest
> > doesn't have access to SVQ vring. That way, qemu will not send all the
> > unmaps & maps, only the new ones. And vhost/vdpa does not need to call
> > unpin_user_page / pin_user_pages for all the guest memory.
> >
> > More optimizations include the batching of the SVQ vrings.
> Nods.
>
> >
> >>> One of the concerns was that it could delay VM initialization, and I
> >>> didn't profile it but I think that may be the case.
> >> Yes, that's the concern here - we should not introduce regression to
> >> normal VM boot process/time. In case of large VM it's very easy to see
> >> the side effect if we go this way.
> >>
> >>>    I'm not sure about
> >>> the right fix but I think the change is easy to profile. If that is
> >>> the case, we could:
> >>> * use a flag (listener->address_space ?) and only register the
> >>> listener in _init if waiting for a migration, do it in _start
> >>> otherwise.
> >> Just doing this alone won't help SVQ mode switch downtime, see the
> >> reason stated above.
> >>
> >>> * something like io_uring, where the map can be done in parallel and
> >>> we can fail _start if some of them fails.
> >> This can alleviate the problem somehow, but still sub-optimal and not
> >> scalable with larger size. I'd like zero or least pinning to be done a=
t
> >> the SVQ switch or migration time.
> >>
> > To reduce even further the pinning at SVQ time we would need to
> > preallocate SVQ vrings before suspending the device.
> Yep. Preallocate SVQ vrings at the start of migration, but before
> suspending the device. This will work under the assumption that we can
> reserve or "steal" some ranges from the GPA or GIOVA space...
>
> Thanks,
> -Siwei
>
> >
> >>>> Actually I think the counterpart vhost_detach_mm() only gets
> >>>> handled in vhost_vdpa_release() at device close time is a resulting
> >>>> artifact and amiss of today's vhost protocol - the opposite RESET_OW=
NER
> >>>> call is not made mandatory hence only seen implemented in vhost-net
> >>>> device today. One qemu instance could well exec(3) another new qemu
> >>>> instance to live upgrade itself while keeping all emulated devices a=
nd
> >>>> guest alive. The current vhost design simply prohibits this from hap=
pening.
> >>>>
> >>> Ok, I was not aware of this. Thanks for explaining it!
> >>>
> >>>>>>>      so all the guest memory can be pinned for all the guest / qe=
mu
> >>>>>>> lifecycle.
> >>>>>> I think to tie pinning to guest / qemu process life cycle makes mo=
re
> >>>>>> sense. Essentially this pinning part needs to be decoupled from th=
e
> >>>>>> iotlb mapping abstraction layer, and can / should work as a standa=
lone
> >>>>>> uAPI. Such that QEMU at the destination may launch and pin all gue=
st's
> >>>>>> memory as needed without having to start the device, while awaitin=
g any
> >>>>>> incoming migration request. Though problem is, there's no existing=
 vhost
> >>>>>> uAPI that could properly serve as the vehicle for that. SET_OWNER =
/
> >>>>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection aga=
inst
> >>>>>> introducing a new but clean vhost uAPI for pinning guest pages, su=
bject
> >>>>>> to guest's life cycle?
> >>>>>>
> >>>>> I think that to pin or not pin memory maps should be a kernel
> >>>>> decision, not to be driven by qemu.
> >>>> It's kernel decision for sure. I am with this part.
> >>>>
> >>>>> I'm not against it if needed, but
> >>>>> let me know if the current "clean at close" address your concerns.
> >>>> To better facilitate QEMU exec (live update) case, I propose we add =
new
> >>>> vhost uAPI pair for explicit pinning request - which would live with
> >>>> user mm's, or more precisely qemu instance's lifecycle.
> >>>>
> >>> Ok I see your problem better now, but I think it should be solved at
> >>> kernel level. Does that live update need to forcefully unpin and pin
> >>> the memory again,
> >> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
> >> downtime expectation. The exec(3)'d process should inherit the page
> >> pinning and/or mlock accounting from the original QEMU process, while
> >> keeping original page pinning intact. Physical page mappings for DMA c=
an
> >> be kept as is to avoid the need of reprogramming device, though in thi=
s
> >> case the existing vhost iotlb entries should be updated to reflect the
> >> new HVA in the exec(3)'d QEMU process.
> >>
> >>>    or that is just a consequence of how it works the
> >>> memory listener right now?
> >>>
> >>> Why not extend the RESET_OWNER to the rest of devices? It seems the
> >>> most natural way to me.
> >> Not sure, I think RESET_OWNER might be too heavy weighted to implement
> >> live update, and people are not clear what the exact semantics are by
> >> using it (which part of the device state is being reset, and how
> >> much)... In addition, people working on iommufd intended to make this =
a
> >> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
> >>
> >> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
> >>
> >> New uAPI to just change ownership of mm seems a better fit to me...
> >>
> > I'm not sure about the right solution here, but there are other
> > proposals to batch ioctls. But maybe creating a new one fits better.
> >
> > Thanks!
> >
> >> Thanks,
> >> -Siwei
> >>
> >>> Thanks!
> >>>
> >>>
> >>>>>> Another concern is the use_va stuff, originally it tags to the dev=
ice
> >>>>>> level and is made static at the time of device instantiation, whic=
h is
> >>>>>> fine. But others to come just find a new home at per-group level o=
r
> >>>>>> per-vq level struct. Hard to tell whether or not pinning is actual=
ly
> >>>>>> needed for the latter use_va friends, as they are essentially tied=
 to
> >>>>>> the virtio life cycle or feature negotiation. While guest / Qemu s=
tarts
> >>>>>> way earlier than that. Perhaps just ignore those sub-device level =
use_va
> >>>>>> usages? Presumably !use_va at the device level is sufficient to in=
fer
> >>>>>> the need of pinning for device?
> >>>>>>
> >>>>> I don't follow this. But I have the feeling that the subject of my
> >>>>> original mail is way more accurate if I would have said just "memor=
y
> >>>>> maps".
> >>>> I think the iotlb layer in vhost-vdpa just provides the abstraction =
for
> >>>> mapping, not pinning. Although in some case mapping implicitly relie=
s on
> >>>> pinning for DMA purpose, it doesn't have to tie to that in uAPI
> >>>> semantics. We can do explicit on-demand pinning for cases for e.g.
> >>>> warming up device at live migration destination.
> >>>>
> >>>>
> >>>>> I still consider the way to fix it is to actually delegate that to =
the
> >>>>> kernel vdpa, so it can choose if a particular ASID needs the pin or
> >>>>> not. But let me know if I missed something.
> >>>> You can disregard this for now. I will discuss that further with you
> >>>> guys while bind_mm and per-group use_va stuffs are landed.
> >>>>
> >>>> Thanks!
> >>>> -Siwei
> >>>>
> >>>>
> >>>>
> >>>>> Thanks!
> >>>>>
> >>>>>> Regards,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>
> >>>>>>> This has two main problems:
> >>>>>>> * At this moment the reset semantics forces the vdpa device to un=
map
> >>>>>>> all the memory. So this change needs a vhost vdpa feature flag.
> >>>>>>> * This may increase the initialization time. Maybe we can delay i=
t if
> >>>>>>> qemu is not the destination of a LM. Anyway I think this should b=
e
> >>>>>>> done as an optimization on top.
> >>>>>>>
> >>>>>>> Any ideas or comments in this regard?
> >>>>>>>
> >>>>>>> Thanks!
> >>>>>>>
>


