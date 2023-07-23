Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CE275E2F4
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:03:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbVd-0003oL-O3; Sun, 23 Jul 2023 12:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbVb-0003na-A7
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:00:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbVZ-0002j6-QI
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:00:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so2832512f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690128032; x=1690732832;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LktNimRU9OwO6Zs5tm9aqCj3B/sEkQe0Lm4USeY7rUU=;
 b=lbALk+uWq9hjF6z62BCeAyIhshISXUkUAxvwFthM4CmjuLzrMhAeqdXPvSfPXEjqj8
 XdsMkb+z9KR5BVpnyv8vUykwoP4Jc1OEa4CD91u/HU+PpROb1DuzUA0gPtbds+U0cqru
 IosMzRQ4oV/GHiPpggBB5hXTVeVpdzgQF4pH/ZQc1N6n0p/vFAXlscgd1DInfniqsFTv
 PnDHbmHnaHyM+xrw08ZySQbpTlSAW/79vVgZLrhWD0PpJGZ4ecos8OudqttAYokRe5sw
 Zx2MCotsbJ94xsty0SCFJvgav3zdpGcY3OQ+EBkLOQozE5ZkRlvZa702xDfBFaLIjXSP
 fmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690128032; x=1690732832;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LktNimRU9OwO6Zs5tm9aqCj3B/sEkQe0Lm4USeY7rUU=;
 b=RNjpKo6orjWcuvtFOM8mFExIp3L0m2JZ8sLIbCbVAOblPvsD9RbztW2DWg5l6kuJTx
 617rT2BrsnrFcIPgKWSq46jd8sD7x7i6VB2wJmL0EM0WxKpzwuhvFtN29UPzKizq1n5b
 4H/7AKIVJSiQJ1HWlcZfnC/lZUonRVFesJSSFgroVQFS3b+U/c7mYmW0FJ/soDmOqszo
 n2nydeerHBYC9/7NWGgr3AfX7O8C4WV3AMzfIU1j7SGrnO6gVmlpC5scGYAbZOaRlY2N
 AUaanmw43/mCKTa1+qSkckO5KChtpLP87gaaVZtGUG99n3IFHJlvh+Df6/3jGQ2BCUjV
 jUIA==
X-Gm-Message-State: ABy/qLY8DoA92LFFNrRVSPMwOHBV2rSQLbPWXSKbDFhmOQnkwLJqgkKi
 RNE4dDMeuagJ4cbaSC6WTGc9NQ==
X-Google-Smtp-Source: APBJJlFr3Ksj2BzFu9OOzZF3vbg8VeAV6WE9Sm395uNSDS81gPb8YRJxOrPmVbjeNPluZRlQTnjHmw==
X-Received: by 2002:a5d:460a:0:b0:313:df09:acfb with SMTP id
 t10-20020a5d460a000000b00313df09acfbmr6364699wrq.11.1690128032441; 
 Sun, 23 Jul 2023 09:00:32 -0700 (PDT)
Received: from [172.20.2.224]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 o5-20020adfcf05000000b003172510d19dsm10094909wrj.73.2023.07.23.09.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:00:31 -0700 (PDT)
Message-ID: <58f041c7-8240-3fda-d099-a29cc3b20639@linaro.org>
Date: Sun, 23 Jul 2023 17:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/14] target/arm/ptw: Report stage 2 fault level for
 stage 2 faults on stage 1 ptw
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
> When we report faults due to stage 2 faults during a stage 1
> page table walk, the 'level' parameter should be the level
> of the walk in stage 2 that faulted, not the level of the
> walk in stage 1. Correct the reporting of these faults.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

