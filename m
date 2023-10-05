Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD07BA94E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:41:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTGD-0001Wc-9U; Thu, 05 Oct 2023 14:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoTG6-0001Sq-UK
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:39:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoTG5-0003sY-4b
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:39:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32336a30d18so1178920f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696531175; x=1697135975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9AWkkg53ztRpJE1Qw9XVEVbsdYMCpimMmh/cmrGK+zI=;
 b=PXKDBRjC7dsiYXQW3wVS5uB/Rjn5OqmpoubbRFzT9ZUwIEjOyHAN9/a0zNr8nJi/lE
 k9qJqEB5CvyJfrvVlYELoEdtSOvv+jwnfRVXBc4o4862/6RS4CDq7DfKgLsXqsCvdwEq
 fhT/LHk0Ql1vZilCDvbwwXoXcuhiBkZqWa+mGzT9qC+6CnFy9g4Fedvl33yJK22qhSV4
 DARwTnbSOaHVRLqPcAGV2XHtfQf8EQoYnzyNSxpk41phEAHMRtDgZ3IDPkD6pnd9llhE
 5KhjuCPRrnsxQK2QBwpRn7WxDXWODIcQ5gI8BEXwpH4cu7a02QAThtrKWeRw3tIz/yyR
 biAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696531175; x=1697135975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9AWkkg53ztRpJE1Qw9XVEVbsdYMCpimMmh/cmrGK+zI=;
 b=tSs35FsLmK513rYXQg42Fz6l2c82DlP6IqUzUL2kf1QV0ebIR+1+yN3zvIR5PcymMD
 JWXyD+S6Ol5KBFK14PiFM6SPeUQz6Qj25jTkIHTbM851qt2OsVs96qtvyrW4U41YuPJS
 zo8HQl70m1BYzNWsa2RQmOCHIN0FHVslf3KL4uJ0+K7t6nCBC9dHO210guYBm1DgYqh7
 zlbgn+uQi6dj/X1QVhBX1M2TZq0jiacVygMcE4QXhMRB3RODpCwIoVHNa/XH2KNae+tV
 O6f4/25ceVvWo41Q5oxVgLc8TEDdQSSsgB49gA5zvX8SKAxgmYZbhLQrfqRpo/ruYkiP
 hyxw==
X-Gm-Message-State: AOJu0Yxjh7YpTeVfuDT58S4++qBlmWf9cRmpI9lZinLPZ18r+oHwKMIA
 UZi2nbJClVY+2HpENdl7/MnMVw==
X-Google-Smtp-Source: AGHT+IGftXTHnpw7D0PbYWbfM6JqekJTPlhZKkEOqqpcDoAYfwYRwDtHQmqxN/iDH3vsNd1sj6Ffig==
X-Received: by 2002:a5d:6445:0:b0:31c:6420:ff4 with SMTP id
 d5-20020a5d6445000000b0031c64200ff4mr5148420wrw.36.1696531175351; 
 Thu, 05 Oct 2023 11:39:35 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a056000194900b0031c5e9c2ed7sm2368418wry.92.2023.10.05.11.39.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 11:39:34 -0700 (PDT)
Message-ID: <669b7b69-a5d0-fef2-40a8-84a1805f1aad@linaro.org>
Date: Thu, 5 Oct 2023 20:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTANERS: Split vt82c686 out of fuloong2e
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231005181805.8EA7475723D@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005181805.8EA7475723D@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 5/10/23 20:18, BALATON Zoltan wrote:
> It is used by other machines not just fuloong2e so put it in a
> separate section and add myself as reviewer.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> By the way, PIIX4 already has a section just above where I've added
> this but some files are still listed in Malta. You may want to have a
> look at that.
> 
>   MAINTAINERS | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea91f9e804..7f0e20fde6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1307,10 +1307,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>   S: Odd Fixes
>   F: hw/mips/fuloong2e.c
> -F: hw/isa/vt82c686.c
>   F: hw/pci-host/bonito.c
> -F: hw/usb/vt82c686-uhci-pci.c
> -F: include/hw/isa/vt82c686.h
>   F: include/hw/pci-host/bonito.h
>   F: tests/avocado/machine_mips_fuloong2e.py
>   
> @@ -2462,6 +2459,14 @@ S: Maintained
>   F: hw/isa/piix4.c
>   F: include/hw/southbridge/piix.h
>   
> +VIA south bridges (VT82C686B, VT8231)
> +M: Philippe Mathieu-Daudé <philmd@linaro.org>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +R: BALATON Zoltan <balaton@eik.bme.hu>

Feel free to add yourself as maintainer if you rather.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +F: hw/isa/vt82c686.c
> +F: hw/usb/vt82c686-uhci-pci.c
> +F: include/hw/isa/vt82c686.h
> +
>   Firmware configuration (fw_cfg)
>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
>   R: Gerd Hoffmann <kraxel@redhat.com>


