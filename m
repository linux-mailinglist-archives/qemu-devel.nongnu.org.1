Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AA2724340
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WD3-0005Ab-5Z; Tue, 06 Jun 2023 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6WD1-0005AS-KU
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6WD0-0005OH-4u
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686056085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uls5QYOLUHZS8PZpsFVXe1vsFwtQDSKjiD/6HNuysKs=;
 b=astRgznk/6ZVKCBXkshYPdZzHdYnsDjYNwf2A2DFGbssrw8tK3DvQD7Ok+4oeTa1geZpkF
 GmghaAyuoNvO1+HayFgJvG3gAWu0vHtdiopEnZeiB6hZLSiUg7/1TTCcCnmSXT9/fgFBM2
 7asgEZSOdMQT1GNasKubHXwpkuH67r0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-YMELBEQmMpSWtxjv6jBj0w-1; Tue, 06 Jun 2023 08:54:43 -0400
X-MC-Unique: YMELBEQmMpSWtxjv6jBj0w-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-77703efb26dso477571739f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686056083; x=1688648083;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uls5QYOLUHZS8PZpsFVXe1vsFwtQDSKjiD/6HNuysKs=;
 b=IV1T1wGpGSWvH4sxaGcNr6UxqvKWaK5YRJqUGOd5RnTJ/iRZb3KTBQiSvbvavE8GIh
 QCJUogt8e9wzsmVTWM5Gpda96FGozZNG2okqQMOrpIleZR5xjPXb4jT/UIcasfnqQJIy
 OieIaaJ6x9vdymOzvBudNF5N/nnSljpt/+MrdrNP8ALeFewhZYa1sHqlrgNjQFJY/POc
 o60ungHnM+QOOBrN7GmenKlJIVrB1dWQFnNlfBBBhGDhTNPtyqoNHB3157I6fKi4tnLX
 jmAbyat3OTNQoS3qDLjFj6si9/YN8iqa99tx8xQ/Y11mW2hARIL+P2pRslIE3GIdJCKi
 2BJA==
X-Gm-Message-State: AC+VfDwlr1D0ZF19NE8ncN/xqjUSdafE6kFE7tfgnTRrZJkkyXQ7Y1nl
 L6Qmub+sKlDLeKaBxD96Ah8OYRzF5VfVCdDAuGZA3HmU1KkURvFaAMeAvGRwfZ2Zu9hrosf+Qe3
 k3gZ+2a0OlOYW+oU=
X-Received: by 2002:a5e:dd45:0:b0:753:ca30:6bb0 with SMTP id
 u5-20020a5edd45000000b00753ca306bb0mr3597134iop.4.1686056083168; 
 Tue, 06 Jun 2023 05:54:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69tuJxeqBOBgdKtBiZt+tcbRVKSkpi/Pv+HM/WQERByEW7lS3NoawouRCNWV9e7DZWuLwv6Q==
X-Received: by 2002:a5e:dd45:0:b0:753:ca30:6bb0 with SMTP id
 u5-20020a5edd45000000b00753ca306bb0mr3597123iop.4.1686056082939; 
 Tue, 06 Jun 2023 05:54:42 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 i13-20020a6bf40d000000b00776a991d35asm3094338iog.14.2023.06.06.05.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 05:54:42 -0700 (PDT)
Date: Tue, 6 Jun 2023 06:54:41 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: <ankita@nvidia.com>
Cc: <jgg@nvidia.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC v1 4/4] qemu: adjust queried bar size to power-of-2
Message-ID: <20230606065441.170333b5.alex.williamson@redhat.com>
In-Reply-To: <20230605235005.20649-5-ankita@nvidia.com>
References: <20230605235005.20649-1-ankita@nvidia.com>
 <20230605235005.20649-5-ankita@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, 5 Jun 2023 16:50:05 -0700
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> The GPU device memory is reported to the VM as a BAR. The device memory
> may not be aligned to the power-of-2, but the QEMU expects the PCI BAR to
> be. Align the reported device memory size to the next power-of-2 before
> QEMU does an mmap.
> 
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  hw/vfio/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4d01ea3515..bb49200458 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2061,7 +2061,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
>  
>      region->vbasedev = vbasedev;
>      region->flags = info->flags;
> -    region->size = info->size;
> +    region->size = info->size ? pow2ceil(info->size) : info->size;
>      region->fd_offset = info->offset;
>      region->nr = index;
>  

Nak, this means our kernel emulation of the BAR is broken, a BAR that
is not naturally aligned is not a PCI BAR.  PCI BAR sizing through the
BAR register still needs to work via the kernel interface alone.  It's
clear now how the kernel resizing the vma on mmap was a hack around
userspace mangling the region size.

Maybe this needs to be exposed as a device specific region, which then
userspace emulates as a BAR for the VM facing device rather than the
kernel emulating it as a BAR.  Thanks,

Alex


