Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E108751E7A
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 12:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJtGZ-0003uC-Op; Thu, 13 Jul 2023 06:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJtGV-0003u3-Ln
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:09:39 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJtGO-0008Gc-U9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 06:09:39 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb960b7c9dso977258e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689242971; x=1691834971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qbbC2Q8Qam38/9uPDXRQFJ8VzTPw8yBV2VZ2Q2n6k2g=;
 b=B8bRgUNJrj+dtmkr9/RXsrw8EXSAWOma+UkBkOJh/vRWjes9TbWceT98ZzvnQzNYec
 dFfrPlvceFJ3UAjMaaIetO2Ad+7AuAYM5WPlhEY8rfXJMkIcxl+dMEQEAjVJh93vzKfG
 vVItIDxypemJXjBirt4WBH/HxMpG1x0bx9JOBuj/EjeeFrMojeRRCOToHoPZVYDaxTh0
 bc65FqNVzli7xOsBeIWxtYxTKTkmcJyLhXdNaDMKdLgFvq4NLX3wcm2Nmnpv7ho6Uct2
 joVsXNcFvhD/BxwDOnwclC+7rZ1MC01+G7nHz6zG/AZPVCYqfsBU3ZcZ7ErWeIXIZYss
 pUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689242971; x=1691834971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbbC2Q8Qam38/9uPDXRQFJ8VzTPw8yBV2VZ2Q2n6k2g=;
 b=PY3gDT1/xnSFO9sWXhiwH0bk0+XJTIJbm2SlAHxGkRt0/jb+QO0ctaGLrgy3Bj7of/
 7TIEpW37neAbIpdLnQwwdBiAdToQo5NS6s7Gn2oDsyMArzDd7zDDSfPM94XthuwIdKnp
 hrot7jqBAjGk0NBO4AhqE1PBlGTMjsEtbCLF1UEa7+Q2edhfP7iGQSfn04upCMcvkO/7
 UkONmULvMHoTdnn+vJP4LLPGjhLBZAIEYQtSCDUHvpOa4cTup6/K8eUV+w9SaLF/zyzo
 JOaZeLx0NukKbBKnNmE1fmCd7LH5anoziHcj3xWsgIiwtd86CUlB6oSnwsmTHijgNzd0
 KVtg==
X-Gm-Message-State: ABy/qLZKwYR3non6yaAOeSc8vbd2vi8H2HIFLbPPa4q3o/0AEe/BcqpT
 ZEKcNgWVs/IULxhTslxSzCDpcA==
X-Google-Smtp-Source: APBJJlGovMRXFqWjzO8O+yBo8aiEYDoyWYIs+gOxk+AjcDRPZp5c1ewQ5DJ8XaDR/jObWKOWcKr19g==
X-Received: by 2002:a05:6512:304e:b0:4fb:89e3:5ac4 with SMTP id
 b14-20020a056512304e00b004fb89e35ac4mr1107107lfb.66.1689242970638; 
 Thu, 13 Jul 2023 03:09:30 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a5d6147000000b0031412b685d2sm7499036wrt.32.2023.07.13.03.09.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 03:09:30 -0700 (PDT)
Message-ID: <062e8b3b-dcdd-8f87-d245-ea9e16b1c276@linaro.org>
Date: Thu, 13 Jul 2023 12:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20230621074134.82781-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621074134.82781-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

Hi Thomas,

On 21/6/23 09:41, Thomas Huth wrote:
> It's possible to compile QEMU without the USB devices (e.g. when using
> "--without-default-devices" as option for the "configure" script).
> To be still able to run the loongson3-virt machine in default mode with
> such a QEMU binary, we have to check here for the availability of the
> USB devices first before instantiating them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Use #ifdef instead of runtime check
> 
>   hw/mips/loongson3_virt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 216812f660..3094413eea 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -51,6 +51,7 @@
>   #include "sysemu/reset.h"
>   #include "sysemu/runstate.h"
>   #include "qemu/error-report.h"
> +#include CONFIG_DEVICES

I'm a but reluctant to include CONFIG_DEVICES.

> +#ifdef CONFIG_USB_OHCI_PCI
>       if (defaults_enabled()) {

What about:

   if (defaults_enabled() && object_class_by_name(TYPE_PCI_OHCI)) {

>           pci_create_simple(pci_bus, -1, "pci-ohci");
>           usb_create_simple(usb_bus_find(-1), "usb-kbd");
>           usb_create_simple(usb_bus_find(-1), "usb-tablet");
>       }
> +#endif


