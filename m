Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 752097427B5
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErTg-0002pk-Sn; Thu, 29 Jun 2023 09:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErTf-0002pR-93
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:14:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErTd-0006qu-Fp
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:14:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so6198255e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688044463; x=1690636463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4HGhkT2pkRfKP+xt/D+slTkYWgm6XqxwpAxVQ7LBa5o=;
 b=VkH55KNZkhRHJC9gWuZHkKYFGx91MvBasoM2cePI24HqYfiELWEIxSkvLxEz392lZ2
 iaG10wTVVMXLZL/Hwm/Mt8RQQoHE4BZ1EI/sAnh4A1fcH/GgX0yuU5nkjrc2oufHUfKg
 zuCmhDY5R0qY3HrVSeZh21P8VnIBx87sWacX1gAM/FxejJhJoB0TB6kjngnr0wpmovC5
 9+owoTco3uT8EqjspaNpclEKELRGrsg565AlqEspF5O0vwU0ei2Y+Z5a+88l7s4Y8lGy
 FwLSh1yxdlDMEjuPQuPRSHr7NK8vOAkqX0YxujYQTOe3rxmekH5vNFF741XpU6d40Q8w
 TztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688044463; x=1690636463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4HGhkT2pkRfKP+xt/D+slTkYWgm6XqxwpAxVQ7LBa5o=;
 b=JuT5Lub76Xv69osgQeanDtvaEnLb/so6N9Jyz/OZl7mP1xUuzKL4BrOxVbeh/kprUG
 UEHdfOM//g1eLQrxbo0zZtgFfileQPbygdMkSgLMCT8dpvjMpnt1u1pRXYKtQ1ASRTtQ
 GGpAQYcr7FlClNAJ1t26o0rvk/jSEyNMR26KBeXjKUlbvZ9jH+4XLuwiZof1WzwpxUI4
 SliiueIJftCBmHndtS85XaRs9uLG83quw0hXi8gy4ANu/OOE2CmHQ5+IFFDFWeyvwOuo
 Bfend4hZ6qhfU6UfCgz1F7B8OEP5J7rcvS5iG8WWrKNH2YAQKLe3/hGjUnRIXCWMcC4E
 bn5Q==
X-Gm-Message-State: AC+VfDyxcF7yEFNYbGaWAAqujZiGUiYEIayFJGM2O0CRR8kL9foikS+m
 0HhNyvYtyO+ofgibnwPGHU458w==
X-Google-Smtp-Source: ACHHUZ7vM5sFVpeE67gPsWFnipdTRE1hiU49LlYxYANpt0Och4aI9dtkqVKFZzDByI3SosDXMje+HA==
X-Received: by 2002:a05:600c:2204:b0:3fa:8db4:91ec with SMTP id
 z4-20020a05600c220400b003fa8db491ecmr9523766wml.10.1688044463026; 
 Thu, 29 Jun 2023 06:14:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm17081716wmb.11.2023.06.29.06.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:14:22 -0700 (PDT)
Message-ID: <9624e58a-1305-c522-2405-fcbb53e01dcb@linaro.org>
Date: Thu, 29 Jun 2023 15:14:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] hw/riscv/virt: Fix 'controller' typo
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230629121103.87733-1-philmd@linaro.org>
 <20230629121103.87733-2-philmd@linaro.org>
 <057c335b-a614-95c9-953d-d9eaa793d529@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <057c335b-a614-95c9-953d-d9eaa793d529@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 29/6/23 14:26, Daniel Henrique Barboza wrote:
> Phil,
> 
> I've fixed this typo a few weeks ago. qemu-trivial picked it up.

Ah great, thanks :)

> Thanks,
> 
> Daniel
> 
> On 6/29/23 09:11, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/riscv/virt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index ed4c27487e..68ccd0bde1 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -1692,7 +1692,7 @@ static void virt_machine_class_init(ObjectClass 
>> *oc, void *data)
>>                                     virt_set_aia);
>>       object_class_property_set_description(oc, "aia",
>>                                             "Set type of AIA interrupt "
>> -                                          "conttoller. Valid values 
>> are "
>> +                                          "controller. Valid values 
>> are "
>>                                             "none, aplic, and 
>> aplic-imsic.");
>>       object_class_property_add_str(oc, "aia-guests",


