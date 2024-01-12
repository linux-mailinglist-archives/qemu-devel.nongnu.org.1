Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EF82C700
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:09:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPi7-0005jZ-Ud; Fri, 12 Jan 2024 17:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi2-0005j3-Lk
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:04 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPi0-0001xt-JL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:09:02 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d5a7954b8bso6916745ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705097327; x=1705702127; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UxcsCjyhYdzzRTOUzAhNhHq2q6V+UDW5A7IQ3dqiCnM=;
 b=AmGg/Lkbg+zk2RjCjvwEKRfgzjp7clC5ZtbPsEEK4J5uFoueqmbx0kFazz6AnaFDKD
 re9koEBR2aRtGk2YN/sWvIL5Vdip31RWo8KJMEu7aS4DSg9y/YdatlQIsJRMmgIkvkLE
 0yNHA3nfg/Mja6zy2SVqT2ksQfjrRisKN4l9KfDLzCkK17B5dBzMsL11Z0VT6/ZnLo3Q
 6XiTaThVmQP6vEtaZfUYWcm+GfSFy5uR+euQ1z7g/i0mH7n6KORs/qipfS89sG+5papV
 1wX4UsICxR4rg1mBOCZfZiHV7qt1UkGc66yYqKPq4g/re+BBQKTfpM1y5nVCshkr0PRA
 2bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705097327; x=1705702127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UxcsCjyhYdzzRTOUzAhNhHq2q6V+UDW5A7IQ3dqiCnM=;
 b=RZUXN8W8UB+ySOhLzKRHRsnZqaWZlhAOlgkqpBHJEJtQ+Nfd6lJV/jW31JSu4poFi1
 F7zvKMOuw/UmCA/Ij+eAUxVpLcEIpXf80G7wLTmvVCC5R6u/hy/2fPbQBIs+Xw/tlqi4
 5Wql/wiEMqUHspgVmqykRJGlloK/DEOMGhD3keB1ZRL3+87ZoxB9CIqRCfdAUbp3t3SQ
 +GlV0t/EPXtxibCpA4h734Fb+geJSi2BFKtXb1dhP0mjiuQogr3SjPUhBXttn3xN9LUT
 z/NhjRmeR8AImOwMtsUW0u95rI65Th+RVljwocjPhdnuTQWsRA2Qu5OT9fnCQUz2ZUuC
 rKnQ==
X-Gm-Message-State: AOJu0Yz8KMFGcUbaOsfdyTzAQ4zheNwrJ+sSV0q+XcjutdtXoB79lrTh
 1n+j9Tpzv4hqmcq5ShF4bTNg/mkH5tC3nCUFZaQDJkaMzJvOfg==
X-Google-Smtp-Source: AGHT+IGO0c/QQwZNQk38IYgChi3A1qgyk3H6CFgjGtSGPEe4iFpTk3LZJ7UGf3yi89kP8lfU59HrBQ==
X-Received: by 2002:a17:902:ea10:b0:1d4:b37a:e0a8 with SMTP id
 s16-20020a170902ea1000b001d4b37ae0a8mr1428318plg.118.1705097327349; 
 Fri, 12 Jan 2024 14:08:47 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a170902a60d00b001d4b73f60e4sm3641032plq.149.2024.01.12.14.08.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:08:46 -0800 (PST)
Message-ID: <9f6e4384-2b9a-4afd-a094-30095151f72f@linaro.org>
Date: Sat, 13 Jan 2024 09:08:43 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] target/hppa: Fix IOR and ISR on unaligned access
 trap
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240112102927.35406-1-deller@kernel.org>
 <20240112102927.35406-9-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112102927.35406-9-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/12/24 21:29, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Put correct values (depending on CPU arch) into IOR and ISR on fault.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/cpu.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

