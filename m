Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09073F51B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2sC-0004RE-BD; Tue, 27 Jun 2023 03:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE2s7-0004Qa-Hj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:12:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE2s5-00023L-IF
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:12:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f61890fbso1412021f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687849935; x=1690441935;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOWGsljA/o4hxQxRwIhTg/bhaTQenTn8tfUAv9gl+Nc=;
 b=hS49Yp8yJvUZ/mzSCtQC3IOIOJA6AjMsMzyjFO+K9ikykrncTusPvKencwYRwfpweu
 YMm0TcWm9GnrqwCep21/1IoKzr64tjFrPPg0ydAjFzA8Kk/V7BGFR5gDqic9oT94QRCg
 OH2a5Xf4zv/Oh3acP98lo7wbGpz0F8lpNXlBHxLyNUQZKLPHN/MlsKbjBXWLujUA9G1J
 N6NsuqZ673Z/2hNtZZOMndGyCgrRAkn0iPQdJUIj6ipvGqsWMurXRMUhAMFPqWjG4TGC
 74P6vwNU5gGK/PxDhhtI0WDEeMlLRu9VMXfXDRyCbrz25TfO1O46YMRFSyTrAtZqQWzG
 ro9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687849935; x=1690441935;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOWGsljA/o4hxQxRwIhTg/bhaTQenTn8tfUAv9gl+Nc=;
 b=JjZB5gkkzQ71Ow9j+M3D1KSrH/x4hrUNJiJt9ziaitO/ZpDqUC4Npj/jtVG43v3FG2
 waGTEgaq60XCe1JnpNczSWLWVMPLp4cryO8LTY21XO9OZtJxKA/Ck77PnYJdFMKDOJox
 jRJaIuZThV0zvrrVPXgiI6G4kyilF+pbDMWdQ+uA2r1FsEfQjXGfGGKxUcjhxrbvwKVI
 cduk2DeE7YvdxDIr2JD7bwe1ZW+BPNe4UVHWpCwwkoXBO3+B7xkWAscdC+jz4J+8FuB7
 Kz5T5qkfBvgTnLxsx/hMO/BBVnBo9FPObjmBAs8iPiqZe3FzyDSi4KfKk+XgxP4SWqT3
 883Q==
X-Gm-Message-State: AC+VfDzYjgBbaVIanwwwlCrkm+YWNiMl5KgfEOF3/0hj6NSkor0L2U3n
 bGyU3q58CIozQB1/n4WQ1ia+63FT8+V2ZFSv+Lx1AWRz
X-Google-Smtp-Source: ACHHUZ5sS1nxzF+BWYtYmmcPM8KxiFVnljmEOsRKSHNPLYV4YNM3VOQ++FsCfNVCa/JMz2aOiVve5w==
X-Received: by 2002:adf:e84b:0:b0:313:f497:d8b5 with SMTP id
 d11-20020adfe84b000000b00313f497d8b5mr3033094wrn.6.1687849935352; 
 Tue, 27 Jun 2023 00:12:15 -0700 (PDT)
Received: from [192.168.157.227] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6102000000b003127a21e986sm9332260wrt.104.2023.06.27.00.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 00:12:14 -0700 (PDT)
Message-ID: <766484bc-b3a6-3d20-49a9-ae8614ae8433@linaro.org>
Date: Tue, 27 Jun 2023 09:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] fpu: Add float64_to_int{32,64}_modulo
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu, alex.bennee@linaro.org
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <0f0aed5b-1db2-59e4-0523-14d957eac24a@linaro.org>
In-Reply-To: <0f0aed5b-1db2-59e4-0523-14d957eac24a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

On 6/21/23 11:12, Richard Henderson wrote:
> On 5/27/23 16:19, Richard Henderson wrote:
>> Extract some common code from Alpha and Arm, and which will
>> shortly also be required by the RISC-V Zfa extension.
>> Added a new test for Alpha; I already had a RISU test for Arm.
>>
>>
>> r~
>>
>>
>> Richard Henderson (4):
>>    fpu: Add float64_to_int{32,64}_modulo
>>    tests/tcg/alpha: Add test for cvttq
>>    target/alpha: Use float64_to_int64_modulo for CVTTQ
>>    target/arm: Use float64_to_int32_modulo for FJCVTZS
>>
>>   include/fpu/softfloat.h         |  3 ++
>>   fpu/softfloat.c                 | 31 ++++++++++++
>>   target/alpha/fpu_helper.c       | 85 +++++++--------------------------
>>   target/arm/vfp_helper.c         | 71 +++++----------------------
>>   tests/tcg/alpha/test-cvttq.c    | 78 ++++++++++++++++++++++++++++++
>>   fpu/softfloat-parts.c.inc       | 78 ++++++++++++++++++++++++++++++
>>   tests/tcg/alpha/Makefile.target |  2 +-
>>   7 files changed, 221 insertions(+), 127 deletions(-)
>>   create mode 100644 tests/tcg/alpha/test-cvttq.c
>>
> ping.

ping 2.

r~


