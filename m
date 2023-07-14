Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F29753246
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCcg-0002pW-7r; Fri, 14 Jul 2023 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCcA-0002ml-Ic
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:49:21 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCc7-0000Ov-55
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:49:17 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6b91ad1f9c1so1277254a34.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317348; x=1691909348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4FIWKdYrmInmq9U4lN0gaf+FX8HlpekkwQN86ZEDlYg=;
 b=okbGYrWl5bWb+PGbA3IvE5FDQMkT484YZ/BxaI9Xp7FM3+j2SHOA7SlYD+V3ccL55n
 khWJwF/W3zTBzg+RUJXznthmuD6x8jvCeupDZGgfvww2ek+xatB5zGHpXrFL7rIonKIH
 AwaqvgQv4cix0ISzpAdBusznkprzMsGwnJCkaNJKElCu1zivpjWnKiHxGCq5JJTXzVn5
 kG6+vOWYg/+mqNHE4/9ieTgwOqrWoGBq0hI+QEZeRk53Gf6ebXzddM0GBe4YCbrKT+U6
 hC3XsMWKmpQeXy33XukDsaGofUJ9WH48tjzETqS0fig19GOldqxAJ3sfdUwrr6LKamon
 iUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317348; x=1691909348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4FIWKdYrmInmq9U4lN0gaf+FX8HlpekkwQN86ZEDlYg=;
 b=NCyXyf+ksqD1n+CKbtCrP81zr4CYEJkGDEPf522b3kk7XPo3OjU6V5zkCC6DFw/tRK
 DVfcrHdSufdQYLtAhzOtrssxzqegMPDjHUDEtOiHrfxkV2Boi5bvUbeKZUFoCR8HWWqX
 Ylm6kjDMLS4k/tbqOemTikbrHN9G4Solc165Fu36dLenVojlfY0EQTj3nq13iXM10Qvj
 uuVDs+Wt+/ure8VmYwMIp09oB10CkzWhaJ3vEYUGt7pbhyON8Ko7v9bbyMoMaCAC2Eg1
 oy4CFVCxl6ZV9vP4zFYUZNsJUiKcqZhTqBh+6TE031Xvye2Zi3ewApUj2QNu43Xcaq/8
 fRqQ==
X-Gm-Message-State: ABy/qLZF4SjkxrYfzEJ7Wdvs11HD1wCJ+6DQx0N4wvEq2LLHxxhqkbet
 AT9KAq0oZaZDF13eZZdYsfefEQ==
X-Google-Smtp-Source: APBJJlFNsjYKqjWlNzEnFuiJPMJ+VoaVoJz5KpqFVzRNTgZsoYjepJTGxlhElC2wKjlg+30Pbim60A==
X-Received: by 2002:a05:6358:339f:b0:134:cd32:3565 with SMTP id
 i31-20020a056358339f00b00134cd323565mr4740774rwd.31.1689317348440; 
 Thu, 13 Jul 2023 23:49:08 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a62e70a000000b006687b41c4dasm6448290pfh.110.2023.07.13.23.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:49:07 -0700 (PDT)
Message-ID: <4e360b70-3c13-ba87-89b7-d4b36319bcd7@linaro.org>
Date: Fri, 14 Jul 2023 07:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/11] hw/char/pl011: Display register name in trace
 events
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
 <20230710175102.32429-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> To avoid knowing the register addresses by heart,
> display their name along in the trace events.
> 
> Since the MMIO region is 4K wide (0x1000 bytes),
> displaying the address with 3 digits is enough,
> so reduce the address format.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c      | 25 ++++++++++++++++++++++---
>   hw/char/trace-events |  4 ++--
>   2 files changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

