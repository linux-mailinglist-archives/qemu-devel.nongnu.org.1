Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88F84C72A
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Feb 2024 10:21:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXe7L-0002V6-CG; Wed, 07 Feb 2024 04:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXe7F-0002Ty-BK
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:21:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXe7C-0001u8-8m
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707297668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yTcjraMjbKyviBDNnka5k6oTaB23g8v44QFIg9LDeGQ=;
 b=avtHVLuPFTcgBI0aaeuhdBAAwvHwu/cq4m+O4meYy2AsYETqvV4Pp6N7nEveJI+zPd5T8z
 zPgNtTiWLLi4AZzVjXizb5WYE+5gbNjutg0+n0Ai+yS3WvpAKb/Ro4QHxeH26pO0YhwUSC
 giTr3j93+Q8Idx8+hRQgqQHX9rbRdxk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-PpKPa8vMOyuhl4zISYVidg-1; Wed, 07 Feb 2024 04:21:06 -0500
X-MC-Unique: PpKPa8vMOyuhl4zISYVidg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c4f4411f8so9085206d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297666; x=1707902466;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yTcjraMjbKyviBDNnka5k6oTaB23g8v44QFIg9LDeGQ=;
 b=REx8kwiStEPYsdOOqeG7f2Zu4oY1nvo0j14pJprpE9/oUlEP4pu12yTxB7kzsg3c7I
 axPu55ZMRJMsKKJJOSDTduADp7CSCo7hcIYh6hh2dxcZYYJhfuTdDm2T51ycVntUdtAQ
 af2LdJ9VVx1YQnx1cnKUBEN/3IUH/5YESDLV5h1/p9t80rGLgFy/rPVUY7fJ2SpzHKX/
 q29VbVrvJlIiHQSKzcNHmnyjQwe1r6o+Z6YUMcycYBu3CxehMOm+vtkETOO5W5apDZiP
 +TZmyXm0PBalKjCjcTv4wP8NBWFz5oJVFz1h36sce42cA+Lx+rzel03PDCXkSGyrmv2Q
 WinQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf1fUehUvTpwB7LxNB78XCfWo5J8CPWmMFDH1vNs0wkUbjrhhkWtC/PeFsoWeEKZqOnLShjBsP04lOELfDUuJRp8dGFbE=
X-Gm-Message-State: AOJu0Ywgi3SY9S9scwDNtFB4X+y/+GdF9HYgmS4UDEZZxp5GH+aIteQ1
 a2vgrcQKP4a9KMKBkjZChMBz04R+E5IT9bopYbJxajICmQ7/fDeNPWQ2e3tsCfM8YNFXJQEyaM6
 hppCe3GiD8+8heqSVWAA1MUPHOJrnkmzch/4oq7kZ0f+kbgw2uRyi
X-Received: by 2002:a05:6214:184b:b0:68c:a8df:37e1 with SMTP id
 d11-20020a056214184b00b0068ca8df37e1mr10503371qvy.4.1707297666576; 
 Wed, 07 Feb 2024 01:21:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAr4hs9qY0B/Jdd0MQDYKH+QBrI4xM2HE+d7P43/6IAeLV6axPuB5u5d8XxWYxCp7ze1G3RA==
X-Received: by 2002:a05:6214:184b:b0:68c:a8df:37e1 with SMTP id
 d11-20020a056214184b00b0068ca8df37e1mr10503359qvy.4.1707297666356; 
 Wed, 07 Feb 2024 01:21:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVtyw6+UWuPw3Klg0YbBXT+PFusQG1XK+A8rQ6uCm6uoPtCbJZ+zQU2mIvGmS9SUOmvLozk2oZkEc8ofGPMlCI9dG6is6toXNUD+lZ1QRWcyH1hZo9/Ydik1295Zj0fSbN5Z2pcPUURR66yMnkmHB33cCd46TCjJFMJ9CMdoksvo0VfFfXPoDLlfzWO4hjev8ymCay7kc5xVlW0zo1LwfZrDLF41gK4k/A=
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 nw1-20020a0562143a0100b0068caf764281sm399804qvb.39.2024.02.07.01.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 01:21:06 -0800 (PST)
Message-ID: <ffd36e1f-293c-4e14-adc5-51c520a9b77c@redhat.com>
Date: Wed, 7 Feb 2024 10:21:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to
 hw/pci-host/
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240207091254.1478-1-philmd@linaro.org>
 <20240207091254.1478-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240207091254.1478-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07/02/2024 10.12, Philippe Mathieu-Daudé wrote:
> ppc4xx_pci.c is moved from the target specific ppc_ss[] meson
> source set to pci_ss[] which is common to all targets: the
> object is built once.
> 
> Declare PPC4XX_PCI selector in pci-host/Kconfig.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                       | 1 +
>   hw/{ppc => pci-host}/ppc4xx_pci.c | 0
>   hw/pci-host/ppce500.c             | 2 +-
>   hw/pci-host/Kconfig               | 4 ++++
>   hw/pci-host/meson.build           | 1 +
>   hw/pci-host/trace-events          | 4 ++++
>   hw/ppc/Kconfig                    | 2 +-
>   hw/ppc/meson.build                | 1 -
>   hw/ppc/trace-events               | 4 ----
>   9 files changed, 12 insertions(+), 7 deletions(-)
>   rename hw/{ppc => pci-host}/ppc4xx_pci.c (100%)

Reviewed-by: Thomas Huth <thuth@redhat.com>



