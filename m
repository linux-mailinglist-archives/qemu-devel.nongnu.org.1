Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A27176FA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4FTO-0008Kr-LV; Wed, 31 May 2023 02:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4FTL-0008Hb-1q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4FTJ-0003gz-DJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685515091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMoM3odhQ/OWVUI7PLYpKZMrIOS3ZoddrChJVCHjGN4=;
 b=BbTFvl9IfJ7YnbkTwo2sOO9k+OP5l0bpjPhozUaitn7U1QBLN4OmIakyW4fin2XV//0MKR
 ChwNjk5x7GGyESOCkNncDChAbKDNslr+ko6luMTN83KOx7XU4/QYxBiqx2+LYlCv6f6fmD
 aX9/0ABEnFaM8B6pqTnD6yhllR/2uDI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-wVXD4AWqMbSFNj-IBKSNfQ-1; Wed, 31 May 2023 02:38:10 -0400
X-MC-Unique: wVXD4AWqMbSFNj-IBKSNfQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5689bcc5f56so41837867b3.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 23:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685515089; x=1688107089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMoM3odhQ/OWVUI7PLYpKZMrIOS3ZoddrChJVCHjGN4=;
 b=PmOb9Y+HSKmLiQgl10GDtkDHaEC5zwYs/MXfe0wBfxyOVc8mOfWx4J/Q0dDRl+j4Zx
 ZOLLO1ZnkO4eqYCChjtLaFfe3luo8Zs/zzfWYmWV1wv7CpLKodYlUpCG0SYyMIg/IeY3
 KHwc6zNkatwlB6DiomodKoNjg4qqjfResYM2tPb0GS02O8eK6vL9usTZ0e/UyyeXBTNQ
 XF78utGt0Dzr8erL6JBr1rmk5Pdzkf8232OCnXwFMZjiGEtGTf/n6NsnjFNZRonjDIj4
 39vSpw0dPTeAfqOiq0Z4JwEapC8If/qBiZE1jyQW7EOTUpkqtyTMzZvp9ZEn0wOJHc0r
 4dGQ==
X-Gm-Message-State: AC+VfDzE+OI9mrTf0RV/OcYWz8Edz7xbQxbzCDmxW1rqjl7ZD82EwOoa
 1wUDIh24Dh12sUCCH/la4K5c1iMno4QlB9m9R5e4H61JLIjf+wKmPwW8VtqtPjvke/jgdhM3w9C
 DycFl9uyIYdPuVu5VX/pVrHUweoJveYU=
X-Received: by 2002:a81:8645:0:b0:565:f14b:6cdb with SMTP id
 w66-20020a818645000000b00565f14b6cdbmr5751980ywf.21.1685515089683; 
 Tue, 30 May 2023 23:38:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RJU5xsf78TzwwxiJwB3X8cqMnoOGok0+qvDmgN7qD3I4qdLhg5hL3FELza5OPA+203aBnSeUm4rthM7mMTxM=
X-Received: by 2002:a81:8645:0:b0:565:f14b:6cdb with SMTP id
 w66-20020a818645000000b00565f14b6cdbmr5751970ywf.21.1685515089463; Tue, 30
 May 2023 23:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
 <CACGkMEvza0nAWqbQ1-KiLGRRxSxYvJoTrtTgUPV-KQpSuJFB6g@mail.gmail.com>
In-Reply-To: <CACGkMEvza0nAWqbQ1-KiLGRRxSxYvJoTrtTgUPV-KQpSuJFB6g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 31 May 2023 08:37:33 +0200
Message-ID: <CAJaqyWe7e4OAZU+-i73OQ76QtM3Kv0V0LrfCMEjgnNmMH=TGZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
To: Jason Wang <jasowang@redhat.com>
Cc: Hawkins Jiawei <yin31149@gmail.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Wed, May 31, 2023 at 3:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, May 29, 2023 at 9:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
> >
> > This patch introduces vhost_vdpa_net_load_offloads() to
> > restore offloads state at device's startup.
> >
> > Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> > ---
> >  net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index 37cdc84562..682c749b19 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *=
s,
> >      return *s->status !=3D VIRTIO_NET_OK;
> >  }
> >
> > +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> > +                                        const VirtIONet *n)
> > +{
> > +    uint64_t features, offloads;
> > +    ssize_t dev_written;
> > +
> > +    features =3D n->parent_obj.guest_features;
>
> Any reason you need to do tricks like this instead of using
> virtio_xxx_has_features()?
>

It can be replaced by virtio_vdev_has_feature, yes.

Current code of vhost_vdpa_net_load_mac and vhost_vdpa_net_load_mq
access to guest_features directly too, so I think we should change all
of them at once.

Thanks!

> > +    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
> > +        return 0;
> > +    }
> > +
> > +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
> > +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_O=
FFLOADS,
> > +                                          VIRTIO_NET_CTRL_GUEST_OFFLOA=
DS_SET,
> > +                                          &offloads, sizeof(offloads))=
;
> > +    if (unlikely(dev_written < 0)) {
> > +        return dev_written;
> > +    }
> > +
> > +    return *s->status !=3D VIRTIO_NET_OK;
> > +}
> > +
> >  static int vhost_vdpa_net_load(NetClientState *nc)
> >  {
> >      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> > @@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
> >      if (unlikely(r)) {
> >          return r;
> >      }
> > +    r =3D vhost_vdpa_net_load_offloads(s, n);
> > +    if (unlikely(r)) {
> > +        return r;
> > +    }
> >
> >      return 0;
> >  }
> > --
> > 2.25.1
> >
>


