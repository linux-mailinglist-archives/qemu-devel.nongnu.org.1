Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A682A8B5
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:04:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNq2j-0001OY-P7; Thu, 11 Jan 2024 03:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNq2i-0001OQ-CN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNq2g-0001Sx-So
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704960237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JqomWg3P5JvDTKAPaHo96MpbiGHYLwZRQnt2Nb8E8lk=;
 b=Gi3u+hl2n1KMWIIS3NRqY4krF0wDUnGF0frBR8JXtFvhsCaLAn7FwQAAKZev/7LNheSe1U
 VKre+pExAX1GU4TY6IcBbFcP/fdS+CW4Xt5scaviP8XSoL4LZX5wK+ftRbs0R4q4/IkVKf
 CA8msqmnmpR7NJvweXhTuLP9afUh5P4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-GcXuntcyNfK8LEyONTtTVQ-1; Thu, 11 Jan 2024 03:03:56 -0500
X-MC-Unique: GcXuntcyNfK8LEyONTtTVQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3bd44263113so3026476b6e.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704960236; x=1705565036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JqomWg3P5JvDTKAPaHo96MpbiGHYLwZRQnt2Nb8E8lk=;
 b=DEdWLqNgznvfCPURVN1BhGGwp0GOc7TwNa9beo8arVr7KM+oEJSr/Fzgchb0SybeDu
 rz1aFs4/qjr6FfcpPgVWJ+cyDeg1ye+Xzpn0gk1MC2VVY8y+xdlXFiweM1jYxAN+z851
 kVGrC0Kuvb1IHAJM/SvvZ0juK98v/3wIkEY4oZZJdZ9Nu7Eb8quy461VPK/jCqgJ+EAg
 2IbZ9GhZAm8lW5+utIZa+r6gfk+AZEKsvko7RJYwy72E++E7HKcKwjuDZYY/WLXIMspC
 EKKUAD/Hy+JZofnCon53qKKrwmE5C6FZzTPdxpmkaV/XuOvmdCID/G/ON5VX9AcXJwUQ
 xrSQ==
X-Gm-Message-State: AOJu0Yw9gqa0eUAcBwccD7+YwWZnwZm49z3JyLsbD2y5ooXTpWVN5BhR
 LERoQe598bLt12dJcUvpUoUR8r1F5zQ/quGX1loPX6knwDNfDsfpy85JQoM/ETZ+rk6kh48RsnJ
 hYswH4+QgGW9yehQXfw5BYDHtJN3Nx/OgDgRTeI8=
X-Received: by 2002:a05:6358:4403:b0:175:7309:4228 with SMTP id
 z3-20020a056358440300b0017573094228mr891329rwc.37.1704960235893; 
 Thu, 11 Jan 2024 00:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk47JzPrhdX0ubFxPubV7Du1S1Sv/7gK8/czzaH1mFa3kaZZOy/hgZywmkILKjkTEoRctKqlMQ2ckwQNiZ0WE=
X-Received: by 2002:a05:6358:4403:b0:175:7309:4228 with SMTP id
 z3-20020a056358440300b0017573094228mr891316rwc.37.1704960235636; Thu, 11 Jan
 2024 00:03:55 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-12-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-12-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:03:44 +0800
Message-ID: <CACGkMEtR2fBhNjBBz16PpQA4XLt-WMCMCS=0G_6rnN0XibVghA@mail.gmail.com>
Subject: Re: [PATCH 11/40] vdpa: factor out vhost_vdpa_last_dev
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Generalize duplicated condition check for the last vq of vdpa
> device to a common function.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 30dff95..2b1cc14 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -593,6 +593,11 @@ static bool vhost_vdpa_first_dev(struct vhost_dev *d=
ev)
>      return v->index =3D=3D 0;
>  }
>
> +static bool vhost_vdpa_last_dev(struct vhost_dev *dev)
> +{
> +    return dev->vq_index + dev->nvqs =3D=3D dev->vq_index_end;
> +}
> +
>  static int vhost_vdpa_get_dev_features(struct vhost_dev *dev,
>                                         uint64_t *features)
>  {
> @@ -1432,7 +1437,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          goto out_stop;
>      }
>
> -    if (dev->vq_index + dev->nvqs !=3D dev->vq_index_end) {
> +    if (!vhost_vdpa_last_dev(dev)) {
>          return 0;
>      }
>
> @@ -1467,7 +1472,7 @@ static void vhost_vdpa_reset_status(struct vhost_de=
v *dev)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
>
> -    if (dev->vq_index + dev->nvqs !=3D dev->vq_index_end) {
> +    if (!vhost_vdpa_last_dev(dev)) {
>          return;
>      }
>
> --
> 1.8.3.1
>


