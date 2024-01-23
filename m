Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDB68393F7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:59:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJA8-0006ik-W6; Tue, 23 Jan 2024 10:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJA5-0006hu-1e
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:58:05 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSJA3-0003NT-8T
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:58:04 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2907748497dso2093945a91.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706025481; x=1706630281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tcTpvbjJwfPsYzw2YmoZSPVZf9rAhM7xR0nmwArUt1U=;
 b=bVUhBLaRo8GaJEnVSlmQEJ5rEoMbVvOkE0H4kt/voCKfLGwYqaFcYXa6uynqr3H5kv
 YNM3pT6uM96qrVqu3xef/5TLJrwOlKqvs9FglN1izrq+xhUdz6A+rtUZ9veSw6PhF4Kt
 m+k9Ept9dJWmM1GxSURheKe1VwF1dzQqDppXaRPu85U59Xq9Gl1lWB2D8JJdWW2t5mxn
 QXJNTvQlx+BvPdhsfvVndzsy+9B5B0BwyEXYyyf6O0PaHqaP59pcQwErSfVb/zGDuCNx
 UD9hoxiyjqdYAQyHF35NrSMBkIpU1JaRtc+Zo7CrzBQAXtMsb3XrC/qFFJz4cwQwhOt9
 +AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706025481; x=1706630281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tcTpvbjJwfPsYzw2YmoZSPVZf9rAhM7xR0nmwArUt1U=;
 b=mETflDinTvSOb3ZalH4QkANO55YX3babiL716l3yhj6HRioBMvC+cxO6cGQ2YuSgfk
 FehJ/+7Sf8SSyKU83wqdGC9UbJoeb4phII2sgPPTbb5yAddQjVso12rjJGZRt86JhLMf
 UF892jB3/FL9wH+AlColTJ5k1MJ/LBJiBe5rLfWGyfyfeYFJOZttYufXu1KOZ3B73p9l
 Rw9CUOi4ca01sCnTzuenv3CRjUaIs4nyrwwrB8wgwrWjd14XBTPQTKEFJrfKEogtO8a6
 g1Tz45RadbE6IIICE97hnBRk5Zx1jGmM2q/dj00QwQ2GeckQF9Ejmmea1zyYA6EqeTdz
 4CXA==
X-Gm-Message-State: AOJu0YyD9BiW4vV5pTOQ6UzX13iA0pKLCJ/gnKFxYEBDwpLshxo9F3cF
 dwiKs0ceh+2AX4pfztJ1Y9SLRhRhns9ltHmJfS9O3XYwR6VEw/ds1ryPu2t0SV4=
X-Google-Smtp-Source: AGHT+IFJOjnmntIpsh840mI6lOjiGab1GOhcWVamGH10FxymzY/Rf5gHceC9LLFCwEc639MomEj9Zw==
X-Received: by 2002:a17:90a:488a:b0:28e:8458:2889 with SMTP id
 b10-20020a17090a488a00b0028e84582889mr2902350pjh.30.1706025481525; 
 Tue, 23 Jan 2024 07:58:01 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:94f0:22fe:dda1:1842?
 (2001-44b8-2176-c800-94f0-22fe-dda1-1842.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:94f0:22fe:dda1:1842])
 by smtp.gmail.com with ESMTPSA id
 su7-20020a17090b534700b0028d29d837c7sm11767601pjb.36.2024.01.23.07.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 07:58:01 -0800 (PST)
Message-ID: <506043f7-e245-437c-a4cc-e6bc0f71d086@linaro.org>
Date: Wed, 24 Jan 2024 01:57:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/vl.c: Fix handling of '-serial none -serial
 something'
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240122163607.459769-1-peter.maydell@linaro.org>
 <20240122163607.459769-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240122163607.459769-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 1/23/24 02:36, Peter Maydell wrote:
> Currently if the user passes multiple -serial options on the command
> line, we mostly treat those as applying to the different serial
> devices in order, so that for example
>   -serial stdio -serialfile:filename
> will connect the first serial port to stdio and the second to the
> named file.
> 
> The exception to this is the '-serial none' serial device type.  This
> means "don't allocate this serial device", but a bug means that
> following -serial options are not correctly handled, so that
>   -serial none -serial stdio
> has the unexpected effect that stdio is connected to the first serial
> port, not the second.
> 
> This is a very long-standing bug that dates back at least as far as
> commit 998bbd74b9d81 from 2009.
> 
> Make the 'none' serial type move forward in the indexing of serial
> devices like all the other serial types, so that any subsequent
> -serial options are correctly handled.
> 
> Note that if your commandline mistakenly had a '-serial none' that
> was being overridden by a following '-serial something' option, you
> should delete the unnecessary '-serial none'.  This will give you the
> same behaviour as before, on QEMU versions both with and without this
> bug fix.
> 
> Cc:qemu-stable@nongnu.org
> Reported-by: Bohdan Kostiv<bohdan.kostiv@tii.ae>
> Fixes: 998bbd74b9d81 ("default devices: core code & serial lines")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> See the discussion of Bohdan's patch on the mailing list for
> further context:
> https://lore.kernel.org/qemu-devel/CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com/
> ---
>   system/vl.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

