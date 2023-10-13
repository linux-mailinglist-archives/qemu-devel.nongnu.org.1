Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F79B7C8100
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtu-0002jZ-Cy; Fri, 13 Oct 2023 04:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrDtj-0002cE-0v
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:56 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrDtR-0001hW-6w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:51:54 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so377551566b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187095; x=1697791895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YeEfXgsKpYdF3RMLquGoYhyEJWn3mVtkScrf5aIh5jc=;
 b=J4SxAXxbf/nSqp1/PQti+5aKX3yi7RWsiK08TKvGKJyIyJRi8OIv3KJKkbtA81Di6r
 dC8S+VMnPU02HXc2vIELqcvPJn+Sy7P/sHTTqdf6+gvNXVR30/4FJKprjqVbwN6h2ZF7
 xlYV3oHhmiE/hM33G/ZHBs7GZDgQHT/bE2s1LN1VK6+kKSpHPoAEdv5yiHsarO52wNCE
 qG0v9YkhorlL52Gzh3FhA+fHW07Vx+TIqQcGcdXp16mQJMF3lix0vKQwP1u1LI5Py/U8
 AFSCocVGFhgOGQgWsK3/0W7hY1FiZwwX9I9AMsngNlZmWGBnwWR8+FDVqN4bN9YA/LRj
 2BCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187095; x=1697791895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YeEfXgsKpYdF3RMLquGoYhyEJWn3mVtkScrf5aIh5jc=;
 b=DiI66FfZP+IkqSelyfBhL1UPC4wGmPMnZemjucIdscjI9w73HPW99G+R6pEjvlcQvs
 DF/AcwdeNTxnFxVmYwxRK9FaN7n4ivWNUFOUwk+w1irw0geWm5j0YdxXjTRxba74INjS
 ZLIz9iyfpO+JeXH8I0GiUAnXKi9K1vm10MAP7QVtJNGvqop2keCi0Igd2lwSqDx2x3Ku
 0SnV+4wxX49dKXxc5c/mkA2QyhtQPBvQxeRv8gWkTthQ/mWu36v4HkODm/bRbu4xI46Y
 qs4X+WyL8l3y6mXOgJ/rcHXIBb+WTV6wxQkYHbmIZM1GsZgwddcc6gbfG3ebw4Fy/r1Z
 xd5A==
X-Gm-Message-State: AOJu0YwE86eKPuPRPqzrQjrhOlqqcg+Z8YkbSOmPJOkjhfEWkjAy6e2x
 s4UIXssCjTQ2mhBrKpgLsisISNUXcyU0PLOevUSC5g==
X-Google-Smtp-Source: AGHT+IFU9CiBPtDfnpXENWsgYoDu1B8G4xiCQso0L3gQhYjyxkdn8iYVq2EgTKZN/4Lebaxgh5FE1w==
X-Received: by 2002:a17:907:6d2a:b0:9bd:bdfd:e17a with SMTP id
 sa42-20020a1709076d2a00b009bdbdfde17amr332487ejc.6.1697187095344; 
 Fri, 13 Oct 2023 01:51:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 op13-20020a170906bced00b009a13fdc139fsm12152002ejb.183.2023.10.13.01.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 01:51:34 -0700 (PDT)
Message-ID: <3e159260-f1ac-d3cf-4ba4-3ce6c1b88343@linaro.org>
Date: Fri, 13 Oct 2023 10:51:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add the nios2 interrupt controller to the
 nios2 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
References: <20231013065408.949486-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013065408.949486-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/10/23 08:54, Thomas Huth wrote:
> These files obviously belong to the nios2 target, so they should
> be listed in the nios2 section in the MAINTAINERS file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6eecd617e0..45eb230465 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -296,7 +296,9 @@ R: Marek Vasut <marex@denx.de>
>   S: Orphan
>   F: target/nios2/
>   F: hw/nios2/
> +F: hw/intc/nios2_vic.c
>   F: disas/nios2.c
> +F: include/hw/intc/nios2_vic.h
>   F: configs/devices/nios2-softmmu/default.mak
>   F: tests/docker/dockerfiles/debian-nios2-cross.d/build-toolchain.sh
>   F: tests/tcg/nios2/

Could we have a NiosII hardware section instead?

