Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5786831247
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:10:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKee-0000vp-RD; Thu, 18 Jan 2024 00:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQKec-0000vL-G5
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 00:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQKea-00071G-UV
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 00:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705554563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNEXmz7mVVM07cddH1v8gDu1apzTRSKKHG2AE8VIMdA=;
 b=inl4fwz3312gvFb15NlhXt8p/r0E1hZIvZRfiZeoXdqBwLDEtj+IV4diYtfTIGOpwBSxAD
 kE9DrOYMaM/zBbQGIP4CN3xzHGGOCr+f2vQ+huvM3xdYpWJngC7tJJ+W8Tna3A+wrYmM6R
 m39g74eCcRyN1aGvL/xMGd32K6Z/sFg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-YEsjJSXzNCqz6WENbWJMhA-1; Thu, 18 Jan 2024 00:09:21 -0500
X-MC-Unique: YEsjJSXzNCqz6WENbWJMhA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d5a4416df4so15975785ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 21:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705554560; x=1706159360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNEXmz7mVVM07cddH1v8gDu1apzTRSKKHG2AE8VIMdA=;
 b=IJEiJIgS7GFBTuqN+s49h9kDl4TWAe0SihUN9Vw5C6x0ms9LL6+wgiqjDqahVVYPzN
 KOodXkc9mJMwLB91TuKkohOoC9SkTnUa0334MR2yod4Xpo/UQTwBrLGfS48hbI/Zom1y
 XEohGk+VA+nPRXFPT7ExKW1WWXeqcq5dLd0bWcLyhgrgGLv76ljJ9EBb/J7DiJAijcGh
 sH9E/KldvPeaimf1eT0+uwLmzdJS/1FE2l8jEKVk04KouGeCzvncSlWvSnnS6kgctWF+
 sXzx9bioFP4LUFDpEqWPvHVh8r1sAsjzl7q6DVju7/WbHI+7/pc6ZqWkJsosoYIOlg2h
 1WSw==
X-Gm-Message-State: AOJu0Yxycv1APPmJBOP9wyw4sNWAr3HVeV1iWbOGm80GEHYcqD1n5MRT
 AfBFhrmiRiztTxbOjwshl8t7drxKaz+5zgJn7rRcpwfGziA3D9hVQSXYMJ5ywKgkGPdoc9IoKf9
 gPedCTIJaNMbUQn1/cxEE/7QQS7+uH3rq/EvmgD/obIjeyXfuZUvDAsdWDdQ3
X-Received: by 2002:a17:902:ee13:b0:1d5:efd6:20f with SMTP id
 z19-20020a170902ee1300b001d5efd6020fmr685190plb.1.1705554559899; 
 Wed, 17 Jan 2024 21:09:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI4GJHBiEu9UI/u1dVexs1frIl7lhKoOis3EyNjrxWQmCpUu44ZHPXP7ayrwjlwqVmqfIvUg==
X-Received: by 2002:a17:902:ee13:b0:1d5:efd6:20f with SMTP id
 z19-20020a170902ee1300b001d5efd6020fmr685178plb.1.1705554559576; 
 Wed, 17 Jan 2024 21:09:19 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 az8-20020a170902a58800b001d5e993c6b9sm492014plb.68.2024.01.17.21.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 21:09:19 -0800 (PST)
Date: Thu, 18 Jan 2024 13:09:16 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] vfio: use matching sizeof type
Message-ID: <ZaiyfDX2-hUUynhp@x1n>
References: <20240117160344.175872-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117160344.175872-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 17, 2024 at 05:03:44PM +0100, Paolo Bonzini wrote:
> Do not use uint64_t for the type of the declaration and __u64 when
> computing the number of elements in the array.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/vfio/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0b3352f2a9d..0da4003ecf5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1118,7 +1118,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>  {
>      uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>                          sizeof(struct vfio_device_feature_dma_logging_report),
> -                        sizeof(__u64))] = {};
> +                        sizeof(uint64_t))] = {};
>      struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>      struct vfio_device_feature_dma_logging_report *report =
>          (struct vfio_device_feature_dma_logging_report *)feature->data;

There seem to have other places in the sme file that reference __u64.  Are
we going to remove all __u64 references?  Or maybe something else?

Copy Alex/Cedric to make sure this won't get lost..

Thanks,

-- 
Peter Xu


