Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488D75619D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMSZ-0006e3-EZ; Mon, 17 Jul 2023 07:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMSX-0006aC-Gp
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:32:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMSV-00071L-M6
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:32:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so39657435e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689593525; x=1692185525;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/LqSDv0S+su1NcrDcgNsjzHkEsF+lLVxZCvKSdCPM3Y=;
 b=u86yXtw5d/pX/6fOZAURK3p0gCL74butLjrJH0DJwVu+uW/hJPjDSXoK8XW8O3vagx
 NXq6ltqHgvxzZjwwoOt/odISmV/UcEkb6COGlLrBWrnn7Wcvl2HrzTXJpSP/19ptN/ot
 WEGGJ/6G06vJEwLocF29N/NrfVRVWj05QACZpmtRt+6Rk3STFPXwW2ThCbIgoWBlYNNA
 81b7bLoboYGtaW1iDBqoqKx1KcI8R+uxP02793C9xExJ3T3mNpOn42pXC/P/iFRmC1yD
 9WMppc/AMsOLxfRUS8Ci5pOqn0G3Pj7DICB6IDcZ73fdEoxzMzibKomzeUxs8zSSPomg
 Bhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689593525; x=1692185525;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/LqSDv0S+su1NcrDcgNsjzHkEsF+lLVxZCvKSdCPM3Y=;
 b=gxLFtDD5Qe90+7yMTpSCSjaEN0qa7IqJmWaGqhRLsTLBYTd4xNFBnXyeiQIHm08yHU
 GbaI1VcOlSzll+00LmT0lpl0ZLpgNIK4mS3GGYwihb4U+d8o2KAyVL9BwGq3lzq2QEY3
 HWSesFlo9Q2FjkIv5zbZXfzVu92kHikvwf7MPWokHg+gxGDffSJ3kkhB7mAqrNOHfwRc
 zZ8YRyoddlhLy39zGEb4RyaKuN7GRBroyl5QXJRaNPWlg2wR8W83/1EBvRb0jyqnUmOg
 aOMpV1w1wipse9BHr1MzViXgtVtEqS2vHj1+/kLFj6bZrinS+i+ofX2uBjjfB6cNnu8h
 sCaA==
X-Gm-Message-State: ABy/qLZWKevV8HqaiEGkBy3836wWMWtQ7+CmnWFHs35/vCwusBZO/4gK
 KCw9V+annR/NAVhVCegAOPkcCQ==
X-Google-Smtp-Source: APBJJlE6AAu5qCgZvjJES+DZTHYDvTTiZ4DUn+h3+t7u9FDatgjkcZj+zexcsuYqEwsvA1IB44jwZQ==
X-Received: by 2002:a05:600c:294b:b0:3fa:7bf9:706c with SMTP id
 n11-20020a05600c294b00b003fa7bf9706cmr9840374wmd.36.1689593524745; 
 Mon, 17 Jul 2023 04:32:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0031433d8af0dsm18916722wrx.18.2023.07.17.04.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 04:32:03 -0700 (PDT)
Message-ID: <46891cc0-6f71-b452-0e87-58953aa64826@linaro.org>
Date: Mon, 17 Jul 2023 13:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230717103544.637453-1-peter.maydell@linaro.org>
 <c7506bc9-0b59-bdaf-de3f-8bfe7d81c580@linaro.org>
In-Reply-To: <c7506bc9-0b59-bdaf-de3f-8bfe7d81c580@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 13:30, Philippe Mathieu-Daudé wrote:
> On 17/7/23 12:35, Peter Maydell wrote:
>> In CPUSparcState we define the fprs field as uint64_t.  However we
>> then refer to it in translate.c via a TCGv_i32 which we set up with
>> tcg_global_mem_new_ptr().  This means that on a big-endian host when
>> the guest does something to writo te the FPRS register this value

(typo around "write")

>> ends up in the wrong half of the uint64_t, and the QEMU C code that
>> refers to env->fprs sees the wrong value.  The effect of this is that
>> guest code that enables the FPU crashes with spurious FPU Disabled
>> exceptions.  In particular, this is why
>>   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
>> times out on an s390 host.
>>
>> There are multiple ways we could fix this; since there are actually
>> only three bits in the FPRS register and the code in translate.c
>> would be a bit painful to convert to dealing with a TCGv_i64, change
>> the type of the CPU state struct field to match what translate.c is
>> expecting.
>>
>> (None of the other fields referenced by the r32[] array in
>> sparc_tcg_init() have the wrong type.)
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Changes v1->v2:
>>   * drop unnecessary change to gdbstub.c
>>   * put the vmstate fields the correct way around
>>
>> NB: I believe the vmstate changes to be correct, but sparc64
>> seems unable to successfully do a savevm/loadvm even before
>> this change due to some other bug (the guest kernel panics
>> immediately after the loadvm).
>> ---
>>   target/sparc/cpu.h     | 2 +-
>>   target/sparc/cpu.c     | 4 ++--
>>   target/sparc/machine.c | 3 ++-
>>   target/sparc/monitor.c | 2 +-
>>   4 files changed, 6 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


