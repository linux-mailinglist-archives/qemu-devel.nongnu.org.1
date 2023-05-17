Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74D706C56
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIos-0006lF-A0; Wed, 17 May 2023 11:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzIoq-0006kw-Mt
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:12:00 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1pzIop-00068I-4A
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:12:00 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2acb6571922so8632351fa.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684336317; x=1686928317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tnm9td0+sZGGKRcyiEx8KbTna9jhkCAl6HLgTWV8UKg=;
 b=eamD+lLHEMUILwxbp0G0uc6adQxDZQUvkCO9AwxYrdVjhhmgY+MT8JwdPLIDLTzd2Z
 DxIg2Vl1qmQZX2vArIflsVqXVrlZf/v1Y1wCr8BtSQHYC04tncWwBfIj4aj1IhbQEeix
 nZZBizQ9+xjGRC2BiMvfdomvFBW+uEEjbJCnSRUQ1YBWkWv/ZGrb11Bn9TujLZbb7HqM
 GsO67a1+LtrdGs4wWLurO5Wo/v58H60XA1kST5j35uzmXja3ojLbH9CM60l5RANcs9yj
 KFbhp6pZ+CL6JeAKoQRs7M9A5aMFRoti9r3h67sr/zc1Zys0x4IZzwiXTOLQXw1j+lGn
 iPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684336317; x=1686928317;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnm9td0+sZGGKRcyiEx8KbTna9jhkCAl6HLgTWV8UKg=;
 b=CjwheEXT29gRCj2lqHjNlL6pIXxXJduxdDubO0wGlLYUKOH3uObUzfTe2wXw8GCWwR
 +FPKa6S3t/6tkIHySrFTd5df2F/9pgqgk8tEijKmxCuggv6HYIJEqSVtHDflbZXmb878
 O6w49TOu8IeRAg4948OxwH0AyO2kMV8mOpkBz1Lw7x4Vbsv4KXuJwO09vnJDTR/ozI2u
 EpPxpRGTPrTWkdiarjob+QK74y1mTZyne6duYfy0+Xf+SxoRrA0SosJCztiOhZlkQxLB
 Z26d2Iw0uTBXzPXFuTrN7br+cxN39xjuZXACtekioBhd34u+2XdUBRUvohYJTvXL/DMe
 n/oQ==
X-Gm-Message-State: AC+VfDwjihsNAToV2KLIkL2wVLlDwvZHy1xf9BEmgRM28c4MzmMUBdRM
 SH7DsM6pmPoPufmd9bb3DQrbLM4a2BRbNbMDrsA=
X-Google-Smtp-Source: ACHHUZ7Ov8F/ldtK2l0riFjrg5PP25Z/UjGIC9jNRt8sJ5VHXtKK2GIV5gebwUuWd5FLrIyrUB1CKJ4bRpmNWjpMOZg=
X-Received: by 2002:a2e:9989:0:b0:2ad:ad0b:d0fb with SMTP id
 w9-20020a2e9989000000b002adad0bd0fbmr10192405lji.30.1684336316427; Wed, 17
 May 2023 08:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683371965.git.yin31149@gmail.com>
 <fbaa1630a3cf8d08c59c2e273d53f055da8292b3.1683371965.git.yin31149@gmail.com>
 <CACGkMEttwMJ6J6LegqYg-yobWbXnFvmVTCBFXKv40=AZ2Ov6fw@mail.gmail.com>
In-Reply-To: <CACGkMEttwMJ6J6LegqYg-yobWbXnFvmVTCBFXKv40=AZ2Ov6fw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 17 May 2023 23:11:42 +0800
Message-ID: <CAKrof1PjGpAEXd9L8ZAgboQProF0vFfwqB5AhQr6V3BLTUyu7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vdpa: rename vhost_vdpa_net_cvq_add()
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, 18801353760@163.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x232.google.com
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
I will resend this email with cc.

On Wed, 17 May 2023 at 12:12, Jason Wang <jasowang@redhat.com> wrote:
>
> On Sat, May 6, 2023 at 10:07=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
> >
> > We want to introduce a new version of vhost_vdpa_net_cvq_add() that
> > does not poll immediately after forwarding custom buffers
> > to the device, so that QEMU can send all the SVQ control commands
> > in parallel instead of serialized.
> >
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  net/vhost-vdpa.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 99904a0da7..10804c7200 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -590,8 +590,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState=
 *nc)
> >      vhost_vdpa_net_client_stop(nc);
> >  }
> >
> > -static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_le=
n,
> > -                                      size_t in_len)
> > +/**
> > + * vhost_vdpa_net_cvq_add_and_wait() adds SVQ control commands to SVQ,
> > + * kicks the device and polls the device used buffers.
> > + *
> > + * Return the length written by the device.
> > + */
> > +static ssize_t vhost_vdpa_net_cvq_add_and_wait(VhostVDPAState *s,
>
> Nit: is it better to use "poll" or "sync" other than wait?
>
> Other than this:
>
> Acked-by: Jason Wang <jasowang@redhat.com>

Hi Jason,

Thanks for your suggestion. I prefer 'poll', which makes it clearer
that this function will poll immediately compared to the new
version of vhost_vdpa_net_cvq_add().

I will refactor this in the v2 patch with the Acked-by tag on.

Thanks!

>
> Thanks
>
> > +                                    size_t out_len, size_t in_len)
> >  {
> >      /* Buffers for the device */
> >      const struct iovec out =3D {
> > @@ -636,7 +642,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, uint8_t class,
> >      memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> >      memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
> >
> > -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
> > +    return vhost_vdpa_net_cvq_add_and_wait(s, sizeof(ctrl) + data_size=
,
> >                                    sizeof(virtio_net_ctrl_ack));
> >  }
> >
> > @@ -753,7 +759,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostSh=
adowVirtqueue *svq,
> >          dev_written =3D sizeof(status);
> >          *s->status =3D VIRTIO_NET_OK;
> >      } else {
> > -        dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(=
status));
> > +        dev_written =3D vhost_vdpa_net_cvq_add_and_wait(s, out.iov_len=
,
> > +                                                      sizeof(status));
> >          if (unlikely(dev_written < 0)) {
> >              goto out;
> >          }
> > --
> > 2.25.1
> >
>

