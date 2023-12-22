Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DE981C74C
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:30:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbqj-0005xd-4R; Fri, 22 Dec 2023 04:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rGbqh-0005xG-ES
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rGbqf-0006vU-LC
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703237379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yW3TuP94nSpQEOTtv1Wg5Ho23xhGFSOAhy5oZZOx0KI=;
 b=aYMkNaIqACXYeBZg8vREPZOrdLwBT8xhrP0LVNRr6TDtEmjm/BBmBzZEfz0BiOMMkUU3XS
 3fZayhg2S0HZiWRVuXrQ4uuZAWY1nxAD2puLhRUm91tTaLtSAvP8hPDzhEkA7YzWsYak3M
 4INi2ldwUBB30XKBTVH0rT41vueYufU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-_9iZFFhSM_6d0mGASgTZdA-1; Fri, 22 Dec 2023 04:29:37 -0500
X-MC-Unique: _9iZFFhSM_6d0mGASgTZdA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2336591d48so80710566b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703237376; x=1703842176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yW3TuP94nSpQEOTtv1Wg5Ho23xhGFSOAhy5oZZOx0KI=;
 b=ZGpsd8y0xR1xk2j2I8121gBqBr3iFcUS8dV9zc7tOwjtHO+z+EhPCxPZxFzR3i7HIH
 YrL9+gbbEJAcvorUqspi1HYafxisgP8X256uEYcqaackiGo6wN3KXaEOmEHnHXZ6xn7G
 AKzly5z9VRnqc2/guRfgCt6RVGsFRAu3Fsqpz6WuKPSeqei9T2KghJG+XpGaVD4hLwQL
 9IscbE/1n/aK+Jg5gQo3q7HqyBpZEKokf2GsrjY+qNZ8hYxbHy9jhxVpdcpXfiIMv2TG
 lyQeZyMaYbjwdDtusme1nhkrzQB0GXW92Lt+L8i17+pVo0O50pc2ExnGebzT3QPRMfEC
 KTLg==
X-Gm-Message-State: AOJu0YwkxqyEZ4xHykBugLSgpfgdb/DX3bLBqVhGTo/KNb2uLSw+NZsF
 22za7VfJOzZyqRrM1pRi8yHrWi5ZHVHQeDrEK71MqkEbg+Hd004WD6DU23wWDRFotm0R4li5c0m
 Bu6hmVxzDDwQJI/+NCGUJtF3iCZndiZK8pqmEEYg=
X-Received: by 2002:a17:906:3f05:b0:a19:a19a:ea9f with SMTP id
 c5-20020a1709063f0500b00a19a19aea9fmr507894ejj.88.1703237376493; 
 Fri, 22 Dec 2023 01:29:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxhjkp+KMwy5Kg8kXIq2mo0Uwl+aZAIFLDXPfuwhtvN7hckjEgZSiQjEdKdMudcU5jM8yu6cQi0JAWfpEpDnI=
X-Received: by 2002:a17:906:3f05:b0:a19:a19a:ea9f with SMTP id
 c5-20020a1709063f0500b00a19a19aea9fmr507886ejj.88.1703237376130; Fri, 22 Dec
 2023 01:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20231221174322.3130442-1-eperezma@redhat.com>
 <20231221174322.3130442-2-eperezma@redhat.com>
In-Reply-To: <20231221174322.3130442-2-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 22 Dec 2023 17:28:59 +0800
Message-ID: <CAPpAL=xZ6hsUo5KkM68cc3DKmx=e=n1iBdkkZA_Kc-MxvaS5nA@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] vdpa: add VhostVDPAShared
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 si-wei.liu@oracle.com, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

QE tested this series v4 with regression tests. It has fixed the qemu
core issues that hit last time.And everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>




On Fri, Dec 22, 2023 at 1:43=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
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
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
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


