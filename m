Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EF07E78ED
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 06:42:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1KFo-0003rS-Vc; Fri, 10 Nov 2023 00:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r1KFn-0003pt-QG
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r1KFl-0002MT-7D
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699594823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmARn2TyvglsBPSh5qNgd7k7rRIl+efyMS5xWgxuYi4=;
 b=UhqMZw17a+YhRdzpNzp2DBYPuC2M6ZkzIglCzCWjOXGK3cxuEJfCfzJ5U/M1zwHEegm47y
 mOZsYWcji8D17aVJ8n48nKCe+e6DJdt0roRodN4rBapPICm7+ZA0GRu9cQeMtGi2cZ+czY
 nf0nfWXruoLGoFaSYrqFeHy7hr1VC7s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-69DH9f-RMLeAt0WBZ2xk_g-1; Fri, 10 Nov 2023 00:40:21 -0500
X-MC-Unique: 69DH9f-RMLeAt0WBZ2xk_g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9de267de2a0so127070866b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 21:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699594820; x=1700199620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmARn2TyvglsBPSh5qNgd7k7rRIl+efyMS5xWgxuYi4=;
 b=JDtyUf7HgvP7JERSIqWayIloYzVrQh3LjX2HUgwOD/OqarWmFowkQbLfvHMKTDGFos
 Buuo7ckFVrDdB6oOTN3Kal2UhTzYoowTR2EqwstQ5Oayvf/WSVRTPhcgUEZrGnVlWi8F
 y9xFE8DI3ig8wJG4LJHwiw4lFVb1xY1LKt+mv7eyjgV1GDflAi8sVyloTgTGLwkhokJ0
 09B/vJ1Mswq7UQ7jHeAuhjkx8BtJRVoaspTR61/0r8M7Pr6n6Th8c4JmaBcVwdJTSGoQ
 5Jh7BETUVuZ5g6P7cLSkqaODyzfy+Q00uycFQQx29LRFgmz8/k64F8UBUxOnoUCNmFpJ
 Zdhw==
X-Gm-Message-State: AOJu0YwsGX98ULwdiWYlelb8OBYrU7WmK3XkBAVX8X2mPIIkKn6bjrna
 /gsD9um6vkENYcrGQZe6EaCLhoTS3P+kwGE4zBp5ErgLFA7bcBvacnico352JyyL5q8wax608ib
 fVKKNIj7LVZqfPCs=
X-Received: by 2002:a17:907:97cd:b0:9be:562:a44a with SMTP id
 js13-20020a17090797cd00b009be0562a44amr5472880ejc.23.1699594820202; 
 Thu, 09 Nov 2023 21:40:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFruu8jbSkVgLIfg0YKQD9+KYFkMGZQh7DZgTBCCygZ1/QaSQo1ZKkNA3s5qteyGvBh2IR2OQ==
X-Received: by 2002:a17:907:97cd:b0:9be:562:a44a with SMTP id
 js13-20020a17090797cd00b009be0562a44amr5472871ejc.23.1699594819892; 
 Thu, 09 Nov 2023 21:40:19 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a1709061d0b00b009dd701bb916sm3427585ejh.213.2023.11.09.21.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 21:40:19 -0800 (PST)
Date: Fri, 10 Nov 2023 00:40:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Binfeng Wu <wubinfeng@huawei.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, wangmeiling21@huawei.com
Subject: Re: [PATCH] Fix segmentation fault when VM shutdown with virtio-gpu
 unplugged
Message-ID: <20231110003905-mutt-send-email-mst@kernel.org>
References: <20231110043916.1116-1-wubinfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110043916.1116-1-wubinfeng@huawei.com>
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

On Fri, Nov 10, 2023 at 12:39:16PM +0800, Binfeng Wu wrote:
> From: wangmeiling <wangmeiling21@huawei.com>
> 
> In the virtio-gpu unrealize process, the vdev structure has been cleaned up.
> However, vm_change_state_handler is not cleaned up yet, which is related to
> vdev. This handler will be cleaned up when VM shutdown, but the vdev is
> already a null pointer at this time, this will lead to segmentation fault.
> 
> Signed-off-by: wangmeiling21@huawei.com
> Signed-off-by: wubinfeng@huawei.com

You need to add your real names, not just email.

With that:
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/display/virtio-gpu-base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 37af256219..b31b8d683f 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -252,6 +252,8 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
>  {
>      VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
>  
> +    virtio_cleanup(VIRTIO_DEVICE(g));
> +
>      migrate_del_blocker(&g->migration_blocker);
>  }
>  
> -- 
> 2.20.1


