Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA9D7B72A3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmEJ-0006Mr-Nf; Tue, 03 Oct 2023 16:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnmEE-0006B0-Kx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnmE9-00042F-Vh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696365764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5iSdl4shBhdHRuvnmC2JCWg0NFez9D6Vp3+5JM1M05E=;
 b=etQiMarkItrjGR50RiyD33EysNsZZN3SHEpMkLmapSEsdUFZlL4RwIgp6uWaqFNcLmAPLE
 mEkfkEdbMpMpwBgcTS8AriVCt+AsFahVp/qWK6wiDwqWj9CxLiPyptDth9qek49zQEESyk
 2Bh4Z+r6VwrX/IrFqDQvcbarXHgxMTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-7Aqt-ZH2NO-qZLkkK8gZDw-1; Tue, 03 Oct 2023 16:42:43 -0400
X-MC-Unique: 7Aqt-ZH2NO-qZLkkK8gZDw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4030ae94fedso10296145e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365762; x=1696970562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iSdl4shBhdHRuvnmC2JCWg0NFez9D6Vp3+5JM1M05E=;
 b=X4xagtPfq/foE+bSYcTJPTNkAXngA6uwfj4FtCXj7EVmE1982I/pEysjOYuWpa//VV
 borQDZBwlJBJpRYdkk6zFE6pjQRkc+W57LlPsJMFY3IibPrTi34v6GSSVNa3guL01ORU
 ZCIVhrpLyz+JkzrQZSaFPSP8F5fHp113GVCtvU1Dgj7IOvxSz223ZfR3lbrElHduLa3V
 AM4xz9IBV3EzjpXeqooHPbCcTrdsmKyLER7G26MCPIDhSzai6WHKDF35uc49YWGUmwEI
 vB3fy+/sjMum5UBnQ0S/CGlQzOB8WNdOkeLFF63/v0x/w918lZSzusiLzpBaxJyTks18
 dYoA==
X-Gm-Message-State: AOJu0YymfuQqSEWAEsdPlHttHh8Zi4clS5soyUMVcEgIHtxvXa0W7ga9
 eWiAVRoc9w/cqkwICrAkmEHNjYg+y2TQe3zBvC3yo7JtensjZ3D8dCpF9DnqXy4kEAbnGqHwZ04
 aqPEc94G6S4K5cKw=
X-Received: by 2002:a7b:cb89:0:b0:3fe:15f0:dfbc with SMTP id
 m9-20020a7bcb89000000b003fe15f0dfbcmr516939wmi.12.1696365762012; 
 Tue, 03 Oct 2023 13:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwAS755C83DiWh2TIV4B0QREk83DEstPqqv7oVHBL3Y+EulZUl+rCFgdkaYZrNd6M/1OVjJw==
X-Received: by 2002:a7b:cb89:0:b0:3fe:15f0:dfbc with SMTP id
 m9-20020a7bcb89000000b003fe15f0dfbcmr516925wmi.12.1696365761644; 
 Tue, 03 Oct 2023 13:42:41 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c229100b00405959469afsm12283wmf.3.2023.10.03.13.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:42:40 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:42:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 linuxarm@huawei.com
Subject: Re: [PATCH v3 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231003163747-mutt-send-email-mst@kernel.org>
References: <20230919093434.1194-1-Jonathan.Cameron@huawei.com>
 <20230919093434.1194-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919093434.1194-3-Jonathan.Cameron@huawei.com>
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

On Tue, Sep 19, 2023 at 10:34:32AM +0100, Jonathan Cameron wrote:
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
> ---
>  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd13..7ef3ef2bd6 100644
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
> +            static_assert(sizeof(*cregs->cache_mem_registers) == 4);

In C currently static_assert needs a message.

In fact clang warns:
../hw/cxl/cxl-component-utils.c:75:67: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
            static_assert(sizeof(*cregs->cache_mem_registers) == 4);


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
> +        static_assert(sizeof(*cregs->cache_mem_regs_write_mask) == 4);
> +        static_assert(sizeof(*cregs->cache_mem_registers) == 4);
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


