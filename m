Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 410FE756B2E
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLSWH-0004jF-T8; Mon, 17 Jul 2023 14:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLSW7-0004iY-V5
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:00:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLSW5-00071J-Rg
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:00:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31454996e06so4616023f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689616810; x=1692208810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V6b4nhtt1b7g6uzX/2FBN/gSl3O2Ld6Rb6qMPhbuFAM=;
 b=cTBcX2vDCyhlO9syXtQMn01Xvkp95vO6SI5FpwRyN3yQleX6dStnxmrM6cB+r7m4v0
 kwLYqyorg5g6aycUZLQkT1dBoYV820igWN/Ap3BjK29hQrc7aP1BnqTC5QmJhT06Q3yA
 gBUKYQVumj10FyPMFsO5QD6k0Gug0tcq8uVcIEPORr3pNWE4n3sQ8u+ftxDaLWwI83VY
 oRJCIgKMlMqRJBrE1MA0XpG/A5RDF0N9Ktny4edZEy443CuhYMsQKa9iu3EhfEWfvLQ1
 F8LPHJkhHpBKHDN+z4bGgeMhppZyPsTUNDHOprDBqTbw4U1wHkR+inPDjnYn3feTozzH
 4hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689616810; x=1692208810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V6b4nhtt1b7g6uzX/2FBN/gSl3O2Ld6Rb6qMPhbuFAM=;
 b=Uc+InVpt98J4iNpX/c9LX+B26J9w2qpOxY6FpY23Z97fN3/BQz2+VEEZnhkaGJhlRn
 jdxuYMjgVeujJcr9dw6Dd6dJDjzNmLUHx/8GUWwGpj/ZwO+ds2NdtQcWhYMvLVxA/O5E
 FM79L8hWG1IStKEk9iC9t+fNL1lVH05OMYCm+pkAXsK/b4xNr7++FjZla+u+7cZjICuw
 fBingp2uKhwBs430DvuF7/Xj8L8q+uWui9a06Dxr79ZFUdhioBCT72hc+d4u79dCz1e6
 Dq6ozjb+hJnFXdyjbXNb8flK8Mg/v1fYF5p45D5EGRfFCbvU+etfgjufOfpnEVLQ4Gus
 M9hg==
X-Gm-Message-State: ABy/qLZvnYAQORp0TTlHl99TnHCOFZAquSTXKwy/yKbPJtAeT5LUf5M3
 OMRd06YZx7YkUJg0LXtUm1UBeFcCnqSy9nS0G0Q=
X-Google-Smtp-Source: APBJJlFws0/u1msICrC+nC5vRYG/BIIjyOMDA/vpB/DPxPNrnB4tnnzUGpn6u0P9F0n3DVQ6i7dByQ==
X-Received: by 2002:a5d:6603:0:b0:313:ee2e:dae1 with SMTP id
 n3-20020a5d6603000000b00313ee2edae1mr10346530wru.18.1689616810079; 
 Mon, 17 Jul 2023 11:00:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adff2c6000000b0030fd03e3d25sm80361wrp.75.2023.07.17.11.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 11:00:09 -0700 (PDT)
Message-ID: <4f64b8e7-3bde-1a4f-24cb-5bc20de93445@linaro.org>
Date: Mon, 17 Jul 2023 20:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <20230717162940.814078-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717162940.814078-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 18:29, Peter Maydell wrote:
> Coverity points out that in page_table_walk_refill() we can shift by
> a negative number, which is undefined behaviour (CID 1452918,
> 1452920, 1452922).  We already catch the negative directory_shift and
> leaf_shift as being a "bail out early" case, but not until we've
> already used them to calculated some offset values.
> 
> Move the calculation of the offset values to after we've done the
> "return early if directory_shift or leaf_shift are -1" check.
> 
> Since walk_directory() re-calculates these shift values, add an
> assert() to tell Coverity that the caller has already ensured they
> won't be negative.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


