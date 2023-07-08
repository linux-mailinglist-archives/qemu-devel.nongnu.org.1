Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2F74BEA2
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBxF-0001sd-Vx; Sat, 08 Jul 2023 13:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBxC-0001sE-Vq
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:42:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBxB-0003We-Fs
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:42:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso31087675e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688838160; x=1691430160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OPtrq0jPXBDy6FtVCJh7wb7/dODQ0wpRpOqAtInz3v8=;
 b=Sj4VmYbcM+q1J9dRW210CY7reCoYqRUoY7uYic01YnNZKlVHr1gUkCzqWdPjCjC7Sq
 fNfioCaK6W2scLfu03M/Sig/m4tvsu5TCd8DTE0GYKN29LbBamykTXWNo83RXQ+1yd5M
 GH0nP43cBvuOtrCPo30WIVJOMysBW+jFxaxg5AUNxemjDo+mBDU/s1Rv/GpEIsnbH3Jh
 ZXZ9e3oa7+GNk+W4mE8ScAlAe/QvRuYhgZX0dmWK4htmp3TXe5WtRbCUgit/FXC0Qn+p
 uG0vqPaHUXSlwVroa4oFwaYu3CgUyUEC6UTYB+2+KZetEEowY+rE59iXQRlI3W+Sj5+/
 ErDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688838160; x=1691430160;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPtrq0jPXBDy6FtVCJh7wb7/dODQ0wpRpOqAtInz3v8=;
 b=IcPZ4RnQiUghEZTmskM25ZOiG3C9EkANLazDp9G05vGWXvsSDjXgxMJhKzMZRBWvmX
 hbpUEHIEasCB82QHNaZDkvsVboywPxzXbisWiIR7KKrlhT2YN5zuhdgay1ANsmgLIh7C
 tuwzFWgEJ86ru1Qdj7P/tFQUNc08oYNdQIGKsqrJtYlaoAZN20LKdM6OW7Vzei13bbqT
 FTA9vTSaY9IO8xwhI88+zL8vA/5gVC751rrUvSR/FKbTw9H+TKZvdIxoVQMLHRSLHFBP
 WFAkXrRcGF1warAqNMwmHbkpNjBFFu13S06IcCLRLdU67Lnswwe/Y9DssfariYj5c+so
 Aj6w==
X-Gm-Message-State: ABy/qLbfWEw0VATPkY/+mFt577/nzHIL8/0ZX2rjklqpK26EDpvcOa9Z
 v2sgeyyKxG73mx4Gam60y4z/9w==
X-Google-Smtp-Source: APBJJlEB0MlO7sfh8nzjG8aF9Ef4oS9Je3XnEREZbo/CPK6py+rBsCE09wK4ZxWW3l8HqxFKc7PLCw==
X-Received: by 2002:a7b:cb97:0:b0:3fa:93b0:a69c with SMTP id
 m23-20020a7bcb97000000b003fa93b0a69cmr5924656wmi.24.1688838159962; 
 Sat, 08 Jul 2023 10:42:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c231300b003fc0505be19sm2563913wmo.37.2023.07.08.10.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:42:39 -0700 (PDT)
Message-ID: <2167a8df-44ab-2039-4567-3057bd2da0a6@linaro.org>
Date: Sat, 8 Jul 2023 19:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 17/24] linux-user: Use 'last' instead of 'end' in
 target_mmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru
References: <20230707204054.8792-1-richard.henderson@linaro.org>
 <20230707204054.8792-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230707204054.8792-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/7/23 22:40, Richard Henderson wrote:
> Complete the transition within the mmap functions to a formulation
> that does not overflow at the end of the address space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 45 +++++++++++++++++++++++----------------------
>   1 file changed, 23 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


