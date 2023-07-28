Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4F8766EEE
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:58:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNY9-0003XG-0R; Fri, 28 Jul 2023 09:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNXn-0003W6-Mg
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:30:16 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNXl-0000t7-Ld
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:30:10 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso16696535ad.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690551007; x=1691155807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N841rxA1SSSsqFF0m8qLqQUKLyc+EcDuq9oc+nuymW8=;
 b=vpqJy0KFlDrNuSJWA4VK5ncdx4qCVijZBnDU9Ueh6XPzvfETAPiAEMnXNiim8l7xCR
 1s1KaXBcP8vTXL5liP/0GNCmzT5zsUFgBXfJTcIEZrDEgblPLkTzp+D7l6s2mOoWPNL9
 3v19mg9Alsy1HWx+iSH7jBZjGPF8p+SY+Zb79zMobIQfjUfWvaMfCWYx5cB5vCCuF2x6
 o+RaHUJfn+lwO993kxSDBYEgXdDhj6pAt25tf0KqiqxGv0DH5PGEtmD1/a18lkKL7a+F
 dZh9yKhLPuLtiEZbiSDi7LuA+CFbndB/hi9R9ZZ4oFOPSP8ZlVjrv7y0aPL4JHMe0kxZ
 mhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690551007; x=1691155807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N841rxA1SSSsqFF0m8qLqQUKLyc+EcDuq9oc+nuymW8=;
 b=Brx+fx1fYHHCbsEdjK65+y5x4wrL3k5Zgct49WaGTxbPP+dQaGkg+MUyURltW5rCsm
 JsPd76AcnEDSml0wBxS8mJvbUAVQYKYkRm77klM3rOU42gnjrbibLVReogcCr+kH5Ctf
 jDy8RMf7Fc52+KwTkewfunxXG0GnmySCOQLO3rsgQE8LDcl5NHAgxnuhVGFIpXN1nAbo
 mvTN0cN1I/tuKaLeF4IWCpLZfCjqFnGzL3VktfC+PhZAdmwNQ/N3ap5fKaaaZTXfSyEJ
 14cJjuk/2QcpfG/NOVhZik/saiZf3TAmLOwEgxQkNlb5JNzH5DGuNAtYXXpDmUHBlwx9
 hM4w==
X-Gm-Message-State: ABy/qLaJ4A6nBxbUiLXiaTXNhJVly7jzBRX3azLsqX7tm4cM71QWJtj3
 UVW+Dain8EorSbC1VcA3oPNw9Q==
X-Google-Smtp-Source: APBJJlG+xNeXkLGBukuPZB8Mg5VOLzYFIZ1nH1sNUMNi6jRKlSRZGUpvEIePbupMdwIEACWyZfhbhw==
X-Received: by 2002:a17:902:830b:b0:1bb:90d7:5e01 with SMTP id
 bd11-20020a170902830b00b001bb90d75e01mr1457291plb.63.1690551007036; 
 Fri, 28 Jul 2023 06:30:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170902f7c700b001b8c689060dsm3591528plw.28.2023.07.28.06.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 06:30:06 -0700 (PDT)
Message-ID: <d608c3b6-4e32-fe5e-44da-26df41c86a78@linaro.org>
Date: Fri, 28 Jul 2023 06:30:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230727162621.445400-1-richard.henderson@linaro.org>
 <CAFEAcA_oycCzi9ucp6njiZMs9puO_pshY0xDgT3ed6KQZP=bKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_oycCzi9ucp6njiZMs9puO_pshY0xDgT3ed6KQZP=bKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 06:17, Peter Maydell wrote:
> On Thu, 27 Jul 2023 at 17:33, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> STGP writes to tag memory, it does not check it.
>> This happened to work because we wrote tag memory first
>> so that the check always succeeded.
> 
> So this is code cleanup to be more sensible, rather
> than a guest visible bug ?

Yes.


r~


