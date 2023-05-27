Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 669767135F7
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 20:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2yE3-0001Qn-0z; Sat, 27 May 2023 14:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yE0-0001QZ-SW; Sat, 27 May 2023 14:01:09 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q2yDz-0005KJ-20; Sat, 27 May 2023 14:01:08 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-199dd37f0e4so1730601fac.2; 
 Sat, 27 May 2023 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685210465; x=1687802465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LDhFMCWVes8QbcIwN9qyIOXMIG0VumITnbDZGMYvGbE=;
 b=eRanV8dSm1QfhCwYGIUYji0C/9DQ8BW5eShZkMsh6Cruiv4CvAvxiRT88tGWUJxhjz
 fxoHXJKr0OzyPURwSIz63gCefBKEyudLgXzseG6WaoJ+bBLBUwc+Iyx/TzDHfMnjoPsm
 JXK49EQW5jMZMzJVVYwvil1+8nVq8LSx+c42Wp6M32Psh4PidbtNNgNLYeX2qlhlhgq4
 eg0j9RuETD0OVxqChGqdms4HTz54BDxhn93dZAJPLYgez7hW/xh6rOBxZkKjvZ8RfgZi
 JlUmlYLl/omsQr7GttHJ3TKCvVywb46PnwgpAAORbveA4T8hw/heLcpkEJMvKIgf8uzT
 XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685210465; x=1687802465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDhFMCWVes8QbcIwN9qyIOXMIG0VumITnbDZGMYvGbE=;
 b=ZWJmv5RTFK5eygbpMkHZXk8XKXGARBhgnAQBiam+sBclopYFN25hflNlJlElPWBZOi
 s5DOvJw4L/c58iHvZQTbb8v1ESY1uk2zdiJtYrHvRgz8hOK+Yqhe1+5b2csUm3xsle0H
 ovv7vhuzeEP5yRgmw2c2J5uLNIjmp5BXlZEOkkne2e80brejztBK8sYz5Oxi5apbxFoL
 NKeG1XnxEFk5dGIAbLoQCj8yskKG8g0jRvlb4JstTwN61EquMVAGWlKgyebpJgfzq7I8
 PemGn+aPbzZ64mypn4QjZidqT+/Z9jpm2YcCjawBst5AGx3QTDjxmhl756TM0Ib9jUxR
 nW5w==
X-Gm-Message-State: AC+VfDwAzZlbsUkvoZiuHMSahDfKQDPPeyNyNEdWhvP1H+BXHDWTthUF
 czvwWLTUkq7TYtkv7X/QaAo=
X-Google-Smtp-Source: ACHHUZ7BIIfVVg+DrBrn4+cwATWcPJT5b12nkA6wrKyvxBQPa4CFBtVjpPmFjAlRdosFbo5mdQsMIg==
X-Received: by 2002:a05:6870:e282:b0:196:51e7:6454 with SMTP id
 v2-20020a056870e28200b0019651e76454mr2979155oad.51.1685210465315; 
 Sat, 27 May 2023 11:01:05 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 dy27-20020a056870c79b00b0019a3bbeeb34sm2980729oab.40.2023.05.27.11.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 May 2023 11:01:04 -0700 (PDT)
Message-ID: <e714b0bc-ef68-0183-ac0f-84bfaec1b713@gmail.com>
Date: Sat, 27 May 2023 15:00:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] hw/ppc/prep: Fix wiring of PIC -> CPU interrupt
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paul Burton <paulburton@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230304114043.121024-1-shentey@gmail.com>
 <20230304114043.121024-4-shentey@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230304114043.121024-4-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 3/4/23 08:40, Bernhard Beschow wrote:
> Commit cef2e7148e32 ("hw/isa/i82378: Remove intermediate IRQ forwarder")
> passes s->cpu_intr to i8259_init() in i82378_realize() directly. However, s-
>> cpu_intr isn't initialized yet since that happens after the south bridge's
> pci_realize_and_unref() in board code. Fix this by initializing s->cpu_intr
> before realizing the south bridge.
> 
> Fixes: cef2e7148e32 ("hw/isa/i82378: Remove intermediate IRQ forwarder")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued in ppc-next. Thanks,


Daniel



>   hw/ppc/prep.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index d00280c0f8..cfa47c1e44 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -270,9 +270,11 @@ static void ibm_40p_init(MachineState *machine)
>       }
>   
>       /* PCI -> ISA bridge */
> -    i82378_dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
> +    i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
>       qdev_connect_gpio_out(i82378_dev, 0,
>                             qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
> +    qdev_realize_and_unref(i82378_dev, BUS(pci_bus), &error_fatal);
> +
>       sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
>       isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
>   

