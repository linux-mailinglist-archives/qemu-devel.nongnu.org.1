Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49C27E2B02
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:35:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03VC-0000lp-Us; Mon, 06 Nov 2023 12:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03VA-0000lO-DH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03V8-0004GH-Po
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0F7BYeNOF8ehL/D4gkovhRx9kFJUvRloafDKG+KV9Qs=;
 b=IZIYQZU5oTrrLtlVwQ7cHb7UDimzyPgGWH7dCzb+/dLIFrUwu5YEgdzXCYuodUezOWQJKG
 EQSVRKlFlLSaocWhhAnbKtrxOZGRD7hXchSLJR4cmb6jh2l/9KAPBDfTYCPGFHnOwLFJ0c
 LWsi1ueBMdy3FrLd3BYI0SZmKv6ZvD4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-cGY9ojxgPnqQ3SCUL0BvrA-1; Mon, 06 Nov 2023 12:34:49 -0500
X-MC-Unique: cGY9ojxgPnqQ3SCUL0BvrA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079fe7cc7cso5399244e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:34:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292088; x=1699896888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F7BYeNOF8ehL/D4gkovhRx9kFJUvRloafDKG+KV9Qs=;
 b=wzh1Zn/TJxViQZyLHDp6u6NOCISvg0Dq3m2sPH9Lec68FDZQbZhU8DBYLLf8CBDSif
 B5LzamVm1L2dpn9dc9DkOKYD9fUR3rZ4iR0KGuM5YchjcTfXOVNz5j4qLfZeueAgC8tT
 mymUU+D28P0xSkMYcIDyot3GDtrMJYGBbHp3c2oHkCqx2F+yKhLkip5eARujZLj7TJWr
 9WG0+tN4tVxrdZ1/rBWxxIsmC7O3RQWYawCrSMcg2xog9p8VibEH0oSM5G0uZRmQk7du
 iKWWRXecHZYvJnYCwekKColxDQbPPwU8mTObMW+ipPXKJIUbkaZJx7hvbbOf1alewAZG
 5PqQ==
X-Gm-Message-State: AOJu0YzrOhikKvRmqjameyldFXbv/cBNwbqjsvY91NAfViaGmDNdcqZT
 aryFkrmCvsCo4YFljBiQVXTc9lP/KrdcEzoX0Z26F0IsbkicujO/qb5YbJGiFpOvlvuUOFSzF7d
 3X/kkSFDXUuS36xM=
X-Received: by 2002:a05:6512:3d8e:b0:507:9854:3b95 with SMTP id
 k14-20020a0565123d8e00b0050798543b95mr26558012lfv.14.1699292087845; 
 Mon, 06 Nov 2023 09:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZMTjB26C1diZGoFeNLxgYBVnMxlXsc4nebZG5PB3sxJLm94VLYljqXtBHK1quSN+q8FVBzQ==
X-Received: by 2002:a05:6512:3d8e:b0:507:9854:3b95 with SMTP id
 k14-20020a0565123d8e00b0050798543b95mr26557991lfv.14.1699292087456; 
 Mon, 06 Nov 2023 09:34:47 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 e14-20020a5d530e000000b0032daf848f68sm161956wrv.59.2023.11.06.09.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:34:46 -0800 (PST)
Date: Mon, 6 Nov 2023 12:34:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: viresh.kumar@linaro.org, lulu@redhat.com, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: rng: Check notifier helpers for
 VIRTIO_CONFIG_IRQ_IDX
Message-ID: <20231106123302-mutt-send-email-mst@kernel.org>
References: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Oct 25, 2023 at 11:18:41AM -0600, Mathieu Poirier wrote:
> Since the driver doesn't support interrupts, we must return early when
> index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
> did for "91208dd297f2 virtio: i2c: Check notifier helpers for
> VIRTIO_CONFIG_IRQ_IDX".
> 
> Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

So vhost-user-rng is now switching to use the generic base device.
Alex could you help suggest how to rebase this on top of your series please?

> ---
>  hw/virtio/vhost-user-rng.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user-rng.c b/hw/virtio/vhost-user-rng.c
> index 201a39e220c5..62142b717f73 100644
> --- a/hw/virtio/vhost-user-rng.c
> +++ b/hw/virtio/vhost-user-rng.c
> @@ -129,6 +129,14 @@ static void vu_rng_guest_notifier_mask(VirtIODevice *vdev, int idx, bool mask)
>  {
>      VHostUserRNG *rng = VHOST_USER_RNG(vdev);
>  
> +    /*
> +     * We don't support interrupts, return early if index is set to
> +     * VIRTIO_CONFIG_IRQ_IDX.
> +     */
> +    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
> +        return;
> +    }
> +
>      vhost_virtqueue_mask(&rng->vhost_dev, vdev, idx, mask);
>  }
>  
> @@ -136,6 +144,14 @@ static bool vu_rng_guest_notifier_pending(VirtIODevice *vdev, int idx)
>  {
>      VHostUserRNG *rng = VHOST_USER_RNG(vdev);
>  
> +    /*
> +     * We don't support interrupts, return early if index is set to
> +     * VIRTIO_CONFIG_IRQ_IDX.
> +     */
> +    if (idx == VIRTIO_CONFIG_IRQ_IDX) {
> +        return false;
> +    }
> +
>      return vhost_virtqueue_pending(&rng->vhost_dev, idx);
>  }
>  
> -- 
> 2.34.1


