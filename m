Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701CB80041E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 07:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8xEO-0005QO-I9; Fri, 01 Dec 2023 01:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r8xEL-0005QB-Iu
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 01:42:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1r8xEJ-0002sq-OP
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 01:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701412946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19HEhKkDkaHHQZRcgehTqE/WZWdT98DnJnGR1nOVcCw=;
 b=NEy+SrSxD968JJEA563B0RhSGav+06HktZd1DWL55wULfVzoMOX8ndry59spiqMrhav2h+
 QqRGhl9P5OykP4EGX+sC97tB01chQQuHPJB1guRB6iggdqgHaqWrhxBC7oDqqroIiMe609
 UTvfRx2mk6UIjybZNiMMOJXAJc+wHeU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-e_UapaGAPW-fTfxzQ5mMRg-1; Fri, 01 Dec 2023 01:42:24 -0500
X-MC-Unique: e_UapaGAPW-fTfxzQ5mMRg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5d42c43d8daso1514787b3.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 22:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701412944; x=1702017744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19HEhKkDkaHHQZRcgehTqE/WZWdT98DnJnGR1nOVcCw=;
 b=YKppusHKBgbwyzKyxcN9MYeUk9NkAHpbq5uBqDaEifBghg02vda45RxaX3R9QBH3WB
 z4gh4fNBlrXnj6f+lnJ0M97DLlIaIMGG8faF6noNQHO6EAXRhmCrhNCh+8oG9IYL1PnC
 nyv0DQX+PjpwrnqW/vVr1+MYxc5/LZf7yI1Xven4mbMuFsvv21mZuX9ob1htn6iOFcPs
 k70e+2MTV9YwO6shcdyaSBKSgtk/umEsgULZXs2G6OaT2F5I7XunMI6ndJAGpfTIEuXH
 vdLBlpy7uxIaoDxpENONUUKN6Ol4TfdJM33Kucw82Y3BGDX6D+adqM7ov7/FOXGDhF+k
 lzzA==
X-Gm-Message-State: AOJu0YyKY4eunWw0Ji3BejPAkRNFnV5yISkSKy43AiOhPpFlbWCTIAsn
 19GjWozEbIisvB6oDUzriuv6snjqIpAfBSmZC4gsf8iYF7FI/va/jSlMbl0C70NVHiSSeg16xHv
 eAJ1FsuWhh5UAGE4mhSCdmbEG2479jC0=
X-Received: by 2002:a81:99d3:0:b0:5d3:a63b:88f7 with SMTP id
 q202-20020a8199d3000000b005d3a63b88f7mr2259377ywg.25.1701412944371; 
 Thu, 30 Nov 2023 22:42:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXLCxRKKzaB3a4X6aZXNgEKDQgzRwA7KP2Te4Pmhf+mHFrn2cBTCau4GPUTMgbY3AxqlxSxrx5AZ9ozwmIYl4=
X-Received: by 2002:a81:99d3:0:b0:5d3:a63b:88f7 with SMTP id
 q202-20020a8199d3000000b005d3a63b88f7mr2259360ywg.25.1701412944060; Thu, 30
 Nov 2023 22:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
 <20231124171430.2964464-2-eperezma@redhat.com>
 <CACGkMEuJcJvp3odHLMtjh2A-2MP9r3P19XXC_1yfikUdRftLBw@mail.gmail.com>
In-Reply-To: <CACGkMEuJcJvp3odHLMtjh2A-2MP9r3P19XXC_1yfikUdRftLBw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 1 Dec 2023 07:41:47 +0100
Message-ID: <CAJaqyWc0r0v7LzQisVe7TUd=rkL7fSm9zrn7rkLRedVxEsOWgg@mail.gmail.com>
Subject: Re: [PATCH 9.0 01/13] vdpa: add VhostVDPAShared
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Dec 1, 2023 at 6:35=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > It will hold properties shared among all vhost_vdpa instances associate=
d
> > with of the same device.  For example, we just need one iova_tree or on=
e
> > memory listener for the entire device.
> >
> > Next patches will register the vhost_vdpa memory listener at the
> > beginning of the VM migration at the destination. This enables QEMU to
> > map the memory to the device before stopping the VM at the source,
> > instead of doing while both source and destination are stopped, thus
> > minimizing the downtime.
> >
> > However, the destination QEMU is unaware of which vhost_vdpa struct wil=
l
> > register its memory_listener.  If the source guest has CVQ enabled, it
> > will be the one associated with the CVQ.  Otherwise, it will be the
> > first one.
> >
> > Save the memory operations related members in a common place rather tha=
n
> > always in the first / last vhost_vdpa.
>
> Great.
>
> Patch looks good but I think we probably need a better name like
> VhostVDPAParent?
>

Sure, I'm ok with the renaming. I'll change it for v2.

Thanks!

> And it would be better in the future if we can convert it to QOM.
>
> Thanks
>
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  include/hw/virtio/vhost-vdpa.h |  5 +++++
> >  net/vhost-vdpa.c               | 24 ++++++++++++++++++++++--
> >  2 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-v=
dpa.h
> > index 5407d54fd7..eb1a56d75a 100644
> > --- a/include/hw/virtio/vhost-vdpa.h
> > +++ b/include/hw/virtio/vhost-vdpa.h
> > @@ -30,6 +30,10 @@ typedef struct VhostVDPAHostNotifier {
> >      void *addr;
> >  } VhostVDPAHostNotifier;
> >
> > +/* Info shared by all vhost_vdpa device models */
> > +typedef struct vhost_vdpa_shared {
> > +} VhostVDPAShared;
> > +
> >  typedef struct vhost_vdpa {
> >      int device_fd;
> >      int index;
> > @@ -46,6 +50,7 @@ typedef struct vhost_vdpa {
> >      bool suspended;
> >      /* IOVA mapping used by the Shadow Virtqueue */
> >      VhostIOVATree *iova_tree;
> > +    VhostVDPAShared *shared;
> >      GPtrArray *shadow_vqs;
> >      const VhostShadowVirtqueueOps *shadow_vq_ops;
> >      void *shadow_vq_ops_opaque;
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index d0614d7954..8b661b9e6d 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -240,6 +240,10 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
> >          qemu_close(s->vhost_vdpa.device_fd);
> >          s->vhost_vdpa.device_fd =3D -1;
> >      }
> > +    if (s->vhost_vdpa.index !=3D 0) {
> > +        return;
> > +    }
> > +    g_free(s->vhost_vdpa.shared);
> >  }
> >
> >  /** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
> > @@ -1661,6 +1665,7 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> >                                         bool svq,
> >                                         struct vhost_vdpa_iova_range io=
va_range,
> >                                         uint64_t features,
> > +                                       VhostVDPAShared *shared,
> >                                         Error **errp)
> >  {
> >      NetClientState *nc =3D NULL;
> > @@ -1696,6 +1701,7 @@ static NetClientState *net_vhost_vdpa_init(NetCli=
entState *peer,
> >      if (queue_pair_index =3D=3D 0) {
> >          vhost_vdpa_net_valid_svq_features(features,
> >                                            &s->vhost_vdpa.migration_blo=
cker);
> > +        s->vhost_vdpa.shared =3D g_new0(VhostVDPAShared, 1);
> >      } else if (!is_datapath) {
> >          s->cvq_cmd_out_buffer =3D mmap(NULL, vhost_vdpa_net_cvq_cmd_pa=
ge_len(),
> >                                       PROT_READ | PROT_WRITE,
> > @@ -1708,11 +1714,16 @@ static NetClientState *net_vhost_vdpa_init(NetC=
lientState *peer,
> >          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> >          s->cvq_isolated =3D cvq_isolated;
> >      }
> > +    if (queue_pair_index !=3D 0) {
> > +        s->vhost_vdpa.shared =3D shared;
> > +    }
> > +
> >      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_inde=
x, nvqs);
> >      if (ret) {
> >          qemu_del_net_client(nc);
> >          return NULL;
> >      }
> > +
> >      return nc;
> >  }
> >
> > @@ -1824,17 +1835,26 @@ int net_init_vhost_vdpa(const Netdev *netdev, c=
onst char *name,
> >      ncs =3D g_malloc0(sizeof(*ncs) * queue_pairs);
> >
> >      for (i =3D 0; i < queue_pairs; i++) {
> > +        VhostVDPAShared *shared =3D NULL;
> > +
> > +        if (i) {
> > +            shared =3D DO_UPCAST(VhostVDPAState, nc, ncs[0])->vhost_vd=
pa.shared;
> > +        }
> >          ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> >                                       vdpa_device_fd, i, 2, true, opts-=
>x_svq,
> > -                                     iova_range, features, errp);
> > +                                     iova_range, features, shared, err=
p);
> >          if (!ncs[i])
> >              goto err;
> >      }
> >
> >      if (has_cvq) {
> > +        VhostVDPAState *s0 =3D DO_UPCAST(VhostVDPAState, nc, ncs[0]);
> > +        VhostVDPAShared *shared =3D s0->vhost_vdpa.shared;
> > +
> >          nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
> >                                   vdpa_device_fd, i, 1, false,
> > -                                 opts->x_svq, iova_range, features, er=
rp);
> > +                                 opts->x_svq, iova_range, features, sh=
ared,
> > +                                 errp);
> >          if (!nc)
> >              goto err;
> >      }
> > --
> > 2.39.3
> >
>


