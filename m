Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7727A4536
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiA2i-0008Oc-9v; Mon, 18 Sep 2023 04:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA2V-0008O6-4g
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qiA2S-0000HE-Bs
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695027326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mz0EY1lphbgfKba1RXf7Tv60j/XnpkugXGjgAh3hHJg=;
 b=aZ7DF2peLU8A76loLqU8/G/1dMmtQUQDovR02hbqSvdeeX3D4JDUwD2YLfv1Srl6Q7pQQQ
 JPF3tYqvWPl/yPvAY4Ok5rEcBF7RQtpBgIM0obW4E1Ssfn0+yCKtqkJxz9Ph7WS6m1Gxu8
 QGTecO3Nml4Q4GxchQmf85MLLi+V+OE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-AkG_sUKCNByyVWC1LTMkjg-1; Mon, 18 Sep 2023 04:55:24 -0400
X-MC-Unique: AkG_sUKCNByyVWC1LTMkjg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bbc1d8011dso49679701fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695027322; x=1695632122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz0EY1lphbgfKba1RXf7Tv60j/XnpkugXGjgAh3hHJg=;
 b=QROmmh1qOsaJyuVfFrUreVnh442OqBVIAyUSxFUBwysdGOlUg3Tjd0yoOu3kyD3PRd
 70rXNkE+698nAE0prA2DNAREICvSsMnGCyz14c3bnu7DSLWx+zhG94stMyI3lC99b/L6
 NYRTBN8VF5SepYmL8Au8PdgVo3MnvoS8WxRodNK6bsNkQ1lcKY6hBkYUCaFtjEi4wfMK
 pM/vXJE/kGFDmVPCJVDcIFq9Q4DKjcY/QhJO0XJRWtl18gwpJCftaDDeUwSWJuiSa6nt
 HONQ/I+5KFhaBT252nOH6AcAU9XW5ZYfGRVug5qLMiZivqJuaTgJ3DRk8OBQtgpuKDdm
 41og==
X-Gm-Message-State: AOJu0Yzqe2CSr/PglQwCoVQcMVjLWFIc9H5opQGw9kvKJsjiVoouiUak
 sdfdgbBTAkWfahaYkUcPlXxsUVmEERTJ5SGATNAVs+F2/6+GjgxfJ6NmUnGv3ZkXkiIRQVLE0v3
 sT1nmOtt3BduYeSCg8dsJbyWM8yQ/XjJQFTREkOl6Pw==
X-Received: by 2002:a2e:93c2:0:b0:2bc:da4a:4649 with SMTP id
 p2-20020a2e93c2000000b002bcda4a4649mr7583886ljh.22.1695027322087; 
 Mon, 18 Sep 2023 01:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHup+fhRRDsOcEumEsa09Ba4M6/0FOhTw3MAwZRLxb5q73q+Q1P4Qam4WrZMbsIr0XfSgZfrb6IK74bYnRg4QQ=
X-Received: by 2002:a2e:93c2:0:b0:2bc:da4a:4649 with SMTP id
 p2-20020a2e93c2000000b002bcda4a4649mr7583867ljh.22.1695027321808; Mon, 18 Sep
 2023 01:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230915170322.3076956-1-eperezma@redhat.com>
 <20230915170322.3076956-2-eperezma@redhat.com>
In-Reply-To: <20230915170322.3076956-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:55:10 +0800
Message-ID: <CACGkMEutx4om5e1GXcDR3i39GJ3TivTKJyM1KTBt4a-Sf7MMsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa net: fix error message setting virtio status
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, si-wei.liu@oracle.com,
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

On Sat, Sep 16, 2023 at 1:03=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> It incorrectly prints "error setting features", probably because a copy
> paste miss.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..9845e2db9c 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -1293,7 +1293,7 @@ static int vhost_vdpa_probe_cvq_isolation(int devic=
e_fd, uint64_t features,
>
>      r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
>      if (unlikely(r)) {
> -        error_setg_errno(errp, -r, "Cannot set device features");
> +        error_setg_errno(errp, -r, "Cannot set status");
>          goto out;
>      }
>
> --
> 2.39.3
>


