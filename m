Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0393F826D99
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:16:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoWu-0007GC-If; Mon, 08 Jan 2024 07:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoWs-0007G2-Mg
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:14:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoWb-0002bF-NU
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:14:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d89446895so10160675e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704716075; x=1705320875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pTv62+lrN+LJDOyyZzZUKji6+pubYOy60kmzZvHd3z4=;
 b=cYoPlX0UJmGiGL4YY5WkdNsVr6C2yAwTEWbgCEyCUGO5+FRZR7siv4sSkQCYBRPATV
 Mm4zjKSUCaPSv0AFQQR4hJdDLx09bL3nSevoKAbnaphOQ6pkKeA8wM+QrziesdwlZQZP
 3169mCsETnpzOYL3mVnF6rMAusC8YDl/V6OYEDy26/bnzwATueIDf3cKgQIBBvXSibD0
 MftdImAhQOMexGMZTzeEUHK9VtslPsmlbvFWHlCVl/+jumYf93UugkQ6FLb/yqIdzeEf
 ssvK8RSeOM6txFAnmfC0HYEXV6NssdG+Aa1wkdTFhJDYGixYLqliHyR8+loX1tzIjFzr
 mv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704716075; x=1705320875;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTv62+lrN+LJDOyyZzZUKji6+pubYOy60kmzZvHd3z4=;
 b=HIb+OzIRsbJHKgy3f4BwQT7W+SB9VMKR9Mm21hSagd7cKmJKl39jm9APtxV9LLF1va
 feZnabLe9eXzY3YIfyPANytxTNHwU4zpoSmpOKEcGdbY6udf3xY84kaghhSMlo2DwTtm
 fGbRfoHXn4szfQuSSvDGEAeIlas3zKmoPxOFO4trvZy+YrvVleTvJs0DuSdtoP+rdZOB
 WssC0P7R4es6aPeAe7zmkdgH02XYK9ZTE2h6eUUaHeIINUtSCV+RWdKnvUUJOFcn8qTq
 1A0D3w3ONGbuEEogbBmh0HBI5ftwfEaQ9XlCAoCMpc8fG/B19EE2iSciNQgikNoGrnX3
 ms7w==
X-Gm-Message-State: AOJu0Ywot5/NftbP3GC9aheYAsBBqlncqzAYrvQXxfb73UTa0+M/aTlN
 yTjyGxy+0udzbQsu5XCRGpR3OuovwNKJ3w==
X-Google-Smtp-Source: AGHT+IGxCyPZI3LhIKghuQNTCsPq8RlSvMV1g4746yYM5AkZRdonIiznbdeKS14OHtcSSqqKiec3+g==
X-Received: by 2002:a7b:c8c3:0:b0:40d:8a57:796e with SMTP id
 f3-20020a7bc8c3000000b0040d8a57796emr1691872wml.154.1704716075055; 
 Mon, 08 Jan 2024 04:14:35 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a5d558b000000b003367bb8898dsm7625577wrv.66.2024.01.08.04.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:14:34 -0800 (PST)
Message-ID: <d818e085-40e8-4916-b72d-1c105bea5e9a@linaro.org>
Date: Mon, 8 Jan 2024 13:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_piix: Make piix_intx_routing_notifier_xen()
 more device independent
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>
References: <20240107231623.5282-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240107231623.5282-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/1/24 00:16, Bernhard Beschow wrote:
> This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-specific
> variant of piix3_write_config()" which introduced
> piix_intx_routing_notifier_xen(). This function is implemented in board code but
> accesses the PCI configuration space of the PIIX ISA function to determine the
> PCI interrupt routes. Avoid this by reusing pci_device_route_intx_to_irq() which
> makes piix_intx_routing_notifier_xen() more device-agnostic.
> 
> One remaining improvement would be making piix_intx_routing_notifier_xen()
> agnostic towards the number of PCI interrupt routes and move it to xen-hvm.
> This might be useful for possible Q35 Xen efforts but remains a future exercise
> for now.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 042c13cdbc..abfcfe4d2b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -92,13 +92,10 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
>   {
>       int i;
>   
> -    /* Scan for updates to PCI link routes (0x60-0x63). */
> +    /* Scan for updates to PCI link routes. */
>       for (i = 0; i < PIIX_NUM_PIRQS; i++) {
> -        uint8_t v = dev->config_read(dev, PIIX_PIRQCA + i, 1);
> -        if (v & 0x80) {
> -            v = 0;
> -        }
> -        v &= 0xf;
> +        const PCIINTxRoute route = pci_device_route_intx_to_irq(dev, i);

This indeed dispatch to piix_route_intx_pin_to_irq().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        const uint8_t v = route.mode == PCI_INTX_ENABLED ? route.irq : 0;
>           xen_set_pci_link_route(i, v);
>       }
>   }


