Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9DB753277
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCoS-0002Kk-EQ; Fri, 14 Jul 2023 03:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCoQ-0002KQ-HU
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:01:58 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCoO-0001hb-W7
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 03:01:58 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66f3fc56ef4so1783014b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689318115; x=1691910115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ho68VsIwtZsMIxXYHYn8lsA1a2VK2kWlvPkM9CTUNZA=;
 b=bBocyXUkcFEeB8EKfN0S24JO0xAJBDgjtiOzAg5ivkjKDUVc4q0JVELcFpr+dko6HQ
 gryK9Yk0kNY2Yf9n28R/vJArXVZ+ii6lbE6W2+fesZ9cyMHYgrNkWDZNZStDfJCsU6kk
 AgeyjA9IrM5g5PfzpAh75vej6Q0sM1qenj9Vh+aiTImETRb9ejrWURsp7Zq+hVJ1w5M+
 puTtIbcdVHwLv/fw8C5wKicJ74FTIYnyzP8RJvdqR8OyFW26na4t7gl6UYKohu09IqG/
 eKgfFvW4JuzQCK1GS8PqnRsojiPavWRPDX87X1zXuLm0PLdKph8XsRY6Qzgoh28m/3Kc
 nkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318115; x=1691910115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ho68VsIwtZsMIxXYHYn8lsA1a2VK2kWlvPkM9CTUNZA=;
 b=NNwSULoG8HsbTnKtKj/l2Vgh4kaftampKmCjxiVeZH719oozQHhtujQZJs+UAxo6K8
 G8bsXA8PyZw1C6fJmiz6cCk0eHHIbGWh50x+FggrTFTCVV6fYkUHZT3frq7ZCAWRPEnJ
 1MynVa5RPsy+hxuBQEIFPu155Rm4XIchqYb8yA5xFlUsysbswOTXc7hsyP4jT2deEKxA
 PvJmhF1m3lmhcd97R3gsbQ70p/EeFyGKIllULzI+nva2Sr34agFB+O4qw5g1z8r+YMSF
 nH+TblQ2ofDUBVgsb4BZTHab4OCgOqD4ji2sdBNw82clkzZMVtthFyXcEbtWqARt4HDq
 n8qQ==
X-Gm-Message-State: ABy/qLbDe3A4DxGMnCeBukYOiztIU2HisfLwD0m9QBZGZfxwfxWwUvtf
 Qz5ROfcPrjzz7FpnOHzdJFv65Q==
X-Google-Smtp-Source: APBJJlGRy9YMW4JuO5DESUHWTNrkmog/kxJ7SGKItfZlNaeGghm+58BpGAEQe4AuebYzzW4gUiOSbQ==
X-Received: by 2002:a17:902:f548:b0:1b7:de50:7d9c with SMTP id
 h8-20020a170902f54800b001b7de507d9cmr2698487plf.15.1689318115570; 
 Fri, 14 Jul 2023 00:01:55 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 je11-20020a170903264b00b001b85a56597bsm7014340plb.185.2023.07.14.00.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 00:01:55 -0700 (PDT)
Message-ID: <b40da0c9-a629-136c-fad8-a8e1b082f236@linaro.org>
Date: Fri, 14 Jul 2023 08:01:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 08/11] hw/char/pl011: Warn when using disabled
 transmitter
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> We shouldn't transmit characters when the full UART or its
> transmitter is disabled. However we don't want to break the
> possibly incomplete "my first bare metal assembly program"s,
> so we choose to simply display a warning when this occurs.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

