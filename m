Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4897A707A19
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:13:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWsb-0001Yl-AI; Thu, 18 May 2023 02:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWsR-0001Vq-0L
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1pzWsO-0005Fq-3E
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684390353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8WQ5D6tlkw/i10hSKAEDsE2DnGWLBHuhOg/EaMROE0=;
 b=JOth93Io/AeXVfCxWiQbdhIpv5NPw+tyNB3rXLjcsE74v/tt8tft5pNk525kxHEJVnU5Rs
 I7yuzRNGNNuUyapRB9bzHiAO4bW2qxPzDATAbVnNTewzD260/VDTW7iCYkENtJdRbI7Qx9
 BX+UvqOEVicq4Upjoyv4rV/kS1QqIPw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-RxStykkpOYCeLewSw7s6FQ-1; Thu, 18 May 2023 02:12:32 -0400
X-MC-Unique: RxStykkpOYCeLewSw7s6FQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f26157450aso1170107e87.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684390350; x=1686982350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8WQ5D6tlkw/i10hSKAEDsE2DnGWLBHuhOg/EaMROE0=;
 b=ayrmsLO8MSAUosT1qBTESM0f25EKmKeNBRgcXqjIf9Pdusg4tEz1B3pCi5EE8yd5YH
 UvIj0HrRJcXrNFk5rdsqyTj3BayhOsDI4XQkWBhU23AQ1vVPjMaU85nHUQTLgghV81io
 kDFc9q6S7MkGkd2Nz8KYptUMPEIO2M4S7/REuYqnXyn43MB0NdgchwPuEFNMYAktVsMG
 +z3kiiWCRSnsIUd0++zOl82FhivR3N9MZpgxHCXxjJI6L6Efn4QHvRGf7S9A6lo3TIgB
 oKuYwah+QmVtcWasND0+SPm34ZGsExmvwTLwfJfj73nN4sxRryThhrp6BMH2T7Jpqgof
 Ujxg==
X-Gm-Message-State: AC+VfDxY4qSXfl1O0i2xRV2TLZWYAiEMKnZeRMs/ZVwaCjjEGA3oP3Qq
 quMb2WoR7E671VM515UFm3SQzZ+t27Oe2nrRuE+6VGY+9r86FklAdVv9WzRtOB5wKRhHvw1w0Oy
 ccrlWQKZaKom4pnJRYHkhAY8pe6JHZJ4=
X-Received: by 2002:a19:5205:0:b0:4f2:74d3:8996 with SMTP id
 m5-20020a195205000000b004f274d38996mr904399lfb.8.1684390350623; 
 Wed, 17 May 2023 23:12:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rxu42S1AAEpvlrWfAx/A0TzkSoHkMtD5We/sVEfkWgQPptaaPF1w4zU0ocOPlhQRW8AyWxzDrp3+D6WFXmlw=
X-Received: by 2002:a19:5205:0:b0:4f2:74d3:8996 with SMTP id
 m5-20020a195205000000b004f274d38996mr904391lfb.8.1684390350248; Wed, 17 May
 2023 23:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <7d800315d04359d0bb91f61ec348eda1bdb972be.1683371965.git.yin31149@gmail.com>
 <CACGkMEuj=HY0YWHoXcw+qBLm4ctfTgj3P5cfWbueVFrOP1B2uQ@mail.gmail.com>
 <CAJaqyWc2hHKb_F11ZCF0ewCk8bc7g5O-U08OxMHLWDx1erg8Sg@mail.gmail.com>
 <CAKrof1MCLXB4CG9umV4oTo_Wfkaw4ADXxyD925ej9NM0ccgjzg@mail.gmail.com>
 <CACGkMEuKYnu0st4UttOhGb56Y5tvi3pnFPRM_RgSTj_rQicZqg@mail.gmail.com>
 <CAJaqyWde_GrJHp9zbY4vfDdkMeUpemE24J=zvSqdZ1ji2CXhxQ@mail.gmail.com>
In-Reply-To: <CAJaqyWde_GrJHp9zbY4vfDdkMeUpemE24J=zvSqdZ1ji2CXhxQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:12:18 +0800
Message-ID: <CACGkMEtWpDvv-_Y6CcQo3xOQun+xYYqCv10sfh0obd-FMaX7XQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: send CVQ state load commands in parallel
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Hawkins Jiawei <yin31149@gmail.com>, 18801353760@163.com,
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

On Thu, May 18, 2023 at 2:00=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, May 18, 2023 at 7:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, May 17, 2023 at 11:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail=
.com> wrote:
> > >
> > > Sorry for forgetting cc when replying to the email.
> > >
> > > On Wed, 17 May 2023 at 16:22, Eugenio Perez Martin <eperezma@redhat.c=
om> wrote:
> > > >
> > > > On Wed, May 17, 2023 at 7:22=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@=
gmail.com> wrote:
> > > > > >
> > > > > > This patch introduces the vhost_vdpa_net_cvq_add() and
> > > > > > refactors the vhost_vdpa_net_load*(), so that QEMU can
> > > > > > send CVQ state load commands in parallel.
> > > > > >
> > > > > > To be more specific, this patch introduces vhost_vdpa_net_cvq_a=
dd()
> > > > > > to add SVQ control commands to SVQ and kick the device,
> > > > > > but does not poll the device used buffers. QEMU will not
> > > > > > poll and check the device used buffers in vhost_vdpa_net_load()
> > > > > > until all CVQ state load commands have been sent to the device.
> > > > > >
> > > > > > What's more, in order to avoid buffer overwriting caused by
> > > > > > using `svq->cvq_cmd_out_buffer` and `svq->status` as the
> > > > > > buffer for all CVQ state load commands when sending
> > > > > > CVQ state load commands in parallel, this patch introduces
> > > > > > `out_cursor` and `in_cursor` in vhost_vdpa_net_load(),
> > > > > > pointing to the available buffer for in descriptor and
> > > > > > out descriptor, so that different CVQ state load commands can
> > > > > > use their unique buffer.
> > > > > >
> > > > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
> > > > > > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > > > > > ---
> > > > > >  net/vhost-vdpa.c | 152 +++++++++++++++++++++++++++++++++++++--=
--------
> > > > > >  1 file changed, 120 insertions(+), 32 deletions(-)
> > > > > >
> > > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > > index 10804c7200..14e31ca5c5 100644
> > > > > > --- a/net/vhost-vdpa.c
> > > > > > +++ b/net/vhost-vdpa.c
> > > > > > @@ -590,6 +590,44 @@ static void vhost_vdpa_net_cvq_stop(NetCli=
entState *nc)
> > > > > >      vhost_vdpa_net_client_stop(nc);
> > > > > >  }
> > > > > >
> > > > > > +/**
> > > > > > + * vhost_vdpa_net_cvq_add() adds SVQ control commands to SVQ,
> > > > > > + * kicks the device but does not poll the device used buffers.
> > > > > > + *
> > > > > > + * Return the number of elements added to SVQ if success.
> > > > > > + */
> > > > > > +static int vhost_vdpa_net_cvq_add(VhostVDPAState *s,
> > > > > > +                                void **out_cursor, size_t out_=
len,
> > > > >
> > > > > Can we track things like cursors in e.g VhostVDPAState ?
> > > > >
> > > >
> > > > Cursors will only be used at device startup. After that, cursors ar=
e
> > > > always the full buffer. Do we want to "pollute" VhostVDPAState with
> > > > things that will not be used after the startup?
> >
> > So it's the cursor of the cvq_cmd_out_buffer, it would be more elegant
> > to keep it with where the cvq_cmd_out_buffer is placed. It can avoid
> > passing cursors in several levels.
> >
>
> That's right, there is no reason to update at vhost_vdpa_net_cvq_add.
> It can be done at the caller.
>
> > Or it would be even better to have some buffer allocation helpers to
> > alloc and free in and out buffers.
> >
>
> I think that's overkill, as the buffers are always the in and out CVQ
> buffers. They are allocated at qemu initialization, and mapped /
> unmapped at device start / stop for now.

It's not a must, we can do it if it has more users for sure.

>
> To manage them dynamically would need code to map them at any time etc.

Thanks

>
> Thanks!
>
> > Thanks
> >
> > > >
> > > > Maybe we can create a struct for them and then pass just this struc=
t?
> > >
> > > Yes, Currently, the new version of vhost_vdpa_net_cvq_add() is only
> > > called in vhost_vdpa_net_load() at startup, so these cursors will not=
 be
> > > used after startup.
> > >
> > > If needed, we can create a `VhostVDPACursor` as suggested by Eugenio.
> > >
> > > >
> > > > Thanks!
> > > >
> > > > > > +                                virtio_net_ctrl_ack **in_curso=
r, size_t in_len)
> > > > > > +{
> > > > > > +    /* Buffers for the device */
> > > > > > +    const struct iovec out =3D {
> > > > > > +        .iov_base =3D *out_cursor,
> > > > > > +        .iov_len =3D out_len,
> > > > > > +    };
> > > > > > +    const struct iovec in =3D {
> > > > > > +        .iov_base =3D *in_cursor,
> > > > > > +        .iov_len =3D sizeof(virtio_net_ctrl_ack),
> > > > > > +    };
> > > > > > +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_v=
dpa.shadow_vqs, 0);
> > > > > > +    int r;
> > > > > > +
> > > > > > +    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
> > > > > > +    if (unlikely(r !=3D 0)) {
> > > > > > +        if (unlikely(r =3D=3D -ENOSPC)) {
> > > > > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on de=
vice queue\n",
> > > > > > +                          __func__);
> > > > > > +        }
> > > > > > +        return r;
> > > > > > +    }
> > > > > > +
> > > > > > +    /* Update the cursor */
> > > > > > +    *out_cursor +=3D out_len;
> > > > > > +    *in_cursor +=3D 1;
> > > > > > +
> > > > > > +    return 1;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands=
 to SVQ,
> > > > > >   * kicks the device and polls the device used buffers.
> > > > > > @@ -628,69 +666,82 @@ static ssize_t vhost_vdpa_net_cvq_add_and=
_wait(VhostVDPAState *s,
> > > > > >      return vhost_svq_poll(svq);
> > > > > >  }
> > > > > >
> > > > > > -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint=
8_t class,
> > > > > > -                                       uint8_t cmd, const void=
 *data,
> > > > > > -                                       size_t data_size)
> > > > > > +
> > > > > > +/**
> > > > > > + * vhost_vdpa_net_load_cmd() restores the NIC state through SV=
Q.
> > > > > > + *
> > > > > > + * Return the number of elements added to SVQ if success.
> > > > > > + */
> > > > > > +static int vhost_vdpa_net_load_cmd(VhostVDPAState *s,
> > > > > > +                                void **out_cursor, uint8_t cla=
ss, uint8_t cmd,
> > > > > > +                                const void *data, size_t data_=
size,
> > > > > > +                                virtio_net_ctrl_ack **in_curso=
r)
> > > > > >  {
> > > > > >      const struct virtio_net_ctrl_hdr ctrl =3D {
> > > > > >          .class =3D class,
> > > > > >          .cmd =3D cmd,
> > > > > >      };
> > > > > >
> > > > > > -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - siz=
eof(ctrl));
> > > > > > +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
> > > > > > +                          (*out_cursor - s->cvq_cmd_out_buffer=
));
> > > > > > +    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - siz=
eof(ctrl) -
> > > > > > +                       (*out_cursor - s->cvq_cmd_out_buffer));
> > > > > >
> > > > > > -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> > > > > > -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_si=
ze);
> > > > > > +    memcpy(*out_cursor, &ctrl, sizeof(ctrl));
> > > > > > +    memcpy(*out_cursor + sizeof(ctrl), data, data_size);
> > > > > >
> > > > > > -    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + d=
ata_size,
> > > > > > -                                  sizeof(virtio_net_ctrl_ack))=
;
> > > > > > +    return vhost_vdpa_net_cvq_add(s, out_cursor, sizeof(ctrl) =
+ data_size,
> > > > > > +                                  in_cursor, sizeof(virtio_net=
_ctrl_ack));
> > > > > >  }
> > > > > >
> > > > > > -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const Vi=
rtIONet *n)
> > > > > > +/**
> > > > > > + * vhost_vdpa_net_load_mac() restores the NIC mac through SVQ.
> > > > > > + *
> > > > > > + * Return the number of elements added to SVQ if success.
> > > > > > + */
> > > > > > +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const Vi=
rtIONet *n,
> > > > > > +                            void **out_cursor, virtio_net_ctrl=
_ack **in_cursor)
> > > > > >  {
> > > > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > > > >      if (features & BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> > > > > > -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIR=
TIO_NET_CTRL_MAC,
> > > > > > -                                                  VIRTIO_NET_C=
TRL_MAC_ADDR_SET,
> > > > > > -                                                  n->mac, size=
of(n->mac));
> > > > > > -        if (unlikely(dev_written < 0)) {
> > > > > > -            return dev_written;
> > > > > > -        }
> > > > > > -
> > > > > > -        return *s->status !=3D VIRTIO_NET_OK;
> > > > > > +        return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_N=
ET_CTRL_MAC,
> > > > > > +                                       VIRTIO_NET_CTRL_MAC_ADD=
R_SET,
> > > > > > +                                       n->mac, sizeof(n->mac),=
 in_cursor);
> > > > > >      }
> > > > > >
> > > > > >      return 0;
> > > > > >  }
> > > > > >
> > > > > > -static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
> > > > > > -                                  const VirtIONet *n)
> > > > > > +/**
> > > > > > + * vhost_vdpa_net_load_mac() restores the NIC mq state through=
 SVQ.
> > > > > > + *
> > > > > > + * Return the number of elements added to SVQ if success.
> > > > > > + */
> > > > > > +static int vhost_vdpa_net_load_mq(VhostVDPAState *s, const Vir=
tIONet *n,
> > > > > > +                            void **out_cursor, virtio_net_ctrl=
_ack **in_cursor)
> > > > > >  {
> > > > > >      struct virtio_net_ctrl_mq mq;
> > > > > >      uint64_t features =3D n->parent_obj.guest_features;
> > > > > > -    ssize_t dev_written;
> > > > > >
> > > > > >      if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > > > >          return 0;
> > > > > >      }
> > > > > >
> > > > > >      mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
> > > > > > -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL=
_MQ,
> > > > > > -                                          VIRTIO_NET_CTRL_MQ_V=
Q_PAIRS_SET, &mq,
> > > > > > -                                          sizeof(mq));
> > > > > > -    if (unlikely(dev_written < 0)) {
> > > > > > -        return dev_written;
> > > > > > -    }
> > > > > > -
> > > > > > -    return *s->status !=3D VIRTIO_NET_OK;
> > > > > > +    return vhost_vdpa_net_load_cmd(s, out_cursor, VIRTIO_NET_C=
TRL_MQ,
> > > > > > +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS=
_SET,
> > > > > > +                                   &mq, sizeof(mq), in_cursor)=
;
> > > > > >  }
> > > > > >
> > > > > >  static int vhost_vdpa_net_load(NetClientState *nc)
> > > > > >  {
> > > > > >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > > > > > +    VhostShadowVirtqueue *svq;
> > > > > > +    void *out_cursor;
> > > > > > +    virtio_net_ctrl_ack *in_cursor;
> > > > > >      struct vhost_vdpa *v =3D &s->vhost_vdpa;
> > > > > >      const VirtIONet *n;
> > > > > > -    int r;
> > > > > > +    ssize_t cmds_in_flight =3D 0, dev_written, r;
> > > > > >
> > > > > >      assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA)=
;
> > > > > >
> > > > > > @@ -699,14 +750,51 @@ static int vhost_vdpa_net_load(NetClientS=
tate *nc)
> > > > > >      }
> > > > > >
> > > > > >      n =3D VIRTIO_NET(v->dev->vdev);
> > > > > > -    r =3D vhost_vdpa_net_load_mac(s, n);
> > > > > > +    out_cursor =3D s->cvq_cmd_out_buffer;
> > > > > > +    in_cursor =3D s->status;
> > > > > > +
> > > > > > +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_curso=
r);
> > > > > >      if (unlikely(r < 0))
> > > > > >          return r;
> > > > > >      }
> > > > > > -    r =3D vhost_vdpa_net_load_mq(s, n);
> > > > > > -    if (unlikely(r)) {
> > > > > > +    cmds_in_flight +=3D r;
> > > > > > +
> > > > > > +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor=
);
> > > > > > +    if (unlikely(r < 0)) {
> > > > > >          return r;
> > > > > >      }
> > > > > > +    cmds_in_flight +=3D r;
> > > > > > +
> > > > > > +    /* Poll for all used buffer from device */
> > > > > > +    svq =3D g_ptr_array_index(s->vhost_vdpa.shadow_vqs, 0);
> > > > > > +    while (cmds_in_flight > 0) {
> > > > > > +        /*
> > > > > > +         * We can poll here since we've had BQL from the time =
we sent the
> > > > > > +         * descriptor. Also, we need to take the answer before=
 SVQ pulls
> > > > > > +         * by itself, when BQL is released
> > > > > > +         */
> > > > > > +        dev_written =3D vhost_svq_poll(svq);
> > > > >
> > > > > I'd tweak vhost_svq_poll to accept cmds_in_flight.
> > >
> > > That sounds great!
> > > I will refactor the code here and send the v2 patch after
> > > your patch.
> > >
> > > Thanks!
> > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > > +
> > > > > > +        if (unlikely(!dev_written)) {
> > > > > > +            /*
> > > > > > +             * vhost_svq_poll() return 0 when something wrong,=
 such as
> > > > > > +             * QEMU waits for too long time or no available us=
ed buffer
> > > > > > +             * from device, and there is no need to continue p=
olling
> > > > > > +             * in this case.
> > > > > > +             */
> > > > > > +            return -EINVAL;
> > > > > > +        }
> > > > > > +
> > > > > > +        --cmds_in_flight;
> > > > > > +    }
> > > > > > +
> > > > > > +    /* Check the buffers written by device */
> > > > > > +    for (virtio_net_ctrl_ack *status =3D s->status; status < i=
n_cursor;
> > > > > > +         ++status) {
> > > > > > +        if (*status !=3D VIRTIO_NET_OK) {
> > > > > > +            return -EINVAL;
> > > > > > +        }
> > > > > > +    }
> > > > > >
> > > > > >      return 0;
> > > > > >  }
> > > > > > --
> > > > > > 2.25.1
> > > > > >
> > > > >
> > > >
> > >
> >
>


