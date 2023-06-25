Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087D73D03B
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 12:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDNOx-0000p6-W0; Sun, 25 Jun 2023 06:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNOv-0000op-GP
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qDNOu-0006OC-0U
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 06:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687690522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnqybfnxXk4pw3IT4XUHt9Uw1kbULmoRoMXZ6IxIG08=;
 b=Ec3GM0+kQ5dbAn8u3wYs08QKRZFtimwO9wI8FGmraGbbrpxcDakxpoJeUqw5m+KXD76wmM
 c2ILybuYSk1vhrsWf2l/QB4JEudecD3krRYZtTVOS7yUIqM9SRlQekVnQz8pvaVXHkczU4
 BFlUKgpmaafoCBtm/YriyPBP+tfTKEQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-54vRmUFmMG6yghAwZLFxqA-1; Sun, 25 Jun 2023 06:55:21 -0400
X-MC-Unique: 54vRmUFmMG6yghAwZLFxqA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-bfec07e5eb0so2232374276.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 03:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687690521; x=1690282521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnqybfnxXk4pw3IT4XUHt9Uw1kbULmoRoMXZ6IxIG08=;
 b=cUG+fd2Bn41Ps5dXznILrKXyyQn2Jm4xC6iN1sWxx1nM9Ww/FziccuRacHt9djDZ0f
 4SOgnxd3bErVZmBTL5xM4mTBCLD/Fxp/rSo4zFbbZUCmurVfs44B7ZFuXrhMZaZDLKuq
 HKQex+7QNN1rxHKDOEVKFaqvX1ALmvLOAvpBAwjcIxL5E2esvxBtFdV/EyQrv570AV8h
 8EcAmdQHtzaG9Rz2yNhV17Kli8BP2n5ieL+1Uf7TIehajSkZ+NEEKepvq7jLQ0gU/Bk/
 qvctAoSC3YYEAYAD8RKtGevVnE0dB8CIHzgoVEorlCe6pjm9co6465J9jLUnSmbUkfks
 fTUA==
X-Gm-Message-State: AC+VfDzd3+yqqHQercbT9peLBXhXQAETxeuCHQaa5RMr242pmFlMTSwt
 1cWz1j2YZOmBcW9fFwyvFEApAakt7+FQ4g6YboMyJ9dHNtOR/xhRuPzKtevcC5rAkWnSItnpLBu
 qqpKdfV1EoaZnxNWATH9j9lKa0Kk0mFM=
X-Received: by 2002:a25:4f89:0:b0:be6:7314:19d5 with SMTP id
 d131-20020a254f89000000b00be6731419d5mr12614085ybb.23.1687690520909; 
 Sun, 25 Jun 2023 03:55:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cefq0dW1RRlNGv1jf24GO9mvT8i+MifpocOoHTXKiw7Ek1IgxbR8+346lP5d1nt+UtuKM585lDwD5+BCEW28=
X-Received: by 2002:a25:4f89:0:b0:be6:7314:19d5 with SMTP id
 d131-20020a254f89000000b00be6731419d5mr12614083ybb.23.1687690520694; Sun, 25
 Jun 2023 03:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687524532.git.yin31149@gmail.com>
 <e88a774a47c19ca85ae838b30b75dac549446f5b.1687524532.git.yin31149@gmail.com>
In-Reply-To: <e88a774a47c19ca85ae838b30b75dac549446f5b.1687524532.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 25 Jun 2023 12:54:44 +0200
Message-ID: <CAJaqyWdZgsEs9QWf8a5p5EOYBAnQYRS-gMaQrAeddAuAEmp+Vw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX_EXTRA feature
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Fri, Jun 23, 2023 at 3:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch refactors vhost_vdpa_net_load_rx() to
> restore the packet receive filtering state in relation to
> VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>  net/vhost-vdpa.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index ca800f97e2..9b929762c5 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -822,6 +822,36 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>          }
>      }
>
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EXT=
RA)) {
> +        /* Load the all-unicast mode */
> +        on =3D n->alluni;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, =
on);
> +        if (r < 0) {
> +            return r;
> +        }
> +
> +        /* Load the non-multicast mode */
> +        on =3D n->nomulti;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI,=
 on);
> +        if (r < 0) {
> +            return r;
> +        }
> +
> +        /* Load the non-unicast mode */
> +        on =3D n->nouni;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, o=
n);
> +        if (r < 0) {
> +            return r;
> +        }
> +
> +        /* Load the non-broadcast mode */
> +        on =3D n->nobcast;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST,=
 on);
> +        if (r < 0) {
> +            return r;
> +        }
> +    }
> +

Can we skip the load if the state matches the virtio defaults? by
virtio_net_reset the defaults are:
    n->promisc =3D 1;
    n->allmulti =3D 0;
    n->alluni =3D 0;
    n->nomulti =3D 0;
    n->nouni =3D 0;
    n->nobcast =3D 0;

Thanks!

>      return 0;
>  }
>
> --
> 2.25.1
>


