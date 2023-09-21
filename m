Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C6E7A94D6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJnk-00012F-CV; Thu, 21 Sep 2023 09:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJnZ-0000x3-QS
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:32:54 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjJnY-0007r1-4u
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:32:53 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so16275191fa.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695303170; x=1695907970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jtT5GaZOD7AcfkRvvyaceyXG4ZZEy/F3mni/84VA1Q0=;
 b=VBDn98Lwk6aCmwfSc6NQdO9wEXsI1zF9gD8BREvtIUoCCU6/bxaRYJo7dJaNhvyc5d
 A20kl8N7BA/heJNh1zisuRakgO4Vg7ZiON1efuDQVuD4aCsdL0D94uIQW1kBAyzs/CNi
 IdP71J4HeYvwYvVyMLIInIFO2yPet2Z6ajXJfgKvnlEiaM4jN953r+GTb+BaZ+eZKkM1
 x3h2dYSNOhhuPm+iEaGrVSNMnWlK8AiTWgkpZIOiZdIAku1Wc9Jm5bMD+9fXoTmLVyJp
 vM4MSdA75/hs/ZkNOCk8GOHsext8k1tDOR7nF2QyCImZt2I0GbS2Ou8OJxIiJwFIQA3u
 /IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303170; x=1695907970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtT5GaZOD7AcfkRvvyaceyXG4ZZEy/F3mni/84VA1Q0=;
 b=YHwM7oe9H9J6GL9IMO9QnGhhgrbna83u03aa/ZT5uPDtMtDDkSTtYJo+RyYjHLL5us
 g4RNHMFWOZC3azQDN+1PySSlNtUN+GO9XuqvMixfSU1kINJ2oksUIpjxFV8H2gfBOnei
 LrOXb7wPJl5LcVevchDs7peC0MQb7SH8CuP1f5hd2PN1rV3Dv9P0Z58D32pdFkHBJT5i
 jNUiMDBzB8h0hV5QfbKcrXKhewsQKlYmER53n+CopOrguEAku6tE4fIj/hgrP3wEmCLn
 hhCvptXBzBA8ovMc4UScpwZlVHGddXylDdoJjmoaTr9HX6VxAMBTlSkA07iJoWQuCtSP
 ZHvA==
X-Gm-Message-State: AOJu0Ywo/8tEC7Urx2B1tQoyt3OPFyU/dn+JH2TcMxNKxSfClEO5gMAG
 cjKI4mI3Zy9XKqYrtgYaCEVQZVCVndI4DfQnRxo=
X-Google-Smtp-Source: AGHT+IFP/E0ZsOgF4lPhbvNM4rwgezP/TVi5N3/xySG+wOsYV3Qv8lanExqQDGRf+0Rxz5csqWRn0w==
X-Received: by 2002:a17:906:31c1:b0:9ae:65a5:b6fa with SMTP id
 f1-20020a17090631c100b009ae65a5b6famr943615ejf.32.1695291844364; 
 Thu, 21 Sep 2023 03:24:04 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 x18-20020a170906b09200b0099c53c44083sm838179ejy.79.2023.09.21.03.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:24:04 -0700 (PDT)
Message-ID: <7b134840-7829-e85a-defa-d7e859ae5fe1@linaro.org>
Date: Thu, 21 Sep 2023 12:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] plugins/hotblocks: Fix potential deadlock in
 plugin_exit() function
Content-Language: en-US
To: Cong Liu <liucong2@kylinos.cn>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Cc: qemu-devel@nongnu.org
References: <8c11bc64-e22f-6ad9-af3e-e7a690536539@linaro.org>
 <20230921092311.15578-1-liucong2@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230921092311.15578-1-liucong2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 21/9/23 11:23, Cong Liu wrote:
> This patch fixes a potential deadlock in the plugin_exit() function of QEMU.
> The original code does not release the lock mutex if it is NULL. This patch
> adds a check for it being NULL and releases the mutex in that case.
> 
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Not really suggested, just reviewed ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   contrib/plugins/hotblocks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index 6b74d25fead6..b99b93ad8dc7 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -69,9 +69,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>           }
>   
>           g_list_free(it);
> -        g_mutex_unlock(&lock);
>       }
>   
> +    g_mutex_unlock(&lock);
>       qemu_plugin_outs(report->str);
>   }
>   


