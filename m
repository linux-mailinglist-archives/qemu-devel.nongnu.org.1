Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4289780CB1F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgSO-0002h3-5t; Mon, 11 Dec 2023 08:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCgSL-0002gr-Sy
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCgSK-0002zh-4t
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702301779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akGQonHdMCMiPRWmwjmqN5yGIIcC/wv45tqQZzva9l4=;
 b=BqvFSuAJdgixoHajqso7AioTWIADkGqUKxt2t15vNnSXMIVGxoyQfzyMDK25gYNS7Hj+LA
 PO1/HlzXirhY2hlfmFnqVm++33RTVGsHD1VtfOVS+kraZQDmLX793NPFk1GCg+vjmNfd4q
 joVB/Te5/AlquDbq6lKROAo5rgIJNZc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-pJVmQo_gMwKn2Xoph8IwDg-1; Mon, 11 Dec 2023 08:36:18 -0500
X-MC-Unique: pJVmQo_gMwKn2Xoph8IwDg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5de8c2081d1so34728427b3.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702301777; x=1702906577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akGQonHdMCMiPRWmwjmqN5yGIIcC/wv45tqQZzva9l4=;
 b=jBEIxePRW+fE7mUpaMrCoHMGdm5EKv6trwNQ6x/iCO/k89iSOnOt5jXwp2Knr72R0P
 DbygAfSpIrTjHRaXxOQwxRiTWky9BE3oBriLsVXt8PX5uRWTVGS3lS6CwPUKQd+Y8mnZ
 nP4fOCZoujjOaEgUtpUZ6AsGUxpLY4AqAxyo9zUPeP3f62l1c0v4eGbhU0Zmo8KWok7R
 pzW/nyX2qLRxyWnjbd5wF6Mp4z6RjcGrUR229HOeNKPNrSkzYd6OJrTQQFiJKFAimYcc
 kRLV1EDCy0eMrT9S5x1U0IX6YfVi/Hn59EmqKlbGY0m/7SSPHvw//5giw3Ov17wlfhU8
 9qxg==
X-Gm-Message-State: AOJu0Yx/C6p+Kgs2hYt6o/7JuSdhPFRQllGzjXc+he8hVmD+ihuYuc1W
 fu5WV2nazWFtRXbNkpe6XvdZoPpV7JGgsOwqkub1LXOXHpVE+EPGWwfsGQw2oQZ7+6Xl9ZlHZsk
 Fp0KCXivKZw45H9kN9BJUFXUd9YKdE2U=
X-Received: by 2002:a0d:ee01:0:b0:5d7:1941:aa6 with SMTP id
 x1-20020a0dee01000000b005d719410aa6mr3264531ywe.65.1702301777389; 
 Mon, 11 Dec 2023 05:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqILcdx5fd7fi9indR9RvMzLNfepZ8cHUVw+G1Hlxi7Nu9veyMibniKMepICpibiIzzBDuWZB+nAlW2BSrYDQ=
X-Received: by 2002:a0d:ee01:0:b0:5d7:1941:aa6 with SMTP id
 x1-20020a0dee01000000b005d719410aa6mr3264515ywe.65.1702301777047; Mon, 11 Dec
 2023 05:36:17 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-11-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-11-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 14:35:40 +0100
Message-ID: <CAJaqyWfpaZkdbzOeqqrScjD89EYtaC77-SzrgTEtPDLDq6mr3g@mail.gmail.com>
Subject: Re: [PATCH 10/40] vdpa: assign svq descriptors a separate ASID when
 possible
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
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

v->address_space_id !=3D VHOST_VDPA_GUEST_PA_ASID?

> +                        NULL : v->shared->iova_tree);
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

&& VHOST_BACKEND_F_DESC_ASID feature is acked?

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

Maybe not so popular opinion, but I would add a previous patch modifying:
if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
    iova_tree =3D new()
}
---

to:
if (!v->shadow_vqs_enabled) {
  return
}

if (!v->shared->iova_tree) {
    iova_tree =3D new()
}
---

> +
> +    if (s->always_svq || v->desc_group < 0) {
> +        return;
> +    }
> +
> +    r =3D vhost_vdpa_set_address_space_id(v, v->desc_group,
> +                                        VHOST_VDPA_NET_CVQ_ASID);
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

I'm not sure "address_space_id" is a good name for this member
anymore. If any, I think we can add a comment explaining that it only
applies to descs vring if VHOST_BACKEND_F_DESC_ASID is acked and all
the needed conditions are met.

Also, maybe it is better to define a new constant
VHOST_VDPA_NET_VRING_DESCS_ASID, set it to VHOST_VDPA_NET_CVQ_ASID,
and explain why it is ok to reuse that ASID?

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
> +    } else {
> +        s->vhost_vdpa.address_space_id =3D s0->vhost_vdpa.address_space_=
id;
> +    }
> +

Ok, here I see how all vqs are configured so I think some of my
previous comments are not 100% valid.

However I think we can improve this, as this omits the case where two
vrings different from s0 vring have the same vring descriptor group.
But I guess we can always optimize on top.

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
> +            s0->vhost_vdpa.address_space_id) {
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

I'm not sure if we can happily set v->desc_group if !s->cvq_isolated.
If CVQ buffers share its group with data queues, but its vring is
effectively isolated, we are setting all the dataplane buffers to the
ASID of the CVQ descriptors, isn't it?

>      if (unlikely(cvq_group < 0)) {
>          error_report_err(err);
>          return cvq_group;
> @@ -1840,6 +1888,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      s->always_svq =3D svq;
>      s->migration_state.notify =3D NULL;
>      s->vhost_vdpa.shadow_vqs_enabled =3D svq;
> +    s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;

Isn't this overridden at each vhost_vdpa_net_*_start?


>      if (queue_pair_index =3D=3D 0) {
>          vhost_vdpa_net_valid_svq_features(features,
>                                            &s->vhost_vdpa.migration_block=
er);
> --
> 1.8.3.1
>


