Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B8717352
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Atb-0005SL-JS; Tue, 30 May 2023 21:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AtZ-0005Rr-Uf
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AtX-000061-Ty
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685497498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8J8oYUKps/lFBs7F7HnDB9lmmt7hPFvx6Ev7t37xpXQ=;
 b=hjleam/s6q/Eq0tO/OVz8pvmBGVbSO2YmCR98udHxg8fPKI4uhT52Qtp9HNm2ywGmwJ2Ou
 bhxpuWG+d7NQZJ2d7Qu4zFZGqBCPNSXHUo1lnxB5LsdoY5gDFp+hKjps0/4IuHFAzc6PLi
 VHVHQz3j4nCXa7zLN8xVm8ohk+UfWGQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-lsVSRA3RPMqUuFuRRYQA6g-1; Tue, 30 May 2023 21:44:56 -0400
X-MC-Unique: lsVSRA3RPMqUuFuRRYQA6g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af17f626e3so25919371fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685497495; x=1688089495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J8oYUKps/lFBs7F7HnDB9lmmt7hPFvx6Ev7t37xpXQ=;
 b=dFT6o1M31NRs0bw2iJy4NcZWutcr/6K0fNtl+AQug3a4PwAIvmD+SGEMrQn4dB13rY
 UMFKahqo+iWoUnMCSbHaF4eY+Kn9mYgy3I+J5ZEBv12VFsIz2BJz0mPhYPUH0eYEjD/3
 +4HtMPImEOCEaNN0Aem+/gG2UlNMG3U9JpUeBygamCzjBTghuxxyYFMd8GVCvIuLHKvv
 cSx1cG0HaZiWdxtpBmxjHp3V1twcBcF1+5c8UoFDQC8W+Qx9wi5udz6NEJeHDj9LH1ax
 UamP1bdnOfX9SJ200waVUDF6hVze2W4k1V8QWhIJ0sOyjpM8vPzUxYqJXGu41HShxuRr
 DLXg==
X-Gm-Message-State: AC+VfDy5yujcbL7kHKu1q8GBLTUTOTYGiOtV1o9xvDZCkBg0V3K/SHWl
 xxO/GhfgUsqbK+sr8uu3XAz48g7cwjkTK+RrZLK27fyQWGHHMah3Yz7BSe3xEZ6aMD3e338uHLS
 wgd9QNfN4Gx4fYrah0YHp/zb2fSBmG58=
X-Received: by 2002:a2e:350c:0:b0:2ab:6e23:ef71 with SMTP id
 z12-20020a2e350c000000b002ab6e23ef71mr1719471ljz.37.1685497495308; 
 Tue, 30 May 2023 18:44:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4grQOIh7UrxznP0U6KfWc0GnnRcrs2rc7Of44izUEIQfnv+Za169wW0NdBCZT6hxB7bHXfchfQN9qaHptRw18=
X-Received: by 2002:a2e:350c:0:b0:2ab:6e23:ef71 with SMTP id
 z12-20020a2e350c000000b002ab6e23ef71mr1719462ljz.37.1685497494975; Tue, 30
 May 2023 18:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153143.470745-1-eperezma@redhat.com>
 <20230526153143.470745-3-eperezma@redhat.com>
In-Reply-To: <20230526153143.470745-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:44:43 +0800
Message-ID: <CACGkMEtzRbXMeSURKOHf7Cj_ds8DEatyuWL5kdzbHhB6K1gHew@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] vdpa: move CVQ isolation check to
 net_init_vhost_vdpa
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com, 
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, 
 Cindy Lu <lulu@redhat.com>, Lei Yang <leiyang@redhat.com>, 
 Harpreet Singh Anand <hanand@xilinx.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Liuxiangdong <liuxiangdong5@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 alvaro.karsz@solid-run.com, Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 26, 2023 at 11:31=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Evaluating it at start time instead of initialization time may make the
> guest capable of dynamically adding or removing migration blockers.
>
> Also, moving to initialization reduces the number of ioctls in the
> migration, reducing failure possibilities.
>
> As a drawback we need to check for CVQ isolation twice: one time with no
> MQ negotiated and another one acking it, as long as the device supports
> it.  This is because Vring ASID / group management is based on vq
> indexes, but we don't know the index of CVQ before negotiating MQ.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolated
> v3: Only record cvq_isolated, true if the device have cvq isolated in
>     both !MQ and MQ configurations.
> v4: Only probe one of MQ or !MQ.
> v4: Merge vhost_vdpa_cvq_is_isolated in vhost_vdpa_probe_cvq_isolation
>     as there is only one call now.
> v4: Call ioctl directly instead of adding functions.
> ---
>  net/vhost-vdpa.c | 154 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 111 insertions(+), 43 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3fb833fe76..0cafccd334 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
>
>      /* The device always have SVQ enabled */
>      bool always_svq;
> +
> +    /* The device can isolate CVQ in its own ASID */
> +    bool cvq_isolated;
> +
>      bool started;
>  } VhostVDPAState;
>
> @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info =3D {
>          .check_peer_type =3D vhost_vdpa_check_peer_type,
>  };
>
> -/**
> - * Get vring virtqueue group
> - *
> - * @device_fd  vdpa device fd
> - * @vq_index   Virtqueue index
> - *
> - * Return -errno in case of error, or vq group if success.
> - */
> -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_ind=
ex)
> +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_ind=
ex,
> +                                          Error **errp)
>  {
>      struct vhost_vring_state state =3D {
>          .index =3D vq_index,
> @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int device_=
fd, unsigned vq_index)
>
>      if (unlikely(r < 0)) {
>          r =3D -errno;
> -        error_report("Cannot get VQ %u group: %s", vq_index,
> -                     g_strerror(errno));
> +        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq_index=
);
>          return r;
>      }
>
> @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientState *n=
c)
>  {
>      VhostVDPAState *s, *s0;
>      struct vhost_vdpa *v;
> -    uint64_t backend_features;
>      int64_t cvq_group;
> -    int cvq_index, r;
> +    int r;
> +    Error *err =3D NULL;
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClientState =
*nc)
>      /*
>       * If we early return in these cases SVQ will not be enabled. The mi=
gration
>       * will be blocked as long as vhost-vdpa backends will not offer _F_=
LOG.
> -     *
> -     * Calling VHOST_GET_BACKEND_FEATURES as they are not available in v=
->dev
> -     * yet.
>       */
> -    r =3D ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend_featu=
res);
> -    if (unlikely(r < 0)) {
> -        error_report("Cannot get vdpa backend_features: %s(%d)",
> -            g_strerror(errno), errno);
> -        return -1;
> +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> +        return 0;
>      }
> -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) ||
> -        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> +
> +    if (!s->cvq_isolated) {
>          return 0;
>      }
>
> -    /*
> -     * Check if all the virtqueues of the virtio device are in a differe=
nt vq
> -     * than the last vq. VQ group of last group passed in cvq_group.
> -     */
> -    cvq_index =3D v->dev->vq_index_end - 1;
> -    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd, cvq_index);
> +    cvq_group =3D vhost_vdpa_get_vring_group(v->device_fd,
> +                                           v->dev->vq_index_end - 1,
> +                                           &err);
>      if (unlikely(cvq_group < 0)) {
> +        error_report_err(err);
>          return cvq_group;
>      }
> -    for (int i =3D 0; i < cvq_index; ++i) {
> -        int64_t group =3D vhost_vdpa_get_vring_group(v->device_fd, i);
> -
> -        if (unlikely(group < 0)) {
> -            return group;
> -        }
> -
> -        if (group =3D=3D cvq_group) {
> -            return 0;
> -        }
> -    }
>
>      r =3D vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA_NET_C=
VQ_ASID);
>      if (unlikely(r < 0)) {
> @@ -799,6 +776,87 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_=
svq_ops =3D {
>      .avail_handler =3D vhost_vdpa_net_handle_ctrl_avail,
>  };
>
> +/**
> + * Probe if CVQ is isolated
> + *
> + * @device_fd         The vdpa device fd
> + * @features          Features offered by the device.
> + * @cvq_index         The control vq pair index
> + *
> + * Returns <0 in case of failure, 0 if false and 1 if true.
> + */
> +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t featur=
es,
> +                                          int cvq_index, Error **errp)
> +{
> +    uint64_t backend_features;
> +    int64_t cvq_group;
> +    uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                     VIRTIO_CONFIG_S_DRIVER |
> +                     VIRTIO_CONFIG_S_FEATURES_OK;
> +    int r;
> +
> +    ERRP_GUARD();
> +
> +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features=
);
> +    if (unlikely(r < 0)) {
> +        error_setg_errno(errp, errno, "Cannot get vdpa backend_features"=
);
> +        return r;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> +        return 0;
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, errno, "Cannot set features");
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot set device features");
> +        goto out;
> +    }
> +
> +    cvq_group =3D vhost_vdpa_get_vring_group(device_fd, cvq_index, errp)=
;
> +    if (unlikely(cvq_group < 0)) {
> +        if (cvq_group !=3D -ENOTSUP) {
> +            r =3D cvq_group;
> +            goto out;
> +        }
> +
> +        /*
> +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa fron=
tend
> +         * support ASID even if the parent driver does not.  The CVQ can=
not be
> +         * isolated in this case.
> +         */
> +        error_free(*errp);
> +        *errp =3D NULL;
> +        r =3D 0;
> +        goto out;
> +    }
> +
> +    for (int i =3D 0; i < cvq_index; ++i) {
> +        int64_t group =3D vhost_vdpa_get_vring_group(device_fd, i, errp)=
;
> +        if (unlikely(group < 0)) {
> +            r =3D group;
> +            goto out;
> +        }
> +
> +        if (group =3D=3D (int64_t)cvq_group) {
> +            r =3D 0;
> +            goto out;
> +        }
> +    }
> +
> +    r =3D 1;
> +
> +out:
> +    status =3D 0;
> +    ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    return r;
> +}
> +
>  static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
>                                         const char *device,
>                                         const char *name,
> @@ -808,16 +866,25 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>                                         bool is_datapath,
>                                         bool svq,
>                                         struct vhost_vdpa_iova_range iova=
_range,
> -                                       uint64_t features)
> +                                       uint64_t features,
> +                                       Error **errp)
>  {
>      NetClientState *nc =3D NULL;
>      VhostVDPAState *s;
>      int ret =3D 0;
>      assert(name);
> +    int cvq_isolated;
> +
>      if (is_datapath) {
>          nc =3D qemu_new_net_client(&net_vhost_vdpa_info, peer, device,
>                                   name);
>      } else {
> +        cvq_isolated =3D vhost_vdpa_probe_cvq_isolation(vdpa_device_fd, =
features,
> +                                                      queue_pair_index *=
 2, errp);
> +        if (unlikely(cvq_isolated < 0)) {
> +            return NULL;
> +        }
> +
>          nc =3D qemu_new_net_control_client(&net_vhost_vdpa_cvq_info, pee=
r,
>                                           device, name);
>      }
> @@ -844,6 +911,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientS=
tate *peer,
>
>          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
>          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> +        s->cvq_isolated =3D cvq_isolated;
>
>          /*
>           * TODO: We cannot migrate devices with CVQ as there is no way t=
o set
> @@ -972,7 +1040,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const =
char *name,
>      for (i =3D 0; i < queue_pairs; i++) {
>          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                       vdpa_device_fd, i, 2, true, opts->x=
_svq,
> -                                     iova_range, features);
> +                                     iova_range, features, errp);
>          if (!ncs[i])
>              goto err;
>      }
> @@ -980,7 +1048,7 @@ int net_init_vhost_vdpa(const Netdev *netdev, const =
char *name,
>      if (has_cvq) {
>          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                   vdpa_device_fd, i, 1, false,
> -                                 opts->x_svq, iova_range, features);
> +                                 opts->x_svq, iova_range, features, errp=
);
>          if (!nc)
>              goto err;
>      }
> --
> 2.31.1
>


