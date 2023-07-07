Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9774B778
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 21:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrRX-0000DD-J8; Fri, 07 Jul 2023 15:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHrRV-0000CR-FO
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:48:37 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHrRT-0005GT-M3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:48:37 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-992b2249d82so286588766b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688759313; x=1691351313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JjarKcvNq6+XRYOE3rQGMFJp4Yz9FBXqTtaJLLCcfmI=;
 b=iS1xE30RYZrePxrSzYot25+WXX9WgODqsO6p5a1m8VuTGyq9QIpOZW2aP1Pankskw9
 Zm+4dubtKCcbvq9iM1v5gtFEgd9uz6xcY7/2pZ1rKEiNwTTx+DHlFies8ZpJJ0m4P+N+
 fteAyajhgcNq6RRdNIBeIjBQXaV4JCc8L4eAQemunwBSpH0NCKVg7dqXltnSw45jBQIo
 as2gFfnel+HL2K+aNSHCqzIKsGW6ef+fUC5JaU5/S/4RrcNN/aP0gEIaA2WZfTCTvgtA
 A7Op5QRUX7IoMi0+bT0/UCWLbk5NSI3t3XNTZRvCy3Rt74IRo/uRSG0mE1hLarcQWRfM
 fQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688759313; x=1691351313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjarKcvNq6+XRYOE3rQGMFJp4Yz9FBXqTtaJLLCcfmI=;
 b=iH+XYY3/57bSyJAKtd+N4Eo0jj+dOicC3iWqsz9q4g0X4m5cB0+skUSE2zn2lgOB9g
 0JyKmTSL5BMfW4KXHKezpf8rhjwN+/7Jr3sdvr2ZgJMK3dWh87EaRovzLrHpYglQSz/E
 N5z3hvNXUDsx34M9Zce0rW1nP8KQYdq/PW7OhjZ3Ch9nmkx1v3prj3GzKM9qFMDG7uvY
 k+Qn38/zzRM3wQGc4orvelstKmFIQwUYedAK9gACFEWgdpb/TI4qWNrOiB4yUmIKzKmd
 BjTFy3orC65YTLAsbC8M8/vT5DshDbLOYlLCBNeve5R7ACBLXWHFE5Hn33mMmcK3PeFx
 zRng==
X-Gm-Message-State: ABy/qLYO/76pW4eb3/VFbl2PTP6vbRfxTURkLLJHCi5b3yQl29naGyld
 v9TIyfs89/Ocb7nUr9pEPvdf4woDD6up78R7iDE=
X-Google-Smtp-Source: APBJJlGr3g3UoDIssiUwld1Xud+qEAS32rTWFyPdpXXLXpWxLfu8+KvHkb2UFU32NrQhJYhmhMm7TQ==
X-Received: by 2002:a17:906:535b:b0:993:da87:1c7f with SMTP id
 j27-20020a170906535b00b00993da871c7fmr1072173ejo.7.1688759312956; 
 Fri, 07 Jul 2023 12:48:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709063c4c00b00982a92a849asm2546017ejg.91.2023.07.07.12.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 12:48:32 -0700 (PDT)
Message-ID: <942e89c1-2636-d65c-733a-35040cd07f1e@linaro.org>
Date: Fri, 7 Jul 2023 21:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 21/37] target/i386: Use aesdec_IMC
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AESIMC instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/ops_sse.h | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


