Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C797B6A8E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfSa-0007YT-QH; Tue, 03 Oct 2023 09:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfSY-0007YG-JS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfSX-0003nI-2H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696339747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QljlDRx19fm6UcffMVH+OKsL87Bd65yi+3egvlh6kac=;
 b=K8+UXKM8sOtXarC9ycdzw4Dm4tfJ12SCCjmbgJxpfFEXn734e/KJpzTSj7A4lL5/zkvg0m
 mBSyJtzYSMFwNoO8uKeC7k0OS1VBRiR6HCuk0mYdMMoi30gD3b4x+UkxswR4Ul9x+acdF5
 ayU1/H5nIXMD3EvgIhk15v4WNYW/5iA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-jp3NCP15ODOJ89ongp8Utg-1; Tue, 03 Oct 2023 09:28:50 -0400
X-MC-Unique: jp3NCP15ODOJ89ongp8Utg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso5987205e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339729; x=1696944529;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QljlDRx19fm6UcffMVH+OKsL87Bd65yi+3egvlh6kac=;
 b=R5czxtl1+jmXLxb3sSrTblYeILW3NRaZCcepmDDnbtXis2vfam9O59agCLc+OVmDhg
 /EHfklhbGHQg0NVZ6xzg5U52JUitw/CNo3jylXjJPmKen9JMnP8RF1RZxl9h7xjvnBwn
 WlYaEQRgSc7QO/WKhxfZxd3XHMb9snlcDG84yQBaIHWpLrZiacynCpXxOZ864pwKaILc
 HiFU0qjAhpafWo8JDMn+f34xu2CqBGauiymDWKykZNCTv2IMZLfhxUMit4T3lqzuex0t
 qt9C7eIL3+gtUL5GHNVY0O3eqebbbg5H0nXdQcpaRSGlfPjgyNAkfoXAy8LNgv33NXeY
 e7Wg==
X-Gm-Message-State: AOJu0YxDscTgXfX8xt4/GhfojTBlIhuXqVFzLIGtgR2cMuRGbKiNNuqu
 gZd6y00WKtG4WZp1DdiiEtyszZYVSX+ah0LrNXGP/ov/IUaSmxCVMX0H7TQ4zeSFX4UpHwTl676
 8rtmyjR3aQy8x0fs=
X-Received: by 2002:a7b:ce8b:0:b0:402:98cd:a3e9 with SMTP id
 q11-20020a7bce8b000000b0040298cda3e9mr12582281wmj.32.1696339729566; 
 Tue, 03 Oct 2023 06:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3SGxB1+KyZweuP6VhOtzVH8JFF4k3/4xt4jv8/YkpPajTwmQGkwmS88KSKxtOwDsSGVKIBw==
X-Received: by 2002:a7b:ce8b:0:b0:402:98cd:a3e9 with SMTP id
 q11-20020a7bce8b000000b0040298cda3e9mr12582271wmj.32.1696339729269; 
 Tue, 03 Oct 2023 06:28:49 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004054dcbf92asm1288791wml.20.2023.10.03.06.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 06:28:48 -0700 (PDT)
Date: Tue, 3 Oct 2023 09:28:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linuxarm@huawei.com
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Message-ID: <20231003092820-mutt-send-email-mst@kernel.org>
References: <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
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

On Mon, Sep 25, 2023 at 04:22:58PM +0100, Jonathan Cameron wrote:
> Rename the version not burried in the macro to cap_h.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

pls merge with the rest of local shadowing things.



> I had another instance of this in a series I'll post later today.
> Cleaned that up the same way.
> 
>  hw/cxl/cxl-device-utils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 517f06d869..bd68328032 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -283,13 +283,13 @@ static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
>  
>  void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    uint64_t *cap_hdrs = cxl_dstate->caps_reg_state64;
> +    uint64_t *cap_h = cxl_dstate->caps_reg_state64;
>      const int cap_count = 3;
>  
>      /* CXL Device Capabilities Array Register */
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> -    ARRAY_FIELD_DP64(cap_hdrs, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_ID, 0);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_VERSION, 1);
> +    ARRAY_FIELD_DP64(cap_h, CXL_DEV_CAP_ARRAY, CAP_COUNT, cap_count);
>  
>      cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
>      device_reg_init_common(cxl_dstate);
> -- 
> 2.39.2


