Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31778D6DD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMvF-0005pk-0v; Wed, 30 Aug 2023 11:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMvC-0005nh-8j
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:15:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMv9-0006Nm-SM
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:15:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so54544975e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408550; x=1694013350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1VVcPDT+yfhIMy8SArX998eJXHtNLfdLQ8c/NhuDTeQ=;
 b=dbKsarH0Hocka/QOjuCUp/ZG8tjgQ19V28Vl1FplYlFL6ianEjASpm364n8GH4BT2L
 DyNz63QH9sTxe98r6LJqJzqN+fDNjx/ap/2hvjorceKgH4HmPHsWIRp+cxedN1r5LRoa
 8DBXzamRG3mcgIzIHoR87m7IrYP5n/TdnYdmQmx+LVOEtY4ZhZcyQlH1463IKvn6x7uT
 GosrmiULZSpbJ/EaGk6t4e/h9YQmMZ+uIcrG5700QrAMnMylAE00aVgQ/BBUj19XRM61
 lQNErAAtCZInr+syX+535swRIwVBop60jv6N/Koxtk7P7jdmN7Q6H+GNj6oxDkN42Uso
 xRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408550; x=1694013350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1VVcPDT+yfhIMy8SArX998eJXHtNLfdLQ8c/NhuDTeQ=;
 b=IukPO+XsCAACo0ZSiD1EK1/dPVlGKFNzcEhHdN5W0BMopwpMbiXb+i4/w5ynsWviQO
 rEU2zO+5IEdqY3TmUThUGH51duhUdSDGz8twAHr3hOnvHypqtavh9QbHHY1leXLCs3u0
 I7M6eGX9RMRZq0rOQH/kL/UjtiA/5MDADRv8a9Oj8glW6pLyV5vVTEM3ftadbyV+Ytsl
 6NQTUsqugSxTHhdzgSYuImhUDqvq7udQoBMfYMJKVSgcl0judCnkS5vzbJ8I/i66ukfV
 q8/Je086RHFk52aGjSXnsxUMtrp+YbbUv4+OA3LVD68gw4gw9eEfDvVYVDyo7Bci56V8
 32oA==
X-Gm-Message-State: AOJu0Yyugzt3i3u15kbLiLxh7VUFcmKxw5SEhrdKNBHYNEHl0r3Oo1MH
 kbjvRrwWtefboz5K5J6R1b33PcjnWqAI2yAqYQbQx6M6
X-Google-Smtp-Source: AGHT+IGr45FmYGOpmHw7Xos15cMx5gwjXKS3/73ItZSfvxEspDiUTzDBnYxkkYzkIKoVshbvLKN08Q==
X-Received: by 2002:a05:600c:2116:b0:3fb:b248:67c with SMTP id
 u22-20020a05600c211600b003fbb248067cmr2310810wml.22.1693408550266; 
 Wed, 30 Aug 2023 08:15:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a05600c220800b003ff3b964a9asm2593577wml.39.2023.08.30.08.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:15:49 -0700 (PDT)
Message-ID: <5cfc124f-f495-dff9-1e15-799c61e43b74@linaro.org>
Date: Wed, 30 Aug 2023 17:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 39/67] ui/console: fold text_console_update_cursor_timer
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-40-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-40-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)


>   static void text_console_update_cursor(void *opaque)
>   {
>       QemuConsole *s;
> @@ -2520,7 +2513,8 @@ static void text_console_update_cursor(void *opaque)
>       }
>   
>       if (count) {
> -        text_console_update_cursor_timer();
> +        timer_mod(cursor_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> +                  + CONSOLE_CURSOR_PERIOD / 2);

This should be padded here         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }
>   }
>   


