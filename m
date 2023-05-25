Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA86710BB8
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29kQ-0000wk-2P; Thu, 25 May 2023 08:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29kI-0000vf-M7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:07:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29kD-0000Rg-Va
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:07:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2ebso3848775e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685016420; x=1687608420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L2uv7Q7ZnDtTuxAfDbORIWXUwCaDJBLgKwq1sJytB6k=;
 b=k+0TFpATCFSDXpX+9U5EF7mRcSNiD8Vzk/RCTQYR4n0rm8FuJb5yuTuEjd9xAijmN+
 hK+vskUBTCXFoOMR/+WtuPPyEY6fvDEhtPzg36Q0kQtDwzY69wkvdekeglyID4FpK3oR
 EKR706Klv+O44Tmq0HfFXjvgenI7GPZcwJqU+r1HaMVJJHAl7TAo65OnL0nYwN2gsRxp
 xnFSoIbhB5XbkPic6FP02/v2V5Ej6dsy5XvQ06BZFvDoPspqWgbkiqNAHkR5rjf235wC
 sWPAv7t7CFqo1mYvCMn77CnO5eFmALDPWEQtvGqNenQhIAphy5LIHYxEf6TqU8Jbq4YG
 kCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685016420; x=1687608420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L2uv7Q7ZnDtTuxAfDbORIWXUwCaDJBLgKwq1sJytB6k=;
 b=kswsPJC7bQL2HrQvoIzbFBUD4WE+TposrJZVHgPwl1DKLd1i69NtQskYaNmiATs5CR
 syNDHtSSP6i5FwGUI7rnLjmiigEqnXfh3fsw9VZvUqxsPEPo/lQgutks1VG8oC13PKHZ
 5gzW/q3qEq4bAWlGsasEm3cYv38q6BmXiA660uJZoEkaM8YaveK/YFMJBii3VvGUg/7c
 odPthrz9n/a1KrtpuE7qwTXfAyN2esKsAudljkcllcmg+Irgwq8IbS+TdTtpQkz4RWkB
 qPIdMG4nJIfImGpENlfR/obJ8PNRR+UsFkK2DW9KhvttpBL8Mt90MgWxdDOYKfUGmrJ+
 Mc+A==
X-Gm-Message-State: AC+VfDwt2pjfWqj/THU5sYKTpy2e/ULodiCpscvVTEcECsQDtPb7bTGi
 INBFtZGD5Ak4yRK4Ira9gCOW4g==
X-Google-Smtp-Source: ACHHUZ480q2SsY5LO3jMlHTn1krZ+7Gtj1rhiPSuSVwcKW+YdhjK+KKomjprDwZVDzB2p5k62MKpUA==
X-Received: by 2002:a05:600c:2255:b0:3f6:1e6:d5a2 with SMTP id
 a21-20020a05600c225500b003f601e6d5a2mr2411559wmm.4.1685016420247; 
 Thu, 25 May 2023 05:07:00 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f4f89bc48dsm5647135wml.15.2023.05.25.05.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 05:06:59 -0700 (PDT)
Message-ID: <1f33d65c-39a2-ceff-56dc-1982499066c6@linaro.org>
Date: Thu, 25 May 2023 14:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/3] hw/riscv: sifive_e: Support the watchdog timer of
 HiFive 1 rev b.
Content-Language: en-US
To: Tommy Wu <tommy.wu@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 jim.shu@sifive.com, frank.chang@sifive.com, thuth@redhat.com,
 liweiwei@iscas.ac.cn
References: <20230523084910.304679-1-tommy.wu@sifive.com>
 <20230523084910.304679-3-tommy.wu@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523084910.304679-3-tommy.wu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 23/5/23 10:49, Tommy Wu wrote:
> Create the AON device when we realize the sifive_e machine.
> This patch only implemented the functionality of the watchdog timer,
> not all the functionality of the AON device.
> 
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/riscv/Kconfig            |  1 +
>   hw/riscv/sifive_e.c         | 13 +++++++++++--
>   include/hw/riscv/sifive_e.h |  8 +++++---
>   3 files changed, 17 insertions(+), 5 deletions(-)


> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index b824a79e2d..a094b47e0b 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -35,6 +35,7 @@ typedef struct SiFiveESoCState {
>       /*< public >*/
>       RISCVHartArrayState cpus;
>       DeviceState *plic;
> +    DeviceState *aon;

Preferably allocate the device state in the SoC, similar to gpio:

         SiFiveEAONState aon;

>       SIFIVEGPIOState gpio;
>       MemoryRegion xip_mem;
>       MemoryRegion mask_rom;
> @@ -76,9 +77,10 @@ enum {
>   };
>   

