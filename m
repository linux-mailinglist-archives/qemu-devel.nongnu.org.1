Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA972ACAC
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80m2-0002zj-M8; Sat, 10 Jun 2023 11:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80m0-0002yx-FL
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:45:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80ly-0001nt-NI
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:45:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-653436fcc1bso2453150b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686411901; x=1689003901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MAemMD4RvbZWi2VOmxme+WZoM1xm6sNL2TioFv41nq0=;
 b=s6YEZTTIEYo41YYhKmyOlui9kMDWqVvVjWVySmBjr2pASewTqez9p2d2ri24hjXlsH
 redXl7h8ijzjMVZn5x5l/+1neqZkFI1tbUFnACPU4N7f+cI6nSTnoy99zSOXlDyVlPeP
 DqX3ERWgQYavvrqf7BCHq1PIxttN6Azf38pC46dlFscvHolqzRsEDMMjt9oF0tWblXFZ
 TAlyY8CIzUMFgXWUJCNJA4hnmPSMryCGuwvjFPa+q8kfcllwU1YYDIF6nS3K83BTOy1c
 rzca1tl6JzKBEv3/A0iIKXzRpmv/xSvHM8yJvAa0yW+Y7ncRtIbVJRIGov7jHjv/AlER
 2k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686411901; x=1689003901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAemMD4RvbZWi2VOmxme+WZoM1xm6sNL2TioFv41nq0=;
 b=LYtn8a3JEOE72QoeXhDaLSxkHDSLBfEQ43z/wHZ2FiRfCbsrZbDRV9Vc56C5Z6kdZa
 VuV9fecwcBniQFF6ZrqLf26R801qxTiHgmSj5DKHLi+ZoIEWobKTKj14lL1dGN1IWbOA
 hwPDxhMPDtCqbubzf4V1XquPUVLK/4W0t17r3u5lMfIrjiDd3U3UO3xhFRIkGrybwkrr
 Y6ix6QaprwuWiJeqHPnNTscsuIVxBYHg2CCDEk/VEnTEqgWDTqr9PKsdg9T7Rk8GNhxw
 2i+6lfpvmPLMxsbCxXqFBmPFKvCVZ29/Qoagt79OR7ddKdnc9kWTNhe6aO3DOEkSRpD8
 R8Fg==
X-Gm-Message-State: AC+VfDxWr/ageKBUoypkA8NZpYd6ex49hKxaRNGmGeTy97nv++7huOPr
 jF3bCaq8Jf4tOp4wYmB3j9Y+KA==
X-Google-Smtp-Source: ACHHUZ7uCeY72tCEeOETtLJSZYXMtLzobVM5Rk/NRyq3bhZQ5SNfTW1hDQo6of6vA8QQ+wG3oxwJtg==
X-Received: by 2002:a05:6a20:a296:b0:105:b75e:9df6 with SMTP id
 a22-20020a056a20a29600b00105b75e9df6mr3787229pzl.26.1686411901230; 
 Sat, 10 Jun 2023 08:45:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 73-20020a63014c000000b0053ba104c113sm4677370pgb.72.2023.06.10.08.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:45:00 -0700 (PDT)
Message-ID: <39ffe72a-c8a4-8982-c411-16cf88493b27@linaro.org>
Date: Sat, 10 Jun 2023 08:44:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/29] ppc queue
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org
References: <20230610133132.290703-1-danielhb413@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/10/23 06:31, Daniel Henrique Barboza wrote:
> The following changes since commit 3673ad389622d9ef4d2743101253c642def7935a:
> 
>    tcg/tci: Fix MemOpIdx operand index for 3-operand memops (2023-06-09 08:30:56 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/danielhb/qemu.git  tags/pull-ppc-20230610
> 
> for you to fetch changes up to 9ec08f3569be3bc8bfd4d9b8b0445b9136910661:
> 
>    hw/ppc/Kconfig: MAC_NEWWORLD should always select USB_OHCI_PCI (2023-06-10 10:19:24 -0300)
> 
> ----------------------------------------------------------------
> ppc patch queue for 2023-06-10:
> 
> This queue includes several assorted fixes for target/ppc emulation and
> XIVE2. It also includes an openpic fix, an avocado fix for ppc64
> binaries without slipr and a Kconfig change for MAC_NEWWORLD.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


