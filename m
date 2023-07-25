Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F0C760AD2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 08:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOBpV-0005BG-29; Tue, 25 Jul 2023 02:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBpS-0005Aa-C4
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOBpQ-00078c-0L
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 02:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690267647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83mnbR7N313B4P6f9KH4/0/1zSlGnwwL3BeAexSCCcY=;
 b=ZX22rk5BwMh0HgSuZPS5Gn4cocnr85qmEebW7dLUdUtieBpyJNJY6fXaUX08OsZnTY9Dlp
 S+WnG1tP8LWKhDF/MRjAy8yBqJI2l2CD2nyBTjFrVK3wJ0eAtZUNz4ICWZxyWKWnLdhVEt
 VMSv46KVUto+dMxba3ocv5lyKHRFRTk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-0aWwC-rcMBW6z-pER7y_cQ-1; Tue, 25 Jul 2023 02:47:25 -0400
X-MC-Unique: 0aWwC-rcMBW6z-pER7y_cQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6fbed5189so42579801fa.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 23:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690267643; x=1690872443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=83mnbR7N313B4P6f9KH4/0/1zSlGnwwL3BeAexSCCcY=;
 b=PDmA/ewNfIbLP/ZwTambQuAVaNp6F+fbQ5Z8+63r3m288odBAPimM3fvh0zdtOqAhi
 Hh5sIbwbyOlnZogspB/1gA0pQzV6kBwDVyEmfL6LVERozjucF8yasT3OhuLwcpwdJIxB
 R+TBr0pmQ2phNU8u83ypY6imD7pwHkPi8US1aqiR+ggPe6tkesPj0BiKyIsg32IIVUTP
 RTmPPIV8Y69zBGzPD+Dtj7vUyNPoPAXwl5QPPLSM9/Yr1BCdaOuIqNSb/qQ9iEHFNBXX
 a0aVrehRp9rVO02aU8o+F0rCAnLoNrr0b17qUIlwaq6NwCqAnv1kPDsPbZJ+K3I/4ss2
 QQOA==
X-Gm-Message-State: ABy/qLYcxPb3luAkOQ2bU4gdhypIyyL/pqrK4qlOKC+jfAqZqYp08Kht
 lnMlKKOqhKaC4yeTV5lKiAezew9oSUo4u5WmDlNP9wohvnYdZU/whBEXsC7eGTuWMMLTZkXHYry
 x3QuBqv5aFI+DdGpCn3bKPykWdZ8T5Iw=
X-Received: by 2002:a2e:80d8:0:b0:2b6:c790:150a with SMTP id
 r24-20020a2e80d8000000b002b6c790150amr8137912ljg.22.1690267643193; 
 Mon, 24 Jul 2023 23:47:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFKOzkW4FCRplx+jrYncBpgj8Q7UaA2XFyOkFs4ykw/ZmALxko2oa63L3nk96NVjv8my1rNMRaJOu5JGl/88Ps=
X-Received: by 2002:a2e:80d8:0:b0:2b6:c790:150a with SMTP id
 r24-20020a2e80d8000000b002b6c790150amr8137896ljg.22.1690267642892; Mon, 24
 Jul 2023 23:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690100802.git.yin31149@gmail.com>
In-Reply-To: <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690100802.git.yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 14:47:11 +0800
Message-ID: <CACGkMEuM8JdPhch4uV+3zBSq=8ss99xDwX-KAr9_8_Q8TJ9m+g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa: Restore vlan filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Sun, Jul 23, 2023 at 5:28=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_single_vlan()
> and vhost_vdpa_net_load_vlan() to restore the vlan
> filtering state at device's startup.
>
> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

But this seems to be a source of latency killer as it may at most send
1024 commands.

As discussed in the past, we need a better cvq command to do this: for
example, a single command to carray a bitmap.

Thanks

> ---
> v2:
>  - remove the extra line pointed out by Eugenio
>
> v1: https://lore.kernel.org/all/0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.=
1689690854.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9795306742..347241796d 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -965,6 +965,50 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>      return 0;
>  }
>
> +static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
> +                                           const VirtIONet *n,
> +                                           uint16_t vid)
> +{
> +    const struct iovec data =3D {
> +        .iov_base =3D &vid,
> +        .iov_len =3D sizeof(vid),
> +    };
> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_V=
LAN,
> +                                                  VIRTIO_NET_CTRL_VLAN_A=
DD,
> +                                                  &data, 1);
> +    if (unlikely(dev_written < 0)) {
> +        return dev_written;
> +    }
> +    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
> +                                    const VirtIONet *n)
> +{
> +    int r;
> +
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_VLAN)=
) {
> +        return 0;
> +    }
> +
> +    for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
> +        for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
> +            if (n->vlans[i] & (1U << j)) {
> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + j=
);
> +                if (unlikely(r !=3D 0)) {
> +                    return r;
> +                }
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
> @@ -995,6 +1039,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>      if (unlikely(r)) {
>          return r;
>      }
> +    r =3D vhost_vdpa_net_load_vlan(s, n);
> +    if (unlikely(r)) {
> +        return r;
> +    }
>
>      return 0;
>  }
> --
> 2.25.1
>


