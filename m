Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C774CAE2
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 05:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIhye-00035D-DJ; Sun, 09 Jul 2023 23:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhyc-00034r-HP
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhyb-0007Mk-3L
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688961255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7UGN+mrk5Gl1PDK4G3f4/W5zlh0VqtE0sPOSx1XBQHM=;
 b=Rpz7zkcb8PPm0IEYPcMHpXGX54djjFr5ALFzJFkWcoXwLDrEa53tuy98Munanrl7f9ADrT
 kV7cNE88h8YDCCczlGba+ZL5s37FYKFtlj4BjTnbDA9LRSEUErCJc/aIDPlMLOqHVyUY2d
 Fq3oQhIZQOvYBCl87sLE6rLqe0foZ68=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-QfazOknYPJKAGUop1RHYkg-1; Sun, 09 Jul 2023 23:54:12 -0400
X-MC-Unique: QfazOknYPJKAGUop1RHYkg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b704f6bbeaso37687001fa.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 20:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688961251; x=1691553251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7UGN+mrk5Gl1PDK4G3f4/W5zlh0VqtE0sPOSx1XBQHM=;
 b=dzw0heCtvEGM2WEsuHqvjdZ0qIeZhDUA8TgfxIJH5cmucBHvezSDPBNrYcs5JIulYb
 YKEn2pygddq4tB3zIPDG/Qy9E8YcaZtLBp27oO8G6hDD1AAQIp+uIMhByQXkFY5swy9H
 9v5QQtDQqh8dEXjwavXSnc9Vb+nJr15qNTWS3N9Nj5un2toq1wSyv1QjXp2mDisiV2B7
 Q9lY00SiX67fB1uFMLuRpwzRD8/ttiPyeI2FsELxS1faL4R4MZyR//6uRvbP9+YYYGMx
 uLm1vfWLH/AHtBxYDyaypnP6UD5NVmYJVlWQ+2lFSzujXnBDYOBoAYtiIcadlWKRgXoq
 QozQ==
X-Gm-Message-State: ABy/qLb8TiRcSSjA/Qi7m/651vPbxWhat4WE5Cv/NYq+dwicG9uFDV/c
 I7I1mCOTrCsqIecWjmDOb3JII5LeWfIq0OSL90xepJPaCOk7KaBU/otapNJFiXq8AE9ch9AIknU
 UM8B78F3xLcymdFNr0AcwjNp4GBsB7R4=
X-Received: by 2002:a2e:9a86:0:b0:2b5:86e4:558e with SMTP id
 p6-20020a2e9a86000000b002b586e4558emr9231840lji.38.1688961250923; 
 Sun, 09 Jul 2023 20:54:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFd9ScV71HK1OWBhW3UZTYbfhgSuQfpMgJYbHDdla95K/Ziawx2ANC3xtTAd41NL4D6ZAP42hilobYVsttR7qY=
X-Received: by 2002:a2e:9a86:0:b0:2b5:86e4:558e with SMTP id
 p6-20020a2e9a86000000b002b586e4558emr9231832lji.38.1688961250669; Sun, 09 Jul
 2023 20:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-7-eperezma@redhat.com>
In-Reply-To: <20230706191227.835526-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:53:59 +0800
Message-ID: <CACGkMEtjbYCGNLLO+HDhtbA7QqZALr-cEpkjX=ETy=j3eCkTVA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] vdpa: remove net cvq migration blocker
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Now that we have add migration blockers if the device does not support
> all the needed features, remove the general blocker applied to all net
> devices with CVQ.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I wonder what's the difference compared if we just start cvq first in
vhost_net_start()?

Thanks

> ---
>  net/vhost-vdpa.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index d5970e9f06..5432b50498 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -996,18 +996,6 @@ static NetClientState *net_vhost_vdpa_init(NetClient=
State *peer,
>          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
>          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
>          s->cvq_isolated =3D cvq_isolated;
> -
> -        /*
> -         * TODO: We cannot migrate devices with CVQ and no x-svq enabled=
 as
> -         * there is no way to set the device state (MAC, MQ, etc) before
> -         * starting the datapath.
> -         *
> -         * Migration blocker ownership now belongs to s->vhost_vdpa.
> -         */
> -        if (!svq) {
> -            error_setg(&s->vhost_vdpa.migration_blocker,
> -                       "net vdpa cannot migrate with CVQ feature");
> -        }
>      }
>      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index,=
 nvqs);
>      if (ret) {
> --
> 2.39.3
>


