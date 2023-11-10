Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E3E7E78C6
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 06:23:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1JxD-0007UH-15; Fri, 10 Nov 2023 00:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1JxB-0007U1-1q
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:21:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1Jx9-0007Ak-EW
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 00:21:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so11965275e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 21:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699593669; x=1700198469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WINv/yYs8iMNOnLEKIjfgkuMTFBPduHcna5wcjH+82Y=;
 b=pqp2lnbZjAl4reTaUERjz8VL/P6oCFqgVeGI1bnp+jAiuSd7ZNLRcklXgY1PkDd2nW
 1fFcYEV4+PAiB3NhJiEJgCJx5Wq/I5E9MqaodgTjVmcA/eJMTMlTkZLxUPuuVr+TdZ79
 7gVEdPhzCbcuezbsCgHvdk9J18Yh18MqFng5U2bGQvZt48bDeSKYfPhd1HLggAHz5eU7
 uDLg330J80cFLqAVdEk19QqbwjrUZLZns7c2klgTK/stE2/Pzliuie6wdkOfItQMj1Cb
 sxJ0HZQBM4q1RBWfDKtJQnyn/5mqsVIE4fBn3vDzJ5WI7ab/0ZvyXJR8xF9ZS1fUHDhB
 Jhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699593669; x=1700198469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WINv/yYs8iMNOnLEKIjfgkuMTFBPduHcna5wcjH+82Y=;
 b=b1UmXaI7EYYuK5G1JDSnCkMZ2yp4QrgbD6cbXinJDiI4MBrCVfuo2OcOAZUom2va1B
 OetGH078Y1zKu0MGxfU3bQ34kgU7Th2v7LSi5oVKaWrDt0MMnRbiI/DYj9/Ko1KvrUKF
 LhI3q7oxarDRYV4W2QiZPUzLOMHwFQ2LWosIr8wlixaD3IggJbCWINtwQtipjxvuG/rM
 xWVFPzARuP6n8FiD8ON9Z6jgLXz85CWET2XozDv5nAsqTQPVrGpGHdgpvdIO/6P9pgj5
 n8DxGWzQEcfRSq6tLk9m6hpAgm8YPj8wNmWNMuMbly6QUOHGRxyHlYum9aYfSIW34iXa
 71Tw==
X-Gm-Message-State: AOJu0YxXka4U8Z1QrkHpzXGFE2RXQhKlRen0DzKNfmRkThMiMZ+0EKhK
 3DsCuFJw+kTz+7g+Y6iBgNfNKQ==
X-Google-Smtp-Source: AGHT+IFa5bs4d11Y3CsnQLtA/lFOHdZ8qoEZnlyy0z5nH4nfmaRM/+Finoq0meDULnvfdcuWVmVm4Q==
X-Received: by 2002:a05:600c:35d2:b0:408:80bb:ae80 with SMTP id
 r18-20020a05600c35d200b0040880bbae80mr5861914wmq.7.1699593669443; 
 Thu, 09 Nov 2023 21:21:09 -0800 (PST)
Received: from [192.168.69.115] ([176.187.194.109])
 by smtp.gmail.com with ESMTPSA id
 fl14-20020a05600c0b8e00b004094d4292aesm4064145wmb.18.2023.11.09.21.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 21:21:08 -0800 (PST)
Message-ID: <aa0536ae-d44d-44bb-a688-93393950fd76@linaro.org>
Date: Fri, 10 Nov 2023 06:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390x/pci: bypass vfio DMA counting when using cdev
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20231109225302.401344-1-mjrosato@linux.ibm.com>
 <20231109225302.401344-2-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109225302.401344-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/11/23 23:53, Matthew Rosato wrote:
> The current code assumes that there is always a vfio group, but
> that's no longer guaranteed with the iommufd backend when using
> cdev.  In this case, we don't need to track the vfio dma limit
> anyway.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-vfio.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index 59a2e03873..7218583883 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -66,7 +66,11 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
>   
>       assert(vpdev);
>   

Matter of taste, simpler as:

        if (!vpdev->vbasedev.group) {
            return NULL;
        }

> -    id = vpdev->vbasedev.group->container->fd;

and this line isn't changed.

> +    if (vpdev->vbasedev.group) {
> +        id = vpdev->vbasedev.group->container->fd;
> +    } else {
> +        return NULL;
> +    }
>   
>       if (!s390_pci_update_dma_avail(id, &avail)) {
>           return NULL;


