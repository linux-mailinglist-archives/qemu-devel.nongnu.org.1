Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD33721876
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 18:13:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5qL5-0004Ol-PX; Sun, 04 Jun 2023 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qL4-0004O0-1w
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:12:18 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5qL1-0003DQ-Hf
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 12:12:17 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2553663f71eso1553474a91.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685895134; x=1688487134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hroHzR7x1g6W9cjw4hhQK3FpNEcnbNs33lrQ6iRHrhY=;
 b=WEycpUiimGHD1zxnJAqF1IxxFt2v+neZKdsAf+6MkP8hFfsxWo453WR2PYMLZmnZJB
 9mxpVGnDVJuVHuBHVA5WG4wSBLpu8NwhR1xAt1lOeO+oqezzvn6EvBXrwqeXY4jyl1LT
 7vTS+BfyXK20Sho7bNZpdyMXVAvOxtS8N9B8SZ5BDPVy5fEq1Db969ZDPhNFM7dRWAo3
 i3sRmamYj+weoyCjmXwWjwlRUtqyt22FBb1z3LOnxqddMgH3svJZkQS0X38dtASx4P4m
 A0DTcjOaj5wvkCsDlrnEY+GnVBlwjXX8fGb0hJ4rvba9FUZncmKwb6OPKJXYWq/wSCeu
 eJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685895134; x=1688487134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hroHzR7x1g6W9cjw4hhQK3FpNEcnbNs33lrQ6iRHrhY=;
 b=gFPAH5BLYpverF9Fmor+kIS5/CfdPg3rAjfaRzBFAKLL8iq455nTBh0rNb1vmopxhc
 CFnMx0JCM1Qlgm72JTxUftfRuYd1xRJoUyVSE5p19JZwpC1uMD/S/YcsYP40MbGQKX3M
 eLZ2hGdmMiJ1bChPgJEOvBE4h9epVfpofWfJB52as+DLpVyd4uYvnJ+hoDaqA7NLUVId
 1HgL6Ihk28kQIR01o4jcRXnzBfxi+1lM6YrkZrG0DI0B8ilckeX4HlqBPOqFAOtAeB7A
 jWIYV63KWLkPg59H6q0zfaOYb6HHtjUYAtf7YSFngAU9v7JhpL+NBUQ77yhbSIVrKun+
 47yw==
X-Gm-Message-State: AC+VfDwUjzPuEHCW9/VMCMl/VIpvurpZp7ZPVk7/rGEi/RSNhWfmMvKI
 WIgmMNY9xyBOv420zmfb8gxhCg==
X-Google-Smtp-Source: ACHHUZ52krgEvHthTRP3I3HHE+pVWZVs1VJgWTWkNKggcyOlcfZ1Xe5xkC1Z64Wy/xhlmAKzLejmbQ==
X-Received: by 2002:a17:90b:3596:b0:253:2c7f:e9ad with SMTP id
 mm22-20020a17090b359600b002532c7fe9admr2183380pjb.27.1685895133873; 
 Sun, 04 Jun 2023 09:12:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7d0c:4d62:710d:ff28?
 ([2602:ae:1598:4c01:7d0c:4d62:710d:ff28])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a17090a688e00b0025930e46596sm1232113pjd.55.2023.06.04.09.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 09:12:13 -0700 (PDT)
Message-ID: <d39d024b-9db8-50e9-4a35-04eaef1cc704@linaro.org>
Date: Sun, 4 Jun 2023 09:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] target/ppc: Remove larx/stcx. memory barrier semantics
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-3-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230604102858.148584-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 6/4/23 03:28, Nicholas Piggin wrote:
> larx and stcx. are not defined to order any memory operations.
> Remove the barriers.
> 
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/translate.c | 11 -----------
>   1 file changed, 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

