Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B56735819
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEeK-00030i-Nr; Mon, 19 Jun 2023 09:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBEe6-0002zw-73
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:10:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBEe4-0003QH-L4
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:10:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so5003811a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687180210; x=1689772210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jmEdz1JmATUymmiFQEZlY3ftI+epZiWOQi6A4u37OtE=;
 b=uz+GlbWZe2E2UMQDDQ0bWvYtXxcX6Qz9x0vHgRjgMmEaXXP3k6Cw1Xrg1w12xJHydE
 GixRatJWkHgnmMhduXxPtq/YNWEgr3GAvznawuK4N8QcmdUF8aePm03NUIanpL0PSZIz
 hqOhZS+gShTbQnjiG9ln1SEfVY7ARl4yCy9D+vBv9DGmqBsm868248Sss4o3vrYdU4bM
 ndSz6ErH3Rq6pPb8i2zzcAG93fmlt8eoHVAxntezZhu+S5nhUr6MZ3NoT0ZcNXgagb9u
 skC7hc0fD+8/ndJNxLgKuATrMiQJm1gy6kOxzo/FBKlikVzEj0YeM9BNQ/lqSzCCS598
 b3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687180210; x=1689772210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jmEdz1JmATUymmiFQEZlY3ftI+epZiWOQi6A4u37OtE=;
 b=etswYPxe4XeHIBIMeWj8xT3mbSR33D7q9/usHLnlR/97TberpBqtLHB6gJ8Q4PYF+Q
 okoRSp0wvq4sRF1eUA99K2PDu618P4R3sehxQJrfZ9OXkgfFc7LKlu6GjyIH5vPZGkE8
 NTAeQVPMrAp3/oSJnrA/nureC/dyuwFkO83+P1RXm60yqgJ1jLAgqROLWUlmh+Hza2jT
 vRKdBQpaO7txuozYa9iNDczBXe+2xVeyvdzIFLX1J9RhW2X/7qqQhATzZw4M1PlEjHVk
 f6Z5ZJSXR/Fks+zhy54rGcqvkPLgWsnLBTMDAMxXG8A9yJK5PfwlubyTQHG4gtokJx9Y
 hPzw==
X-Gm-Message-State: AC+VfDxylc4cStJrz7PrbJmi596IXdkVU7hl7WZcxXRxADGrI4a464YB
 CaLsxmPHAhDLNj/PIcOwsJ0kew==
X-Google-Smtp-Source: ACHHUZ7hSzT0dGJ6eh1PjtxftkhZ0cx4DXMM17gjZFdStxFfr69t0SRsx5ANDTMfp5odNBh91XpF8Q==
X-Received: by 2002:a05:6402:121a:b0:51a:4628:d3f0 with SMTP id
 c26-20020a056402121a00b0051a4628d3f0mr4543304edw.38.1687180209983; 
 Mon, 19 Jun 2023 06:10:09 -0700 (PDT)
Received: from [192.168.69.115] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 a24-20020a50ff18000000b0050bc4eb9846sm12962042edu.1.2023.06.19.06.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:10:09 -0700 (PDT)
Message-ID: <bf02a3c4-7961-00a3-db42-031d0ecd1942@linaro.org>
Date: Mon, 19 Jun 2023 15:09:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] imx_serial: set wake bit when we receive a data byte
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Martin Kaiser <martin@kaiser.cx>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230608154129.133169-1-martin@kaiser.cx>
 <20230615142256.1142849-1-martin@kaiser.cx>
 <CAFEAcA84ng=jMTvb+XHrvGatf7UOPNxg7u+m-LXKVYT_kaDm5g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA84ng=jMTvb+XHrvGatf7UOPNxg7u+m-LXKVYT_kaDm5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 19/6/23 12:36, Peter Maydell wrote:
> On Thu, 15 Jun 2023 at 15:24, Martin Kaiser <martin@kaiser.cx> wrote:
>>
>> The Linux kernel added a flood check for RX data recently in commit
>> 496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
>> check uses the wake bit in the UART status register 2. The wake bit
>> indicates that the receiver detected a start bit on the RX line. If the
>> kernel sees a number of RX interrupts without the wake bit being set, it
>> treats this as spurious data and resets the UART port. imx_serial does
>> never set the wake bit and triggers the kernel's flood check.
>>
>> This patch adds support for the wake bit. wake is set when we receive a
>> new character (it's not set for break events). It seems that wake is
>> cleared by the kernel driver, the hardware does not have to clear it
>> automatically after data was read.
>>
>> The wake bit can be configured as an interrupt source. Support this
>> mechanism as well.
>>
>> Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> 
> 
> 
> Applied to target-arm.next, thanks.
> 
> -- PMM


