Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A7373F858
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4hp-0000b6-Up; Tue, 27 Jun 2023 05:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4hn-0000as-5C
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:09:47 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4hl-0002dA-6W
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:09:46 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9891c73e0fbso774027166b.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687856982; x=1690448982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2CIdvi14WX5bwXrvJscRtc+fanWSgDZomHgZ4i50ryk=;
 b=KVX9FOG/Tk+m4iqQ6itWxdKTAE2UlSBRXpdWPFGt5QfIZVju0GV2ex1WlveQrOdbsD
 klbfGZzzVElZPGCshpwdWgZYkLw7qd0oUWsy5OwqdFNtFhNpBDYgluyW3PkAKGAx7Alb
 vjv5XG38/kQT5ZZe9WRBG1X1U8Vjqs8P5PAmkb9prkdR7Gr/6+Ukmg4dZWdOvPgtkCtx
 xXWzUBXtq2aqLBMpIZa9H42ZqDhR9Ti6uJ8netG90RCUFXpC2XKfNx/Xc3jBElcQRNTv
 LK8djNA7hpFlIA/61o/cVGyJGIvIjSB+VY0elCx0LCVjkDQXZTRlS38D1zdNL4VrrnMv
 IAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856982; x=1690448982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2CIdvi14WX5bwXrvJscRtc+fanWSgDZomHgZ4i50ryk=;
 b=S7/KYrFuXRtI3FQiXooPyXGTP7lwB/ZIgYLqc5JK0TzjZbzj9LhTKtlxMFXoQzBejO
 D3ei/GxBsH0T2EUo3mxmNYmcAEHqwS8B8NB7Papks9VuwzNQLsfK27D4BcpWDSvBT7Qu
 ewu8k85xleI23f/UQ0jXqABPV17tlWmkA1o0dzFZZmuvmRCSsxN58JVLQSz2iiJmL63W
 UgdvxEHuX/IG6cxyEiKcnmJNnyPT9J/TfKvnant5Rb/02FIs/1iyBUDTOO5vYgg2lQE7
 yjiwgjSU7ZLfMLActo91RMQ0l3GB9oJWw8Sxn7zbKfv7qbTwLTqqt5ctXbpDwstYBo7R
 Ss9w==
X-Gm-Message-State: AC+VfDyHfbQttkBXK3jkSccdnZZS3Fn9NndleQYA08gSbmq2oQdLVIiZ
 Wm77YDz91R57iH1ElLS5Not6OQ==
X-Google-Smtp-Source: ACHHUZ4uuG2lCMmlFWhefi0pMC5XvIg/mQw6NJLnZB0n7wPHkCo8Vo6ZO8TAaI+JC0Nuc46kedb2fQ==
X-Received: by 2002:a17:907:d11:b0:96f:9cea:a34d with SMTP id
 gn17-20020a1709070d1100b0096f9ceaa34dmr36707420ejc.21.1687856982621; 
 Tue, 27 Jun 2023 02:09:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 kt19-20020a170906aad300b009894b476310sm4294080ejb.163.2023.06.27.02.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:09:42 -0700 (PDT)
Message-ID: <a8c45e74-2a0a-6fe6-6e8d-e2f1ced3ac52@linaro.org>
Date: Tue, 27 Jun 2023 11:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/8] target/sparc: Use DYNAMIC_PC_LOOKUP for
 conditional branches
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 21/6/23 20:06, Richard Henderson wrote:
> When resolving JUMP_PC, we know this is for a plain branch
> with no other side effects.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


