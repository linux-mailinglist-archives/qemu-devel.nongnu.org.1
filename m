Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBA7B77C8
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:26:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnvKA-0001zN-NW; Wed, 04 Oct 2023 02:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvK7-0001zB-VF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:25:32 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnvK6-0006QL-6o
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:25:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32320381a07so1741179f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696400727; x=1697005527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YEcbKJff5v1/BqxTsmR3zQE0bi7M8/Vk0ZWzI3ql8cs=;
 b=RDYrMu+rE/cAzdew/pF/rmEaC0pQrwPcBLTF1qRe4Ji3xdBe6MCBR+MSLFUcyMJRd0
 uVlAXM7RJkSkZDtnPuiSVIwdGhQ32KFo4a2iUDZR3hzy8p8xCKAtT9M1PO+taIA5QtVd
 3Ua5UOG7ueGXAp19vwBlO84Vp2skLMcMFsrc7LlNK4lDQFSjjUpBFnZxRKqarTqnItuj
 CPY0FjBob7iGdvUhJ713NMX0aKmY2xzHYmnq54x6wGIjoC4l5OexBLN2jknggW7O/BjE
 MPyc8vNIcZd9dxIT2UJK5+rBb0/fzB9eM2hqEX9MctvUJw+Hj8iGWQgs01bkAwpX0B5a
 Q6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696400727; x=1697005527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YEcbKJff5v1/BqxTsmR3zQE0bi7M8/Vk0ZWzI3ql8cs=;
 b=dyN6Rz2Az18+94sDsrUGx9aurLOBH2OsZ5rkixxShPdtzOoZ6B7RhE1+IAVp7gmgkp
 a1KLaEmHDwwmMP/zkewTS+CBUAUgEm15G3S7WfqIP1R4IxOMgW0Z7X/ihYBN4wGj4a9p
 PWsBMhJI92G/86qTSCxRrXX04PJa0uVWNC6pe49KzvCq2VTJ1QQjFbAWH1ZzPVsshTp/
 GLszdq6OwfBuRx0545hwEmEj6tAt9lslDBvYED++RPG1trfvESRa1PHhUHKCNi9uHPe4
 y9G55fnHOSobIT8K179ESVYGGhDVnrLEhHseLMsy5s1TFtOuq6NGyi/NT+w4NqYcikoM
 hVhw==
X-Gm-Message-State: AOJu0Yy78qv0SPnPK4YjU4Z+sKYlejptnIDsGgKXDaKadYUL/6f72abU
 sOP1LDyzYiS3blzDpOsGWTMahKK6jF4pCgFxhlI=
X-Google-Smtp-Source: AGHT+IGfevVVsZ9ODtMR6k/wgowLYQMyIwpb68Vypse27PErTyOkOMveMoeaHBKQITbe9nOJQcJaxA==
X-Received: by 2002:adf:f641:0:b0:31f:b6ea:af48 with SMTP id
 x1-20020adff641000000b0031fb6eaaf48mr1181692wrp.49.1696400727305; 
 Tue, 03 Oct 2023 23:25:27 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 g14-20020a056000118e00b003231ca246b6sm3173968wrx.95.2023.10.03.23.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:25:26 -0700 (PDT)
Message-ID: <0784106e-44da-7d1f-85d9-8ea83acf4694@linaro.org>
Date: Wed, 4 Oct 2023 08:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/isa/vt82c686: Respect SCI interrupt assignment
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231003214437.29302-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003214437.29302-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

Hi Bernhard,

On 3/10/23 23:44, Bernhard Beschow wrote:
> According to the datasheet, SCI interrupts of the power management function
> aren't triggered through the PCI pins but rather directly to the integrated PIC.
> The routing is configurable through the ACPI interrupt select register at offset
> 42 in the PCI configuration space of the ISA function.

You describe 42 but use 0x42 (66). Clearer would be to add a definition,
maybe:

   #define PCI_ACPI_INTR_SELECT_OFS 0x42
   #define PCI_ACPI_INTR_SELECT_MSK 0xf

Alternatively self-document with function name:

   static unsigned via_isa_get_pm_irq_index(ViaISAState *s)
   {
       return pci_get_byte(s->pm.dev.config + 0x42) & 0xf;
   }

Otherwise LGTM.

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/isa/vt82c686.c | 43 +++++++++++++++++++++++++++++++------------
>   1 file changed, 31 insertions(+), 12 deletions(-)

> +static void via_isa_set_pm_irq(void *opaque, int n, int level)
> +{
> +    ViaISAState *s = opaque;
> +    uint8_t irq = pci_get_byte(s->pm.dev.config + 0x42) & 0xf;
> +
> +    if (irq == 2) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for PM controller is reserved");
> +        return;
> +    }
> +
> +    if (irq != 0) {
> +        qemu_set_irq(s->isa_irqs_in[irq], level);
> +    }
> +}


