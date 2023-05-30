Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57203716EE1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:34:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4625-0005bj-DP; Tue, 30 May 2023 16:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4623-0005bS-GZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:33:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4621-00049E-LY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:33:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30ae7cc0e86so2975603f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685478804; x=1688070804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=28kMARIyfwZxuvAkzPZT14SvXNSySkYf1ablxOFuT0U=;
 b=avI/cfmJKGOieqnA+Lp32fp88ZnTtJ+PqbrGqeMvFwK1EHFKxJaCZtP4lcV6QBNOS2
 IlIxhHCb5tGhpQtXRtjvxw2PirkbKXXiHU+g34YzdIsxzlmjXTw9VLByN02G4OBekvFu
 VYjCQRKRv2kWZwDO9b9E1M9p5p/yM6+FnxMoHO27nTN3VuD2MSEYjeMxwQKFO7P2Iken
 IK3ygxV5b1p0/11PrrHnIKn0ySmQpMg/LAd6ehN795ftp6Rw47i5t+OMboANa6rwP7ZH
 4J62UKIs3WuMCe0haQ5XMz1HiIWXmkE24Aw8lBcHfMM+aApgbn4KlG5FrOAEiwsT64Hf
 kGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685478804; x=1688070804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=28kMARIyfwZxuvAkzPZT14SvXNSySkYf1ablxOFuT0U=;
 b=UzXEd95gZABEMUnP+l2X+OZJh3MWtn2x1ybBZo2XgJFyg+zvl+aHJE9HWXZJUKXpRr
 M1gW6t07gJnKJymKt5qDb3j5UVVKAJAA1ixQa025I/l7s5MWzsjGfbx2i1AHjJUjh8L1
 2npku4as6CBljKLG3nTKfIv1d/1t/ZEz1vxR+L9Ig68c7VE7QUFAUimY4nCJlzCqNzkn
 z28eSIX2lguR8xe5jgjHfZJ71Ln1Ixgk+821ZS+KFuwLCthYvy7vB7/BwEO9y+mqURl5
 e2HC+2vg7Uz8qOPlD50FKYgVmTYsByzqyMEzpIz2HQkSMqNscffamXkRMX8il2DxHGRU
 GMLQ==
X-Gm-Message-State: AC+VfDz8alaqhXsWaL3CSKpkL/u3cHRve5EfFwH14B+TcXp3WJ/dL9hY
 dBpFAMA5qSIUikL8BnWqhegrIA==
X-Google-Smtp-Source: ACHHUZ5aK+1atv6t8PP0OgLh1XN1vKTQ1wMpx6YNAredPdCgSbgumkEBCFLNIsLd4cucoumNQX0/6Q==
X-Received: by 2002:a5d:590e:0:b0:30a:ebe2:5e4f with SMTP id
 v14-20020a5d590e000000b0030aebe25e4fmr3358919wrd.36.1685478803832; 
 Tue, 30 May 2023 13:33:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 x15-20020adfdd8f000000b0030ae3a6be4asm4332223wrl.72.2023.05.30.13.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:33:23 -0700 (PDT)
Message-ID: <dc9883f1-0d36-d86b-caf0-a54f18861913@linaro.org>
Date: Tue, 30 May 2023 22:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 04/12] hw/ssi: Add an "addr" property to SSIPeripheral
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-5-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-5-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> Boards will use this new property to identify the device CS line and
> wire the SPI controllers accordingly.
> 
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/ssi/ssi.h | 3 +++
>   hw/ssi/ssi.c         | 7 +++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 6950f86810..ffd3a34ba4 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -64,6 +64,9 @@ struct SSIPeripheral {
>   
>       /* Chip select state */
>       bool cs;
> +
> +    /* Chip select address/index */
> +    uint32_t addr;

uint8_t is probably enough.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };


