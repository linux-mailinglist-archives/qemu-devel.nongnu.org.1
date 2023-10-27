Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E8F7D8EEF
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGen-0002a2-DH; Fri, 27 Oct 2023 02:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGel-0002Zc-3Y
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qwGej-0007OX-BN
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698389356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=os44ixVTmyrsDJMhKpf7U1fxpwL3Ete0vheE0+mzWbk=;
 b=XWq3GVzbQm/dS+mWCmaQv9WAk276iJA9Qa3T/5YavxsO8GMoj8WfLQr0aGXHdwD7FTX3Iz
 PbFvrD65J4aQ+vy2edcBdRgfBiu1+k9gY1CM8ItbsAs1dHcaOS8FZ0Ra9aw9n9+Z7+YyzT
 HpSI6pODtcouFrIvemlgbOQG6BKF1Uw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-K_4Qz2OMPMS9V2nay4m0Ew-1; Fri, 27 Oct 2023 02:49:14 -0400
X-MC-Unique: K_4Qz2OMPMS9V2nay4m0Ew-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c512a53e82so19367791fa.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 23:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698389353; x=1698994153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=os44ixVTmyrsDJMhKpf7U1fxpwL3Ete0vheE0+mzWbk=;
 b=MHQFQpQJKeEJJpxWYy51DK6P6wmztXn0ALIj/R6JTZ31SFWNAw7FuMhcnjyqNpcnKA
 Pm/Ko01qBgiYfJ1cnIry9KE4z1eqfg+rbx6ayPC2DXgj/U5G9KKd7rAxsvR1fRv6EYsW
 Td9MGIEn8jOaeZ1qqzqAWnEVeMl7034kLhz2u8j4xDsS7/Tp06SHYxPnhbM9Yp6AhXKl
 u7P6itWlMAsp3TiHnxtwrYKVj5w6ix5qjbmYtcmIVac+BC8RLdxB7Xl4OdCL+EN+HeLF
 zy1m0MCDXOLQYRndD94RBoMM6+QsuvCp3dGxkUsPJnjCkQfkpDozmCky81ZWhopCUgk5
 Qq9w==
X-Gm-Message-State: AOJu0Ywrlve17qpaTISRK8zWqT23aZmTAfYJRM9VCLRFB8a0rqEK64Qy
 XWbzttag1xIrdna1to/+2x5ho7V4v7q+mdKh41T7jsbl/w+FoT+9iVsJDKtrl9qmeEKKi8ezWn6
 3xZI/xZZJnmgm3eGyi5Q+CEAnsQa0PU3KHeIckb4RAQ==
X-Received: by 2002:a19:f608:0:b0:503:1913:ed8e with SMTP id
 x8-20020a19f608000000b005031913ed8emr954365lfe.61.1698389352832; 
 Thu, 26 Oct 2023 23:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5/Kn7x60vH6rxyk//Bl7jkslx7R+r3tkZL/WptribRph4Cyhfj7rHvj3BOvvGGUMnd63/u9egSXzucoYmKv8=
X-Received: by 2002:a19:f608:0:b0:503:1913:ed8e with SMTP id
 x8-20020a19f608000000b005031913ed8emr954353lfe.61.1698389352484; Thu, 26 Oct
 2023 23:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
In-Reply-To: <20231017040932.62997-5-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Oct 2023 14:49:01 +0800
Message-ID: <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 17, 2023 at 12:09=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> While netmap implements virtio-net header, it does not implement
> receive_raw().

The only user for raw is the announcing. Netmap probably doesn't it at all.

> Instead of implementing receive_raw for netmap, add
> virtio-net headers in the common code and use receive_iov()/receive()
> instead. This also fixes the buffer size for the virtio-net header.
>
> Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/net/net.h   |  1 -
>  include/net/queue.h |  1 -
>  net/net.c           | 17 +++++++++--------
>  net/queue.c         | 30 ++++++++++--------------------
>  net/tap.c           |  1 -
>  5 files changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index 011031ef77..971dc54897 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -71,7 +71,6 @@ typedef struct NetClientInfo {
>      NetClientDriver type;
>      size_t size;
>      NetReceive *receive;
> -    NetReceive *receive_raw;
>      NetReceiveIOV *receive_iov;
>      NetCanReceive *can_receive;
>      NetStart *start;
> diff --git a/include/net/queue.h b/include/net/queue.h
> index 9f2f289d77..7a43863be2 100644
> --- a/include/net/queue.h
> +++ b/include/net/queue.h
> @@ -31,7 +31,6 @@ typedef struct NetQueue NetQueue;
>  typedef void (NetPacketSent) (NetClientState *sender, ssize_t ret);
>
>  #define QEMU_NET_PACKET_FLAG_NONE  0
> -#define QEMU_NET_PACKET_FLAG_RAW  (1<<0)
>
>  /* Returns:
>   *   >0 - success
> diff --git a/net/net.c b/net/net.c
> index 6d2fa8d40f..2d94d23c07 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -752,8 +752,13 @@ ssize_t qemu_receive_packet_iov(NetClientState *nc, =
const struct iovec *iov,
>
>  ssize_t qemu_send_packet_raw(NetClientState *nc, const uint8_t *buf, int=
 size)
>  {
> -    return qemu_send_packet_async_with_flags(nc, QEMU_NET_PACKET_FLAG_RA=
W,
> -                                             buf, size, NULL);
> +    struct virtio_net_hdr_v1_hash vnet_hdr =3D { };
> +    struct iovec iov[] =3D {
> +        { .iov_base =3D &vnet_hdr, .iov_len =3D nc->vnet_hdr_len },
> +        { .iov_base =3D (void *)buf, .iov_len =3D size }
> +    };

Having virtio-net specific code in the net layer is a layer violation.
I'd leave it to tap.

Thanks


