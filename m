Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2731782934
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY47P-00059O-24; Mon, 21 Aug 2023 08:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY47N-00058y-3S
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:34:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY47L-0003by-1F
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:34:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fee769fcc3so15954295e9.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692621285; x=1693226085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAhs6E6UevhHtSDVGEICqf6IXZG+9rbNBsooO/qSZSc=;
 b=MYDv5+2lzd1uLdBQd89Kzf2kQS41TmeR+SeeDK+wToQqCr1qAJ09vwxeC8YolODBHA
 1s95IGn63U1AB/0oO55F2XGgySd2j2fT71gwNOKcu90Su0i43j3ymFP/lEV9xN9Gga6m
 GbUJQAXDxpqBcqWN3K43p36e0pOdnO97IqB11fn4I9kdq//slQZb7OmcjlrA+ZFJte4W
 Oxcigh9ziM4m28XmL8mka4aO6qlytjJ+vvKPibnZJSWHsYPle4lyoHZR273LncE8H7SW
 t6w+SNCwR+csd/O2sSK4sdH9/j2Q4ZoVEKsIkzZF4g/F4FTpjm22w8SZ9rca3Ss2wTUp
 i7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692621285; x=1693226085;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAhs6E6UevhHtSDVGEICqf6IXZG+9rbNBsooO/qSZSc=;
 b=WqAVT1dnVx0XEyNguymO2JkMCZ3Dd7ltY7PtUnqvC1PjdRCEhTbKJfdIaWOnA6y+dR
 eLf5dIax+heoriUqIECwzZD8D5TkzKX3f1ET/VysSP5UYOsKynsIgHaKvm9sbbEO4CiD
 Q7ofsBH+OtloC/LTUoaCwwag+TLCd9KYmRL4X8pZL+5Hj8Najbop2dz4lFUK0NMzH8AT
 Km4Ns/1xci0Ar61vo88dj4b9/wZFxGZCO2NrUDDR3p2cvibzxJW8UC6eHvubvU6nOTWH
 dkbGHWq7Wkx3Fsk8Fyn9tgU4uJoOVHBdHlNu1Kk21TdlaZmAchNuPxa8VWzo2rUbhKLj
 lh/g==
X-Gm-Message-State: AOJu0YxFOjbi5OdMs8cScxrTwWBWK+XBwr51GYQj5WDvd1IQ25Ev9rXG
 5jYPh6HdoGskEk6DyVNVOjOOlw==
X-Google-Smtp-Source: AGHT+IFNu4p1OsaKylq1XdZAkptkD3A8fohImg+ljkFjHNDeDO1571h5UeQjP/FnuV7BiD3PUqO1jQ==
X-Received: by 2002:a5d:568f:0:b0:319:55bc:4416 with SMTP id
 f15-20020a5d568f000000b0031955bc4416mr4510771wrv.5.1692621285531; 
 Mon, 21 Aug 2023 05:34:45 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 v14-20020a5d4b0e000000b0031760af2331sm12249866wrq.100.2023.08.21.05.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:34:45 -0700 (PDT)
Message-ID: <6172a10d-96a9-9ea3-b07d-43a2a129322b@linaro.org>
Date: Mon, 21 Aug 2023 14:34:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 16/18] target/ppc: Use clmul_64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routine for 64-bit carry-less multiply.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/int_helper.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


