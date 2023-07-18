Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF64757A56
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLim6-00015U-2b; Tue, 18 Jul 2023 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLim4-00015C-IT
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:21:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLim3-0006yw-3K
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:21:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so5830867f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689679305; x=1692271305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GvI21veUZqHwcOI8YslxqVhD63a3gyF2WBoLTCKFfTc=;
 b=r67YfuSJXUnG66B/ddM+Oy3TgEFlNQktpLLZwe1eJb1C5j/qoGUR30DNATJMbzAWZX
 9cYmIwnazf09RWVoNQfgnZOJKGinI4kz12FrNZ/FFcnfNpKvcKoZp82C1B5YTWgUOXzx
 hpY6J/EduWyXiiaEL5wXGsczJRmZAQJmGo/CYIrIxX+Gzl/SPXT5CokJA6bv9QA2B/Ve
 FFRMAOFxUHw5gGe4sjpAyf6oi8imZ7k1FBBqRaw8HkX1yTG7XP6qUsstknBo9lD+CHsb
 oJW98Bx+K10NYHlnhtv6ZHJ67EIb4VBrnksbiwNqYLSx9AJ0kfyBOoYGdl0uanfRtC0l
 Fvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689679305; x=1692271305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvI21veUZqHwcOI8YslxqVhD63a3gyF2WBoLTCKFfTc=;
 b=UQZ9SZBtnjEp+feAZ6a/6XBYGdH8GpvxHf8J3Zr9UowXKQxYtLlwA68YhRei67GNDQ
 TmL3kypMR6APYzCoXSavD/GwrsnRV9A5dZXCfXCHrGhdJONSz11Qix4n6uy4iLA0ty38
 0aO2EqBls8IzOUY3WeorOMKa4N35opoTvEMtmXFtrH/8xcF5EQL4DS2Zfkw+Y71bPIXw
 3m/XQVRoRltDr6gvWZdwqIcQTG7/RenUwxh2UyJULwZsop9lwtN0G267UVz+9759fGFy
 sDsNIIj0fi0bFQw+zY11RC1CnpkKjXkn6+M09mvRudgwiAWyI+j7WVysDot9zfnPAT7/
 esDQ==
X-Gm-Message-State: ABy/qLbv1AKRNftfbRUtQ0POrt1qMdkdEjXrovxWQge9MDGlBSYrkHtB
 zkoOnxlvVWyuu+rjZB0GlUileQ==
X-Google-Smtp-Source: APBJJlEytr+yGK+5+X4q/YyPW4Z9f3Y7nXtbyU17n123o01nEx3EeVB1i92qkDTjidkp1ntvjXTKIw==
X-Received: by 2002:a5d:5958:0:b0:313:df08:7b7e with SMTP id
 e24-20020a5d5958000000b00313df087b7emr12783451wri.14.1689679305469; 
 Tue, 18 Jul 2023 04:21:45 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.140]) by smtp.gmail.com with ESMTPSA id
 k22-20020a5d5256000000b0031455482d1fsm2123818wrc.47.2023.07.18.04.21.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 04:21:45 -0700 (PDT)
Message-ID: <549711e4-e76c-1d1e-0d4b-6cdbc6394245@linaro.org>
Date: Tue, 18 Jul 2023 13:21:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] xen: Don't pass MemoryListener around by value
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20230718101057.1110979-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718101057.1110979-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 18/7/23 12:10, Peter Maydell wrote:
> Coverity points out (CID 1513106, 1513107) that MemoryListener is a
> 192 byte struct which we are passing around by value.  Switch to
> passing a const pointer into xen_register_ioreq() and then to
> xen_do_ioreq_register().  We can also make the file-scope
> MemoryListener variables const, since nothing changes them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Disclaimer: I have not tested this beyond any testing you
> get from 'make check' and 'make check-avocado', which is likely
> not much.
> ---
>   include/hw/xen/xen-hvm-common.h | 2 +-
>   hw/arm/xen_arm.c                | 4 ++--
>   hw/i386/xen/xen-hvm.c           | 4 ++--
>   hw/xen/xen-hvm-common.c         | 8 ++++----
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


