Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF1B9A8D9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 17:16:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RBb-0003RE-8o; Wed, 24 Sep 2025 11:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RBZ-0003QE-2K
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RBN-0003UA-No
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g4Iy/KuP+RzQSIN92iFFy87oo4HWoLCNClXmsV8Xz7E=;
 b=hbyXIvCeTuCIIdKVlIDozRdVw432ZDNkY2vmNAxs8vIYL4Mu3QssjqiNmIJ9cYFDsYSScZ
 DWdBte1Se1cxs1/D667MF1rrlGEa3YnZHXJFfbVgZLQtzCuk35dh9nAREOG+c3NRS1OyfO
 rzXaGrd142NkYz72gJAMrUChbmdp9kI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-gLOizLSSPC6yGFLc394U1g-1; Wed, 24 Sep 2025 11:13:19 -0400
X-MC-Unique: gLOizLSSPC6yGFLc394U1g-1
X-Mimecast-MFC-AGG-ID: gLOizLSSPC6yGFLc394U1g_1758726797
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e19f00bc2so27435125e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726797; x=1759331597;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g4Iy/KuP+RzQSIN92iFFy87oo4HWoLCNClXmsV8Xz7E=;
 b=kWR9qAfAV9bZEKI53KvE72I+PgCGnq6dXk7uCQGhwE1yYXg+QovfILKLdDbvXKneKM
 ULuCauPLZbcQdTx1riIxru08R8IUVR8VWv3Ozj7IIs7ymixkNE0ASr1XFpHKhXwmyLVo
 ktDt3QfjyKCB+lsetfZZf901F89HtL1L3Rx2IUZ4eRKcT/FVYHxa6NDl8MYWp5Vxqj72
 b133leGNka32o3QjdZJbhB9yzgFPaZ5mAqTg1/SDDQ1oULEVOAbtvoBQ+K6l7a3VKHFY
 Autzxe4SwvnSOUPvuqR7rKcZowrGDp2YL5yHLDISk6EI0fTzMY8p/xeQBFYJ8omISoC6
 /nvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+kdIxKzOay+znYgeswXkU+nev+wkNrhRh77/9IaFnEmWJWEOjNPsBw5DSkd6r7f2rFfOK7pMeFHr3@nongnu.org
X-Gm-Message-State: AOJu0Yy/52MtS35adLEJXPGO2zXBKwSQM9s2uaAuv0LTa9zu/uctmt7U
 aO9m1a54GTfBCzN+ovgr0m4d3s7XhvgCfXYDEqFoYUCIcMKpdEOjaRBz4qJDMJTkofWbFiEvYMn
 W/EV5jLOKprhPj0gkVTLwfNHdGce8h0Grf7dgbNoXdZWhwgXlFM9765OM
X-Gm-Gg: ASbGncsSqqOwgdFmJOdNrok4Yd1s1+fT3a99ueGLeWWvn4EBYKRMBTTmTkMkQ6ZEoDg
 vsjfrNdxk3xdcIp+APmQ9JHHtn6A+CFg/HNv5YBi7GIe63TFubbynbXcXI7ujckS35HyLi4ddvl
 uWoSQS5IFt9yvbCSBXw40l1fyGGXAwhaJJ0omJWHJTcJ87hkHo2X3EGNzbQoOgvmOsteb04mK28
 6Ciib3xqPmXug79xrZZBQsKvs8IvoeqNdNHSR5KXhegh9b1e3Q3Q1yAp53erEFGMEwDreM1+78K
 fUO9yJe1HhLAhf4zYlD3fJlyqUi/c9MZGbKmRgqXovLahuMPh77NveQPqdlSTeR5g5yz7AqyMv5
 twmo=
X-Received: by 2002:a05:600c:3b8b:b0:46d:996b:8270 with SMTP id
 5b1f17b1804b1-46e329fb92cmr1944835e9.21.1758726797286; 
 Wed, 24 Sep 2025 08:13:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe7lQdcln0X9PMRWxf8O75eZB283LF+R5e9WOmUEvza5gk6QJXqnpOvFJUGsHi0LHKXkwklQ==
X-Received: by 2002:a05:600c:3b8b:b0:46d:996b:8270 with SMTP id
 5b1f17b1804b1-46e329fb92cmr1944525e9.21.1758726796889; 
 Wed, 24 Sep 2025 08:13:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a998314sm42238835e9.3.2025.09.24.08.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:13:16 -0700 (PDT)
Message-ID: <2fa01dbd-c998-417a-a908-6496e20eca84@redhat.com>
Date: Wed, 24 Sep 2025 17:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/27] vfio/pci.c: rename
 vfio_pci_nohotplug_dev_class_init() to vfio_pci_nohotplug_class_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-22-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-22-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> This changes the function prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a32a507059..ec60bc3907 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3932,7 +3932,7 @@ static const Property vfio_pci_nohotplug_properties[] = {
>                               ON_OFF_AUTO_AUTO),
>   };
>   
> -static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
> +static void vfio_pci_nohotplug_class_init(ObjectClass *klass,
>                                                 const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3957,7 +3957,7 @@ static const TypeInfo vfio_pci_nohotplug_dev_info = {
>       .name = TYPE_VFIO_PCI_NOHOTPLUG,
>       .parent = TYPE_VFIO_PCI,
>       .instance_size = sizeof(VFIOPCIDevice),
> -    .class_init = vfio_pci_nohotplug_dev_class_init,
> +    .class_init = vfio_pci_nohotplug_class_init,
>   };
>   
>   static void register_vfio_pci_dev_type(void)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



