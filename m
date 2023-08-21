Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ACC782D0C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 17:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY6cb-0004Is-Sc; Mon, 21 Aug 2023 11:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY6cU-0004I3-10
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:15:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY6cR-00072b-GC
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 11:15:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so20789235ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692630901; x=1693235701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3/XT2GYoCZFeNeLbI82X+TOOjX4fL0cWNocCogcOyiA=;
 b=XPKNn3XxEiaEqNf3NfeCNRJPluFilPHvfZJGFwtN5OVpK5lUtGwMFmdiILBbX0e/dv
 2+PYXxeU5Juo1VNdPDmaGwSCBWkuGsfb/aiTvhyFI4oBUewZhQ3ncE49JMX2ZNX9z+yu
 qwvLAOTuEfolQFb9IVErxeiMGfnaKksTH+JnDbmsBYOJYRkQjGPGJuHmMLgMbxIBIYI2
 jOvcDJ1ANKZXPKXvQop+OXdfjwR2tW1rfpsSy6hVRj1fgVqvPbgOecNOS5XSleUVJkpS
 XQm/9HNwfSxkADiEVMJv2itoPvuf9OL9rnLxGkUt9V23iODqoywf4Ht0/OUtBx8pUxtX
 gX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692630901; x=1693235701;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3/XT2GYoCZFeNeLbI82X+TOOjX4fL0cWNocCogcOyiA=;
 b=exGR7U1dg2D95mNq42dhXgCETRfNn8HYnWv0DJGAY87Q3jlLMUJhBv61e5UqP5XaNm
 o0XTVB2xnujYYOHVvK43ZbHxTbs4ywszfqJu1+uoJ1uL5ELSe90V3GLkkxcjflBWhGDB
 JptQB5HSht5A0uDNW/5qltSoXYidEWA1xWQSE5bMKhB0o4lUUcDvpO/TXW65lZglXbt/
 YjGt1lm9cpYvFdDVE+QsPuS1VmFjHXAFtSRIuC18fhyxKY97FBpAdyfVriAYqb7oPnpQ
 rs8okvPHE7gpYzS2skrJBDydfMwGVLPnuwYlcmpQOCSNipdPX5FUOdTxP608ALC6ruEG
 MHlg==
X-Gm-Message-State: AOJu0YxPDhRgHj5U+ml83NgJnP2N42oX4R//i+5Rt8x4n+8z6b3/OJYf
 ITJbLmlLxqR4n9Z02VdBiNzcGg==
X-Google-Smtp-Source: AGHT+IHUxrxxyFOHByWIxkFW/HN5i+aPUMy5DQxPG82QsBJkPLhBnTOSa4lOq0EB2UGy2R3RvQUDog==
X-Received: by 2002:a17:902:6b47:b0:1b8:b3f0:3d57 with SMTP id
 g7-20020a1709026b4700b001b8b3f03d57mr4492527plt.31.1692630901036; 
 Mon, 21 Aug 2023 08:15:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:2c08:e710:4459:46f1?
 ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 iy20-20020a170903131400b001b89b7e208fsm7188006plb.88.2023.08.21.08.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 08:15:00 -0700 (PDT)
Message-ID: <dcbfe992-303d-5472-e7c7-4c1c717cde7b@linaro.org>
Date: Mon, 21 Aug 2023 08:14:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/18] crypto: Provide clmul.h and host accel
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <CAMj1kXFWeUzWkpt5o0Bh6CXzBHoxkZk7wUiLsidEvDjH_SSnHw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMj1kXFWeUzWkpt5o0Bh6CXzBHoxkZk7wUiLsidEvDjH_SSnHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 8/21/23 07:57, Ard Biesheuvel wrote:
>> Richard Henderson (18):
>>    crypto: Add generic 8-bit carry-less multiply routines
>>    target/arm: Use clmul_8* routines
>>    target/s390x: Use clmul_8* routines
>>    target/ppc: Use clmul_8* routines
>>    crypto: Add generic 16-bit carry-less multiply routines
>>    target/arm: Use clmul_16* routines
>>    target/s390x: Use clmul_16* routines
>>    target/ppc: Use clmul_16* routines
>>    crypto: Add generic 32-bit carry-less multiply routines
>>    target/arm: Use clmul_32* routines
>>    target/s390x: Use clmul_32* routines
>>    target/ppc: Use clmul_32* routines
>>    crypto: Add generic 64-bit carry-less multiply routine
>>    target/arm: Use clmul_64
>>    target/s390x: Use clmul_64
>>    target/ppc: Use clmul_64
>>    host/include/i386: Implement clmul.h
>>    host/include/aarch64: Implement clmul.h
>>
> 
> I didn't re-run the OpenSSL benchmark, but the x86 Linux kernel still
> passes all its crypto selftests when running under TCG emulation on a
> TX2 arm64 host, so
> 
> Tested-by: Ard Biesheuvel <ardb@kernel.org>

Oh, whoops.  What's missing here?  Any target/i386 changes.


r~


