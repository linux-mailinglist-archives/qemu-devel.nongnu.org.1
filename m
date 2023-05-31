Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2C71883D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PNp-0004Gi-LT; Wed, 31 May 2023 13:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4PNn-0004Fb-M0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:13:11 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4PNm-0005oD-6J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:13:11 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5353521a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685553188; x=1688145188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UbGZWoyBpqZ1b2Xq4238aMV8PCe970ho30HBemnWEc4=;
 b=AxemYN5s8SgVf0OLrmXTGTP8+BlKkYfo+KJFh0yILLz1NXttV623vdBLQIiNMsJE9b
 zbXVfvHreL22f3kmydHmlslauqo/JO5I5NdazBzRMvJxF0uPjC7x4WXM6kuMwMKEk7xd
 HoIUKLn4pxRTTkqLzbQZVzF226b084wKUVPetkCX8lUbMmKxRDMUaMvB3oKkNF0bOKs9
 MoHwXT19UfhMx6sLVGFzJsHHKLeeXSadl/h6EKgLsyB8KMV1VlgYZdW9hQrPrNXc4eCL
 Q0ZY/OnJUPQwqcsow9GDbsHz62uYwavgqNtfFzlqpMY/ozIGa4PuTwtqsYGCOY0ZHiuP
 BJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685553188; x=1688145188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbGZWoyBpqZ1b2Xq4238aMV8PCe970ho30HBemnWEc4=;
 b=NaSzML6O1i3SuXEo8GgqF0+Rb6P0khpHrbX6uSIU+tf/tuk1Z43+KpeLFD75LG4Ato
 pliOtTbCvuVE8jMxOOwQB3xEGg+DMUDmwF1qaZQSF1Gey2GgiNkzSXyy1Yf84VAoGC89
 szKxKeKsAZ1T3AS5pqHtUgSOHdZmmlhsMQNv7zTERdtNsrICSC3gRUfWBXoSGq3KnbJz
 sHV7xrzHm7qhyijjaJ+2TDJuBZ40de9D3Mh1pX0TRcOSbLUY2sflqmOnpkdgDdr5AHub
 B+Rt/DQhKuzulZoDem/175FTKMjFfjnrg3vpusyTLHhp5slRdKJzITgeiQIaMet5honV
 JXog==
X-Gm-Message-State: AC+VfDw/kECRSkMV+Gk6RXk47Nbaw0QeLk3JOjgIwc2xGTVrs9O1o0ow
 uSJgqxtVpL6mJlUpsR0AT6HrNQ==
X-Google-Smtp-Source: ACHHUZ4JrsnRKtKXi3pKGMa6jfC83GV/vntrPM6mp22vXOP2/vjuiUKzGJGf9YsGJTtovAd8C7SQ4A==
X-Received: by 2002:a05:6a20:d90b:b0:10c:89cc:bc5f with SMTP id
 jd11-20020a056a20d90b00b0010c89ccbc5fmr6357822pzb.20.1685553188351; 
 Wed, 31 May 2023 10:13:08 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 23-20020aa79157000000b0064fff9f540csm2780991pfi.164.2023.05.31.10.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 10:13:07 -0700 (PDT)
Message-ID: <5c5c64f4-7b69-5513-0ee4-6e23678e8177@linaro.org>
Date: Wed, 31 May 2023 10:13:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] target/i386: Implement AES instructions using
 AArch64 counterparts
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20230531112239.3164777-1-ardb@kernel.org>
 <20230531112239.3164777-3-ardb@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230531112239.3164777-3-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/31/23 04:22, Ard Biesheuvel wrote:
> +++ b/util/cpuinfo-aarch64.c
> @@ -56,6 +56,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>       unsigned long hwcap = qemu_getauxval(AT_HWCAP);
>       info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
>       info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
> +    info |= (hwcap & HWCAP_AES ? CPUINFO_AES : 0);
>   #endif
>   #ifdef CONFIG_DARWIN
>       info |= sysctl_for_bool("hw.optional.arm.FEAT_LSE") * CPUINFO_LSE;

FYI, "hw.optional.arm.FEAT_AES" exists for darwin, and is set for Apple M1.
I'll incorporate that when adding the probing.


r~

