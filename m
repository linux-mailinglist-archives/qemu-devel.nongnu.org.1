Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6935AE964D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Jun 2025 08:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUgAY-0005su-80; Thu, 26 Jun 2025 02:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgAW-0005sl-BO
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uUgAQ-00024Z-VJ
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750919581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ejDQeIgtQuPnipTiktX+rIMDFJ8jOGSnMkrWrCWMwtY=;
 b=MwWd2rM0Uz5KxRLrCgBXmcEkXqtfhgXxUJwqSgYeaDUXjwHP6knGuHsYRZMSktXkpebFRn
 y3cY7oIZC8GIcsQVH/EwVZvxOJd0qVxTB/Dv7n1NRb6TwdyXJjCLKKmRpv2P0ucOv166FK
 7ALPeTv2f6iMQkRLed5Db7ZN0uCjPm0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Iqxa4Dx-Mjul4nXQw4O5qQ-1; Thu, 26 Jun 2025 02:32:59 -0400
X-MC-Unique: Iqxa4Dx-Mjul4nXQw4O5qQ-1
X-Mimecast-MFC-AGG-ID: Iqxa4Dx-Mjul4nXQw4O5qQ_1750919578
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4532514dee8so4489775e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 23:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750919578; x=1751524378;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejDQeIgtQuPnipTiktX+rIMDFJ8jOGSnMkrWrCWMwtY=;
 b=kAl/w4LCuPkLxowIrPRiUhNSkH4K6yQAosWCkoqFPqFcB3rPCfrkVZTI2XwR9eT+Lt
 3nJwhdFdIcAhOFIZ2Kl9UDrs2A5xDot63MoQO5qipqMborAcg/Rtf/75z6zylOG2VXVC
 vxqFD8Fu2XpM3AtcphQ9f6AXd5t5CxClXrw83mEqIeRyK2FfDtO/GrHTgOjrwNRnZQjm
 TTI1j+zqKntYFMgHlwFTIWHX40s52uhMGsC7W6xoc3UyIKivwsY6BococThzRz0WUyy6
 V0GrzxBuZvZENY8Mmx73CwQArIx4+jnra+ftP+8t9/1hqoMHwWWAI5v61IxMRNYUtI6x
 baZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs5P5ey8cV2AuwLzES1v6ce76E6w99hItLEVjfaZjOBO1n1bhHk4VTcsUdQHEHd1wAqO6Fq9p6KFHH@nongnu.org
X-Gm-Message-State: AOJu0Yzn5Llg0XIXAAaiBDa0GLCzyE7SRb75tROf54HSm70Oa48hU07o
 BIlT2yeVZvYXyB1Fexx/2gLZDghEA31y7WVyNiw9aa3X5OwS4jpF8yj8QndSLmtU32ojTC9YDmX
 auJTe+ielNBemQiZJWM/+TSI6Es6mDVST60iEfU24ccMoF+5OnxQIoEf2
X-Gm-Gg: ASbGncvb+YHnqZoKbsBbJlgBawwqkcBvvuoI+fOS5n8LPW1eaTMYLremmYGBePKr8Nr
 O0X4vj6Y4f2+w6U6AieQ7tvQcu1nqr3FPqIIEDKin+5VEZdvNqoMhMT8P2hgkhh0sYuo0x8ztwc
 hJd/H3CgpxxO8psyE2u5j3NL8SRaV77z0InM600BhRWSqBgukoe33IZtuyD0Dv0xJhlwyg6eMQf
 qzSkuve2uJfOWhBuwVuUagXZlFGtFKBecfRyztIGKrjpymX4Hh/uGAm7A9+zIvtuuMXtCiWAl3P
 s+K5CVgvDpzpgVZuQWD2ituwvycWFzvgxdN3rNmz96BAFwuQI6x8A8h88k82
X-Received: by 2002:a05:600c:620a:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-45381b20df6mr43406365e9.27.1750919578252; 
 Wed, 25 Jun 2025 23:32:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkeRBYedWbQHKmgLB3EyLBmtnqiOzbci9rOECLlelKkBhILhYwDDDBlwhHa7CeIOm5CCJmVg==
X-Received: by 2002:a05:600c:620a:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-45381b20df6mr43406165e9.27.1750919577858; 
 Wed, 25 Jun 2025 23:32:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823ad0f3sm40425135e9.19.2025.06.25.23.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 23:32:57 -0700 (PDT)
Message-ID: <5392fbc9-5fd8-4585-b69c-d01add02d9b7@redhat.com>
Date: Thu, 26 Jun 2025 08:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/19] vfio-user: connect vfio proxy to remote server
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
 <20250625193012.2316242-3-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250625193012.2316242-3-john.levon@nutanix.com>
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

On 6/25/25 21:29, John Levon wrote:
> Introduce the vfio-user "proxy": this is the client code responsible for
> sending and receiving vfio-user messages across the control socket.
> 
> The new files hw/vfio-user/proxy.[ch] contain some basic plumbing for
> managing the proxy; initialize the proxy during realization of the
> VFIOUserPCIDevice instance.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.h          |  79 +++++++++++++++++
>   include/hw/vfio/vfio-device.h |   2 +
>   hw/vfio-user/pci.c            |  22 +++++
>   hw/vfio-user/proxy.c          | 162 ++++++++++++++++++++++++++++++++++
>   hw/vfio-user/meson.build      |   1 +
>   5 files changed, 266 insertions(+)
>   create mode 100644 hw/vfio-user/proxy.h
>   create mode 100644 hw/vfio-user/proxy.c
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



