Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BC8716F5D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46XJ-0008GZ-M2; Tue, 30 May 2023 17:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46XI-0008GB-1M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:05:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46XF-0002Lh-VA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:05:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3063433fa66so3560729f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685480740; x=1688072740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7VkMhVGOxiOQ61TnY/jd9GpbjF7vhHIyXxCNbDCSLA=;
 b=aPN3Si/d69SvkZmeFQskm4igjZs4hFcTcjUvgm1RzxYZsBDY87v3M9f3NcpOTMTQ+u
 6QWY4g5LT4Hz99YTdwe2ADbwvDfUGsEY2ai/i2Aa7vXpvGztPFRTGVpmwUPhwwRj7jTt
 X5hEN1ORekpGPVu6H3+Ti0GNYYkKJe002zBhwnAuRJKA3mOLzZYLF+sijBbVpF/xghay
 dpva20HfuLGH/3CC+gWJFaS+Kf+LyEDFgWK2z4+pHBQ9e9r9Lgdfg/kM7pP9xbSgW59p
 vEAGrCPVr9JkOImSyhZ1igu3zu05IUb8jdIBphYeXGODf6jfMunEdEDTER90yZCHvT1+
 pymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685480740; x=1688072740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O7VkMhVGOxiOQ61TnY/jd9GpbjF7vhHIyXxCNbDCSLA=;
 b=SVPyaOufa/Y8EkFa2QpXMBng+xIri3lkgj5zTlkx31OZ9Ue59HlMG3rGnpfy/wenir
 bFHT8TzEG+YPTjHYEyaGc35eAaU8Wrh6i8e/xhT4XhlYzAFy7f9Uzg982yuyT9sBQUZ0
 2/VSqFoT4DwIW0B6VYdevAdl8XK69a3U3e7vqtl2mifXL18eXwp1P8fqWNurm2U7YGYR
 NnNxPSpTHDAM4dwxjP0FV3+7K12Fyetgr4OvV0QYBdeSqwxeMIst/o6FOKT3T/0JEd4/
 Z3H+zONrEfFaXDocbaM075yh99KZ+L516fKmzAmttXDhVIPOxa4KJ3X3tZ1wDOiR4JDF
 Kw2g==
X-Gm-Message-State: AC+VfDyFblvfhtVOWhuw1rnyxkiwB2dYjSzyHJUeuM7c9g4BOn8lOaj2
 Q8t/iZRg/0RlHbM/kf3y1NyFWw==
X-Google-Smtp-Source: ACHHUZ4eRtqZy24Qk/QosPHah/J6PtLVvXqAQTCRy38KrkJ31H3ceVGNgwEDinArx+9foUqSXt4JCw==
X-Received: by 2002:adf:e789:0:b0:305:ed26:8576 with SMTP id
 n9-20020adfe789000000b00305ed268576mr2533019wrm.9.1685480740220; 
 Tue, 30 May 2023 14:05:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a5d4607000000b0030647449730sm4372519wrq.74.2023.05.30.14.05.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:05:39 -0700 (PDT)
Message-ID: <f8a075cd-0100-f3d0-dc26-bf733917fbee@linaro.org>
Date: Tue, 30 May 2023 23:05:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 07/12] hw/ssi: Check for duplicate addresses
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-8-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-8-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> This to avoid address conflicts on the same SSI bus. Adapt machines
> using multiple devices on the same bus to avoid breakage.
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/stellaris.c                  |  4 +++-
>   hw/arm/xilinx_zynq.c                |  1 +
>   hw/arm/xlnx-versal-virt.c           |  1 +
>   hw/arm/xlnx-zcu102.c                |  2 ++
>   hw/microblaze/petalogix_ml605_mmu.c |  1 +
>   hw/ssi/ssi.c                        | 20 ++++++++++++++++++++
>   6 files changed, 28 insertions(+), 1 deletion(-)


> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index a25e064417..685b7678e0 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -42,10 +42,30 @@ DeviceState *ssi_get_cs(SSIBus *bus, int addr)
>       return NULL;
>   }
>   
> +static bool ssi_bus_check_address(BusState *b, DeviceState *dev, Error **errp)
> +{
> +    SSIPeripheral *s = SSI_PERIPHERAL(dev);
> +
> +    if (ssi_get_cs(SSI_BUS(b), s->addr)) {
> +        error_setg(errp, "addr '0x%x' already in use", s->addr);

We could return "... in use by a $MODEL device".

   DeviceState *d = ssi_get_cs(SSI_BUS(b), s->addr);
   if (d) {
       "... in use by a %s device", ..., object_get_typename(OBJECT(d)));
   }

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        return false;
> +    }
> +
> +    return true;
> +}



