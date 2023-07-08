Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B77074BC7B
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:06:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI20f-0000hl-C2; Sat, 08 Jul 2023 03:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI20Z-0000hW-NH
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:05:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI20Y-0004Nn-6T
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:05:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so3202404f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 00:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688799928; x=1691391928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ETtkz05r0gEENL2gYXwBG5hQQhwQmKgUy+BZxM/vgdE=;
 b=RNV1X4m74BneS+uMEyADmYrFJAEoJymlrfQDlNDoz2fppBnkdStYEMVKBOSxa2J1A6
 OU+wA6mgTBTi7utDL2OFZ74Zg0crZdFkZVZUpXqIZCwlvQzxceI9hkGaWPvgMZ5K+Go7
 YndoydSoc/HiWR9iAoeDBbwN34ZDVOpGSrpUPnUMB7MP9JeVp+ux0XmthXUQcOMw0uPT
 E5uz7tyLjthCZWnSYrjfaZjcD3TdDgsQeMsWk7OBJQwfKa8DNl3jTRxYpyFj/pi6Y7ED
 CplJqFarujjzrKw92dE105SskekWXGKQ5L7hL+UEveC03lFPlBo3pHqF/Oomaj4Z06/v
 Wlbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688799928; x=1691391928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETtkz05r0gEENL2gYXwBG5hQQhwQmKgUy+BZxM/vgdE=;
 b=M8PzXjJdMwlkVowMEVoPc8gh3xTGwbRbAp2DnfbJxf5oY3UaPCesUL9j3sbFuks5ka
 sEzm/4/zcl73oErWyv8yAxJzHGkzWXqL1/pJbDfVY5e5ZyGwis2pePHuvJ3l/lIYn3WD
 fJTHcB+ugeZNHXMZpqsi2h87lT0kB53Ylur9TRlCqucNuXwL7ttgDvSgn1l0t57LwQT2
 WxLS9oks1grcky60ZYiroDgXQaupWs2ZyduRhU0MQsRttjBAAirYVGG452MEbBVrRCRQ
 tmczKgv22j7NY0S8ypD1+YGEJ9afHcdbYvLK73cNaAM2vP+K8X2mLd4KBD6c3yq7/jGJ
 AEDg==
X-Gm-Message-State: ABy/qLZ5x1t9IcZJdic6rE0Ak6D3pABvJwYNYfqMMCIXifr+ElWO3/aZ
 MeuPVpLhTwRcoIWQWLxIaEuuq53ZoxFNGwTrVAQOSg==
X-Google-Smtp-Source: APBJJlGwTXQaC9lm/0PEoF0ObcBezveleDBnf0pmiZL5giePrVepaVRYpeyH/B03aEMuVKYjn5nUHw==
X-Received: by 2002:adf:e0c7:0:b0:314:2faa:a23 with SMTP id
 m7-20020adfe0c7000000b003142faa0a23mr8281866wri.43.1688799927782; 
 Sat, 08 Jul 2023 00:05:27 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a5d6acf000000b00314326c91e2sm6282477wrw.28.2023.07.08.00.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 00:05:27 -0700 (PDT)
Message-ID: <dfd75e56-5660-2b3f-1cf2-63353e3f58d0@linaro.org>
Date: Sat, 8 Jul 2023 08:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 24/46] target/loongarch: Implement LASX logic
 instructions
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-25-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-25-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/30/23 08:58, Song Gao wrote:
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;

Use simd_oprsz directly, without the rest of the computation.


r~

