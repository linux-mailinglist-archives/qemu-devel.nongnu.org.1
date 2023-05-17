Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F4706C0A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIfQ-0002kN-B5; Wed, 17 May 2023 11:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzIfD-0002jn-Ca
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:02:06 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzIf7-0004Ko-DP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:02:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ac81d2bfbcso8366001fa.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684335714; x=1686927714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO8+zDVG8DErvrwFGWSAEszt12Z4vDHvmD6IqUDRgG8=;
 b=BaRKHKWoupQFswqFKmrMW61iItvjBmqh/bYjAaIFlwbMaBYVUqLfkY0T31sfnpgjQf
 YLBRHgOzm0RbdmTgX6wPBsD4HQYbgLvzg4tvAtXyrwMVaeW/fM0vnZ9lDr4rsw5zuuI0
 kgc4G6tU1ZSyAE7Z1kjcE98OrTaUeSRNQL48gsQWQh/GEbQkQTjNvCCukelu6R05mWtn
 9G74JLH4dT6m7opaxHH7NDCxBZ6MCx+BXg7UwsmkQdtRF3tAIvURbIhGE+EXkVUtIO1R
 gZwnE1zElGeUTOtPbpoM8E+ON9+RmFcGR+qghtvIfBitPcgZP+IBA8muNLhX9ykdySDd
 2sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684335714; x=1686927714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO8+zDVG8DErvrwFGWSAEszt12Z4vDHvmD6IqUDRgG8=;
 b=h33679zxn48z/a39XyKRS45gFzhe7zKRGr91+jmkYmA02aK/FV9XE3Qytr4cgjnL9r
 wUca1iueoO1ceLQJreyE15EzFcd+uOxxy+BQupoVM3MyDAQTxmfykvcZ2smej2HVf8ib
 dQYcp5XlrUGf7kJQBPgcWNUkwY229nNGNCT4w6OqZEIbJ4emU4AwP4bCs3XZvoTK4D0X
 JlrpJ+6D+42fthYb0FR4iXZGz2BGpyfk5MFRvdYt+3fArrXct23eIn8RUXj3uGM2lCqq
 +oyQTQqG+rZ6zO4GhuBOxw/KoxA0HjR94e1klx0dL4ICzbUTq1XrxqGBSledhga07J8P
 b0Gg==
X-Gm-Message-State: AC+VfDxRQUPNtLAZaHTg5zh5flqgsrR6gtW+iWPfDodotcXtXdBSSnSr
 33dKFkziY1meFHCGwuUVhOBaYrR+6fEMrTNr+xM=
X-Google-Smtp-Source: ACHHUZ7eb09pOmYv0B5ag73bF/TfjQxGOtjWonZs1AxymYWgWzxFtHYvoFaGjpxTaTBACDZlPiNVwP+TjHvo9lTfgh4=
X-Received: by 2002:ac2:4143:0:b0:4f0:345:6ceb with SMTP id
 c3-20020ac24143000000b004f003456cebmr327693lfi.14.1684335713497; Wed, 17 May
 2023 08:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
 <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
In-Reply-To: <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 17 May 2023 23:01:40 +0800
Message-ID: <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Sorry for forgetting cc when replying to the email.

On Wed, 17 May 2023 at 16:22, Eugenio Perez Martin <eperezma@redhat.com> wr=
ote:
>
> On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> > >
> > > This patch introduces the vhost_vdpa_net_cvq_add() and
> > > refactors the vhost_vdpa_net_load*(), so that QEMU can
> > > send CVQ state load commands in parallel.
> > >
> > > To be more specific, this patch introduces vhost_vdpa_net_cvq_add()
> > > to add SVQ control commands to SVQ and kick the device,
> > > but does not poll the device used buffers. QEMU will not
> > > poll and check the device used buffers in vhost_vdpa_net_load()
> > > until all CVQ state load commands have been sent to the device.
> > >
> > > What's more, in order to avoid buffer overwriting caused by
> > > using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> > > buffer for all CVQ state load commands when sending
> > > CVQ state load commands in parallel, this patch introduces
> > > `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> > > pointing to the available buffer for in descriptor and
> > > out descriptor, so that different CVQ state load commands can
> > > use their unique buffer.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > ---
> > >  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 120 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > index 10804c7200..14e31ca5c5 100644
> > > --- a/net/vhost-vdpa.c
> > > +++ b/net/vhost-vdpa.c
> > > @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClientSta=
te *nc)
> > >      vhost_vdpa_net_client_stop(nc);
> > >  }
> > >
> > > +/**
> > > + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> > > + * kicks the device but does not poll the device used buffers.
> > > + *
> > > + * Return the number of elements added to SVQ if success.
> > > + */
> > > +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> > > +                                void **out_cursor, size_t out_len,
> >
> > Can we track things like cursors in e.g VhostVDPAState ?
> >
>
> Cursors will only be used at device startup. After that, cursors are
> always the full buffer. Do we want to "pollute" VhostVDPAState with
> things that will not be used after the startup?
>
> Maybe we can create a struct for them and then pass just this struct?

Yes, Currently, the new version of vhost_vdpa_net_cvq_add() is only
called in vhost_vdpa_net_load() at startup, so these cursors will not be
used after startup.

If needed, we can create a `VhostVDPACursor` as suggested by Eugenio.

>
> Thanks!
>
> > > +                                virtio_net_ctrl_ack **in_cursor, siz=
e_t in_len)
> > > +{
> > > +    /* Buffers for the device */
> > > +    const struct iovec out =3D {
> > > +        .iov_base =3D *out_cursor,
> > > +        .iov_len =3D out_len,
> > > +    };
> > > +    const struct iovec in =3D {
> > > +        .iov_base =3D *in_cursor,
> > > +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> > > +    };
> > > +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.sh=
adow_vqs, 0);
> > > +    int r;
> > > +
> > > +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> > > +    if (unlikely(r !=3D 0)) {
> > > +        if (unlikely(r =3D=3D -ENOSPC)) {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device q=
ueue\n",
> > > +                          __func__);
> > > +        }
> > > +        return r;
> > > +    }
> > > +
> > > +    /* Update the cursor */
> > > +    *out_cursor +=3D out_len;
> > > +    *in_cursor +=3D 1;
> > > +
> > > +    return 1;
> > > +}
> > > +
> > >  /**
> > >   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to SV=
Q,
> > >   * kicks the device and polls the device used buffers.
> > > @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_wait(=
VhostVDPAState *s,
> > >      return vhost_svq_poll(svq);
> > >  }
> > >
> > > -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t cl=
ass,
> > > -                                       uint8_t cmd, const void *data=
,
> > > -                                       size_t data_size)
> > > +
> > > +/**
> > > + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
> > > + *
> > > + * Return the number of elements added to SVQ if success.
> > > + */
> > > +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> > > +                                void **out_cursor, uint8_t class, ui=
nt8_t cmd,
> > > +                                const void *data, size_t data_size,
> > > +                                virtio_net_ctrl_ack **in_cursor)
> > >  {
> > >      const struct virtio_net_ctrl_hdr ctrl =3D {
> > >          .class =3D class,
> > >          .cmd =3D cmd,
> > >      };
> > >
> > > -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ct=
rl));
> > > +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> > > +                          (*out_cursor - s->cvq_cmd_out_buffer));
> > > +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ct=
rl) -
> > > +                       (*out_cursor - s->cvq_cmd_out_buffer));
> > >
> > > -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> > > -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> > > +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> > > +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
> > >
> > > -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_si=
ze,
> > > -                                  sizeof(virtio_net_ctrl_ack));
> > > +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + data=
_size,
> > > +                                  in_cursor, sizeof(virtio_net_ctrl_=
ack));
> > >  }
> > >
> > > -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONe=
t *n)
> > > +/**
> > > + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> > > + *
> > > + * Return the number of elements added to SVQ if success.
> > > + */
> > > +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONe=
t *n,
> > > +                            void **out_cursor, virtio_net_ctrl_ack *=
*in_cursor)
> > >  {
> > >      uint64_t features =3D n->parent_obj.guest_features;
> > >      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NE=
T_CTRL_MAC,
> > > -                                                  VIRTIO_NET_CTRL_MA=
C_ADDR_SET,
> > > -                                                  n->mac, sizeof(n->=
mac));
> > > -        if (unlikely(dev_written < 0)) {
> > > -            return dev_written;
> > > -        }
> > > -
> > > -        return *s->status !=3D VIRTIO_NET_OK;
> > > +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTR=
L_MAC,
> > > +                                       VIRTIO_NET_CTRL_MAC_ADDR_SET,
> > > +                                       n->mac, sizeof(n->mac), in_cu=
rsor);
> > >      }
> > >
> > >      return 0;
> > >  }
> > >
> > > -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > > -                                  const VirtIONet *n)
> > > +/**
> > > + * vhost_vdpa_net_load_mac() restores the NIC mq state through SVQ.
> > > + *
> > > + * Return the number of elements added to SVQ if success.
> > > + */
> > > +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtIONet=
 *n,
> > > +                            void **out_cursor, virtio_net_ctrl_ack *=
*in_cursor)
> > >  {
> > >      struct virtio_net_ctrl_mq mq;
> > >      uint64_t features =3D n->parent_obj.guest_features;
> > > -    ssize_t dev_written;
> > >
> > >      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > >          return 0;
> > >      }
> > >
> > >      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> > > -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> > > -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIR=
S_SET, &mq,
> > > -                                          sizeof(mq));
> > > -    if (unlikely(dev_written < 0)) {
> > > -        return dev_written;
> > > -    }
> > > -
> > > -    return *s->status !=3D VIRTIO_NET_OK;
> > > +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_MQ=
,
> > > +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
> > > +                                   &mq, sizeof(mq), in_cursor);
> > >  }
> > >
> > >  static int vhost_vdpa_net_load(NetClientState *nc)
> > >  {
> > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > +    VhostShadowVirtqueue *svq;
> > > +    void *out_cursor;
> > > +    virtio_net_ctrl_ack *in_cursor;
> > >      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > >      const VirtIONet *n;
> > > -    int r;
> > > +    ssize_t cmds_in_flight =3D 0, dev_written, r;
> > >
> > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > >
> > > @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientState *=
nc)
> > >      }
> > >
> > >      n =3D VIRTIO_NET(v->dev->vdev);
> > > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > > +    out_cursor =3D s->cvq_cmd_out_buffer;
> > > +    in_cursor =3D s->status;
> > > +
> > > +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
> > >      if (unlikely(r < 0))
> > >          return r;
> > >      }
> > > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > > -    if (unlikely(r)) {
> > > +    cmds_in_flight +=3D r;
> > > +
> > > +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
> > > +    if (unlikely(r < 0)) {
> > >          return r;
> > >      }
> > > +    cmds_in_flight +=3D r;
> > > +
> > > +    /* Poll for all used buffer from device */
> > > +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> > > +    while (cmds_in_flight > 0) {
> > > +        /*
> > > +         * We can poll here since we've had BQL from the time we sen=
t the
> > > +         * descriptor. Also, we need to take the answer before SVQ p=
ulls
> > > +         * by itself, when BQL is released
> > > +         */
> > > +        dev_written =3D vhost_svq_poll(svq);
> >
> > I'd tweak vhost_svq_poll to accept cmds_in_flight.

That sounds great!
I will refactor the code here and send the v2 patch after
your patch.

Thanks!

> >
> > Thanks
> >
> > > +
> > > +        if (unlikely(!dev_written)) {
> > > +            /*
> > > +             * vhost_svq_poll() return 0 when something wrong, such =
as
> > > +             * QEMU waits for too long time or no available used buf=
fer
> > > +             * from device, and there is no need to continue polling
> > > +             * in this case.
> > > +             */
> > > +            return -EINVAL;
> > > +        }
> > > +
> > > +        --cmds_in_flight;
> > > +    }
> > > +
> > > +    /* Check the buffers written by device */
> > > +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_curs=
or;
> > > +         ++status) {
> > > +        if (*status !=3D VIRTIO_NET_OK) {
> > > +            return -EINVAL;
> > > +        }
> > > +    }
> > >
> > >      return 0;
> > >  }
> > > --
> > > 2.25.1
> > >
> >
>

