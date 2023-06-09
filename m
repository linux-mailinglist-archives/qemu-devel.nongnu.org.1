Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725C729EF8
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:45:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7dBN-00041i-NO; Fri, 09 Jun 2023 10:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7dBH-000413-LA
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7dBF-00053c-JF
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 10:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686321205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYEAzTo5ZGuSQdlfqeiqW7OP3oEFdMwM3YkaxG0uRZ8=;
 b=LFZHV3EUqUGuCcFCCY+mNwwHw8SIu0KjxpO3Q9haTf38/gsHIK7ssrNwt2sqfzKoMnjgIG
 Gbx/HF6FRBsFl0Zd926oVxhgnUc+ul6yK0zf50SW6uBXGIIcBKLSqKO5UqwXDVBwIonELd
 OvLb/bWbApxVv4Yp5FS9jlhuyf3Ce14=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-K-rhgzthN0Wu2P5AXgUCJg-1; Fri, 09 Jun 2023 10:33:24 -0400
X-MC-Unique: K-rhgzthN0Wu2P5AXgUCJg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-568fd72993cso62774227b3.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 07:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686321204; x=1688913204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYEAzTo5ZGuSQdlfqeiqW7OP3oEFdMwM3YkaxG0uRZ8=;
 b=J99+NIMH3IJiJ8zfloG4g7k7dYudlAaSojk5Z+jtQtz/zAT8Z5BZNb12kC7b93uYuf
 elhDR8GosapXpkNreeKuOcuGtxqU/OMLLN4ECdA5sUWcpIYdi8MsV7RcY3yNZCNveRF2
 ShmlVUXDfzLAyZYWBkiG3VF5fVZ73sNrFeo0936vF/lhPpzWj11ZTUhfzvVp2zlbmuGK
 ehqv0HXbjwaoF+Ifm+IeNfpBs7cNKDRYPr3OElncX2jvnOZL7YWPYGd6/mBdBz0i+90n
 xw249QsYcM/QgM1JuITyCHXHO5BPXTvU8Tmz1qQ1ToBznBgIdKGh7ASVNXshFuas1wo9
 iXqg==
X-Gm-Message-State: AC+VfDwY9UJQgKvwpoV9jbet6l/zNoRxLgRKivs/epOh5G+7ChEd7Mm6
 nWC11CXN1XqepspVGVSrrbWZBn6viiOjksaqu+L6bgjbyz/N2N8izLy149WYpC5Zv4oXOyFvDx2
 ob9ErV68YjJP1u7LLI1OhdxnDJhcIvZE=
X-Received: by 2002:a81:8397:0:b0:565:b76d:82c8 with SMTP id
 t145-20020a818397000000b00565b76d82c8mr2050263ywf.5.1686321203907; 
 Fri, 09 Jun 2023 07:33:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6laW8DgT3cQDP3DzkwzuE8w6gNB1nFUoa40FaohlrNx7Wl0LweE4Var+TyjaG9fQfkVaBo+p+lBiWAgZ7gUhg=
X-Received: by 2002:a81:8397:0:b0:565:b76d:82c8 with SMTP id
 t145-20020a818397000000b00565b76d82c8mr2050242ywf.5.1686321203604; Fri, 09
 Jun 2023 07:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWdV6pKP0SVZciMiu_HN86aJriZh0HBiwHNkO7+yErXnBA@mail.gmail.com>
 <c59d2d67-d31a-b6e6-54c5-5b81c18d9547@oracle.com>
 <CAJaqyWegsVHEVZt2_mf4wA8MuF7UXmU=UbHJfwyzURDRxfRgmg@mail.gmail.com>
 <bff286b8-0103-1698-c77d-736417396405@oracle.com>
In-Reply-To: <bff286b8-0103-1698-c77d-736417396405@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 9 Jun 2023 16:32:47 +0200
Message-ID: <CAJaqyWcwFgEH3MCOAhHe20P3oy2_aq2BUkTA9_7wePsT8=GoAg@mail.gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 9, 2023 at 12:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
> On 6/7/23 01:08, Eugenio Perez Martin wrote:
> > On Wed, Jun 7, 2023 at 12:43=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >> Sorry for reviving this old thread, I lost the best timing to follow u=
p
> >> on this while I was on vacation. I have been working on this and found
> >> out some discrepancy, please see below.
> >>
> >> On 4/5/23 04:37, Eugenio Perez Martin wrote:
> >>> Hi!
> >>>
> >>> As mentioned in the last upstream virtio-networking meeting, one of
> >>> the factors that adds more downtime to migration is the handling of
> >>> the guest memory (pin, map, etc). At this moment this handling is
> >>> bound to the virtio life cycle (DRIVER_OK, RESET). In that sense, the
> >>> destination device waits until all the guest memory / state is
> >>> migrated to start pinning all the memory.
> >>>
> >>> The proposal is to bind it to the char device life cycle (open vs
> >>> close),
> >> Hmmm, really? If it's the life cycle for char device, the next guest /
> >> qemu launch on the same vhost-vdpa device node won't make it work.
> >>
> > Maybe my sentence was not accurate, but I think we're on the same page =
here.
> >
> > Two qemu instances opening the same char device at the same time are
> > not allowed, and vhost_vdpa_release clean all the maps. So the next
> > qemu that opens the char device should see a clean device anyway.
>
> I mean the pin can't be done at the time of char device open, where the
> user address space is not known/bound yet. The earliest point possible
> for pinning would be until the vhost_attach_mm() call from SET_OWNER is
> done.

Maybe we are deviating, let me start again.

Using QEMU code, what I'm proposing is to modify the lifecycle of the
.listener member of struct vhost_vdpa.

At this moment, the memory listener is registered at
vhost_vdpa_dev_start(dev, started=3Dtrue) call for the last vhost_dev,
and is unregistered in both vhost_vdpa_reset_status and
vhost_vdpa_cleanup.

My original proposal was just to move the memory listener registration
to the last vhost_vdpa_init, and remove the unregister from
vhost_vdpa_reset_status. The calls to vhost_vdpa_dma_map/unmap would
be the same, the device should not realize this change.

One of the concerns was that it could delay VM initialization, and I
didn't profile it but I think that may be the case. I'm not sure about
the right fix but I think the change is easy to profile. If that is
the case, we could:
* use a flag (listener->address_space ?) and only register the
listener in _init if waiting for a migration, do it in _start
otherwise.
* something like io_uring, where the map can be done in parallel and
we can fail _start if some of them fails.

> Actually I think the counterpart vhost_detach_mm() only gets
> handled in vhost_vdpa_release() at device close time is a resulting
> artifact and amiss of today's vhost protocol - the opposite RESET_OWNER
> call is not made mandatory hence only seen implemented in vhost-net
> device today. One qemu instance could well exec(3) another new qemu
> instance to live upgrade itself while keeping all emulated devices and
> guest alive. The current vhost design simply prohibits this from happenin=
g.
>

Ok, I was not aware of this. Thanks for explaining it!

>
> >
> >>>    so all the guest memory can be pinned for all the guest / qemu
> >>> lifecycle.
> >> I think to tie pinning to guest / qemu process life cycle makes more
> >> sense. Essentially this pinning part needs to be decoupled from the
> >> iotlb mapping abstraction layer, and can / should work as a standalone
> >> uAPI. Such that QEMU at the destination may launch and pin all guest's
> >> memory as needed without having to start the device, while awaiting an=
y
> >> incoming migration request. Though problem is, there's no existing vho=
st
> >> uAPI that could properly serve as the vehicle for that. SET_OWNER /
> >> SET_MEM_TABLE / RESET_OWNER seems a remote fit.. Any objection against
> >> introducing a new but clean vhost uAPI for pinning guest pages, subjec=
t
> >> to guest's life cycle?
> >>
> > I think that to pin or not pin memory maps should be a kernel
> > decision, not to be driven by qemu.
>
> It's kernel decision for sure. I am with this part.
>
> > I'm not against it if needed, but
> > let me know if the current "clean at close" address your concerns.
>
> To better facilitate QEMU exec (live update) case, I propose we add new
> vhost uAPI pair for explicit pinning request - which would live with
> user mm's, or more precisely qemu instance's lifecycle.
>

Ok I see your problem better now, but I think it should be solved at
kernel level. Does that live update need to forcefully unpin and pin
the memory again, or that is just a consequence of how it works the
memory listener right now?

Why not extend the RESET_OWNER to the rest of devices? It seems the
most natural way to me.

Thanks!


> >
> >> Another concern is the use_va stuff, originally it tags to the device
> >> level and is made static at the time of device instantiation, which is
> >> fine. But others to come just find a new home at per-group level or
> >> per-vq level struct. Hard to tell whether or not pinning is actually
> >> needed for the latter use_va friends, as they are essentially tied to
> >> the virtio life cycle or feature negotiation. While guest / Qemu start=
s
> >> way earlier than that. Perhaps just ignore those sub-device level use_=
va
> >> usages? Presumably !use_va at the device level is sufficient to infer
> >> the need of pinning for device?
> >>
> > I don't follow this. But I have the feeling that the subject of my
> > original mail is way more accurate if I would have said just "memory
> > maps".
>
> I think the iotlb layer in vhost-vdpa just provides the abstraction for
> mapping, not pinning. Although in some case mapping implicitly relies on
> pinning for DMA purpose, it doesn't have to tie to that in uAPI
> semantics. We can do explicit on-demand pinning for cases for e.g.
> warming up device at live migration destination.
>
>
> >
> > I still consider the way to fix it is to actually delegate that to the
> > kernel vdpa, so it can choose if a particular ASID needs the pin or
> > not. But let me know if I missed something.
>
> You can disregard this for now. I will discuss that further with you
> guys while bind_mm and per-group use_va stuffs are landed.
>
> Thanks!
> -Siwei
>
>
>
> >
> > Thanks!
> >
> >> Regards,
> >> -Siwei
> >>
> >>
> >>> This has two main problems:
> >>> * At this moment the reset semantics forces the vdpa device to unmap
> >>> all the memory. So this change needs a vhost vdpa feature flag.
> >>> * This may increase the initialization time. Maybe we can delay it if
> >>> qemu is not the destination of a LM. Anyway I think this should be
> >>> done as an optimization on top.
> >>>
> >>> Any ideas or comments in this regard?
> >>>
> >>> Thanks!
> >>>
>


