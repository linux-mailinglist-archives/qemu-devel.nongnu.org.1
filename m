Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2174574F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEto-00009D-0q; Mon, 03 Jul 2023 04:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEtl-00008r-Eb
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:27:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEtj-0007W2-PO
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:27:05 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so4578552f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688372822; x=1690964822;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+g3yvbP4PQ9J1yw+Le3GL4jy81faKVCF59ath6WJBjM=;
 b=xokzJ5SWrHYWN1XhoTg6yMP0ec1CnjXYIn3VCnrJaruDWjG2QvWdt/ZMld9lh/LmaD
 0ctnbldbudG48rs87t5MGhIFTkHPfwq6Awc1DCBjte9F+rv5KOZGoyc7chR8cimCRByG
 u7vYRBbT8rk/hiOkiiuP2W9mv6JIquB9S+MYGQ3VhUYm2+bADew+j5hEJ8AZPMMkjgrg
 vi+8rDeJI9Hj5jVXI7xjEcV9nuiSFcdvVYXXd1M2Z2lJSsUWo1dVT1VXqdNQk5nQehhP
 MCQdktfUD9M223eVqabHKKeBn7tdS8uhIJHMhfF+8LiWin0LKph1ixQ5DUG44LwH7oAS
 lk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688372822; x=1690964822;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+g3yvbP4PQ9J1yw+Le3GL4jy81faKVCF59ath6WJBjM=;
 b=Yu3sDV/s73IPt2ttEzCj9RXVqbyZPB3OjEHIw5TIWAm9XMdeeJx4kl9vsjq9/EeW5K
 zzJV5mqZc4a/ZtNWG3EflNA6HxIEyLXd20PrTpKcpa5B2r1ZDcfzrUMnPpZxrIjILIXA
 V4Vx173zprYRH14enmtB8y0MViDnuTuACil8Q+kM3lqljcGDTtKJjTf0LzkAeWZI7xDS
 xzJ3Fw7Nuxf+NtTNeW3Io0c8bCAJbFY99bBkZ1f9yooj9bXNqLhPHp/nwnHL57JMICkA
 58s7fzRsokHWaOunwlQICpU9QnJ7ATllQGkebBKmthW2rDc/aP5Tdn3fK5OvZLSPVeIY
 he0g==
X-Gm-Message-State: ABy/qLYt3Mtfo92ehfRh8zYP5N6uhIfjDQkWiN15Rx8e7NwypVgPrsCf
 /lgA4DTvc6gczwnIk1Nhj5NTmg==
X-Google-Smtp-Source: APBJJlFqNrIXN+r+87Hy8t6aDUazduK+S5gp5s0b/YksyltA28nSCDvZuvqSTCblE3NHgENF8qNzaA==
X-Received: by 2002:a5d:58d8:0:b0:313:ee2e:dae1 with SMTP id
 o24-20020a5d58d8000000b00313ee2edae1mr7127552wrf.18.1688372822330; 
 Mon, 03 Jul 2023 01:27:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d6550000000b00313f4304bcasm19304047wrv.16.2023.07.03.01.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 01:27:02 -0700 (PDT)
Message-ID: <575796cd-6460-b9ea-bfcf-8f27fadf0920@linaro.org>
Date: Mon, 3 Jul 2023 10:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 11/21] swim: add trace events for IWM and ISM registers
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-12-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230702154838.722809-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 2/7/23 17:48, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/block/swim.c       | 14 ++++++++++++++
>   hw/block/trace-events |  7 +++++++
>   2 files changed, 21 insertions(+)


> @@ -267,6 +275,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
>       reg >>= REG_SHIFT;
>   
>       swimctrl->regs[reg >> 1] = reg & 1;
> +    trace_swim_iwmctrl_write((reg >> 1), size, (reg & 1));
>   
>       if (swimctrl->regs[IWM_Q6] &&
>           swimctrl->regs[IWM_Q7]) {
> @@ -297,6 +306,7 @@ static void iwmctrl_write(void *opaque, hwaddr reg, uint64_t value,
>                   if (value == 0x57) {
>                       swimctrl->mode = SWIM_MODE_SWIM;
>                       swimctrl->iwm_switch = 0;
> +                    trace_swim_iwm_switch();
>                   }
>                   break;
>               }
> @@ -312,6 +322,7 @@ static uint64_t iwmctrl_read(void *opaque, hwaddr reg, unsigned size)
>   
>       swimctrl->regs[reg >> 1] = reg & 1;
>   
> +    trace_swim_iwmctrl_read((reg >> 1), size, (reg & 1));
>       return 0;
>   }


> +swim_swimctrl_read(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_swimctrl_write(int reg, const char *name, unsigned size, uint64_t value) "reg=%d [%s] size=%u value=0x%"PRIx64
> +swim_iwmctrl_read(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64
> +swim_iwmctrl_write(int reg, unsigned size, uint64_t value) "reg=%d size=%u value=0x%"PRIx64

For these 2 functions, 'value' is 1 bit so could be 'unsigned' ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


