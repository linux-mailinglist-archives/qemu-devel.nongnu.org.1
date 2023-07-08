Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF874BC75
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 09:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1vz-0005kk-Ju; Sat, 08 Jul 2023 03:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1vx-0005kG-Hl
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:00:45 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qI1vw-0003co-0u
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 03:00:45 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b5c231c23aso42802241fa.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688799642; x=1691391642;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P0XKtM1fYym2+k/qntb4VmPM8TS5lSw9BxwfqToOUuQ=;
 b=iCLuA1XLlZ1aHd1fbki8DMlCY5THoidgfxlL/VlRXZMn9IRfW/Z0amAoJzycHeYf8K
 Nr2UPyke/Lcsa5SfTl8rhChR85bY26yQkyOsInSj8/Z6Q4b3OKajBJ0R9DLQlGSlYtf8
 Oi+54VZOGjIKrFu/xOWDKaJNiDfBX0ZTr7guMHhAsRayVYqDamu83GHbfL5+C2t+4grJ
 x0jC1mGr0HwzC7rZFz9A3G8rc9oHWwmepkgyQGH/4QhsPN+M+hbTendHe9xGSbWUZ/wb
 h3fgiSWj5NO5aZpMgveiIxVJP40kG9UjPXpfiI6V+SpF0L0gHSQ7nlw1+Qr2Pvz4olSX
 SNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688799642; x=1691391642;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P0XKtM1fYym2+k/qntb4VmPM8TS5lSw9BxwfqToOUuQ=;
 b=KQrkBS2JeYzBWnL/v+7O/AguyA5jOwlx60I+C+aZKRAZFkqmPc+RAu/VC5aWpxaUxx
 dRt57I8wliSVR9QRcgY22hJvgqaNHcHw7vNOXqygfCqeCv5ceuuUp9D0cx+DLO7rutoa
 Woq6FnQ5UYBG38sY9r6zGW3jB1h/Qicny5c8e+81b6q8NkZfiKdCMarSYKTFhutqZDnV
 UyNHML4wwMmBDQ/r1NbQGoRGaLf24Fz3quMLJqlTE1t7NS+2O32mOEV4jLEeed3PZufk
 5c/KVYHl/6YCo091mWB/SNXUzFLh0bj4N1oE552AtKIagKKqBlq3Z3utE4yNZio4L2mO
 U+OQ==
X-Gm-Message-State: ABy/qLYqDrSm4JFdciEgpmdKMECUF1D1CkaR3NI65XxbMMMNA6V4rPL8
 itZ0xQ9Df88E8B5kZBnZrfBMhLmoXj/EI2RDHX0Xkg==
X-Google-Smtp-Source: APBJJlE3Kjh0rhCYSlwdOhE2CG8ltCl0VwM52rXmJ0LXg8FWpx2k+aLQSount5S9Rgq3OjYVG2sU+Q==
X-Received: by 2002:a2e:7801:0:b0:2b6:fa71:5bae with SMTP id
 t1-20020a2e7801000000b002b6fa715baemr5396650ljc.12.1688799642203; 
 Sat, 08 Jul 2023 00:00:42 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003fbb1a9586esm4307831wmc.15.2023.07.08.00.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 00:00:41 -0700 (PDT)
Message-ID: <8fecddfc-12bf-0649-5439-e6c9152490ff@linaro.org>
Date: Sat, 8 Jul 2023 08:00:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 22/46] target/loongarch: Implement
 xvmskltz/xvmskgez/xvmsknz
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-23-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-23-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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
> -void HELPER(vmskltz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
> +void HELPER(vmskltz_b)(CPULoongArchState *env,
> +                       uint32_t oprsz, uint32_t vd, uint32_t vj)
>   {
> -    uint16_t temp = 0;
> +    int i, max;
> +    uint16_t temp;
>       VReg *Vd = &(env->fpr[vd].vreg);
>       VReg *Vj = &(env->fpr[vj].vreg);
>   
> -    temp = do_vmskltz_b(Vj->D(0));
> -    temp |= (do_vmskltz_b(Vj->D(1)) << 8);
> -    Vd->D(0) = temp;
> -    Vd->D(1) = 0;
> +    max = (oprsz == 16) ? 1 : 2;
> +
> +    for (i = 0; i < max; i++) {
> +        temp = 0;
> +        temp = do_vmskltz_b(Vj->D(2 * i));

void * and desc operands; loop over oprsz.


r~

