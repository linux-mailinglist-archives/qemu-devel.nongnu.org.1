Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB562744C5E
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 07:55:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFq3L-0004AJ-29; Sun, 02 Jul 2023 01:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq3I-0004A9-JH
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:55:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFq3G-0001Fk-Sy
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 01:55:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-992b66e5affso369633566b.3
 for <qemu-devel@nongnu.org>; Sat, 01 Jul 2023 22:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688277313; x=1690869313;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9WpXY09Hmdc4eunlMga6QI4YuTFwrjcvDWFhBxVbHkM=;
 b=nnS2MWW++gKNJgNHeS4UJr4XcbiH9lhlNe8QJyI5WvmknI7F7vRTTaaiJaeU7uV5kH
 ggk+CkpKCCq/nqnMgr3H2MW4H37tiejZD3t4dreKM/TCTurvbjy3aL0OkJCkTVK6okN+
 XZjnaKxKPBTF4Wp5rvR0ddikCYpz3UFsSMY6TiaIJIdSuCrW3wDHZIjQUePmeh8/xHst
 PPxGs39+/GYJ4TY9OZ2VUy/VBSyllO93We0tSj3h8i/IV983316BDanmxVPrgx+F16kQ
 lIpz7Z4YeJGh1vcojZQgq88/nAt9H4Xgyi9e9T50wJ4AK1dNniEZI1yUC7OUgPCLns6Y
 YlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688277313; x=1690869313;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WpXY09Hmdc4eunlMga6QI4YuTFwrjcvDWFhBxVbHkM=;
 b=GK4vnMA94u/ecJbKUpmUv8aksa+pKMUr3EJ5Uw75UX83ivJSgmWX1rpPhEwvKb6EtA
 VZS+R6pC5Tj1m3rw3wrFrW7oyZmrOcTOc14XWpfaRuFO6ZPbvKB0gWpVQ/UPyzlny3YY
 QyA9T3PKUNiGsM/OahMCq/hecvwC8aMLH2eFlJLPhnD5wsvvqgJJTrWrLQdFDS8GAJKO
 uek8e/mJr3/jYvbVOM2MX097clHXH9pxCL5cQtdy7NS19i3kTsIqzkLbw3erPi2W61Ye
 I9Ss8+Izq77d4dlPFfOlJuxYrPg3HSRqfELONo3owTAb/dyqfVgM7xuT/9c4vJNKSPno
 n5Tg==
X-Gm-Message-State: ABy/qLavZZZaJwuyZl0+4Y/F1iYhn/ZzRT+dQs8aijc8CKh0esh54CZ0
 T79VjFeH1LoIpvyUl7h1GX4e0R8TuMLavGKxVuqPlg==
X-Google-Smtp-Source: ACHHUZ45yyjqNCxc6vk791sdegYxk3BiPdG+VndUprJwNDp7WpIBleZdCCphc4z2rh8KkieI+eREpQ==
X-Received: by 2002:a17:906:3446:b0:97e:aace:b6bc with SMTP id
 d6-20020a170906344600b0097eaaceb6bcmr4554251ejb.53.1688277312845; 
 Sat, 01 Jul 2023 22:55:12 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b0031433760a92sm743335wrq.115.2023.07.01.22.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 22:55:12 -0700 (PDT)
Message-ID: <8db01f6d-bde7-2bee-eef2-a9d8e6865915@linaro.org>
Date: Sun, 2 Jul 2023 07:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/46] target/loongarch: Implement xvadd/xvsub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-5-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-5-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

On 6/30/23 09:58, Song Gao wrote:
> This patch includes:
> - XVADD.{B/H/W/D/Q};
> - XVSUB.{B/H/W/D/Q}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/disas.c                     |  23 +
>   target/loongarch/insn_trans/trans_lasx.c.inc |  52 +-
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 511 +++++++++----------
>   target/loongarch/insns.decode                |  14 +
>   target/loongarch/translate.c                 |   5 +
>   target/loongarch/vec.h                       |  17 +
>   6 files changed, 351 insertions(+), 271 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

