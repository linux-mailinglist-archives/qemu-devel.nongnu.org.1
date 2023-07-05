Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A227486C2
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:46:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3l4-00054B-3h; Wed, 05 Jul 2023 10:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3l1-00053T-Dz
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:45:27 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3kz-0003Ol-M5
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:45:27 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so10681968e87.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688568324; x=1691160324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tl2AskdNCf03W6dDZ14SDintwMW6XEoJs3CByzgxNoA=;
 b=v4UVc4AQ/ovoSV9touIg4srcKrE/2pOcu1he4jvAKSbHz7j9BxWjXH1Vat2ZWsdkrx
 hyk8jusKVdvT57v2/Q+29HxFqJYRdM0obszObGjPL4YnhD4aGWO7r0wdKS2yABdn7Y68
 2jZyIgpcGypy23hGdEpERhHmmmSqWZb9aAH12tdXF8mNVqai2Xr8c9M3lfyxA3n+mZov
 Vsxwy3vSLGVlRqjuYwcx70Ue13lLppVbPk5dv/VFeBNEiAWdy+Di4n8sDfTge1FgeYyT
 cVQN7JpUb9NIFwOEK2NU7Wt2lEU/aRXhJVuSbACbdzocYL8sFbUTaQRtxRSNE0+p354Z
 kwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688568324; x=1691160324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tl2AskdNCf03W6dDZ14SDintwMW6XEoJs3CByzgxNoA=;
 b=FBsx/JVos+WTqL6uv7xpSfGPxu4oU7oX4WiFuOjis9dhq4c4Sx/kwBQUNSv0u97nMY
 nllVaF46kqgKFz+FgFF0ghupbWexSJJkWKuw3YrDGgkK+pJtwK4NPJgLHdJySIFCnuLC
 E4Xw/lbPfSNH0CZ3eWanJDYGt7A1RWA6KHAkiXERaVwPUSJPbwA9wzudA8ZcDOjW/RPL
 PnlWVrfR+m/Ej/H0RND1QNqGvl6pGtck7uNSAPPbwq2L2rQFRCcoQpDORB9PHyEpB8V5
 YMQfAMcjdRFWawqGAGTQxlGudmz0XNIGWbhEjl4hbXgskxlNNqDKcyLljrHH028r96mK
 DUKQ==
X-Gm-Message-State: ABy/qLaHkzxHuOkOshCwDprvPts1Plw0OXxnZ96MlBDwo/cGsh/zlRjI
 MBGbbX7qxLhUcPt4uYMEhKg1Zw==
X-Google-Smtp-Source: APBJJlGu/tGi8FN4Awg8+1+xOn2/b4sUy4lEpOir/9O5QHsU1SEJJr+9i1Xepexq7Cydo4bMc8oxRg==
X-Received: by 2002:a05:6512:2386:b0:4fb:8987:734e with SMTP id
 c6-20020a056512238600b004fb8987734emr13394389lfv.68.1688568323807; 
 Wed, 05 Jul 2023 07:45:23 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 o10-20020ac2494a000000b004fbac2646e3sm2473663lfi.195.2023.07.05.07.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:45:23 -0700 (PDT)
Message-ID: <c90fd4c8-59a4-e4b9-544b-8eb6cd03b4d3@linaro.org>
Date: Wed, 5 Jul 2023 16:45:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
 <87jzvffywd.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87jzvffywd.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 18:00, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> If you build QEMU with the clang sanitizer enabled, you can see it
>> fire when running the arm-cpu-features test:
>>
>> $ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 ./build/arm-clang/tests/qtest/arm-cpu-features
>> [...]
>> ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too large for 64-bit type 'unsigned long long'
>> [...]
>>
>> This happens because the user can specify some incorrect SVE
>> properties that result in our calculating a max_vq of 0.  We catch
>> this and error out, but before we do that we calculate
>>
>>   vq_mask = MAKE_64BIT_MASK(0, max_vq);$
>>
>> and the MAKE_64BIT_MASK() call is only valid for lengths that are
>> greater than zero, so we hit the undefined behaviour.
> 
> Hmm that does make me worry we could have more land mines waiting to be
> found. Would converting MAKE_64BIT_MASK into an inline function and
> asserting be a better solution?

I'd be tempted to keep a macro, and use __builtin_constant_p to make sure this expands to 
a constant if possible.  Ideally constants would be diagnosed at compile-time and runtime 
values get runtime asserts.


r~


