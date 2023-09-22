Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD57AB932
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkxd-0008Mo-0S; Fri, 22 Sep 2023 14:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkxb-0008MC-18
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:33:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkxZ-00034K-J9
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:33:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so28893105e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695407579; x=1696012379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w38Xu7XC0+JK4ZoEBsrv5xcn7n9833n4YcixKlJnSWs=;
 b=A8isdKloFvAbhC0+lxydjHk3raXgtSk7wIncXq7CKaGld/5/AbqOKURTlTWlYc9dY1
 TrC2J7b8FuG+EhRE+XDIJrRHsA23gPqvAOK7S8rFd6k4m2dI0fUwrGuwjfFh9PO3KQfp
 7mkMLVVpT6bTh5mEt8aOGfPkNMzkweaBCozL/N+1ZWVoL1KSPUxY70Weioryhvr3W8Ia
 4K4AuLEUDRs4SdDX6GscDM/Y848g92/gbi/EP9qe+kx3jIZl1dMijgbkFLlhuGywQMu3
 /zQKe50woBo6EPhOLZid87Z8UknlrSvxIAnEKAk1SD8wwHXkdCo2GvGLWb6ywSKQJGNe
 v64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407579; x=1696012379;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w38Xu7XC0+JK4ZoEBsrv5xcn7n9833n4YcixKlJnSWs=;
 b=qn5J3PX5CrNHnkAhc2FwYgfuFBJvsnWw2LrjZl73h9plbs6nSxHxpTlCXaRGMcB0Kl
 7hjWV/8caypZA7HJgEAWPICBL7fuuNbL6kMjqjooH2hGAi5RaPe+46mQ2tLTh9HIuvH3
 MZh4F3eH3qudtUsXp03AdJ6Ul++2u6OZRQZ7qu3rvvqof8uqAHxBEe/Q3P7VgXAB1Woc
 +ap6cwIOJu95Ekd5Sp+0qUp+mD6akfUKyG+79K5r+FKMgq2TAxXwnJASbZmVhkIb3e1H
 Y+CA0oD5LidERHjQfPEfIUJw7X0c7BKoklPM86ql7eQWFifc2/qfAWWfx04vsB1k0YgT
 x2yA==
X-Gm-Message-State: AOJu0Yyw17eEEtpNYVXcSVps5nFViX/p8F083tjtvcW3jUd+1pYx+LdJ
 t7bMQ+0fydMJnvNwlnudorSl5vb57ioZbEYQdvA2jUt/
X-Google-Smtp-Source: AGHT+IE7MUp+6Pq1jlJARp2CGA1Xn0iRiVuHxBAz5KNq0p7hfF/9dDzQTqnCg+P+YEeYeK5W31G9vw==
X-Received: by 2002:a05:600c:b52:b0:405:48ba:9c with SMTP id
 k18-20020a05600c0b5200b0040548ba009cmr129620wmr.16.1695407579165; 
 Fri, 22 Sep 2023 11:32:59 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c251200b003fed7fa6c00sm8167276wma.7.2023.09.22.11.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:32:58 -0700 (PDT)
Message-ID: <845812e9-5dba-a34b-28e6-842e5f374ad2@linaro.org>
Date: Fri, 22 Sep 2023 20:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] aspeed/timer: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922155924.1172019-5-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/9/23 17:59, Cédric Le Goater wrote:
> commit 8137355e850f ("aspeed/timer: Fix behaviour running Linux")
> introduced a MAX() expression to calculate the next timer deadline :
> 
>      return calculate_time(t, MAX(MAX(t->match[0], t->match[1]), 0));
> 
> The second MAX() is not necessary since the compared values are an
> unsigned and 0. Simply remove it and fix warning :
> 
>    ../hw/timer/aspeed_timer.c: In function ‘calculate_next’:
>    ../include/qemu/osdep.h:396:31: warning: declaration of ‘_a’ shadows a previous local [-Wshadow=compatible-local]
>      396 |         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>          |                               ^~
>    ../hw/timer/aspeed_timer.c:170:12: note: in expansion of macro ‘MAX’
>      170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
>          |            ^~~
>    ../hw/timer/aspeed_timer.c:170:16: note: in expansion of macro ‘MAX’
>      170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
>          |                ^~~
>    /home/legoater/work/qemu/qemu-aspeed.git/include/qemu/osdep.h:396:31: note: shadowed declaration is here
>      396 |         typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
>          |                               ^~
>    ../hw/timer/aspeed_timer.c:170:12: note: in expansion of macro ‘MAX’
>      170 |     next = MAX(MAX(calculate_match(t, 0), calculate_match(t, 1)), 0);
>          |            ^~~
> 
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/timer/aspeed_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


