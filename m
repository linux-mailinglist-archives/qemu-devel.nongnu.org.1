Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4D7B4F09
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:28:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnFCv-0006o6-DV; Mon, 02 Oct 2023 05:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnFCs-0006nA-P1
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnFCr-0000EJ-BX
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 05:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696238830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1z6qsXWnt+GruzDmBPUiEhcsak21PXnCsAoU/54TBt8=;
 b=bztBQP6niuvWi4Z0qnDNWW3OSpctboYSUggubvqf0NSjT5E+oyqX/INtMn1NaxZE+YNV36
 Ae9mfDRszcJiyVEBAFp4M/IGSdI+7NcGxY5Fqv5zpPvyLxrBgDmUNVcodCZyAWlM6evrxZ
 +9a6Ae2QYyPzq9rYEGqjDoFWv6fxyvs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-eJzMSgbfOlyxuJFGKDuKzA-1; Mon, 02 Oct 2023 05:27:09 -0400
X-MC-Unique: eJzMSgbfOlyxuJFGKDuKzA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5041bea78a5so21946210e87.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 02:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696238828; x=1696843628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1z6qsXWnt+GruzDmBPUiEhcsak21PXnCsAoU/54TBt8=;
 b=QCS9j/paMtrG0+t4nO59Ts+Nkx8Pf/0DtjlV++jvV6Bdz4M0i9NdTbV+ko2JtkUfRT
 8GqeRm0KAIWSxZQlO/9osbv/l0KR2iMvM4JYnCHBz4jP+TRTl822VrpkTTgwZIC8FdyW
 M3L4WEGUCeddhB32+5HnVjrrIo+vmRwbowGCi//dnnoIMRzQ8OWNuTZaYDJbwT3redTP
 zr11ex5xYKw7X3IUV875fOWg7EtzodeckWIqi3w4QFHB6wn6XuLKkAltUTiwKozgGQaC
 AN7yMrVWQpl4QHnzXELvuz77bouSjyfg7h8xGxEeP5P0PKwFYjWSsGvUWOIs2yirM7mQ
 GmqQ==
X-Gm-Message-State: AOJu0Yw9EvK0U8f2A7otpe6hP946yAPvFxeQwoPhS2wTD1GaLh1qtEd4
 53AdUPdz/Y3WzOkn2B+507dhsRyLfhpKWBu52v7aX4E8yNmWqPfR0qykUL6TJTDnwFuLlMC35ak
 PyAg9mpo+wlnEzkA=
X-Received: by 2002:a05:6512:324e:b0:500:adbd:43e9 with SMTP id
 c14-20020a056512324e00b00500adbd43e9mr8567158lfr.15.1696238827934; 
 Mon, 02 Oct 2023 02:27:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAFCJ3dVBLKKjgp1X8kU91U9/9Rm30zcxnIJSsw/zbWzgryweqWUnHlya2ymlhRza1/yedjQ==
X-Received: by 2002:a05:6512:324e:b0:500:adbd:43e9 with SMTP id
 c14-20020a056512324e00b00500adbd43e9mr8567151lfr.15.1696238827541; 
 Mon, 02 Oct 2023 02:27:07 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fc02e8ea68sm6769460wmk.13.2023.10.02.02.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 02:27:06 -0700 (PDT)
Date: Mon, 2 Oct 2023 05:27:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/virtio/vhost: check nvqs at dev_start
Message-ID: <20231002052550-mutt-send-email-mst@kernel.org>
References: <20230901122323.66183-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901122323.66183-1-aesteve@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Sep 01, 2023 at 02:23:23PM +0200, Albert Esteve wrote:
> While this is not expected to happen, it could still
> be that a vhost_dev did not set its nvqs member.
> 
> Since `vhost_dev_start` access the device's vqs array
> later without checking its size, it would cause a
> Segmentation fault when nvqs is 0.
> 
> To avoid this `rare` case and made the code safer,
> add a clause that ensures nvqs has been set, and
> warn the user if it has not.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  hw/virtio/vhost.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..78805fe5b7 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1935,6 +1935,11 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
>      hdev->started = true;
>      hdev->vdev = vdev;
>  
> +    if (!hdev->nvqs) {
> +        error_report("device nvqs not set");
> +        goto fail_nvqs;
> +    }
> +
>      r = vhost_dev_set_features(hdev, hdev->log_enabled);
>      if (r < 0) {
>          goto fail_features;
> @@ -2028,6 +2033,7 @@ fail_mem:
>      if (vhost_dev_has_iommu(hdev)) {
>          memory_listener_unregister(&hdev->iommu_listener);
>      }
> +fail_nvqs:
>  fail_features:
>      vdev->vhost_started = false;
>      hdev->started = false;

What do we want to return in this case?
ATM the value we return (r) will be uninitialized.

> -- 
> 2.41.0


