Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A804B208B0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Aug 2025 14:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRYw-0001ie-Ek; Mon, 11 Aug 2025 08:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRYr-0001gK-DC
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ulRYo-0006lV-4Q
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754915007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=igxuoWIsimUw0nIoaQdNMk/nZ9l37+GrYNS35PFY6Ok=;
 b=H8Gv4WHpfUXHEk4HT8oVhBtj3cGbJVSaxJ82DTRLUY/hwXTNYZwKLYxiZd02IoKOCeKoRE
 Q9KCjPqI+Qe7Z2+/+TqXB109ukrLfb5HCvbtOKtfCdDsoESsuZsSx/g7rGI68YQ+DGmBX7
 B01vBdL5M0LWKCErm1rRcxHQIPkfkKI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-RbuTc0oYNn2OLt24Y83OSg-1; Mon, 11 Aug 2025 08:23:26 -0400
X-MC-Unique: RbuTc0oYNn2OLt24Y83OSg-1
X-Mimecast-MFC-AGG-ID: RbuTc0oYNn2OLt24Y83OSg_1754915006
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b08b271095so119328541cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754915006; x=1755519806;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=igxuoWIsimUw0nIoaQdNMk/nZ9l37+GrYNS35PFY6Ok=;
 b=iJu2wN/lDaLXXHvPMehofaafZ2jzsRUJ1Rkk/8nkwlxn7nOFLGsrsSMrIxMTWTcLgn
 exwUNdFpu4+uYjABD8UKoQ1JCtOahei1e4wHcFvj2J5+6lOP0w4uhddbUZDs+pxSBF+w
 eixE/kFZ8fQSYvEXJQBqhmh/2UES8gyL/ztSLElTlgYZtawTGcujykqHvSTFvYzhjqC9
 Lc+F/I6Zr6kTI6aBE1bdF0frCWOexObL9EvTqyddo6Il3XymQUmAurVbiCN+j3B8bnAS
 qm0Ydm7Y3Xvvk/4Z9U0jXzCpsBvi4TI0rVziJl338L0PQbZW7TNRmiSdtDzM9gIN7S7D
 HnWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXifUzz0wnbK/eES1MOEzJrucSzSqLKepxYnieMtjQSeTFNrI1g1jTlCBMG0a5vwAGixTBM3Xjb9zNc@nongnu.org
X-Gm-Message-State: AOJu0Yx4Xst0+c33pmCV+Qzrq960y+f3AaQIoKfaKYmN5pliulu2AoJm
 Ur0TKNwh3twOTMTg0weFzimtBMruqmU1ROvCxNnMRIzOojc9Ye96hWBEaUZzHaSO4wraRdG0qqS
 qfTxCXJ62YgUDmFSQcdoA53AC0gKQJmBib8RNMdlK7k+8HVbAzoQVKBLe
X-Gm-Gg: ASbGncs5VMFvO2oRAnWazwGheXaAFnlN9MFdv7Fd11JhB9E7nHBOV3b3UgtUbfcHsS+
 BHuLwFTjpCmQeom4G8cjYSyooJMHw007ijQEkYJlflZl/FrzBtUMacuREb9T7SqF6QMY8P54cLy
 xXFslNvkjlOSr4nNbQVXrVQhbEPc1egBE1z5EP5z6Qry1RIfdYcrdEvFe86ljBIn9MwZ/ac/3Ml
 0Ynh4hkqn1TfEe6fOtbcOxSL5lOgDHtvainLsCKF8AXIuE2ZusbsR91aX36z6X3cYTnlEmDLcP3
 5vjymF2ewuUjGG9qHfxxKVTm2iGUGlJMEQ+9e4olpBBbq3+fNGtaV/fQRURDW4ATEKNoWpn6wuQ
 Aww==
X-Received: by 2002:ac8:59cc:0:b0:4ab:65c3:37d9 with SMTP id
 d75a77b69052e-4b0aedd7d47mr175897851cf.33.1754915005789; 
 Mon, 11 Aug 2025 05:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDWlNrB0omDL/iVEIQ6GFpxyX5vnxpbbNzAiSkidfa3LejzdBbdSp0qCM5IPpoEoeOR36Kjw==
X-Received: by 2002:ac8:59cc:0:b0:4ab:65c3:37d9 with SMTP id
 d75a77b69052e-4b0aedd7d47mr175897301cf.33.1754915005252; 
 Mon, 11 Aug 2025 05:23:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b095e6c7d4sm69730641cf.54.2025.08.11.05.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 05:23:24 -0700 (PDT)
Message-ID: <34e36f6a-0c77-40c3-8270-26615859a4db@redhat.com>
Date: Mon, 11 Aug 2025 14:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] vfio-user/container.h: update VFIOUserContainer
 declaration
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-9-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715093110.107317-9-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/15/25 11:25, Mark Cave-Ayland wrote:
> Update the VFIOUserContainer declaration so that it is closer to our coding
> guidelines: remove the explicit typedef (this is already handled by the
> OBJECT_DECLARE_TYPE() macro) and add a blank line after the parent object.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio-user/container.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> index 2bb1fa1343..d5d2275af7 100644
> --- a/hw/vfio-user/container.h
> +++ b/hw/vfio-user/container.h
> @@ -13,10 +13,11 @@
>   #include "hw/vfio-user/proxy.h"
>   
>   /* MMU container sub-class for vfio-user. */
> -typedef struct VFIOUserContainer {
> +struct VFIOUserContainer {
>       VFIOContainerBase bcontainer;
> +
>       VFIOUserProxy *proxy;
> -} VFIOUserContainer;
> +};
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
>   


