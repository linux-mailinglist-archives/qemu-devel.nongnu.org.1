Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB345826DAD
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:21:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMocJ-0001x2-Qf; Mon, 08 Jan 2024 07:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMocB-0001uT-Hn
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:20:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMoc3-0005r3-9a
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:20:17 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so16195885e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704716412; x=1705321212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yjv7QhUyk1DBe4G4f2saIb5DXmOwx/nc3h5PoIHWUzc=;
 b=X4RAZyrI1AuPGgUktPFKKQJB2xQ8XFh86hp5+u6469pOhAKxIaxN3MqpEMgtPudUVq
 oxlp3CGeJBv0mhsxdqxtBZdrQeGV0HL2LQ5kiN0zTDJXgQtFQADrpmN0wP2ceed8iETv
 pqwB1w+v/AJhw5/voCXXEn94Z2Yuhp6wfsZ76qyb0YCrswTZ6F6q6qJCRyy4I4cPaODh
 IURrJ+JQ0cwrHBRqvdS8hHUK3tvaZ2eZEi5iCODlzW8kD4JdSkEDt0rjFMnLvUDPHXtn
 BFNj+IsTyB8fJNpZGdg3RZFcFhA+ahMTlM0l4wc5kjZN8l3mIbHMLIa2XwvZeNQbz0Fz
 fjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704716412; x=1705321212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yjv7QhUyk1DBe4G4f2saIb5DXmOwx/nc3h5PoIHWUzc=;
 b=oZ7af+eq9VgSp0OWbWteWg5mYknpxN++tqCLUgb9wT7MSOyEmmJ6YR6r72F8ejFeNR
 gYqVXfUVmTC9UGSdUedxpTry6+pbgmmSiV1WrJTnNws8QhweWQfRs3opcLOOkaHO1JUt
 wzDHhI2fm5L90V4bRtLLoD8UWn8veSDMWhG+VOM3xeqzRQOEqt0zEODW6RHrG5MprTFE
 LWs0jx1rycrph7wI0bNp5Ftzi2ay5/uKgSoenLB3MdzREBTVYUizIkA24/Oa3BTYs4qA
 l8nLyRaMmdrnPmW9LLf+FDp70ZmdShOPIJ4kk3wmcWjI5njWrAQIxfFzxf0DFoH2eHbT
 7sag==
X-Gm-Message-State: AOJu0YzixY9HoEf4NzQEL+OvJVnaBUfi4ue3+1HCquWjZ1s9AhLwqqfE
 lKv+phWtLvhamAh+rZk3NvwYbXahiCE95A==
X-Google-Smtp-Source: AGHT+IEzAx4rngqDGA3xmnbPvKmgzFU+LXG/P1pDI5A9C9iNRGeKW2cTQ4Lkjd9S/idW8XDj9TOBTw==
X-Received: by 2002:a05:600c:4fd1:b0:40e:3b47:eb71 with SMTP id
 o17-20020a05600c4fd100b0040e3b47eb71mr1962566wmq.73.1704716411804; 
 Mon, 08 Jan 2024 04:20:11 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c4e8900b0040e3bdff98asm8825124wmq.23.2024.01.08.04.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 04:20:11 -0800 (PST)
Message-ID: <f030dc08-f010-43dd-9aaf-e9b8048a8e43@linaro.org>
Date: Mon, 8 Jan 2024 13:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: add PCIe to Freescale i.MX6
Content-Language: en-US
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240107165702.47819-1-n.ostrenkov@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240107165702.47819-1-n.ostrenkov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Nikita,

On 7/1/24 17:57, Nikita Ostrenkov wrote:
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>   hw/arm/Kconfig            |  3 +++
>   hw/arm/fsl-imx6.c         | 25 ++++++++++++++++++++++
>   include/hw/arm/fsl-imx6.h | 44 ++++++++++++++++++++-------------------
>   3 files changed, 51 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 660f49db49..575bb68c76 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -530,13 +530,16 @@ config FSL_IMX31
>   
>   config FSL_IMX6
>       bool
> +    imply PCI_DEVICES

This should be PCIE_DEVICES.

>       imply I2C_DEVICES
>       select A9MPCORE
> +    select PCI

Incorrect, should be PCI_EXPRESS, but this is already
(indirectly) selected by PCI_EXPRESS_DESIGNWARE which
you select below, so not needed.

>       select IMX
>       select IMX_FEC
>       select IMX_I2C
>       select IMX_USBPHY
>       select WDT_IMX2
> +    select PCI_EXPRESS_DESIGNWARE
>       select SDHCI

