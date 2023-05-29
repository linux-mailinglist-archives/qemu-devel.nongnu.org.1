Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA3714CAE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 17:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3eSZ-0001NR-St; Mon, 29 May 2023 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eSX-0001NG-BJ
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q3eSV-00015J-Ui
 for qemu-devel@nongnu.org; Mon, 29 May 2023 11:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685372815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QyECeUFnqfCGWht9zNnIcrx+CNviwU3nx8zEvmwLOFA=;
 b=e8BlCWQVBVCsk7iUHlWtv7YDPqhHiNJ4ib0DqRKvKo46Tg4b6M6KLUUrrBWZsps3M1cYRC
 vCxMtM+5h96NPuFXvVg9IkrUyhwU5QRihaJx9Qupo/SQ7hZ/PrfZSuq89XTv7HOylrDIns
 AEefrH2wu/d6cIyEpmtWEvmf54lZB38=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-caZkha56OQuZcDDTQpwXag-1; Mon, 29 May 2023 11:06:53 -0400
X-MC-Unique: caZkha56OQuZcDDTQpwXag-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f830918d47so299751cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 08:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685372813; x=1687964813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyECeUFnqfCGWht9zNnIcrx+CNviwU3nx8zEvmwLOFA=;
 b=gmBZ0WIRRxe9eVDBZZhKZ0L72s9fl/76TPPPwg8ZBdV+8NmSf5jHf58oO5ixMul1rr
 JWbqS5n4R+SlZUI7NvGaLybQ1kAXuGDBJVbel+CkhfLRRzH0vUUmfFiD/9A4CVNTpQdh
 SRURdgpDBARcAC2BRKsiqq2qfEl9E+evMImaoJ4BXZHuU8HJyikUEAJhn8hoPZg6jC9+
 cXyDG+z20wb5XYZUhsq7EirHNP7DGZtCJMzt4cDVndQ0SjOtc9shKDwUw1T4WawcZs5t
 7np/3MuUbcDH+aNsnzxvDvzHBcu7GJFJViq/QyrV75Skw1ikuNDgCyGHiah0Qx1WP0n8
 xtAw==
X-Gm-Message-State: AC+VfDwIaSHGzXBnesuPoGGZS8X5Eza+7qDoltzHG9CLsC5aqowUUhVC
 RETIQQ7g5J4TeFC76fiH2MppXxWGrJq2tmD2rAKPO226MPzxUow8RDBxAz2ws6LcpKwKosJD4xY
 jEDCDkxKMqveSnPI=
X-Received: by 2002:a05:622a:306:b0:3f6:a7ad:9eef with SMTP id
 q6-20020a05622a030600b003f6a7ad9eefmr10986278qtw.1.1685372813277; 
 Mon, 29 May 2023 08:06:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4g95SFyxnzCmXVie+5xrbLSz6/BUSS5fv3reyIyACGROFywgy9GB5ll3bA24FGkG1LBx3oFw==
X-Received: by 2002:a05:622a:306:b0:3f6:a7ad:9eef with SMTP id
 q6-20020a05622a030600b003f6a7ad9eefmr10986252qtw.1.1685372812918; 
 Mon, 29 May 2023 08:06:52 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 q14-20020ac8450e000000b003e4f1b3ce43sm3906141qtn.50.2023.05.29.08.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 08:06:52 -0700 (PDT)
Date: Mon, 29 May 2023 11:06:51 -0400
From: Peter Xu <peterx@redhat.com>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael S Tsirkin <mst@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2 2/2] vhost: release virtqueue objects in error path
Message-ID: <ZHS/i/chxXONie49@x1n>
References: <20230529114333.31686-1-ppandit@redhat.com>
 <20230529114333.31686-3-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230529114333.31686-3-ppandit@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

On Mon, May 29, 2023 at 05:13:33PM +0530, P J P wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> vhost_dev_start function does not release virtqueue objects when
> event_notifier_init() function fails. Release virtqueue objects
> and log a message about function failure.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")
Reviewed-by: Peter Xu <peterx@redhat.com>

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
> @@ -1942,7 +1942,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>      r = event_notifier_init(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier, 0);
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

-- 
Peter Xu


