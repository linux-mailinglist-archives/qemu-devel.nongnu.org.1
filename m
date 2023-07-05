Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBA0748B38
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 20:06:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH6rV-0000Yv-G0; Wed, 05 Jul 2023 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qH6rS-0000Yg-Qh
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qH6rQ-0004iS-DA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 14:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688580254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5weXK/t0SU2uZeo2u6VCgWLeoMsKamcuy9UJI1E9fJw=;
 b=abAo+9ZwNxbO52xbM8/ESw2cVLl/ddIEdg/am4gYQY9+k7raTngq7WryPLh+erW23kP4XB
 2diQLJQaq1UiQvPC8PZ4M2Vd5+MHmz477amQOCmYL2Xd30HWavL+6HUO+w4FnEIh4lUDvJ
 W9BRn70ih6JQRvwjTbnsCA2OCusKET0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-3PqZCea2PCWQJY5xOLKn6w-1; Wed, 05 Jul 2023 14:04:13 -0400
X-MC-Unique: 3PqZCea2PCWQJY5xOLKn6w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-577323ba3d5so13402677b3.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 11:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688580253; x=1691172253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5weXK/t0SU2uZeo2u6VCgWLeoMsKamcuy9UJI1E9fJw=;
 b=Zt9LdRx6HaQZGuw+bV1QYEptfEjFaq5O2ckKwSJqmZQmSxmXCdpRk3JxyOI5Rtveiz
 x9Bd11tQH9iMJZ7goUKWye5zQkvJ7F9vRf+C+WHjXnrCxsUpPcaWq7Tz7SquKdGZf12S
 U/td1C+K4ouw/R10Jsf4luUWjg4Gn8CfJOzuZSdQUjPg2hcDcLdEXJqRhx17ckYAOS5G
 GZ2ace3/yM9WEWSE/VrEONCdeNBXh3N79Q9WTG+LhkTO3g1mcd/GfboyKojsiTjSVj12
 kuKZyGOM0Bxo4Qlg+HVmhzqVnBXSdauPC+i5SsRN6bFs68wDyWwmRN/4iACjEbmC7AZG
 L7GA==
X-Gm-Message-State: ABy/qLYu3MXznnMia9Y6CywCCICpGVGstvPlV0NvRRs/y1L1JAKYrmEF
 AXtQ3jWXaoNwdOTc2L67jniZNIl9dTratqpBtSaGcIZHLKZuSM91jBNEF3MktfT2PF62gIYmoUy
 pOzlU+fY6LPN7mq7kx2UOfTSRCMHgyTM=
X-Received: by 2002:a25:ca49:0:b0:c41:e357:7df2 with SMTP id
 a70-20020a25ca49000000b00c41e3577df2mr2315083ybg.14.1688580252660; 
 Wed, 05 Jul 2023 11:04:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHnrPdQKD+ZjwG8YmYdORX6poECIGXjcP4s/TLyeeKYikxz74dLvM5N3AEyWDhZS+JvdkTxitFcxt5ucJy/Tm4=
X-Received: by 2002:a25:ca49:0:b0:c41:e357:7df2 with SMTP id
 a70-20020a25ca49000000b00c41e3577df2mr2315055ybg.14.1688580252312; Wed, 05
 Jul 2023 11:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
 <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
 <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
In-Reply-To: <8db2b6cf-1e32-67eb-f6c0-fe3a4175b410@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Jul 2023 20:03:35 +0200
Message-ID: <CAJaqyWd_wb5eXcTi2R+-n=AriP=rwKTCwObz1sZ45eRrpLw_wQ@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 8:36=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 6/9/2023 7:32 AM, Eugenio Perez Martin wrote:
> > On Fri, Jun 9, 2023 at 12:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> >>> On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> Sorry for reviving this old thread, I lost the best timing to follow=
 up
> >>>> on this while I was on vacation. I have been working on this and fou=
nd
> >>>> out some discrepancy, please see below.
> >>>>
> >>>> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>>>> Hi!
> >>>>>
> >>>>> As mentioned in the last upstream virtio-networking meeting, one of
> >>>>> the factors that adds more downtime to migration is the handling of
> >>>>> the guest memory (pin, map, etc). At this moment this handling is
> >>>>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, t=
he
> >>>>> destination device waits until all the guest memory / state is
> >>>>> migrated to start pinning all the memory.
> >>>>>
> >>>>> The proposal is to bind it to the char device life cycle (open vs
> >>>>> close),
> >>>> Hmmm, really? If it's the life cycle for char device, the next guest=
 /
> >>>> qemu launch on the same vhost-vdpa device node won't make it work.
> >>>>
> >>> Maybe my sentence was not accurate, but I think we're on the same pag=
e here.
> >>>
> >>> Two qemu instances opening the same char device at the same time are
> >>> not allowed, and vhost_vdpa_release clean all the maps. So the next
> >>> qemu that opens the char device should see a clean device anyway.
> >> I mean the pin can't be done at the time of char device open, where th=
e
> >> user address space is not known/bound yet. The earliest point possible
> >> for pinning would be until the vhost_attach_mm() call from SET_OWNER i=
s
> >> done.
> > Maybe we are deviating, let me start again.
> >
> > Using QEMU code, what I'm proposing is to modify the lifecycle of the
> > .listener member of struct vhost_vdpa.
> >
> > At this moment, the memory listener is registered at
> > vhost_vdpa_dev_start(dev, started=3Dtrue) call for the last vhost_dev,
> > and is unregistered in both vhost_vdpa_reset_status and
> > vhost_vdpa_cleanup.
> >
> > My original proposal was just to move the memory listener registration
> > to the last vhost_vdpa_init, and remove the unregister from
> > vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
> > be the same, the device should not realize this change.
> This can address LM downtime latency for sure, but it won't help
> downtime during dynamic SVQ switch - which still needs to go through the
> full unmap/map cycle (that includes the slow part for pinning) from
> passthrough to SVQ mode. Be noted not every device could work with a
> separate ASID for SVQ descriptors. The fix should expect to work on
> normal vDPA vendor devices without a separate descriptor ASID, with
> platform IOMMU underneath or with on-chip IOMMU.
>

At this moment the SVQ switch is very inefficient mapping-wise, as it
unmap all the GPA->HVA maps and overrides it. In particular, SVQ is
allocated in low regions of the iova space, and then the guest memory
is allocated in this new IOVA region incrementally.

We can optimize that if we place SVQ in a free GPA area instead. All
of the "translations" still need to be done, to ensure the guest
doesn't have access to SVQ vring. That way, qemu will not send all the
unmaps & maps, only the new ones. And vhost/vdpa does not need to call
unpin_user_page / pin_user_pages for all the guest memory.

More optimizations include the batching of the SVQ vrings.

> >
> > One of the concerns was that it could delay VM initialization, and I
> > didn't profile it but I think that may be the case.
> Yes, that's the concern here - we should not introduce regression to
> normal VM boot process/time. In case of large VM it's very easy to see
> the side effect if we go this way.
>
> >   I'm not sure about
> > the right fix but I think the change is easy to profile. If that is
> > the case, we could:
> > * use a flag (listener->address_space ?) and only register the
> > listener in _init if waiting for a migration, do it in _start
> > otherwise.
> Just doing this alone won't help SVQ mode switch downtime, see the
> reason stated above.
>
> > * something like io_uring, where the map can be done in parallel and
> > we can fail _start if some of them fails.
> This can alleviate the problem somehow, but still sub-optimal and not
> scalable with larger size. I'd like zero or least pinning to be done at
> the SVQ switch or migration time.
>

To reduce even further the pinning at SVQ time we would need to
preallocate SVQ vrings before suspending the device.

> >
> >> Actually I think the counterpart vhost_detach_mm() only gets
> >> handled in vhost_vdpa_release() at device close time is a resulting
> >> artifact and amiss of today's vhost protocol - the opposite RESET_OWNE=
R
> >> call is not made mandatory hence only seen implemented in vhost-net
> >> device today. One qemu instance could well exec(3) another new qemu
> >> instance to live upgrade itself while keeping all emulated devices and
> >> guest alive. The current vhost design simply prohibits this from happe=
ning.
> >>
> > Ok, I was not aware of this. Thanks for explaining it!
> >
> >>>>>     so all the guest memory can be pinned for all the guest / qemu
> >>>>> lifecycle.
> >>>> I think to tie pinning to guest / qemu process life cycle makes more
> >>>> sense. Essentially this pinning part needs to be decoupled from the
> >>>> iotlb mapping abstraction layer, and can / should work as a standalo=
ne
> >>>> uAPI. Such that QEMU at the destination may launch and pin all guest=
's
> >>>> memory as needed without having to start the device, while awaiting =
any
> >>>> incoming migration request. Though problem is, there's no existing v=
host
> >>>> uAPI that could properly serve as the vehicle for that. SET_OWNER /
> >>>> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection again=
st
> >>>> introducing a new but clean vhost uAPI for pinning guest pages, subj=
ect
> >>>> to guest's life cycle?
> >>>>
> >>> I think that to pin or not pin memory maps should be a kernel
> >>> decision, not to be driven by qemu.
> >> It's kernel decision for sure. I am with this part.
> >>
> >>> I'm not against it if needed, but
> >>> let me know if the current "clean at close" address your concerns.
> >> To better facilitate QEMU exec (live update) case, I propose we add ne=
w
> >> vhost uAPI pair for explicit pinning request - which would live with
> >> user mm's, or more precisely qemu instance's lifecycle.
> >>
> > Ok I see your problem better now, but I think it should be solved at
> > kernel level. Does that live update need to forcefully unpin and pin
> > the memory again,
> No, it should avoid the unpin&pin cycle, otherwise it'd defeat the
> downtime expectation. The exec(3)'d process should inherit the page
> pinning and/or mlock accounting from the original QEMU process, while
> keeping original page pinning intact. Physical page mappings for DMA can
> be kept as is to avoid the need of reprogramming device, though in this
> case the existing vhost iotlb entries should be updated to reflect the
> new HVA in the exec(3)'d QEMU process.
>
> >   or that is just a consequence of how it works the
> > memory listener right now?
> >
> > Why not extend the RESET_OWNER to the rest of devices? It seems the
> > most natural way to me.
> Not sure, I think RESET_OWNER might be too heavy weighted to implement
> live update, and people are not clear what the exact semantics are by
> using it (which part of the device state is being reset, and how
> much)... In addition, people working on iommufd intended to make this a
> "one-shot" ioctl e.g. CHANGE_OWNER instead of RESET_OWNER+SET_OWNER:
>
> https://lore.kernel.org/kvm/Y5Ibvv9PNMifi0NF@ziepe.ca/
>
> New uAPI to just change ownership of mm seems a better fit to me...
>

I'm not sure about the right solution here, but there are other
proposals to batch ioctls. But maybe creating a new one fits better.

Thanks!

> Thanks,
> -Siwei
>
> >
> > Thanks!
> >
> >
> >>>> Another concern is the use_va stuff, originally it tags to the devic=
e
> >>>> level and is made static at the time of device instantiation, which =
is
> >>>> fine. But others to come just find a new home at per-group level or
> >>>> per-vq level struct. Hard to tell whether or not pinning is actually
> >>>> needed for the latter use_va friends, as they are essentially tied t=
o
> >>>> the virtio life cycle or feature negotiation. While guest / Qemu sta=
rts
> >>>> way earlier than that. Perhaps just ignore those sub-device level us=
e_va
> >>>> usages? Presumably !use_va at the device level is sufficient to infe=
r
> >>>> the need of pinning for device?
> >>>>
> >>> I don't follow this. But I have the feeling that the subject of my
> >>> original mail is way more accurate if I would have said just "memory
> >>> maps".
> >> I think the iotlb layer in vhost-vdpa just provides the abstraction fo=
r
> >> mapping, not pinning. Although in some case mapping implicitly relies =
on
> >> pinning for DMA purpose, it doesn't have to tie to that in uAPI
> >> semantics. We can do explicit on-demand pinning for cases for e.g.
> >> warming up device at live migration destination.
> >>
> >>
> >>> I still consider the way to fix it is to actually delegate that to th=
e
> >>> kernel vdpa, so it can choose if a particular ASID needs the pin or
> >>> not. But let me know if I missed something.
> >> You can disregard this for now. I will discuss that further with you
> >> guys while bind_mm and per-group use_va stuffs are landed.
> >>
> >> Thanks!
> >> -Siwei
> >>
> >>
> >>
> >>> Thanks!
> >>>
> >>>> Regards,
> >>>> -Siwei
> >>>>
> >>>>
> >>>>> This has two main problems:
> >>>>> * At this moment the reset semantics forces the vdpa device to unma=
p
> >>>>> all the memory. So this change needs a vhost vdpa feature flag.
> >>>>> * This may increase the initialization time. Maybe we can delay it =
if
> >>>>> qemu is not the destination of a LM. Anyway I think this should be
> >>>>> done as an optimization on top.
> >>>>>
> >>>>> Any ideas or comments in this regard?
> >>>>>
> >>>>> Thanks!
> >>>>>
>


