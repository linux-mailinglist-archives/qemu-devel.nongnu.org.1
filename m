Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67C735B52
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH1A-0000sQ-7f; Mon, 19 Jun 2023 11:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBH0z-0000rF-4d
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:42:02 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBH0s-0000MP-4N
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:41:58 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-988b75d8b28so140734266b.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189310; x=1689781310;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6Zg5Ptr5rt69qtuNavlCpsXyhZuQAiGTP6iZDJ7VOo=;
 b=sky60ZdtjU6xYUuH/8F5MH/yOECAVrz2bb8i/iXRSR8JuefMlEJRfjTR8LbmslIGUv
 sBw4LMkwFTLRtA4X5oBUomHBz+ImMWcBkeJISg+fqjbrEw+YaACgLhdreV/DXFaB8yMM
 DXDajY6PCOJkOhhdrTq8UXRTqQ+g8uvIL79Kt6eHaeAQKdrqDyEbLKPQIZOHqwX6M3PF
 SIKXugUMX6kDEFexjOYyxY0QKKjkLpl8ouY28MFfILtskzVgZOGIYxUN7ddaMUyTV6fx
 ZxtR6+JTmfAojC6ajKfSfeK9IP0yB0U49+Tb6mXi11sEhL9DuMPwpV/FRLD/So1bF0IW
 QvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189310; x=1689781310;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6Zg5Ptr5rt69qtuNavlCpsXyhZuQAiGTP6iZDJ7VOo=;
 b=EyO6TgEZMEFokuPhiHKpS6uSVxzwLhyTOJNUT64LYZOWZieQKq4WPWpIVZZJDqS3HK
 5XgPuXUtXvTjtHsVgqJrn0Uc5h4dVAQll0Zd5Ty0G2El3QmIyceVs7836oynMRc/3HI0
 OiQEuP0LzPidS9p60/TATXh7jr0xco9uMnqAa+TkgCrvndkkP7FexVwndq0XqegjVZr+
 wQFnrnW2ITt70+IvjZ6ap0nSVzAd59J9/RU1sO+21OS9Vgah/oEdXMZckybr9YDMoLmr
 r6txQ0uaj+vdbAZlLMi69w/CFV7p/uIuwOWqF1DPvElwEhZs/h79rF29R8NpkibebXlp
 sr1A==
X-Gm-Message-State: AC+VfDwKb7S9oujc3FAR4FWu8EO1ZEYGvZQFygbSg7HYrCMO1Qhxk1zD
 VX/PB537eXuNk3PC5AkbqOuy7Q==
X-Google-Smtp-Source: ACHHUZ4a07rVBY/VmCS9gELQPKwIBrO0nqDgc16gEWpvnpT6wmtOfTkOvHAYZzPqlUJ4UhL7A1w0sQ==
X-Received: by 2002:a17:906:aac8:b0:978:6b18:e935 with SMTP id
 kt8-20020a170906aac800b009786b18e935mr7335005ejb.23.1687189310194; 
 Mon, 19 Jun 2023 08:41:50 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 bt16-20020a170906b15000b00977cc21ddd8sm14983400ejb.54.2023.06.19.08.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 08:41:49 -0700 (PDT)
Message-ID: <f7d45693-78db-261b-f016-c198a7c98d97@linaro.org>
Date: Mon, 19 Jun 2023 17:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-8.1] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230405185922.2122668-1-richard.henderson@linaro.org>
 <2d46a274-8234-a635-81ca-c79c2969cb7b@linaro.org>
 <fc35257d-8af0-8aa1-af88-982c7506bfa5@ilande.co.uk>
 <a5c261f4-b3e5-314f-b28f-dfac54a0bed8@linaro.org>
In-Reply-To: <a5c261f4-b3e5-314f-b28f-dfac54a0bed8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/11/23 13:02, Richard Henderson wrote:
> On 5/11/23 09:40, Mark Cave-Ayland wrote:
>> Obviously nothing notionally against this patch, however if you could give me a few days 
>> to run my OpenBIOS SPARC32/SPARC64 boot tests against git master with this patch applied 
>> to double-check there are no regressions, that would be great.
> 
> No problem.  I just didn't want it to get lost.

Ping for results?


r~


