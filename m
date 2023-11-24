Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF207F7A1A
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:13:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ZjA-00040I-J9; Fri, 24 Nov 2023 12:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6Zj9-000408-7C
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r6Zj7-0006sF-2D
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700845943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGLfC5ouN+xNSPBjDA816H5wPCra9oLm6JC4/TvdPkY=;
 b=AEpGebHRQ8f3TgxQpI5XchOtYK94JfAcZj1rEwUXq5OSc6fxKFiormXQM76iOplvoIVj5Q
 PfJkxKHToxxH7pVY7HtLwB7wbHvnp3AcAdiQwLpovlSkvFGclOVDxYctqv7wQmCT3LzSQJ
 3ynf8Z4h3iRxCEQHy4ZPzR7fG0nhN1E=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-rEDYqzS4OPu5vSDY0eFQdg-1; Fri, 24 Nov 2023 12:12:22 -0500
X-MC-Unique: rEDYqzS4OPu5vSDY0eFQdg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5ae5b12227fso27302167b3.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700845941; x=1701450741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGLfC5ouN+xNSPBjDA816H5wPCra9oLm6JC4/TvdPkY=;
 b=XxlUv3USfh/a8H3e8N0GFW7C8vQ/XWinOfM7iL5iOy9+oA2ln3uOpexRjmECB5jYRf
 JdGaHVKG/1PKfs7V7xRw/Uzj40obSUeenn9mwAnP1vk8gCi09wQUtUo23QyiF1Gl/gF5
 3t9dOx0o6k5YYB5Hj2VLK05MLJCaQobAvoEPz/0d5+tH6Dc8JvYpmDqEYeZ0VgCGjPU1
 29oe96p9TWeS3efqPcJJ9CgocFeNY0pflzaVRBYvc82/Ps74qHuG17rmLq+ReQbBb/sB
 oAfZ2vAl3k9j2dufmxYPWUltXAD+70bWi4MdnZG+QSZaUtxIXxXh+JtJTbpMfsHAs8fl
 ibVA==
X-Gm-Message-State: AOJu0YxQVvzM9GCteTVr5F3RClOkl7xQiU0fCy10WEj0TijaUD5JvTUi
 mdy3QdTa6R9IKURzJJzY0FnY5imkSdazyYWGMLyZ0SEZPo3z+JbiQ8xZnLuvtXQhAEee1t2Pj3a
 4uzGM6Cqu/1fgHeOBne05Ri9P4eHsadE=
X-Received: by 2002:a05:690c:4708:b0:5ce:dff:f79b with SMTP id
 gz8-20020a05690c470800b005ce0dfff79bmr2767309ywb.8.1700845941112; 
 Fri, 24 Nov 2023 09:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELVhKCl3hLHs8swIY/OYGbk0CIuFAX/6gB/wVjMpmw/3/v5pBZlSZkumwUqlLJ0VbtWubyyBUgbMAIOMV9gkA=
X-Received: by 2002:a05:690c:4708:b0:5ce:dff:f79b with SMTP id
 gz8-20020a05690c470800b005ce0dfff79bmr2767255ywb.8.1700845940580; Fri, 24 Nov
 2023 09:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
 <20231019143455.2377694-3-eperezma@redhat.com>
 <e263633d-7f80-4ed7-87d8-c9e824758e73@oracle.com>
In-Reply-To: <e263633d-7f80-4ed7-87d8-c9e824758e73@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 24 Nov 2023 18:11:44 +0100
Message-ID: <CAJaqyWcPUcj7ZWd8yx15y7SuxBMH_g6k_JpkZ=C8jOQfg9XfmA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/18] vdpa: move iova tree to the shared struct
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Nov 2, 2023 at 10:37=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/19/2023 7:34 AM, Eugenio P=C3=A9rez wrote:
> > Next patches will register the vhost_vdpa memory listener while the VM
> > is migrating at the destination, so we can map the memory to the device
> > before stopping the VM at the source.  The main goal is to reduce the
> > downtime.
> >
> > However, the destination QEMU is unaware of which vhost_vdpa device wil=
l
> > register its memory_listener.  If the source guest has CVQ enabled, it
> > will be the CVQ device.  Otherwise, it  will be the first one.
> >
> > Move the iova tree to VhostVDPAShared so all vhost_vdpa can use it,
> > rather than always in the first or last vhost_vdpa.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   include/hw/virtio/vhost-vdpa.h |  4 +--
> >   hw/virtio/vhost-vdpa.c         | 19 ++++++------
> >   net/vhost-vdpa.c               | 54 +++++++++++++++------------------=
-
> >   3 files changed, 35 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index eb1a56d75a..ac036055d3 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -32,6 +32,8 @@ typedef struct VhostVDPAHostNotifier {
> >
> >   /* Info shared by all vhost_vdpa device models */
> >   typedef struct vhost_vdpa_shared {
> > +    /* IOVA mapping used by the Shadow Virtqueue */
> > +    VhostIOVATree *iova_tree;
> >   } VhostVDPAShared;
> >
> >   typedef struct vhost_vdpa {
> > @@ -48,8 +50,6 @@ typedef struct vhost_vdpa {
> >       bool shadow_data;
> >       /* Device suspended successfully */
> >       bool suspended;
> > -    /* IOVA mapping used by the Shadow Virtqueue */
> > -    VhostIOVATree *iova_tree;
> >       VhostVDPAShared *shared;
> >       GPtrArray *shadow_vqs;
> >       const VhostShadowVirtqueueOps *shadow_vq_ops;
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 819b2d811a..9cee38cb6d 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -358,7 +358,7 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
> >           mem_region.size =3D int128_get64(llsize) - 1,
> >           mem_region.perm =3D IOMMU_ACCESS_FLAG(true, section->readonly=
),
> >
> > -        r =3D vhost_iova_tree_map_alloc(v->iova_tree, &mem_region);
> > +        r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &mem_reg=
ion);
> >           if (unlikely(r !=3D IOVA_OK)) {
> >               error_report("Can't allocate a mapping (%d)", r);
> >               goto fail;
> > @@ -379,7 +379,7 @@ static void vhost_vdpa_listener_region_add(MemoryLi=
stener *listener,
> >
> >   fail_map:
> >       if (v->shadow_data) {
> > -        vhost_iova_tree_remove(v->iova_tree, mem_region);
> > +        vhost_iova_tree_remove(v->shared->iova_tree, mem_region);
> >       }
> >
> >   fail:
> > @@ -441,13 +441,13 @@ static void vhost_vdpa_listener_region_del(Memory=
Listener *listener,
> >               .size =3D int128_get64(llsize) - 1,
> >           };
> >
> > -        result =3D vhost_iova_tree_find_iova(v->iova_tree, &mem_region=
);
> > +        result =3D vhost_iova_tree_find_iova(v->shared->iova_tree, &me=
m_region);
> >           if (!result) {
> >               /* The memory listener map wasn't mapped */
> >               return;
> >           }
> >           iova =3D result->iova;
> > -        vhost_iova_tree_remove(v->iova_tree, *result);
> > +        vhost_iova_tree_remove(v->shared->iova_tree, *result);
> >       }
> >       vhost_vdpa_iotlb_batch_begin_once(v);
> >       /*
> > @@ -1059,7 +1059,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhos=
t_vdpa *v, hwaddr addr)
> >       const DMAMap needle =3D {
> >           .translated_addr =3D addr,
> >       };
> > -    const DMAMap *result =3D vhost_iova_tree_find_iova(v->iova_tree, &=
needle);
> > +    const DMAMap *result =3D vhost_iova_tree_find_iova(v->shared->iova=
_tree,
> > +                                                     &needle);
> >       hwaddr size;
> >       int r;
> >
> > @@ -1075,7 +1076,7 @@ static void vhost_vdpa_svq_unmap_ring(struct vhos=
t_vdpa *v, hwaddr addr)
> >           return;
> >       }
> >
> > -    vhost_iova_tree_remove(v->iova_tree, *result);
> > +    vhost_iova_tree_remove(v->shared->iova_tree, *result);
> >   }
> >
> >   static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
> > @@ -1103,7 +1104,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_=
vdpa *v, DMAMap *needle,
> >   {
> >       int r;
> >
> > -    r =3D vhost_iova_tree_map_alloc(v->iova_tree, needle);
> > +    r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
> >       if (unlikely(r !=3D IOVA_OK)) {
> >           error_setg(errp, "Cannot allocate iova (%d)", r);
> >           return false;
> > @@ -1115,7 +1116,7 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_=
vdpa *v, DMAMap *needle,
> >                              needle->perm =3D=3D IOMMU_RO);
> >       if (unlikely(r !=3D 0)) {
> >           error_setg_errno(errp, -r, "Cannot map region to device");
> > -        vhost_iova_tree_remove(v->iova_tree, *needle);
> > +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
> >       }
> >
> >       return r =3D=3D 0;
> > @@ -1216,7 +1217,7 @@ static bool vhost_vdpa_svqs_start(struct vhost_de=
v *dev)
> >               goto err;
> >           }
> >
> > -        vhost_svq_start(svq, dev->vdev, vq, v->iova_tree);
> > +        vhost_svq_start(svq, dev->vdev, vq, v->shared->iova_tree);
> >           ok =3D vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
> >           if (unlikely(!ok)) {
> >               goto err_map;
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index a2f9855288..15e7579b13 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -345,8 +345,8 @@ static void vhost_vdpa_net_data_start_first(VhostVD=
PAState *s)
> >
> >       add_migration_state_change_notifier(&s->migration_state);
> >       if (v->shadow_vqs_enabled) {
> > -        v->iova_tree =3D vhost_iova_tree_new(v->iova_range.first,
> > -                                           v->iova_range.last);
> > +        v->shared->iova_tree =3D vhost_iova_tree_new(v->iova_range.fir=
st,
> > +                                                   v->iova_range.last)=
;
> This code change is okay so far without .load_setup involved, but if
> interacting with .load_setup the iova_tree can be NULL when x-svq=3Don.
> Below is a stacktrace showing the problem.
>

Right, the next version of the series including .load_setup will take
this into account. Thanks!

> #0  0x00005582bf00944c in vhost_iova_tree_map_alloc (tree=3D0x0,
> map=3Dmap@entry=3D0x7fb16bfffde0) at ../hw/virtio/vhost-iova-tree.c:89
> #1  0x00005582bee8cdb3 in vhost_vdpa_listener_region_add
> (listener=3D0x5582c138ee58, section=3D0x7fb16bfffe50)
>      at ../include/qemu/int128.h:33
> #2  0x00005582bf029d4b in memory_listener_register (as=3D0x5582bfb53d20
> <address_space_memory>, listener=3D0x5582c138ee58)
>      at ../system/memory.c:3026
> #3  0x00005582bf029d4b in memory_listener_register
> (listener=3D0x5582c138ee58, as=3D0x5582bfb53d20 <address_space_memory>)
>      at ../system/memory.c:3096
> #4  0x00005582bee8e712 in vhost_vdpa_load_setup (shared=3D0x5582c138ee50,
> dma_as=3D0x5582bfb53d20 <address_space_memory>)
>      at ../hw/virtio/vhost-vdpa.c:1550
> #5  0x00005582bef0b7df in vhost_vdpa_net_load_setup (nc=3D0x7fb172a27010,
> nic=3D<optimized out>) at ../net/vhost-vdpa.c:415
> #6  0x00005582beeeb4f5 in qemu_loadvm_state (f=3D0x5582c1c1a800) at
> ../migration/savevm.c:2682
> #7  0x00005582beeeb4f5 in qemu_loadvm_state (f=3D0x5582c1c1a800) at
> ../migration/savevm.c:2866
> #8  0x00005582beed5e17 in process_incoming_migration_co
> (opaque=3D<optimized out>) at ../migration/migration.c:548
> #9  0x00005582bf21b29b in coroutine_trampoline (i0=3D<optimized out>,
> i1=3D<optimized out>) at ../util/coroutine-ucontext.c:177
> #10 0x00007fb16e448190 in __start_context () at /lib64/libc.so.6
>
> -Siwei
> >       }
> >   }
> >
> > @@ -371,11 +371,6 @@ static int vhost_vdpa_net_data_start(NetClientStat=
e *nc)
> >           return 0;
> >       }
> >
> > -    if (v->shadow_vqs_enabled) {
> > -        VhostVDPAState *s0 =3D vhost_vdpa_net_first_nc_vdpa(s);
> > -        v->iova_tree =3D s0->vhost_vdpa.iova_tree;
> > -    }
> > -
> >       return 0;
> >   }
> >
> > @@ -408,9 +403,8 @@ static void vhost_vdpa_net_client_stop(NetClientSta=
te *nc)
> >
> >       dev =3D s->vhost_vdpa.dev;
> >       if (dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end) {
> > -        g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_dele=
te);
> > -    } else {
> > -        s->vhost_vdpa.iova_tree =3D NULL;
> > +        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
> > +                        vhost_iova_tree_delete);
> >       }
> >   }
> >
> > @@ -464,7 +458,7 @@ static int vhost_vdpa_set_address_space_id(struct v=
host_vdpa *v,
> >
> >   static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr=
)
> >   {
> > -    VhostIOVATree *tree =3D v->iova_tree;
> > +    VhostIOVATree *tree =3D v->shared->iova_tree;
> >       DMAMap needle =3D {
> >           /*
> >            * No need to specify size or to look for more translations s=
ince
> > @@ -498,7 +492,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa=
 *v, void *buf, size_t size,
> >       map.translated_addr =3D (hwaddr)(uintptr_t)buf;
> >       map.size =3D size - 1;
> >       map.perm =3D write ? IOMMU_RW : IOMMU_RO,
> > -    r =3D vhost_iova_tree_map_alloc(v->iova_tree, &map);
> > +    r =3D vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
> >       if (unlikely(r !=3D IOVA_OK)) {
> >           error_report("Cannot map injected element");
> >           return r;
> > @@ -513,7 +507,7 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa=
 *v, void *buf, size_t size,
> >       return 0;
> >
> >   dma_map_err:
> > -    vhost_iova_tree_remove(v->iova_tree, map);
> > +    vhost_iova_tree_remove(v->shared->iova_tree, map);
> >       return r;
> >   }
> >
> > @@ -573,24 +567,22 @@ out:
> >           return 0;
> >       }
> >
> > -    if (s0->vhost_vdpa.iova_tree) {
> > -        /*
> > -         * SVQ is already configured for all virtqueues.  Reuse IOVA t=
ree for
> > -         * simplicity, whether CVQ shares ASID with guest or not, beca=
use:
> > -         * - Memory listener need access to guest's memory addresses a=
llocated
> > -         *   in the IOVA tree.
> > -         * - There should be plenty of IOVA address space for both ASI=
D not to
> > -         *   worry about collisions between them.  Guest's translation=
s are
> > -         *   still validated with virtio virtqueue_pop so there is no =
risk for
> > -         *   the guest to access memory that it shouldn't.
> > -         *
> > -         * To allocate a iova tree per ASID is doable but it complicat=
es the
> > -         * code and it is not worth it for the moment.
> > -         */
> > -        v->iova_tree =3D s0->vhost_vdpa.iova_tree;
> > -    } else {
> > -        v->iova_tree =3D vhost_iova_tree_new(v->iova_range.first,
> > -                                           v->iova_range.last);
> > +    /*
> > +     * If other vhost_vdpa already have an iova_tree, reuse it for sim=
plicity,
> > +     * whether CVQ shares ASID with guest or not, because:
> > +     * - Memory listener need access to guest's memory addresses alloc=
ated in
> > +     *   the IOVA tree.
> > +     * - There should be plenty of IOVA address space for both ASID no=
t to
> > +     *   worry about collisions between them.  Guest's translations ar=
e still
> > +     *   validated with virtio virtqueue_pop so there is no risk for t=
he guest
> > +     *   to access memory that it shouldn't.
> > +     *
> > +     * To allocate a iova tree per ASID is doable but it complicates t=
he code
> > +     * and it is not worth it for the moment.
> > +     */
> > +    if (!v->shared->iova_tree) {
> > +        v->shared->iova_tree =3D vhost_iova_tree_new(v->iova_range.fir=
st,
> > +                                                   v->iova_range.last)=
;
> >       }
> >
> >       r =3D vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffe=
r,
>


