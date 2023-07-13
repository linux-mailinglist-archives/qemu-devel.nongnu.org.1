Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11FD751C11
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 10:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJryW-0002LZ-RY; Thu, 13 Jul 2023 04:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJryH-0001zD-8p
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qJryC-0007Ti-HS
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 04:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689237998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bnCCMdXWeCOaJxIEFILAG/h1MBXKiwDAk51I/1JzPzs=;
 b=BnmFgrQzAMsktiC1ZmK21b+ecJkAbAc1gD/PjvknzqGPSKC8xNGAonxyV0/vPQ34Op4x7j
 Fb3PubmOL1sYvYO+A3gWVnuEZztGtUN5qNMdtcsXV5ycfH1rlNYTej7OcQlxBE7g3idXMn
 /urYKO3VkylmWyPL4L8G7FSqXZkbkmo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-2LLGYUluOCex6F0ipck4EA-1; Thu, 13 Jul 2023 04:46:35 -0400
X-MC-Unique: 2LLGYUluOCex6F0ipck4EA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7675fc3333eso32569085a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 01:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689237995; x=1691829995;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnCCMdXWeCOaJxIEFILAG/h1MBXKiwDAk51I/1JzPzs=;
 b=im1bP0swuMx2lH+3d0uEAchSJ2+XRVCk2y6k36gk3uastSzK077arJTZFEEEyaffQZ
 61XTHQUbpyYIqAN9q8RlibihahTryJ35bIXAqFIkRL0TuTQMXrImqJ6MbWefk3277pMy
 6k0KoHt5eUGQlkK3Pj3xXJn7XA2ZNWUi+B/wvtNv17ycypQ6VAyldqO3OA2tldNOUKOn
 Z34iLvErUTFB0C+BH4E/6ItZC46cnlLhdORr6KFchBqSFcEuHRg75RjkBu9CEsbZuBNb
 r17LrINo9WLBP2Bg2ICuipPpB/3OHZyFmHYyOWwjKSpd0AsO5Fy5Z9ROwZrtOgAEDdth
 rpzw==
X-Gm-Message-State: ABy/qLYNh24b0GSF2/A9wygz44cuVyl7/MWyCB3Efrls2jhjpczdIrq6
 XSUCYDyUtnyuU4DOebPhnsB64bTM2TsvfaQJKAVon+mY3OIKRx9hF7I2wFNegtvi2Wy5bv95guV
 TrYcng6szR48MehQ=
X-Received: by 2002:a05:620a:4710:b0:765:467e:133a with SMTP id
 bs16-20020a05620a471000b00765467e133amr1211895qkb.23.1689237995173; 
 Thu, 13 Jul 2023 01:46:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3tgo1QtLgC3pvqwWZ/QTQgFawEk4ZxRMgIHGyMkG83hP381UKEptXSeq7T/qH/3/7aB/B6g==
X-Received: by 2002:a05:620a:4710:b0:765:467e:133a with SMTP id
 bs16-20020a05620a471000b00765467e133amr1211884qkb.23.1689237994953; 
 Thu, 13 Jul 2023 01:46:34 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a37e305000000b00766fce8f840sm2725485qki.120.2023.07.13.01.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 01:46:34 -0700 (PDT)
Message-ID: <0effafc0-4de8-7554-006a-78be3e84d043@redhat.com>
Date: Thu, 13 Jul 2023 10:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230621074134.82781-1-thuth@redhat.com>
In-Reply-To: <20230621074134.82781-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/06/2023 09.41, Thomas Huth wrote:
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
>   
>   #define PM_CNTL_MODE          0x10
>   
> @@ -447,11 +448,13 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>   
>       pci_vga_init(pci_bus);
>   
> +#ifdef CONFIG_USB_OHCI_PCI
>       if (defaults_enabled()) {
>           pci_create_simple(pci_bus, -1, "pci-ohci");
>           usb_create_simple(usb_bus_find(-1), "usb-kbd");
>           usb_create_simple(usb_bus_find(-1), "usb-tablet");
>       }
> +#endif
>   
>       for (i = 0; i < nb_nics; i++) {
>           NICInfo *nd = &nd_table[i];

Ping?

  Thomas


