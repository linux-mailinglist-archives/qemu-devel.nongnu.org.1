Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 668627B9C8A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 12:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoLn5-00074a-IQ; Thu, 05 Oct 2023 06:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qoLn2-00074F-HK
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:41:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qoLmx-0000gQ-Sx
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:41:08 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-504b84d59cbso1063277e87.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1696502460; x=1697107260; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=elJ0Tzj6T7qM2spwIIeOqzynuJZr3Ab3gERMDu8A5G8=;
 b=uDjMigYxtcq+yqRziI0NlrrHmOJ/Hwbj1FQgX2jmpHeAn/7bN6ajn9O5TZhxDKgI9g
 PetoVHGXbZKcM5dPiLvaXC2EsMXWhV84DSiAe8Xt3A3nzK5VHC8JpBs0AV8AW0udhDr4
 MlNN2z5U6VWNiIRPg05rvR5Kf9en4F9rUWFm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696502460; x=1697107260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=elJ0Tzj6T7qM2spwIIeOqzynuJZr3Ab3gERMDu8A5G8=;
 b=VxEE/Fy2hcOY13BubnyWqxiulH3vO8h6h/2Mk7hAH/SMqnI8d2Oy4cePsBFz8RAWQ1
 7ky7GA8WjJzfpXCT8NqlyX8tqBX/k4xUvpIUIArHW1ZkaU0sF3aKzMMZqEKoyRLnjuZ6
 LL1FAoUimRVeBSb4JQ88Yup/oM8MGT8Km/sfFQO5MYr469bcNLxY4X9iRaC2LNa6rOa4
 PiTJ2KI70rW3u+NgQKD3clKkd5iZnrGbPI6t2TtEn/X5FiKYFXThShYtanUaUIHt9au7
 rvVzel4zvrEPxaWrdlOZPe5U9nZLBkdw5A0T/nO+ZnQS/2ygQNcyCqsYTdasQeEmsjkO
 IRKA==
X-Gm-Message-State: AOJu0YzvoW+pSnF7jZMgALnZLh6bLI8w3ahE6a3iEhw4LdY5YcHXe9w4
 9p/KUT3iFCQfGLwruk8QDyXDjw==
X-Google-Smtp-Source: AGHT+IG4uRnJ5/h4OL8IQ3dapEHs799vm2iduRA3BIQdiOhLrJ0RIa1js4UwuDHq4+rRat304vPV/Q==
X-Received: by 2002:a19:3807:0:b0:504:4165:54ab with SMTP id
 f7-20020a193807000000b00504416554abmr3683664lfa.56.1696502460429; 
 Thu, 05 Oct 2023 03:41:00 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 l34-20020a05600c1d2200b003fef5e76f2csm879911wms.0.2023.10.05.03.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 03:40:59 -0700 (PDT)
Date: Thu, 5 Oct 2023 11:40:57 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [QEMU][PATCH v4 1/2] xen_arm: Create virtio-mmio devices during
 initialization
Message-ID: <9f3aad26-0233-4987-9fb0-cfcf8d424ef4@perard>
References: <20230830043518.21584-1-vikram.garhwal@amd.com>
 <20230830043518.21584-2-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830043518.21584-2-vikram.garhwal@amd.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=anthony.perard@cloud.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Vikram,

This patch prevent QEMU from been build with Xen 4.15. See comments.

Also, why didn't you CC all the maintainers of
include/hw/xen/xen_native.h?

On Tue, Aug 29, 2023 at 09:35:17PM -0700, Vikram Garhwal wrote:
> diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
> index 4dce905fde..a4b1aa9e5d 100644
> --- a/include/hw/xen/xen_native.h
> +++ b/include/hw/xen/xen_native.h
> @@ -523,4 +523,20 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
>                                                   enable);
>  }
>  
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41500

xendevicemodel_set_irq_level() was introduced in Xen 4.15, so this
should say '<' and not '<=', otherwise, we have:
    include/hw/xen/xen_native.h:527:19: error: static declaration of ‘xendevicemodel_set_irq_level’ follows non-static declaration

> +static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
> +                                               domid_t domid, uint32_t irq,
> +                                               unsigned int level)
> +{
> +    return 0;

Shouldn't this return something like -ENOSYS, instead of returning a
success?

> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 1d3e6d481a..7393b37355 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> +
> +static void xen_set_irq(void *opaque, int irq, int level)
> +{
> +    xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level);

So, you just ignore the return value here. Shouldn't there be some kind
of error check?

And is it OK to create a virtio-mmio device without an error, even when
we could find out that it never going to work (e.g. on Xen 4.14)?

Cheers,

-- 
Anthony PERARD

