Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27757734C5F
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB9Jf-0003nb-JN; Mon, 19 Jun 2023 03:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9JZ-0003nM-SU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:28:41 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB9JY-0001N9-92
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 03:28:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9b23dc270so4495115e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687159718; x=1689751718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5dLVwVWQjSaRfREMTW8eH6UWICDMVAw1COzJ2+GHOA=;
 b=JzZ0TLDubwlbELLOgMWdxJWfQSp8g3Cq5gRS8sz2XePn3KzGYCdT+O9TMU78txCn8C
 aPNJ24xe8vT8cs2camuq+4hSZ1435xqxAyRPyO+thkMaW7GnnuQQxawvZmmzcfrrHncC
 wwTKosaQQhD5pTBB1MbCUJWiJwPtw+WnrinR+PYAFY6F+pgO5qY+JNGxoAXFVxOa8q6O
 ehtxZzKNuxq6MLQwo/w6FvWtkWmrSLxQwPlCHi3wBaudug+w5D4aAtMa6nCOghOSUwaJ
 oWnHjGpWQDEX58RG5gd+yrJCWeadRBKlLq8AVAeGOXMT6x0CMvnkouyY/1/Yukq6SCDL
 lhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687159718; x=1689751718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5dLVwVWQjSaRfREMTW8eH6UWICDMVAw1COzJ2+GHOA=;
 b=A3nAleFVirCySuTYG9ape6llSP3rOWVzvJylesJYSb8aIgvXkJZhcxYynVT/Du4CwR
 jjuhiM66ckNOIrFITAx0lGYGMnMpjOwhqfnNwxhpCjoKnGwNxgHSDGpl4T9a8xGRS0t9
 8NEA58kppABwxVMovSRaWTlHyYdbgVSuTT60FV3CfZwvfD2pbRGKWEiMPUiogCyZHxGI
 ++eN5LxPMEUVdeQVT/hF3xLPeqQINWuTcT7lMOGYbtplIvqzoW6Vc/9q18G4lgSfifJm
 cTApzDVES8nCZfmUKTVrny++p8Kim0RNNPIR8GDXyv2sH/zAug0/WZxFWsgh+JnT9gT9
 9uLQ==
X-Gm-Message-State: AC+VfDzFz0VZzNUH9oV+RZ4ruo5O8ihYoY1Tvsoo0NXj5UxxpwkVlr3U
 EQKsy3Uiw4nb/B7DpuOY4nkkoQ==
X-Google-Smtp-Source: ACHHUZ4DUi55XQtJnpYMTd5uctZkfdKGxZxS4kcTo32A8HMLe4XVfmZAzkTLStwP/8OU0cicaBoTRw==
X-Received: by 2002:a05:600c:ce:b0:3f6:cdf7:a741 with SMTP id
 u14-20020a05600c00ce00b003f6cdf7a741mr7761193wmm.25.1687159718292; 
 Mon, 19 Jun 2023 00:28:38 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bcc13000000b003f8d0308616sm9864639wmh.32.2023.06.19.00.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 00:28:38 -0700 (PDT)
Message-ID: <11c5220a-82c1-b013-9278-a19b6835f1af@linaro.org>
Date: Mon, 19 Jun 2023 09:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] target/i386: TCG supports 32-bit SYSCALL
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230618215114.107337-1-pbonzini@redhat.com>
 <20230618215114.107337-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230618215114.107337-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

On 6/18/23 23:51, Paolo Bonzini wrote:
> TCG supports both 32-bit and 64-bit SYSCALL, so expose it
> with "-cpu max" even for 32-bit emulators.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

