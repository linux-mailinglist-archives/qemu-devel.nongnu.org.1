Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACFA7460E1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMa8-00051K-NM; Mon, 03 Jul 2023 12:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGMa6-00050O-2I
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGMa4-0007jF-85
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688402355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pl5VMnTqwkp2uuPTnxbNUQaJCfcNYVAdeSDF0YOVY9Q=;
 b=LNHtH9cdlVF1BoYrpVI6XN0/F1yyZfCncyQLDbJ679KTrR45oVO8kublR+0BXICKOy4H5O
 gH/UhZ292S3D8j8cAwt16TlJ12SGCBbCrq76CGcA+2LCandeJ3jGpz++ifnFV9qayz+EN6
 LeqqrCmF0AvGXoV5gkU1g2yN6TEoQM0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-RuYro63GOCu8PWG4YOnDYQ-1; Mon, 03 Jul 2023 12:39:13 -0400
X-MC-Unique: RuYro63GOCu8PWG4YOnDYQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-bf34588085bso5010636276.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688402353; x=1690994353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pl5VMnTqwkp2uuPTnxbNUQaJCfcNYVAdeSDF0YOVY9Q=;
 b=TDqCPbmKE7pZbx3b83ilD+zSxfucC/A5BqHIMZ/q3AkDziQL6n8a9WuDq9hhfA9+vt
 uUvCc+I47r5/nVzUykrJIYEWl4RrS9KSaR1MdHHHrzTFWBg3FqCtRCF1rBmi6AMBWTeh
 NpAL7Qy9d647oqkzWQebAjkN7vPfflQBg47Y0T+a8KhrUG5uPVQGW8zf554PBU2Yp8Vx
 CJs5ZUNIeSA8zfvo8PeKNb8CgpDI47ftvGIblVa8Xjy9U1vL4SXShOLCzGFxOlyhYlO2
 v/03vFUO5SK7W9nTK9Kgvz186ys9sGUH455mo0hWoVrObDXX+6wGfXAOyCuTNQ6BR0Me
 Kc6Q==
X-Gm-Message-State: ABy/qLbObZVFPeI20VBcttrpI5M3aCrvmpC4H6wIVoqdlQQtoNYxHFCC
 YJlTNR/FlsoNOVBmLIJktuVhgdhShYRZOaJ+4Lzc1WkZedDiH/tgt6jVo0x8GqlZUdvn51vrsTg
 mV8A5sriCovmvv9bs9ZGC5ALonvfdTE4=
X-Received: by 2002:a25:16c1:0:b0:bc9:1019:543 with SMTP id
 184-20020a2516c1000000b00bc910190543mr8677645ybw.58.1688402353406; 
 Mon, 03 Jul 2023 09:39:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPNVjHSxN63WVY0voLYGp5Z7Z7fYHxvJ3/vQ0qzLwM9VtSZjOJBDDytaKKJSiGK9TVUN2SmITZFE/6+6Lyna8=
X-Received: by 2002:a25:16c1:0:b0:bc9:1019:543 with SMTP id
 184-20020a2516c1000000b00bc910190543mr8677633ybw.58.1688402353185; Mon, 03
 Jul 2023 09:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686746406.git.yin31149@gmail.com>
 <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
In-Reply-To: <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 3 Jul 2023 18:38:37 +0200
Message-ID: <CAJaqyWeM9GmmRLtK50Z-UphWRv0u9OJkoJ3Dcvrz1BSiPNznew@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] vdpa: Return -EINVAL if device's ack is
 VIRTIO_NET_ERR
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 14, 2023 at 3:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> According to VirtIO standard, "The class, command and
> command-specific-data are set by the driver,
> and the device sets the ack byte.
> There is little it can do except issue a diagnostic
> if ack is not VIRTIO_NET_OK."
>
> Therefore, QEMU should stop sending the queued SVQ commands and
> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>
> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
> As a result, net->nc->info->load() also returns 1, this makes
> vhost_net_start_one() incorrectly assume the device state is
> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
> goto `fail` label to cancel the device startup, as vhost_net_start_one()
> only cancels the device startup when net->nc->info->load() returns a
> negative value.
>
> This patch fixes this problem by returning -EINVAL when the device's
> ack is not VIRTIO_NET_OK.
>
> Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa=
_net_load")
> Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Maybe we could split the fixes? Either way:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  net/vhost-vdpa.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 37cdc84562..630c9bf71e 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -651,8 +651,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s,=
 const VirtIONet *n)
>          if (unlikely(dev_written < 0)) {
>              return dev_written;
>          }
> -
> -        return *s->status !=3D VIRTIO_NET_OK;
> +        if (*s->status !=3D VIRTIO_NET_OK) {
> +            return -EINVAL;
> +        }
>      }
>
>      return 0;
> @@ -676,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>      if (unlikely(dev_written < 0)) {
>          return dev_written;
>      }
> +    if (*s->status !=3D VIRTIO_NET_OK) {
> +        return -EINVAL;
> +    }
>
> -    return *s->status !=3D VIRTIO_NET_OK;
> +    return 0;
>  }
>
>  static int vhost_vdpa_net_load(NetClientState *nc)
> --
> 2.25.1
>


