Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C25981CDAC
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 18:39:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjSp-0006HD-6X; Fri, 22 Dec 2023 12:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGjSl-0006Gl-Mk
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 12:37:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGjSj-00085t-C8
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 12:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703266647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGZ9KOjxzqJV9e6tX3FkeDDO67jGBvN8sghDzX703yM=;
 b=U3xBXuJeYXASh6+jA0alC17HvTVdZt5tGQWTrMDvvncZcd80zA4T9vV7wp0TBWwAXQP5H7
 Iv0+y64R0AOdxsVBABJvQuX7bo12hDK5w30QaHE8ZRBiAeT7JvS3yf5zgtAnPxUC3WvphF
 4NxTioV6AVm1R6KZ9MfS3mPd1/7Fl/8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-3iyw7K5UPBS3RRyd8l3hXg-1; Fri, 22 Dec 2023 12:37:23 -0500
X-MC-Unique: 3iyw7K5UPBS3RRyd8l3hXg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5ca2a6f07b6so39219327b3.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 09:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703266643; x=1703871443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGZ9KOjxzqJV9e6tX3FkeDDO67jGBvN8sghDzX703yM=;
 b=wShKJKK+1hnc8yChl8HiogIfNrhmBS32Y85DJFhBuS8rmkcXPrYo+Qv+Fkqt0wjWlc
 IE9nD6e0lMubMiNQF6YP+B5ZBtu/1VnfJhpxu191s+noQOtvO06S2p5L54NZZAUU8hEv
 1H3xRegoIE8DergXyJpo6y4OAsaY2vJsYlNsc9vKYLdpbpSyorW2N9rucogn+HDh//AA
 1z8axZsoN+rig1AU0Sh73Jq2INDK7BDpqCVR+1ySbIioUimAkiJ0C0b4Vb8+4yb9woZ+
 5q4JFWTXiSBJ+LBCjGST5EltEgQA1AKeK+tCMFnq9q27Z3O6/Qq773SSZnDWm79W2qz0
 7XVA==
X-Gm-Message-State: AOJu0YzbFhVUE8tJxr1cy8EJg4PnOIS2a00VGmRQeuZ+aJVAOgUyvKUK
 9SfovetRMMkPNBootVBrtE8jLV6ZwvPGjDT8iOEtqnhWq6D8Fafsf7EMDnALVtRhqu0wBwS2rSZ
 +MqykKPklF4q3P2lPQXu+eKCIXC61Zl/dDDnc0aw=
X-Received: by 2002:a0d:ca92:0:b0:5e1:aa35:2c8b with SMTP id
 m140-20020a0dca92000000b005e1aa352c8bmr1553544ywd.12.1703266642949; 
 Fri, 22 Dec 2023 09:37:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvBCMAzYwH8sZmbGO9iX7ZbvlpvN7LVP8mGJtw8PsyRi1h+OWVCDR2faGB7x7hUxwzeWy8EWkJLvzqVrKc2BQ=
X-Received: by 2002:a0d:ca92:0:b0:5e1:aa35:2c8b with SMTP id
 m140-20020a0dca92000000b005e1aa352c8bmr1553535ywd.12.1703266642638; Fri, 22
 Dec 2023 09:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <20230918044932.1433744-5-yajunw@nvidia.com>
In-Reply-To: <20230918044932.1433744-5-yajunw@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Dec 2023 18:36:46 +0100
Message-ID: <CAJaqyWePMJm1t7tx6mggT+iHufVSMXDKzoeTu+fpBwXfZWJbSA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] virtio: Add VMState for early load
To: Yajun Wu <yajunw@nvidia.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, 
 Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

On Mon, Sep 18, 2023 at 6:51=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
> Define new virtio device vmstate for early save/load (happens in
> LM setup stage). Same as original vmstate, except:
>
> In LM setup phase of the destination VM, the guest memory has not
> been synchronized yet. To address this, a flag has been added to
> virtio_load function to skip the index check.
>
> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  hw/virtio/virtio.c         | 152 +++++++++++++++++++++++--------------
>  include/hw/virtio/virtio.h |  10 ++-
>  2 files changed, 103 insertions(+), 59 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 969c25f4cf..8c73c245dd 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2832,7 +2832,17 @@ virtio_device_get(QEMUFile *f, void *opaque, size_=
t size,
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
>      DeviceClass *dc =3D DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
>
> -    return virtio_load(vdev, f, dc->vmsd->version_id);
> +    return virtio_load(vdev, f, dc->vmsd->version_id, false);
> +}
> +
> +/* A wrapper for use as a VMState .get function */
> +static int virtio_early_device_get(QEMUFile *f, void *opaque, size_t siz=
e,
> +                                      const VMStateField *field)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(opaque);
> +    DeviceClass *dc =3D DEVICE_CLASS(VIRTIO_DEVICE_GET_CLASS(vdev));
> +
> +    return virtio_load(vdev, f, dc->vmsd->version_id, true);
>  }
>
>  const VMStateInfo  virtio_vmstate_info =3D {
> @@ -2841,6 +2851,12 @@ const VMStateInfo  virtio_vmstate_info =3D {
>      .put =3D virtio_device_put,
>  };
>
> +const VMStateInfo virtio_early_vmstate_info =3D {
> +    .name =3D "virtio-early",
> +    .get =3D virtio_early_device_get,
> +    .put =3D virtio_device_put,
> +};
> +
>  static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
>  {
>      VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);
> @@ -2940,8 +2956,75 @@ size_t virtio_get_config_size(const VirtIOConfigSi=
zeParams *params,
>      return config_size;
>  }
>
> +static int virtio_load_check_index(VirtIODevice *vdev, int num)
> +{
> +    int i;
> +
> +    RCU_READ_LOCK_GUARD();
> +

I didn't check manually, but in the original function vdc->post_load
call was also protected by the RCU. Maybe it is better to leave it at
the caller?

> +    for (i =3D 0; i < num; i++) {
> +        if (vdev->vq[i].vring.desc) {
> +            uint16_t nheads;
> +
> +            /*
> +             * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
> +             * only the region cache needs to be set up.  Legacy devices=
 need
> +             * to calculate used and avail ring addresses based on the d=
esc
> +             * address.
> +             */
> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +                virtio_init_region_cache(vdev, i);
> +            } else {
> +                virtio_queue_update_rings(vdev, i);
> +            }
> +
> +            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +                vdev->vq[i].shadow_avail_idx =3D vdev->vq[i].last_avail_=
idx;
> +                vdev->vq[i].shadow_avail_wrap_counter =3D
> +                                        vdev->vq[i].last_avail_wrap_coun=
ter;
> +                continue;
> +            }
> +
> +            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
> +            /* Check it isn't doing strange things with descriptor numbe=
rs. */
> +            if (nheads > vdev->vq[i].vring.num) {
> +                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
> +                             "inconsistent with Host index 0x%x: delta 0=
x%x",
> +                             i, vdev->vq[i].vring.num,
> +                             vring_avail_idx(&vdev->vq[i]),
> +                             vdev->vq[i].last_avail_idx, nheads);
> +                vdev->vq[i].used_idx =3D 0;
> +                vdev->vq[i].shadow_avail_idx =3D 0;
> +                vdev->vq[i].inuse =3D 0;
> +                continue;
> +            }
> +            vdev->vq[i].used_idx =3D vring_used_idx(&vdev->vq[i]);
> +            vdev->vq[i].shadow_avail_idx =3D vring_avail_idx(&vdev->vq[i=
]);
> +
> +            /*
> +             * Some devices migrate VirtQueueElements that have been pop=
ped
> +             * from the avail ring but not yet returned to the used ring=
.
> +             * Since max ring size < UINT16_MAX it's safe to use modulo
> +             * UINT16_MAX + 1 subtraction.
> +             */
> +            vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx =
-
> +                                vdev->vq[i].used_idx);
> +            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
> +                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
> +                             "used_idx 0x%x",
> +                             i, vdev->vq[i].vring.num,
> +                             vdev->vq[i].last_avail_idx,
> +                             vdev->vq[i].used_idx);
> +                return -1;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  int coroutine_mixed_fn
> -virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> +virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id, bool early)

As an alternative to introducing a parameter, maybe we can check
incoming migration state?

migration_incoming_get_current()->state =3D=3D MIGRATION_STATUS_SETUP shoul=
d work.

>  {
>      int i, ret;
>      int32_t config_len;
> @@ -3078,62 +3161,15 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int =
version_id)
>          vdev->start_on_kick =3D true;
>      }
>
> -    RCU_READ_LOCK_GUARD();
> -    for (i =3D 0; i < num; i++) {
> -        if (vdev->vq[i].vring.desc) {
> -            uint16_t nheads;
> -
> -            /*
> -             * VIRTIO-1 devices migrate desc, used, and avail ring addre=
sses so
> -             * only the region cache needs to be set up.  Legacy devices=
 need
> -             * to calculate used and avail ring addresses based on the d=
esc
> -             * address.
> -             */
> -            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -                virtio_init_region_cache(vdev, i);
> -            } else {
> -                virtio_queue_update_rings(vdev, i);
> -            }
> -
> -            if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> -                vdev->vq[i].shadow_avail_idx =3D vdev->vq[i].last_avail_=
idx;
> -                vdev->vq[i].shadow_avail_wrap_counter =3D
> -                                        vdev->vq[i].last_avail_wrap_coun=
ter;
> -                continue;
> -            }
> -
> -            nheads =3D vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_=
avail_idx;
> -            /* Check it isn't doing strange things with descriptor numbe=
rs. */
> -            if (nheads > vdev->vq[i].vring.num) {
> -                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
> -                             "inconsistent with Host index 0x%x: delta 0=
x%x",
> -                             i, vdev->vq[i].vring.num,
> -                             vring_avail_idx(&vdev->vq[i]),
> -                             vdev->vq[i].last_avail_idx, nheads);
> -                vdev->vq[i].used_idx =3D 0;
> -                vdev->vq[i].shadow_avail_idx =3D 0;
> -                vdev->vq[i].inuse =3D 0;
> -                continue;
> -            }
> -            vdev->vq[i].used_idx =3D vring_used_idx(&vdev->vq[i]);
> -            vdev->vq[i].shadow_avail_idx =3D vring_avail_idx(&vdev->vq[i=
]);
> -
> -            /*
> -             * Some devices migrate VirtQueueElements that have been pop=
ped
> -             * from the avail ring but not yet returned to the used ring=
.
> -             * Since max ring size < UINT16_MAX it's safe to use modulo
> -             * UINT16_MAX + 1 subtraction.
> -             */
> -            vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx =
-
> -                                vdev->vq[i].used_idx);
> -            if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
> -                error_report("VQ %d size 0x%x < last_avail_idx 0x%x - "
> -                             "used_idx 0x%x",
> -                             i, vdev->vq[i].vring.num,
> -                             vdev->vq[i].last_avail_idx,
> -                             vdev->vq[i].used_idx);
> -                return -1;
> -            }
> +    /*
> +     * Early setup happens in LM setup stage when the guest memory hasn'=
t
> +     * synced to target VM yet. So skip all guest memory access and inde=
x check
> +     * in early load.
> +     */
> +    if (!early) {
> +        ret =3D virtio_load_check_index(vdev, num);
> +        if (ret) {
> +            return ret;
>          }
>      }
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..c9e6faf72c 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -280,6 +280,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)=
;
>  int virtio_save(VirtIODevice *vdev, QEMUFile *f);
>
>  extern const VMStateInfo virtio_vmstate_info;
> +extern const VMStateInfo virtio_early_vmstate_info;
>
>  #define VMSTATE_VIRTIO_DEVICE \
>      {                                         \
> @@ -288,7 +289,14 @@ extern const VMStateInfo virtio_vmstate_info;
>          .flags =3D VMS_SINGLE,                  \
>      }
>
> -int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id);
> +#define VMSTATE_EARLY_VIRTIO_DEVICE \
> +    {                                         \
> +        .name =3D "virtio-early",            \
> +        .info =3D &virtio_early_vmstate_info,\
> +        .flags =3D VMS_SINGLE,                  \
> +    }
> +
> +int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id, bool ea=
rly);
>
>  /**
>   * virtio_notify_config() - signal a change to device config
> --
> 2.27.0
>
>


