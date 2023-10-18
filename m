Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F17CE046
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7jM-0003ps-1z; Wed, 18 Oct 2023 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt7jG-0003pJ-UP
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:41:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt7jE-0001Ro-LY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697640055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRbO2H2P6MzOvYnJzmkxWGeWa2egnbgB6QkJouL37vA=;
 b=Trkdz7ZqmMkzzB7y12EWT/k674UCnjbaDdgby/QhUYic+1o1bIl9qjpaAnOG3cSC75WdOw
 4PA8FC5/Ijb9Vbc3ercxvE7ueuZEAEtnG00LNsHNn2WmlhxO0aTXXFL0MEX67dT1hESIj9
 mc/6ul1Eks+40PVE8fyICESx9gWK+Rc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-U3PxJiMaMnmXralhZNTkDg-1; Wed, 18 Oct 2023 10:40:53 -0400
X-MC-Unique: U3PxJiMaMnmXralhZNTkDg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079c865541so5092614e87.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697640052; x=1698244852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRbO2H2P6MzOvYnJzmkxWGeWa2egnbgB6QkJouL37vA=;
 b=gCGOK84UeKgGQ2JX6bl4r+vN5l7W1jTDUFxuW2GJJjiV+9pBSDWAs13LPKgrKkXRJX
 SRdux6IOgZICFJcB/5teOCI2+S5SNYufiO8Lk2GjPvIX8OfsDUtx6IK2SAgSU/4XTplK
 Eg22RVcBZY2Gnxfhf04MJOaL0qDuRtXdbmD6QNkVlCQmM9ATPAB/MidM4/5PxXpxaxTP
 QcFpYhrM4w/RaGazMGBYMFVvJwOv0YqoDY4lr47PQgvv7AlqOdKcjUHLOpfl62PbEWcr
 yIxX4CL2Xsqj9OVG3cOr0Y754TXRDEKafNGW2QDPC+hnjLPwCXIMNwZBtaPmWd9FESgw
 7yjg==
X-Gm-Message-State: AOJu0YxgcKvbWISFUSYVhq68+ZtCCeeywy8f3SzBkgKMGzxBKbSBbW4k
 /GjEWNjIrdWyfCNkop9Wb1T84Ob/tCwr2nL5F1wpAqHIpx0jFVsn6HOnmxOPaYoHxV9K8ZGd0HE
 dtJrTO/PMVRvia4AjFhUdgFGamA==
X-Received: by 2002:ac2:44cd:0:b0:4f9:586b:dba1 with SMTP id
 d13-20020ac244cd000000b004f9586bdba1mr3681278lfm.4.1697640052037; 
 Wed, 18 Oct 2023 07:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEynFvChxtdJK5uQ2f8W5ySl3eOek4Ntg0aHf2q3hJpO74qDEaHSF5T8mEnEKrXyaY9zaiPOw==
X-Received: by 2002:ac2:44cd:0:b0:4f9:586b:dba1 with SMTP id
 d13-20020ac244cd000000b004f9586bdba1mr3681263lfm.4.1697640051574; 
 Wed, 18 Oct 2023 07:40:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d50c5000000b003140f47224csm2284447wrt.15.2023.10.18.07.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:40:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:40:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Michael Tokarev <mjt@tls.msk.ru>, linuxarm@huawei.com,
 Fan Ni <fan.ni@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231018103907-mutt-send-email-mst@kernel.org>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 12, 2023 at 03:05:12PM +0100, Jonathan Cameron wrote:
> Establishing that only register accesses of size 4 and 8 can occur
> using these functions requires looking at their callers. Make it
> easier to see that by using switch statements.
> Assertions are used to enforce that the register storage is of the
> matching size, allowing fixed values to be used for divisors of
> the array indices.
> 
> Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fails with clang:

../hw/cxl/cxl-component-utils.c:130:9: error: expected expression
        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
        ^
../include/qemu/compiler.h:76:30: note: expanded from macro 'QEMU_BUILD_BUG_ON'
#define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                             ^
../include/qemu/compiler.h:74:36: note: expanded from macro 'QEMU_BUILD_BUG_MSG'
#define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                   ^
1 error generated.

See e.g.

https://gitlab.com/mstredhat/qemu/-/jobs/5320879531



> ---
> v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
>     error message.
> 
>  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd13..d1997a52e6 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>      CXLComponentState *cxl_cstate = opaque;
>      ComponentRegisters *cregs = &cxl_cstate->crb;
>  
> -    if (size == 8) {
> +    switch (size) {
> +    case 4:
> +        if (cregs->special_ops && cregs->special_ops->read) {
> +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> +        } else {
> +            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> +            return cregs->cache_mem_registers[offset / 4];
> +        }
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
>          return 0;
> -    }
> -
> -    if (cregs->special_ops && cregs->special_ops->read) {
> -        return cregs->special_ops->read(cxl_cstate, offset, size);
> -    } else {
> -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
>  
> @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
>      ComponentRegisters *cregs = &cxl_cstate->crb;
>      uint32_t mask;
>  
> -    if (size == 8) {
> +    switch (size) {
> +    case 4:
> +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> +        mask = cregs->cache_mem_regs_write_mask[offset / 4];
> +        value &= mask;
> +        /* RO bits should remain constant. Done by reading existing value */
> +        value |= ~mask & cregs->cache_mem_registers[offset / 4];
> +        if (cregs->special_ops && cregs->special_ops->write) {
> +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> +            return;
> +        }
> +
> +        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> +            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> +            dumb_hdm_handler(cxl_cstate, offset, value);
> +        } else {
> +            cregs->cache_mem_registers[offset / 4] = value;
> +        }
> +        return;
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
>          return;
> -    }
> -    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
> -    value &= mask;
> -    /* RO bits should remain constant. Done by reading existing value */
> -    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> -    if (cregs->special_ops && cregs->special_ops->write) {
> -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> -        return;
> -    }
> -
> -    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> -        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> -        dumb_hdm_handler(cxl_cstate, offset, value);
> -    } else {
> -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
>  
> -- 
> 2.39.2


