Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E8975279B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyTB-0001lO-64; Thu, 13 Jul 2023 11:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJyT9-0001kt-A4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:43:03 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJyT7-0006kF-IR
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:43:03 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-577412111f0so7960477b3.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 08:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689262980; x=1691854980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bMAjZTjQEslxKdTHIg/iKBDmUcSsVqay8zgynYgRTKM=;
 b=RcqQn0Es8sum+zfeASdAN335LLcB45MkIUna+jshdX656ET23oiox0cr73nDFBg5PX
 nVGcKzRuNeL29id2bIFh+ShtrY4tXxrZK+Kxa6HBpNmDov7BWozEj9WZMwWlgsBBwL+6
 k5VM+UJxoGZ80JL1DV5gkVrquXIgINrsmcORVrdygn1LTWYJaEZelphmLisu7yabdCpK
 Z4TwwFN8kM2qjFcBUjmEhvPPqMeCG3yWHEpGnhYnXAZU4GE4TwJo7r6gGkD0IdWwcy46
 pDvLY1BjdRc8bWI/+JS7dNv8J5J2LnxEfH0TFCGdIVK1ErPrbmUhaRTCixCxBXtSGmE8
 Cn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689262980; x=1691854980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bMAjZTjQEslxKdTHIg/iKBDmUcSsVqay8zgynYgRTKM=;
 b=B68mw+dUpt9ztLbddnIYYC75GXTFjAKaR4nSeSpwet3SdK6vntmMmW/fGPF+0Bhb0w
 Jue+2zARkIIa/9i/KIoTGT13Rjkgpwp8JqMSLyw50lZzgqHIHyXtvYX6iwrq9H3xgTHa
 udCiQJOA8Sd/2b7HjMZHcMHPFfCEqbJThqJOjMoY+3XlF/xkeWRUa5y3Y3ODTRGE2TGa
 +z6kK2z7HIGkAtI9UK63kd8c51LSeHHaeF/EBgSLCAKcwuoW7Rv/07T3gZgvxA+S1zQy
 rmFG99KPdYg1exwNVhRD+38qhg3RTl0GoG6XiwPqIQmtQUgqbULMgqpf6aKuemhjUT+Y
 2B/Q==
X-Gm-Message-State: ABy/qLZgR7I0dnjbV5qDomF9kIXoPSr2E2gf4nFJ6ihMR2ESGjikyqR3
 6erVyyerbbh1tsrVKIXT7aj++Q==
X-Google-Smtp-Source: APBJJlFr4cfVPkLZaB0uDY+OTRBwli2I99ztp2GSVUehdH8sdEOXgr43FvRtJBkn944VmXblEZaQ8Q==
X-Received: by 2002:a0d:eb0b:0:b0:561:206a:ee52 with SMTP id
 u11-20020a0deb0b000000b00561206aee52mr2068947ywe.24.1689262980191; 
 Thu, 13 Jul 2023 08:43:00 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.139.107])
 by smtp.gmail.com with ESMTPSA id
 f65-20020a0dc344000000b00565271801b6sm1818380ywd.59.2023.07.13.08.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 08:42:59 -0700 (PDT)
Message-ID: <0c7c6e95-e727-85c9-8fb5-928d9a420de8@linaro.org>
Date: Thu, 13 Jul 2023 16:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] util/interval-tree: Avoid race conditions without
 optimization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230707103036.5647-1-richard.henderson@linaro.org>
 <CAFEAcA9LF_7RKSut0=XrLOnWx9ag7b7R0vWongxBb1dUiHjM0g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9LF_7RKSut0=XrLOnWx9ag7b7R0vWongxBb1dUiHjM0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/13/23 12:32, Peter Maydell wrote:
> On Fri, 7 Jul 2023 at 11:30, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Read the left and right trees once, so that the gating
>> tests are meaningful.  This was only a problem at -O0,
>> where the compiler didn't CSE the two reads.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> If this data structure is intended to support operations
> being done on it while it's being mutated, shouldn't it
> be using the atomic accessors, though? That would make
> it clearer that you can't just undo the transformation
> made by this patch.

Yes, it probably should.  I use qatomic_set() where the kernel used WRITE_ONCE, but there 
was no markup for the read side.


r~


