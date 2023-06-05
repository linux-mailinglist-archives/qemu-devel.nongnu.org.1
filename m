Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA97226AC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69nE-0001kp-AH; Mon, 05 Jun 2023 08:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69mb-0001PG-Ia
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:58:14 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69m5-0007KQ-UR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:57:37 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so3770553f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685969843; x=1688561843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xtdc0TwwtFyqAgqUIpDRj5EV1KGkkghRNsurMfwSd7o=;
 b=McwScFmFnkN8hhiNdbZoO1RmorttaEr9y9jwJ/HSqypv1wl7YtFfGORwSxmkRlb1ZA
 j6D3m1i3IdxAutdcwJiiQwO9fLJdHmYa8w9ROtIaOKqjGsOrBQ361UnmKUZ1aRFsaMFh
 DMYllr0M6c+kp6XYU0yKZKtB4H7ZCGuor9UQyg7JDyqXv6WFx8+T9DdmaP6qlqZT/DK7
 jjSTkCWhZaiCf5ykXYlfSPO8pJkUNyIkjDEn3sW5mqoA4KvERqZvEhLPr08hq0GdZg6H
 /3j+ZBjp4qLwfpIzmBfJTexr3I+9PTwK47zNBQLU53WBBAVhwTkg1/KIeh8cJNay7PrV
 qwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685969843; x=1688561843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xtdc0TwwtFyqAgqUIpDRj5EV1KGkkghRNsurMfwSd7o=;
 b=FjZXntd3/bGp8+wyZ9GHem5vR0HDc3gGG4n9yrM9ADHwrilrg11KpFs47IML7rUKOk
 dW6msNwnGS9g8551/2PcNGqAFPDLD+JZAT/0yWEYt0ySQzBs8y7nv2oypO3yIaHt3vXy
 GCUIA/y9HSJskWG8i4UkcARQAD8FjWEVLV8hNhSgGkzs8X/TjqkwIvbNeSONyXjmyPPj
 9IAScx9RR8YixLErTuy4GqaImrUphgSajjEj1rMJU1HRybsDT7On0b4mEbMgs7ojegIy
 Z/X0Um/31NufUh+50sg89B1n+/TPI3gchmy0VdGByJDuE0Xwe8j7uOKBmFOx4y+Pnvlo
 WQqQ==
X-Gm-Message-State: AC+VfDwbUBcchTMi2/AzmhV/aglbyXSZAF9dbKQUrxE9WZwb/gfvBxrs
 C47xlkN2Wx018XP3yqqx+5sgBG9kyyUCDQc6PWY=
X-Google-Smtp-Source: ACHHUZ5AmYgDdHBTuBZO8ITTD3n8a7ClmshUMS2GoNpoKH5RVMFTK5j5eluviAVsiDOeljeCx4fgfA==
X-Received: by 2002:a5d:590e:0:b0:30a:e45f:df64 with SMTP id
 v14-20020a5d590e000000b0030ae45fdf64mr5116657wrd.65.1685969843226; 
 Mon, 05 Jun 2023 05:57:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adff2c6000000b00307b5376b2csm9714413wrp.90.2023.06.05.05.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:57:22 -0700 (PDT)
Message-ID: <d4305b1b-0750-acec-b617-fb4531383013@linaro.org>
Date: Mon, 5 Jun 2023 14:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 12/15] linux-user: Use abi_short not short in
 syscall_defs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
 <20230603222355.1379711-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603222355.1379711-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 4/6/23 00:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall_defs.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


