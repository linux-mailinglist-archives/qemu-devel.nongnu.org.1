Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F51A82D37A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:48:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDwu-0005N7-Ed; Sun, 14 Jan 2024 22:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDwp-0005MX-Dk
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDwn-0000UA-9C
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705290456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gY8R8TcpkGe0JsyWkszoHptkk7zlYk+kzpFr3A74aQ0=;
 b=UKoH7tlOrF2bQ3MNGmpi5n85tZ2OrKS+IGtR8iNh6b1FNsSu8LX0Gx15n0cA/ir43vMt/k
 hezHmgSfdtdSmAjjmekw+cfQh8WmV2fBmGen16IGzy+WEQwlOLodVfdWmDqGET+P4kaK9Y
 W/lnpGTY6iCOXelswHzJag6LWGpZv9o=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-8v_BwKlfNuWoUaSdhDmQIw-1; Sun, 14 Jan 2024 22:47:35 -0500
X-MC-Unique: 8v_BwKlfNuWoUaSdhDmQIw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6df2f0e8351so4578784a34.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705290454; x=1705895254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gY8R8TcpkGe0JsyWkszoHptkk7zlYk+kzpFr3A74aQ0=;
 b=sGe3F52DHHfYsR6EqWSfPPV/RX9eJmluCBUwxq69Z91n9kjT7NkaUZnc/mBUnLo/3K
 dLiCKUgZLqImO60+IHTuPg0cIQUBfDg0cVwFf3yFuFfLBGKi3MuhvgX78y9GsVJ+g+n6
 1/mf1/7/PybowApIYJ2rW39TtKDHS6hxEKyXWHoYnZCb9iD+96n+vi87JxF8Vokxgytt
 HwnFCp9efGXJGEf9oefig3+eN6UNZ8u406eUtaui9tIA51nFne2mKIMSQZjdg9+6plea
 OJQBIeGrh5Y+xtXzKPkql0WpZTXj8EczufdnPqIkRH4A2ED+/UfLYI0lFwavzi663kxB
 Me7A==
X-Gm-Message-State: AOJu0YzfRdqxTulgv8DvC+akOYx5GtCwKY7eGhE54UEjJqZr9/s49QqU
 UEeKb+x3OMhUfxPH47TMVCj2fyXXkFmRzQxXJ1ScGb1IjhY09ZHYHtRBQ5Dme0Q1Pul00+Rrfa3
 MUp7vNT8DdLREyBWuhsN51JevbxDNIuCqOddbAqi75CP1G4Y=
X-Received: by 2002:a05:6830:344e:b0:6dd:e970:1347 with SMTP id
 b14-20020a056830344e00b006dde9701347mr5127540otu.8.1705290453899; 
 Sun, 14 Jan 2024 19:47:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFygi0ZWRxQRkQA7KtTOzWvYRmVbJk53lIBa/Nj8mRldLFdSxueKJLqPI2IV/sYCzElIRGFmAGyyurSoQncwVw=
X-Received: by 2002:a05:6830:344e:b0:6dd:e970:1347 with SMTP id
 b14-20020a056830344e00b006dde9701347mr5127537otu.8.1705290453622; Sun, 14 Jan
 2024 19:47:33 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-34-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-34-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:47:21 +0800
Message-ID: <CACGkMEvo-WK8keSQWghfJuqBr9+hLzCrc7pOW9A-Uwc=t2GuMw@mail.gmail.com>
Subject: Re: [PATCH 33/40] vdpa: batch multiple dma_unmap to a single call for
 vm stop
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Should help live migration downtime on source host. Below are the
> coalesced dma_unmap time series on 2 queue pair config (no
> dedicated descriptor group ASID for SVQ).

It's better to explain how we can batch into a single call (e.g do we
batch at the level of a whole device?)

>
> 109531@1693367276.853503:vhost_vdpa_reset_device dev: 0x55c933926890
> 109531@1693367276.853513:vhost_vdpa_add_status dev: 0x55c933926890 status=
: 0x3
> 109531@1693367276.853520:vhost_vdpa_flush_map dev: 0x55c933926890 doit: 1=
 svq_flush: 0 persist: 1
> 109531@1693367276.853524:vhost_vdpa_set_config_call dev: 0x55c933926890 f=
d: -1
> 109531@1693367276.853579:vhost_vdpa_iotlb_begin_batch vdpa:0x7fa2aa895190=
 fd: 16 msg_type: 2 type: 5
> 109531@1693367276.853586:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x1000 size: 0x2000 type: 3
> 109531@1693367276.853600:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x3000 size: 0x1000 type: 3
> 109531@1693367276.853618:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x4000 size: 0x2000 type: 3
> 109531@1693367276.853625:vhost_vdpa_dma_unmap vdpa:0x7fa2aa895190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x6000 size: 0x1000 type: 3
> 109531@1693367276.853630:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x7000 size: 0x2000 type: 3
> 109531@1693367276.853636:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x9000 size: 0x1000 type: 3
> 109531@1693367276.853642:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 =
msg_type: 2 asid: 0 iova: 0xa000 size: 0x2000 type: 3
> 109531@1693367276.853648:vhost_vdpa_dma_unmap vdpa:0x7fa2aa84c190 fd: 16 =
msg_type: 2 asid: 0 iova: 0xc000 size: 0x1000 type: 3
> 109531@1693367276.853654:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 =
msg_type: 2 asid: 0 iova: 0xf000 size: 0x1000 type: 3
> 109531@1693367276.853660:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 =
msg_type: 2 asid: 0 iova: 0x10000 size: 0x1000 type: 3
> 109531@1693367276.853666:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 =
msg_type: 2 asid: 0 iova: 0xd000 size: 0x1000 type: 3
> 109531@1693367276.853670:vhost_vdpa_dma_unmap vdpa:0x7fa2aa6b6190 fd: 16 =
msg_type: 2 asid: 0 iova: 0xe000 size: 0x1000 type: 3
> 109531@1693367276.853675:vhost_vdpa_iotlb_end_batch vdpa:0x7fa2aa895190 f=
d: 16 msg_type: 2 type: 6
> 109531@1693367277.014697:vhost_vdpa_get_vq_index dev: 0x55c933925de0 idx:=
 0 vq idx: 0
> 109531@1693367277.014747:vhost_vdpa_get_vq_index dev: 0x55c933925de0 idx:=
 1 vq idx: 1
> 109531@1693367277.014753:vhost_vdpa_get_vq_index dev: 0x55c9339262e0 idx:=
 2 vq idx: 2
> 109531@1693367277.014756:vhost_vdpa_get_vq_index dev: 0x55c9339262e0 idx:=
 3 vq idx: 3
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c         |   7 +--
>  include/hw/virtio/vhost-vdpa.h |   3 ++
>  net/vhost-vdpa.c               | 112 +++++++++++++++++++++++++++--------=
------
>  3 files changed, 80 insertions(+), 42 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index d98704a..4010fd9 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1162,8 +1162,8 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_=
vdpa *v, hwaddr addr)
>      vhost_iova_tree_remove(v->shared->iova_tree, *result);
>  }
>
> -static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
> -                                       const VhostShadowVirtqueue *svq)
> +void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
> +                                const VhostShadowVirtqueue *svq)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
>      struct vhost_vring_addr svq_addr;
> @@ -1346,17 +1346,14 @@ static void vhost_vdpa_svqs_stop(struct vhost_dev=
 *dev)
>          return;
>      }
>
> -    vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
>      for (unsigned i =3D 0; i < v->shadow_vqs->len; ++i) {
>          VhostShadowVirtqueue *svq =3D g_ptr_array_index(v->shadow_vqs, i=
);
>
>          vhost_svq_stop(svq);
> -        vhost_vdpa_svq_unmap_rings(dev, svq);
>
>          event_notifier_cleanup(&svq->hdev_kick);
>          event_notifier_cleanup(&svq->hdev_call);
>      }
> -    vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
>  }
>
>  static void vhost_vdpa_suspend(struct vhost_dev *dev)
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index aa13679..f426e2c 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -112,6 +112,9 @@ int vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s,=
 uint32_t asid);
>  int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
>  int vhost_vdpa_load_cleanup(VhostVDPAShared *s, bool vhost_will_start);
>
> +void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
> +                                const VhostShadowVirtqueue *svq);
> +
>  typedef struct vdpa_iommu {
>      VhostVDPAShared *dev_shared;
>      IOMMUMemoryRegion *iommu_mr;
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 683619f..41714d1 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -29,6 +29,7 @@
>  #include "migration/migration.h"
>  #include "migration/misc.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-vdpa.h"
>
>  /* Todo:need to add the multiqueue support here */
>  typedef struct VhostVDPAState {
> @@ -467,15 +468,89 @@ static int vhost_vdpa_net_data_load(NetClientState =
*nc)
>      return 0;
>  }
>
> +static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
> +{
> +    VhostIOVATree *tree =3D v->shared->iova_tree;
> +    DMAMap needle =3D {
> +        /*
> +         * No need to specify size or to look for more translations sinc=
e
> +         * this contiguous chunk was allocated by us.
> +         */
> +        .translated_addr =3D (hwaddr)(uintptr_t)addr,
> +    };
> +    const DMAMap *map =3D vhost_iova_tree_find_iova(tree, &needle);
> +    int r;
> +
> +    if (unlikely(!map)) {
> +        error_report("Cannot locate expected map");
> +        return;
> +    }
> +
> +    r =3D vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova=
,
> +                             map->size + 1);
> +    if (unlikely(r !=3D 0)) {
> +        error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
> +    }
> +
> +    vhost_iova_tree_remove(tree, *map);
> +}
> +
>  static void vhost_vdpa_net_client_stop(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> +    struct vhost_vdpa *last_vi =3D NULL;

Nit: just curious what did "vi" mean here?

> +    bool has_cvq =3D v->dev->vq_index_end % 2;
> +    int nvqp;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
>      if (s->vhost_vdpa.index =3D=3D 0) {
>          migration_remove_notifier(&s->migration_state);
>      }
> +
> +    if (v->dev->vq_index + v->dev->nvqs !=3D v->dev->vq_index_end) {
> +        return;
> +    }
> +
> +    nvqp =3D (v->dev->vq_index_end + 1) / 2;
> +    for (int i =3D 0; i < nvqp; ++i) {
> +        VhostVDPAState *s_i =3D vhost_vdpa_net_get_nc_vdpa(s, i);
> +        struct vhost_vdpa *v_i =3D &s_i->vhost_vdpa;
> +
> +        if (!v_i->shadow_vqs_enabled) {
> +            continue;
> +        }
> +        if (!last_vi) {
> +            vhost_vdpa_dma_batch_begin_once(v_i->shared,
> +                                            v_i->address_space_id);
> +            last_vi =3D v_i;
> +        } else if (last_vi->address_space_id !=3D v_i->address_space_id)=
 {
> +            vhost_vdpa_dma_batch_end_once(last_vi->shared,
> +                                          last_vi->address_space_id);
> +            vhost_vdpa_dma_batch_begin_once(v_i->shared,
> +                                            v_i->address_space_id);
> +            last_vi =3D v_i;
> +        }
> +
> +        for (unsigned j =3D 0; j < v_i->shadow_vqs->len; ++j) {
> +            VhostShadowVirtqueue *svq =3D g_ptr_array_index(v_i->shadow_=
vqs, j);
> +
> +            vhost_vdpa_svq_unmap_rings(v_i->dev, svq);
> +        }
> +    }
> +    if (has_cvq) {
> +        if (last_vi) {
> +            assert(last_vi->address_space_id =3D=3D v->address_space_id)=
;
> +        }
> +        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer);
> +        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->status);
> +    }
> +    if (last_vi) {
> +        vhost_vdpa_dma_batch_end_once(last_vi->shared,
> +                                      last_vi->address_space_id);
> +        last_vi =3D NULL;
> +    }

The logic looks rather complicated, can we simplify it by:

batch_begin_once()
unmap()
batch_end_once()

?

Thanks


>  }
>
>  static int vhost_vdpa_net_load_setup(NetClientState *nc, NICState *nic)
> @@ -585,33 +660,6 @@ static int64_t vhost_vdpa_get_vring_desc_group(int d=
evice_fd,
>      return state.num;
>  }
>
> -static void vhost_vdpa_cvq_unmap_buf(struct vhost_vdpa *v, void *addr)
> -{
> -    VhostIOVATree *tree =3D v->shared->iova_tree;
> -    DMAMap needle =3D {
> -        /*
> -         * No need to specify size or to look for more translations sinc=
e
> -         * this contiguous chunk was allocated by us.
> -         */
> -        .translated_addr =3D (hwaddr)(uintptr_t)addr,
> -    };
> -    const DMAMap *map =3D vhost_iova_tree_find_iova(tree, &needle);
> -    int r;
> -
> -    if (unlikely(!map)) {
> -        error_report("Cannot locate expected map");
> -        return;
> -    }
> -
> -    r =3D vhost_vdpa_dma_unmap(v->shared, v->address_space_id, map->iova=
,
> -                             map->size + 1);
> -    if (unlikely(r !=3D 0)) {
> -        error_report("Device cannot unmap: %s(%d)", g_strerror(r), r);
> -    }
> -
> -    vhost_iova_tree_remove(tree, *map);
> -}
> -
>  /** Map CVQ buffer. */
>  static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_=
t size,
>                                    bool write)
> @@ -740,18 +788,8 @@ err:
>
>  static void vhost_vdpa_net_cvq_stop(NetClientState *nc)
>  {
> -    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> -    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> -
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> -    if (s->vhost_vdpa.shadow_vqs_enabled) {
> -        vhost_vdpa_dma_batch_begin_once(v->shared, v->address_space_id);
> -        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer);
> -        vhost_vdpa_cvq_unmap_buf(&s->vhost_vdpa, s->status);
> -        vhost_vdpa_dma_batch_end_once(v->shared, v->address_space_id);
> -    }
> -
>      vhost_vdpa_net_client_stop(nc);
>  }
>
> --
> 1.8.3.1
>


