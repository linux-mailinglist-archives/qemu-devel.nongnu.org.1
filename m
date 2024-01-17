Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE0830E09
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 21:34:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQCau-0003be-Ll; Wed, 17 Jan 2024 15:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQCar-0003au-G2
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:33:01 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQCao-00067y-3Z
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:33:01 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5989d8decbfso4325895eaf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 12:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705523572; x=1706128372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQk+CYJPZnuYG2RkgSS6ZCVwuWTraJtHujafWf0AhIE=;
 b=eqO+eASW8Hj1P6oDbcPZuPfLx8tNkHX+NncRr5JR/8tw+yX5kpIi3PA9IF9n2LeKUs
 H1l7h3paxXkWNAYGhHyG8HymRR6+IEJ89yKaJE2AqUAnv5SxTbKV++xxqypPxdb3Gpf+
 euEMrWX+CvG/+w8p9sI8sufh9WgDzPZFJ9/pTNLChcp1NDZ0svZgs392XhBdNpeyq2AX
 GOc5F2Wd/1FxHXDC7k5XhrFBwHEu44NSWb6rEuXQ23doU3om6xq+L4sJEwwtaNeERUuj
 iOZx/NIZAMI3yE6/RzHBLpAK9lmZmKD5cacWXgFBhS6yJqsqeOHY5y4J+bNwrwrL3Sc/
 InkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705523572; x=1706128372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQk+CYJPZnuYG2RkgSS6ZCVwuWTraJtHujafWf0AhIE=;
 b=C7pfkPAi43seqA9nWJllXEK5CpYmKqvp1gdyzCFzREZjxtS39CY2o2uotV9aBWe/Io
 b604mRv0bgqaM7lQZnDQAX3ki9TLfPHathiB6Q4HM6QnpRFffPdmAPrc7tzZPjmzoxEo
 PogokV/N+7wyENwdtimPyIBgooB+5vEwOr8nQXWopol5qbM0uZxMDWibRB+tNBcxOxSH
 zliuI/RoJXWYO2eF5eG4LKkM+YXXEwu5w/KOtQ6lXph6m1tIL6n3S12ja9q37kU9cA7a
 gl9IjazIR3myzf/l5F5qmxdc3TMDhyZGueWhRhIR2/p6OzvEuCqaKryP02YDQaZjTxWx
 L1HA==
X-Gm-Message-State: AOJu0YxYuoSdLXu0AvbNP5dkpwRryiqDqSvMZu5oC0LgPAZ9vYJ5ACQq
 Ye1BFw28m/oNpuccW6iQJ6DXNPWMTRZFuA==
X-Google-Smtp-Source: AGHT+IFx2npmqZp7/VezOI7aAkHtVADsuW2wkMvU9oAjLxD2nQBFbnbGZ5Nda88tBFNHUkcJhB99zw==
X-Received: by 2002:a05:6359:6f91:b0:175:d3e6:8faa with SMTP id
 tl17-20020a0563596f9100b00175d3e68faamr4893999rwb.63.1705523572083; 
 Wed, 17 Jan 2024 12:32:52 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:5fc1:fe4b:9b89:f799?
 ([2001:8004:2728:321b:5fc1:fe4b:9b89:f799])
 by smtp.gmail.com with ESMTPSA id
 lp18-20020a056a003d5200b006db0f35296esm1924219pfb.148.2024.01.17.12.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 12:32:51 -0800 (PST)
Message-ID: <65fea2a9-841f-43b1-a756-66efe5c9f263@linaro.org>
Date: Thu, 18 Jan 2024 07:32:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: pcrel: store low bits of physical address in
 data[0]
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240117155143.172890-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240117155143.172890-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/18/24 02:51, Paolo Bonzini wrote:
> For PC-relative translation blocks, env->eip changes during the
> execution of a translation block, Therefore, QEMU must be able to
> recover an instruction's PC just from the TranslationBlock struct and
> the instruction data with.  Because a TB will not span two pages, QEMU
> stores all the low bits of EIP in the instruction data and replaces them
> in x86_restore_state_to_opc.  Bits 12 and higher (which may vary between
> executions of a PCREL TB, since these only use the physical address in
> the hash key) are kept unmodified from env->eip.  The assumption is that
> these bits of EIP, unlike bits 0-11, will not change as the translation
> block executes.
> 
> Unfortunately, this is incorrect when the CS base is not aligned to a page.
> Then the linear address of the instructions (i.e. the one with the
> CS base addred) indeed will never span two pages, but bits 12+ of EIP

added

> can actually change.  For example, if CS base is 0x80262200 and EIP =
> 0x6FF4, the first instruction in the translation block will be at linear
> address 0x802691F4.  Even a very small TB will cross to EIP = 0x7xxx,
> while the linear addresses will remain comfortably within a single page.
> 
> The fix is simply to use the low bits of the linear address for data[0],
> since those don't change.  Then x86_restore_state_to_opc uses tb->cs_base
> to compute a temporary linear address (referring to some unknown
> instruction in the TB, but with the correct values of bits 12 and higher);
> the low bits are replaced with data[0], and EIP is obtained by subtracting
> again the CS base.
> 
> Huge thanks to Mark Cave-Ayland for the image and initial debugging,
> and to Gitlab user @kjliew for help with bisecting another occurrence
> of (hopefully!) the same bug.
> 
> It should be relatively easy to write a testcase that performs MMIO on
> an EIP with different bits 12+ than the first instruction of the translation
> block; any help is welcome.
> 
> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL", 2022-10-11)
> Cc: qemu-stable@nongnu.org
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1964
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2012
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/tcg-cpu.c   | 20 ++++++++++++++++----
>   target/i386/tcg/translate.c |  1 -
>   2 files changed, 16 insertions(+), 5 deletions(-)

Wow, that is subtle.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

