Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB0827A60
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 22:47:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMxRQ-0003pU-9x; Mon, 08 Jan 2024 16:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMxRO-0003o0-PI
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:45:50 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rMxRM-0002j5-VA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 16:45:50 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28cc07d8876so1247854a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 13:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704750347; x=1705355147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dwvAVdhZerN0PvjGvngabAMvYcnQaxHuiJIPP8UILKk=;
 b=tp1n7CM2IfPUGMCNeaSbdR3p31f2EdnVIrzeGpJzg5C5lZuSafD5jwPZQK8yfOMc3r
 ep12w8fX160Yy/i7VGzA7LISHWTAJ/Uli3z7Vnn8WSnNKSdHw7P6W81hgSU5PqLQA3nn
 Ax56BfSZbNnP2cITXjkYkQuqc15Rl2T7K6noBzp/JliEMeghDQPXiXHlyrFkDz3EX6/d
 +hFwbjRiIjXFd+yKwbeX+YUi15af4bAGkY9RMiTFCxu9iBgLjOgbtdol8f+n0u1QaDBU
 IEQpmTZAoTyKtMZvrHJGMpFWyc/o3gF/UB+UPhUZcFGivO3S9gYEPTGx9e5HJ2ZmqxR/
 AWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704750347; x=1705355147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dwvAVdhZerN0PvjGvngabAMvYcnQaxHuiJIPP8UILKk=;
 b=VJFyYbfz9ayfiSiy2QcW/BjqG1JiH77iuGJ6UzTF8TCySj7ndrPW+o3jVRHKs2k+AW
 5aaSqalMdne1Vu8ENXI94+wDWO5ciHqH8B+KwPlBflvQ45R506b9O8NUeBrlVZdcDmCR
 ab8SD6Vn4EVO074YgkeWhaHhrRQqlKr/5dJ/E/n+avthDf+TR+xdVQEzKxrhvvEmr63y
 LEP2cPa3weZaY5Ao+4i6y9ysecUpI/slZi0s0R8Eu1a0nbk8dAlbAGt1kv4TklqShhfH
 A4xS8LFQbD98rV8ICdGmA6yzLlpkcMWoO/9L2kWm4DBps40lnkZpqP4m0DseseP4wv72
 5IVg==
X-Gm-Message-State: AOJu0Yz0/Us2edNAwbFuX9WTjamhFJTlHeODIHNDNeNNOcbqEXT8J/0x
 sewU5WfZAU5cRajV476dL8AVoGtzGuqdBA==
X-Google-Smtp-Source: AGHT+IEEHQgP25/sllFxNeseUIsfEUo/tVdmxRogIno+jNKU4SSWIjkfhIuZSZvYUTljY7mfkwlQHA==
X-Received: by 2002:a17:90b:1991:b0:28b:894b:4494 with SMTP id
 mv17-20020a17090b199100b0028b894b4494mr1768945pjb.55.1704750347341; 
 Mon, 08 Jan 2024 13:45:47 -0800 (PST)
Received: from [192.168.1.66] ([103.194.3.133])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a17090276c300b001d5389bd42fsm360040plt.57.2024.01.08.13.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 13:45:46 -0800 (PST)
Message-ID: <6327ac54-6394-4648-b4b8-2294a37b1588@linaro.org>
Date: Tue, 9 Jan 2024 08:45:41 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] tcg: Introduce TCG_COND_TST{EQ,NE}
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <CABgObfZme6gNZG=3ibXb8=+yAg=LHPeHYdncdx2LgN741bk_7A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfZme6gNZG=3ibXb8=+yAg=LHPeHYdncdx2LgN741bk_7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/7/24 04:43, Paolo Bonzini wrote:
> On Sat, Oct 28, 2023 at 9:45 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Expose a pair of comparison operators that map to the "test"
>> comparison that is available on many architectures.
>>
>> Changes for v2:
>>    * Add TCGCond to tcg_target_const_match.
>>      This fixes a long-standing issue with ppc and s390x backends,
>>      in that CMPI for signed comparisons has signed immediate and
>>      CMPLI for unsigned comparisons has unsigned immediate.
>>      But now allows different immediates for the TST comparisons.
>>    * tcg/i386: Generate TEST x,x for power-of-two in {7,15,31,63}.
>>    * tcg/i386: Generate BT n,x for other power-of-two.
>>    * tcg/ppc: tcg_target_const_match improvements
>>    * tcg/s390x: tcg_target_const_match improvements
>>    * target/m68k: Use TST{EQ,NE} for gen_fcc_cond.
> 
> I updated the MIPS backend (untested though) and pushed the result to
> branch i386 of https://gitlab.com/bonzini/qemu/.

Thanks.

> 
> However I was thinking: a lot of RISC targets simply do AND/ANDI
> followed by the sequence used for TCG_COND_NE.  Would it make sense to
> have a TCG_TARGET_SUPPORTS_TST bit and, if absent, lower TSTEQ/TSTNE
> to AND+EQ/NE directly in the optimizer?

Probably best, yes.

> And for brcond2/setcond2,
> always using AND/AND/OR may work just as well as any backend-specific
> trick, and will give more freedom to the register allocator.

   test   a,b
   testeq c,e

for Arm32.  So I'll leave it to the backends.


r~

