Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F9716FC0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46vg-0006Rh-D0; Tue, 30 May 2023 17:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46vQ-0006JK-4O
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:30:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46vL-0007dV-N3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:30:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30ad752f433so3375460f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685482233; x=1688074233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6ImSubkbjbUjNZwF69C2rLByaMdghdLHpgc9tkxHRmc=;
 b=RaMmFTRRCIJ2kdIefaOIxrMB0Kn0KWTHL86uFej1S5OT9S3xrRbtdk6OwLtC3C57RL
 uKth3pDID2OFbjLUNhgjZeG6AZCKReeOrXn7j60GTIDp0GXlBFtSrF9O8/UnfJmOnnlU
 KY6XJLwhxKvmTj0w6GYUmyWfCZVrYtQCxjHLmmu2e0qJb6kvp2zjZZlz2zmIFrEXDEFq
 LbZJdbjnBOqT/9mE9TzdG1clnqeE2oSXyb8JWXC2MFOxExozgZJmIivXAF5RI3Iu8lOC
 et80wgsZaSYndKIDwdm252HkAgQ4PiadE6+Y45XFtzHPaLp5Qq8OZHFPgrGGGhsayXYE
 RDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685482233; x=1688074233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ImSubkbjbUjNZwF69C2rLByaMdghdLHpgc9tkxHRmc=;
 b=CQ590AHUnidKj5glOvimACVFTD0O2yrIyPZ6qK49sboVuSTSIq75Gl0f6rRNBxgCVu
 qQBgcUJDu33/0El33DX5kaoizdmFNjpdUEA+pBuTgK3bJx29IUubmMQsPAMiVqwLJ3I+
 QV0Kg9Kj8/I04hzWxATSvle1OcnH+FENcPfHbjSm1ANsC1dVreQCUA8KTyYa/8SjHW5l
 Zsl9XOQP88C+OakIKfFxZJ9Joe6udpBtXkTd+P0lCJ4hvgiTUTG8uS70EbVhZpO75wLs
 QQ6ddnXJX0N+zOXC5GBk6kN9TQ/VXqMDN6oJ7atfTP3JRQeqx7wUOSRHCs8iXrMeZ0ar
 uL/Q==
X-Gm-Message-State: AC+VfDzshhYDLVnjTq6wGIvXbRW/2c9hzehJl6VIg5c6SU8enDqRjRRj
 +FTnKQ3PtThgcI9MZ+TjGGWzuw==
X-Google-Smtp-Source: ACHHUZ6Q6oXBqbNcPrJz6Is318zgTHrJJfNvzs9a+YrOpSAfPdV/KJrImY6rnmHSMJmcZ/sS5csanQ==
X-Received: by 2002:a5d:610e:0:b0:306:28fa:16a7 with SMTP id
 v14-20020a5d610e000000b0030628fa16a7mr2643895wrt.43.1685482233172; 
 Tue, 30 May 2023 14:30:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 f15-20020adff58f000000b002fae7408544sm4388866wro.108.2023.05.30.14.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:30:32 -0700 (PDT)
Message-ID: <515e97c8-eb14-9d74-8942-10808bdad4af@linaro.org>
Date: Tue, 30 May 2023 23:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 01/12] aspeed/hace: Initialize g_autofree pointer
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> As mentioned in docs/devel/style.rst "Automatic memory deallocation":
> 
> * Variables declared with g_auto* MUST always be initialized,
>    otherwise the cleanup function will use uninitialized stack memory
> 
> This avoids QEMU to coredump when running the "hash test" command
> under Zephyr.
> 
> Cc: Steven Lee <steven_lee@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>

Cc: qemu-stable@nongnu.org

> Fixes: c5475b3f9a ("hw: Model ASPEED's Hash and Crypto Engine")
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20230421131547.2177449-1-clg@kaod.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/misc/aspeed_hace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
> index 12a761f1f5..b07506ec04 100644
> --- a/hw/misc/aspeed_hace.c
> +++ b/hw/misc/aspeed_hace.c
> @@ -189,7 +189,7 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
>                                 bool acc_mode)
>   {
>       struct iovec iov[ASPEED_HACE_MAX_SG];
> -    g_autofree uint8_t *digest_buf;
> +    g_autofree uint8_t *digest_buf = NULL;
>       size_t digest_len = 0;
>       int niov = 0;
>       int i;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


