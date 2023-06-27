Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FB73F873
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4kR-0002jQ-5R; Tue, 27 Jun 2023 05:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4kL-0002T2-PR
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:28 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4kK-0003FK-4b
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:12:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51da8340ab4so1220272a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687857142; x=1690449142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MF4MoK2PxS40GZNw8tamBvxQu6wW5ln9Cl2soqGg/j8=;
 b=nt7yKL4ObbOHrfpYHX22Rf/eWO/aCCVGCfuFDbtJgEJ+Lh19+IE+mm/OSEsofZrGcd
 OQsqeAbKgnu0ruUU7ssr8xgnKOAxhe2DrwfDVCNfhD7I5kF8ygLhdxQJE2FWwmvcdpl8
 nkhXw5hKt0aoVSTVmWMA+x82ZwMS316UlKiRvHlRz1vUY4/DLhmLiw7/zfdCAlPWzGRZ
 gqd3hx4YnLE3hexPoFTcHnQI6HVocS3QWR84rLhFtbzsXqBj6M7EkTtLqIai+AZsOHpL
 aRqNmFPJeXkF7GIY6gxAQ+Jri0Qy03OfoMEH6PZIgXpELBqg30wyHVNOlCYjNsaexkvj
 ZZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857142; x=1690449142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MF4MoK2PxS40GZNw8tamBvxQu6wW5ln9Cl2soqGg/j8=;
 b=jTKrDfuo8or7o5LGZGKlX61wmJWtfHlkJKpQNgUfF2dKdrUdO843FUqTScnmivGvw/
 KUSU65gy7xLDgtZUHOBXvqOGoPobWDELnuxr8OH0zjIthypz8Fju+FKCeeqlcrSPVQWE
 5Yw/1mdzFkyfhgZLVM6ItTT7/t35sMJFoy9sKH5cxv5/tov/6RHqYV/QmY5Ir4Wkz9LJ
 s72wJAvWmpF8TAl8iFuNa4t85VHsBQsZbBW0WTyPFGuswk+al3Q4LQGM9rDqbKaEzMXq
 zvadWa7tUmsKyfOHAkfqsMTBmbqdgqoHVvQMktoDVsxEoCncZMRDpTFr5soCmT3tmB+3
 Y+/A==
X-Gm-Message-State: AC+VfDxCG78R2Sjy9Ejnhl57Z9/nlGnUa4OESRv8NPvMt4Cwhim8NeXm
 Bo4YwmBU+aB/5NnXA1dLMZQfZQ==
X-Google-Smtp-Source: ACHHUZ55r/G7zfB14hyrJ8yQbkkKRSBHe47uN80OKd+OAsioJOE1plrEeOkpYBkkUUoHk9tYuCGGbg==
X-Received: by 2002:a17:907:971d:b0:991:db79:5666 with SMTP id
 jg29-20020a170907971d00b00991db795666mr4676501ejc.4.1687857142465; 
 Tue, 27 Jun 2023 02:12:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 bv12-20020a170906b1cc00b00988a0765e29sm4301831ejb.104.2023.06.27.02.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:12:22 -0700 (PDT)
Message-ID: <f0dad42f-a02e-4462-c4a8-8e17d45ac26b@linaro.org>
Date: Tue, 27 Jun 2023 11:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 6/8] target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 21/6/23 20:06, Richard Henderson wrote:
> This is for a plain indirect branch with no other side effects.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



