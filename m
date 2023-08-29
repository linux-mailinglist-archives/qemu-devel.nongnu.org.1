Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6E78D006
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n8-0000tJ-NQ; Tue, 29 Aug 2023 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb49c-0001uK-Fd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:13:32 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb49a-0007AS-Cd
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:13:32 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c504386374so3448411fac.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336409; x=1693941209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a+PvqgeILWPoH01oAJfmk7ZgX/WqMSezvJnn1shTe3s=;
 b=L3T9LCD1nH4u7KwDyjwf64nbEMGfSUAkzMC59o8+M7Cf/SR5Vt48v4tzutxGFD5kkD
 5kjHsfdFfQKgU7dTe6s9lT33vzoiCwfq4jPJbLRmbrZQZrk8iP6GBu/uWf9+BoyX5vPk
 TmIzkMqJCKpC2Ohr39+OpR2C3/G9IzpT1O31bpnWA+TCgDNPJt2rsYlCVHTT8DrM3PMl
 MQdw2/F7StiUsIlkuuQ83ywYH4AZA4/7Xr6LIwuW0Lo8lnUNBzZATG08Xy5tGOBb8Fqv
 aIdqV2ZOwivA2snXg9MF30R1JBtIVGLkNXl66V78M4nj8yD2kc455zsUCIG2K1ekANdp
 crMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336409; x=1693941209;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+PvqgeILWPoH01oAJfmk7ZgX/WqMSezvJnn1shTe3s=;
 b=TtGS/B4SG5n7X6NMQ+Z9UKiq25GfqHADoe+snFZzYgGUOcckpBgcXAWeS4l8giN7tT
 QsvCeasbknu4Y2Qee/RQglInU47QYlL8IsoRGg8u0HpYog+zpLoDIXDfnQfuCyliOvfu
 cSgiOiAdVvUAQTNkTRFXN9oq1SbAKDY52zxdxZB5GRU8NF4j+nmpGtW3Gqi/0I0MjnH1
 7dSrceOIg9dbCCVV2wk5VlNvbWqQsnftlZjI3p0gFgkcAhxLgnEs/9XuXLrjePe8ueiw
 ephCulvFjs9Q9GOUSu4IWMncG6OmaypO5KwbZq/eLVSe3W1DugPhnqO9jfhv2MfxXIGf
 gMrQ==
X-Gm-Message-State: AOJu0Yzv10+5ItuTOY+0taKWCOix63KYKwYEIEJyeEnpm4rLQILia+6w
 geO+zxQIgfjTsrfJESLu4/P4yQ==
X-Google-Smtp-Source: AGHT+IFN0to+K5Xv1AulUFXZx2sXQ951rvgSIMUPx3DGDAp1IRiBNV+QGYBvUgZn29sp96gDb6vCnw==
X-Received: by 2002:a05:6870:2426:b0:1bb:8040:24e1 with SMTP id
 n38-20020a056870242600b001bb804024e1mr121401oap.28.1693336408871; 
 Tue, 29 Aug 2023 12:13:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a62fb10000000b0068c10187dc3sm7705493pfm.168.2023.08.29.12.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:13:28 -0700 (PDT)
Message-ID: <203ad3db-c84d-f118-5d59-17d07d46b5a8@linaro.org>
Date: Tue, 29 Aug 2023 12:13:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/32] bsd-user: Implement host_to_target_siginfo.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-4-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-4-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Used in wait6 system call
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/signal-common.h | 1 +
>   bsd-user/signal.c        | 6 ++++++
>   2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

