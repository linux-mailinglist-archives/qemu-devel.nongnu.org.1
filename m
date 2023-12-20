Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CA88197D7
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:34:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFoHw-0002Yb-1k; Tue, 19 Dec 2023 23:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoHt-0002Y0-9F
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoHr-0004Xo-On
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALTLsslK8lMKWesJtzG2JrAdmTxHKDzRf4Ycs/rpBvM=;
 b=crNEep6TEP8xK2L+Wqd1eAHfpfEDhTNXoE26KAT7zzYBM6wBb+9jBtMJEZk+AyVqmd+OwV
 pu0IPZKZgda66SeCjL9sWmljDheqX3F5/16tLFwmFkHQWgkIAQwvQ9LUJBA9S/jrTtbrB8
 fvjqaittD9LdWdmnCrlK+LZQJwvd2Ko=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-H7mTodYzNSmC-1YJ_eKgVA-1; Tue, 19 Dec 2023 23:34:25 -0500
X-MC-Unique: H7mTodYzNSmC-1YJ_eKgVA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d9feae8dfdso7020021a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046864; x=1703651664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALTLsslK8lMKWesJtzG2JrAdmTxHKDzRf4Ycs/rpBvM=;
 b=Ywh+hMpWADbsbxpr8Mq/UHk4CcU99OXiNA3vn5+ZPlRR5H71hNy+nHuV+ylXSIL4Q+
 xQoUQFRQ6U+TYJi9HXd4yt9nyMGqRE3AkSAl97oPnOpG5gVh1l2GkUGbJgKCwEtoYSeU
 OdeHc1ivULZaxeVLzVm1Isvjb6YCMyfdWXbJfEnEOsGn2HbErHn0hN2eazOk+bdoYk/J
 wvqqehkvOuhjufuKBjvhieAlvb2pm/iw6WOJJqXZkzOnkBHuCkUrYm/JTJQHqvMXUHkM
 9m0qMp26tvjhhvvsQVv4/QlQ8R6nMSLik+TVA/vyuah1ixff/PGheY3A2a0DQgtxkwSA
 wIcQ==
X-Gm-Message-State: AOJu0Yzm9XcGVsDAz+zZBMu01RrtFnhR6IGt72+vzF8QnlxC69LJ/q8R
 YdvJ2Txb1yFR4Y/ne6uwCvBqOphN2PeYfOeymoHVEgSRur3NGdJPJsX94r3ckGfa/0xeZpKaoaN
 e78FhxsT9MHQnMY0kif5Ey2ovXFrtNeM=
X-Received: by 2002:a9d:7a89:0:b0:6d9:d817:c1a with SMTP id
 l9-20020a9d7a89000000b006d9d8170c1amr19532177otn.46.1703046864600; 
 Tue, 19 Dec 2023 20:34:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLfnv/QtMFyKs67xwykivZROiJXKBE+/IpOArbbCPF5sPFu9FkEWegjJFU8fsJGqU87na50WVzZr9f26nYK2U=
X-Received: by 2002:a9d:7a89:0:b0:6d9:d817:c1a with SMTP id
 l9-20020a9d7a89000000b006d9d8170c1amr19532164otn.46.1703046864386; Tue, 19
 Dec 2023 20:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-8-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:34:13 +0800
Message-ID: <CACGkMEtoVLthML2SauX_Ptwdw6KMbtK1EY6BGD=E3mqN01x5hA@mail.gmail.com>
Subject: Re: [PATCH for 9.0 07/12] vdpa: set backend capabilities at
 vhost_vdpa_init
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> The backend does not reset them until the vdpa file descriptor is closed
> so there is no harm in doing it only once.
>
> This allows the destination of a live migration to premap memory in
> batches, using VHOST_BACKEND_F_IOTLB_BATCH.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 50 ++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 449c3794b2..43f7c382b1 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -587,11 +587,25 @@ static int vhost_vdpa_init(struct vhost_dev *dev, v=
oid *opaque, Error **errp)
>      struct vhost_vdpa *v =3D opaque;
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
>      trace_vhost_vdpa_init(dev, v->shared, opaque);
> +    uint64_t backend_features;
> +    uint64_t qemu_backend_features =3D 0x1ULL << VHOST_BACKEND_F_IOTLB_M=
SG_V2 |
> +                                     0x1ULL << VHOST_BACKEND_F_IOTLB_BAT=
CH |
> +                                     0x1ULL << VHOST_BACKEND_F_IOTLB_ASI=
D |
> +                                     0x1ULL << VHOST_BACKEND_F_SUSPEND;
>      int ret;
>
>      v->dev =3D dev;
>      dev->opaque =3D  opaque ;
>      v->shared->listener =3D vhost_vdpa_memory_listener;
> +
> +    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &backend_featur=
es)) {
> +        return -EFAULT;
> +    }
> +
> +    backend_features &=3D qemu_backend_features;
> +
> +    dev->backend_cap =3D backend_features;
> +    v->shared->backend_cap =3D backend_features;
>      vhost_vdpa_init_svq(dev, v);
>
>      error_propagate(&dev->migration_blocker, v->migration_blocker);
> @@ -599,6 +613,11 @@ static int vhost_vdpa_init(struct vhost_dev *dev, vo=
id *opaque, Error **errp)
>          return 0;
>      }
>
> +    ret =3D vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &backend_fe=
atures);
> +    if (ret) {
> +        return -EFAULT;
> +    }
> +
>      /*
>       * If dev->shadow_vqs_enabled at initialization that means the devic=
e has
>       * been started with x-svq=3Don, so don't block migration
> @@ -829,36 +848,6 @@ static int vhost_vdpa_set_features(struct vhost_dev =
*dev,
>      return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
>  }
>
> -static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)

How about keeping this function but just calling it in vhost_vdpa_init()?

Thanks


