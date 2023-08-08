Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 611FD774746
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 21:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTS8c-0004iT-HU; Tue, 08 Aug 2023 15:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTS8b-0004iA-Bc
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:13:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTS8Z-0000PG-UV
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 15:13:01 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so52825525ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 12:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691521978; x=1692126778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z16LocWIa7Ryq1/h8/zJxBHWgTwwFQklVrQbHK4wSCk=;
 b=f7XQqPl6SK+2eS/LepHtcZKKzeoz0tu1UclDVKapyGbdseBlh63eWtElKkUQWOZBf+
 0vMXQlXTK6vCXN/c2Unmb8Yqq8Fv7JWV0ZCzIlB7M6DBxOmHBuELX3ByGbJbhCAW78E1
 +5BDHEzpsPX2kI9Vj5n8Zwdwxaj5aysPtiSM71j5T3QMiKzCOak7RuW47td9lr5ZTkBj
 Xcyqdz2uYSp2a2tywfZAlvMnAIPBOhLDvrCV66Gy9H6fcZ2A0Q8zyJhMhKwTxlnHschK
 eYYx4DtPhoAb9Padl0UGIU/f0v60pLR3qLwDPH0002r5z5xpIYfN3Lp81a+UalK8mqkX
 bspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691521978; x=1692126778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z16LocWIa7Ryq1/h8/zJxBHWgTwwFQklVrQbHK4wSCk=;
 b=HjjNUFyLHwsTas/3raI/sY9xLxZ3b0lQycrzaPhLbIkq+O6C5DGt+mlvG+d7eJrfbd
 KMQf538w74TTbvy/ewpSBWjQRrw4zEwfxrZyb3qwSYnO/yulVxx27zhRCiJHgk8Yefmy
 EF4DUZEvvFowfQQUEIuesEAYOzpDuGA5EhQ/Q9GV/U5oP/UV2kOXHjh59vyBN0q8uSrv
 1dtCwC/yZoOEkvcDF+UBwX6qhnsYFyH3wDPhj0YDDnvMIdTujOCHkblRhtgHNLmPq5w+
 NADVF5w+GP4gTrJvbG2Gt1HthehwAx99m0o1crnFo00Tv1pguoZXHBkcDz81ikRPakw9
 /c9w==
X-Gm-Message-State: AOJu0YykXVZPiFW/fWeXIpDwgeXNqnfUrXYh4WnQNw+xMSXuUo1wTT2L
 nv4S4OzQyf6JL/wHIJJgKGLZWQ==
X-Google-Smtp-Source: AGHT+IEDzxJkBCsii4P05/7kixHuy8qo2svkSc1NsaNWfniHpNmlsedMx7GXGugmZOjXnK9jR9hUQA==
X-Received: by 2002:a17:902:8609:b0:1bb:a125:f828 with SMTP id
 f9-20020a170902860900b001bba125f828mr461340plo.68.1691521978569; 
 Tue, 08 Aug 2023 12:12:58 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001b801044466sm9375206plg.114.2023.08.08.12.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 12:12:58 -0700 (PDT)
Message-ID: <db9c1d60-937a-e17b-0449-b0e5be6d1152@linaro.org>
Date: Tue, 8 Aug 2023 12:12:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/11] target/loongarch: Sign extend results in VA32
 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-11-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-11-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 18:54, Jiajie Chen wrote:
> --- a/target/loongarch/translate.c
> +++ b/target/loongarch/translate.c
> @@ -218,6 +218,19 @@ static TCGv va32_address(DisasContext *ctx, TCGv addr)
>       return addr;
>   }
>   
> +static uint64_t sign_extend32(uint64_t data)
> +{
> +    return (data & 0x7FFFFFFF) - (data & 0x80000000);
> +}

While correct, this is just (int32_t)data.
You can fold that into the only user.

> +
> +static uint64_t va32_result(DisasContext *ctx, uint64_t addr)
> +{
> +    if (ctx->va32) {
> +        addr = sign_extend32(addr);
> +    }
> +    return addr;
> +}

I would call this make_address_pc to match make_address_{i,x}.


r~

