Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA257E1CEB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:06:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzvY2-0003GY-C7; Mon, 06 Nov 2023 04:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qzvXy-0003G8-VI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:05:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qzvXk-0007uj-8y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699261511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYdh8FKWAHQw3HDX8fL19egmDCvxqv4XswBTDk1G200=;
 b=DpB6VMBOgm/c/JdpllxEnH3jQ/3rFunYutezJx2F182FLV/1hQWEaFKx2rQjn6389rE6ww
 WA+UaSilHCTU+ekRjy3LHDnOD+vsVuklhZvnroJju5f8Zj8g/57A0rJd5dmgks+SQ9q/+c
 lFSChRri9FRH902IHoArzWt/h1HY0+0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-BlwMroQcPFKIn5nDu_oD0w-1; Mon, 06 Nov 2023 04:04:53 -0500
X-MC-Unique: BlwMroQcPFKIn5nDu_oD0w-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a7aa161b2fso59376377b3.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 01:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699261492; x=1699866292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LYdh8FKWAHQw3HDX8fL19egmDCvxqv4XswBTDk1G200=;
 b=UM4pU1B6x3M0FncEX2CMgROD4ZCjOdzVz7JEvRCDV+Pgwic0bTaFBHUfBY6AIWTGF/
 P2siiAOg/qTf/H0gHWe0qDYx0GC7LfdS15o2jVwLhWbB2knyHTKW+EVPMZfB8V07uv9K
 HoLPZio2hzarIThzF8tR4bPCrCfEK1CYLn42F9RVH5aZVToR7Rl8RU7aOoge4pqrsdhn
 4p9Uw9s9Tzw7un1BBQjMnnQzdmRzR9zDbgUZCV2TOfQIRjDLQdVsHjHLlOCwKtFRqYq4
 FBUPXy6pi2xPQmuqCzIsq4mqiR1kZSFqX+sOjz8B3Dn6ywiknvJQK7xEWsR56S+ELQhL
 W/Jg==
X-Gm-Message-State: AOJu0Yx0VT2JsEYhMRKPXWHP+QQ0ELosm95QvlAziolw6AwUi54A05qc
 hCTr7zteFLzvi/X7O7dFS/x38dU+ZKp4xFmJFiTjzhM5y+TUrLOAzxtWeJKNVaMmHmPM49OzCrN
 0ivQutMqCDrmIQuGcLiU+zR5r4W4C/B0=
X-Received: by 2002:a81:99c2:0:b0:5a7:acae:3bb0 with SMTP id
 q185-20020a8199c2000000b005a7acae3bb0mr8985173ywg.5.1699261492492; 
 Mon, 06 Nov 2023 01:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzhipVmrdE8SFOLZss+WecIua3ZvhB5CI7NC/fLRQB0RHDLhaSdj4OyBuFNG4TL12WRY30ekD3H+jV01oHEeU=
X-Received: by 2002:a81:99c2:0:b0:5a7:acae:3bb0 with SMTP id
 q185-20020a8199c2000000b005a7acae3bb0mr8985140ywg.5.1699261492123; Mon, 06
 Nov 2023 01:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
 <52bfb600-63e4-42d4-9278-fa8cd5271460@oracle.com>
In-Reply-To: <52bfb600-63e4-42d4-9278-fa8cd5271460@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 6 Nov 2023 10:04:16 +0100
Message-ID: <CAJaqyWemRT8X7vS5sjUtLnT=Q+zLCZ_PhCVZnDvVyE8v=uJh+g@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Nov 3, 2023 at 9:41=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
>
>
> On 11/2/2023 3:12 AM, Si-Wei Liu wrote:
> >
> >
> > On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> >> Current memory operations like pinning may take a lot of time at the
> >>
> >> destination.  Currently they are done after the source of the
> >> migration is
> >>
> >> stopped, and before the workload is resumed at the destination. This
> >> is a
> >>
> >> period where neigher traffic can flow, nor the VM workload can continu=
e
> >>
> >> (downtime).
> >>
> >>
> >>
> >> We can do better as we know the memory layout of the guest RAM at the
> >>
> >> destination from the moment the migration starts.  Moving that
> >> operation allows
> >>
> >> QEMU to communicate the kernel the maps while the workload is still
> >> running in
> >>
> >> the source, so Linux can start mapping them.  Ideally, all IOMMU is
> >> configured,
> >>
> >> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're
> >> still
> >>
> >> saving all the pinning time.
> > I get what you want to say, though not sure how pinning is relevant to
> > on-chip IOMMU and .set_map here, essentially pinning is required for
> > all parent vdpa drivers that perform DMA hence don't want VM pages to
> > move around.
> >>
> >>
> >>
> >> Note that further devices setup at the end of the migration may alter
> >> the guest
> >>
> >> memory layout. But same as the previous point, many operations are
> >> still done
> >>
> >> incrementally, like memory pinning, so we're saving time anyway.
> >>
> >>
> >>
> >> The first bunch of patches just reorganizes the code, so memory relate=
d
> >>
> >> operation parameters are shared between all vhost_vdpa devices. This i=
s
> >>
> >> because the destination does not know what vhost_vdpa struct will
> >> have the
> >>
> >> registered listener member, so it is easier to place them in a shared
> >> struct
> >>
> >> rather to keep them in vhost_vdpa struct.  Future version may squash
> >> or omit
> >>
> >> these patches.
> > It looks this VhostVDPAShared facility (patch 1-13) is also what I
> > need in my SVQ descriptor group series [*], for which I've built
> > similar construct there. If possible please try to merge this in ASAP.
> > I'll rework my series on top of that.
> >
> > [*]
> > https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7=
dff3d6004fbcd5
> >
> >>
> >>
> >>
> >> Only tested with vdpa_sim. I'm sending this before full benchmark, as
> >> some work
> >>
> >> like [1] can be based on it, and Si-Wei agreed on benchmark this
> >> series with
> >>
> >> his experience.
> > Haven't done the full benchmark compared to pre-map at destination yet,
> Hi Eugenio,
>
> I just notice one thing that affects the performance benchmark for this
> series in terms of migration total_time (to be fair, it's mlx5_vdpa
> specific). It looks like iotlb map batching is not acked (via
> vhost_vdpa_set_backend_cap) at the point of vhost-vdpa_load_setup,
> effectively causing quite extensive time spent on hundreds of dma_map
> calls from listener_register().  While the equivalent code had been
> implemented in my destination pre-map patch [1]. Although I can
> benchmark the current patchset by remove batching from my code, I guess
> that's not the goal of this benchmark, right?
>
> If would be the best to have map batching in place, so benchmark for
> both options could match. What do you think?
>

This is definitely a bug I need to fix too, thanks for catching it!
:). But I'm not sure how this happens, as net_init_vhost_vdpa should
be called before .load_setup. I'll take a deeper look, thanks!

> Thanks,
> -Siwei
>
> [1]
> https://github.com/siwliu-kernel/qemu/commit/0ce225b0c7e618163ea09da3846c=
93c4de2f85ed#diff-45489c6f25dc36fd84e1cd28cbf3b8ff03301e2d24dadb6d1c334c9e8=
f14c00cR639
>
> > though an observation is that the destination QEMU seems very easy to
> > get stuck for very long time while in mid of pinning pages. During
> > this period, any client doing read-only QMP query or executing HMP
> > info command got frozen indefinitely (subject to how large size the
> > memory is being pinned). Is it possible to unblock those QMP request
> > or HMP command from being executed (at least the read-only ones) while
> > in migration? Yield from the load_setup corourtine and spawn another
> > thread?
> >
> > Having said, not sure if .load_setup is a good fit for what we want to
> > do. Searching all current users of .load_setup, either the job can be
> > done instantly or the task is time bound without trapping into kernel
> > for too long. Maybe pinning is too special use case here...
> >
> > -Siwei
> >>
> >>
> >>
> >> Future directions on top of this series may include:
> >>
> >> * Iterative migration of virtio-net devices, as it may reduce
> >> downtime per [1].
> >>
> >>    vhost-vdpa net can apply the configuration through CVQ in the
> >> destination
> >>
> >>    while the source is still migrating.
> >>
> >> * Move more things ahead of migration time, like DRIVER_OK.
> >>
> >> * Check that the devices of the destination are valid, and cancel the
> >> migration
> >>
> >>    in case it is not.
> >>
> >>
> >>
> >> [1]
> >> https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f6=
1@nvidia.com/T/
> >>
> >>
> >>
> >> Eugenio P=C3=A9rez (18):
> >>
> >>    vdpa: add VhostVDPAShared
> >>
> >>    vdpa: move iova tree to the shared struct
> >>
> >>    vdpa: move iova_range to vhost_vdpa_shared
> >>
> >>    vdpa: move shadow_data to vhost_vdpa_shared
> >>
> >>    vdpa: use vdpa shared for tracing
> >>
> >>    vdpa: move file descriptor to vhost_vdpa_shared
> >>
> >>    vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
> >>
> >>    vdpa: move backend_cap to vhost_vdpa_shared
> >>
> >>    vdpa: remove msg type of vhost_vdpa
> >>
> >>    vdpa: move iommu_list to vhost_vdpa_shared
> >>
> >>    vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
> >>
> >>    vdpa: use dev_shared in vdpa_iommu
> >>
> >>    vdpa: move memory listener to vhost_vdpa_shared
> >>
> >>    vdpa: do not set virtio status bits if unneeded
> >>
> >>    vdpa: add vhost_vdpa_load_setup
> >>
> >>    vdpa: add vhost_vdpa_net_load_setup NetClient callback
> >>
> >>    vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
> >>
> >>    virtio_net: register incremental migration handlers
> >>
> >>
> >>
> >>   include/hw/virtio/vhost-vdpa.h |  43 +++++---
> >>
> >>   include/net/net.h              |   4 +
> >>
> >>   hw/net/virtio-net.c            |  23 +++++
> >>
> >>   hw/virtio/vdpa-dev.c           |   7 +-
> >>
> >>   hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++-------------=
--
> >>
> >>   net/vhost-vdpa.c               | 127 ++++++++++++-----------
> >>
> >>   hw/virtio/trace-events         |  14 +--
> >>
> >>   7 files changed, 239 insertions(+), 162 deletions(-)
> >>
> >>
> >>
> >
>


