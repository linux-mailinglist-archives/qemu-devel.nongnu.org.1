Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F8B3E186
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 13:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2hy-0006KY-3D; Mon, 01 Sep 2025 07:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2hw-0006K9-0e
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ut2hu-0006qs-3z
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756726097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/N8upRJ1d8yzazW+f/bNmFNtjhrHai25NFdLNIm6DFQ=;
 b=idyjBWo2BcpCh113T2JuXjTvLL+pWbwi0aeDBu88xs9kWGLvAAxjL3KfPRv8eulmJYOqpz
 DFCNWWEzWbqR30Ql3bg8FVJioieMMgNc1PUV2FoXOr7J4fajMn2jBKKQzkFE92EQYgemjg
 83X/7gbSbNvzIhdw+8NSwsTvP5mkZoc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-qoaCZ9ATO3GgugmOupumCA-1; Mon, 01 Sep 2025 07:28:15 -0400
X-MC-Unique: qoaCZ9ATO3GgugmOupumCA-1
X-Mimecast-MFC-AGG-ID: qoaCZ9ATO3GgugmOupumCA_1756726094
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b8f4c2f7fso4155865e9.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756726094; x=1757330894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/N8upRJ1d8yzazW+f/bNmFNtjhrHai25NFdLNIm6DFQ=;
 b=WR7FLDuQ5S7NEIXLI1oGna2rfQZW4II+gGk2XqNCDNF+taoitynM5Ce7bBHGAGBiXE
 w8JoGrtmiiq+zvlimYRkZeaSS7R6vRpGu3bYbYRHcrPwTRkOm3VJ+4y+2DT5Bq878s5w
 Nqe7FjOH9V6LiSoMLwVbSC4fXQ/DIDaEqeSaR4oOf64VVn7fB/5JL1w3ELk6MTmPBHa2
 4vLWe0he4hWVqLvvH3f0Jy9nW7NEV9WauS2itLMs99KODExS77avSjs2TPPU/bypShEF
 EoP19DXerP9nLE1tS46g2TpQjsU5gBrSYmIVuKMXr4UluJDaXAiZWPEhmbwTRxAWTHPu
 Dx7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEj1lo+d8YWwkIpEzU0f8yhvLtEdaEvRdJK2T5OMUDEmmV+tuNEbRNgnDZ9+qLY5HAQ6DalFV6Pm6A@nongnu.org
X-Gm-Message-State: AOJu0YwmoWsX/bupkJjXuy/PweXsV8HlJhAoY/7Nh/W6w3BToi07iAc1
 qLmwxT5rP8fzSQKOehzIgCvIbYz+7YK4McO3b28tAw19ruYMP7vMPyoExYfJlHInWnwVJAPHo+p
 MErvCIl6Qifb9+MrZsYeIpHXln9jD0eyA49bzthYTzLjzmvuFv+UnJRVU
X-Gm-Gg: ASbGncuPU1kty6efhqBYTWY9PNKCabe0Cxhdqa0oK+sM8uJZppjaXpXS7Xk0RAqF7nm
 B73l/2EEcBEG4++UZx7m8zJKjdwSboY2oRZ9ZS3DTW8CFi/MhOeKd1BYH7lmvadKp1VIjKBlml2
 ivbDvMMCXeJ40utoX65JLgyXjSRYTGPD22IbK0sf9/a4J6fQJMMAjYOKQ9pwp9OBPRnFGMgy7eq
 +Sp9Wc21iIlctiHNrPUTnN2uNIKAsOTIhRT7tGZ8bjZ5LxSIhVizVa+EDLrrdG+922UMJjtrlxt
 O9E8TUCfT1F44xD6zJtVjsRg+e83x+YmKKw+i0F1eI4HGNHk++NYcNXrZ/shRzbSj2QiAHF72R0
 /JFg=
X-Received: by 2002:a05:6000:25c7:b0:3ce:9872:fd3 with SMTP id
 ffacd0b85a97d-3d1de5b0cd7mr5924300f8f.34.1756726094315; 
 Mon, 01 Sep 2025 04:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlcrXv4iWFHf9FDBHwkL7noD7j0DD83YfkK9ws+k0GBzszCxVpISmqzAcUL5GnLL2cRSUt4A==
X-Received: by 2002:a05:6000:25c7:b0:3ce:9872:fd3 with SMTP id
 ffacd0b85a97d-3d1de5b0cd7mr5924283f8f.34.1756726093876; 
 Mon, 01 Sep 2025 04:28:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d21a80c723sm9897923f8f.9.2025.09.01.04.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:28:13 -0700 (PDT)
Message-ID: <0699f897-3aeb-4104-919b-c96cdab4d4e7@redhat.com>
Date: Mon, 1 Sep 2025 13:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] vfio/pci: Add an architecture specific error
 handler
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-3-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250825212434.2255-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/25/25 23:24, Farhan Ali wrote:
> Provide a architecture specific error handling callback, that can be used
> by platforms to handle PCI errors for passthrough devices.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/vfio/pci.c | 5 +++++
>   hw/vfio/pci.h | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 07257d0fa0..3c71d19306 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3026,6 +3026,11 @@ static void vfio_err_notifier_handler(void *opaque)
>           return;
>       }
>   
> +    if (vdev->arch_err_handler) {
> +        vdev->arch_err_handler(vdev);


I am not sure that the "architecture specific error handling"
will be implemented this way but we need to check for potential
errors.

So, please make the handler return a bool and add an extra
'Error **' parameter.


Thanks,

C.




> +        return;
> +    }
> +
>       /*
>        * TBD. Retrieve the error details and decide what action
>        * needs to be taken. One of the actions could be to pass
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 810a842f4a..45d4405e47 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -145,6 +145,7 @@ struct VFIOPCIDevice {
>       EventNotifier err_notifier;
>       EventNotifier req_notifier;
>       int (*resetfn)(struct VFIOPCIDevice *);
> +    void (*arch_err_handler)(struct VFIOPCIDevice *);

>       uint32_t vendor_id;
>       uint32_t device_id;
>       uint32_t sub_vendor_id;


