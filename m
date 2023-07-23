Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E675E111
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVni-0002xQ-2S; Sun, 23 Jul 2023 05:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVnf-0002wp-R8
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:54:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVne-0000SH-C0
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:54:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so31191205e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690106088; x=1690710888;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrErL2obAxAAiPfYIl1mVqoO9WSMqdQobkzypjE66IU=;
 b=YLwV/hR/oWUmAtU5xLl892iz4Yr6y6pJ5nyvnolJ7WXKlcZfjpoO349gUc41vKeytf
 miPHW5CCJtgfu/dcWU1qC54kdH9HzQTIAESL1GDnonAA4iWsqfBsPC2Db0dbL4w9ay8g
 YQo3jmx86kbp6Di8WgCUXiNLltnjsDSKPn+LwmoG4q9ShTOqtTP7TDpiQ38lhSRgdLsb
 mvC4lbWY/iaQ1jJ70ss33cpEhz+3EgLgO7DJ2N9Jefck6nDD17zAHBvNBgWzxiP2kBh0
 ztoNOlRWRm3UxXg1ZaUAkIsgA4fEuyiy0obLXGnpgl8JncuTT2QUspSIuC61UjUXnxnT
 I0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690106088; x=1690710888;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrErL2obAxAAiPfYIl1mVqoO9WSMqdQobkzypjE66IU=;
 b=MnfO3yB0Xd4bRy1hwlykmO/zKzd1bYVV8ntF+0Vu2E7ThhyXRv+J47aQ3GgORuks1a
 VmmjbleK7nNp4YjEKlGwh0Ibh9OOWBkvF1PP5N7EoTvmisGYJ/pfJ8Mbd9D7bjTMxadS
 t/G9fqhHivR+cP3Ibbsv629FdlUWnoTFm/eGmU0LI50zAIoMtntUJtSl5SEdvH4is9zf
 cWWEG2X1s04N4XZEa66d6wC5juYHwDu1RV9IBohvP0FuUkblSdOsKBcIW/dzFNz3xW9d
 09a999qAqtW+dQA0dPMAVpXrOjY2k+N5X+4Y39pcxm7RmP21biFwIi7RkKgMo1xtt1Zi
 NOUQ==
X-Gm-Message-State: ABy/qLYMjurLlu7RY0cL10ea/b7OxxXX/n9AHjvJ+QuaABsqWUS3RIJf
 4T05Gcs/+K0vDP/VT7N9AGoxjw==
X-Google-Smtp-Source: APBJJlEY7ZKFD9HyGIAC96pgvqzWibrvsay7EfErzCv2xA5AtaeN2jtYBMmBR8pf9W0Mb1z48+VGjQ==
X-Received: by 2002:a7b:ca4d:0:b0:3fc:70:2f76 with SMTP id
 m13-20020a7bca4d000000b003fc00702f76mr5502287wml.20.1690106088267; 
 Sun, 23 Jul 2023 02:54:48 -0700 (PDT)
Received: from [172.20.2.226]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a056000010100b003144bfbd0b3sm9215601wrx.37.2023.07.23.02.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 02:54:47 -0700 (PDT)
Message-ID: <2ffa4ff5-56e8-1f4b-a5e4-df3eed4004d8@linaro.org>
Date: Sun, 23 Jul 2023 10:54:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/14] target/arm/ptw: Set s1ns bit in fault info more
 consistently
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 16:46, Peter Maydell wrote:
> The s1ns bit in ARMMMUFaultInfo is documented as "true if
> we faulted on a non-secure IPA while in secure state". Both the
> places which look at this bit only do so after having confirmed
> that this is a stage 2 fault and we're dealing with Secure EL2,
> which leaves the ptw.c code free to set the bit to any random
> value in the other cases.
> 
> Instead of taking advantage of that freedom, consistently
> make the bit be set to false for the "not a stage 2 fault
> for Secure EL2" cases. This removes some cases where we
> were using an 'is_secure' boolean and leaving the reader
> guessing about whether that was the right thing for Realm
> and Root cases.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

