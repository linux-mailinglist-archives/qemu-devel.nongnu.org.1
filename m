Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C3718400
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MIp-0003d6-0T; Wed, 31 May 2023 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MIl-0003cr-55
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:55:48 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MIi-0004Va-5e
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:55:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so5758608f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541340; x=1688133340;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tH3ur2M3INdt82gTYuNAeRE4aw7Dy7lg/JVbA9G/Q6M=;
 b=HhRABIDP9WAA8Crt8sC7KLgDngCxXZKMxGSgs9Ry0Z+SV6tT2/6D1b9tzEFUlxBFJ1
 bXwhHSyI+Q/ojxF4cIl6B4Cn5HtMP3ZcCwej0x4mQE1NiDQmWeE7RILZGthsL2UAeGD6
 dTKxJ93T0WKHctcrQRzoJOGqk/D0AGuAJbpku1WWrzanRYJ8D3H2uuNJD8GClrHaciQ0
 u+Sd5T0Cu1JLMVu0KpDlZEF5XbPoH/Jewt+dAmGJv7mCPrAfuoW8m7fgwigMlyk4//PO
 caiaZxUsEg0pad6U4pBwHYxoHq/0nIoxnebH7vr+Lb1K28x22zfbe+koDyCOsidkgfEf
 rzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541340; x=1688133340;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tH3ur2M3INdt82gTYuNAeRE4aw7Dy7lg/JVbA9G/Q6M=;
 b=B5Dhcd/RdA5dVR5az8KrAb3pTxuvTDHP4B4xYCmZPVgqVBTu/hdy5SGxXRSj/iBlYg
 Xt5vsCmejDI9Ap7Urgkri9Y/o6fU1i7Xhe1lDOBsI44chGz3JmzjeaUx1gwne2mGHe1m
 xvqojjHHlRVnSd7AGX2OBITbkZFwSfFsYsy4D4OofDZ79M/XA9xi2L/SvnVhaJvrzCKA
 VJxR/zhpZHcZIchYiFHAfMZu1evQUOd2T1AxNZk0V3oQ8nNCmqLq0vyvgMPRQ+T6zLs7
 oYASEfpaPAkH2WeqVzYzs4iYsn5KWI28HvdbTesgpzU2upcEUN+wy0VEmdKoSIhban+p
 TFIg==
X-Gm-Message-State: AC+VfDwbSUd5ZqKtoShzAgI/0weqjUSAQpI4mPK7aYw7rjQkqrqNFyy1
 cSv5ahmABgI6t2Nelg2ZKtO3tqefoWpgJwJYewg=
X-Google-Smtp-Source: ACHHUZ4tjRvucBYNCvk/UTfZJIgS0vBoRbMQq9sIvt/5rqt1pRgQF8Y0+mrsx1ejga7dYH2xpJqicA==
X-Received: by 2002:adf:fdcb:0:b0:30a:d2e6:6a78 with SMTP id
 i11-20020adffdcb000000b0030ad2e66a78mr3975680wrs.24.1685541340418; 
 Wed, 31 May 2023 06:55:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 bf3-20020a0560001cc300b00307b5376b2csm6829067wrb.90.2023.05.31.06.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:55:39 -0700 (PDT)
Message-ID: <3594a2c2-5526-deae-6259-9906d79c5e3c@linaro.org>
Date: Wed, 31 May 2023 15:55:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 21/23] q800: move macfb device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-22-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the macfb device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 946cb09e30..0e7451e77a 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -449,7 +449,9 @@ static void q800_machine_init(MachineState *machine)
>   
>       /* framebuffer in nubus slot #9 */
>   
> -    dev = qdev_new(TYPE_NUBUS_MACFB);
> +    object_initialize_child(OBJECT(machine), "macfb", &m->macfb,

Alternatively "framebuffer" or "fb". Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +                            TYPE_NUBUS_MACFB);


