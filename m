Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F27079CA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 07:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWTn-000107-OQ; Thu, 18 May 2023 01:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWTg-0000zm-Mu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWTe-000163-Bu
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684388820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/WwhAet4Asw6jgqKPhyB1c44g3PvXav+ttc7CXrEuI=;
 b=iqlwVXe9pplWk/7Ph8/9vj8QaeFAPZ+1V/9EbdEPdVwpgTip8EbohDIJwMHVDWnkIbFfr+
 wUE6+vtJ8Qih6Y7LIfYgG5REXQe+6KyqODiG3ikAQwHsCf+j+zHu9Aydto8iw2Q/GTajlg
 wdqeZJAfMe/gchh+cMtyufXMKJZKpbI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-x0x6AzY2P0esY02Dc4OYWA-1; Thu, 18 May 2023 01:46:57 -0400
X-MC-Unique: x0x6AzY2P0esY02Dc4OYWA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3923306d0so1137039e87.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 22:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684388816; x=1686980816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/WwhAet4Asw6jgqKPhyB1c44g3PvXav+ttc7CXrEuI=;
 b=AS1bvABmg4Pik09zjZHIniuM1l8XFDeHGQ+wdyEnYkEcpeej+c4kfNn25zFFKj09W3
 No2YOZ/HFjizAjbst3bZxbHYv2nunE5FRBZ7gdIiy5m2PE7o+Wvxi73GoN4VaZHDLfJY
 hKnHBLZ7hx5TPEoIXX/8L8HGjfIPf8UmBddTCsDQDYZWB5U8M0gTy9LFeLW/rsBE7Iww
 yrzPdQjI8OU7mbEE9cNj2q3gtIa9xPZJee3JXD34otcDjPVtSQiMkVWGPEA037tspFwg
 ZUbe03mV2pl3tp+2rOyV0kAabmTE7hi56Xj1MgAIIEuKKj4jbeCIT3Gw47RIkkHNGkAB
 3pdg==
X-Gm-Message-State: AC+VfDzYchqimTuvvr7ezWFkvuu25oIXsLdI0fX0pcJzuYOYRvdYLxVv
 1JjRvPT66bbAq+VlCRZtfh5vepFuHMf1HYpjTmSJ0bVD+qiOzms/i+JTAMmbdZlnM2tvkXIGpgd
 BM26WP761UNQmcXi8kreob14hVjiaBxM=
X-Received: by 2002:ac2:562c:0:b0:4f3:93d4:2bc7 with SMTP id
 b12-20020ac2562c000000b004f393d42bc7mr1022191lff.36.1684388816474; 
 Wed, 17 May 2023 22:46:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78xxcUNNWheo/9fi6Mv/Y9O7NiCN1UEPYzgbeSVTkOUISiUvdEKQypf83whueGZINqo0Mq/jWoo/I7eJOkqG0=
X-Received: by 2002:ac2:562c:0:b0:4f3:93d4:2bc7 with SMTP id
 b12-20020ac2562c000000b004f393d42bc7mr1022186lff.36.1684388816131; Wed, 17
 May 2023 22:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
 <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
 <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
In-Reply-To: <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 13:46:44 +0800
Message-ID: <CACGkMEuKYnu0st4UttOhGb56Y5tvi3pnFPRM_RgSTj_rQicZqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, May 17, 2023 at 11:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> Sorry for forgetting cc when replying to the email.
>
> On Wed, 17 May 2023 at 16:22, Eugenio Perez Martin <eperezma@redhat.com> =
wrote:
> >
> > On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gmai=
l.com> wrote:
> > > >
> > > > This patch introduces the vhost_vdpa_net_cvq_add() and
> > > > refactors the vhost_vdpa_net_load*(), so that QEMU can
> > > > send CVQ state load commands in parallel.
> > > >
> > > > To be more specific, this patch introduces vhost_vdpa_net_cvq_add()
> > > > to add SVQ control commands to SVQ and kick the device,
> > > > but does not poll the device used buffers. QEMU will not
> > > > poll and check the device used buffers in vhost_vdpa_net_load()
> > > > until all CVQ state load commands have been sent to the device.
> > > >
> > > > What's more, in order to avoid buffer overwriting caused by
> > > > using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> > > > buffer for all CVQ state load commands when sending
> > > > CVQ state load commands in parallel, this patch introduces
> > > > `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> > > > pointing to the available buffer for in descriptor and
> > > > out descriptor, so that different CVQ state load commands can
> > > > use their unique buffer.
> > > >
> > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> > > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > > ---
> > > >  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++------=
----
> > > >  1 file changed, 120 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > index 10804c7200..14e31ca5c5 100644
> > > > --- a/net/vhost-vdpa.c
> > > > +++ b/net/vhost-vdpa.c
> > > > @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetClientS=
tate *nc)
> > > >      vhost_vdpa_net_client_stop(nc);
> > > >  }
> > > >
> > > > +/**
> > > > + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> > > > + * kicks the device but does not poll the device used buffers.
> > > > + *
> > > > + * Return the number of elements added to SVQ if success.
> > > > + */
> > > > +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> > > > +                                void **out_cursor, size_t out_len,
> > >
> > > Can we track things like cursors in e.g VhostVDPAState ?
> > >
> >
> > Cursors will only be used at device startup. After that, cursors are
> > always the full buffer. Do we want to "pollute" VhostVDPAState with
> > things that will not be used after the startup?

So it's the cursor of the cvq_cmd_out_buffer, it would be more elegant
to keep it with where the cvq_cmd_out_buffer is placed. It can avoid
passing cursors in several levels.

Or it would be even better to have some buffer allocation helpers to
alloc and free in and out buffers.

Thanks

> >
> > Maybe we can create a struct for them and then pass just this struct?
>
> Yes, Currently, the new version of vhost_vdpa_net_cvq_add() is only
> called in vhost_vdpa_net_load() at startup, so these cursors will not be
> used after startup.
>
> If needed, we can create a `VhostVDPACursor` as suggested by Eugenio.
>
> >
> > Thanks!
> >
> > > > +                                virtio_net_ctrl_ack **in_cursor, s=
ize_t in_len)
> > > > +{
> > > > +    /* Buffers for the device */
> > > > +    const struct iovec out =3D {
> > > > +        .iov_base =3D *out_cursor,
> > > > +        .iov_len =3D out_len,
> > > > +    };
> > > > +    const struct iovec in =3D {
> > > > +        .iov_base =3D *in_cursor,
> > > > +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> > > > +    };
> > > > +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.=
shadow_vqs, 0);
> > > > +    int r;
> > > > +
> > > > +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> > > > +    if (unlikely(r !=3D 0)) {
> > > > +        if (unlikely(r =3D=3D -ENOSPC)) {
> > > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device=
 queue\n",
> > > > +                          __func__);
> > > > +        }
> > > > +        return r;
> > > > +    }
> > > > +
> > > > +    /* Update the cursor */
> > > > +    *out_cursor +=3D out_len;
> > > > +    *in_cursor +=3D 1;
> > > > +
> > > > +    return 1;
> > > > +}
> > > > +
> > > >  /**
> > > >   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to =
SVQ,
> > > >   * kicks the device and polls the device used buffers.
> > > > @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and_wai=
t(VhostVDPAState *s,
> > > >      return vhost_svq_poll(svq);
> > > >  }
> > > >
> > > > -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t =
class,
> > > > -                                       uint8_t cmd, const void *da=
ta,
> > > > -                                       size_t data_size)
> > > > +
> > > > +/**
> > > > + * vhost_vdpa_net_load_cmd() restores the NIC state through SVQ.
> > > > + *
> > > > + * Return the number of elements added to SVQ if success.
> > > > + */
> > > > +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> > > > +                                void **out_cursor, uint8_t class, =
uint8_t cmd,
> > > > +                                const void *data, size_t data_size=
,
> > > > +                                virtio_net_ctrl_ack **in_cursor)
> > > >  {
> > > >      const struct virtio_net_ctrl_hdr ctrl =3D {
> > > >          .class =3D class,
> > > >          .cmd =3D cmd,
> > > >      };
> > > >
> > > > -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(=
ctrl));
> > > > +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> > > > +                          (*out_cursor - s->cvq_cmd_out_buffer));
> > > > +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(=
ctrl) -
> > > > +                       (*out_cursor - s->cvq_cmd_out_buffer));
> > > >
> > > > -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> > > > -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> > > > +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> > > > +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
> > > >
> > > > -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_=
size,
> > > > -                                  sizeof(virtio_net_ctrl_ack));
> > > > +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) + da=
ta_size,
> > > > +                                  in_cursor, sizeof(virtio_net_ctr=
l_ack));
> > > >  }
> > > >
> > > > -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIO=
Net *n)
> > > > +/**
> > > > + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> > > > + *
> > > > + * Return the number of elements added to SVQ if success.
> > > > + */
> > > > +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIO=
Net *n,
> > > > +                            void **out_cursor, virtio_net_ctrl_ack=
 **in_cursor)
> > > >  {
> > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > >      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > > -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_=
NET_CTRL_MAC,
> > > > -                                                  VIRTIO_NET_CTRL_=
MAC_ADDR_SET,
> > > > -                                                  n->mac, sizeof(n=
->mac));
> > > > -        if (unlikely(dev_written < 0)) {
> > > > -            return dev_written;
> > > > -        }
> > > > -
> > > > -        return *s->status !=3D VIRTIO_NET_OK;
> > > > +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_C=
TRL_MAC,
> > > > +                                       VIRTIO_NET_CTRL_MAC_ADDR_SE=
T,
> > > > +                                       n->mac, sizeof(n->mac), in_=
cursor);
> > > >      }
> > > >
> > > >      return 0;
> > > >  }
> > > >
> > > > -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > > > -                                  const VirtIONet *n)
> > > > +/**
> > > > + * vhost_vdpa_net_load_mac() restores the NIC mq state through SVQ=
.
> > > > + *
> > > > + * Return the number of elements added to SVQ if success.
> > > > + */
> > > > +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const VirtION=
et *n,
> > > > +                            void **out_cursor, virtio_net_ctrl_ack=
 **in_cursor)
> > > >  {
> > > >      struct virtio_net_ctrl_mq mq;
> > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > > -    ssize_t dev_written;
> > > >
> > > >      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > >          return 0;
> > > >      }
> > > >
> > > >      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> > > > -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
> > > > -                                          VIRTIO_NET_CTRL_MQ_VQ_PA=
IRS_SET, &mq,
> > > > -                                          sizeof(mq));
> > > > -    if (unlikely(dev_written < 0)) {
> > > > -        return dev_written;
> > > > -    }
> > > > -
> > > > -    return *s->status !=3D VIRTIO_NET_OK;
> > > > +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_CTRL_=
MQ,
> > > > +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET=
,
> > > > +                                   &mq, sizeof(mq), in_cursor);
> > > >  }
> > > >
> > > >  static int vhost_vdpa_net_load(NetClientState *nc)
> > > >  {
> > > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > > +    VhostShadowVirtqueue *svq;
> > > > +    void *out_cursor;
> > > > +    virtio_net_ctrl_ack *in_cursor;
> > > >      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > > >      const VirtIONet *n;
> > > > -    int r;
> > > > +    ssize_t cmds_in_flight =3D 0, dev_written, r;
> > > >
> > > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
> > > >
> > > > @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientState=
 *nc)
> > > >      }
> > > >
> > > >      n =3D VIRTIO_NET(v->dev->vdev);
> > > > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > > > +    out_cursor =3D s->cvq_cmd_out_buffer;
> > > > +    in_cursor =3D s->status;
> > > > +
> > > > +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
> > > >      if (unlikely(r < 0))
> > > >          return r;
> > > >      }
> > > > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > > > -    if (unlikely(r)) {
> > > > +    cmds_in_flight +=3D r;
> > > > +
> > > > +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
> > > > +    if (unlikely(r < 0)) {
> > > >          return r;
> > > >      }
> > > > +    cmds_in_flight +=3D r;
> > > > +
> > > > +    /* Poll for all used buffer from device */
> > > > +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> > > > +    while (cmds_in_flight > 0) {
> > > > +        /*
> > > > +         * We can poll here since we've had BQL from the time we s=
ent the
> > > > +         * descriptor. Also, we need to take the answer before SVQ=
 pulls
> > > > +         * by itself, when BQL is released
> > > > +         */
> > > > +        dev_written =3D vhost_svq_poll(svq);
> > >
> > > I'd tweak vhost_svq_poll to accept cmds_in_flight.
>
> That sounds great!
> I will refactor the code here and send the v2 patch after
> your patch.
>
> Thanks!
>
> > >
> > > Thanks
> > >
> > > > +
> > > > +        if (unlikely(!dev_written)) {
> > > > +            /*
> > > > +             * vhost_svq_poll() return 0 when something wrong, suc=
h as
> > > > +             * QEMU waits for too long time or no available used b=
uffer
> > > > +             * from device, and there is no need to continue polli=
ng
> > > > +             * in this case.
> > > > +             */
> > > > +            return -EINVAL;
> > > > +        }
> > > > +
> > > > +        --cmds_in_flight;
> > > > +    }
> > > > +
> > > > +    /* Check the buffers written by device */
> > > > +    for (virtio_net_ctrl_ack *status =3D s->status; status < in_cu=
rsor;
> > > > +         ++status) {
> > > > +        if (*status !=3D VIRTIO_NET_OK) {
> > > > +            return -EINVAL;
> > > > +        }
> > > > +    }
> > > >
> > > >      return 0;
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> > >
> >
>


