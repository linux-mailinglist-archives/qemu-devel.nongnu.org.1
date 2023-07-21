Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342D75C641
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMomA-0004GG-3Z; Fri, 21 Jul 2023 07:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMom7-0004Fo-PM
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMom6-0003GD-9D
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689940701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Zyqp+RNJwQANpb3SX38nWDfhDU7pNYc4znhX5MrKiE=;
 b=KUp0YctswCmDBUiADKtEy/ZesXGhmV8dqJxk5w5WpOJBzOrsbfTqyX3urfqPCy4jjz71r3
 mJ3iRvlRv1TcQMsQU2dMbTEimVTOyF0+aR9Z2o8han/xkqhh4ahXq3A435nFcwn1y75ByX
 Wai8SrlzSVUrqRMP+v37tFsVDPFzhaE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-jvAp1irkPg-h3rtOB_6nVA-1; Fri, 21 Jul 2023 07:58:19 -0400
X-MC-Unique: jvAp1irkPg-h3rtOB_6nVA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-577323ba3d5so48369307b3.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 04:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689940698; x=1690545498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Zyqp+RNJwQANpb3SX38nWDfhDU7pNYc4znhX5MrKiE=;
 b=YzYMSue6G2UWF52JWQiUzaLf/oqH6JTci6s6EUY0UnYoh2DpsvOTBwGm8OXd77ZVGM
 1D9IlkYn4ehQlaC9k0BztrMDgmevQXKushARQUHXHYRsSZHYALPtGJo0TRtk2H6gtSRQ
 TZC5Pdb3eWASzF+ug8KVqPkK8clon0/nmUOPDjKmieHS40ggJJlERKSG7LSeD+puxZKP
 MgPP07T81EPbByrGk/7YYoT8M15marypH06NXL0l426/VVFXTpt55XQYHIMrgaDLB4eE
 UZOq2gaKImA4UnrFFr90CRmB6Ooom+Kz3DEz/Nwk31w6U2fL8DAH39sW11gqzQvNVUQN
 bebg==
X-Gm-Message-State: ABy/qLbOM45oxpw+vJWyhgICkbXBwojzCW1pTylXdI8ES6dYTui/XiVV
 iIz4BIHvppwVSuoNxvgeWZyHvPYnYN2Xx6x6Sd7zLJX9E16QqPWJsTreoWYeL640LE7/2P3Dhyn
 dyGpGPe6krdKLxIcoL9tuw0G8xf6el0U=
X-Received: by 2002:a25:4cc9:0:b0:cee:80e:23af with SMTP id
 z192-20020a254cc9000000b00cee080e23afmr1482012yba.11.1689940698559; 
 Fri, 21 Jul 2023 04:58:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG6Pd3uQSGkVvs2cDCzfuv6mFTwNDSLGt1/Cf465itw188rro5VVcyRrScX3jhSdP9ZZwqZ3AWKzZhY83UkC98=
X-Received: by 2002:a25:4cc9:0:b0:cee:80e:23af with SMTP id
 z192-20020a254cc9000000b00cee080e23afmr1482003yba.11.1689940698323; Fri, 21
 Jul 2023 04:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689690854.git.yin31149@gmail.com>
 <0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.1689690854.git.yin31149@gmail.com>
In-Reply-To: <0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.1689690854.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 21 Jul 2023 13:57:42 +0200
Message-ID: <CAJaqyWf1ZP6G91skDx4rai=xArkdvPZj8g3-UXC2dHc0iUN3-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] vdpa: Restore vlan filtering state
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

On Wed, Jul 19, 2023 at 9:48=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_single_vlan()
> and vhost_vdpa_net_load_vlan() to restore the vlan
> filtering state at device's startup.
>
> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9795306742..0787dd933b 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -965,6 +965,51 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
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
> +

Nit: I'm not sure if it was here originally, but there is an extra newline =
here.

>  static int vhost_vdpa_net_load(NetClientState *nc)
>  {
>      VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> @@ -995,6 +1040,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


