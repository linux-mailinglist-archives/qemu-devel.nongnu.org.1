Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0059B7062AB
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCQZ-000211-TZ; Wed, 17 May 2023 04:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzCQY-00020r-5v
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1pzCQW-0005BH-7A
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684311747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T9GtXqLB7qpQ23tJ7SUUet5qoBptqpBDI8LrxsWZuvI=;
 b=F5SBMCeJN6GM2QMhjg+hsUkuboD+oXOi+5i4uXUf7ttZOF4OqPceyYi+tdoFP1GlR+ql0P
 4ny8U1+UyVBHKlAAiR54MPCxqC5Peys9RAnGaAg/sG5laSkLCOAUpUkMeIweDNpAgYwM/C
 dB+bm4XNzJND77nAw+HI+iZGwwX3vWg=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-G8z1TmBaP4SHBbnLys1NPw-1; Wed, 17 May 2023 04:22:25 -0400
X-MC-Unique: G8z1TmBaP4SHBbnLys1NPw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-561a80d872dso6007277b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 01:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311745; x=1686903745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9GtXqLB7qpQ23tJ7SUUet5qoBptqpBDI8LrxsWZuvI=;
 b=T1yLMCuFtm8O2H6fJNC0AxH1FGmVtzjtuSGPPeXeN8aPL8RE8UumfOEKEhKq00C7g6
 e0K7ZoOcFzulqBOUYmiC9cBtMJUNNWUBQWe2xkSW6as2XLSTlcM3Rwdq8WOS9Da8VMhH
 //rRA7PZ0c3z8E9Is3ANFGNdlgt1JPOnte/bdccqSwsKXD5hFqmxFZLj+mJbi7YzMG4t
 vvUjDuD9CO5jXsakhtL7qP+r8uazx65t1wnRsxvUM4/jQBIOqJvf5CwBfxkkurEy0jZJ
 h4dJPl3C1QU+PDRjBq8wZqfQFhskAwMvK5T+tn2btgE0sb+aZpMFxTZFLSEUs+ZsXrFc
 LpjA==
X-Gm-Message-State: AC+VfDxn5fnSqEuc/DZkVk/ya8ZHK5Wj+/NFqZvixOY0mrht7XqGSbIV
 3iE/3HSXJSGmx0+Jy/W9qAy4kyVdWPiuZRYgkO5knZizyvWVwDKBoMw9qDuL0YCniYU0CkI/k56
 W3wOkAbhPnc7WgRPveMrlpqs2wQtVPVY=
X-Received: by 2002:a0d:d516:0:b0:561:a3e6:bfc7 with SMTP id
 x22-20020a0dd516000000b00561a3e6bfc7mr3208594ywd.52.1684311745383; 
 Wed, 17 May 2023 01:22:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bSM+PkMj6oz0yFp1YCUW16qyfqcoCfmj5TngAtHFrJbpvMpD+p0D9rEPHCnLjD9dzXElD55cHQXmfIxpFof8=
X-Received: by 2002:a0d:d516:0:b0:561:a3e6:bfc7 with SMTP id
 x22-20020a0dd516000000b00561a3e6bfc7mr3208588ywd.52.1684311745114; Wed, 17
 May 2023 01:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
In-Reply-To: <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 17 May 2023 10:21:49 +0200
Message-ID: <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Jason Wang <jasowang@redhat.com>
Cc: Hawkins Jiawei <yin31149@gmail.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
> >
> > This patch introduces the vhost_vdpa_net_cvq_add() and
> > refactors the vhost_vdpa_net_load*(), so that QEMU can
> > send CVQ state load commands in parallel.
> >
> > To be more specific, this patch introduces vhost_vdpa_net_cvq_add()
> > to add SVQ control commands to SVQ and kick the device,
> > but does not poll the device used buffers. QEMU will not
> > poll and check the device used buffers in vhost_vdpa_net_load()
> > until all CVQ state load commands have been sent to the device.
> >
> > What's more, in order to avoid buffer overwriting caused by
> > using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> > buffer for all CVQ state load commands when sending
> > CVQ state load commands in parallel, this patch introduces
> > `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> > pointing to the available buffer for in descriptor and
> > out descriptor, so that different CVQ state load commands can
> > use their unique buffer.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 120 insertions(+), 32 deletions(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 10804c7200..14e31ca5c5 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClientState=
 *nc)
> >      vhost_vdpa_net_client_stop(nc);
> >  }
> >
> > +/**
> > + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> > + * kicks the device but does not poll the device used buffers.
> > + *
> > + * Return the number of elements added to SVQ if success.
> > + */
> > +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> > +                                void **out_cursor, size_t out_len,
>
> Can we track things like cursors in e.g VhostVDPAState ?
>

Cursors will only be used at device startup. After that, cursors are
always the full buffer. Do we want to "pollute" VhostVDPAState with
things that will not be used after the startup?

Maybe we can create a struct for them and then pass just this struct?

Thanks!

> > +                                virtio_net_ctrl_ack **in_cursor, size_=
t in_len)
> > +{
> > +    /* Buffers for the device */
> > +    const struct iovec out =3D {
> > +        .iov_base =3D *out_cursor,
> > +        .iov_len =3D out_len,
> > +    };
> > +    const struct iovec in =3D {
> > +        .iov_base =3D *in_cursor,
> > +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> > +    };
> > +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shad=
ow_vqs, 0);
> > +    int r;
> > +
> > +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> > +    if (unlikely(r !=3D 0)) {
> > +        if (unlikely(r =3D=3D -ENOSPC)) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device que=
ue\n",
> > +                          __func__);
> > +        }
> > +        return r;
> > +    }
> > +
> > +    /* Update the cursor */
> > +    *out_cursor +=3D out_len;
> > +    *in_cursor +=3D 1;
> > +
> > +    return 1;
> > +}
> > +
> >  /**
> >   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to SVQ,
> >   * kicks the device and polls the device used buffers.
> > @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_wait(Vh=
ostVDPAState *s,
> >      return vhost_svq_poll(svq);
> >  }
> >
> > -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t clas=
s,
> > -                                       uint8_t cmd, const void *data,
> > -                                       size_t data_size)
> > +
> > +/**
> > + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
> > + *
> > + * Return the number of elements added to SVQ if success.
> > + */
> > +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> > +                                void **out_cursor, uint8_t class, uint=
8_t cmd,
> > +                                const void *data, size_t data_size,
> > +                                virtio_net_ctrl_ack **in_cursor)
> >  {
> >      const struct virtio_net_ctrl_hdr ctrl =3D {
> >          .class =3D class,
> >          .cmd =3D cmd,
> >      };
> >
> > -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
> > +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> > +                          (*out_cursor - s->cvq_cmd_out_buffer));
> > +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
) -
> > +                       (*out_cursor - s->cvq_cmd_out_buffer));
> >
> > -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> > -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> > +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> > +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
> >
> > -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_size=
,
> > -                                  sizeof(virtio_net_ctrl_ack));
> > +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + data_s=
ize,
> > +                                  in_cursor, sizeof(virtio_net_ctrl_ac=
k));
> >  }
> >
> > -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n)
> > +/**
> > + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> > + *
> > + * Return the number of elements added to SVQ if success.
> > + */
> > +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n,
> > +                            void **out_cursor, virtio_net_ctrl_ack **i=
n_cursor)
> >  {
> >      uint64_t features =3D n->parent_obj.guest_features;
> >      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_=
CTRL_MAC,
> > -                                                  VIRTIO_NET_CTRL_MAC_=
ADDR_SET,
> > -                                                  n->mac, sizeof(n->ma=
c));
> > -        if (unlikely(dev_written < 0)) {
> > -            return dev_written;
> > -        }
> > -
> > -        return *s->status !=3D VIRTIO_NET_OK;
> > +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_=
MAC,
> > +                                       VIRTIO_NET_CTRL_MAC_ADDR_SET,
> > +                                       n->mac, sizeof(n->mac), in_curs=
or);
> >      }
> >
> >      return 0;
> >  }
> >
> > -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > -                                  const VirtIONet *n)
> > +/**
> > + * vhost_vdpa_net_load_mac() restores the NIC mq state through SVQ.
> > + *
> > + * Return the number of elements added to SVQ if success.
> > + */
> > +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtIONet *=
n,
> > +                            void **out_cursor, virtio_net_ctrl_ack **i=
n_cursor)
> >  {
> >      struct virtio_net_ctrl_mq mq;
> >      uint64_t features =3D n->parent_obj.guest_features;
> > -    ssize_t dev_written;
> >
> >      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> >          return 0;
> >      }
> >
> >      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> > -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> > -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_=
SET, &mq,
> > -                                          sizeof(mq));
> > -    if (unlikely(dev_written < 0)) {
> > -        return dev_written;
> > -    }
> > -
> > -    return *s->status !=3D VIRTIO_NET_OK;
> > +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_MQ,
> > +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
> > +                                   &mq, sizeof(mq), in_cursor);
> >  }
> >
> >  static int vhost_vdpa_net_load(NetClientState *nc)
> >  {
> >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > +    VhostShadowVirtqueue *svq;
> > +    void *out_cursor;
> > +    virtio_net_ctrl_ack *in_cursor;
> >      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> >      const VirtIONet *n;
> > -    int r;
> > +    ssize_t cmds_in_flight =3D 0, dev_written, r;
> >
> >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> >
> > @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
> >      }
> >
> >      n =3D VIRTIO_NET(v->dev->vdev);
> > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > +    out_cursor =3D s->cvq_cmd_out_buffer;
> > +    in_cursor =3D s->status;
> > +
> > +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
> >      if (unlikely(r < 0))
> >          return r;
> >      }
> > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > -    if (unlikely(r)) {
> > +    cmds_in_flight +=3D r;
> > +
> > +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
> > +    if (unlikely(r < 0)) {
> >          return r;
> >      }
> > +    cmds_in_flight +=3D r;
> > +
> > +    /* Poll for all used buffer from device */
> > +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> > +    while (cmds_in_flight > 0) {
> > +        /*
> > +         * We can poll here since we've had BQL from the time we sent =
the
> > +         * descriptor. Also, we need to take the answer before SVQ pul=
ls
> > +         * by itself, when BQL is released
> > +         */
> > +        dev_written =3D vhost_svq_poll(svq);
>
> I'd tweak vhost_svq_poll to accept cmds_in_flight.
>
> Thanks
>
> > +
> > +        if (unlikely(!dev_written)) {
> > +            /*
> > +             * vhost_svq_poll() return 0 when something wrong, such as
> > +             * QEMU waits for too long time or no available used buffe=
r
> > +             * from device, and there is no need to continue polling
> > +             * in this case.
> > +             */
> > +            return -EINVAL;
> > +        }
> > +
> > +        --cmds_in_flight;
> > +    }
> > +
> > +    /* Check the buffers written by device */
> > +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_cursor=
;
> > +         ++status) {
> > +        if (*status !=3D VIRTIO_NET_OK) {
> > +            return -EINVAL;
> > +        }
> > +    }
> >
> >      return 0;
> >  }
> > --
> > 2.25.1
> >
>


