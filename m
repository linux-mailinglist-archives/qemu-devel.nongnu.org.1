Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C978449D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSbp-0005d0-Fa; Tue, 22 Aug 2023 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYSbo-0005cn-5A
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:43:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYSbl-0003i5-Py
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:43:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e587eso43663255e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692715428; x=1693320228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/l938DaXbktOoEt4jC//vs18S3bKe/dZIQYvuYgHKyE=;
 b=H3HAoKcBPyiqi0kLYNdNoXzXod215oyqNcsb80oiGEKk3IheoMEDDFAbtZyUegpLAr
 PQqnxGRShzgg9+2tPieUi8KpgzKgD1wJ/CupLg0B8wHV+/vKyFjjsxI/jqBgrKk/BOOQ
 lHQx1/EM6EGhHOllq1JmxedYFKf6pw8Z9iO4lLwf9paWfJQmKYVhG48NL7nB69g0wf+A
 gIAVIJbAt6yXcORn4O2WHq6N8FurvTIP811yt4AsxWqy2Jt+uPZ6TfWRwPaB0bMSAAzd
 I8JyVTK5PXwoMIeQyNBnxq8y66lzYkJ82mAKznqLWiUPCyjChULeM0ksPKjuJSYEwlQX
 9pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692715428; x=1693320228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/l938DaXbktOoEt4jC//vs18S3bKe/dZIQYvuYgHKyE=;
 b=OpguESoXHZXhpfuFhtEAHLCm/ereDzv1y1jcvjeJyHIuISlxN4osLPMZOzz1JSs4Vc
 tYVQTz06AMxZuZ8v6zmXkne4JGHoTRo1W2UDiRHXsnhVNL62uj7141ESsO6sDB1hLt8O
 Bnp7sVNcCddeJGBEtup++wfYjUYCRaf1PLz3jnQ6hJuM3qqeYcsc4juaXcxYOUeZfyVo
 vU3MTfJ/j49J06MuFFZbzkuIZ3KWENP0Tupx09n58nfENxfsBNnRLXt6lc1k0KqEn9q4
 NfbmvdiAs9V7ACEgwZ2vZEgBnB9zznyvR1BNdYD/p21PnZ71Uepm0TEzxAy3Z1NnqB0p
 a5oA==
X-Gm-Message-State: AOJu0YxqpM4Pci9UtSWUUauPKAGoeXS8p5WbIijRa79TVkyvO6Kawtkv
 ksH/us4XRbnMCb9N1pLgXUwqWQ==
X-Google-Smtp-Source: AGHT+IEEpOQc3LBMNmXZ6KqlI03RyjdKYKE4Q1zlL0+8kXSTh6sWdEjPhzJohQBUCwpth4yH7IR4rg==
X-Received: by 2002:a7b:c459:0:b0:3fe:16d3:7d60 with SMTP id
 l25-20020a7bc459000000b003fe16d37d60mr7681194wmi.9.1692715428040; 
 Tue, 22 Aug 2023 07:43:48 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c15-20020a7bc84f000000b003feeb082a9fsm9434336wml.3.2023.08.22.07.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:43:47 -0700 (PDT)
Message-ID: <8bfc85a7-4557-e635-3ef8-7d77a794f282@linaro.org>
Date: Tue, 22 Aug 2023 16:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 0/7] tcg: Document *swap/deposit helpers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230822093712.38922-1-philmd@linaro.org>
 <87zg2jgphi.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87zg2jgphi.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/8/23 15:42, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> While reviewing a recent patch from Richard optimizing
>> deposit() [*] I ended looking at the *swap friends, taking
>> some notes, which then evolved to proper documentation.
>>
>> [*]
>> https://lore.kernel.org/qemu-devel/20230816145547.477974-3-richard.henderson@linaro.org/
> 
> We already have some documentation in tcg.rst:
> 
>     * - bswap16_i32/i64 *t0*, *t1*, *flags*
> 
>       - | 16 bit byte swap on the low bits of a 32/64 bit input.
>         |
>         | If *flags* & ``TCG_BSWAP_IZ``, then *t1* is known to be zero-extended from bit 15.
>         | If *flags* & ``TCG_BSWAP_OZ``, then *t0* will be zero-extended from bit 15.
>         | If *flags* & ``TCG_BSWAP_OS``, then *t0* will be sign-extended from bit 15.
>         |
>         | If neither ``TCG_BSWAP_OZ`` nor ``TCG_BSWAP_OS`` are set, then the bits of *t0* above bit 15 may contain any value.
> 
>     * - bswap32_i64 *t0*, *t1*, *flags*
> 
>       - | 32 bit byte swap on a 64-bit value.  The flags are the same as for bswap16,
>           except they apply from bit 31 instead of bit 15.
> 
>     * - bswap32_i32 *t0*, *t1*, *flags*
> 
>         bswap64_i64 *t0*, *t1*, *flags*
> 
>       - | 32/64 bit byte swap. The flags are ignored, but still present
>           for consistency with the other bswap opcodes.

I guess I wasn't clear enough: I mostly documented the implementation,
not the API.

That said, maybe the bytes movement pattern belong to the API doc
(at least I find it very useful to find which TCG opcode implement
the frontend code, when the TCG opcode name isn't trivial, although
documented).

