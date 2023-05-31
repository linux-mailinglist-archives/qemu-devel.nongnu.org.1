Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599AF71731A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:23:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYH-0003vs-Jj; Tue, 30 May 2023 21:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AYF-0003vk-LW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4AYE-0005Cx-6g
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685496176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9GcfXlVJA1AfEI6RVgLhAKi3MekX5qoPrYs2eCYDjQ=;
 b=V7ZEaowvlQooCXloQdvbUdTBMSmmazd5AViuGxftQCe9VQprowHzh7gtJtT0oP1rDg+ShE
 amAhet41Ztea5PPUgQY5JKef6ba1GxSpt7qkdF5G6uyCl7Njc2MVGclVp7sVouRdCjLCmF
 fMVrgeEKkuHw0y5u1e4VcIzWwIE+JRA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-sOFqGM9mMsastXHsymOMow-1; Tue, 30 May 2023 21:22:55 -0400
X-MC-Unique: sOFqGM9mMsastXHsymOMow-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af23cfd23aso26802091fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496173; x=1688088173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9GcfXlVJA1AfEI6RVgLhAKi3MekX5qoPrYs2eCYDjQ=;
 b=hC8VsIOmnTG0jxt862QZFkQOPUsoTBxp3mnK1aj5NnM+Hkx7URtjmjOeT2YbKwBy6b
 PEPZikNRaGMRfWvZ2/Q+cCItPnYlwl5cBsumD+YeGq9AlrDflkcKtRWlpS42Ua+XPZE+
 +5HS1HM/7ZfPeGk+vIqmH8i7PjOvTtz0opsZREKx87QRfYpIYmTPWPOtJmZSym8f0gaU
 0ZeZCfMDos5IyY5XF0kT6t4jzmvCwEuiWCKrIw4iggkHDsGQmgA7ZGp0MiYLzwR5MHiA
 WFFZZMUTHuTE2RzcU9qb6v7Gf6A8R/0LIDIEA5WSkBd/pAO6hjqORzx8Dmvz7Po9eEzh
 zrjw==
X-Gm-Message-State: AC+VfDyqmaU4snMXgxMRYh38nKmmeHVlzM9vrKZzL53UeFyNDI0okpZU
 CuHDmYy+viIXt187wfDr9SfuD9mTOD5X8xkcpu/XFIaZ4r4xEo7gRHjaxVgGaqMfscAPeXpzLpe
 JB3FTs4XwKpIWBZG5XF+bimPQYQWoUr9pnJ3UWtWbWkMY
X-Received: by 2002:a2e:b16c:0:b0:2a7:96a2:7da2 with SMTP id
 a12-20020a2eb16c000000b002a796a27da2mr1782300ljm.49.1685496173202; 
 Tue, 30 May 2023 18:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xvPs91UIVA0kqHC2cjDFaNE86tZlLNEvQjRSNhGXpiwKauhF+wm+WzYO0+z3jh0atxTvAyu5F6faeACh6bDA=
X-Received: by 2002:a2e:b16c:0:b0:2a7:96a2:7da2 with SMTP id
 a12-20020a2eb16c000000b002a796a27da2mr1782294ljm.49.1685496172935; Tue, 30
 May 2023 18:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230529114333.31686-1-ppandit@redhat.com>
 <20230529114333.31686-3-ppandit@redhat.com>
In-Reply-To: <20230529114333.31686-3-ppandit@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:22:41 +0800
Message-ID: <CACGkMEt8Qe0SEnZCiF1sefLs+weG9UQQsjuM2tyY81BWHkCQyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost: release virtqueue objects in error path
To: P J P <ppandit@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, 
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 29, 2023 at 7:41=E2=80=AFPM P J P <ppandit@redhat.com> wrote:
>
> From: Prasad Pandit <pjp@fedoraproject.org>
>
> vhost_dev_start function does not release virtqueue objects when
> event_notifier_init() function fails. Release virtqueue objects
> and log a message about function failure.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Cc: qemu-stable@nongnu.org
Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  hw/virtio/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> v2: split a single patch into two.
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 6be4a0626a..1de3029ae7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1942,7 +1942,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>      r =3D event_notifier_init(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0=
);
>      if (r < 0) {
> -        return r;
> +        VHOST_OPS_DEBUG(r, "event_notifier_init failed");
> +        goto fail_vq;
>      }
>      event_notifier_test_and_clear(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
> --
> 2.40.1
>


