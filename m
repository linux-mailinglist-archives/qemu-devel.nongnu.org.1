Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F092277F8D1
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdwO-0006QX-TX; Thu, 17 Aug 2023 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWdwM-0006Q7-4z
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWdwJ-0005sL-JR
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692282330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9DpWLuwY9e869nqC9iL3xcM5Xiwkx7NSCFQVCxfICE=;
 b=LEny5mvJHhdAN0FqHlf5OxtQAscD2GGSwONp332iJvwTxqkEIf+6AxTfqif8ls1d7NhwUp
 PW6TfEvJ43Fn66bBU+w4VjQRO0Y2zw+ECWWDFTsKWVOS4CDhULIIGjeaqURYcDo/dGxw/W
 WIdosJw20O1wIeHX/03qMBMX72mC/uM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-2LqENCGKP6WMYr4UdMJVvg-1; Thu, 17 Aug 2023 10:25:28 -0400
X-MC-Unique: 2LqENCGKP6WMYr4UdMJVvg-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-d66d85403f5so7571861276.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282327; x=1692887127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9DpWLuwY9e869nqC9iL3xcM5Xiwkx7NSCFQVCxfICE=;
 b=BGYoESMkbKB6XAjphGScPNDSK3B9z6gdVZko84pecvRsb9cfbBVTHH7hWQqKcL8oID
 uf3esdZ8zyNRhsRyjAYUJ0a5MKOqFDvz6ZjxSa12f6lVw/6gyv7kh6Urjh374g5sFKeu
 XUQt1HUwAa0xsCjqDBPl6/uVkLyX+EZKxLj2mWnHPK26Fnb2ZjFglgQSfpuY1ASmBxZo
 1/vj3uUQuPJPBteaoTWh6p7rxcn5AsXRkTHcYbQ39mckpMM0OBmSlY9MmrgeyCxplkGK
 eFZVfYIzYqAnagn7PONAKuEDcKsfefj8PBV7vva2jOhVEWIK0ub/+cg8NW//5j0bM6Tg
 oWLw==
X-Gm-Message-State: AOJu0Yx/nnVGFPyxmYwG8xVQWDevavi/hmieOraaamZO86+DhE8ZbdH4
 CLiLgaF+4mC9/7gr72iTBXAEDS922FI4bTim+Sx0e+CwK6ne1zRm+t3eXh8smTWlBHpBenSbkxc
 OA1JkyRHbVY3Cead0prx3CX3yWN2GZTc=
X-Received: by 2002:a25:844a:0:b0:d15:454e:8ecd with SMTP id
 r10-20020a25844a000000b00d15454e8ecdmr6160142ybm.13.1692282327633; 
 Thu, 17 Aug 2023 07:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8jsf54yXo6JS5wpqyMWrDDmZFZT3aIXCf8JcFhzF5b5C1Unm2Ub5n9xPNQezjgumARIyy+48initPhwOV1UQ=
X-Received: by 2002:a25:844a:0:b0:d15:454e:8ecd with SMTP id
 r10-20020a25844a000000b00d15454e8ecdmr6160125ybm.13.1692282327316; Thu, 17
 Aug 2023 07:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
 <CAJaqyWeWuXn5=OvW99cgnniaZyW=wSp2EutxzROE5Xnp=xvjQw@mail.gmail.com>
 <CAKrof1NJx-KAKs60-r06tL0KRL7UxiK7A3WhphGrwE-okk0gew@mail.gmail.com>
In-Reply-To: <CAKrof1NJx-KAKs60-r06tL0KRL7UxiK7A3WhphGrwE-okk0gew@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 16:24:51 +0200
Message-ID: <CAJaqyWfXzKcZSpFbsf0pCZjnWkiuXX+qSQcjmoWKyLJkNY+O0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] vdpa: Restore MAC address filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 17, 2023 at 2:47=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> On 2023/8/17 18:18, Eugenio Perez Martin wrote:
> > On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
> >>
> >> This patch refactors vhost_vdpa_net_load_mac() to
> >> restore the MAC address filtering state at device's startup.
> >>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >> v3:
> >>    - return early if mismatch the condition suggested by Eugenio
> >>
> >> v2: https://lore.kernel.org/all/2f2560f749186c0eb1055f9926f464587e419e=
eb.1688051252.git.yin31149@gmail.com/
> >>    - use iovec suggested by Eugenio
> >>    - avoid sending CVQ command in default state
> >>
> >> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dad=
ce.1687402580.git.yin31149@gmail.com/
> >>
> >>   net/vhost-vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 52 insertions(+)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 31ef6ad6ec..7189ccafaf 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -660,6 +660,58 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState=
 *s, const VirtIONet *n)
> >>           }
> >>       }
> >>
> >> +    /*
> >> +     * According to VirtIO standard, "The device MUST have an
> >> +     * empty MAC filtering table on reset.".
> >> +     *
> >> +     * Therefore, there is no need to send this CVQ command if the
> >> +     * driver also sets an empty MAC filter table, which aligns with
> >> +     * the device's defaults.
> >> +     *
> >> +     * Note that the device's defaults can mismatch the driver's
> >> +     * configuration only at live migration.
> >> +     */
> >> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX=
) ||
> >> +        n->mac_table.in_use =3D=3D 0) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    uint32_t uni_entries =3D n->mac_table.first_multi,
> >
> > QEMU coding style prefers declarations at the beginning of the code
> > block. Previous uses of these variable names would need to be
> > refactored to met this rule.
>
> Hi Eugenio,
>
> Thanks for the detailed explanation.
>
> Since this patch series has already been merged into master, I will
> submit a separate patch to correct this problem.
>
> I will take care of this problem in the future.
>

If the maintainer is ok with this, I'm totally ok with leaving the
code as it is right now.

Thanks!

> Thanks!
>
>
> >
> > Apart from that,
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> >> +             uni_macs_size =3D uni_entries * ETH_ALEN,
> >> +             mul_entries =3D n->mac_table.in_use - uni_entries,
> >> +             mul_macs_size =3D mul_entries * ETH_ALEN;
> >> +    struct virtio_net_ctrl_mac uni =3D {
> >> +        .entries =3D cpu_to_le32(uni_entries),
> >> +    };
> >> +    struct virtio_net_ctrl_mac mul =3D {
> >> +        .entries =3D cpu_to_le32(mul_entries),
> >> +    };
> >> +    const struct iovec data[] =3D {
> >> +        {
> >> +            .iov_base =3D &uni,
> >> +            .iov_len =3D sizeof(uni),
> >> +        }, {
> >> +            .iov_base =3D n->mac_table.macs,
> >> +            .iov_len =3D uni_macs_size,
> >> +        }, {
> >> +            .iov_base =3D &mul,
> >> +            .iov_len =3D sizeof(mul),
> >> +        }, {
> >> +            .iov_base =3D &n->mac_table.macs[uni_macs_size],
> >> +            .iov_len =3D mul_macs_size,
> >> +        },
> >> +    };
> >> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> >> +                                VIRTIO_NET_CTRL_MAC,
> >> +                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
> >> +                                data, ARRAY_SIZE(data));
> >> +    if (unlikely(dev_written < 0)) {
> >> +        return dev_written;
> >> +    }
> >> +    if (*s->status !=3D VIRTIO_NET_OK) {
> >> +        return -EIO;
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


