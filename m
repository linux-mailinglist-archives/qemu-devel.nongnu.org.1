Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80040747D0F
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 08:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGw1N-0003PD-9a; Wed, 05 Jul 2023 02:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGw1K-0003P0-LK
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGw1I-0000LC-OO
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688538582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jA2gIaSIsFTfxiAWnahapUzEMMrpSnVmHNjhzJz9WE=;
 b=TiO2OTGsTN2aBNYHFY4VyeJYgP3SUKB9ysDPDUoEEwcBn7sUt2Pdi2hgVDiiagi5yXyZPd
 vp01bq4NwMDfFrxlQlHTsuiX/s8D0goJKVkDsv1GuMAIh15NUGRisRH7H9h0USdqq2Glq4
 jbLeDAeq78IX77WhLNSxhc/lyXOOGM4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-3U3wd3G3NySfBQJLQYb5yQ-1; Wed, 05 Jul 2023 02:29:40 -0400
X-MC-Unique: 3U3wd3G3NySfBQJLQYb5yQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-c5f4d445190so910259276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 23:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688538580; x=1691130580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jA2gIaSIsFTfxiAWnahapUzEMMrpSnVmHNjhzJz9WE=;
 b=EFd99LhLjxghP+uyL5hRIrzPBC+RTrpizTTsVstrL63Z3GT299oVDhk7Ym3vsCJ11x
 fSFh618P4tf+BBldcCkxdwGvEMMQJFyFuL/ynr6wVdt4j/vEE5RCp0aqmgXguElofIvP
 pzwBz20rQ0MEzQ7vLZQadYhZf62kiK/gVmFwSkInwqcnpZ2RmKpo4qcyRnDEJV2/mcsA
 sSbi+ZzDIBU50B6gWaqIy8SPciiY7bQfNY1zuejDuKO57B9mFP6KaQuowe/JZho0C+L8
 L7O9LNC4MYnaBkgPq1UAqeDXWJ1OaqLVnxou0JYzGfU14jYYQ3Lm7diHCSQ5bJM/WWpk
 nmOg==
X-Gm-Message-State: ABy/qLafGNg0844YRZcT0oS5qv5QKE5FYfMmEVVbcLqlm3zt4BkNNlHS
 OUgKVO+Ovx8l21OsBvP5iAo0ncrsuobTPxck9FU47u8lLYOe1ZwjDsfaoz6rDyH/ZN7q8/5H2T2
 2UcAV4vjduP7s4fNy+h0V29AofIzo7Jw=
X-Received: by 2002:a25:dcb:0:b0:c5f:c73b:15cd with SMTP id
 194-20020a250dcb000000b00c5fc73b15cdmr2234633ybn.38.1688538580373; 
 Tue, 04 Jul 2023 23:29:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWmF6RSYy/5OD6AG5+GH/v58dMsF66lD9NuR1lTwpgE1ASSJGJFZpaBql2mGwna0gNh9FPLKeYCXIojSYZxNw=
X-Received: by 2002:a25:dcb:0:b0:c5f:c73b:15cd with SMTP id
 194-20020a250dcb000000b00c5fc73b15cdmr2234624ybn.38.1688538580074; Tue, 04
 Jul 2023 23:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com>
 <CAJaqyWfq0Sec14Y9UCAtYXRCTyyUwEo0NRBu6uksgESkMVgFUQ@mail.gmail.com>
 <CAKrof1PExLDTkfu5B1Kg2s7CQAXbdhGn2s=Pt-g-nfBBRyPTiA@mail.gmail.com>
In-Reply-To: <CAKrof1PExLDTkfu5B1Kg2s7CQAXbdhGn2s=Pt-g-nfBBRyPTiA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Jul 2023 08:29:04 +0200
Message-ID: <CAJaqyWe=N6Vjq0Mdjaw8OUa-9PbVi-PLDWbZvjCL8g9Km40ZcA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] vdpa: Restore MAC address filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Wed, Jul 5, 2023 at 3:43=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> On 2023/7/4 22:53, Eugenio Perez Martin wrote:
> > On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> This patch refactors vhost_vdpa_net_load_mac() to
> >> restore the MAC address filtering state at device's startup.
> >>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >> v2:
> >>    - use iovec suggested by Eugenio
> >>    - avoid sending CVQ command in default state
> >>
> >> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dad=
ce.1687402580.git.yin31149@gmail.com/
> >>
> >>   net/vhost-vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 51 insertions(+)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 0bd1c7817c..cb45c84c88 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -665,6 +665,57 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState=
 *s, const VirtIONet *n)
> >>           }
> >>       }
> >>
> >> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)=
) {
> >> +        if (n->mac_table.in_use !=3D 0) {
> >
> > This may be just style nitpicking, but I find it more clear to return
> > early if conditions are not met and then send the CVQ command.
>
> Yes, this makes code more clear to read.
>
> But it appears that we may meet a problem if the function
> vhost_vdpa_net_load_x() sends multiple CVQ commands. It is possible that
> we might not meet the condition for one of the CVQ commands, but we
> could still meet the conditions for other CVQ commands.
>
> Therefore, in the case of vhost_vdpa_net_load_x() sending multiple CVQ
> commands, if we still hope to use this style, should we split the
> function into multiple functions, with each function responsible for
> sending only one CVQ command? Or should we jump to the next CVQ command
> instead of returning from the function if the conditions are not met?
>

In that case I'd suggest using multiples if() {}, as each ctrl command
processing code is very small.

But for VIRTIO_NET_F_CTRL_RX particular case your patch propose:
if (x) {
  if (y) {
    ...
  }
}

So in my opinion it makes sense to convert to:
if (!x || !y) {
  return;
}
...

We can always change later if needed.

Thanks!

> Thanks!
>
>
> > Something like:
> > /*
> >   * According to ...
> >   */
> > if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) ||
> > (n->mac_table.in_use =3D=3D 0)) {
> >    return 0
> > }
> >
> > uni_entries =3D n->mac_table.first_multi,
> > ...
> > ---
> >
> > Now I just realized vhost_vdpa_net_load_mac does not follow this for
> > checking VIRTIO_NET_F_CTRL_MAC_ADDR.
> >
> > I'm ok if you leave it this way though.
> >
> > Thanks!
> >
> >> +            /*
> >> +             * According to virtio_net_reset(), device uses an empty =
MAC filter
> >> +             * table as its default state.
> >> +             *
> >> +             * Therefore, there is no need to send this CVQ command i=
f the
> >> +             * driver also sets an empty MAC filter table, which alig=
ns with
> >> +             * the device's defaults.
> >> +             *
> >> +             * Note that the device's defaults can mismatch the drive=
r's
> >> +             * configuration only at live migration.
> >> +             */
> >> +            uint32_t uni_entries =3D n->mac_table.first_multi,
> >> +                     uni_macs_size =3D uni_entries * ETH_ALEN,
> >> +                     mul_entries =3D n->mac_table.in_use - uni_entrie=
s,
> >> +                     mul_macs_size =3D mul_entries * ETH_ALEN;
> >> +            struct virtio_net_ctrl_mac uni =3D {
> >> +                .entries =3D cpu_to_le32(uni_entries),
> >> +            };
> >> +            struct virtio_net_ctrl_mac mul =3D {
> >> +                .entries =3D cpu_to_le32(mul_entries),
> >> +            };
> >> +            const struct iovec data[] =3D {
> >> +                {
> >> +                    .iov_base =3D &uni,
> >> +                    .iov_len =3D sizeof(uni),
> >> +                }, {
> >> +                    .iov_base =3D n->mac_table.macs,
> >> +                    .iov_len =3D uni_macs_size,
> >> +                }, {
> >> +                    .iov_base =3D &mul,
> >> +                    .iov_len =3D sizeof(mul),
> >> +                }, {
> >> +                    .iov_base =3D &n->mac_table.macs[uni_macs_size],
> >> +                    .iov_len =3D mul_macs_size,
> >> +                },
> >> +            };
> >> +            ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> >> +                                        VIRTIO_NET_CTRL_MAC,
> >> +                                        VIRTIO_NET_CTRL_MAC_TABLE_SET=
,
> >> +                                        data, ARRAY_SIZE(data));
> >> +            if (unlikely(dev_written < 0)) {
> >> +                return dev_written;
> >> +            }
> >> +            if (*s->status !=3D VIRTIO_NET_OK) {
> >> +                return -EINVAL;
> >> +            }
> >> +        }
> >> +    }
> >> +
> >>       return 0;
> >>   }
> >>
> >> --
> >> 2.25.1
> >>
> >
>


