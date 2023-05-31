Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A955718270
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M5s-0005vp-3O; Wed, 31 May 2023 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M5n-0005vc-U3
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:42:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M5k-0008UA-Tr
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:42:22 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so44505255e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540538; x=1688132538;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxT6E6+X6kOia7nLMhfDhCTwB2Gu/me/mbRa1FPYcCI=;
 b=q9uy7/fqatWPghNWmMUe6BXnRDmM3mAJlfePZ5svIO2BqRvA3oAuiHQHlpLmn/UT6S
 3dV+SHf4TIO8iEu6onBolOi2pNXEJ4urYAK8zp2R88TYduHmdHItU8BA/o+x7R20vxsF
 808E8UzTQRb/U9YVHEiZbwgm2IlhPreAc8dqH/gqFBHCAJZIR8FwPlPP/Df5cihcDuFE
 DDL3qHmYNjrzmUQUt0v3gVj80Azl7ZMPmy8PfM2nWncWVWHcGONG6IFSx73DY/zTxvup
 WdLpLYkAu+tpxtM2EalTYQRAXX4QkbVdZAYdPtkYOh16LQ0lVYPf1FgNVTLn9h5KRB49
 qwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540538; x=1688132538;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxT6E6+X6kOia7nLMhfDhCTwB2Gu/me/mbRa1FPYcCI=;
 b=lWfARUsRozKqIflb3f44AzhGaawJzDaiwoDLbNZ5y6Jk0SHsExOreIDV2bY7C33QJO
 /x5SPirmqWLroyDFvdIh5KOYWUWHrwdXfikJRqZsh05AL6sE68jqQ7ODOqObu3mRrcAs
 5JsJcg0gm9mxYKUhGUJDlWuakeiFkvO48cAfQynvgCbEyI5k25NwvlEzwpYpdO0XzVwh
 XfpG/774hRzex/+awdN1bMV/XeY2kKp70YCVl6N5QQR1m9wh6zPYu+PTc935mR49h4PO
 Yunl7zeNNxi2PMI0yVZeLmF+lI609VHAtueaOeE569/zOgfvPTMgyrFCrqSXf1En1wCQ
 8F/w==
X-Gm-Message-State: AC+VfDyq8lsBMOJ+j6sVcZmRGVEN2c71PuwFbWOeqfK0x8C9xCljhUVr
 MKCBfdBEapDoOTU9cArBuDbkfuXjTUQ0Q+5Q1Cw=
X-Google-Smtp-Source: ACHHUZ5f/3SBTvZKY08l3gVAM3E/cWhrnoaD7jyBOzVlJq56Hc6MSUWT4y8PriSTFuhvSwCSggTxaA==
X-Received: by 2002:a5d:4acb:0:b0:309:3b8d:16a8 with SMTP id
 y11-20020a5d4acb000000b003093b8d16a8mr4394145wrs.50.1685540537785; 
 Wed, 31 May 2023 06:42:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c028900b003f42a75ac2asm21011764wmk.23.2023.05.31.06.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:42:17 -0700 (PDT)
Message-ID: <b4c09603-065b-678e-8ec2-86fe5654ce57@linaro.org>
Date: Wed, 31 May 2023 15:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/23] q800: move ROM memory region to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 +++++--------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 6 insertions(+), 8 deletions(-)


> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> index 0f54f1c2cf..3e41f0e297 100644
> --- a/include/hw/m68k/q800.h
> +++ b/include/hw/m68k/q800.h
> @@ -31,6 +31,7 @@ struct Q800MachineState {
>       MachineState parent_obj;
>   
>       M68kCPU cpu;
> +    MemoryRegion rom;

Declared in "exec/memory.h" (missing #include), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };
>   
>   #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")


