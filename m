Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF75075E2EE
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbMG-0001FG-N8; Sun, 23 Jul 2023 11:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbME-0001E2-53
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:50:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbMC-000814-MM
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:50:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3172144c084so3104313f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690127451; x=1690732251;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k252XPH4PZA8/tNLIs5R1Pmualb7PIAO7yTHlkQMoS8=;
 b=C9llMhHI1f/Ag4mVnZt0uoYyc7yP58+rt5AZY1ulATaULIfM1v//kZ6ue9//cV3udw
 xxZYARpVYXzTJD/YKJBdNW1bDGLm3uwzrrLRqH9kah7eY95pWBqiT11l57/1D11BKTxs
 RofGsDM0yuU58LFLiwqdWa8FF51wqzMkCvaF5MSoS3aEnd8tkEUD+ZVyP/lKFgGtaDma
 dbVO6dyJoLIG9XpiOu2idkujIN0febhF9TbEIf92o/T3XHGNRJePERUrxFeQBP3w9ZQz
 U4g03nc1OHKvSArFAZT0kPjGbSkNApqNv9YNqTo05BU+lNozwvv1gOb70s6DgKCKnSgh
 cMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690127451; x=1690732251;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k252XPH4PZA8/tNLIs5R1Pmualb7PIAO7yTHlkQMoS8=;
 b=d2GS2ibzjjgYXR5okN9PlOXcn4Uc99u1ReyMeEKd2n8Kq300BTsNQE7Ka388i2quF3
 XW+Y9Eq8Rbh3aV9cGHo9bbT+gtWs4GiXJg5hJmnXIWhXjJZUSNEYya9JMK2uMVqQlsuo
 HbcAZZPJOhIkqlpqHXu1ostPnH51cpmXuaYJJp9QDos1IyA1e60qIMTIFtW3lU1Nd5vU
 IcwXhWWlN7SxSiE9vkybQyhQz0DdIubei2pAqD4Kgp3K2vCFpzpeos9LQWAuJc9gaTGj
 G9DlJRpjFURCmW8rpcH4t2yrCA3NOVwc/L1qo3g+yFGTjDEATWBhxwR7RGvTAHy3RWFe
 MuCg==
X-Gm-Message-State: ABy/qLbKE89CK3ahJQZFjMVLFruAsOfziGUIzhitBbtDjpWBBH5iQVc5
 KAZZfxChN+aT23eLIXWLW9+atg==
X-Google-Smtp-Source: APBJJlEHYmHEMSCLyN3v5jWx2YngAfnDwJzEsR8dOza8l/pe9zogJ66FutfSNuWkN63WyrdCk7wDDg==
X-Received: by 2002:a5d:5112:0:b0:313:e8bf:a6f with SMTP id
 s18-20020a5d5112000000b00313e8bf0a6fmr6016725wrt.23.1690127451261; 
 Sun, 23 Jul 2023 08:50:51 -0700 (PDT)
Received: from [172.20.15.116]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a5d5712000000b0030c4d8930b1sm9957280wrv.91.2023.07.23.08.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:50:51 -0700 (PDT)
Message-ID: <9e869fd2-94c6-54f4-f4b7-2bc700a49daf@linaro.org>
Date: Sun, 23 Jul 2023 16:50:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/14] target/arm/ptw: Set attributes correctly for MMU
 disabled data accesses
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 7/14/23 16:46, Peter Maydell wrote:
> When the MMU is disabled, data accesses should be Device nGnRnE,
> Outer Shareable, Untagged.  We handle the other cases from
> AArch64.S1DisabledOutput() correctly but missed this one.
> Device nGnRnE is memattr == 0, so the only part we were missing
> was that shareability should be set to 2 for both insn fetches
> and data accesses.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

