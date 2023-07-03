Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCE746108
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMrA-0004rk-NZ; Mon, 03 Jul 2023 12:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGMr9-0004ra-1j
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:56:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGMr7-0003qZ-Al
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:56:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3142970df44so2928549f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688403411; x=1690995411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YP2QdnbyToyzj0+BJcrRqycgw8g8E8EuD8VB+b3hQGw=;
 b=ouohnf/K284tNGRAame2RV3090YG0i3Tw3lLn1dHyqLz2Fn7dJrINogAIghPKM1Mp0
 j/ggQr48PYNCBLxALfqOWrsB0/GXul/fAdZhYPeMPhRBAcSICWELVwkhS/eaH9riYMWp
 Xy7MBU0C+UVctCHGjF5/2m5dyaflfhTGPH1/MViv5r5tMLE+LqcJQb2rGAi0qZDtrPbg
 N+Uk3MvswodiJC9d5e17USneKwt+Lmaql67ET/HTKn6TM6PmHZsfi6h+AwWghVNIDqm6
 toWfax2LB6IlSEkKvw330mgdyHU67MUDFN6fapuoIyPWRvoW8GJCaRzurDVEidWV4Fdk
 2jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688403411; x=1690995411;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YP2QdnbyToyzj0+BJcrRqycgw8g8E8EuD8VB+b3hQGw=;
 b=Nc9eMEkunUA51V2h8eVD3re85e10yjlDu4urH+Ik231PMbQeu/Q4vMZBLCv3vMz9Lm
 eVO1p8IfczMsyI1e9sGZ/TaliB4ddldejE7VN6SwWpwPjMt60lEkNRHwncWGsbJgq4LN
 2fwHWa7TDu02h8C7+eod1o3OlNTqflJr1HCIw0Yil+HvkDACZsnxD11KPoniR4eLgj+u
 U2OHzNz/2ILO+oFYNi0j3076gQtc0jCYA9VJEAQnzDF0YdU0kgRyXaMjSWLdkE6oP7U7
 4yHz1CLDyHI9DV3L7UDPGSfOY8Ss0uPSFEFDLr7SuyiMyRhvHP5BK6PtqHZ+8xUTiTfG
 3FGA==
X-Gm-Message-State: ABy/qLaWyG5MiBLLU4VV1kvc0CMYCn0foKoGs3iTk5FhNWKl0QFiqJ4Q
 1EWq94b4sUkONv0w1EtK+I2asg==
X-Google-Smtp-Source: APBJJlGS7Acl7J8umk1adKI8HcD0nGBbB5q4N/2UvYbdbyTLmSn1IopRCEsd3cOGJ1RtSOnFz+ZKOA==
X-Received: by 2002:a5d:6b51:0:b0:314:2ff2:b051 with SMTP id
 x17-20020a5d6b51000000b003142ff2b051mr4727456wrw.41.1688403411595; 
 Mon, 03 Jul 2023 09:56:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003141e86e751sm10186065wro.5.2023.07.03.09.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:56:51 -0700 (PDT)
Message-ID: <7c4c2bc7-add6-6e45-c753-af163de3e216@linaro.org>
Date: Mon, 3 Jul 2023 18:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] vfio: Fix null pointer dereference bug in
 vfio_bars_finalize()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230703163953.18526-1-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703163953.18526-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/7/23 18:39, Avihai Horon wrote:
> vfio_realize() has the following flow:
> 1. vfio_bars_prepare() -- sets VFIOBAR->size.
> 2. msix_early_setup().
> 3. vfio_bars_register() -- allocates VFIOBAR->mr.
> 
> After vfio_bars_prepare() is called msix_early_setup() can fail. If it
> does fail, vfio_bars_register() is never called and VFIOBAR->mr is not
> allocated.
> 
> In this case, vfio_bars_finalize() is called as part of the error flow
> to free the bars' resources. However, vfio_bars_finalize() calls
> object_unparent() for VFIOBAR->mr unconditionally and thus we get a null
> pointer dereference.
> 
> Fix it by checking VFIOBAR->mr in vfio_bars_finalize().
> 
> Fixes: 89d5202edc50 ("vfio/pci: Allow relocating MSI-X MMIO")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ab6645ba60..95e077082b 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1752,7 +1752,7 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>   
>           vfio_bar_quirk_finalize(vdev, i);
>           vfio_region_finalize(&bar->region);
> -        if (bar->size) {
> +        if (bar->size && bar->mr) {
>               object_unparent(OBJECT(bar->mr));
>               g_free(bar->mr);
>           }

What about:

             if (bar->mr) {
                 assert(bar->size);
                 object_unparent(OBJECT(bar->mr));
                 g_free(bar->mr);
                 bar->mr = NULL;
             }

?

