Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D218197D3
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:32:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFoFV-00012A-R6; Tue, 19 Dec 2023 23:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoFT-0000v1-O8
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoFS-00046C-5T
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUjg33+zXwkxGU7Jv83JARpJsi4jzyOEO4bwBMFXvgc=;
 b=EIke46QdqHeKRKs4K42Jm7BBCGbMnBQPWQP00H1JBmaSk3Z5nytELk0FlPbOZiKtkpthWJ
 zE1hJjKhG1guASoHCiKZOkBATqGDH2QSMGKT6JuSTFEwQfFKL7Vy3t0C5PKP4zyj91IPwP
 8sOsmy3QBHCJW+YSWUr2z6jqc7EF1mw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-qS9bL5czPBWjE6yAatt3rA-1; Tue, 19 Dec 2023 23:31:55 -0500
X-MC-Unique: qS9bL5czPBWjE6yAatt3rA-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-591627a8555so6376799eaf.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046715; x=1703651515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rUjg33+zXwkxGU7Jv83JARpJsi4jzyOEO4bwBMFXvgc=;
 b=Fk+aJElL6fMrvLyce36V6TQBgnwoxMaoTXaFO3l6GLAQaCTckDtC5LUlO/oZAO06KD
 Gaxz6Ty09Wrxhsq0NdH8PfuEhh4ZAE8LrhTHvs8v/mxOMrThUQUX9+9B+BGEu8j+4uaG
 Sa5K0bGpw4DPZeNXZGJVZgbMWU+bJZWgnJnygjYE86fVk6TYIcXH7Z/P9ACdPFhJ9SrG
 E7TIhsA2D17wKjxahF4vrOgni1bqP6uS1bnjSvggPJn0iDzrKP/IYCw920ALayoW7yEC
 S/0/r3yDyUvIPhcIMg7vg6P43IIj+Kj8JTQGTU4Oz8TI+CgLZS6R3uKHDKMGHNk9b5ML
 nB0g==
X-Gm-Message-State: AOJu0YzJSvKX193g+et4MQ8VxkIImi+85h8OgJod4qrbeE1t54KEXqJq
 mnrTy84FeFj7C+wXaSMYPxvx0BsYvBI+x4m1Fsbpfc/x+Jj7oZeOnCXWJXIBlumcKHw6qkZ+9HY
 X0GbYhNlwWpgglSSvM9n33emszPwC2C8=
X-Received: by 2002:a05:6358:2919:b0:170:982:5611 with SMTP id
 y25-20020a056358291900b0017009825611mr28675529rwb.32.1703046714888; 
 Tue, 19 Dec 2023 20:31:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCCofb+2PYtqGHskAF5rQjtSaiUmn6oB+PiFYs7PKvtSfm+N9yQsxbBri/GSrXydMp5sc5+DnVi7SCumlcZhg=
X-Received: by 2002:a05:6358:2919:b0:170:982:5611 with SMTP id
 y25-20020a056358291900b0017009825611mr28675511rwb.32.1703046714570; Tue, 19
 Dec 2023 20:31:54 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-6-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:31:43 +0800
Message-ID: <CACGkMEs1P-R=6n6i_uWTOexQup48teb8ZVwgnisxe_hUiq-DXA@mail.gmail.com>
Subject: Re: [PATCH for 9.0 05/12] vdpa: factor out stop path of
 vhost_vdpa_dev_start
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This makes easier to build an error path in next patches.  No functional
> change.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost-vdpa.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 57a8043cd4..449c3794b2 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1302,7 +1302,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *de=
v)
>  static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
>  {
>      struct vhost_vdpa *v =3D dev->opaque;
> -    bool ok;
> +    bool ok =3D true;
>      trace_vhost_vdpa_dev_start(dev, started);
>
>      if (started) {
> @@ -1313,8 +1313,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          }
>      } else {
>          vhost_vdpa_suspend(dev);
> -        vhost_vdpa_svqs_stop(dev);
> -        vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
> +        goto out_stop;
>      }
>
>      if (dev->vq_index + dev->nvqs !=3D dev->vq_index_end) {
> @@ -1333,6 +1332,11 @@ static int vhost_vdpa_dev_start(struct vhost_dev *=
dev, bool started)
>      }
>
>      return 0;
> +
> +out_stop:
> +    vhost_vdpa_svqs_stop(dev);
> +    vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
> +    return ok ? 0 : -1;
>  }
>
>  static void vhost_vdpa_reset_status(struct vhost_dev *dev)
> --
> 2.39.3
>


