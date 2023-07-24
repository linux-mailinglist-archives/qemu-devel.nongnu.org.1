Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7975F928
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 16:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNw5k-0000Uv-Ey; Mon, 24 Jul 2023 09:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNw5i-0000Ts-JR
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:59:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNw5g-0006ec-ID
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:59:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf15bso42910465e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690207151; x=1690811951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82/oiZCqlYBPw7WsjhRAAeJQPwk7OyoUJ8s5f301u3o=;
 b=uKMht+UxOVB2SgPr6T/aXp6BPmlTZxvWIkTNzrYJVLd7OYq6Lilaila7RtthAIhrtL
 qD/s4p2gPwy0434hFGcPoD4KcoMq2XkLu1eL2oiLMI6CedvAnf4jVC4Mv6fTK5S1vRjz
 3JbR9RypCTLZF/4HPbUlbcwQ1Rrdl04fj85etYfwYhHnXJW1nUW2L0lqrq1K4DQmUdQw
 VoJb3HDAMDS2xezRVJYGXlKdYq7fZmJ22uOJ9w6Yp9zj7PWQAHIMic9oRhv+A6oEAlaJ
 PR5rJM7jd1p1kl5Rlelt+Rme7isPLX7BKIJxCfRvDQCKHGweST0jT79rEmy+sC52uDNc
 zTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690207151; x=1690811951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82/oiZCqlYBPw7WsjhRAAeJQPwk7OyoUJ8s5f301u3o=;
 b=eJPqaqgaFt5d67sMzbsPXBFxW8GqI7kdX+fCFjgefRPPGiWdZzYB0zzLLf4EiRO/J7
 Ao5V+xLprcgC+y7z/efPhGJxsG16hNz2uwqHo3pYXxGdkJ0vBPtEVW0n3Rkz2ZIT0PfF
 rXuJMLazJdHEKa1zJm5TKq9tJTMGzvRQ5uN3yytRPBi5xYaXDUICDUBp8nFogCAwzCWJ
 ItwTbSZ5IzcpfDDPVwX8hJxV2CPtGKDH5n9C+DU2C8vjjZzlM5uvJiTJrfpVQNkyC234
 QctOc2V1z1DbK9VmvGfebpRxfwlB6Hf05zjQrS9HFia1NJ0XXIDVwW+CEpW1WFsSNrif
 RpEQ==
X-Gm-Message-State: ABy/qLbYB1tTR6iip1e5XZ8BQoQQskdhIUTWvbmIgot7YJTawAPvK6mv
 /InZFBWjh5idKsk48aDaTQn7qQ==
X-Google-Smtp-Source: APBJJlGg06AeCshlouzmvedj/cp1vBmACwZHkuadHY54SKp5duZHx4H2pTmI/b4rk0LCn9jmrigRZg==
X-Received: by 2002:adf:f84b:0:b0:314:377:5e43 with SMTP id
 d11-20020adff84b000000b0031403775e43mr7192531wrq.48.1690207150746; 
 Mon, 24 Jul 2023 06:59:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 j16-20020adfea50000000b0031424f4ef1dsm13165860wrn.19.2023.07.24.06.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 06:59:10 -0700 (PDT)
Message-ID: <ed91cfbe-c5cd-2550-ea35-214e58ae6ce8@linaro.org>
Date: Mon, 24 Jul 2023 15:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/sd/sdhci: Do not force sdhci_mmio_*_ops onto all SD
 controllers
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Bernhard Beschow <shentey@gmail.com>, 
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 qemu-stable@nongnu.org
References: <20230709080950.92489-1-shentey@gmail.com>
 <52b5a36a-5744-0ac9-a3f5-0dbd247410ed@linaro.org>
 <3F4FCDD8-91B3-4331-A336-EB31E0237625@gmail.com>
 <B5DFB2DD-E01B-42A5-9907-B2988D683F9B@gmail.com>
 <13C66458-1744-4747-BF2D-72371BC00755@gmail.com>
 <61dc5162-e125-326f-b6ca-020cfd825f44@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <61dc5162-e125-326f-b6ca-020cfd825f44@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 24/7/23 15:44, Guenter Roeck wrote:
> On 7/24/23 00:18, Bernhard Beschow wrote:

>> Ping^2
>>
>> I would like to have the bug fixed in 8.1.
>>
> 
> +1
> 
> Not that I care too much - I build qemu myself anyway and carry the 
> patch locally -
> but this really should get fixed.
> 
> Guenter
> 

Patch queued, thanks!

