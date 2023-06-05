Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56C7227A3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 15:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6AQ7-00043C-8i; Mon, 05 Jun 2023 09:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6APx-0003uY-HF; Mon, 05 Jun 2023 09:38:44 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q6APt-00006f-JC; Mon, 05 Jun 2023 09:38:40 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b28fc7a6dcso270007a34.0; 
 Mon, 05 Jun 2023 06:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685972316; x=1688564316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyG4sCGx0Pl6dedIT8VWCB1P32a9UdZH6k+rrz8gyls=;
 b=Ptj1KA30KVPBylHdZUMAtl6Yq6OVHHqf0apzFop/JOXMrXcVmHp5MHr8DT3rtZ/kbf
 VgMCDnIivkxVZi28VUO0BajMvNwdrKKXfUMPd2Xrypfgp9ITe09NyLpCa5+0Z6CNbpMC
 Dc9WNx+c4GGAHkGeFpBX4VZGQirVejAXlnhRw3YvX9f7u1fvk/pby7QVIawlu3SX2+co
 Pamdq7P53j1mzs5VC7a0dRUqvZFAdDgtC7q3T3ZFyUUywqIM8LGorsl1xROxvQPmgMfX
 2EqCCne7c/VGYR1A5rswC0Otl7sIpxJVy3AntMlKji2EgCQgIsHFuCF6gM1BamBx3g4r
 rbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685972316; x=1688564316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyG4sCGx0Pl6dedIT8VWCB1P32a9UdZH6k+rrz8gyls=;
 b=FRzK2KfJtGNe/wtXyTM6QboGGmx67asFWGgyrP8M9uAd9X3syEqX3UvuvJiJKSLE/P
 RC7tZBrwOUZth9uqJorR7/2qSOeoNnpmAMf6yapncBwqOYwb0za1wYufYMryve8eh7Gb
 EaD4oAdlKE3jsCMJl7I/f22UTkcVgVk7U4mRBN9MomCgbI7+4/wTCdO8s7yh4azDwvbB
 CBLARuEQ/4qPJ74BhirKEDdQkE/Xivsq4Z7ADsuzfGg0tMl7Bkj4CflnCbINq6PQ+qXR
 mfi9i+Y3opaJU/6OksnrVkcXAgycDUW8ThP9bysJG8k9sEiwXYbM9c7AJe82h9pGadx7
 fN4A==
X-Gm-Message-State: AC+VfDxCaaoK0X9Kyh/aIRc7Ndp3y4gzQNh/SJF18aW6cEfDfF4R76kh
 /6NsoUA54Sz1b4CHoNFpXeQ=
X-Google-Smtp-Source: ACHHUZ5b8Ue0MJIp+LOfAqs7stqfbw78AT7jfI7jhsIjyiQlmKqzdmv9ViHxunG6MQcT4YSFFtgdBg==
X-Received: by 2002:a05:6830:1c1:b0:6af:a27f:66c7 with SMTP id
 r1-20020a05683001c100b006afa27f66c7mr9673155ota.9.1685972315913; 
 Mon, 05 Jun 2023 06:38:35 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 h25-20020a9d6f99000000b006af904d9c37sm1742101otq.45.2023.06.05.06.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 06:38:35 -0700 (PDT)
Message-ID: <88c7e2a6-d1f4-116e-db8e-8a3cb749dbcf@gmail.com>
Date: Mon, 5 Jun 2023 10:38:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/2] target/ppc: Fix decrementer time underflow and
 infinite timer loop
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
References: <20230530131214.373524-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230530131214.373524-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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



On 5/30/23 10:12, Nicholas Piggin wrote:
> It is possible to store a very large value to the decrementer that it
> does not raise the decrementer exception so the timer is scheduled, but
> the next time value wraps and is treated as in the past.
> 
> This can occur if (u64)-1 is stored on a zero-triggered exception, or
> (u64)-1 is stored twice on an underflow-triggered exception, for
> example.
> 
> If such a value is set in DECAR, it gets stored to the decrementer by
> the timer function, which then immediately causes another timer, which
> hangs QEMU.
> 
> Clamp the decrementer to the implemented width, and use that as the
> value for the timer calculation, effectively preventing this overflow.
> 
> Reported-by: sdicaro@DDCI.com
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And queued.


Daniel

> sdicaro@DDCI.com debugged and reported this, I just changed their fix
> to extract variable bits so it works with large decrementer. So most
> of the credit goes to them.
> 
> Thanks,
> Nick
> 
>   hw/ppc/ppc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4e816c68c7..d80b0adc6c 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -798,6 +798,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>       int64_t signed_decr;
>   
>       /* Truncate value to decr_width and sign extend for simplicity */
> +    value = extract64(value, 0, nr_bits);
> +    decr = extract64(decr, 0, nr_bits);
>       signed_value = sextract64(value, 0, nr_bits);
>       signed_decr = sextract64(decr, 0, nr_bits);
>   

