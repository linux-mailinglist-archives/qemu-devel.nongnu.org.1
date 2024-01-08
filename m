Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39685827B64
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:22:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMywO-0005wZ-W1; Mon, 08 Jan 2024 18:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMywM-0005wE-Kz
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:21:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMywK-0004fU-TK
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:21:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so29213185e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704756111; x=1705360911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=juckxiv6Ncx6AbT5zGsOzKgw5eeVZ3TTw0n9AAfkLW0=;
 b=iPocBL8jjUbfVFHIgzs2A/24AF5tlE8MOEfr92vDWDMbqoxMx/Sl6V5eBEa4ZJHuh8
 ezmverf6W8A73eS46DvyEp6T4NzdjvxcYZQo3GV8eS2sXs5jp6SnmBVuUL9DoDTNevkd
 JYbGiMVjhxkRqO1cRNFe+Ssi3dyBMb50LmgFqZPf/C79k2S9/sBh7UacAazWdonxg8pi
 QdcCzsRShX3+tvuqzwzacDPUhO3pYg4AC8qg2QG3rDucvYzASUyo7rKMnuQwn4TJQT7x
 DHjfcSpp2g9zGtkrfATzhtQK8u5V5iYlbr3uVh9HonRaGJADsPXz2YKdKQl5KW1W/VS4
 xMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704756111; x=1705360911;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=juckxiv6Ncx6AbT5zGsOzKgw5eeVZ3TTw0n9AAfkLW0=;
 b=gO7DBoF40Jz5r0rfb2kWoxJSlB63PdPQ1LniI4tNqqn4tNEdCZxd30r1XZRfSIsD33
 /o+MzcHt3kbzM+C+KmHA0nppOj7Ck+wcXKNt8XMHLZZi1cWa5q5DNFXtjB+bRsnGJX5X
 Hhlhc8uDvo2XFV1v2Rogd4Ir6/+tMtI5d6UTSHe2cjnqlTOmdSNisxBofO8CIAfYJe3K
 LYEOPVu4kebLPzjDF+WyxbOSbZ7+SlwKA2lnouRyzfKqMb03bUQ4kFfQ9VeBPiCEL7ie
 IzLuEVnlHQnYHI6ihu61mtaAzfWhL/tbX93TVJv6Us5bAscoUUbBzH1W2pWnGgaHBm9B
 MzEw==
X-Gm-Message-State: AOJu0YzdAEqJ7SPXxhr6KJC+JCU8SrE7rceetjUka3T4VvOuFE1xBRpn
 2dwoo5PgFyvJbM7YdjlE/ugocW08IOEMeQ==
X-Google-Smtp-Source: AGHT+IHEKxdzPqcpV/e6tsCtpqvhFwkNsETtFycpdPHqF8lNznm2tWDvCii9AxzLzfLa63LqLTV98Q==
X-Received: by 2002:a05:600c:444c:b0:40e:47d8:c425 with SMTP id
 v12-20020a05600c444c00b0040e47d8c425mr657978wmn.124.1704756111274; 
 Mon, 08 Jan 2024 15:21:51 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 j15-20020adfb30f000000b003375c8f796bsm840602wrd.0.2024.01.08.15.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 15:21:50 -0800 (PST)
Message-ID: <77aa582f-3c0c-47de-984b-69faabfaafdf@linaro.org>
Date: Tue, 9 Jan 2024 00:21:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] linux-user: Add code for PR_GET/SET_UNALIGN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20211220214135.189157-1-richard.henderson@linaro.org>
 <20211220214135.189157-4-richard.henderson@linaro.org>
 <bd92d4c4-8d12-4036-8d9d-385d67099e4e@linaro.org>
 <98572a44-c587-4591-b2e4-b07f6f28bde3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <98572a44-c587-4591-b2e4-b07f6f28bde3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/1/24 22:13, Richard Henderson wrote:
> On 1/9/24 04:15, Philippe Mathieu-Daudé wrote:
>>> +/*
>>> + * This can't go in hw/core/cpu.c because that file is compiled only
>>> + * once for both user-mode and system builds.
>>> + */
>>>   static Property cpu_common_props[] = {
>>> -#ifndef CONFIG_USER_ONLY
>>> +#ifdef CONFIG_USER_ONLY
>>>       /*
>>> -     * Create a memory property for softmmu CPU object,
>>> -     * so users can wire up its memory. (This can't go in hw/core/cpu.c
>>> -     * because that file is compiled only once for both user-mode
>>> -     * and system builds.) The default if no link is set up is to use
>>> +     * Create a property for the user-only object, so users can
>>> +     * adjust prctl(PR_SET_UNALIGN) from the command-line.
>>
>> How can I test this per-thread property?
> 
> -cpu foo,prctl-unalign-sigbus=true
> 
> 
>> Shouldn't this be an accel (TCG/user) property, for all threads?
> 
> There is always one cpu at user-only startup, and it is copied on clone.
> 
> Logically it would be a kernel property, since it's something the kernel 
> does, not the cpu.  But cpu vs accel makes no difference to me; it was 
> just easy here.

Can a process started with prctl(PR_SET_UNALIGN) unset it before
forking?

"kernel property" as "accel property" works for me.

> IIRC, this is simply a proxy for not really being able to inherit this 
> bit across fork+exec like you can with the real kernel.
> 
> 
> r~


