Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1576707A06
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWht-0003yj-P8; Thu, 18 May 2023 02:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzWgt-0003sw-Qk
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzWgr-0003KI-In
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684389639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TysSvWoi+NYCly++hsXJJt9+JmMCPK1iMLZbo+0AqQ=;
 b=QgxcUMewfF7OxeO97v9biZgppLk/N2VxxHGmhXC/ZhAdsaP5OEVjK5KpZfUpVf0JbgWlPP
 qEgagwp7fg7di/ucR8rvLBHCoWuVUlDDWVF0aR7loxUEyvH4vuZjaI8K1EaTWGEGI7qsXo
 bTwk77LLDI98tTj7V8ue6l8i8P2IlDA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-9zS3OgxmPbOgHurDCGqfyg-1; Thu, 18 May 2023 02:00:38 -0400
X-MC-Unique: 9zS3OgxmPbOgHurDCGqfyg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-559e55b8766so25350807b3.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684389638; x=1686981638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TysSvWoi+NYCly++hsXJJt9+JmMCPK1iMLZbo+0AqQ=;
 b=d/jo3jDLWjIAtycivL1knubKgYIUMFdgNGjuGYeaAzPOeOZhbBcIkMc9prkb3aD+UL
 f8691MGq0EVZD8CPmBKMnFOGATz5xT6xOW7MgKzdXTmX4zBja+oRLEqtQzik3KjN2VLo
 lN+9qamDpa86SqOyZtCPJlpetIpvpN153GeFBrucIbPbidWbgnG3uJFFb3Ipl6EOs5mD
 u0THZD5yI+JIm1Q3c8/XpTe/80bp9vSY8EGA2E4qujoMbAta8y32yYImefPoIhZ8sYwa
 0j8Vx9yG/6avdZ9KAGtWJjcsuh4Uqq7fOylKxv21RmhX1T0DG0zXO2LDXEhnIPZtmsT0
 baTw==
X-Gm-Message-State: AC+VfDzQKhhLNbhpImzgKfmQNkw+KyQq3fkIokxV3nnexiQSLWUdGF12
 rhc5YFK2ePLA1UXvBl/SXtp4zHYQlO1UR3CydB8VSoqdUNldcO1sO4pBqjZJIBwfehv9GmUZfvB
 ldxX+2XUmcgftyJpX6DMBptV+x0gGsedZhRwM6mnQuQ==
X-Received: by 2002:a0d:db0d:0:b0:55a:3cd6:cded with SMTP id
 d13-20020a0ddb0d000000b0055a3cd6cdedmr682217ywe.4.1684389637906; 
 Wed, 17 May 2023 23:00:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Y+M8LWjLm/oZqY5Hs/8oeVPJKHEm9a7LhRM1hFa+8heIEZq0tRoRjtCSuG5AVzILK8yBrAFDrpnr1MIV2xHE=
X-Received: by 2002:a0d:db0d:0:b0:55a:3cd6:cded with SMTP id
 d13-20020a0ddb0d000000b0055a3cd6cdedmr682197ywe.4.1684389637556; Wed, 17 May
 2023 23:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
 <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
 <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
 <CACGkMEuKYnu0st4UttOhGb56Y5tvi3pnFPRM_RgSTj_rQicZqg@mail.gmail.com>
In-Reply-To: <CACGkMEuKYnu0st4UttOhGb56Y5tvi3pnFPRM_RgSTj_rQicZqg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 May 2023 08:00:00 +0200
Message-ID: <CAJaqyWde_GrJHp9zbY4vfDdkMeUpemE24J=zvSqdZ1ji2CXhxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Jason Wang <jasowang@redhat.com>
Cc: Hawkins Jiawei <yin31149@gmail.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, May 18, 2023 at 7:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, May 17, 2023 at 11:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
> >
> > Sorry for forgetting cc when replying to the email.
> >
> > On Wed, 17 May 2023 at 16:22, Eugenio Perez Martin <eperezma@redhat.com=
> wrote:
> > >
> > > On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gm=
ail.com> wrote:
> > > > >
> > > > > This patch introduces the vhost_vdpa_net_cvq_add() and
> > > > > refactors the vhost_vdpa_net_load*(), so that QEMU can
> > > > > send CVQ state load commands in parallel.
> > > > >
> > > > > To be more specific, this patch introduces vhost_vdpa_net_cvq_add=
()
> > > > > to add SVQ control commands to SVQ and kick the device,
> > > > > but does not poll the device used buffers. QEMU will not
> > > > > poll and check the device used buffers in vhost_vdpa_net_load()
> > > > > until all CVQ state load commands have been sent to the device.
> > > > >
> > > > > What's more, in order to avoid buffer overwriting caused by
> > > > > using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> > > > > buffer for all CVQ state load commands when sending
> > > > > CVQ state load commands in parallel, this patch introduces
> > > > > `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> > > > > pointing to the available buffer for in descriptor and
> > > > > out descriptor, so that different CVQ state load commands can
> > > > > use their unique buffer.
> > > > >
> > > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> > > > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > > > ---
> > > > >  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++----=
------
> > > > >  1 file changed, 120 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > index 10804c7200..14e31ca5c5 100644
> > > > > --- a/net/vhost-vdpa.c
> > > > > +++ b/net/vhost-vdpa.c
> > > > > @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClien=
tState *nc)
> > > > >      vhost_vdpa_net_client_stop(nc);
> > > > >  }
> > > > >
> > > > > +/**
> > > > > + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> > > > > + * kicks the device but does not poll the device used buffers.
> > > > > + *
> > > > > + * Return the number of elements added to SVQ if success.
> > > > > + */
> > > > > +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> > > > > +                                void **out_cursor, size_t out_le=
n,
> > > >
> > > > Can we track things like cursors in e.g VhostVDPAState ?
> > > >
> > >
> > > Cursors will only be used at device startup. After that, cursors are
> > > always the full buffer. Do we want to "pollute" VhostVDPAState with
> > > things that will not be used after the startup?
>
> So it's the cursor of the cvq_cmd_out_buffer, it would be more elegant
> to keep it with where the cvq_cmd_out_buffer is placed. It can avoid
> passing cursors in several levels.
>

That's right, there is no reason to update at vhost_vdpa_net_cvq_add.
It can be done at the caller.

> Or it would be even better to have some buffer allocation helpers to
> alloc and free in and out buffers.
>

I think that's overkill, as the buffers are always the in and out CVQ
buffers. They are allocated at qemu initialization, and mapped /
unmapped at device start / stop for now.

To manage them dynamically would need code to map them at any time etc.

Thanks!

> Thanks
>
> > >
> > > Maybe we can create a struct for them and then pass just this struct?
> >
> > Yes, Currently, the new version of vhost_vdpa_net_cvq_add() is only
> > called in vhost_vdpa_net_load() at startup, so these cursors will not b=
e
> > used after startup.
> >
> > If needed, we can create a `VhostVDPACursor` as suggested by Eugenio.
> >
> > >
> > > Thanks!
> > >
> > > > > +                                virtio_net_ctrl_ack **in_cursor,=
 size_t in_len)
> > > > > +{
> > > > > +    /* Buffers for the device */
> > > > > +    const struct iovec out =3D {
> > > > > +        .iov_base =3D *out_cursor,
> > > > > +        .iov_len =3D out_len,
> > > > > +    };
> > > > > +    const struct iovec in =3D {
> > > > > +        .iov_base =3D *in_cursor,
> > > > > +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> > > > > +    };
> > > > > +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdp=
a.shadow_vqs, 0);
> > > > > +    int r;
> > > > > +
> > > > > +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> > > > > +    if (unlikely(r !=3D 0)) {
> > > > > +        if (unlikely(r =3D=3D -ENOSPC)) {
> > > > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on devi=
ce queue\n",
> > > > > +                          __func__);
> > > > > +        }
> > > > > +        return r;
> > > > > +    }
> > > > > +
> > > > > +    /* Update the cursor */
> > > > > +    *out_cursor +=3D out_len;
> > > > > +    *in_cursor +=3D 1;
> > > > > +
> > > > > +    return 1;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands t=
o SVQ,
> > > > >   * kicks the device and polls the device used buffers.
> > > > > @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_w=
ait(VhostVDPAState *s,
> > > > >      return vhost_svq_poll(svq);
> > > > >  }
> > > > >
> > > > > -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_=
t class,
> > > > > -                                       uint8_t cmd, const void *=
data,
> > > > > -                                       size_t data_size)
> > > > > +
> > > > > +/**
> > > > > + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
> > > > > + *
> > > > > + * Return the number of elements added to SVQ if success.
> > > > > + */
> > > > > +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> > > > > +                                void **out_cursor, uint8_t class=
, uint8_t cmd,
> > > > > +                                const void *data, size_t data_si=
ze,
> > > > > +                                virtio_net_ctrl_ack **in_cursor)
> > > > >  {
> > > > >      const struct virtio_net_ctrl_hdr ctrl =3D {
> > > > >          .class =3D class,
> > > > >          .cmd =3D cmd,
> > > > >      };
> > > > >
> > > > > -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeo=
f(ctrl));
> > > > > +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> > > > > +                          (*out_cursor - s->cvq_cmd_out_buffer))=
;
> > > > > +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeo=
f(ctrl) -
> > > > > +                       (*out_cursor - s->cvq_cmd_out_buffer));
> > > > >
> > > > > -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> > > > > -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size=
);
> > > > > +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> > > > > +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
> > > > >
> > > > > -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + dat=
a_size,
> > > > > -                                  sizeof(virtio_net_ctrl_ack));
> > > > > +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + =
data_size,
> > > > > +                                  in_cursor, sizeof(virtio_net_c=
trl_ack));
> > > > >  }
> > > > >
> > > > > -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const Virt=
IONet *n)
> > > > > +/**
> > > > > + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> > > > > + *
> > > > > + * Return the number of elements added to SVQ if success.
> > > > > + */
> > > > > +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const Virt=
IONet *n,
> > > > > +                            void **out_cursor, virtio_net_ctrl_a=
ck **in_cursor)
> > > > >  {
> > > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > > >      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > > > -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTI=
O_NET_CTRL_MAC,
> > > > > -                                                  VIRTIO_NET_CTR=
L_MAC_ADDR_SET,
> > > > > -                                                  n->mac, sizeof=
(n->mac));
> > > > > -        if (unlikely(dev_written < 0)) {
> > > > > -            return dev_written;
> > > > > -        }
> > > > > -
> > > > > -        return *s->status !=3D VIRTIO_NET_OK;
> > > > > +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET=
_CTRL_MAC,
> > > > > +                                       VIRTIO_NET_CTRL_MAC_ADDR_=
SET,
> > > > > +                                       n->mac, sizeof(n->mac), i=
n_cursor);
> > > > >      }
> > > > >
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > > > > -                                  const VirtIONet *n)
> > > > > +/**
> > > > > + * vhost_vdpa_net_load_mac() restores the NIC mq state through S=
VQ.
> > > > > + *
> > > > > + * Return the number of elements added to SVQ if success.
> > > > > + */
> > > > > +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtI=
ONet *n,
> > > > > +                            void **out_cursor, virtio_net_ctrl_a=
ck **in_cursor)
> > > > >  {
> > > > >      struct virtio_net_ctrl_mq mq;
> > > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > > > -    ssize_t dev_written;
> > > > >
> > > > >      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > > >          return 0;
> > > > >      }
> > > > >
> > > > >      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> > > > > -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_M=
Q,
> > > > > -                                          VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_SET, &mq,
> > > > > -                                          sizeof(mq));
> > > > > -    if (unlikely(dev_written < 0)) {
> > > > > -        return dev_written;
> > > > > -    }
> > > > > -
> > > > > -    return *s->status !=3D VIRTIO_NET_OK;
> > > > > +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTR=
L_MQ,
> > > > > +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_S=
ET,
> > > > > +                                   &mq, sizeof(mq), in_cursor);
> > > > >  }
> > > > >
> > > > >  static int vhost_vdpa_net_load(NetClientState *nc)
> > > > >  {
> > > > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > > > +    VhostShadowVirtqueue *svq;
> > > > > +    void *out_cursor;
> > > > > +    virtio_net_ctrl_ack *in_cursor;
> > > > >      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > > > >      const VirtIONet *n;
> > > > > -    int r;
> > > > > +    ssize_t cmds_in_flight =3D 0, dev_written, r;
> > > > >
> > > > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > > > >
> > > > > @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientSta=
te *nc)
> > > > >      }
> > > > >
> > > > >      n =3D VIRTIO_NET(v->dev->vdev);
> > > > > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > > > > +    out_cursor =3D s->cvq_cmd_out_buffer;
> > > > > +    in_cursor =3D s->status;
> > > > > +
> > > > > +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor)=
;
> > > > >      if (unlikely(r < 0))
> > > > >          return r;
> > > > >      }
> > > > > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > > > > -    if (unlikely(r)) {
> > > > > +    cmds_in_flight +=3D r;
> > > > > +
> > > > > +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
> > > > > +    if (unlikely(r < 0)) {
> > > > >          return r;
> > > > >      }
> > > > > +    cmds_in_flight +=3D r;
> > > > > +
> > > > > +    /* Poll for all used buffer from device */
> > > > > +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> > > > > +    while (cmds_in_flight > 0) {
> > > > > +        /*
> > > > > +         * We can poll here since we've had BQL from the time we=
 sent the
> > > > > +         * descriptor. Also, we need to take the answer before S=
VQ pulls
> > > > > +         * by itself, when BQL is released
> > > > > +         */
> > > > > +        dev_written =3D vhost_svq_poll(svq);
> > > >
> > > > I'd tweak vhost_svq_poll to accept cmds_in_flight.
> >
> > That sounds great!
> > I will refactor the code here and send the v2 patch after
> > your patch.
> >
> > Thanks!
> >
> > > >
> > > > Thanks
> > > >
> > > > > +
> > > > > +        if (unlikely(!dev_written)) {
> > > > > +            /*
> > > > > +             * vhost_svq_poll() return 0 when something wrong, s=
uch as
> > > > > +             * QEMU waits for too long time or no available used=
 buffer
> > > > > +             * from device, and there is no need to continue pol=
ling
> > > > > +             * in this case.
> > > > > +             */
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +
> > > > > +        --cmds_in_flight;
> > > > > +    }
> > > > > +
> > > > > +    /* Check the buffers written by device */
> > > > > +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_=
cursor;
> > > > > +         ++status) {
> > > > > +        if (*status !=3D VIRTIO_NET_OK) {
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +    }
> > > > >
> > > > >      return 0;
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > >
> >
>


