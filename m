Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16473D03E
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:57:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNQh-0002DJ-7V; Sun, 25 Jun 2023 06:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNQf-0002Cs-5T
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:57:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNQd-0006dI-Iy
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687690630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sjhur8lWpmf6/OEpCMSJpJZznkqbRsojVXxHmMYa1LU=;
 b=U3uhRRFlgswWHdQchTWB7SaNKICeJXQtZOnSAdPXDHfVl1pUp0NfeuLpXE9hC3xBBWGW+2
 P8DtmoPwaRIJiFR7UHS6ruwGyZcP3DsbXvskSpv6ANmQxTtUK7I1wrlONLIipuGEx/bTeZ
 sy4XUZ+qAqWG2cZewtt7x3Zd27FLh98=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-aRoLmczfMROpLYd5omPpoA-1; Sun, 25 Jun 2023 06:57:08 -0400
X-MC-Unique: aRoLmczfMROpLYd5omPpoA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-56942442eb0so30163467b3.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690628; x=1690282628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sjhur8lWpmf6/OEpCMSJpJZznkqbRsojVXxHmMYa1LU=;
 b=R23ABpQyUg0k5QD4KYux373j4etWgR18L+KW4hkXZ46sZF0Y6y5qwvb9hzoCGkWxp1
 JaCkzZewh8N5To8QQt/xmRbM2y9XOcZEWXIgrsnvVrbbTeu3dsqhjaAVNOAIS2+gVSzp
 POh6GcQ0vyo0lnxKIBGK3F1xvKw1Xc70UkhTU02gVlLv+8rsWKwlKRsQSDpWPVHvA1jg
 qXT0l65aac6Byj+pRxyO4CthEzWdqpXTXYMCHcARkHXqXBcFdVDFxP9flp+atKfqu3eA
 9aM4xy39hUv9jCNfU7dqc8+HWvkwmrL6206eucORUvhJ6lP+J2wT6nRAyNW8aavnwQqs
 0zKw==
X-Gm-Message-State: AC+VfDww5cY4M9xb771RrQjBNJmajENaM2Etu8343YzRQ+3cCVMlesDn
 zGTH1HFr8orZlyHXZ0artzAhPTGwr1lSUzU5yntae3iaLMDq1UV03zB5noqgvRNX2f094fc9v3w
 z4vItZyi8YDWO22ipFEMg4cEZschU3NU=
X-Received: by 2002:a25:9385:0:b0:bea:918f:2f01 with SMTP id
 a5-20020a259385000000b00bea918f2f01mr21685579ybm.44.1687690628304; 
 Sun, 25 Jun 2023 03:57:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/ICQME/yspPkKa66NcOj5b5jANja6jqe1wmCQa+tQUmjAlZkFD0851fVN6/dSxXVUT6unjfKqyXdG4Ei0wkE=
X-Received: by 2002:a25:9385:0:b0:bea:918f:2f01 with SMTP id
 a5-20020a259385000000b00bea918f2f01mr21685568ybm.44.1687690628053; Sun, 25
 Jun 2023 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687402580.git.yin31149@gmail.com>
 <86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com>
In-Reply-To: <86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:56:32 +0200
Message-ID: <CAJaqyWcERYv=qFD9Aefmcr4yTZd8HzFp37Guxhvtfo9zCcoexw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jun 22, 2023 at 5:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_rx_mode()
> and vhost_vdpa_net_load_rx() to restore the packet
> receive filtering state in relation to
> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 10264d3e96..355a6aef15 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -754,6 +754,76 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>      return *s->status !=3D VIRTIO_NET_OK;
>  }
>
> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
> +                                       uint8_t cmd,
> +                                       uint8_t on)
> +{
> +    ssize_t dev_written;
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> +                                          cmd, &on, sizeof(on));
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
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC,=
 on);
> +        if (r < 0) {
> +            return r;
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
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI=
, on);
> +        if (r < 0) {
> +            return r;
> +        }

Can we skip the sending of the CVQ commands if the state matches the
default state?

Thanks!

> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -780,6 +850,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


