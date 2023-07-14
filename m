Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A07541E9
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKN4J-0006mX-6S; Fri, 14 Jul 2023 13:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKN4G-0006m7-I2
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:59:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qKN4B-0004sj-RD
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:59:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3158a5e64b6so2258569f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689357534; x=1691949534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63cOYQti04lv3TX4cSS5rVV63tCFOxOifmFN9NwWBIU=;
 b=DYnHt05zRrI8B/DRvXP74EfXzhi67Fa8odAfCVLqlsRwhjNh/0mi/vmsRJ553SQz4u
 x/5yu1N1Gc30XNVTZRKhKHNOktnkkfHUmTZXx6Iu/kBjdTmkjlAaxkT4Gq01IeK++XH/
 mdl3AZ4npCeSCJf+0ZltF4jdiFbE+TZfhvqCVaS3w8dhCW8sWhRH3bJvX8Dd+xipQ9Ti
 jQH4GDWhOMsksJ0ZvUYXXoE/sRGLvphsHrJnCSHYS2GmUhkNEHcM134YhO/Vjsmr+Hvn
 wP5ZHDXU0UzBhDSTM1a1LP3Iro4FK+yUnzaHFFOT7FfXqDYvTY5JL5yRd63/eGc0R+tP
 D91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689357534; x=1691949534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63cOYQti04lv3TX4cSS5rVV63tCFOxOifmFN9NwWBIU=;
 b=IL4yFrMMuejkmE5molUQvvUGMfzFrH5Q+JysN52WtxVbk8H2HO1xZrgYTUG5w2DRz9
 8u/WDv1V67pZCnSiNEIw7q1n7WFKpJ5axOv3gAGtBwlfthV4Y1Bf/YyuRWLw4TZVlKwT
 HHnn+PH4HzMYBs1GoqE1VowMKbuuLJlEfUF2ecMFWcs5vWw1H1ajkkjVo4rl0nQXiWGg
 JlXcZLYzM7PRI2VXXMZMTBjA9Pyp55LoZK1icBtJds8Y6/ixPbgApADAqDAA9ktfubU0
 B8E0anji9XFQQrQ182wM+OICnsq0+jv1VfDZzJqEf6zjYVXTM8fCt0Hd0U6oPs7ET0xs
 C5KA==
X-Gm-Message-State: ABy/qLYQ0IdbvVKE4Yr1F/N9VoaKogFpKlx2fCIDqnEDplUAjSUBoBPc
 aCPWtwZ7Rika0vNR2M5Q7q45Gg==
X-Google-Smtp-Source: APBJJlHgDa6CPIfmAHwa401YcfN4tR77J1cQvAxKbGZlw4XgzvULbQOyn36jJWDxN4qj4KPNLl4+Ww==
X-Received: by 2002:a5d:6301:0:b0:313:f548:25b9 with SMTP id
 i1-20020a5d6301000000b00313f54825b9mr5113049wru.40.1689357533844; 
 Fri, 14 Jul 2023 10:58:53 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d4492000000b00315a1c160casm11465782wrq.99.2023.07.14.10.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 10:58:53 -0700 (PDT)
Message-ID: <6697efa4-c76c-deaa-178f-1d7fccf08b04@linaro.org>
Date: Fri, 14 Jul 2023 19:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PULL v1 1/1] hw/tpm: TIS on sysbus: Remove unsupport ppi command
 line option
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: peter.maydell@linaro.org, Eric Auger <eric.auger@redhat.com>,
 Joelle van Dyne <j@getutm.app>
References: <20230714154101.184057-1-stefanb@linux.ibm.com>
 <20230714154101.184057-2-stefanb@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230714154101.184057-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Stefan,

On 14/7/23 17:41, Stefan Berger wrote:
> The ppi command line option for the TIS device on sysbus never worked
> and caused an immediate segfault. Remove support for it since it also
> needs support in the firmware and needs testing inside the VM.
> 
> Reproducer with the ppi=on option passed:
> 
> qemu-system-aarch64 \
>     -machine virt,gic-version=3 \
>     -m 4G  \
>     -nographic -no-acpi \
>     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>     -tpmdev emulator,id=tpm0,chardev=chrtpm \
>     -device tpm-tis-device,tpmdev=tpm0,ppi=on
> [...]
> Segmentation fault (core dumped)
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Message-id: 20230713171955.149236-1-stefanb@linux.ibm.com
> ---
>   hw/tpm/tpm_tis_sysbus.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index 45e63efd63..6724b3d4f6 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -93,7 +93,6 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>   static Property tpm_tis_sysbus_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),

Since properties are user-facing, shouldn't we deprecate their
removal? I'm not sure so I ask :) Otherwise we could register
the property with object_class_property_add_bool() and have
the setter display a warning. Anyhow I suppose now setting
"ppi" triggers some error, which is better than a abort.

>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


