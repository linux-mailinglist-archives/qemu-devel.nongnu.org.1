Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30A780F71
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:42:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1bs-0002mL-UA; Fri, 18 Aug 2023 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1bn-0002Yy-Mo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qX1bl-00084A-Fo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692373312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OEGuO+CVAn4dYe5kDfDxflke8GAykRXauHDwDDmklao=;
 b=U7Cg/AIol10zTeRAYuMtAcz7j7Tmq/UKyRSeye5nz+HiBk10JDrcBQk/otUwbWaqyUBGUJ
 RQhWNoz5xiXaLmcK0vorkGIlyVSD34Q79rdXbvGLcBTOMzUBoDWvMfLfyI3tM5ai6j2bqd
 lJ721Y1zsZDT6q8a6p1gP2A0xdokAjg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-8FBL6IDlMSCrNet3NhFsxw-1; Fri, 18 Aug 2023 11:41:49 -0400
X-MC-Unique: 8FBL6IDlMSCrNet3NhFsxw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-56c13bf96b2so1149375eaf.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 08:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692373309; x=1692978109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEGuO+CVAn4dYe5kDfDxflke8GAykRXauHDwDDmklao=;
 b=fm2yYYbl+YwmEYYi+cifrUgW1h55846d5lHnFVPZapn0F3OgeigqI0K+YFg+ehBgvn
 LC9OVyURwWmqRC3SPUwG8YqdJlZhjdvBkzWugq6gID0INZl9GkmSYdrKhrBPRUFzdvEc
 mQD43pvftGzD6SX78EIr3CI/PjLbEnb6EsqWsh77jiUPmffwZecRjdjTNji5YWMuvhoX
 es/Pwb7On2+IOJ5eiZe4/ec2A+K84vxGWVNBVQXn5OOVhY2GMIgkid2sTygFOxI5v7pm
 ZkKCkknHhzM8xyUa7LWQMPj8I0TuwpfjcyVP1BzsBCGkFvR/+Xxs6eRnEoKNR30jtwtW
 k9rA==
X-Gm-Message-State: AOJu0YySeP+y/JVeTeVlAIhfqwtilbpeHhrjikjQXUlXZBMDLfiOjw5F
 9RxgOifEtnoLHpwpmj4ghcpchobaTJuHZSPjoXhnVOIBFxfxYjRw/nbGI7jSEHqh0gTjPbeH+aR
 BpYzw1qbGhoruM/dy4BUk9AKGyadp8cU=
X-Received: by 2002:a05:6358:9209:b0:132:d07d:8f3b with SMTP id
 d9-20020a056358920900b00132d07d8f3bmr3747657rwb.28.1692373308860; 
 Fri, 18 Aug 2023 08:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIPWYfu3Mlh5EvwIFl/mQ1Y1vo3pJhmqd8dPxlujtN8YKFGBQzatmEvaxzzzFuOsDC8a9915OQdxrCT0o9p8=
X-Received: by 2002:a05:6358:9209:b0:132:d07d:8f3b with SMTP id
 d9-20020a056358920900b00132d07d8f3bmr3747638rwb.28.1692373308564; Fri, 18 Aug
 2023 08:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <abecff1ddd3020adacb398e0f553600d0b088205.1689748694.git.yin31149@gmail.com>
In-Reply-To: <abecff1ddd3020adacb398e0f553600d0b088205.1689748694.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 18 Aug 2023 17:41:12 +0200
Message-ID: <CAJaqyWeKmBA5mu=0EbAc1MyStMXxqJ1gd8sbXMoFxvL9Xu-rGw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] vdpa: Check device ack in
 vhost_vdpa_net_load_rx_mode()
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

On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Considering that vhost_vdpa_net_load_rx_mode() is only called
> within vhost_vdpa_net_load_rx() now, this patch refactors
> vhost_vdpa_net_load_rx_mode() to include a check for the
> device's ack, simplifying the code and improving its maintainability.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/vhost-vdpa.c | 76 ++++++++++++++++++++----------------------------
>  1 file changed, 31 insertions(+), 45 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index ae8f59adaa..fe0ba19724 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -814,14 +814,24 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPASta=
te *s,
>          .iov_base =3D &on,
>          .iov_len =3D sizeof(on),
>      };
> -    return vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> -                                   cmd, &data, 1);
> +    ssize_t dev_written;
> +
> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
> +                                          cmd, &data, 1);
> +    if (unlikely(dev_written < 0)) {
> +        return dev_written;
> +    }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EIO;
> +    }
> +
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>                                    const VirtIONet *n)
>  {
> -    ssize_t dev_written;
> +    ssize_t r;
>
>      if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) =
{
>          return 0;
> @@ -846,13 +856,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (!n->mac_table.uni_overflow && !n->promisc) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_PROMISC, =
0);
> -        if (unlikely(dev_written < 0)) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC,=
 0);
> +        if (unlikely(r < 0)) {
> +            return r;
>          }
>      }
>
> @@ -874,13 +880,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->mac_table.multi_overflow || n->allmulti) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_ALLMULTI,=
 1);
> -        if (unlikely(dev_written < 0)) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULTI=
, 1);
> +        if (unlikely(r < 0)) {
> +            return r;
>          }
>      }
>
> @@ -899,13 +901,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->alluni) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_ALLUNI, 1=
);
> -        if (dev_written < 0) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, =
1);
> +        if (r < 0) {
> +            return r;
>          }
>      }
>
> @@ -920,13 +918,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nomulti) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_NOMULTI, =
1);
> -        if (dev_written < 0) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI,=
 1);
> +        if (r < 0) {
> +            return r;
>          }
>      }
>
> @@ -941,13 +935,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nouni) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_NOUNI, 1)=
;
> -        if (dev_written < 0) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, 1=
);
> +        if (r < 0) {
> +            return r;
>          }
>      }
>
> @@ -962,13 +952,9 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>       * configuration only at live migration.
>       */
>      if (n->nobcast) {
> -        dev_written =3D vhost_vdpa_net_load_rx_mode(s,
> -                                            VIRTIO_NET_CTRL_RX_NOBCAST, =
1);
> -        if (dev_written < 0) {
> -            return dev_written;
> -        }
> -        if (*s->status !=3D VIRTIO_NET_OK) {
> -            return -EIO;
> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST,=
 1);
> +        if (r < 0) {
> +            return r;
>          }
>      }
>
> --
> 2.25.1
>


