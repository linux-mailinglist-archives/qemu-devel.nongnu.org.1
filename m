Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EAC731528
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 12:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9kAQ-0000ac-1x; Thu, 15 Jun 2023 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9kAE-0000ZY-MK
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:25:15 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9kAC-0007ie-3T
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:25:14 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-982a88ca610so61542066b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686824710; x=1689416710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ft2Mh9fiIf5GfqCvoGdPnZrt5zD3PwtSMKH21zHeixA=;
 b=OSp0fRFJIyR4sQVwsLL6hfE94Ef3NtA2V2mR0/lthfFpt4KpMTqoSwqdsvX6aJpwxi
 01unJr/B+e+qaiMPENK7psU9YqH9/BG1JJZGrCmoJ0ge4Y4cEa5ysy0rvtHRHRvJEEdR
 o6MoER0e+Vx3+rWeuzn6hBrcIPTNAf9Xf6E9oidMHBjZU3eqGezran/+BAcmQMd4Wour
 1uwKmBVlKY9Yy0A9u3WRyjPTC9UEj8WMJXqDjUXB2fRD60UkEKs/UcCNCjPUued3rP6O
 BP1HqbWQMgaj8n0IOdSe289bOJ7sSJU1xbCUCYe15sK4ryvQ1sf3cSdlfvD3eGzhny9B
 Q1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686824710; x=1689416710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ft2Mh9fiIf5GfqCvoGdPnZrt5zD3PwtSMKH21zHeixA=;
 b=KGteiDROSciDfv3qStuRmYAiV8RjWYl24UYuPREUuaxAtEk9ug1xAnukSW3trS54nK
 nDLdo1DkMCyWoSkD7hJ3i1BaUZ9BPerRxSDJOOB2L+rX/b4y4EjsfzpfrGB5wKr2kfI3
 99EhQaKUz1SYWewz97BMHX+S30eaK6Qfqxh4/ZjxVni++1WGa+imym2uEYVEyiTOXxkp
 TFzkChzooVkB2e3h/PSb6kSbvCq9bgK7oVQLTkj4FTQZmRJaXbNQNDkC4ycPJmc8u++h
 Co7AgtRqM6yxGfr7QWSTAaiHzjLtsqysj8WqmWtHaRtE6gBUY5jh4AnwNSGYKR+cJ92w
 tBgw==
X-Gm-Message-State: AC+VfDxJBaoAyvL3jL1PA1CKKreBZawcJe+ULcNHdzF0H1+UtmMCSoKw
 WWN1oYkIA7I53UitswWil/+30g==
X-Google-Smtp-Source: ACHHUZ5kVPl68Mv6uyuDJMkBqOm3Lsds446DEmNzav88j66AtHBXlDlN4t6fKQwh1/WzzdGsuhhiQg==
X-Received: by 2002:a17:907:9309:b0:96a:861:a2ac with SMTP id
 bu9-20020a170907930900b0096a0861a2acmr17036228ejc.0.1686824710415; 
 Thu, 15 Jun 2023 03:25:10 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a170906140e00b009786ae9ed50sm9146240ejc.194.2023.06.15.03.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 03:25:09 -0700 (PDT)
Message-ID: <580b6ade-fb79-870b-eefa-5c0f0acfa7cd@linaro.org>
Date: Thu, 15 Jun 2023 12:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2] imx_serial: set wake bit when we receive a data byte
Content-Language: en-US
To: Martin Kaiser <martin@kaiser.cx>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230608154129.133169-1-martin@kaiser.cx>
 <20230615093054.1084972-1-martin@kaiser.cx>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230615093054.1084972-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 15/6/23 11:30, Martin Kaiser wrote:
> The linux kernel added a flood check for rx data recently in commmit

"Linux", "commit"

Also maybe s/rx/RX/ s/uart/UART/.

> 496a4471b7c3 ("serial: imx: work-around for hardware RX flood"). This
> check uses the wake bit in the uart status register 2. The wake bit
> indicates that the receiver detected a start bit on the rx line. If the
> kernel sees a number of rx interrupts without the wake bit being set, it
> treats this as spurious data and resets the uart port. imx_serial does
> never set the wake bit and triggers the kernel's flood check.
> 
> This patch adds support for the wake bit. wake is set when we receive a
> new character (it's not set for break events). It seems that wake is
> cleared by the kernel driver, the hardware does not have to clear it
> automatically after data was read.
> 
> The wake bit can be configured as an interrupt source. Support this
> mechanism as well.
> 
> Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
>   - support interrupts from wake
>   - clean up the commit message
> 
>   hw/char/imx_serial.c         | 5 ++++-
>   include/hw/char/imx_serial.h | 1 +
>   2 files changed, 5 insertions(+), 1 deletion(-)


