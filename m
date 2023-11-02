Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9CC7DF2A0
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:39:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWxk-0003IC-FR; Thu, 02 Nov 2023 08:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyWxe-0003FD-8i
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyWxc-0004wA-4B
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698928682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fnnAexCwTYubqGPe4F+xgTrNyik5xqPnQaSYNm6ADw=;
 b=LMvQVR1HOHhogYDc0sRl82Q5xt0/m8LPayrp6Sc2VjLQOKFv8O/HTnWU58HSxqtJ3PRk0e
 NEDwJg9VvWUCl+ie4eRhPMhXEZ2z3v5b+vF05DUPw02ZDgc7qRysQW7l7IcEC4bt0kSbaK
 CqO6VFmMb0OFPd0G1yHzODOWB/0UC1g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-N8MUFHunPaitb6x_cv5ABw-1; Thu, 02 Nov 2023 08:38:01 -0400
X-MC-Unique: N8MUFHunPaitb6x_cv5ABw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5a8d9dcdd2bso18774867b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698928680; x=1699533480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fnnAexCwTYubqGPe4F+xgTrNyik5xqPnQaSYNm6ADw=;
 b=h4qTMxjnll6GPC1YC+cn6Nrebybq2W1It86sUe732PprVJGrmWa1W+heID4tzclHf6
 xP8Cm6cAwMYLQ2qEdn8OmCdRjdfkEGebczfzDM5khlplKrYoFij8eGQE2MvZzqTycikQ
 FcJr6+hD28mQx/EFfS9x96xKZSvcTIWtT2Eq2obXno26JDNWuiK43zVUDzoq1gR6Flh/
 KpeoiDVCjkKiMfBpd+nfWqipoMfvTZkgbHvUTIzNcBNYzdtdxFtCXUpxmORm39HuugIC
 KuuJFaXlHRPFjJKLsDLkFL8uC6EIt3L7ByKsCDRTwN3JMXx9B2uErahIuP9B58OKrN0b
 u3RA==
X-Gm-Message-State: AOJu0YyLzS9lJYF5k8ERza48JWv0qKNX7A2rj49nucWrciQBdcppjDDY
 iP3iKoCmLvK2HIHRqGgiWmyog7jV7lCmxzemJHBrRvn/ZH9DOR5HC9oo6BTdcsCjJG8kR0OjZvM
 gxFvkOJR7Fs4k4qw5K+D/okoOAUU3iGc=
X-Received: by 2002:a81:c80a:0:b0:5a7:b918:26be with SMTP id
 n10-20020a81c80a000000b005a7b91826bemr17177210ywi.15.1698928680599; 
 Thu, 02 Nov 2023 05:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZbyAZNezvIHI+AeavB8e+9QWSVK9W0IxRlgPeUP+aG9nBoz82GjujQR0lLCTtSrDF1xXnY0+GWheteIAyHIk=
X-Received: by 2002:a81:c80a:0:b0:5a7:b918:26be with SMTP id
 n10-20020a81c80a000000b005a7b91826bemr17177180ywi.15.1698928680293; Thu, 02
 Nov 2023 05:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
In-Reply-To: <1e565b27-2897-4063-8eff-e42cfd5934c2@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 2 Nov 2023 13:37:23 +0100
Message-ID: <CAJaqyWeOG0Eoc8W9FYFzJ9r1ENd3Cd1oLGF=ggJvWth2xD6u9A@mail.gmail.com>
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
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 2, 2023 at 11:13=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> > Current memory operations like pinning may take a lot of time at the
> >
> > destination.  Currently they are done after the source of the migration=
 is
> >
> > stopped, and before the workload is resumed at the destination.  This i=
s a
> >
> > period where neigher traffic can flow, nor the VM workload can continue
> >
> > (downtime).
> >
> >
> >
> > We can do better as we know the memory layout of the guest RAM at the
> >
> > destination from the moment the migration starts.  Moving that operatio=
n allows
> >
> > QEMU to communicate the kernel the maps while the workload is still run=
ning in
> >
> > the source, so Linux can start mapping them.  Ideally, all IOMMU is con=
figured,
> >
> > but if the vDPA parent driver uses on-chip IOMMU and .set_map we're sti=
ll
> >
> > saving all the pinning time.
> I get what you want to say, though not sure how pinning is relevant to
> on-chip IOMMU and .set_map here, essentially pinning is required for all
> parent vdpa drivers that perform DMA hence don't want VM pages to move
> around.

Basically highlighting that the work done under .set_map is not only
pinning, but it is a significant fraction on it. It can be reworded or
deleted for sure.

> >
> >
> >
> > Note that further devices setup at the end of the migration may alter t=
he guest
> >
> > memory layout. But same as the previous point, many operations are stil=
l done
> >
> > incrementally, like memory pinning, so we're saving time anyway.
> >
> >
> >
> > The first bunch of patches just reorganizes the code, so memory related
> >
> > operation parameters are shared between all vhost_vdpa devices.  This i=
s
> >
> > because the destination does not know what vhost_vdpa struct will have =
the
> >
> > registered listener member, so it is easier to place them in a shared s=
truct
> >
> > rather to keep them in vhost_vdpa struct.  Future version may squash or=
 omit
> >
> > these patches.
> It looks this VhostVDPAShared facility (patch 1-13) is also what I need
> in my SVQ descriptor group series [*], for which I've built similar
> construct there. If possible please try to merge this in ASAP. I'll
> rework my series on top of that.
>
> [*]
> https://github.com/siwliu-kernel/qemu/commit/813518354af5ee8a6e867b2bf7df=
f3d6004fbcd5
>

I can send it individually, for sure.

MST, Jason, can this first part be merged? It doesn't add a lot by
itself but it helps pave the way for future changes.

> >
> >
> >
> > Only tested with vdpa_sim. I'm sending this before full benchmark, as s=
ome work
> >
> > like [1] can be based on it, and Si-Wei agreed on benchmark this series=
 with
> >
> > his experience.
> Haven't done the full benchmark compared to pre-map at destination yet,
> though an observation is that the destination QEMU seems very easy to
> get stuck for very long time while in mid of pinning pages. During this
> period, any client doing read-only QMP query or executing HMP info
> command got frozen indefinitely (subject to how large size the memory is
> being pinned). Is it possible to unblock those QMP request or HMP
> command from being executed (at least the read-only ones) while in
> migration? Yield from the load_setup corourtine and spawn another thread?
>

Ok, I wasn't aware of that.

I think we cannot yield in a coroutine and wait for an ioctl. One
option that came to my mind is to effectively use another thread, and
use a POSIX barrier (or equivalent on glib / QEMU) before finishing
the migration. I'm not sure if there are more points where we can
check the barrier and tell the migration to continue or stop though.

Another option is to effectively start doing these ioctls in an
asynchronous way, io_uring cmds like, but I'd like to achieve this
first.

> Having said, not sure if .load_setup is a good fit for what we want to
> do. Searching all current users of .load_setup, either the job can be
> done instantly or the task is time bound without trapping into kernel
> for too long. Maybe pinning is too special use case here...
>
> -Siwei
> >
> >
> >
> > Future directions on top of this series may include:
> >
> > * Iterative migration of virtio-net devices, as it may reduce downtime =
per [1].
> >
> >    vhost-vdpa net can apply the configuration through CVQ in the destin=
ation
> >
> >    while the source is still migrating.
> >
> > * Move more things ahead of migration time, like DRIVER_OK.
> >
> > * Check that the devices of the destination are valid, and cancel the m=
igration
> >
> >    in case it is not.
> >
> >
> >
> > [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a56=
6f61@nvidia.com/T/
> >
> >
> >
> > Eugenio P=C3=A9rez (18):
> >
> >    vdpa: add VhostVDPAShared
> >
> >    vdpa: move iova tree to the shared struct
> >
> >    vdpa: move iova_range to vhost_vdpa_shared
> >
> >    vdpa: move shadow_data to vhost_vdpa_shared
> >
> >    vdpa: use vdpa shared for tracing
> >
> >    vdpa: move file descriptor to vhost_vdpa_shared
> >
> >    vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
> >
> >    vdpa: move backend_cap to vhost_vdpa_shared
> >
> >    vdpa: remove msg type of vhost_vdpa
> >
> >    vdpa: move iommu_list to vhost_vdpa_shared
> >
> >    vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
> >
> >    vdpa: use dev_shared in vdpa_iommu
> >
> >    vdpa: move memory listener to vhost_vdpa_shared
> >
> >    vdpa: do not set virtio status bits if unneeded
> >
> >    vdpa: add vhost_vdpa_load_setup
> >
> >    vdpa: add vhost_vdpa_net_load_setup NetClient callback
> >
> >    vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
> >
> >    virtio_net: register incremental migration handlers
> >
> >
> >
> >   include/hw/virtio/vhost-vdpa.h |  43 +++++---
> >
> >   include/net/net.h              |   4 +
> >
> >   hw/net/virtio-net.c            |  23 +++++
> >
> >   hw/virtio/vdpa-dev.c           |   7 +-
> >
> >   hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++--------------=
-
> >
> >   net/vhost-vdpa.c               | 127 ++++++++++++-----------
> >
> >   hw/virtio/trace-events         |  14 +--
> >
> >   7 files changed, 239 insertions(+), 162 deletions(-)
> >
> >
> >
>


