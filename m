Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B280030F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 06:36:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8wC2-0002GO-Cn; Fri, 01 Dec 2023 00:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r8wC0-0002Ea-1C
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 00:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r8wBk-0007G3-6A
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 00:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701408942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3g+3H9pP0finctpT24X9v6w9sLWsW0uby/uwT3yQus=;
 b=EljepvRoTlZ2oAdKY+QJKrG7ADZAFFUqpC1qJsYGaV1iO7GItOg+NMiUeBDnSO8tv9q1WF
 aqr9+RzkeidSbUmknmxt1gizu+68eHpw7pGGgTmpHejmNocMyJayFjEaoWAEHdC5+KISov
 qYpl90+H/4hBgdiW1sLgSPPKIfo8k0k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ZiZS9vJbPZaK837F3gkaDw-1; Fri, 01 Dec 2023 00:35:40 -0500
X-MC-Unique: ZiZS9vJbPZaK837F3gkaDw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50bcd1578c8so1768484e87.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 21:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701408939; x=1702013739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3g+3H9pP0finctpT24X9v6w9sLWsW0uby/uwT3yQus=;
 b=rx1VqkEXm6N9CUgXuN8YeK7owBOnAE793fpVyPhSZsflzO6L6/TqQKaS8LXjLL0ipu
 BHs/Vqv/AwsiWssra4K8CGX92I1JhONpQ3tFlTrZZeSYp+FHWubhjwTd5HlEH3wcAi1h
 u5mZUIQNd1OGtUHX6EoxH/3elnWsE28qJG5QAWcEGWyIWsHUqsy/QBNP0X86Fh43+Twy
 cWlfV76pPZh8SJ+dRmaydYTL7yncwy+1WT7zDvSdx1k69MRIF/7Nfa9GdSR1bY4PkbaQ
 FT/Nq6g3NoyXhePD8EvzTE+WgpUeLzDPvELCKlFSoc5VpKKqKMI5zKQI8Qq8sMH8WQEn
 kZXQ==
X-Gm-Message-State: AOJu0YzQrs0akB6cPer7sZ/idD1sGwrlWdx2c7Lmaut+EVPKjVpdZQKh
 yHHSzZgqrHBtuh/ApvqAh9+Bji9K5x8hXEJ5HNeF9BqmTmtJiDQIP07gelD4WT4QEO16wLdHMva
 lsA7rYNTLv/P/TGSjovA5mpS9O7hCDiQ=
X-Received: by 2002:ac2:47f3:0:b0:50b:d764:9664 with SMTP id
 b19-20020ac247f3000000b0050bd7649664mr327427lfp.72.1701408939505; 
 Thu, 30 Nov 2023 21:35:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrQlfGLHmEbmzLH96xEjF31t6nhQxerQRI3AlyLO9ynCbAjjamFqbomY1pSbHbVmBMVZTwNbO+RTa9pZmTJno=
X-Received: by 2002:ac2:47f3:0:b0:50b:d764:9664 with SMTP id
 b19-20020ac247f3000000b0050bd7649664mr327423lfp.72.1701408939201; Thu, 30 Nov
 2023 21:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
 <20231124171430.2964464-2-eperezma@redhat.com>
In-Reply-To: <20231124171430.2964464-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Dec 2023 13:35:28 +0800
Message-ID: <CACGkMEuJcJvp3odHLMtjh2A-2MP9r3P19XXC_1yfikUdRftLBw@mail.gmail.com>
Subject: Re: [PATCH 9.0 01/13] vdpa: add VhostVDPAShared
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It will hold properties shared among all vhost_vdpa instances associated
> with of the same device.  For example, we just need one iova_tree or one
> memory listener for the entire device.
>
> Next patches will register the vhost_vdpa memory listener at the
> beginning of the VM migration at the destination. This enables QEMU to
> map the memory to the device before stopping the VM at the source,
> instead of doing while both source and destination are stopped, thus
> minimizing the downtime.
>
> However, the destination QEMU is unaware of which vhost_vdpa struct will
> register its memory_listener.  If the source guest has CVQ enabled, it
> will be the one associated with the CVQ.  Otherwise, it will be the
> first one.
>
> Save the memory operations related members in a common place rather than
> always in the first / last vhost_vdpa.

Great.

Patch looks good but I think we probably need a better name like
VhostVDPAParent?

And it would be better in the future if we can convert it to QOM.

Thanks

>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/hw/virtio/vhost-vdpa.h |  5 +++++
>  net/vhost-vdpa.c               | 24 ++++++++++++++++++++++--
>  2 files changed, 27 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index 5407d54fd7..eb1a56d75a 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -30,6 +30,10 @@ typedef struct VhostVDPAHostNotifier {
>      void *addr;
>  } VhostVDPAHostNotifier;
>
> +/* Info shared by all vhost_vdpa device models */
> +typedef struct vhost_vdpa_shared {
> +} VhostVDPAShared;
> +
>  typedef struct vhost_vdpa {
>      int device_fd;
>      int index;
> @@ -46,6 +50,7 @@ typedef struct vhost_vdpa {
>      bool suspended;
>      /* IOVA mapping used by the Shadow Virtqueue */
>      VhostIOVATree *iova_tree;
> +    VhostVDPAShared *shared;
>      GPtrArray *shadow_vqs;
>      const VhostShadowVirtqueueOps *shadow_vq_ops;
>      void *shadow_vq_ops_opaque;
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index d0614d7954..8b661b9e6d 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -240,6 +240,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>          qemu_close(s->vhost_vdpa.device_fd);
>          s->vhost_vdpa.device_fd =3D -1;
>      }
> +    if (s->vhost_vdpa.index !=3D 0) {
> +        return;
> +    }
> +    g_free(s->vhost_vdpa.shared);
>  }
>
>  /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
> @@ -1661,6 +1665,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>                                         bool svq,
>                                         struct vhost_vdpa_iova_range iova=
_range,
>                                         uint64_t features,
> +                                       VhostVDPAShared *shared,
>                                         Error **errp)
>  {
>      NetClientState *nc =3D NULL;
> @@ -1696,6 +1701,7 @@ static NetClientState *net_vhost_vdpa_init(NetClien=
tState *peer,
>      if (queue_pair_index =3D=3D 0) {
>          vhost_vdpa_net_valid_svq_features(features,
>                                            &s->vhost_vdpa.migration_block=
er);
> +        s->vhost_vdpa.shared =3D g_new0(VhostVDPAShared, 1);
>      } else if (!is_datapath) {
>          s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_page=
_len(),
>                                       PROT_READ | PROT_WRITE,
> @@ -1708,11 +1714,16 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
>          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
>          s->cvq_isolated =3D cvq_isolated;
>      }
> +    if (queue_pair_index !=3D 0) {
> +        s->vhost_vdpa.shared =3D shared;
> +    }
> +
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
>          qemu_del_net_client(nc);
>          return NULL;
>      }
> +
>      return nc;
>  }
>
> @@ -1824,17 +1835,26 @@ int net_init_vhost_vdpa(const Netdev *netdev, con=
st char *name,
>      ncs =3D g_malloc0(sizeof(*ncs) * queue_pairs);
>
>      for (i =3D 0; i < queue_pairs; i++) {
> +        VhostVDPAShared *shared =3D NULL;
> +
> +        if (i) {
> +            shared =3D DO_UPCAST(VhostVDPAState, nc, ncs[0])->vhost_vdpa=
.shared;
> +        }
>          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                       vdpa_device_fd, i, 2, true, opts->x=
_svq,
> -                                     iova_range, features, errp);
> +                                     iova_range, features, shared, errp)=
;
>          if (!ncs[i])
>              goto err;
>      }
>
>      if (has_cvq) {
> +        VhostVDPAState *s0 =3D DO_UPCAST(VhostVDPAState, nc, ncs[0]);
> +        VhostVDPAShared *shared =3D s0->vhost_vdpa.shared;
> +
>          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
>                                   vdpa_device_fd, i, 1, false,
> -                                 opts->x_svq, iova_range, features, errp=
);
> +                                 opts->x_svq, iova_range, features, shar=
ed,
> +                                 errp);
>          if (!nc)
>              goto err;
>      }
> --
> 2.39.3
>


