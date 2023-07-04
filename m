Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078A474757B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGi8R-000716-OV; Tue, 04 Jul 2023 11:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGi8H-00070B-Ag
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGi8F-0005AJ-IS
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688485198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fajVaDpslwMZGr0sUTK2oXQa7ooZzGOS6kDsWVvSLVk=;
 b=fJtEbBEjrsoF7ANat4icf5obcbglvnCfX+cO+KuGappZv2HYzqMMNCTUfTNtrTPu56o/CE
 lahiufKZHlr3rlbNRwLu4mZsJ5GECQEZTDbtWFm+j+h+5RwIAJ9ljFQFHsFhMBBcxXoGrZ
 12vcO+3N0FhRKSWAdgENo1D1B2LxuJA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-icw1G52hOZ2vX03ryVb0yA-1; Tue, 04 Jul 2023 11:39:57 -0400
X-MC-Unique: icw1G52hOZ2vX03ryVb0yA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-c5c8d00ce50so858979276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688485197; x=1691077197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fajVaDpslwMZGr0sUTK2oXQa7ooZzGOS6kDsWVvSLVk=;
 b=b4Li16CethW6e3VkJnfrQd+3cDE+880VriFdu95PbiraNPrjmlebOwpEdsvTrD8Lnj
 51Jg9bMSC/KsllpQf1Uz1ErNv+1cWY1SwvoB9k41eq8HUGeI+wyLn1k2ZtuepfY6u9Ma
 IVDlZDIF/5pTjaP+RBChULuI8LBpcTzQT6kcbG7dCkg+CY2/6qHAZ3rB+PPSbpHqOM3T
 0Dvc9wlSpVqx1RxXMxK7LRAUJ3AWQI8/sp5qPWIvAYxLCdD2Mr6UZ9Xxm5KuZE0kErsB
 ankQRDcZM7LW1fhDmy1b7UTJMQtao0HV4gpbtAebtL6OoY4EIrcxnRjYHv1jtJsjLZXJ
 xoag==
X-Gm-Message-State: ABy/qLYu95wM5NKmwxrvTKZOrLYM9GjO5dxxiJMlD01gLnRu0cGxfKCQ
 jzZ9TQzR2QPwEGFdSMfTU1hxUdnwHD58DGJRSltfLFeRO8PpcI1RQaanEWAps2eG28LA+Slcvv1
 t7xHPrEZW6ouuNIxSOBiXj+F37XvAE4E=
X-Received: by 2002:a25:9d0f:0:b0:bfe:e383:6297 with SMTP id
 i15-20020a259d0f000000b00bfee3836297mr13204713ybp.19.1688485196733; 
 Tue, 04 Jul 2023 08:39:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpVE2vDSnFISd2Q6hIW6nHP6pT7FrYxsK9fkN3jIrATc6meriv8x52gMPZVMxQuGT+g7pbPM53hYyuV/BXcGE=
X-Received: by 2002:a25:9d0f:0:b0:bfe:e383:6297 with SMTP id
 i15-20020a259d0f000000b00bfee3836297mr13204696ybp.19.1688485196444; Tue, 04
 Jul 2023 08:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
In-Reply-To: <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 4 Jul 2023 17:39:20 +0200
Message-ID: <CAJaqyWefjZ1-Z08GR8f8kvwxPihEqpzJK17hDnO7wkGx+pCaCw@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_rx_mode()
> and vhost_vdpa_net_load_rx() to restore the packet
> receive filtering state in relation to
> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v2:
>   - avoid sending CVQ command in default state suggested by Eugenio
>
> v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.=
1687402580.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index cb45c84c88..9d5d88756c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -792,6 +792,106 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
ate *s,
>      return 0;
>  }
>
> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
> +                                       uint8_t cmd,
> +                                       uint8_t on)
> +{
> +    ssize_t dev_written;
> +    const struct iovec data =3D {
> +        .iov_base =3D &on,
> +        .iov_len =3D sizeof(on),
> +    };
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> +                                          cmd, &data, 1);
> +    if (unlikely(dev_written < 0)) {
> +        return dev_written;
> +    }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
> +                                  const VirtIONet *n)
> +{
> +    uint8_t on;
> +    int r;
> +
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {

Also suggesting early returns here.

> +        /* Load the promiscous mode */
> +        if (n->mac_table.uni_overflow) {
> +            /*
> +             * According to VirtIO standard, "Since there are no guarant=
ees,
> +             * it can use a hash filter or silently switch to
> +             * allmulti or promiscuous mode if it is given too many addr=
esses."
> +             *
> +             * QEMU ignores non-multicast(unicast) MAC addresses and
> +             * marks `uni_overflow` for the device internal state
> +             * if guest sets too many non-multicast(unicast) MAC address=
es.
> +             * Therefore, we should turn promiscous mode on in this case=
.
> +             */
> +            on =3D 1;
> +        } else {
> +            on =3D n->promisc;
> +        }

I think we can remove the "on" variable and just do:

/*
 * According to ...
 */
if (n->mac_table.uni_overflow || n->promisc) {
  r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on);
  if (r < 0) {
    return r;
  }
---

And the equivalent for multicast.

Would that make sense?

Thanks!

> +        if (on !=3D 1) {
> +            /*
> +             * According to virtio_net_reset(), device turns promiscuous=
 mode on
> +             * by default.
> +             *
> +             * Therefore, there is no need to send this CVQ command if t=
he
> +             * driver also sets promiscuous mode on, which aligns with
> +             * the device's defaults.
> +             *
> +             * Note that the device's defaults can mismatch the driver's
> +             * configuration only at live migration.
> +             */
> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROM=
ISC, on);
> +            if (r < 0) {
> +                return r;
> +            }
> +        }
> +
> +        /* Load the all-multicast mode */
> +        if (n->mac_table.multi_overflow) {
> +            /*
> +             * According to VirtIO standard, "Since there are no guarant=
ees,
> +             * it can use a hash filter or silently switch to
> +             * allmulti or promiscuous mode if it is given too many addr=
esses."
> +             *
> +             * QEMU ignores multicast MAC addresses and
> +             * marks `multi_overflow` for the device internal state
> +             * if guest sets too many multicast MAC addresses.
> +             * Therefore, we should turn all-multicast mode on in this c=
ase.
> +             */
> +            on =3D 1;
> +        } else {
> +            on =3D n->allmulti;
> +        }
> +        if (on !=3D 0) {
> +            /*
> +             * According to virtio_net_reset(), device turns all-multica=
st mode
> +             * off by default.
> +             *
> +             * Therefore, there is no need to send this CVQ command if t=
he
> +             * driver also sets all-multicast mode off, which aligns wit=
h
> +             * the device's defaults.
> +             *
> +             * Note that the device's defaults can mismatch the driver's
> +             * configuration only at live migration.
> +             */
> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLM=
ULTI, on);
> +            if (r < 0) {
> +                return r;
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -818,6 +918,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      if (unlikely(r)) {
>          return r;
>      }
> +    r =3D vhost_vdpa_net_load_rx(s, n);
> +    if (unlikely(r)) {
> +        return r;
> +    }
>
>      return 0;
>  }
> --
> 2.25.1
>


