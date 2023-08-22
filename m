Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED306783C39
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:55:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYNAq-0000yh-Cm; Tue, 22 Aug 2023 04:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qYNAo-0000yI-OH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:55:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qYNAm-0001VD-Eb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02E2OOmhOZs5Vo/O6wchLG/yqfQ/XbGOoeDqh03yFrc=;
 b=bGqNkR/cqU6PPRZlQGxrRflssG4sNYrsU+0a4Bx5jB66ffZPMJdLRUTAd8xUh6uWviZJxJ
 uMcUsHg8yDoPqQMO8r5dK7IIw0FCxt/El2xHzA2Itbe5XMoLuTMeKvbQHBpkEcPhSCpQ4/
 pgvHElWteP1TEkxUZnSuzv6P496WOsQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-PsTBGP0qNC2lNQIjxCsbtA-1; Tue, 22 Aug 2023 04:55:34 -0400
X-MC-Unique: PsTBGP0qNC2lNQIjxCsbtA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bba9a3d63fso42787911fa.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692694533; x=1693299333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=02E2OOmhOZs5Vo/O6wchLG/yqfQ/XbGOoeDqh03yFrc=;
 b=DRjGzuldOX1q5b27w0aoCRizZVuBG7LHOkUkm8HJVBFZwmozcsIiGnmabkQ8ER3HGz
 HvFzVDt4cVi4P56Ms2wKuXcN8umPXdr3HAgAfqq1uETgQSokE/QdTkecj1P+jyKmHKh3
 OB7O6zoQqr3gOt+TxyIOV+YrMIarvr22tyUj9qrN7ny1Sv1SDOaorfqDjb6GvBepxf2h
 mnCZrvtfuMff/jHZGulekh3z4gw6SBwJJ0YCx+afstClMZiCLfs1Y9DfRKmhqzURfN+m
 9CnWFS0v6xJcU4nYS1/mF+xiVBjRLLbqtQ53Z8QLAW6Zoo+XAYzKXvANlBxsogAedZJs
 aXBw==
X-Gm-Message-State: AOJu0Yw8zgCiO/pbPpVvjdS+JeGuNyKCOIYXObnITAXLviU/uczqrbX0
 WI/Ym53ukRKh2JK7pQej+dwETqrQDVdNv4Z7ndcVg/DRMge/RMsPud8q7EJwSRPPTuFq2CR57cN
 rUmpRI+8nfXY1Y0PiF2DTDeyZODSpl98=
X-Received: by 2002:a2e:9cd8:0:b0:2bb:bdf0:caf2 with SMTP id
 g24-20020a2e9cd8000000b002bbbdf0caf2mr6289941ljj.25.1692694533118; 
 Tue, 22 Aug 2023 01:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0olkNgANUiN9UEOiheM7EzvEbxmJG1/zanr6zKtwL1NBK2K6PqsZvGcN5TUD30ehr1l3CQviib6gGN/fBjE=
X-Received: by 2002:a2e:9cd8:0:b0:2bb:bdf0:caf2 with SMTP id
 g24-20020a2e9cd8000000b002bbbdf0caf2mr6289924ljj.25.1692694532796; Tue, 22
 Aug 2023 01:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822085330.3978829-1-eperezma@redhat.com>
 <20230822085330.3978829-5-eperezma@redhat.com>
In-Reply-To: <20230822085330.3978829-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Aug 2023 16:55:21 +0800
Message-ID: <CACGkMEshQAN_9iQp_+Z9BaxPcBpKcZroB_93un6+fYeop6i9rA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] vdpa: move vhost_vdpa_set_vring_ready to the caller
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Harpreet Singh Anand <hanand@xilinx.com>, Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>, Lei Yang <leiyang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 22, 2023 at 4:53=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Doing that way allows CVQ to be enabled before the dataplane vqs,
> restoring the state as MQ or MAC addresses properly in the case of a
> migration.
>
> The patch does it by defining a ->load NetClientInfo callback also for
> dataplane.  Ideally, this should be done by an independent patch, but
> the function is already static so it would only add an empty
> vhost_vdpa_net_data_load stub.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v3:
> * Fix subject typo
> * Expand patch message so it explains why
> ---
>  hw/virtio/vdpa-dev.c   |  3 +++
>  hw/virtio/vhost-vdpa.c |  3 ---
>  net/vhost-vdpa.c       | 57 +++++++++++++++++++++++++++++-------------
>  3 files changed, 42 insertions(+), 21 deletions(-)
>
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 363b625243..f22d5d5bc0 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -255,6 +255,9 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev=
, Error **errp)
>          error_setg_errno(errp, -ret, "Error starting vhost");
>          goto err_guest_notifiers;
>      }
> +    for (i =3D 0; i < s->dev.nvqs; ++i) {
> +        vhost_vdpa_set_vring_ready(&s->vdpa, i);
> +    }
>      s->started =3D true;
>
>      /*
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 0d9975b5b5..8ca2e3800c 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1297,9 +1297,6 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          if (unlikely(!ok)) {
>              return -1;
>          }
> -        for (int i =3D 0; i < dev->nvqs; ++i) {
> -            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
> -        }
>      } else {
>          vhost_vdpa_suspend(dev);
>          vhost_vdpa_svqs_stop(dev);
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9251351b4b..3bf60f9431 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -371,6 +371,22 @@ static int vhost_vdpa_net_data_start(NetClientState =
*nc)
>      return 0;
>  }
>
> +static int vhost_vdpa_net_data_load(NetClientState *nc)
> +{
> +    VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> +    struct vhost_vdpa *v =3D &s->vhost_vdpa;
> +    bool has_cvq =3D v->dev->vq_index_end % 2;
> +
> +    if (has_cvq) {
> +        return 0;
> +    }
> +
> +    for (int i =3D 0; i < v->dev->nvqs; ++i) {
> +        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
> +    }
> +    return 0;
> +}
> +
>  static void vhost_vdpa_net_client_stop(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -393,6 +409,7 @@ static NetClientInfo net_vhost_vdpa_info =3D {
>          .size =3D sizeof(VhostVDPAState),
>          .receive =3D vhost_vdpa_receive,
>          .start =3D vhost_vdpa_net_data_start,
> +        .load =3D vhost_vdpa_net_data_load,
>          .stop =3D vhost_vdpa_net_client_stop,
>          .cleanup =3D vhost_vdpa_cleanup,
>          .has_vnet_hdr =3D vhost_vdpa_has_vnet_hdr,
> @@ -974,26 +991,30 @@ static int vhost_vdpa_net_cvq_load(NetClientState *=
nc)
>
>      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>
> -    if (!v->shadow_vqs_enabled) {
> -        return 0;
> -    }
> +    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
>
> -    n =3D VIRTIO_NET(v->dev->vdev);
> -    r =3D vhost_vdpa_net_load_mac(s, n);
> -    if (unlikely(r < 0)) {
> -        return r;
> -    }
> -    r =3D vhost_vdpa_net_load_mq(s, n);
> -    if (unlikely(r)) {
> -        return r;
> -    }
> -    r =3D vhost_vdpa_net_load_offloads(s, n);
> -    if (unlikely(r)) {
> -        return r;
> +    if (v->shadow_vqs_enabled) {
> +        n =3D VIRTIO_NET(v->dev->vdev);
> +        r =3D vhost_vdpa_net_load_mac(s, n);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
> +        r =3D vhost_vdpa_net_load_mq(s, n);
> +        if (unlikely(r)) {
> +            return r;
> +        }
> +        r =3D vhost_vdpa_net_load_offloads(s, n);
> +        if (unlikely(r)) {
> +            return r;
> +        }
> +        r =3D vhost_vdpa_net_load_rx(s, n);
> +        if (unlikely(r)) {
> +            return r;
> +        }
>      }
> -    r =3D vhost_vdpa_net_load_rx(s, n);
> -    if (unlikely(r)) {
> -        return r;
> +
> +    for (int i =3D 0; i < v->dev->vq_index; ++i) {
> +        vhost_vdpa_set_vring_ready(v, i);
>      }
>
>      return 0;
> --
> 2.39.3
>


