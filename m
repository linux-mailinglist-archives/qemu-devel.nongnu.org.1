Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A344F7698AA
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTOb-0007fG-N3; Mon, 31 Jul 2023 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTOY-0007f5-VF
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:57:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTOX-000458-Ab
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:57:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4213056f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690811827; x=1691416627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pQPL/BpXO+J6r/Ro1mfZyptF2NHhsshku1/xRizzUxo=;
 b=XB7weZGzgrGoUkdPcvyh7sVW9tcn7GUqk8PEaxWtgxekiZSnTbp+Hp+KVpRoGrwlh7
 XIquZxjStK9oR35vBwlq1k8/Tbr/FX4MTVajOjDCpWdSE0ArmHGDfkuCZvqf8AbaeuLy
 YL3tICvKGGklshDT7dumUr410ec61I9YBgj3auwRuymOdm5/wc4oMG5ROlSFHhPOMbyf
 uJHiUEJ32fItDne3ZXlra682eUGR+RVzOR0HzsYsPerW9A09AMH7GtZRxcf89rOI5+3b
 V/FnFPOQ/JZxzwEgUonw/Wr/ELiSRrgZeUn8JL1n430rMjT9xaURvihc7o8OhEFbCG54
 JVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690811827; x=1691416627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQPL/BpXO+J6r/Ro1mfZyptF2NHhsshku1/xRizzUxo=;
 b=hQksXf2EV8egfyfzQjK+Joe1+VwJh4Zy5BELE9pZCGJJyPjNSboWoOhiZrQcRh4rnF
 x+DqG2Kv7zizpg1i7jnpklJDcVmNqFjZDsqnxKj4lQl9yvP5zk/XctVcNAPEq5VO2ADs
 WpMxWw8qkrHcxx9I+66wXQOScNrj7+uQPQG/OOsEBn9ieUanoUSrVQcBLpx1d+rZ4xh1
 77Vq9v8WYLq18OYnbUhHvYi4XJGl0AXjOtdzftYyBRpDBCoyZBypncCrgIJRZmImKzwQ
 eo5eS9I+P8TjjJLpsRvAijry26KHMsuAe7jegL52JFqzs+ylqprVJsU3Qz6+c35jBFZr
 BnKg==
X-Gm-Message-State: ABy/qLb5ay2cgUujc2Lq4m0DxuknyJlkDX7k25nPpzLoxhBtzIH8VoFz
 qhenbX4PZNOgBb9W/qLy1xwJjA==
X-Google-Smtp-Source: APBJJlGRUTm3DCm9Q443IBNsoEKgCA70dmPS9JvUqHu289DT+tZXCXVZPm/IeT+bU9/pI1fRJwUTrQ==
X-Received: by 2002:adf:e98e:0:b0:317:4ef8:1659 with SMTP id
 h14-20020adfe98e000000b003174ef81659mr6851060wrm.28.1690811827153; 
 Mon, 31 Jul 2023 06:57:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 d14-20020adff2ce000000b003176053506fsm9488186wrp.99.2023.07.31.06.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:57:06 -0700 (PDT)
Message-ID: <4253d752-6b33-965a-8534-5cedf5dc963c@linaro.org>
Date: Mon, 31 Jul 2023 15:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/ppc: Disable goto_tb with architectural singlestep
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 david@gibson.dropbear.id.au, clg@kaod.org
References: <20230728173520.486025-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230728173520.486025-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 28/7/23 19:35, Richard Henderson wrote:
> The change to use translator_use_goto_tb went too far, as the
> CF_SINGLE_STEP flag managed by the translator only handles
> gdb single stepping and not the architectural single stepping
> modeled in DisasContext.singlestep_enabled.
> 
> Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


