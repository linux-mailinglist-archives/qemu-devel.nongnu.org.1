Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D7A718471
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:13:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ma9-0007vg-5C; Wed, 31 May 2023 10:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Ma7-0007sH-7q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:13:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Ma5-0000Ko-P1
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:13:43 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so43239465e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685542420; x=1688134420;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GFc07CBmY8wM0zBnA0LrLPixgK04Au1iZn+mWgzTJ0=;
 b=iT3vn8yOZq9PTJjEPWc0McIjeFpiaaMyZgpu4DJHt4qrZNacBfSMxKK2wp15MIkhN2
 SLHHXYPngsV1CHt6rD4xLUl6mdaB8rEIoPrTdY66q1UmM1VQdiSBArrhNl0woOVSTki4
 I5Loj+Mn5WxrJ46unO2J8vCDtHx+8p98h+rEl7L5MJVeC5cZZxbdHp/R0lsumnFh7K4h
 VPgU2gY7qWcF3zCNtKmC/zwAxpOojLGQBcn+l916TIYvdvcdXXCqT4FpZ6c5ULMnU73X
 lAQWnpVZVvDMZW5ShvN/cPq66rNLoDKVyekLQSKQAhsAvvv95+Oe5vEiWYmSXjU1ZDVQ
 Midg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685542420; x=1688134420;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GFc07CBmY8wM0zBnA0LrLPixgK04Au1iZn+mWgzTJ0=;
 b=QtpuD5B5BCpTXQc4Vcwb8yhBsoFy8DaFV73FylSI033BD1zCZnE5pZHGxJ2m9WI+5/
 Z8mxl+DzrctJ9SLXeSkfM2sr9kulG/T1Ai4mtvd/cwN+NifndwyOQ0valSmXSEihK8w6
 wR+4zW0xcOXHrxBmfJ7b6dAikW1I5mT6gq5fIYDXyXpKKqk4NmnD4o4w90hlhoJ725q4
 04YMgvIlhhroZXiZIWVqOe1ixe4YDqpMZo2hYz6vX57lL/cmQHDZEPc7Ok3hXlJCLwPY
 B42fzFkusdcEmx7/zbRyTAjd33eTladN4YFx58OhbHGEWc8y/DBKXyLxvXxAAEbLqv1g
 ikHg==
X-Gm-Message-State: AC+VfDznLHR4Dr2O11RLiP7kSs8lzXrfkYVqpGp1YYm4/inf1ZCo/0/7
 qlGWkrfTcuttqmGrzZuePNA9NFbwQYGNUPFjf4A=
X-Google-Smtp-Source: ACHHUZ6qcH9aWxux0RGY62kJXNU5gr7VulnORS5JI3PwS980BuMgMiAX0s9hrATQhB34HsuAy++uHg==
X-Received: by 2002:adf:e4cf:0:b0:30a:b4e1:a89c with SMTP id
 v15-20020adfe4cf000000b0030ab4e1a89cmr3950832wrm.66.1685542420260; 
 Wed, 31 May 2023 07:13:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 s5-20020adff805000000b00307d58b3da9sm7056795wrp.25.2023.05.31.07.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:13:39 -0700 (PDT)
Message-ID: <14049f9c-7e37-7ba9-85ff-94a9306337a5@linaro.org>
Date: Wed, 31 May 2023 16:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/48] target/hexagon: Include helper-gen.h where needed
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 06:02, Richard Henderson wrote:
> This had been included via tcg-op-common.h via tcg-op.h,
> but that is going away.  In idef-parser.y, shuffle some
> tcg related includes into a more logical order.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/genptr.c                  | 1 +
>   target/hexagon/translate.c               | 1 +
>   target/hexagon/idef-parser/idef-parser.y | 3 ++-
>   3 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


