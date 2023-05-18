Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99952708500
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:34:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfct-0004VF-E9; Thu, 18 May 2023 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzfcl-0004Td-1N
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:33:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzfch-0004og-6N
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:33:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae3f6e5d70so21181495ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684423977; x=1687015977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sUqvOsotRAp6paS2nrc+c8ocZDsbAxZflRuZCWwIEik=;
 b=ImIxx+Hj5OMXNOS62AQehBiYqDe4M7fB0lNisUkgvAowE4qRrLK5JIzlPlYbkp6TFa
 lMPaGXRY76wVEhzTRGIVlzF3ffFXPx3wI2F9WpxDVhMNTmoSBwIctFaQ5F60XSt4RwdZ
 4YMTh1jg/Wph1C90drFWClB3PWw6MAeEFuXuQ2Sn1jjqFWRJoLWCG9kKz0kQCqyQ7jRo
 4z2A7Iu8UCa5ZmEU0L0/a9GyOFxxmgUDApZIGwBcdqVVoG8HvzJ1dTnf7Y+WvtU2dNIt
 g03vJkQCVn6E688YY2VgG+AGtkByFoEUTvIWdZzW9KLkQe39IyHcUvO0yLddCucTsEOZ
 r6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423977; x=1687015977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUqvOsotRAp6paS2nrc+c8ocZDsbAxZflRuZCWwIEik=;
 b=aigEGrkIfixzg5JJby1OgttuG4jtqu1bbakCrc9X8JiBCALjUlBcJEQD9j9ijXg+qE
 ZA0h+FPi54nRETivftTI8YgPnem4aeshrZkcGqplDSZKm1TLrq1uXqrJ5l6EwQNEU2dV
 QYNKISFHBjB5dnyRqgX8Uk0eFErdvIAYSDTiCzTE01vD5tNT6do4UJnBZEZeDbjUBlD4
 4vx05SK/cJuc/2hl3UxoH6T7oR9O/ugl3Cbw8LiB+B4pWNzAKUJOCSQg35jkwjEHTL9J
 +TkbvsmwysKEG17nX1g5XkzZm8oIR5zMj6bl/84qCSQi8Mht9LwWe+i6fBY2bsi9wRz2
 H3Ag==
X-Gm-Message-State: AC+VfDyvodegRcdMJu2g5dXIPaBVSH3VjTbvDawMCbdzS7y5bVYCHbbR
 3oYkx6g1C9BpE/Hwye4bTjsGRw==
X-Google-Smtp-Source: ACHHUZ6IOzSNvrpm5GfXWNYe7pExz+nPp1AgGiHpv6UuirxFimDvHHHJzQEWQgCwsyzmRks8jjPqfg==
X-Received: by 2002:a17:902:b18e:b0:1ac:aaf6:ee3a with SMTP id
 s14-20020a170902b18e00b001acaaf6ee3amr2513604plr.32.1684423977180; 
 Thu, 18 May 2023 08:32:57 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902bccc00b001ac7ab3e97csm1556784pls.260.2023.05.18.08.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 08:32:56 -0700 (PDT)
Message-ID: <2cecbd1b-12fe-dfa3-4ee2-68f90e0eb6bb@linaro.org>
Date: Thu, 18 May 2023 08:32:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] tests/tcg: add mechanism to handle plugin arguments
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230518152729.1247541-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518152729.1247541-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 08:27, Alex Bennée wrote:
> We recently missed a regression that should have been picked up by
> check-tcg. This was because the libmem plugin is effectively a NOP if
> the user doesn't specify the type to use.
> 
> Rather than changing the default behaviour add an additional expansion
> so we can take this into account in future.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Cc: Richard Henderson<richard.henderson@linaro.org>
> ---
>   tests/tcg/Makefile.target | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

