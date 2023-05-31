Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CAA7181EA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:32:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LuE-0006Yq-Dm; Wed, 31 May 2023 09:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Lu1-0006Xw-I1
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:30:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Ltx-0005q9-OK
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:30:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso1475246f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685539803; x=1688131803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BFKUZg0jQcaYDbVumMdm4J067GgtUMgiaV2++h2izs=;
 b=E/qnULBwEEIyu+Z0Ozvtss9KNPKTDE3fOBIIxkr4XkE2ldEFQP5vF/vylWRfF63+Ga
 DcgOn/MAx3zgjd1drRsfR2H/iS0n37Ap+LTdFTIucsQx1J3JBIoddAWh2NQPuUjpMWyq
 6W9I2xDNLWDlmGALhaqzhlw+0Wht9DrN2FtKtcdx5hKMZnW2z8gTiuCpNad31Dg7lDdD
 l/EPkdcEgSOynJZfXC0Za+UrMeg7Wqs0hHq8ri0vnszD456f4qmN7aGqVO4PQGtJLHo3
 2ZcD5BPAjqNhv5W497cguiSObOgu4vBAGEKg8r8+yJwJ+YMjPaiOw98MeBdcEZxI8flL
 wdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685539803; x=1688131803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BFKUZg0jQcaYDbVumMdm4J067GgtUMgiaV2++h2izs=;
 b=iQZJzT/BuEmPegH+kW0ply7JPjXD4eNm/dtAbw55S3g8txaBE6XkksJ+5vl4PYLpdJ
 9bsfPbMZzR1yJEd46cpKcq8Z0dICPi1HwTZk6aH8r122fX+1Y3uisQ4Cy5P9T7DKkZTO
 C+7WjNJKNjfSdz0IF/HSSduuLzoPyTxYBhZQ8Vr86BBHxfRVpnUptlZWxIIK5Fgx0gKN
 z+7Fi139qqJZjIeKwLj8DSO2rTJRnOXFt5MuwEgKBOHFEwW47joC2xjByeQRX5Rx5+28
 KKU4BPCmezUdIp/AWltJ+HXiQ87hmPE53o/hZz4yZraD/i1J2GaquMbkJSBoNSCydgCS
 2htw==
X-Gm-Message-State: AC+VfDz88VlnYws8GmlNIDtSwFQc3hzXsHBQCJdzZmEpquAd83pTeobI
 KHtfpPgQXNqMns4dh79n5ArZ2A==
X-Google-Smtp-Source: ACHHUZ5HIhF+I6c0bmTbih6BcPSbCTeMQUewrFY8TWyVBs+qJZzUR1XSixCRK9i3aqDL5hYeUuMKwQ==
X-Received: by 2002:a05:6000:91:b0:306:44d0:2bcd with SMTP id
 m17-20020a056000009100b0030644d02bcdmr3983986wrx.9.1685539803048; 
 Wed, 31 May 2023 06:30:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a1c6a08000000b003f41bb52834sm24636427wmc.38.2023.05.31.06.30.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:30:02 -0700 (PDT)
Message-ID: <364e5f10-693a-4e3d-0031-865ad4e79b67@linaro.org>
Date: Wed, 31 May 2023 15:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: en-US
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org
Cc: quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230531095845.365019-1-wangyuquan1236@phytium.com.cn>
 <20230531095845.365019-2-wangyuquan1236@phytium.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531095845.365019-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Hi Yuquan,

On 31/5/23 11:58, Yuquan Wang wrote:
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses XHCI to provide a usb controller with 64-bit
> DMA capablity instead of EHCI.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> Change-Id: I1376f8bbc0e25dcd9d8a22b6e061cb56b3486394
> ---
>   hw/arm/sbsa-ref.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)


> -static void create_ehci(const SBSAMachineState *sms)
> +static void create_xhci(const SBSAMachineState *sms)
>   {
> -    hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
> -    int irq = sbsa_ref_irqmap[SBSA_EHCI];
> +    hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
> +    int irq = sbsa_ref_irqmap[SBSA_XHCI];
>   
> -    sysbus_create_simple("platform-ehci-usb", base
> +    sysbus_create_simple("sysbus-xhci", base,

Please use the definition: TYPE_XHCI_SYSBUS.

>                            qdev_get_gpio_in(sms->gic, irq));
>   }



