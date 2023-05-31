Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24561717A38
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HJA-0006B5-Pr; Wed, 31 May 2023 04:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4HJ3-0006AP-OL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4HJ1-0003pw-Of
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685522142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LI7bR7ZLvORYNmLvS/izqM2QTDrpbzXLsm0uKqwgOPI=;
 b=DLzhCOrxWfe2Rxm4tDS0laeYKVYEJdAn0GsyyrCHrqYxq2Bg0lxTktvrt8TOPeTW5cHSc/
 3FA3qY0vIZZN+b6I0VVhMLQCSUNh+LZ1yRmPl8RN39dfqpDmudNeV3BaKhsgGoqzL6vrb/
 Qw9YoYAPawmX3HfM0lT7tJIn+vD+EEo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ltuuhd9wMr-l_y2cbtQ6gg-1; Wed, 31 May 2023 04:35:41 -0400
X-MC-Unique: ltuuhd9wMr-l_y2cbtQ6gg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-568a85f180dso41658817b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685522141; x=1688114141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LI7bR7ZLvORYNmLvS/izqM2QTDrpbzXLsm0uKqwgOPI=;
 b=V2HbKgLkdPMPWZJ2wTU8wXgmY4bv8DRi5goMNTv0MPNxtc1qxi+ljTUI8MrqodT2lC
 dm30baaPUhC4jATZMUx4ov1DCyoS/2393HBcLOdu+1zqR2NUu5t+WhwXHhCnAjJANM4P
 7aDu1mhNdLuLceq0f4jY/sir7y3oWPspm4uhVaAueaMXljFokyFnjcCgZlm4IroXuZHl
 //yfXBHYzfC5bE10mEGbMGiYjSA1JJ+zY4jvrb5WkKyp9PL97DdxgW2X+T23xF6f3fQc
 KT30VkmzT1ZbXRY9CvyEATgbnmclsFrvftRnKRLiEL4ia5GVpklvZS2Qi0GMWhuX3Lkz
 bM2A==
X-Gm-Message-State: AC+VfDyhUljN3ruihONhjeDceabVmq5a+huDzK7o35XefOuAqeC4eI9g
 B9MUXdxAf2prA/fM8dh7ao+ThQcdjb4AL7NPx62FKVaEhph3RA5usbaOdNn/LsKCbpmucezdn98
 FPdkl7XPY1P8obWi85jghpcQgtuqR5aU=
X-Received: by 2002:a81:52cb:0:b0:565:ea7f:2c98 with SMTP id
 g194-20020a8152cb000000b00565ea7f2c98mr5327029ywb.28.1685522140810; 
 Wed, 31 May 2023 01:35:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70UFquqs+PXbDLOKKl47t1e6YAVRfKcbrs8xm4Umwh9Z6dIFnEr0bodv5J72CXRqxc6NiNEoQXl3ua4voa/sw=
X-Received: by 2002:a81:52cb:0:b0:565:ea7f:2c98 with SMTP id
 g194-20020a8152cb000000b00565ea7f2c98mr5327021ywb.28.1685522140579; Wed, 31
 May 2023 01:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
 <CAJaqyWcURXY7GxM2goKHp55pfb-pCjOSYfDwzjsXbtSP1SnSkg@mail.gmail.com>
 <CAKrof1Njyuf5aeA4bX6Z1ryzq6dVK7AFVxrHUfEBi+94ymYNHQ@mail.gmail.com>
In-Reply-To: <CAKrof1Njyuf5aeA4bX6Z1ryzq6dVK7AFVxrHUfEBi+94ymYNHQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 31 May 2023 10:35:04 +0200
Message-ID: <CAJaqyWci2EMo0aORTzYX32hEq=01pKHp83iHvxrszxomrv5Qqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Wed, May 31, 2023 at 10:23=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> On 2023/5/30 0:19, Eugenio Perez Martin wrote:
> > On Mon, May 29, 2023 at 3:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> This patch introduces vhost_vdpa_net_load_offloads() to
> >> restore offloads state at device's startup.
> >>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >>   net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 37cdc84562..682c749b19 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState =
*s,
> >>       return *s->status !=3D VIRTIO_NET_OK;
> >>   }
> >>
> >> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
> >> +                                        const VirtIONet *n)
> >> +{
> >> +    uint64_t features, offloads;
> >> +    ssize_t dev_written;
> >> +
> >> +    features =3D n->parent_obj.guest_features;
> >> +    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
> >> +        return 0;
> >> +    }
> >> +
> >
> > Maybe we can avoid sending this CVQ command if the guest already uses
> > the default values?
>
> Hi Eugenio,
>
> Thanks for the review. However, I'm curious why we don't need to send
> this CVQ command if the guest is using the default values. Is it because
> the device automatically applies these default offloads, when the
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated and QEMU doesn't
> send the CVQ command?
>

Exactly. You can check that either by the standard text or (sometimes
easier) qemu virtio or virtio-net device code.

The standard text says that:
"Upon feature negotiation corresponding offload gets enabled to
preserve backward compatibility."

And you can check in the qemu code by
hw/net/virtio-net:virtio_net_set_features(vdev, features), this chunk
of code:
n->curr_guest_offloads =3D virtio_net_guest_offloads_by_features(features);
virtio_net_apply_guest_offloads(n);

Thanks!

> Thanks!
>
>
> >
> > By default all features are enabled if I'm not wrong. I think the best
> > way is to expose virtio_net_supported_guest_offloads or
> > virtio_net_guest_offloads_by_features and then check if
> > n->curr_guest_offloads is the same.
> >
> > We should do the same with vhost_vdpa_net_load_mq, but that is out of
> > the scope of this series.
> >
> > Thanks!
> >
> >> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
> >> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_=
OFFLOADS,
> >> +                                          VIRTIO_NET_CTRL_GUEST_OFFLO=
ADS_SET,
> >> +                                          &offloads, sizeof(offloads)=
);
> >> +    if (unlikely(dev_written < 0)) {
> >> +        return dev_written;
> >> +    }
> >> +
> >> +    return *s->status !=3D VIRTIO_NET_OK;
> >> +}
> >> +
> >>   static int vhost_vdpa_net_load(NetClientState *nc)
> >>   {
> >>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >> @@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
> >>       if (unlikely(r)) {
> >>           return r;
> >>       }
> >> +    r =3D vhost_vdpa_net_load_offloads(s, n);
> >> +    if (unlikely(r)) {
> >> +        return r;
> >> +    }
> >>
> >>       return 0;
> >>   }
> >> --
> >> 2.25.1
> >>
> >
>


