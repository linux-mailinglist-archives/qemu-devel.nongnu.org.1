Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298DB9A8FB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 17:17:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RCb-0004eo-F3; Wed, 24 Sep 2025 11:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RCL-0004Mc-H6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RCE-0003bN-Hf
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DD7p8dkiK8nOjEBtfekgS0/H2Waevi90FsRPpfPFABk=;
 b=PLiM2tAPeAJgrT6FXna7LLDcTqPy5QrMzSP0FFtOupUyulSwDn857TA1yw2dNucEPWn/4H
 0V20v4QT/4qLzvhkxznqRybyNZOBbRXqpn6DnkK/prV7hFSWKarb64IPS8Kv2oI9kX2sku
 PlwW92TOT/TWAZFGOlVzIkXiYU+FfXQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-wK-EX6ncMN-Ud0szi-0ZdQ-1; Wed, 24 Sep 2025 11:14:10 -0400
X-MC-Unique: wK-EX6ncMN-Ud0szi-0ZdQ-1
X-Mimecast-MFC-AGG-ID: wK-EX6ncMN-Ud0szi-0ZdQ_1758726849
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45e037fd142so56830965e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726849; x=1759331649;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DD7p8dkiK8nOjEBtfekgS0/H2Waevi90FsRPpfPFABk=;
 b=tew6lKQMg2x+SYnZwBPj+11UJ+MGd0uY8j7ppTcpxfXK1NJysxtgndUwfZn8xuENWP
 R8F29Yxm9RB+0sq/fWfBOr+SW2baqg9d1paXLxSOIE/stqwDt7UkD5QYMtrl/+iz38Zj
 aOJQ18lsCmC1GQCX8MRljLyclYDxxIU4r2cBvooUv28uITXz3ql/0J2li9Tee/TIwpso
 GPQvW1FU9Av37M5yMDvx7m5/HV+i6d2X9RrcPvfgGe89rqI+WoAxwPmiV/MhCBYQ3vkX
 YffJs3+B3cIZHBceVsKuO+1YPPYpNDaCf/PytYrAAtZgx7+z4Zc4V3DzzZBht1xWxOYg
 YaRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn59Nv3YDj3NtfoZKQgyJqS7zKdXmkZkeQi/wgbJGdlvE+YcmeAIQ61H58ijK/5d9uik40tI1U7Y2H@nongnu.org
X-Gm-Message-State: AOJu0YyO2RdjpalUzNhxoWLudm1ssmFS8GI36lRzfhzAcG9vU8h8Gq4r
 RhDDfgfJROFldXkIDBM3f686szhDmxieKuEYdOn2/agHDoDlsSJCS3UItlyVq8XAFMS45f2dyRF
 OzMMh7FjA7XaTE+1MPdoeGo4eB4yTM6C3TDAlN9qqWHMueZeYXRtibw4G
X-Gm-Gg: ASbGncskzlPeD5nh/xlKpPskbEG+AeXvrNAdH69BBLHiui9OCi7UW8awm39+xfpKQp/
 DCAwVYBb6dYgG3IzSxBmroJLviyj8x08s89JT0ErewIqzOz/qeRrHxnXHlrAsb33wEemxbyQXwV
 hkE8sSIdtqh3cBV/+byu7VjQJ2vVd2QOJu8jQEQnuhoONWS0ZnrrPpeGJ3CKIsN1VapQWbmdinv
 Z8KUzchdNR16w2qY9AJIyfzFox1u5jbvCFhO5+8KLKOfXoQJ2+D9F79/ewLqddXRgTG45ocCq2p
 1nQbGF41otHFT3qZCmVXP8l3SaBOujrl9zHmMMbnBt/zOJA96H8ppYpcjGiz/nzQcPz5OwIgJRH
 65e8=
X-Received: by 2002:a05:600c:489a:b0:45d:dc9b:e85f with SMTP id
 5b1f17b1804b1-46e329aedecmr1616075e9.2.1758726849357; 
 Wed, 24 Sep 2025 08:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcC2CLgD32RGfW71dPU3aoI9Q3pHm/4q9i7b33iAQCbPa6E3BoGgLFnsAkuGiy98hMM9Z7cQ==
X-Received: by 2002:a05:600c:489a:b0:45d:dc9b:e85f with SMTP id
 5b1f17b1804b1-46e329aedecmr1615765e9.2.1758726848952; 
 Wed, 24 Sep 2025 08:14:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2aadc319sm36535135e9.18.2025.09.24.08.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:14:08 -0700 (PDT)
Message-ID: <6bbaea26-4bd7-46d4-9f6c-e7cdb3f1170c@redhat.com>
Date: Wed, 24 Sep 2025 17:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/27] vfio-user/pci.c: rename
 vfio_user_instance_finalize() to vfio_user_pci_finalize()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-27-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-27-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This is the more typical naming convention for QOM finalize() functions, in
> particular it changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio-user/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 52561900fd..d4f5c7b9d7 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -370,7 +370,7 @@ static void vfio_user_pci_init(Object *obj)
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>   }
>   
> -static void vfio_user_instance_finalize(Object *obj)
> +static void vfio_user_pci_finalize(Object *obj)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> @@ -469,7 +469,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
>       .instance_size = sizeof(VFIOUserPCIDevice),
>       .class_init = vfio_user_pci_class_init,
>       .instance_init = vfio_user_pci_init,
> -    .instance_finalize = vfio_user_instance_finalize,
> +    .instance_finalize = vfio_user_pci_finalize,
>   };
>   
>   static void register_vfio_user_dev_type(void)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



