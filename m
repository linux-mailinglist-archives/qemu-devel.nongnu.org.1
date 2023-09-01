Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7DD7901D0
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:03:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8Tx-0005og-03; Fri, 01 Sep 2023 14:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Tr-0005lo-3c
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:02:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qc8Tb-0005CV-Ol
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:02:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so1915639b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693591354; x=1694196154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MWyw3E0O7rPbbqNJEq32UgC+7UjxQh6vurK4npTMA9E=;
 b=PSu8UyxRNZw9oOPHzLSZo6tdG4tp453vx6+efcbcWwHN7/P9O0lm4eqI15vyHzi2c/
 WkS3Wit41rC35luvKHUenBf0NHEem4qX0WOHslvG04SnqHw3yIsb7XUJlYJ7+9rdUyHC
 B3+ac/OdKpt+OVOQxExl9j6npR64p+jRuz2KbaXKo1WJ0HlMrbf0NN501L0+lwDB7XBX
 hVAn0wr/CSZEPzVVqSxuiSgf5K9zMJHPqeHGgUiFiDBDMjol3N2qneU8w3L+7f1DCQ8A
 TLzE9nC0h1ItqiJCrxW/2CrhMoC5yn82CYMUN3y23XYLeefAeBYM0y/p9d+QKrdI9G8f
 7PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591354; x=1694196154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MWyw3E0O7rPbbqNJEq32UgC+7UjxQh6vurK4npTMA9E=;
 b=amjrZMsn3lxlQ/Wfx+LCmT5sVoCRMO1bxj/14bG7hWxkefRRtMnfnklSRbnGNne6bu
 LWIxvjyrokm/z4ecpeSBRO4hi2GXKhB2GNVsX/YJK3o+t8R6J8oPIDSsAVPTIGMaAq2q
 hjb25YH16BRrrU7w9GO2Hn9XZFg9Ur2CY0iwQUXqP/0YFrH/L88Ikeqn+fr8EJ8RKLjg
 UKHCaeSfPgPlEKS1fJkqBGUWqLtXm2uOoflcfwtcj0QJxogGjpg+G0UImp8/5xNxL5Po
 ON46H3cZkNg0nX2lCwPqNxJHXwMo8EpBIM02hrlm0KxgHg1MdEYNKtw2N/tW/4CZV10g
 zWbw==
X-Gm-Message-State: AOJu0YypB1A87wqAc0VVYLeL3GK6S/KYBFdW4PeI/7gTPsZ3zR54qDkR
 AlAJOXGE6t/Ux63zqgbfT7mX2g==
X-Google-Smtp-Source: AGHT+IH+ybmgaBYDaTf2UxjfA019/gTaAUpcOMb1J+z1kDJMB8ukjS3cWqpyucd0R0mIMp3WKp9uUw==
X-Received: by 2002:a05:6a00:124f:b0:666:e1f4:5153 with SMTP id
 u15-20020a056a00124f00b00666e1f45153mr3908362pfi.0.1693591354057; 
 Fri, 01 Sep 2023 11:02:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y14-20020aa7854e000000b00687a4b66697sm3341658pfn.16.2023.09.01.11.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 11:02:33 -0700 (PDT)
Message-ID: <8d2ab9a1-0c5e-fae7-f57e-1829d08abdb1@linaro.org>
Date: Fri, 1 Sep 2023 11:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 13/14] tcg/loongarch64: Lower rotv_vec ops to LSX
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, git@xen0n.name
References: <20230901093258.942357-1-c@jia.je>
 <20230901093258.942357-14-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230901093258.942357-14-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/1/23 02:31, Jiajie Chen wrote:
> Lower the following ops:
> 
> - rotrv_vec
> - rotlv_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 14 ++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

