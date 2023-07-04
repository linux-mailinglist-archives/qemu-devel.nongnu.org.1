Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0C747422
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:30:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGh2Y-0005CV-6h; Tue, 04 Jul 2023 10:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGh2W-0005AA-B0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:30:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGh2U-0006dc-Sf
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:30:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso49296575e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688480997; x=1691072997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEsfGONhUXyIvqAMq1pA305psYj/evf+95AVezYLCWQ=;
 b=HTHwn0/KvwZzbEIQaE7Fb923FvnJW4vtepasqX8qVwl2YwoORRqf16LN8Cmh7nMcLp
 ILyAIbaqt1VO84drmbHMPyn9kxUxlMRNmnrnXoqO+jTjLnyamhFz2Ykm+dW9FkgL3wTX
 5XrDHROnp4nb9t7FmVhuHHbdEMU+8Nzr+diiT7E3QxaeOB+ztboPUEHCUruqWB8t+tTx
 e7bt4NJYPt1KfMlxMj/QRBHHmo6Zl/5sTN1OLuskxn5RbLl5dCQG2DPwSTOBUZ5CSq/l
 7BnqATdXWeTFoM0JKxgiJyHcNpLny5BWM4onUsGwjxOfuRkaoHmkZUZPMqoSSjPWJh0m
 9esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688480997; x=1691072997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XEsfGONhUXyIvqAMq1pA305psYj/evf+95AVezYLCWQ=;
 b=fn30roLpzqw/Sr3aSdCbOVY4DuMCDL5CLKrmoUEq3ZoqeOagfJqzBWbPf0FFEAL1GO
 RWvaenydZOxK4Vht7J4wuN+WbYEy3TjIUcK16Pebn6wKU3UeDVqlX3BRwF54Tk4ThCVs
 RDSpNyizYFtU615umQfsHR95jAhp8+XamzADMH+ZJCY1XUBaapZ5a4BLc8XPDnGD4t5n
 3E9AP8T6oWUCuRvy9aLJ0wq30kCv8TA9wOVgI3uDPF7EUps8j+E4YStCg9lVQ/RmMMjU
 ZlaKVh028NxBxD/m+m6JkPAu74ygq8wTWpf7SuOS3RpYmLvixtU+gq07Y7u72jx6o+G1
 GfwQ==
X-Gm-Message-State: AC+VfDxKOYbXU+NBnT6zxgyjkjNfv0wMH6brcvz2EOorKZMG/hlFXcJ2
 RA0la02jXY84ERy0ETesukdZ2Q==
X-Google-Smtp-Source: ACHHUZ5AGYCptM6HHrkWiMv4ipp3l8dnQNRxI7LWdk3/2+xn0JGmHfhXSLwIlvVgRqNyxl1gLlG/Vw==
X-Received: by 2002:a7b:cbd8:0:b0:3fb:acbe:da5d with SMTP id
 n24-20020a7bcbd8000000b003fbacbeda5dmr12301579wmi.4.1688480997149; 
 Tue, 04 Jul 2023 07:29:57 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 r3-20020adfda43000000b0030ae3a6be4asm28624066wrl.72.2023.07.04.07.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 07:29:56 -0700 (PDT)
Message-ID: <ab63c24a-db11-9e2b-1f26-29ea7bac2b60@linaro.org>
Date: Tue, 4 Jul 2023 16:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 12/15] hw/timer/arm_timer: Pass timer output IRQ as
 parameter to arm_timer_new
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Sergey Kambalin <serg.oker@gmail.com>
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-13-philmd@linaro.org>
 <CAFEAcA_BSA8s6_8BbMZG9wGWMg78u-k-GQ8ZG8n-MUCRNeEUDA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_BSA8s6_8BbMZG9wGWMg78u-k-GQ8ZG8n-MUCRNeEUDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/6/23 17:00, Peter Maydell wrote:
> On Wed, 31 May 2023 at 21:37, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Both SP804State/IcpPitState peek at ArmTimerState internal state.
>> This is fine so far but we want to convert ArmTimerState to QOM
>> where peeking at QOM state internal should be avoided.
>> ArmTimerState's IRQ is just a pointer, so we can pass/set it via
>> argument, avoiding accessing ArmTimerState internal state except
>> from the arm_timer_*() methods.
> 
> If we convert ArmTimerState to QOM then shouldn't the
> irq become a sysbus IRQ on the ArmTimerState object,
> and the looking at the internals go away automatically?

This is what happen two patches later in "hw/timer/arm_timer:
QOM'ify ARM_TIMER" (which is hard to split).

At this step ArmTimerState is not yet a QOM object (neither
SysBus), so we can not create a SysBus IRQ.

