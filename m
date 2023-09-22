Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A17AB90D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:21:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkm4-0003o6-Qn; Fri, 22 Sep 2023 14:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjklz-0003nd-Oc
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:21:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjkly-0000kw-5y
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:21:03 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so2202132f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695406860; x=1696011660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BQwwpk6zDcYTAWtN8tfhLcRVuhh1lD1yqRmaGfSeR+w=;
 b=AUrpIos0atcJETl8lA8sjJxAHkkT+rUZYAyzIlYwyRF5O/s02tm2doSVNzaxixeDOG
 ey+7YCI5Db/7AH0SX8mS76ZL6vs/d3QUNMEPVCZ9ZzM+s7mWtZaQ28sV0qI063gMVq6g
 MhGNgQrJa5vNX27OLbbVU9bt6dffEdHBfaMM+HqvLW2HItz7GAwhnUhlDMXPqq4wRYD0
 sQxCJnkZwwmvpf0GmOoJw34kwbrRERP2O6MJalFaufE8YDbBkcoHkH4Om6fSGb4tSu78
 fPAlCRhYIam5LdWn6qBzlvQ7JAgtGK/2qpDi2BBewO9vCmZdKydf+08VTfq/B4nYYpf0
 9XLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695406860; x=1696011660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BQwwpk6zDcYTAWtN8tfhLcRVuhh1lD1yqRmaGfSeR+w=;
 b=VBEZvLJ7sdjArUvfvb7bmz92Xrtr/y9FOWzM8CSwOGEf7gyMpo1szAbcriaCKhNtOw
 OYvttbvNWjVHoql+S9iaTEphZ09P7WMMvB7NWsSPI52GYPwRNEDo+zu5hU3hW4qcqHE3
 9g7oA4uX5j9vnCfEhFOhKwHOc3hbh6z2YFG03ba95JbIUdqNFcF1wiYYD7p3SIQYrHom
 MLPpUsOxW/w3nJT+X/ozmoFqfxGn13cxHM8sdFJdPybZaaUK5w+TsKF33u8mb1JFgS5T
 BN7pREDGpKLWUOUF19yajj2IPKTPHE4FyQ5fa8paMFm/j1Va0t7aFcXf44n/xATOIN7U
 eeMA==
X-Gm-Message-State: AOJu0YzYoMZ2Qb9YIBkHQFip7KZkFJNFgxShE1Pw9ZyVkRaqm8kLhXIp
 fTakKG+PMGOnxTQ7RykurFlMFITOr3xeybaL9lEadYLT
X-Google-Smtp-Source: AGHT+IHFwram9pG5+JHltFvA/Zhxa3WKX03d2rgw3byarJ/JrOSNV5oF/Qx74UvIoAaHg9uUbxLRfw==
X-Received: by 2002:a5d:4fc9:0:b0:320:7272:8fbe with SMTP id
 h9-20020a5d4fc9000000b0032072728fbemr507330wrw.17.1695406860611; 
 Fri, 22 Sep 2023 11:21:00 -0700 (PDT)
Received: from [192.168.192.175] (181.red-88-28-23.dynamicip.rima-tde.net.
 [88.28.23.181]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b0031fc9402b47sm5115531wrq.4.2023.09.22.11.20.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Sep 2023 11:21:00 -0700 (PDT)
Message-ID: <f7cdbd47-1833-af1a-ae09-363c86c2e74e@linaro.org>
Date: Fri, 22 Sep 2023 20:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] aspeed: Clean up local variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20230922155924.1172019-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922155924.1172019-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 22/9/23 17:59, Cédric Le Goater wrote:
> Hello,
> 
> Here are cleanups for local variable shadowing warnings in aspeed models.
> 
> Joel, Andrew,
> 
> Could you please double check patch 4 ?

Could Markus' MAKE_IDENTFIER() help there?

> 
> Thanks,
> 
> C.
> 
> Cédric Le Goater (4):
>    aspeed/i2c: Clean up local variable shadowing
>    aspeed: Clean up local variable shadowing
>    aspeed/i3c: Rename variable shadowing a local
>    aspeed/timer: Clean up local variable shadowing
> 
>   hw/arm/aspeed_ast2600.c | 10 +++++-----
>   hw/i2c/aspeed_i2c.c     |  1 -
>   hw/misc/aspeed_i3c.c    |  6 +++---
>   hw/timer/aspeed_timer.c |  2 +-
>   4 files changed, 9 insertions(+), 10 deletions(-)
> 


