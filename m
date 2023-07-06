Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 402037497C2
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKl1-0004sr-SF; Thu, 06 Jul 2023 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKkx-0004sK-UJ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:54:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHKkw-0001AC-DB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:54:31 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51d93425853so637658a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688633668; x=1691225668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3LEwJlDCCvsscZHDcT9vhNZr/NT01L6YBlOu8f92Vmc=;
 b=ycnU1asSFzZfGXMIXTd7g8NrKLi2g+2b3zh8Ca5j0mziCqI//WohGfuresXMM3+TsJ
 XyhuCilpdW2IpsENyNqA5+++BFRfbYJUF47J6aPR0H8lqh8P08Ho3v/eU/l3+FuWqVxl
 AU+xRMrWJRJN+45T/pYjXw1GOncjpyc5C91WRfkALG57L1cfGXscZHtaMn0ZKKE76p7M
 j5yiRrytrKGxKQkAuQ2FJRmW4RDEGlYz8lg8Gt7xFxJoULlkwMXEbHLIh4xa5mVQW5ZB
 3zaFTmykqoWtyuHrLEEUADW1H44F5Ij5sFQodobpWlpBYJq0pDgFRe7JaA6KMAb81Gaq
 7UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633668; x=1691225668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3LEwJlDCCvsscZHDcT9vhNZr/NT01L6YBlOu8f92Vmc=;
 b=e+VE9xK1Lvw+qTYpJGnS2gH0A4DwqYq6aRu0DZWVwvLHU8sT2V5L5rUAW6SDobGndR
 QgRtdpdxLbbBqHZ/mbzMvKKnRHDBtBDEK/h/crUGPKDox82OBV7MRtl1HzHIu3RkjLVU
 9LwdOhv12R6JooVnJGibYwskGLswifozCAg2WsyGrldsEgKrP6BuwfjZ1yImW5DPL89f
 2wg+6EmmRjHhxxrNeRbqZVB8sKcAK6zlkNYRDAdJz5Jo7ry5zMmrL7/8LNcy5SJBY3jq
 UvE72U7o+E57bRJiMSayHO2dO5Zr6uaRElF5otYx5oQNIbMwn5tfvYKTD1W3TzTPn/Qi
 BqDw==
X-Gm-Message-State: ABy/qLb/eo1t+QkwE/wjJVQWCSmTe2kuppaUAARWOx3Vursuc4UzKi/A
 h5gyMYblKRzaInvrU+38E5rYTQ==
X-Google-Smtp-Source: APBJJlFQ6oJvGlbfXpk4Ng/Nv7/7LadrOU6TR/lUpYJT3babmH+CiRbvxoVonk92PBKA06aONHTUeQ==
X-Received: by 2002:aa7:d350:0:b0:51e:f8a:e5ef with SMTP id
 m16-20020aa7d350000000b0051e0f8ae5efmr1139160edr.18.1688633668725; 
 Thu, 06 Jul 2023 01:54:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 y8-20020aa7ccc8000000b0051a2d2f82fdsm515093edt.6.2023.07.06.01.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:54:28 -0700 (PDT)
Message-ID: <ee98ce1e-ca79-3276-45c1-09a599f19a58@linaro.org>
Date: Thu, 6 Jul 2023 10:54:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] riscv: Generate devicetree only after machine
 initialization is complete
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.c>
References: <20230706035937.1870483-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230706035937.1870483-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/7/23 05:59, Guenter Roeck wrote:
> If the devicetree is created before machine initialization is complete,
> it misses dynamic devices. Specifically, the tpm device is not added
> to the devicetree file and is therefore not instantiated in Linux.
> Load/create devicetree in virt_machine_done() to solve the problem.
> 
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Alistair Francis <alistair23@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.c>
> Fixes: 325b7c4e75 hw/riscv: Enable TPM backends
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Handle devicetree (load & create) entirely in machine_done function.
> 
>   hw/riscv/virt.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


