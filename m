Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6405747D38
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 08:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGwCa-00063P-A8; Wed, 05 Jul 2023 02:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGwCX-000639-T6
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGwCV-0003Sk-Qu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688539278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYRZMHQKpHI4eQcaA6RwDpEEr1q4+ujZ8npaik+baV4=;
 b=hpVoCKFzlP2QsyS402IsTDlx/E+haplshA8zUuYCTfxjwU5tIlF/H3YCF3Yj5EO2UGfSMi
 tHCiL3mAQsRXssBlxQ10wKpIw5a8ZAYTiUuLW2BfHmbrHv7pDWOy8DI76qwGV7QWEKupLF
 sf+r5zwDldibbQ7aqQEhfGvG4vlBqhM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-N88L7GT_N7qqOQDmD2KaHg-1; Wed, 05 Jul 2023 02:41:17 -0400
X-MC-Unique: N88L7GT_N7qqOQDmD2KaHg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-56fffdea2d0so53843557b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 23:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688539276; x=1691131276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYRZMHQKpHI4eQcaA6RwDpEEr1q4+ujZ8npaik+baV4=;
 b=P/tdUdqhc6rFiVUrgaPMfg25Dsp9VU0EpDRIdLvFiBtHGtHsFks4BnC8SaqDB1rJUi
 RgR1erE0Eg5lmJ53j3Gp/L/RV4QZcAGu+gWXkqhRrIdPNIui5VlAMtnow5rnRjv4CMg0
 H7J3pLGE5jcs1BXFWRPwTpOVN5rVJUbWh8s8GVHnPr5Pt7hbLkPE8FUDv06zCVg/zuRy
 w4GP/U59CZkulntLk6gEXOczyWRs02hvMd+8PwU6NLNLJu63ZkuyHCDUHHpfIn28Rq9v
 OZRVyuYe4kv68XKtGmIke5EoXc+kdq40ECjKBngQ3OzBkMdlFwVzuNd+3pS5WenZloek
 EnFg==
X-Gm-Message-State: ABy/qLbT5U9aONkQZqGtCPLxo1krtK15hLEtv8kfaz+s5ljyKvNuCPv9
 IRT+6yFYk8n/TrtKAvxw7t5KLxbkueBZyNEcpg4uTV+pb1oHRAcd8Uy9/2hIRpf2VTdwyv51/uM
 dnE9FVR82reV6waLOePZBsiEYarVOyt9ZgB7UnZIPlg==
X-Received: by 2002:a25:a3e6:0:b0:c12:70cd:87d6 with SMTP id
 e93-20020a25a3e6000000b00c1270cd87d6mr14240342ybi.44.1688539276723; 
 Tue, 04 Jul 2023 23:41:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFVc9RatjydCg0sv9e36cYxKE2CsNT8n20D29etZaJe4i7l6mQ2MGriFYFaVERtpfSbrfq9NXyFxxH3ox7cz5c=
X-Received: by 2002:a25:a3e6:0:b0:c12:70cd:87d6 with SMTP id
 e93-20020a25a3e6000000b00c1270cd87d6mr14240336ybi.44.1688539276500; Tue, 04
 Jul 2023 23:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
 <CAJaqyWefjZ1-Z08GR8f8kvwxPihEqpzJK17hDnO7wkGx+pCaCw@mail.gmail.com>
 <CAKrof1ODXvY-8U5zSQcFfKyaoSHTVJ6h5wFkxzZfTebmp5X7Rw@mail.gmail.com>
In-Reply-To: <CAKrof1ODXvY-8U5zSQcFfKyaoSHTVJ6h5wFkxzZfTebmp5X7Rw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Jul 2023 08:40:40 +0200
Message-ID: <CAJaqyWc5QkdWY6K-4SFZq0489S113J=HKH4G3Z_WcwFTiE-YPA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
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

On Wed, Jul 5, 2023 at 4:09=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> On 2023/7/4 23:39, Eugenio Perez Martin wrote:
> > On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> This patch introduces vhost_vdpa_net_load_rx_mode()
> >> and vhost_vdpa_net_load_rx() to restore the packet
> >> receive filtering state in relation to
> >> VIRTIO_NET_F_CTRL_RX feature at device's startup.
> >>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >> ---
> >> v2:
> >>    - avoid sending CVQ command in default state suggested by Eugenio
> >>
> >> v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c1=
83.1687402580.git.yin31149@gmail.com/
> >>
> >>   net/vhost-vdpa.c | 104 +++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 104 insertions(+)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index cb45c84c88..9d5d88756c 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -792,6 +792,106 @@ static int vhost_vdpa_net_load_offloads(VhostVDP=
AState *s,
> >>       return 0;
> >>   }
> >>
> >> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
> >> +                                       uint8_t cmd,
> >> +                                       uint8_t on)
> >> +{
> >> +    ssize_t dev_written;
> >> +    const struct iovec data =3D {
> >> +        .iov_base =3D &on,
> >> +        .iov_len =3D sizeof(on),
> >> +    };
> >> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> >> +                                          cmd, &data, 1);
> >> +    if (unlikely(dev_written < 0)) {
> >> +        return dev_written;
> >> +    }
> >> +    if (*s->status !=3D VIRTIO_NET_OK) {
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
> >> +                                  const VirtIONet *n)
> >> +{
> >> +    uint8_t on;
> >> +    int r;
> >> +
> >> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)=
) {
> >
> > Also suggesting early returns here.
>
> So, for CVQ commands related to VIRTIO_NET_F_CTRL_EXTRA_RX, would it be
> more appropriate to create a new function, maybe
> vhost_vdpa_net_load_rx_extra, to handle them instead of sending those
> CVQ commands within this function, if we choose to return early?
>

My understanding is that VIRTIO_NET_F_CTRL_RX_EXTRA depends on
VIRTIO_NET_F_CTRL_RX, so we can do:

if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
  return;
}

// Process CTRL_RX commands

if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
  return;
}

// process CTRL_RX_EXTRA commands

> >
> >> +        /* Load the promiscous mode */
> >> +        if (n->mac_table.uni_overflow) {
> >> +            /*
> >> +             * According to VirtIO standard, "Since there are no guar=
antees,
> >> +             * it can use a hash filter or silently switch to
> >> +             * allmulti or promiscuous mode if it is given too many a=
ddresses."
> >> +             *
> >> +             * QEMU ignores non-multicast(unicast) MAC addresses and
> >> +             * marks `uni_overflow` for the device internal state
> >> +             * if guest sets too many non-multicast(unicast) MAC addr=
esses.
> >> +             * Therefore, we should turn promiscous mode on in this c=
ase.
> >> +             */
> >> +            on =3D 1;
> >> +        } else {
> >> +            on =3D n->promisc;
> >> +        }
> >
> > I think we can remove the "on" variable and just do:
> >
> > /*
> >   * According to ...
> >   */
> > if (n->mac_table.uni_overflow || n->promisc) {
> >    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on)=
;
> >    if (r < 0) {
> >      return r;
> >    }
> > ---
> >
> > And the equivalent for multicast.
> >
> > Would that make sense?
>
> Yes, I will refactor these according to your suggestion.
>
> Thanks!
>
>
> >
> > Thanks!
> >
> >> +        if (on !=3D 1) {
> >> +            /*
> >> +             * According to virtio_net_reset(), device turns promiscu=
ous mode on
> >> +             * by default.
> >> +             *
> >> +             * Therefore, there is no need to send this CVQ command i=
f the
> >> +             * driver also sets promiscuous mode on, which aligns wit=
h
> >> +             * the device's defaults.
> >> +             *
> >> +             * Note that the device's defaults can mismatch the drive=
r's
> >> +             * configuration only at live migration.
> >> +             */
> >> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_P=
ROMISC, on);
> >> +            if (r < 0) {
> >> +                return r;
> >> +            }
> >> +        }
> >> +
> >> +        /* Load the all-multicast mode */
> >> +        if (n->mac_table.multi_overflow) {
> >> +            /*
> >> +             * According to VirtIO standard, "Since there are no guar=
antees,
> >> +             * it can use a hash filter or silently switch to
> >> +             * allmulti or promiscuous mode if it is given too many a=
ddresses."
> >> +             *
> >> +             * QEMU ignores multicast MAC addresses and
> >> +             * marks `multi_overflow` for the device internal state
> >> +             * if guest sets too many multicast MAC addresses.
> >> +             * Therefore, we should turn all-multicast mode on in thi=
s case.
> >> +             */
> >> +            on =3D 1;
> >> +        } else {
> >> +            on =3D n->allmulti;
> >> +        }
> >> +        if (on !=3D 0) {
> >> +            /*
> >> +             * According to virtio_net_reset(), device turns all-mult=
icast mode
> >> +             * off by default.
> >> +             *
> >> +             * Therefore, there is no need to send this CVQ command i=
f the
> >> +             * driver also sets all-multicast mode off, which aligns =
with
> >> +             * the device's defaults.
> >> +             *
> >> +             * Note that the device's defaults can mismatch the drive=
r's
> >> +             * configuration only at live migration.
> >> +             */
> >> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_A=
LLMULTI, on);
> >> +            if (r < 0) {
> >> +                return r;
> >> +            }
> >> +        }
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static int vhost_vdpa_net_load(NetClientState *nc)
> >>   {
> >>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >> @@ -818,6 +918,10 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
> >>       if (unlikely(r)) {
> >>           return r;
> >>       }
> >> +    r =3D vhost_vdpa_net_load_rx(s, n);
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


