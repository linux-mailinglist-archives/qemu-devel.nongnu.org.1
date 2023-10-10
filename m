Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C07BFAD9
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:10:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBYs-0001nM-7b; Tue, 10 Oct 2023 08:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBYn-0001mW-Kt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:10:01 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBYk-0003Sh-C5
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:10:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-533df112914so9284996a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696939796; x=1697544596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHblB7HWyNycraTayX5orK5U6tVzYvGMv1Gm5hHvZIg=;
 b=cDGvY/k7Ke3xiAxkllBCdrmQiz53nB+hqUm6OH3M34kvqNPOSoHzfphcz3pGqUWiw/
 Hp98eMxwYJTeQGnSVLw8JVC/W0OfdwoegxZE7nTPlDvNV9AdVvaBwXW4ky/vL/xCuJki
 vLyUtm2ihs4R0ABJcjOC5i6kPk+/q6nZ/OZkt/GQHUkOcUUvf79jOAOUtLe17iBmoSH3
 SnL1YKZ8HJRUADMVWWfSzRGibC9Ewnnkb0b1SPvrerI7E1aodtNU+E1d4ut3zmwSfSVt
 lj3r3WeldC8H/Hu/Msj9NAEVjSfWYQ9lpo+rhgwKygeNCMR5tOZf8+0mLlhJtLeqr8GM
 2twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939796; x=1697544596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHblB7HWyNycraTayX5orK5U6tVzYvGMv1Gm5hHvZIg=;
 b=PlNq4wGUnLPJRN/53FvINxd+BFlLTlhw/Dq1jKdolhqs+aH5t2LmzTHTZLuqRrcxrU
 hFvH/WQ01yofNPBSckjjPnsYW1JgGdI0imUC0iFJnzdsh09TO0deCXootwUpWvJ2xr9c
 vXz4Bc2R+iwASBI54+G+0IMOHaOEEoW6RLjztG7Z5aDJ0iwnYl9+0l+60Q2TFQByQNV9
 YKMU0gBHFd0MVr6idJ6uR+02FmMjU2l/gaFOHy7zWwdNo3m+7xacdbgl2gBTx9Qn8Qt2
 NW+qwFOJsO807gfMHc0P2cy9RCaH1AXtVHisVC07ZBpTpqLpR14upxNarP6QL79yIbP1
 dQdQ==
X-Gm-Message-State: AOJu0YwSw/WS+62vjkgijibeL4uZdB1g+eawiTMsQBFQrDeEJH4PMOrr
 fDt2qg4+0yzFRGFY+XY+dAWojGmnykIiwgyb2+58Ng==
X-Google-Smtp-Source: AGHT+IF1LbRhpGx23WS62g7XyNAbTM/OEHxf3472r3rZNUQUtXnZYSf2sGnkXXbpJvR+gPzeNIE6JA==
X-Received: by 2002:a17:906:32d5:b0:9ae:6388:e09b with SMTP id
 k21-20020a17090632d500b009ae6388e09bmr16877851ejk.40.1696939796685; 
 Tue, 10 Oct 2023 05:09:56 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170906230c00b009920e9a3a73sm8362775eja.115.2023.10.10.05.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:09:56 -0700 (PDT)
Message-ID: <908b9f26-fce5-b57a-650c-a179e4263993@linaro.org>
Date: Tue, 10 Oct 2023 14:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 01/16] accel/tcg: Move HMP info jit and info opcount
 code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 20:30, Richard Henderson wrote:
> Move all of it into accel/tcg/monitor.c.  This puts everything
> about tcg that is only used by the monitor in the same place.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-common.h |   2 -
>   include/exec/cputlb.h       |   1 -
>   include/tcg/tcg.h           |   3 -
>   accel/tcg/cputlb.c          |  15 ----
>   accel/tcg/monitor.c         | 154 ++++++++++++++++++++++++++++++++++++
>   accel/tcg/translate-all.c   | 127 -----------------------------
>   tcg/tcg.c                   |  10 ---
>   7 files changed, 154 insertions(+), 158 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


