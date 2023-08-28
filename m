Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B95578AFAB
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qab3X-0003ZW-91; Mon, 28 Aug 2023 08:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab3M-0003XI-Pf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:09:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab3H-0003Rw-7i
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:09:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so2551586f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224541; x=1693829341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gt3M6B2EsSg8OwS8wia8jHdklhXN7mBMIA7MC/+MDR0=;
 b=kxtLI+EWpotQE9drRJeF4nC3w+y616VSMYxVjALjGQpxNqpBdS1oKa/tZmFol63Ujn
 vucsPrOSMPW8orutnSHO4YkfZfqCTaNcpYWwjZxt/0z3xHmhQpnNIghT2XRQ1PJnSl5g
 rIO6ayIOz7kBVIBg/LdnkmknmgMaqugBcwprTrnx1rtPVA+Ss0VJ7e87kX7PBfuxh168
 qWlc5++hOKZc4EfNs38gar/qoahFpyj6LuC8DtLmgBIvJo6FOdJHaZCAxOkzM3jAeCZ3
 Z40voF0cQFflMo5529OiKxrCJu1Nm2czSJawCC1E27nIQ1HVUt/ydFqgdZtuSMOimrmN
 8KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224541; x=1693829341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gt3M6B2EsSg8OwS8wia8jHdklhXN7mBMIA7MC/+MDR0=;
 b=VhJLQG0G11D0/atp5ccdzzcGTpdn7kklVn4KQJu6E9BGbsCqiRIERpR38Nk2sVulVq
 PZHnA4nAiVvmonGNol3/+jmgrhfvLk4whQgDyWIlJJIJ8ZosZhjBVWZPAXoFElG4lQ5i
 dsH9/9p8i0o/l+6mkwbKg+nCjxzWCeEe/my60PokSiyZUcfT6PTya3MQdtb7aMPtizRv
 yErpU5p8aWNI/tDPxVJ9Jk93QLxQP4UeBSiP4Hh+ty0q0lexdeTtL+nqSrGy9nxXmZ94
 wIGPORyRyx2W3yjEl5AIPt+f9KzFVvk81B9N/9drmzZTwTfBM/Y5QTIe8Q1E1fGc25SQ
 HhDg==
X-Gm-Message-State: AOJu0YwiaqLPhBsuFZ//hi9pzQFBuEgoouKZdiIHssYKg25JU3USOKWr
 8TciH2N2zaq6Q/s3XgerNUZrahSRn2S1K2YATbE=
X-Google-Smtp-Source: AGHT+IE1QpvFqc9y6DHpH/RzSEWbnV4hXCSbwMZ4clmSddnr9XjoelIThrhDd3f6QZsdisAWJyLqog==
X-Received: by 2002:a5d:6290:0:b0:317:51ff:c249 with SMTP id
 k16-20020a5d6290000000b0031751ffc249mr17999428wru.13.1693224541014; 
 Mon, 28 Aug 2023 05:09:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a5d508e000000b0031ad2f9269dsm10385107wrt.40.2023.08.28.05.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:09:00 -0700 (PDT)
Message-ID: <2b82a710-1d02-ec1f-c7b2-b9ebce77c496@linaro.org>
Date: Mon, 28 Aug 2023 14:08:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 8/8] hw/acpi/core: Trace enable and status registers of
 GPE separately
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20230828073609.5710-1-shentey@gmail.com>
 <20230828073609.5710-9-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 28/8/23 09:36, Bernhard Beschow wrote:
> The bit positions of both registers are related. Tracing the registers
> independently results in the same offsets across these registers which
> eases debugging.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/acpi/core.c       | 10 +++++++---
>   hw/acpi/trace-events |  6 ++++--
>   2 files changed, 11 insertions(+), 5 deletions(-)


> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index 159937ddb9..d387adfb0b 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -18,8 +18,10 @@ mhp_acpi_pc_dimm_deleted(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm deleted"
>   mhp_acpi_pc_dimm_delete_failed(uint32_t slot) "slot[0x%"PRIx32"] pc-dimm delete failed"
>   
>   # core.c
> -acpi_gpe_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
> -acpi_gpe_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
> +acpi_gpe_sts_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
> +acpi_gpe_en_ioport_readb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " ==> 0x%" PRIx8
> +acpi_gpe_sts_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8
> +acpi_gpe_en_ioport_writeb(uint32_t addr, uint8_t val) "addr: 0x%" PRIx32 " <== 0x%" PRIx8

0x%02 for val? Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


