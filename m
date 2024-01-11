Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AABD82A8B0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:04:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNq1F-0000dE-G0; Thu, 11 Jan 2024 03:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNq1D-0000cq-9F
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNq1B-0000Ue-9d
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704960143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgZJ5VE20XHZlgv3iiJ2wRKQI3NvQwwqtBPLW+u0l7c=;
 b=Pu+cCjT8VE6zvrp/K0T9yvVy0iNJNLf0wSvpOwyUr3hj26f1BAmMKgFYSzdgJdh2NVhDhm
 AyiQErpr3h7tYtgRKDCjGK6WuWQdz2TH6+R6CdtZwkwL/oKXcvjMyfgJiRUNtFicTbd0a/
 LPSeO7/9pM3ER9TvaSmXP+8fN9CJNVY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-GVic6GkUNhuPlPig2OTYXg-1; Thu, 11 Jan 2024 03:02:21 -0500
X-MC-Unique: GVic6GkUNhuPlPig2OTYXg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bca5524924so6846267b6e.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:02:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704960141; x=1705564941;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgZJ5VE20XHZlgv3iiJ2wRKQI3NvQwwqtBPLW+u0l7c=;
 b=Xu75VbhsSn4OBSVApRf3VPy2Z/R52rZVYA20gt/ubH4+mVa9LMHNntxBevSvbFmhXP
 YTFKzhFK/fCpag4kGZ4TP8jElPXT1MlIMVgp9Fc3oiZkVm7WoYRr6YLFdHXKUm98bWzT
 L/sQrEg/P655BBTBMh/48V65fRQ/Cg3Dnw/VOntUVdImufAxq6MwJbWJJVYI4UBMicFi
 8emSx7NsXV1qCq2/mbdCbQGGQaJBX9dObgB6gGYWK2SCqzcU9o9NV1ini6BKE6eeqoUd
 cgmXZCeSyUB4aU4mU3U/OFZvv7ZPE4kvwo3CjOjqAJkj/q3MMujXYRfHdl4SGp2lvEW4
 nn4g==
X-Gm-Message-State: AOJu0Yz4tsNmOUgivKkBRP7ShDhslcPVe4XQRspAWw7nIYwjsE8ir+IT
 fMeNl0Rn4Kk8gHrr8kAdKy/APUyW5EcC2r7tPTkIw+ZK0EnJi7oxji+q/5lo2bSznOUxcQuNUJc
 GOoWU8m6FuGcbUWlFux4uCi+5LLG9FIsUU0va5Mk=
X-Received: by 2002:a05:6358:89e:b0:175:694b:b742 with SMTP id
 m30-20020a056358089e00b00175694bb742mr879991rwj.52.1704960141032; 
 Thu, 11 Jan 2024 00:02:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDSp/L3sdu0l9RI2r8m3G0Nx3SN3U8Gcb5SY19vY+7K4Cws4jTOc29INTkcD9h9jBqyKjJxtpbUfYJSkkQWSM=
X-Received: by 2002:a05:6358:89e:b0:175:694b:b742 with SMTP id
 m30-20020a056358089e00b00175694bb742mr879955rwj.52.1704960139589; Thu, 11 Jan
 2024 00:02:19 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-11-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-11-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:02:08 +0800
Message-ID: <CACGkMEsR0rVQzk-1OAHcALfkVevq1M24ms=26feEr5h34rNg+g@mail.gmail.com>
Subject: Re: [PATCH 10/40] vdpa: assign svq descriptors a separate ASID when
 possible
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> When backend supports the VHOST_BACKEND_F_DESC_ASID feature
> and all the data vqs can support one or more descriptor group
> to host SVQ vrings and descriptors, we assign them a different
> ASID than where its buffers reside in guest memory address
> space. With this dedicated ASID for SVQs, the IOVA for what
> vdpa device may care effectively becomes the GPA, thus there's
> no need to translate IOVA address. For this reason, shadow_data
> can be turned off accordingly. It doesn't mean the SVQ is not
> enabled, but just that the translation is not needed from iova
> tree perspective.
>
> We can reuse CVQ's address space ID to host SVQ descriptors
> because both CVQ and SVQ are emulated in the same QEMU
> process, which will share the same VA address space.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c |  5 ++++-
>  net/vhost-vdpa.c       | 57 ++++++++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 24844b5..30dff95 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -627,6 +627,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, voi=
d *opaque, Error **errp)
>      uint64_t qemu_backend_features =3D 0x1ULL << VHOST_BACKEND_F_IOTLB_M=
SG_V2 |
>                                       0x1ULL << VHOST_BACKEND_F_IOTLB_BAT=
CH |
>                                       0x1ULL << VHOST_BACKEND_F_IOTLB_ASI=
D |
> +                                     0x1ULL << VHOST_BACKEND_F_DESC_ASID=
 |
>                                       0x1ULL << VHOST_BACKEND_F_SUSPEND;
>      int ret;
>
> @@ -1249,7 +1250,9 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev =
*dev)
>              goto err;
>          }
>
> -        vhost_svq_start(svq, dev->vdev, vq, v->shared->iova_tree);
> +        vhost_svq_start(svq, dev->vdev, vq,
> +                        v->desc_group >=3D 0 && v->address_space_id ?
> +                        NULL : v->shared->iova_tree);

Nit: it might be a little bit more clear if we use a helper to check
like vhost_svq_needs _iova_tree()

>          ok =3D vhost_vdpa_svq_map_rings(dev, svq, &addr, &err);
>          if (unlikely(!ok)) {
>              goto err_map;
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 2555897..aebaa53 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -366,20 +366,50 @@ static int vhost_vdpa_set_address_space_id(struct v=
host_vdpa *v,
>  static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>  {
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> +    int r;
>
>      migration_add_notifier(&s->migration_state,
>                             vdpa_net_migration_state_notifier);
>
> +    if (!v->shadow_vqs_enabled) {
> +        if (v->desc_group >=3D 0 &&
> +            v->address_space_id !=3D VHOST_VDPA_GUEST_PA_ASID) {
> +            vhost_vdpa_set_address_space_id(v, v->desc_group,
> +                                            VHOST_VDPA_GUEST_PA_ASID);
> +            s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;
> +        }
> +        return;
> +    }
> +
>      /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
> -    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
> +    if (!v->shared->iova_tree) {
>          v->shared->iova_tree =3D vhost_iova_tree_new(v->shared->iova_ran=
ge.first,
>                                                     v->shared->iova_range=
.last);
>      }
> +
> +    if (s->always_svq || v->desc_group < 0) {

I think the always_svq mode deserves a TODO there since it can utilize
the desc_group actually?

> +        return;
> +    }
> +
> +    r =3D vhost_vdpa_set_address_space_id(v, v->desc_group,
> +                                        VHOST_VDPA_NET_CVQ_ASID);

Any reason why we only set the descriptor group for the first nc?

(This seems implies the device has one descriptor group for all
virtqueue which might not be true)

> +    if (unlikely(r < 0)) {
> +        /* The other data vqs should also fall back to using the same AS=
ID */
> +        s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;
> +        return;
> +    }
> +
> +    /* No translation needed on data SVQ when descriptor group is used *=
/
> +    s->vhost_vdpa.address_space_id =3D VHOST_VDPA_NET_CVQ_ASID;
> +    s->vhost_vdpa.shared->shadow_data =3D false;
> +    return;
>  }
>
>  static int vhost_vdpa_net_data_start(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    VhostVDPAState *s0 =3D vhost_vdpa_net_first_nc_vdpa(s);
> +
>      struct vhost_vdpa *v =3D &s->vhost_vdpa;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> @@ -397,6 +427,18 @@ static int vhost_vdpa_net_data_start(NetClientState =
*nc)
>          return 0;
>      }
>
> +    if (v->desc_group >=3D 0 && v->desc_group !=3D s0->vhost_vdpa.desc_g=
roup) {
> +        unsigned asid;
> +        asid =3D v->shadow_vqs_enabled ?
> +            s0->vhost_vdpa.address_space_id : VHOST_VDPA_GUEST_PA_ASID;
> +        if (asid !=3D s->vhost_vdpa.address_space_id) {
> +            vhost_vdpa_set_address_space_id(v, v->desc_group, asid);
> +        }
> +        s->vhost_vdpa.address_space_id =3D asid;

Can we unify the logic for nc0 and others here?

Then we don't need the trick in start_fisrt().

> +    } else {
> +        s->vhost_vdpa.address_space_id =3D s0->vhost_vdpa.address_space_=
id;
> +    }
> +
>      return 0;
>  }
>
> @@ -603,13 +645,19 @@ static int vhost_vdpa_net_cvq_start(NetClientState =
*nc)
>          return 0;
>      }
>
> -    if (!s->cvq_isolated) {
> +    if (!s->cvq_isolated && v->desc_group < 0) {
> +        if (s0->vhost_vdpa.shadow_vqs_enabled &&
> +            s0->vhost_vdpa.desc_group >=3D 0 &&

I think we should fail if v->desc_group < 0 but s0->vhost_vdpa.desc_group >=
=3D 0 ?

> +            s0->vhost_vdpa.address_space_id) {

If this is a check for VHOST_VDPA_GUEST_PA_ASID, let's explicitly
check it against the macro here.

But it's not clear to me the logic here:

It looks to me like the code tries to work when CVQ is not isolated,
is this intended? This makes the logic rather complicated here.

Thanks


> +            v->shadow_vqs_enabled =3D false;
> +        }
>          return 0;
>      }
>
> -    cvq_group =3D vhost_vdpa_get_vring_group(v->shared->device_fd,
> +    cvq_group =3D s->cvq_isolated ?
> +                vhost_vdpa_get_vring_group(v->shared->device_fd,
>                                             v->dev->vq_index_end - 1,
> -                                           &err);
> +                                           &err) : v->desc_group;
>      if (unlikely(cvq_group < 0)) {
>          error_report_err(err);
>          return cvq_group;
> @@ -1840,6 +1888,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      s->always_svq =3D svq;
>      s->migration_state.notify =3D NULL;
>      s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> +    s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;
>      if (queue_pair_index =3D=3D 0) {
>          vhost_vdpa_net_valid_svq_features(features,
>                                            &s->vhost_vdpa.migration_block=
er);
> --
> 1.8.3.1
>


