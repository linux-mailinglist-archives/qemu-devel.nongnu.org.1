Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487DD74D07B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:44:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qImVA-0005X3-UA; Mon, 10 Jul 2023 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qImV9-0005WW-Ei
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qImV7-0003iM-Ob
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688978648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THg5un5y8eUUvabMzqpL7zW+EUAduw9ckVa96/2GtzQ=;
 b=Qdn/Hfh14L/tdKjuATEWN2ahR2Pk+viZfrfotQkiskjUmG/fsoGeE0i8C8f2jFVfgBijKL
 Ao15n4ek2sbwIRhU63PjIZYpUpTU+eWg3vtM/j+mMRdQQT0iFxO5uJJMl9b968+NhzJJ4/
 KUyi1ZwKVCt+0QjoYw6HeG8nr/3+His=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-pWqbzkgbPhylC8H2CsX6mw-1; Mon, 10 Jul 2023 04:44:07 -0400
X-MC-Unique: pWqbzkgbPhylC8H2CsX6mw-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-c5cea5773e8so5584629276.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688978647; x=1691570647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THg5un5y8eUUvabMzqpL7zW+EUAduw9ckVa96/2GtzQ=;
 b=dz3K4Zad1w9qBjiSOIa8NXkhseKB2t9x1vci7eBX4DzMysfvy9vt8jAMddAqzD/1us
 4DoIXx91wy+itOtJ1EsmoGXUvkLi+0/RH65soYHNHKipL8zPryFtjsLqiJGJeIPiMcvF
 74h4+4aDtLI7N8+xzQ7KAUaJzk7+JbXuTjqVK85jOmrXDXvKP8xMvkga+fHvQwjymzUR
 fvZXpDnm1PPFFj6LLVeMWdkBblgPFrK+pzCuqmTUfubBvsxenA7cXieknuxLHBfQ5BKH
 RPhgeK4QzT+K0QAnQESLrQCVNaKJaHTP5CfUHdUZI47Z9pi6mJRGA+6wt109QuMuJWku
 Pa5w==
X-Gm-Message-State: ABy/qLbA9M9VQ0rlt18+/IHMr9i9JDnwO55JuzSebcg2rfGcnPBXq2Uh
 SJwIbOGlAC73D5kKXHzLhy2Q3Egol2YSqrOgRXrEkRMhZ2rrZVgepbFd4h/6LXLSHflVx23a805
 pdgvA/EPn9egFS4JpVt/Nm59+M9ejz+g=
X-Received: by 2002:a05:6902:8f:b0:c67:6713:83d9 with SMTP id
 h15-20020a056902008f00b00c67671383d9mr12577107ybs.7.1688978647124; 
 Mon, 10 Jul 2023 01:44:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDyGq4YUfiF8YhTY1NkCYznjWqpSWnaxTKnYyZjpFOAnM2lZ83RyeXbuaW/FSmztvqOMfdL3/I850UJbYaInk=
X-Received: by 2002:a05:6902:8f:b0:c67:6713:83d9 with SMTP id
 h15-20020a056902008f00b00c67671383d9mr12577101ybs.7.1688978646856; Mon, 10
 Jul 2023 01:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-2-eperezma@redhat.com>
 <CACGkMEs3ZkzwSiH6Xt2HRsajzKLqN3tw4F+2NxN7wF3dVVOj-Q@mail.gmail.com>
In-Reply-To: <CACGkMEs3ZkzwSiH6Xt2HRsajzKLqN3tw4F+2NxN7wF3dVVOj-Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Jul 2023 10:43:30 +0200
Message-ID: <CAJaqyWciBszZP07TdSofTJXvYvBGwrNoPN1jU2HFgTfySgGmvg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] vdpa: export vhost_vdpa_set_vring_ready
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 10, 2023 at 5:19=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > The vhost-vdpa net backend needs to enable vrings in a different order
> > than default, so export it.
> >
> > No functional change intended except for tracing, that now includes the
> > (virtio) index being enabled and the return value of the ioctl.
> >
> > Still ignoring return value of this function if called from
> > vhost_vdpa_dev_start, as reorganize calling code around it is out of
> > the scope of this series.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  include/hw/virtio/vhost-vdpa.h |  1 +
> >  hw/virtio/vhost-vdpa.c         | 28 ++++++++++++++++++++--------
> >  hw/virtio/trace-events         |  2 +-
> >  3 files changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index e64bfc7f98..5407d54fd7 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -57,6 +57,7 @@ typedef struct vhost_vdpa {
> >  } VhostVDPA;
> >
> >  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *io=
va_range);
> > +int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
> >
> >  int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iov=
a,
> >                         hwaddr size, void *vaddr, bool readonly);
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 3c575a9a6e..5978d970ee 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -528,6 +528,19 @@ int vhost_vdpa_get_iova_range(int fd, struct vhost=
_vdpa_iova_range *iova_range)
> >      return ret < 0 ? -errno : 0;
> >  }
> >
> > +int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
> > +{
> > +    struct vhost_dev *dev =3D v->dev;
> > +    struct vhost_vring_state state =3D {
> > +        .index =3D idx,
> > +        .num =3D 1,
> > +    };
> > +    int r =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state=
);
> > +
> > +    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
> > +    return r;
> > +}
> > +
> >  /*
> >   * The use of this function is for requests that only need to be
> >   * applied once. Typically such request occurs at the beginning
> > @@ -872,16 +885,15 @@ static int vhost_vdpa_get_vq_index(struct vhost_d=
ev *dev, int idx)
> >      return idx;
> >  }
> >
> > -static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> > +static int vhost_vdpa_set_vrings_ready(struct vhost_dev *dev)
> >  {
> > +    struct vhost_vdpa *v =3D dev->opaque;
> >      int i;
> > -    trace_vhost_vdpa_set_vring_ready(dev);
> > +
> > +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA=
);
>
> Nit: any reason we need to add this assert in this patch?
>

Other vhost_ops asserts, but sure we can leave it out.

Thanks!

> Thanks
>
> > +
> >      for (i =3D 0; i < dev->nvqs; ++i) {
> > -        struct vhost_vring_state state =3D {
> > -            .index =3D dev->vq_index + i,
> > -            .num =3D 1,
> > -        };
> > -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> > +        vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
> >      }
> >      return 0;
> >  }
> > @@ -1294,7 +1306,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev =
*dev, bool started)
> >          if (unlikely(!ok)) {
> >              return -1;
> >          }
> > -        vhost_vdpa_set_vring_ready(dev);
> > +        vhost_vdpa_set_vrings_ready(dev);
> >      } else {
> >          vhost_vdpa_suspend(dev);
> >          vhost_vdpa_svqs_stop(dev);
> > diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> > index 8f8d05cf9b..4f6a6ba428 100644
> > --- a/hw/virtio/trace-events
> > +++ b/hw/virtio/trace-events
> > @@ -46,7 +46,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features)=
 "dev: %p features: 0x%"PRI
> >  vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p devic=
e_id %"PRIu32
> >  vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x=
%"PRIx8
> >  vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: =
%d vq idx: %d"
> > -vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
> > +vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx=
: %u, r: %d"
> >  vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
> >  vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint3=
2_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
> >  vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "d=
ev: %p config: %p config_len: %"PRIu32
> > --
> > 2.39.3
> >
>


