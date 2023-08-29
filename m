Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809478D077
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7n0-0000o8-L9; Tue, 29 Aug 2023 19:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb43s-0000xM-KA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:07:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb43q-0005xd-B3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:07:36 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso30263005ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693336051; x=1693940851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77/c3ESZfE+rKpR7h1yDJrev6kSM3QSzOWxupqf93PM=;
 b=JBFmkTHeI9aECjnxPrrmxo20P5hehsdDyZ5d6o7vhbn1CopX3HyyaEiGcbm6t7wPch
 Gz1pZS6wAMetnwq8tuJ86rJva1p8pvnSJCg67kjVvN5EShvtljZ3vtuCqMywdeWIG2xu
 nVWY+k7HCqF2vKjiFzxIehhx0eMtfVIvpEAz2vfcdWcUEyD/IrYcoaKuUBKXQAem51PB
 BtvUgZDF8R/+5hAQvKycR+JhPob44Clucagbter8lilJKwlJcVKmps5qmoFeATyYPICl
 vZCos165PBmT2HzQNoeHMPssDFWIaOf4MW7AyFkNznxrgOP+ZTbuQDr48qhY4OYTysx+
 7J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336051; x=1693940851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77/c3ESZfE+rKpR7h1yDJrev6kSM3QSzOWxupqf93PM=;
 b=gnfaig2IeYTMvkt3O4iUysx1RyNz5PAThHH51uENo36GOf5b4A9NQlACya2rZqkEpy
 5+aMhJTU95l0eXuNYASOI1U8XHAhqkXbeTJ/ljwoR+KQ861tVYS/Kr7j9Su6YqRS6pc+
 0yDX3QdLpJNjRz5AQ0S+LOxFAdrPrTRewX8aAcj+AyO1jDl4vlUPY+T5Wd2wv3sCMGYz
 leZ/N2mGnQxvJLe49ir/zhGrjYnP0I9BEVcVJWizjiQJuf18hBGB6K1r6V+z5vKgRF8w
 mQw2DdNgROB8jG2VhRvTBeLWNh9jiyPA/q+iNA28pn7qeOFwmJdT1GWu9hqtUMyJmvig
 bNNA==
X-Gm-Message-State: AOJu0YzcZRNTvwXNMvEcgxPZSv0EIZxYPIf8a9U49QlwKVm0Voo4E3YG
 q5Ke4LHUCaQf0vaJurmENQbSCQ==
X-Google-Smtp-Source: AGHT+IH9MKNQ7iaXwQoq4WSEXbP+8ObdXRWvMhneonVm8n7TVEHEME/UNYAY3q6P+HpFFKkBpKeB8g==
X-Received: by 2002:a17:902:ea11:b0:1bd:f69e:6630 with SMTP id
 s17-20020a170902ea1100b001bdf69e6630mr8494plg.65.1693336050983; 
 Tue, 29 Aug 2023 12:07:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jc2-20020a17090325c200b001c0cb2aa2easm9765561plb.121.2023.08.29.12.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:07:30 -0700 (PDT)
Message-ID: <1f2e1722-df35-8916-0885-d0c202b61610@linaro.org>
Date: Tue, 29 Aug 2023 12:07:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/32] bsd-user: define TARGET_RFSPAWN for rfork to use
 vfork(2) semantics.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-2-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-2-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> From: Kyle Evans<kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

