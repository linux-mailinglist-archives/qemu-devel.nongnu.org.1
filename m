Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AD3BC7BB6
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 09:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lBO-0006Dh-OW; Thu, 09 Oct 2025 03:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6lBK-0006Ci-M1
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v6lBE-0002jk-94
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759995309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7jkJKIyCQZUOUmliAFhrxent9CoMlBDIqbMogANMID4=;
 b=e5yAXhNSUwQWC2x7fcXaKePgLzD9+zHxpgUX1i0Mi1U6Xn9xOI7aFin2RUnIlhbE97ZYVx
 zht1L8T1AtuSqQcnM4VnXFBTnKADnFe5KvBEtnWn91zJ1DrEKSLbAH0CxLUg3+udy5UYZu
 5u7WviHo9AsxBj1420OOE/R3iYONjo0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-E3gnG_lNNpuD0Kw8GU1m3g-1; Thu, 09 Oct 2025 03:35:07 -0400
X-MC-Unique: E3gnG_lNNpuD0Kw8GU1m3g-1
X-Mimecast-MFC-AGG-ID: E3gnG_lNNpuD0Kw8GU1m3g_1759995306
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e502a37cdso4364165e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759995306; x=1760600106;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jkJKIyCQZUOUmliAFhrxent9CoMlBDIqbMogANMID4=;
 b=XEA0BO7/Ed8ej4naDGREX4keod30B5cNwQA8MtHK/hTvHGbzCezPg/VzbwrvPNkCxe
 8snl7u4xhBLUYRWTJZxtSbxOMMdli8bqRT1fsTGlwf8x5kLAqYR2+r3ylJPh61DW8GT8
 4KBeGBDotTTTKlrPclSOLEAMB+0m7ZqMogohyrxMrAZkmHYh9kkqmAxw0dUU/jsNrVKt
 Rs6hrGiGFHcRQ60eDI+jpVVhTxzpKDXReB/63tYde61Jhlwf8pH4O9ZnBv+DHKO+udMg
 u1YplZ0ZXV9baHnw4nFyjT74enGGin8m83F5At/mnyH0HAKu79WtXvSF6Sdqojxb5WdG
 PMCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyRnP6oH6hYp/PHMUo58zhCQen+IAEI4k0DdELcNOGxa9GSXlvraOTxvG4pxe9XYxJBpKasHemVxOL@nongnu.org
X-Gm-Message-State: AOJu0YyvJd7cWUZNcyNRQ0jOvXFGwoM/NK1tOTQZRh0OLoDwtZZr95G9
 mlV6CD65NrJFeLMlXXICEFielOoR6BTGhId3Jn6V9x2oblUOQhqJsoYv0FhLQvX0LE2nna9Vv7c
 D/C9JdHqSfD3jhWSRqdn/RiH2ZuSh6eIp7N0zAxGaovjtamm6bpiByvwW
X-Gm-Gg: ASbGncsu/rk2gk8pA2o/sY4ay55NUtVfpRJ+xxTwv2h2M2jclgGnC8Din+xA4cyYWlw
 +X3uCwJo/FlwhkBffgTfnMWPkkQW+HFuTc30QJHIY1dctpZcHNEPL40j41MJtKN+N7bu887mX7n
 2JwQ5dAu9rp3SUDIDMgcbOqCH4HMIXuX8WAl1T//kaHAOumcesTMVVNcu7sW2Lxt4bwOKz2tJDD
 LnSqrZ1LrUnAPscqWw7jfotmdsuM1keHtpZf/XKNwGkpweWjfXZ6kAZ3RVxGVCtUgoV+hUPU2gM
 hUreVubnXnfBnVGNgK43D1BxrB/iE7S7Qr+1QNKMhf0SXCAxLUakOEbKGRGK49RlKd9QEQ8E6Gt
 VjmmsnXOf
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46fa9b092ddmr39139165e9.32.1759995306281; 
 Thu, 09 Oct 2025 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGzoiFjIO/UbHIE91l2EcsGBDJ3+YrCecv3PEHuLJAHr70B1yVD2s0sFEmGCesgtDx1CjPgQ==
X-Received: by 2002:a05:600d:41f3:b0:45b:7be1:be1f with SMTP id
 5b1f17b1804b1-46fa9b092ddmr39138995e9.32.1759995305858; 
 Thu, 09 Oct 2025 00:35:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf16abf6sm33606385e9.12.2025.10.09.00.35.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 00:35:05 -0700 (PDT)
Message-ID: <43001ff8-b4d2-44ab-b4c4-c2cf6d5d99d8@redhat.com>
Date: Thu, 9 Oct 2025 09:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Optimize unmap_all with one ioctl()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, levon@movementarian.org
References: <20251009040134.334251-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251009040134.334251-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/25 06:01, Zhenzhong Duan wrote:
> Currently unmap_all is split into two ioctl() with each unmap half of
> the whole iova space.
> 
> IOMMUFD supports unmap_all ioctl() from beginning, after kernel commit
> c19650995374 ("vfio/type1: implement unmap all") added same support
> for VFIO type1, the split becomes unnecessary.
> 
> So optimize the code to only do one ioctl() to unmap_all for both
> backends.
> 
> Test:
> In order to trigger unmap_all request, I have to fake a unmap_all request
> on x86. Maybe it's easy to trigger unmap_all with other arch, e.g., arm smmu,
> but for x86, iommu memory region is split by iommu_ir, unmap_all isn't
> triggered by default. See
> https://github.com/yiliu1765/qemu/commit/7afc7adac8fa601abd978b821c86e90e073d31ba
> for details.
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v2:
> - check unmap_all_supported instead of ioctl() for every unmap_all (John Levon)
> - make assertion a separate patch (Cedric)
> - pass VFIOLegacyContainer pointer in vfio_legacy_dma_unmap_one() (Cedric)
> 
> Zhenzhong Duan (3):
>    vfio/container: Support unmap all in one ioctl()
>    vfio/iommufd: Support unmap all in one ioctl()
>    vfio/listener: Add an assertion for unmap_all
> 
>   include/hw/vfio/vfio-container-legacy.h |  1 +
>   hw/vfio/container-legacy.c              | 38 ++++++++++++++-----------
>   hw/vfio/iommufd.c                       | 15 +---------
>   hw/vfio/listener.c                      |  1 +
>   4 files changed, 25 insertions(+), 30 deletions(-)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



