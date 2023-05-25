Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E230710739
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q26Cz-00051o-FP; Thu, 25 May 2023 04:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q26Cw-0004zp-L9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:20:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q26Cu-0004O7-Rk
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:20:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-309550263e0so1735025f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685002822; x=1687594822;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fvLtCVz/bbUwU/myrh3gFGFiwuibJbLG+X0fMV7/uY=;
 b=SLXw/oAQPwtKIS35fBkZCWq5qmP1ik4gYP4WgbJ9JCtxMGv1zr+tce3zoGJBX3TQjQ
 WXfsNcQNdmOjGYx01mUNInq743dlg6yJNm1JffwbHQNeT+q9tPqw074GNcDj6bM6cmOj
 CZ5v4iW0AtLzJfQzA2U5jA73a2T4+RsRWwwclNJJGlP23T9LohWZgWWagvnXSVh2E2yX
 pEPbgMmB/H1aLPh/MpumoRL2UtCBFsIfXzlrqdAUVp40+8gi19VzEkQjRbNUXGMrk578
 yqmiEA6gxtxGJJHRD9t3tbVvwJg4BH794jrtJR1uV/s9m9v4Rbh8U53n3F7JYni+GoTh
 nTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002822; x=1687594822;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fvLtCVz/bbUwU/myrh3gFGFiwuibJbLG+X0fMV7/uY=;
 b=R6PaGFzMUFZ3Naj017XYp0D4DPrpE5gHHl3Z+vy0apfnGCuxuTQtc38L6OxysQzsEA
 8qEVKdJtD+kfI+9TjHRKGhuaH9ssGlMCL66082TRVUralA+2s72TdAUecwxbA49r0/nu
 20o2zo4ET9iAh4Hpd2hLz0OYyo14Qm+jbwqTruNm8zTvyi/4ZuoBo5Uz26A/7kdrZ+gw
 6PLNePPfWSVLOWFMlp45OPd3xVf+OFWt1eXRvJSyeck67iuB6W0no6taRbjc0/FyW4ei
 WS7jG3I4UFLD2WiJhW50ZaOCHf8O2tkc3NopG3PxBx7UBvQNWw31wnbNaxW7EbpK95tc
 aLVw==
X-Gm-Message-State: AC+VfDyV6EtBPwmlQOb8NuX3wGhAr4eFp5pSNzo+rup5Vc4+PmUCkFY/
 MZ3363EabRMGqLsbPrldxTOOxQ==
X-Google-Smtp-Source: ACHHUZ7XQrFMDsvhQESa1i70DJ15Ktc0cI+JGMLMv4215NNNJVTJZUhvVakDS3xvaBgSbCKREFxlLw==
X-Received: by 2002:adf:f391:0:b0:306:4273:9efc with SMTP id
 m17-20020adff391000000b0030642739efcmr1859622wro.40.1685002821712; 
 Thu, 25 May 2023 01:20:21 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b0030647449730sm935635wrm.74.2023.05.25.01.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 01:20:21 -0700 (PDT)
Message-ID: <fa2e13a7-1fa7-a410-5835-24248d2ae643@linaro.org>
Date: Thu, 25 May 2023 10:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 13/30] q800: allow accesses to RAM area even if less
 memory is available
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-14-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-14-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> MacOS attempts a series of writes and reads over the entire RAM area in order
> to determine the amount of RAM within the machine. Allow accesses to the
> entire RAM area ignoring writes and always reading zero for areas where there
> is no physical RAM installed to allow MacOS to detect the memory size without
> faulting.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 8310670ec2..d12aeaa20e 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -86,6 +86,9 @@
>   
>   #define MAC_CLOCK  3686418
>   
> +/* Size of whole RAM area */
> +#define RAM_SIZE              0x40000000
> +
>   /*
>    * Slot 0x9 is reserved for use by the in-built framebuffer whilst only
>    * slots 0xc, 0xd and 0xe physically exist on the Quadra 800
> @@ -452,6 +455,27 @@ static const MemoryRegionOps machine_id_ops = {
>       },
>   };
>   
> +static uint64_t ramio_read(void *opaque, hwaddr addr, unsigned size)
> +{

Similar to empty_slot_init().

Personally I like to follow firmware detection using trace events here.

Maybe s/ramio/ram/.

> +    return 0x0;
> +}


>   static void q800_machine_init(MachineState *machine)
>   {
>       Q800MachineState *m = Q800_MACHINE(machine);
> @@ -497,7 +521,11 @@ static void q800_machine_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, m->cpu);
>   
>       /* RAM */
> -    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> +    memory_region_init_io(&m->ramio, NULL, &ramio_ops, &m->ramio,
> +                          "ram", RAM_SIZE);
> +    memory_region_add_subregion(get_system_memory(), 0x0, &m->ramio);
> +
> +    memory_region_add_subregion(&m->ramio, 0, machine->ram);

Yes!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



