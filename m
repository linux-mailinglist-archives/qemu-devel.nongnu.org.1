Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE272F343
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HYZ-0004S9-27; Tue, 13 Jun 2023 23:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9HYW-0004Rf-F7
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 23:52:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9HYR-0000Uk-Lz
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 23:52:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30fceb009faso948926f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686714738; x=1689306738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OmB4W9JJz53mn0XNUghXdrPyaTmb7jMrj/7tAfmr/Ko=;
 b=Axe7ggPzBZZ2lfsWFh3/ZrlGZm57NmET+0FrsSWpe3Ftd/hNX/YuKqe829i2wz9NrV
 079bjZ1GlICDE1DQu3S9QVaQXy5YJ75w+f2ryIS/AJGAi4lhRxJe6qGEC1d37eyJqo8F
 riGMaNdIwr9g93ZkQPtrdpXDmtl1+fWukW+lLIdVzuJOJrsMFX1wJP/Hzd8JdcxjRwZ9
 DUE4KkbAWjyMFl1GPuTvtGToRa3LofQLUORl91+dqLAxABQ6sfKo1C1f+yjgCLUQnGKk
 WA2tZElLzjVDe4LQrdrmh7kwe1+i1qlRIDEMEseyHnHqQfEr5/VOcVlPDN8UB6IyjxGg
 IVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686714738; x=1689306738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmB4W9JJz53mn0XNUghXdrPyaTmb7jMrj/7tAfmr/Ko=;
 b=Fe3K+h7DM2+tRPf32BTx8/y6bWuven//ZQqTZBbpVAYqrhrvQVwJ2qEqt4v+EAvcT5
 iYMhkeUbkgTB2tReB6xrwxnZoFG2XqqmqLPYs1RoHOHe3jb6POXVBwF1ExAqpvdcop9q
 7Z5dT8ntGD+l9JwM6h3cV9EdDmgL8c/R+bPaTv53WwJ9T4qjcFs09+FlYzybmo6FILRh
 IMbhRb+cIDqSGiSHVxYlrtl9vwy6sEL39XphbUNorUhZIOho0Jre+xxXvrQNjcVWonuM
 /3uc0Bt0W0AceX7nYrJVGKR43+tVRplkPkcckBWp0FQ5w7lFF19DILWeE7Dme6gIFmdv
 apQQ==
X-Gm-Message-State: AC+VfDxLTpy9i9jXmnnejHhefoR1WE7E3uuCyT8jdXpXWeA0TUvx4liP
 TzhGY9YwB0r0WNF1CKjKspicKA==
X-Google-Smtp-Source: ACHHUZ7aXNpD9N2jgc7GF5zFjVbd5nHwBZ0UkvNgSnWunTG0OWvp5ndvyKqmhbRJoOr2bampWTHC7Q==
X-Received: by 2002:adf:ffc8:0:b0:30c:84d3:f5a with SMTP id
 x8-20020adfffc8000000b0030c84d30f5amr318801wrs.4.1686714737983; 
 Tue, 13 Jun 2023 20:52:17 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 d6-20020adffd86000000b0030ae87bd3e3sm16847086wrr.18.2023.06.13.20.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:52:17 -0700 (PDT)
Message-ID: <3f4e8ef6-1ee3-4cca-c34d-fb5cf4ff9b2a@linaro.org>
Date: Wed, 14 Jun 2023 05:52:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH qemu v2 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
Content-Language: en-US
To: ~jhogberg <john.hogberg@ericsson.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <168656283612.26761.9869630057811681568-1@git.sr.ht>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <168656283612.26761.9869630057811681568-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/8/23 19:49, ~jhogberg wrote:
> From: John Högberg<john.hogberg@ericsson.com>
> 
> Unlike architectures with precise self-modifying code semantics
> (e.g. x86) ARM processors do not maintain coherency for instruction
> execution and memory, and require the explicit use of cache
> management instructions as well as an instruction barrier to make
> code updates visible (the latter on every core that is going to
> execute said code).
> 
> While this is required to make JITs work on actual hardware, QEMU
> has gotten away with not handling this since it does not emulate
> caches, and unconditionally invalidates code whenever the softmmu
> or the user-mode page protection logic detects that code has been
> modified.
> 
> Unfortunately the latter does not work in the face of dual-mapped
> code (a common W^X workaround), where one page is executable and
> the other is writable: user-mode has no way to connect one with the
> other as that is only known to the kernel and the emulated
> application.
> 
> This commit works around the issue by invalidating code in
> IC IVAU instructions.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1034
> 
> Co-authored-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: John Högberg<john.hogberg@ericsson.com>
> ---
>   target/arm/helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 44 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

