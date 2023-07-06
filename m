Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9A74997D
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 12:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMDB-0003D9-LF; Thu, 06 Jul 2023 06:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHMD9-0003Cb-MW
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:27:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHMD7-0003xy-3k
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 06:27:43 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51d7e8dd118so817240a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688639257; x=1691231257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TjI5VncEJUo131PC1BdfMM1kZk+v4da39H8MLcFrQag=;
 b=QOpc0g+iGdf+RTxPB4yMSBchXmqviaoFQrimRwvWWCJ9bdsOL4ntqKaJtll1tyqoa+
 QiLFcMm2ZgEOejCw/sVbK4/YVurHCJ03PaApn1hp73inF4nkF9sf8441IDAuKb/82diO
 PhS7+ApY3hzTc/WEn4iqdxBQ2TWpRTnMB2VFCPSok7hgXyM2F9cYWvDCH7MyvTZHnOd8
 wGSmvJCUWCYcjnGlwUYdMYxlgm/4IPZhQYuKH+ZQ3tS4kqtMa0ePVHpVdqNmSxmMlbw0
 NIPSLFkJ3iOy+Y1u3biRqIyVVZp2sFLsixSN+yNkYGR7Q4JL7gF9NrIuhUz4eST7n48I
 yXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688639257; x=1691231257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjI5VncEJUo131PC1BdfMM1kZk+v4da39H8MLcFrQag=;
 b=BXT/8TupKkZG2J5Tz0LFJkN/puQkw3M+GZv3pSxQ3B6Qp3O8oy0HQJCNHye7E3vfZn
 1gZUZiLRk4fPB7w1NmIL07aDKS2Jc4YB1KTFTEMVzdSZo2iiz5vigQrpC8dozr1e/TgH
 NAdnKNdE7huAz1+58fNsx3huUHbpka1toQL2FORbx7a1fCupEAe1lWN9CZ+8fm9uaSYm
 QT4W50uIzJmUI/3XLTF8ahKDv+puXnbkx74hejzY/DRIMLSbI2izDGWPxAjjITPKrYBQ
 lZ9AgLGR/IDiIET47npOswL+zLp5bRkGIPySBZ8R6boM6yesil27r9P1hKJbWOU/sxfn
 jAZg==
X-Gm-Message-State: ABy/qLaLutBD4RHDEi41Hki0+bd2AxpVHQIbsZQavH2aS2wyRtj4XMDX
 wTq3dQCuUJ4haY2z2vr3NIKAOQ==
X-Google-Smtp-Source: APBJJlGPjYL0hxBofJhy+PuqZnONHGPqgm66Q/cu1PD5WUCJ3P5SRdkVG3deMQ2luqgjzUKTfdDrtA==
X-Received: by 2002:a05:6402:184e:b0:514:9929:1b01 with SMTP id
 v14-20020a056402184e00b0051499291b01mr1154620edy.8.1688639256875; 
 Thu, 06 Jul 2023 03:27:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa7d146000000b0051df54c6a27sm604480edo.56.2023.07.06.03.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 03:27:36 -0700 (PDT)
Message-ID: <d26ae819-2152-ad85-efd6-425f0f9987af@linaro.org>
Date: Thu, 6 Jul 2023 12:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
 <87jzvffywd.fsf@linaro.org> <c90fd4c8-59a4-e4b9-544b-8eb6cd03b4d3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c90fd4c8-59a4-e4b9-544b-8eb6cd03b4d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/7/23 16:45, Richard Henderson wrote:
> On 7/4/23 18:00, Alex Bennée wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> If you build QEMU with the clang sanitizer enabled, you can see it
>>> fire when running the arm-cpu-features test:
>>>
>>> $ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 
>>> ./build/arm-clang/tests/qtest/arm-cpu-features
>>> [...]
>>> ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is 
>>> too large for 64-bit type 'unsigned long long'
>>> [...]
>>>
>>> This happens because the user can specify some incorrect SVE
>>> properties that result in our calculating a max_vq of 0.  We catch
>>> this and error out, but before we do that we calculate
>>>
>>>   vq_mask = MAKE_64BIT_MASK(0, max_vq);$
>>>
>>> and the MAKE_64BIT_MASK() call is only valid for lengths that are
>>> greater than zero, so we hit the undefined behaviour.
>>
>> Hmm that does make me worry we could have more land mines waiting to be
>> found. Would converting MAKE_64BIT_MASK into an inline function and
>> asserting be a better solution?
> 
> I'd be tempted to keep a macro, and use __builtin_constant_p to make 
> sure this expands to a constant if possible.  Ideally constants would be 
> diagnosed at compile-time and runtime values get runtime asserts.

Indeed inlined function doesn't work because MAKE_64BIT_MASK() is
used in static const value definitions:

include/hw/cxl/cxl_component.h:52:1: error: expression is not an integer 
constant expression
CXLx_CAPABILITY_HEADER(LINK, 0x8)
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/hw/cxl/cxl_component.h:50:9: note: expanded from macro 
'CXLx_CAPABILITY_HEADER'
         FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/hw/registerfields.h:46:41: note: expanded from macro 'FIELD'
                                         MAKE_64BIT_MASK(shift, length)};
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This builds however:

-- >8 --
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -28,3 +28,5 @@
  #define MAKE_64BIT_MASK(shift, length) \
-    (((~0ULL) >> (64 - (length))) << (shift))
+    ((__builtin_constant_p(length) && !(length)) \
+     ? 0 \
+     : (((~0ULL) >> (64 - (length))) << (shift)))

---

But then UB is still present at runtime.

