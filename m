Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CFF737FC9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBveY-0000kT-EC; Wed, 21 Jun 2023 07:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBveV-0000jj-Hv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:05:31 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBveT-0005v2-NX
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:05:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5193c97ecbbso6065804a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687345528; x=1689937528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CXF0gJ6WQcBAdJm4ju7cOHbUg46imtW1hD/ZkxQdzuE=;
 b=ZfJbCjkUOQDM3SOTGWy4J+TOWu5P1DFpgI3A8rKGztiTkQHBdaWL6rH5YYDKry9RO4
 iwx0pqA6ru2DjpWBglaxyGc0loIuHcebYNlEu07lJn7O9fcLsjtIXRI7K+N2MnpaEtUf
 5z6yst1oOiPdgD74uBsYzpJq45TI5F4O1wCHzuoj9IY6Ckna7d2hd1YlcCxg0kryjdSy
 Y3CnA6FonSw1rxBaP0J5Kg+HpxPdroTTwgE9NQ1jHhaMafRw9j+JCjgxHqZEZu/MyaCr
 ELiFOKrX01c7gvrutzKVIeFzh7uoP5aTzFWyS04wC7vn88aH4NxveQFkd6pv/MhLUzBl
 f0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687345528; x=1689937528;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CXF0gJ6WQcBAdJm4ju7cOHbUg46imtW1hD/ZkxQdzuE=;
 b=FsJq92j9NLhEoW/3klptt4QzMDULsSOemGGPpwNIWURvel4D3pEtYEopqE7q3uwamY
 KEdNuHH8316k++opYywQDCJcXqI62iFAIVRAqbSdGbMZ8EwpjfnfXcdmPngncS/bgLqi
 hCbaObmW6l5TDfHclt0XmPdzREcmMB0nR7SfbvyNBu6ChO6imW9bcBT5LII3MLo0shXT
 8UlMRdU5XAx8o8stZruAP39BCdeEz5410RmBDPE6xzdxaJhOYlVRGd9idksbF6eGiDfs
 zc1hwBqwcc5p3cJMYyRAyyc0BDzeZlp3zU2ZRGR2ryz6/a6nrBeea2dk8hTCWCEGdsbv
 0Eqg==
X-Gm-Message-State: AC+VfDxolCZOv9/bkC7KTp5mX09gjlmFrvP67pl43HNSeYTGAHXWZNhD
 vTzU0zde7W3iKUuoZthFUDCkdWaWSyK5zJ3E5Uzz6CgP
X-Google-Smtp-Source: ACHHUZ7xvMiIx+K/TyjwMLSAEnk9y7pUbaXxF1M1ygkxVo42I7Lby6rVRunEL4J80lrnJihaxbnqcQ==
X-Received: by 2002:a05:6402:481:b0:516:af22:bcc6 with SMTP id
 k1-20020a056402048100b00516af22bcc6mr8875712edv.21.1687345527890; 
 Wed, 21 Jun 2023 04:05:27 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a50fa91000000b00514b3dd8638sm2451241edr.67.2023.06.21.04.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 04:05:27 -0700 (PDT)
Message-ID: <ec3c99b8-07d6-3b51-c9af-2751d846b28a@linaro.org>
Date: Wed, 21 Jun 2023 13:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/8] target/tricore: Indirect jump insns use
 tcg_gen_lookup_and_goto_ptr()
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230621101950.1645420-1-kbastian@mail.uni-paderborn.de>
 <20230621101950.1645420-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230621101950.1645420-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 12:19, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v2 -> v3:
>      - generate_trap() for indirct jump now set DISAS_NORETURN
> 
>   target/tricore/translate.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

