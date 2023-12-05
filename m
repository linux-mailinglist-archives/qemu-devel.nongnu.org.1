Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D180573D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:24:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWLE-0001xI-Mt; Tue, 05 Dec 2023 09:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rAWLB-0001x6-EH
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:24:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rAWL7-0002KI-Jt
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701786231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY9bog1VZ+UXDM3uNM5z+XyhI74MaOkNgfc1Ppyfx3M=;
 b=P8Fe1IbQh5vs/XtJpEfTONklZH9m+CTpACvAA+mwjpumOtgAoHj5/xziWyam//QSPQ5FA4
 jNu1K4JFjWXVx4P2z56m1hzj2JS2v9i3v54bbQrk6/myPY3ZKfYeI2XR+frIeUcKpa9ZWt
 /ms+A8LHR2ZkGhAB0v1/PYTKlQtcq8I=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-vt515AkyNzmg9vULceWqUw-1; Tue, 05 Dec 2023 09:23:50 -0500
X-MC-Unique: vt515AkyNzmg9vULceWqUw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-daee86e2d70so4921403276.0
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 06:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701786230; x=1702391030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY9bog1VZ+UXDM3uNM5z+XyhI74MaOkNgfc1Ppyfx3M=;
 b=WOh0s1BMIYy83z3STSYI7M5OeRuK0SctThjsSdYyA7mIZF8rUnFsWnMOcQQL8bzFI3
 llCBOiO8MP4swhPGLqJxik9u+ilhPxf0cbsCFWXtNdn7VsvAGQQMRdw0ksX20mIjXlV1
 Kk9bHQojzXZDVIqA3hS3d91mRMELhAOQ6DL7wgIGcMLGnmsvyC9BcZzl6hqSWZDKDzej
 tFcq4+WPaRx0AkNDqql96m6JV5yvceTKXBwX6MM6Na9knME0xRFBCA2l4NLaYkpkmZ6a
 LXalGFUSBto+wZlSo/4ygxtZrcVsi20Xyd8v8chT09K6Bfi+0Zu4EipBRY9sSOIl5tpU
 0D7Q==
X-Gm-Message-State: AOJu0Yymu7y5hPKtfke8pbnohMkQFfr4t3drKfITwJ/UX28rVK4htRhT
 12QNBYJYkW/qCNS0Tl6qul1rV85Tq322TsupLTwNZ9I0qqHimh7DjFkCgchVo3//fCg/XSdAk00
 8G2clm0k85m2w8I00C4InZ4v+tGNV8h8=
X-Received: by 2002:a25:7651:0:b0:db7:dacf:3fa3 with SMTP id
 r78-20020a257651000000b00db7dacf3fa3mr3934222ybc.80.1701786229522; 
 Tue, 05 Dec 2023 06:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLDi17ahNLI6d8qDtxQgUlRZwCyuz6Dce0CzoRdq1uVCE/yzYUaBtDMAZwTq5zoJISQItrVfEavvuXsa4pVzs=
X-Received: by 2002:a25:7651:0:b0:db7:dacf:3fa3 with SMTP id
 r78-20020a257651000000b00db7dacf3fa3mr3934207ybc.80.1701786229207; Tue, 05
 Dec 2023 06:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
 <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
 <b4cdaabd-45b1-4ff7-a267-05230a754588@oracle.com>
In-Reply-To: <b4cdaabd-45b1-4ff7-a267-05230a754588@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Dec 2023 15:23:13 +0100
Message-ID: <CAJaqyWe0Umnazu2dBGCWd36BC2yFWzXPg4r_Ak4erGiwmqgCGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, 
 Yajun Wu <yajunw@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Gautam Dawar <gdawar@xilinx.com>
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

On Fri, Nov 3, 2023 at 9:19=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 11/2/2023 5:37 AM, Eugenio Perez Martin wrote:
> > On Thu, Nov 2, 2023 at 11:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> >>> Current memory operations like pinning may take a lot of time at the
> >>>
> >>> destination.  Currently they are done after the source of the migrati=
on is
> >>>
> >>> stopped, and before the workload is resumed at the destination.  This=
 is a
> >>>
> >>> period where neigher traffic can flow, nor the VM workload can contin=
ue
> >>>
> >>> (downtime).
> >>>
> >>>
> >>>
> >>> We can do better as we know the memory layout of the guest RAM at the
> >>>
> >>> destination from the moment the migration starts.  Moving that operat=
ion allows
> >>>
> >>> QEMU to communicate the kernel the maps while the workload is still r=
unning in
> >>>
> >>> the source, so Linux can start mapping them.  Ideally, all IOMMU is c=
onfigured,
> >>>
> >>> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're s=
till
> >>>
> >>> saving all the pinning time.
> >> I get what you want to say, though not sure how pinning is relevant to
> >> on-chip IOMMU and .set_map here, essentially pinning is required for a=
ll
> >> parent vdpa drivers that perform DMA hence don't want VM pages to move
> >> around.
> > Basically highlighting that the work done under .set_map is not only
> > pinning, but it is a significant fraction on it. It can be reworded or
> > deleted for sure.
> >
> >>>
> >>>
> >>> Note that further devices setup at the end of the migration may alter=
 the guest
> >>>
> >>> memory layout. But same as the previous point, many operations are st=
ill done
> >>>
> >>> incrementally, like memory pinning, so we're saving time anyway.
> >>>
> >>>
> >>>
> >>> The first bunch of patches just reorganizes the code, so memory relat=
ed
> >>>
> >>> operation parameters are shared between all vhost_vdpa devices.  This=
 is
> >>>
> >>> because the destination does not know what vhost_vdpa struct will hav=
e the
> >>>
> >>> registered listener member, so it is easier to place them in a shared=
 struct
> >>>
> >>> rather to keep them in vhost_vdpa struct.  Future version may squash =
or omit
> >>>
> >>> these patches.
> >> It looks this VhostVDPAShared facility (patch 1-13) is also what I nee=
d
> >> in my SVQ descriptor group series [*], for which I've built similar
> >> construct there. If possible please try to merge this in ASAP. I'll
> >> rework my series on top of that.
> >>
> >> [*]
> >> https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf=
7dff3d6004fbcd5
> >>
> > I can send it individually, for sure.
> >
> > MST, Jason, can this first part be merged? It doesn't add a lot by
> > itself but it helps pave the way for future changes.
> If it cannot, it doesn't matter. I can pick it from here and get my
> series posted with your patches 1-13 applied upfront. This should work,
> I think?
>
> >>>
> >>>
> >>> Only tested with vdpa_sim. I'm sending this before full benchmark, as=
 some work
> >>>
> >>> like [1] can be based on it, and Si-Wei agreed on benchmark this seri=
es with
> >>>
> >>> his experience.
> >> Haven't done the full benchmark compared to pre-map at destination yet=
,
> >> though an observation is that the destination QEMU seems very easy to
> >> get stuck for very long time while in mid of pinning pages. During thi=
s
> >> period, any client doing read-only QMP query or executing HMP info
> >> command got frozen indefinitely (subject to how large size the memory =
is
> >> being pinned). Is it possible to unblock those QMP request or HMP
> >> command from being executed (at least the read-only ones) while in
> >> migration? Yield from the load_setup corourtine and spawn another thre=
ad?
> >>
> > Ok, I wasn't aware of that.
> >
> > I think we cannot yield in a coroutine and wait for an ioctl.
> I was wondering if we need a separate coroutine out of the general
> migration path to support this special code without overloading
> load_setup or its callers. For instance, unblock the source from sending
> guest rams while allow destination pin pages in parallel should be
> possible.
>

Hi Si-Wei,

I'm working on this, I think I'll be able to send a new version soon.
Just a question, when the mapping is done in vhost_vdpa_dev_start as
the current upstream master does, are you able to interact with QMP?

Thanks!

> Regardless, a separate thread is needed to carry out all the heavy
> lifting, i.e. ioctl(2) or write(2) syscalls to map&pin pages.
>
>
> > One
> > option that came to my mind is to effectively use another thread, and
> > use a POSIX barrier (or equivalent on glib / QEMU) before finishing
> > the migration.
> Yes, a separate thread is needed anyway.
>
> >   I'm not sure if there are more points where we can
> > check the barrier and tell the migration to continue or stop though.
> I think there is, for e.g. what if the dma_map fails. There must be a
> check point for that.
>
> >
> > Another option is to effectively start doing these ioctls in an
> > asynchronous way, io_uring cmds like, but I'd like to achieve this
> > first.
> Yes, io_uring or any async API could be another option. Though this
> needs new uAPI through additional kernel facility to support. Anyway,
> it's up to you to decide. :)
>
> Regards,
> -Siwei
> >> Having said, not sure if .load_setup is a good fit for what we want to
> >> do. Searching all current users of .load_setup, either the job can be
> >> done instantly or the task is time bound without trapping into kernel
> >> for too long. Maybe pinning is too special use case here...
> >>
> >> -Siwei
> >>>
> >>>
> >>> Future directions on top of this series may include:
> >>>
> >>> * Iterative migration of virtio-net devices, as it may reduce downtim=
e per [1].
> >>>
> >>>     vhost-vdpa net can apply the configuration through CVQ in the des=
tination
> >>>
> >>>     while the source is still migrating.
> >>>
> >>> * Move more things ahead of migration time, like DRIVER_OK.
> >>>
> >>> * Check that the devices of the destination are valid, and cancel the=
 migration
> >>>
> >>>     in case it is not.
> >>>
> >>>
> >>>
> >>> [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a=
566f61@nvidia.com/T/
> >>>
> >>>
> >>>
> >>> Eugenio P=C3=A9rez (18):
> >>>
> >>>     vdpa: add VhostVDPAShared
> >>>
> >>>     vdpa: move iova tree to the shared struct
> >>>
> >>>     vdpa: move iova_range to vhost_vdpa_shared
> >>>
> >>>     vdpa: move shadow_data to vhost_vdpa_shared
> >>>
> >>>     vdpa: use vdpa shared for tracing
> >>>
> >>>     vdpa: move file descriptor to vhost_vdpa_shared
> >>>
> >>>     vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
> >>>
> >>>     vdpa: move backend_cap to vhost_vdpa_shared
> >>>
> >>>     vdpa: remove msg type of vhost_vdpa
> >>>
> >>>     vdpa: move iommu_list to vhost_vdpa_shared
> >>>
> >>>     vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
> >>>
> >>>     vdpa: use dev_shared in vdpa_iommu
> >>>
> >>>     vdpa: move memory listener to vhost_vdpa_shared
> >>>
> >>>     vdpa: do not set virtio status bits if unneeded
> >>>
> >>>     vdpa: add vhost_vdpa_load_setup
> >>>
> >>>     vdpa: add vhost_vdpa_net_load_setup NetClient callback
> >>>
> >>>     vdpa: use shadow_data instead of first device v->shadow_vqs_enabl=
ed
> >>>
> >>>     virtio_net: register incremental migration handlers
> >>>
> >>>
> >>>
> >>>    include/hw/virtio/vhost-vdpa.h |  43 +++++---
> >>>
> >>>    include/net/net.h              |   4 +
> >>>
> >>>    hw/net/virtio-net.c            |  23 +++++
> >>>
> >>>    hw/virtio/vdpa-dev.c           |   7 +-
> >>>
> >>>    hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++-----------=
----
> >>>
> >>>    net/vhost-vdpa.c               | 127 ++++++++++++-----------
> >>>
> >>>    hw/virtio/trace-events         |  14 +--
> >>>
> >>>    7 files changed, 239 insertions(+), 162 deletions(-)
> >>>
> >>>
> >>>
>


