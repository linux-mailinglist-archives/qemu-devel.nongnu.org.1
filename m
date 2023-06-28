Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C2740987
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 08:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEOxn-0002Wj-Cl; Wed, 28 Jun 2023 02:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOxk-0002Vw-Vj
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:47:36 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEOxj-0001ej-C5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 02:47:36 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b69f958ef3so52333011fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 23:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687934853; x=1690526853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ouM7rkJZdjNte8pgXe3VfMluYdj+fNs00pJFJtmEWjM=;
 b=C2KXj5j1Bi3w//HX8cpem4MviMKruqkSlrfuBLMN65J15b50+ZaQdb8eHHXekUCOB6
 dBGRKK78FrEZ0yWPjcrzESMGr3zI+f1qtsAKQCU1p2+WSSHKMAacxQSsY0/nKdSMffk2
 rDZa+Fz3EN3yTPBsuGOvYfH6J8Uv2EP0Uy+r9n2RsG7bwZz8k64eNTm2XE1Tn8dZsl9I
 LDFGalcPguPYpJjKhWUrI7UBPAWYoHxi1692voD26LlgyK+0QPKItL4Q5tfPptHP9ols
 hEntciiEaS2ctmfZVWX6jI9w7XGhSSqIhE3dur8tA9ktp1IPC9UF68pV/VaC1MPMQX4I
 g37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687934853; x=1690526853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ouM7rkJZdjNte8pgXe3VfMluYdj+fNs00pJFJtmEWjM=;
 b=YkCAIMGwx/m9GCHWX9xRiig+IeFk0PorklX8qAepD9C8Kxoo64kJKYbf/5YWdJghAx
 q+FbblMdr1RG84P1unjjdf5hTAQphBLISjwAvfLDtRm/cedyN/2SXg2uUVnEOsrg659b
 xjgxJj1fqBW/u+1rcQbybgzmv8G8ucUi9P7zHE1rxhKpgQNzDCy3jWWhmIKsF1Psrb6w
 51cxQV8TilR1x1XJDAVTtXYDr4H8mELK+xRl50v3LQorLzSPpqNWDmCjkpIzOH9yuaT0
 RYUarhUZePyN1yDdJ76XFT6vuYhlVrTgxhVv1G+dPheRHJQks4FMEWBbSI5V2rVoMFxJ
 EUuw==
X-Gm-Message-State: AC+VfDy0CnOtyyUrABSXwi4sVs5HbY3GBxMYfYby19+xMfwqjEMbN2gi
 5MHDrKFo5iY24eKMP43x0euR0drleDL786rA3W8=
X-Google-Smtp-Source: ACHHUZ7hZBKSI2s37PRDmb3RwMFKooZnwWLS/vjqNTN79XW3s35ckN72hNZY5UikGoeuz48JHxN8bA==
X-Received: by 2002:a2e:2419:0:b0:2b6:bd77:563f with SMTP id
 k25-20020a2e2419000000b002b6bd77563fmr559899ljk.19.1687934853573; 
 Tue, 27 Jun 2023 23:47:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003fa968e9c27sm8105939wmo.9.2023.06.27.23.47.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 23:47:33 -0700 (PDT)
Message-ID: <68facc44-06c6-3b7c-2a17-0ff4bd5f0fc6@linaro.org>
Date: Wed, 28 Jun 2023 08:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user: Fix do_shmat type errors
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, laurent@vivier.eu
References: <20230626140250.69572-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230626140250.69572-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 26/6/23 16:02, Richard Henderson wrote:
> The guest address, raddr, should be unsigned, aka abi_ulong.
> The host addresses should be cast via *intptr_t not long.
> Drop the inline and fix two other whitespace issues.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


