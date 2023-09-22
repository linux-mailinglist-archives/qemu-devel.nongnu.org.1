Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 286547AB91D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkoY-0005ID-H6; Fri, 22 Sep 2023 14:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkoW-0005Hx-LU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:23:40 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkoV-00015m-7k
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:23:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2336075f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695407017; x=1696011817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IaVutyAwfwZZbfy1I7/I3UWY7YNzk9NYg8AD4SguaAg=;
 b=wF58YHUCatIVm+Y5pWZFxcsIV6ZY7hwAsu6Yd+u20M+dDWqBg0Ogv6hgEkWDNwmqY0
 sAbQkzFc1uHon2cXOJJm2RIvoO1cPGILGymjriwn9caeiK07NlWTXzhmGXrSnLqyF5Xu
 Gq7lKcfUPg4TQboU4crhAFwPF7XZPGH4F1p1EFF3uZzzPx+nPGZd6xNbiobwp+azXsNb
 lmtp5bBSVRg4SBhPKBGqDQuAJfKaicGu5WjZpYLAbKkDVT/z1Tx0Afcjvle4AYwbEQsa
 wSCwQvmdR3czcvXRbGmtnRLqRsS8XCKVb7L96uEh6hO7KDmLIUS8BI452Lx7XKsmxaxi
 GTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407017; x=1696011817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IaVutyAwfwZZbfy1I7/I3UWY7YNzk9NYg8AD4SguaAg=;
 b=YkRy04UpfKQMSpNnN/E6EwEo6X9z2tih/S/0RO8nDerF9ARh91N0TC03iEapNXS/6+
 HqQDBPLp9oSikOr6FAfKyVdY6nRIMca9TLGGBOrSFImyCws3BzAex4hLwdz+TCA9SPIM
 W9RvTiv0CmtF0ClOG/xjimLbmPwP7WsfxHbsFeqvZzQOOSRSyIjlXA+yWDAUy9BNSMwQ
 P6iyBKZ0288EM4SKyiq3X/8jDjneKYl18ulIw1IdMzyTHdq4lvXRTXv8JmLr//Ve8kfw
 UgwNOCHQGdVVwETsiq94OzwqF24vHtbOGHknRAtWcXuVxEJlW1Q7eGmjBoCCFJzoyjPx
 0r5w==
X-Gm-Message-State: AOJu0YweOOr+rIrKI+jEB+VMwYIQBfd5EDIsz1vwR5A48lKr9EWbQ6hr
 fV1piwIJBhY4hjTPxNLdaIv36g==
X-Google-Smtp-Source: AGHT+IEhE2ghZ8oQB0VrAWJ1J2sIvJnSz8ElqYFGdE2fwVs/N3YCAYdWYbivq/QAZ+lqR18KlhsuGw==
X-Received: by 2002:adf:f58a:0:b0:313:f463:9d40 with SMTP id
 f10-20020adff58a000000b00313f4639d40mr351218wro.65.1695407017460; 
 Fri, 22 Sep 2023 11:23:37 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 e10-20020a5d594a000000b003180fdf5589sm5107382wri.6.2023.09.22.11.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:23:37 -0700 (PDT)
Message-ID: <bbea6e2c-d6a9-7b7e-13fc-a76ad31775b6@linaro.org>
Date: Fri, 22 Sep 2023 20:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] aspeed: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-3-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922155924.1172019-3-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
> Remove superfluous local 'irq' variables and use the one define at the
> top of the routine. This fixes warnings in aspeed_soc_ast2600_realize()
> such as :
> 
>    ../hw/arm/aspeed_ast2600.c: In function ‘aspeed_soc_ast2600_realize’:
>    ../hw/arm/aspeed_ast2600.c:420:18: warning: declaration of ‘irq’ shadows a previous local [-Wshadow=compatible-local]
>      420 |         qemu_irq irq = aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
>          |                  ^~~
>    ../hw/arm/aspeed_ast2600.c:312:14: note: shadowed declaration is here
>      312 |     qemu_irq irq;
>          |              ^~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed_ast2600.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


