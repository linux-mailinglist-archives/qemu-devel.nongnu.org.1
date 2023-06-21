Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043A2737F1C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuMp-0002AD-MA; Wed, 21 Jun 2023 05:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuMh-00023G-PE
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:43:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuMf-00015i-Uk
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:43:03 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-518b69d5b5dso7780029a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687340580; x=1689932580;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y7yxYGxqlc/vJ/zCVF6hmEoorIc5CKvHshLGKf5ND8I=;
 b=Du7O4rogg9Li5fxM+UG3M9GCOHQmIDIi3tkQh/dP6+Jb8adw+DzY3jWaGU0zw5PIAW
 rrWgPDN4EdWUUeB7yXHiseHPuqH42QggSCKxJfBHDpM/kHM3+dVWSsQOuBhnOeHVTkRL
 qV/HMLqc6vGOBD7Hgo1dOazRsBmOyOIBTfCmHvMnMYLj8aCln8juHBZtVLXa2GawRfxe
 A4kjD+tnAzmFN5Q1rQ0Fziq/UQFf4thL/DnujS7AGkmBWUC21jLog57M0ru5crAxFWrM
 7X1YaWS1JQwpMk6a7cH5Yvwtx/+ye4HacBCPkOFZalrpjIGMZMa8oYzdPYXLM7ln7Rsj
 sUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687340580; x=1689932580;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7yxYGxqlc/vJ/zCVF6hmEoorIc5CKvHshLGKf5ND8I=;
 b=lGaPs3xsMprf2kQ3ZCRhr+wGHz+Ow8Dp/8I0Nvf0DFsZX9wDHRieWfX5jkTN++qVGt
 7W2u6wzsoRUGvqMcB9BgQQwVKZm1zuKhke/h85TTuziQer6cfh21YcR1cAn1DVkCjG/9
 ifaTrMd8wOj6W8q0TeuK2IBgjp5QhEQgHDNgaASIohdYcb3A3Y9441UihRqPBDZ8G2vN
 z1MNESOGNMLfrOJIHkAkO95alZ6OTUkMjZH/yTMp46z1dFHG8dOaR2GOZ6HL8vDI2JzJ
 88l2jsQpfOel5dzvWGatZMxHCgrFVwgKA86CFPHmVz5oh40olWs3ZV6WKBNgtHYJadMc
 Dt2A==
X-Gm-Message-State: AC+VfDzUdmzL85eCj8zNYDCMpMQ4r7XgYHkuzPrD5DfvW7C/ZSbP45G0
 sx3CD/eShsVhckZYc3QDn8flGA==
X-Google-Smtp-Source: ACHHUZ6e+PRDcy7SiPYFxV9S9bjx0q8pjUm1pwtqzl9N66Ybsnlbagc1JsRcLSlVG0SnTZfoq21JQQ==
X-Received: by 2002:aa7:d65a:0:b0:51a:2ca4:5758 with SMTP id
 v26-20020aa7d65a000000b0051a2ca45758mr10212901edr.8.1687340579886; 
 Wed, 21 Jun 2023 02:42:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05640207c700b00514b854c399sm2327451edy.84.2023.06.21.02.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:42:59 -0700 (PDT)
Message-ID: <0e8c4da9-2b33-dc24-77b0-cea5bdd905a3@linaro.org>
Date: Wed, 21 Jun 2023 11:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 00/24] q800: add support for booting MacOS Classic -
 part 1
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 21/6/23 10:53, Mark Cave-Ayland wrote:
> [MCA: the original series has now been split into 2 separate parts based upon
> Phil's comments re: QOM parenting for objects in Q800MachineState. Part 1
> consists of the Q800MachineState patches along with QOM parenting fixes and
> the 2 mac_via RTC patches.]
> 
> This series contains the remaining patches needed to allow QEMU's q800
> machine to boot MacOS Classic when used in conjunction with a real
> Quadra 800 ROM image. In fact with this series applied it is possible
> to boot all of the following OSs:
> 
>    - MacOS 7.1 - 8.1, with or without virtual memory enabled
>    - A/UX 3.0.1
>    - NetBSD 9.3
>    - Linux (via EMILE)
> 
> If you are ready to experience some 90s nostalgia then all you need is
> to grab yourself a copy of the Quadra 800 ROM (checksum 0xf1acad13) and a
> suitable install ISO as follows:
> 
>    # Prepare a PRAM image
>    $ qemu-img create -f raw pram.img 256b
> 
>    # Launch QEMU with blank disk and install CDROM
>    $ ./qemu-system-m68k \
>        -M q800 \
>        -m 128 \
>        -bios Quadra800.rom \
>        -drive file=pram.img,format=raw,if=mtd \
>        -drive file=disk.img,media=disk,format=raw,if=none,id=hd \
>        -device scsi-hd,scsi-id=0,drive=hd \
>        -drive file=cdrom.iso,media=cdrom,if=none,id=cd \
>        -device scsi-cd,scsi-id=3,drive=cd
> 
> And off you go! For more in-depth information about the installation process
> I highly recommend the installation guide over at emaculation.com [1].
> Compatibility is generally very good, and I'm pleased to report it is possible
> to run one of the most popular productivity apps from the 90s [2].

Could you add an Avocado test for this machine? See how the
MipsFuloong2e test (tests/avocado/machine_mips_fuloong2e.py)
handles the firmware (RESCUE_YL_PATH).

