Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DC72424B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:37:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Vv2-00018W-6E; Tue, 06 Jun 2023 08:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Vuz-00017n-FH
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:36:09 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Vux-0000Dl-Lx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:36:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso5494170f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686054964; x=1688646964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ZvKyeHZZLdLTfykcfXQVTPgkjAUyoOfF+Gj/tdX05U=;
 b=hbPSzluT9Q7syRiwqGtyteKl+cOqAyAcjor4veODb/AkWv0LNg7oPqG0q3h2qXRw2J
 CjIGsHzd5s1FiZ6dA9fC0HDHsnFlEVlXPhafXEqND2s+TWJ5A7U+FVaTp9UL1RJ99qLP
 QqJpphkcEshzopXypej1rX9q/mr+WANTPedPvDLNCRD7Nn/N0EfQplBHmvnfSVFk4lX8
 Qa/gKqmq53NHTGTjwljHnNmqkQLnErHOY0Gxpvh9NA39iPXOYac0H3FJg45DH71EMayi
 wVxQZIXaqEErbR4I0IwIXeN0yxIQWMBW95PqRj1PFw4FFrzxfEDwDUPzLeocPm4Z9qRE
 q/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686054964; x=1688646964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZvKyeHZZLdLTfykcfXQVTPgkjAUyoOfF+Gj/tdX05U=;
 b=MtDT4f/RCUSTmUJ6mNB5o5zRztiHso2imViKoWMA8Q5P9dEbNE98UJqAcsztySLNhC
 z+x0/jompJlU5YYwrIAQismj/7GwRBG+VczABJxuip9xUbIZCj7hW5YSRnUtHI607WXd
 JeSo8F44lRcCvwW3++uOWXi1qJ/FXYoPNeSZrUBlSi4fIzV7iRc6qooOFrLnAe/xuTjh
 BJ/XCiVqDpD9mp/SVMRtQcRirJk/z3ipQM60SpVI9ZLeXH5nZX36tEYlNQRBz+C5fUJC
 gy3hpE5ujc2jzfRd9trLpLaKjK5lPvoSC5ojDFLVoPZXY+7T0kaJnRxBLTGZFUarOi1D
 qQnw==
X-Gm-Message-State: AC+VfDzWYfimmLPGWoTtk3wvxoaI7Mb1vYVZiufnCr7M6OfR+1IU/Rlg
 ZfuXSTDVBJqwqrtmMmjC7XhV/J8nYbn7w80ceC0=
X-Google-Smtp-Source: ACHHUZ4FUQuCZEs9x4BrJdTSns13Fs4WYBkySiMhl5h18h8n4nfoDrovhgKni/CjlAoncoPUKUz4UA==
X-Received: by 2002:adf:dd06:0:b0:306:3ded:2bf1 with SMTP id
 a6-20020adfdd06000000b003063ded2bf1mr2223193wrm.60.1686054964273; 
 Tue, 06 Jun 2023 05:36:04 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 o1-20020a5d6841000000b003079c402762sm12554168wrw.19.2023.06.06.05.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 05:36:03 -0700 (PDT)
Message-ID: <ed910356-c68c-a359-2896-abf08f8326e2@linaro.org>
Date: Tue, 6 Jun 2023 14:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] allwinner-a10: Fix interrupt controller regression
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606104609.3692557-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 12:46, Peter Maydell wrote:

> Peter Maydell (2):
>    hw/intc/allwinner-a10-pic: Handle IRQ levels other than 0 or 1
>    hw/sd/allwinner-sdhost: Don't send non-boolean IRQ line levels

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


