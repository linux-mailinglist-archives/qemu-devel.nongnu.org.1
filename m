Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F377C736F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:48:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyrl-0004CH-Vi; Thu, 12 Oct 2023 12:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqyrj-0004C8-PQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:48:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqyrh-00054g-VJ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:48:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-406618d080eso12917655e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697129328; x=1697734128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r01YRQkFv0UxKDuIi97AXhaHGIMR5xQ/ZDGeEdmsu5c=;
 b=CxnLSQqJLgPkMXATR1m32AXoNlsCo0JiBiOHrwPk4UzR+NhWuxsG2fIFpE3JkStj/V
 lutj+SAQjVSa024SBag3RrIfDW38q2R/yFClTo2RfLHrKPvPKTzZo7KzcOAWxQd5xpnE
 S6QKx1ln8RpkYVWenNVSzsAHGT0FmZcFKl25ETlicj5tVFf6y3ivHGny9LsqeFtH3eI+
 tgOOk5qDPd6xJ+BljfCJ4HuuyipepiASASCXfHG+uHFNAPAREihvPXk/xFpvVAk5wIaR
 1wGy2m3IW4IW3CH76qdsoP5UBx/aRLk4SM2GnS41yRtc9KU9dsoI+h6NUiUGmsrN0MWV
 MLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697129328; x=1697734128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r01YRQkFv0UxKDuIi97AXhaHGIMR5xQ/ZDGeEdmsu5c=;
 b=v9ffAOUG7TWKQ6VC0UzSD+YX0cne2P4sliuLB7EC6HeXO0QfOVkpDTK18AKgSw3SQi
 NIsNuduI3EqzJSvZtHK0p/AfTcVBHXExi5uLLltAJwvjpjUgamFsP8+jqUmDmHPmQIXc
 sI/rn+B6y4EztCyC3S7d1kjvgRuOgIFy5CPy6XU8x8GY/+K8DsFmMYiyZFVzhNJP3BnC
 9C9ztasVBSeSauuBlyhpX/Xv99N/9rVdc+HWM48o2d7pRfTLCTkfXHUU67dbikIsTZDF
 3TpmfbHpwNxOHlrgM37OwBrrT19PMGjwaY5/yU/LovOZLvDB58WkJt1PIuZC7jnQWQgQ
 oawg==
X-Gm-Message-State: AOJu0Yx1d9/ylXcerNgDrVaEUre4B7D9h6Fin2KNIG3wsKkOtu+N+XFQ
 ecgwpiBpJtdn9mipl33/uAayog==
X-Google-Smtp-Source: AGHT+IG8iv2z/8y8M0wUOx0X4NgYqaS6h8Q8wWEex5SDtWilHS/K+Uwpu4H4Whl1bp+fczH4dQ1UAA==
X-Received: by 2002:a5d:4d0c:0:b0:319:7787:54a9 with SMTP id
 z12-20020a5d4d0c000000b00319778754a9mr21033872wrt.24.1697129328232; 
 Thu, 12 Oct 2023 09:48:48 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 g12-20020adff40c000000b0031c6581d55esm951727wro.91.2023.10.12.09.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 09:48:47 -0700 (PDT)
Message-ID: <6522c5f6-0d78-1344-c3ee-76b83f39942b@linaro.org>
Date: Thu, 12 Oct 2023 18:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: QOM crash via soundhw_init()
Content-Language: en-US
To: Peng Liang <tcx4c70@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <bbd3c42b-5069-d5e8-0b97-70ff5135801c@linaro.org>
 <af961171-6582-4d1e-b3bc-35d979849ff6@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <af961171-6582-4d1e-b3bc-35d979849ff6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 12/10/23 18:26, Peng Liang wrote:
> On 10/12/2023 18:53, Philippe Mathieu-Daudé wrote:
>> Hi Martin, Paolo, Markus, Marc-André,
>>
>> With the following changes:
>>
>> -- >8 --
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 137276bcb9..291495f798 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -245,6 +245,7 @@ static void ibm_40p_init(MachineState *machine)
>>       uint32_t kernel_base = 0, initrd_base = 0;
>>       long kernel_size = 0, initrd_size = 0;
>>       char boot_device;
>> +    MemoryRegion rom;
>>
>>       if (kvm_enabled()) {
>>           error_report("machine %s does not support the KVM accelerator",
>> @@ -277,6 +278,9 @@ static void ibm_40p_init(MachineState *machine)
>>           exit(1);
>>       }
>>
>> +    memory_region_init_rom_nomigrate(&rom, OBJECT(machine), "test",
>> +                                     4 * KiB, &error_fatal);
>> +
>>       /* PCI -> ISA bridge */
>>       i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
>>       qdev_connect_gpio_out(i82378_dev, 0,
>>
>> ---
> 
> I think it can be fixed by changing the type of rom to MemoryRegion*, such as:
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 137276bcb9..b5c2345ec8 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -245,6 +245,7 @@ static void ibm_40p_init(MachineState *machine)
>       uint32_t kernel_base = 0, initrd_base = 0;
>       long kernel_size = 0, initrd_size = 0;
>       char boot_device;
> +    MemoryRegion *rom = g_new0(MemoryRegion, 1);
> 
>       if (kvm_enabled()) {
>           error_report("machine %s does not support the KVM accelerator",
> @@ -277,6 +278,9 @@ static void ibm_40p_init(MachineState *machine)
>           exit(1);
>       }
> 
> +    memory_region_init_rom_nomigrate(rom, OBJECT(machine), "test", 4 * KiB,
> +                                     &error_fatal);
> +
>       /* PCI -> ISA bridge */
>       i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
>       qdev_connect_gpio_out(i82378_dev, 0,
> ---
> 
> In the original patch, rom is an object on stack and machine will save a reference
> to rom in its properties after memory_region_init_rom_nomigrate. When the function
> returns, the stack frame is freed and the data in rom becomes to garbage. After that,
> when we call object_resolve_path_type, the properties of machine will be used to
> match the specific path and type, then we will use some garbage in rom (which is on
> stack).

YES! Stupid mistake... Thank you Peng, you saved my day :)


