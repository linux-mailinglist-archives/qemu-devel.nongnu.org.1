Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3877A923D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEMH-00085M-1F; Thu, 21 Sep 2023 03:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjEM6-00084B-Bn
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:44:12 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjELw-0007yy-2W
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:44:09 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so78864466b.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695282237; x=1695887037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UBuyLqD1BFTxDbgUquWdb9yCrHOtWS66E8Fy80ETbqQ=;
 b=ts+qNJuSuvqjSxGanz2mYTGDtJ3792/yVh6fzNcMLuAqOaGHbJDywLUT4D/GcpZNvH
 z6l0cJcIXhagS5clXNabff7/Jv/hsyoHTSFyNQe2w3S6IL8FYPWJLGZWwijVzXzZ3Psl
 PW4Hl3bX7r6lZz70YIPcAc5K9f0+bSNazZ6cX3lWzKCveE3RhFfsTILTW38HKov6fIiU
 ZlQa05eIICXhyWWF2A5ZDCML4l7N47IgJWroNHt0bFAnXSPPD76O8xYNOcpqMZ/kNndu
 378XT5RiZ5G/MBYjU5EO6KLS7Ac7NnAUFD6Hc6GOkrqg0NhYNOpDRT5ZVFn78asszpSm
 j8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282237; x=1695887037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBuyLqD1BFTxDbgUquWdb9yCrHOtWS66E8Fy80ETbqQ=;
 b=cpBKWb/N5aYcsKXlOLwM1NUTFeNf5GzsujUkrl2O2L1iVJV91AepWjpTGijbCpqqNy
 38rpLWuxSLKYYRMjcf5XLO+XcUKtOXhH2+Jluc28AjaDzsyK7zBqZ8cSTBpRFQaKoZPX
 OKHKscAxuyeC2tOfZ55EZ3lWcHkCgZiU0jllkJ3KOW+AK0G4JSDGcVqM9WGZGgsWUAK8
 UZ9vlx4C+uK16wn+fZzcjOe1b4utoydpbgRdjKu9bSJc7oKEdlbQ/BzrGDRatF9vHACv
 hlCJZzom6iy1444ns7kS8IVEUy2ebjHzf95ABLPYApX1brPb5Av07hZUbIYbtefxGGx3
 M+gw==
X-Gm-Message-State: AOJu0YwhVi+LuhYWLlX3pBT5M5vi+zrmVzeGhhMqoI3JAVnRbYF9GNOj
 CcSqr10b4slDdw35TpxpDnAZIA==
X-Google-Smtp-Source: AGHT+IFyI1jX6PdOxeBTqvqi98MwIEx88WJffbbKTMusWC3ojOqfZCUFKvon+G8OhmyT3/8RPnKaTQ==
X-Received: by 2002:a17:907:2cd7:b0:9ae:4eb7:ae8b with SMTP id
 hg23-20020a1709072cd700b009ae4eb7ae8bmr3173959ejc.7.1695282237475; 
 Thu, 21 Sep 2023 00:43:57 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 fi3-20020a170906da0300b009a1fef32ce6sm641047ejb.177.2023.09.21.00.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 00:43:57 -0700 (PDT)
Message-ID: <8c11bc64-e22f-6ad9-af3e-e7a690536539@linaro.org>
Date: Thu, 21 Sep 2023 09:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] plugins/hotblocks: Fix potential deadlock in
 plugin_exit() function
Content-Language: en-US
To: Cong Liu <liucong2@kylinos.cn>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230921061231.60948-1-liucong2@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230921061231.60948-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Cong,

On 21/9/23 08:12, Cong Liu wrote:
> This patch fixes a potential deadlock in the plugin_exit() function of QEMU.
> The original code does not release the lock mutex if it is NULL. This patch
> adds a check for it being NULL and releases the mutex in that case.

You are correct.

> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>   contrib/plugins/hotblocks.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 6b74d25fead6..1f713f1904f3 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -70,6 +70,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>   
>           g_list_free(it);
>           g_mutex_unlock(&lock);
> +    } else {
> +        g_mutex_unlock(&lock);
>       }

The code stays simpler if you simply move the unlock call out
of the if() statement, here.

>   
>       qemu_plugin_outs(report->str);

Regards,

Phil.

