Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C303C7CC1D4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiJH-0008Di-4F; Tue, 17 Oct 2023 07:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsiJE-0008Da-W3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:32:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsiJD-0000DK-6P
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:32:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4054f790190so58825125e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697542341; x=1698147141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7AdbJp2pwbBKBm8y17LKHK2aZ8zGpxOrU9nR0FTKMw=;
 b=x8zDwtgrZE9OrkVJivdje0a3kWdgbKS9TvZurcf9TEjL0MRWvWDRNTRk9Y1cVCt4/J
 djbOpguGwhwb6uAqWBEKJt+q1UxcNADxnb9ajW8EA0KDeQnaWxOf5Z1H7GDkHHBmYbEZ
 qc+GHsMKP41dFF3JPFHYpBkDFkkEDC2IDInVC8psMFwOMLbIh0WADoYSW09VMWzTKJ+k
 2Ig9YRkPc8ZUeuYlVRb/OyDcB8X1u5czkCwWt3L0M/mkKN324olG8vpYcLCmJqfVhC5C
 ttIN9s7IzFcXSYf6AtEF4+QiGDA6OngqtoMQC/Ds1GDbCbU8dV7V2YeXea31MNZ01qLo
 NWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542341; x=1698147141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7AdbJp2pwbBKBm8y17LKHK2aZ8zGpxOrU9nR0FTKMw=;
 b=R+8ArgsaYeIe7f7RE/+1q2YyUmWS//HpZFgJFJUyUUWYFKCj6uOV/jUFHvOIIFyz/E
 K4X82LRctXAwwfe48Sn3pY0UiiLFqjctMUnIzHbShBhKYyaJuJNXQHLVoYcHJBNTXBR6
 AoQS4WRoArH+QHW5cpHlcSKlLMiVUKFGgyWAXc4ZW6D2mOdILSx+bBR+FJ1OxSznrZ9R
 j9tjZB9wamecJRBxSPkWxdVHgJSWTNx9UJDauF5Vl/hlQbSicLBNgX3JmR7ie6dPS1MK
 stWez5WSryMO3qT9TbgMimG7qmRwUv2KewmT2XDTp8h20UCkopGQCQEZPM3KuMceyh+d
 ew9w==
X-Gm-Message-State: AOJu0YzS1E+GH1cIj/R2Y7MK+tomW7OLUylAB44IF723qZucnvnJ9bCu
 8Kba16o2XsXdU464cRpXfOv+aw==
X-Google-Smtp-Source: AGHT+IGwPO40cZ4eycS64BI5aOH/XBMZebm8w+xLxMQv2aLLjUi+j8FcPMeZbKKxLpJfZJz0UFCUtQ==
X-Received: by 2002:a05:6000:11c1:b0:32d:857c:d51c with SMTP id
 i1-20020a05600011c100b0032d857cd51cmr2036802wrx.43.1697542341140; 
 Tue, 17 Oct 2023 04:32:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d67cd000000b0032dbf32bd56sm1483503wrw.37.2023.10.17.04.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 04:32:20 -0700 (PDT)
Message-ID: <00a51d67-18c6-37de-eb15-679032af0679@linaro.org>
Date: Tue, 17 Oct 2023 13:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] semihosting/arm-compat: Have TARGET_SYS_EXIT[_EXTENDED]
 return signed
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20231005062610.57351-1-philmd@linaro.org>
 <CAFEAcA_P3s07PpNeDVvy8xB7HLM5+Uvnv=NDycVWW3LR7iT_vg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_P3s07PpNeDVvy8xB7HLM5+Uvnv=NDycVWW3LR7iT_vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Peter,

On 16/10/23 18:08, Peter Maydell wrote:
> On Thu, 5 Oct 2023 at 07:27, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Per the "Semihosting for AArch32 and AArch64" spec. v2 (2023Q3) [*]:
>>
>>    6.5   SYS_EXIT (0x18)
>>    6.5.2   Entry (64-bit)
>>
>>      On entry, the PARAMETER REGISTER contains a pointer to
>>      a two-field argument block:
>>
>>      . field 1
>>        The exception type, which is one of the set of reason
>>        codes in the above tables.
>>
>>      . field 2
>>        A subcode, whose meaning depends on the reason code in
>>        field 1.
>>
>>      In particular, if field 1 is ADP_Stopped_ApplicationExit
>>      then field 2 is an exit status code, as passed to the C
>>      standard library exit() function. [...]
>>
>> Having libc exit() is declared as:
>>
>>    LIBRARY
>>         Standard C Library (libc, -lc)
>>
>>    SYNOPSIS
>>
>>         void
>>         exit(int status);
>>
>> the status is expected to be signed.
>>
>> [*] https://github.com/ARM-software/abi-aa/blob/2023q3-release/semihosting/semihosting.rst#652entry-64-bit
> 
> Is this actually a visible change in behaviour? It makes
> more sense to use 'int', I agree, but unless I'm confused
> about C type conversions then I don't think it actually
> changes the result in any case, does it?  Given we start with a
> guest 64 or 32 bit signed integer value and put it into a
> 'target_ulong' (arg1), it doesn't seem to me to make a
> difference whether we put it into a 'uint32_t' or an
> 'int' (ret) before passing it to either exit() or
> gdb_exit() (which both take 'int')...

There should be no behavioral change, it is a cleanup
to avoid asking "why are we using a uint32_t here?" in
future reviews. Do you rather I mention it in the commit
description?

Regards,

Phil.

