Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B47359F0
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:43:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBG6E-0000Xf-C6; Mon, 19 Jun 2023 10:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBG6C-0000X7-CT
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:43:20 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBG6A-0006pD-P6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:43:20 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so1602628f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687185797; x=1689777797;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NydlFdCa8bp/ItoaMG4FxtPj8oGkAMhF5pR9q6L2Qp0=;
 b=o2ygSXVJ+krLiXK+CoxqjI/J8aokDGx3yGyK5Mfoghqb1DqnWRUD4ZSbv17SmikjBk
 ORMf1MExz1TGwlfc+d3RgARDEGOrX21GZqdqDsutzPjbnXPTLTsl8vqxbyP5if374A9D
 NVRhxqLf+4jYNHtsDCwKQf0NfDyN+hp9fTZwbJ0o1H1XLK98U/IMtVpDmRgL9aOxR1Qo
 EACJI81r8xt9u7Kyz/nb8058wVrZzKo6iWw3pZUvLztgXuQ9KsDCin5t4K+UJHqESPYF
 +CJgVVJ82Ows0dDK/wIrd8gUAdaAeqKYeUY0NsFyBhwKUrE8e/aR417JdxWNYS4E5YEL
 +qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687185797; x=1689777797;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NydlFdCa8bp/ItoaMG4FxtPj8oGkAMhF5pR9q6L2Qp0=;
 b=i//cd+QokCmWbcDwqdaWgsC/KM8+dkeXFMT9anoT0Aqj3Mz8791cOeLZvpmv6F/K7B
 +XerAP/SkK9NDmEm8Kr9csvSioWUfmsXJtYreKC9L40sDq5Vsw3QAZJYOWaaSdPAmSLJ
 Z6YHd/FQ/nCVkH8pyXxG1ZUJFv9Ld6R6J1FUWeP7Us9yB2lOotKCG0RYK9+cwsGiIEXW
 lSOtg4JK1GOqYn5+9qiMT+kRwM05djkj3m7/f9vlzXKjyP5GMIPq3wDX/oSZb3/+IosR
 H2Lk7XlOAw5sHC8HHZMqCJFNWTidxQLqyfDMcYKYNqhNDdVhm6LuxpB/Kc/zPcs7Iv2Y
 p0SQ==
X-Gm-Message-State: AC+VfDwNH3uboavM1VzrvZbnHMS6AfaOLFSYJ+xSj84OlRnrNNIpNIvX
 asWiqj3I+x/CO2g403wbKvvpkJAqSyiHUDxrwpBpBeBJ
X-Google-Smtp-Source: ACHHUZ4n8dTUAlO6uXhHVAMpbIEss4CSYy3refu5UwGc5HyvuRAP9idQ9E6hE3GwVtj35SiFvyJyNg==
X-Received: by 2002:adf:e5c4:0:b0:30f:cb5e:6b1b with SMTP id
 a4-20020adfe5c4000000b0030fcb5e6b1bmr6583571wrn.11.1687185796844; 
 Mon, 19 Jun 2023 07:43:16 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 t12-20020adfe10c000000b00307acec258esm31740641wrz.3.2023.06.19.07.43.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 07:43:16 -0700 (PDT)
Message-ID: <00a4e1d0-9c8f-a8a6-fe04-1923fee82466@linaro.org>
Date: Mon, 19 Jun 2023 16:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/5] tcg: Issue memory barriers for guest memory model
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230619142333.429028-1-richard.henderson@linaro.org>
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 6/19/23 16:23, Richard Henderson wrote:
> v1: https://lore.kernel.org/qemu-devel/20210316220735.2048137-1-richard.henderson@linaro.org/
> v2: https://lore.kernel.org/qemu-devel/20230306015710.1868853-1-richard.henderson@linaro.org/
> 
> Changes for v3:
>    * Update for tcg-built-once.
>    * Require TCG_GUEST_DEFAULT_MO if TARGET_SUPPORTS_MTTCG.

I just noticed that patches 2,3,5 were reviewed (thanks phil)
and I failed to copy the r-b.  I have now done so.


r~

> Richard Henderson (5):
>    target/microblaze: Define TCG_GUEST_DEFAULT_MO
>    tcg: Do not elide memory barriers for !CF_PARALLEL in system mode
>    tcg: Elide memory barriers implied by the host memory model
>    tcg: Add host memory barriers to cpu_ldst.h interfaces
>    accel/tcg: Remove check_tcg_memory_orders_compatible
> 
>   accel/tcg/internal.h    | 34 ++++++++++++++++++++++++++++++++++
>   target/microblaze/cpu.h |  3 +++
>   accel/tcg/cputlb.c      | 10 ++++++++++
>   accel/tcg/tcg-all.c     | 39 ++++++++++-----------------------------
>   accel/tcg/user-exec.c   | 10 ++++++++++
>   tcg/tcg-op.c            | 20 ++++++++++++++++++--
>   6 files changed, 85 insertions(+), 31 deletions(-)




