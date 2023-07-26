Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2E763B47
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOg4F-0008Da-J9; Wed, 26 Jul 2023 11:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOg1M-0007IT-GA
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:01:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOg1K-0005Bz-OH
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:01:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686baccf661so954950b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690383705; x=1690988505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfJ7paRpdLJkrqEJ5aRJ+WWxHnJdXEYWWNfzKsA5g9E=;
 b=W7690Ev+dBOznYUqBn4p+EOX614HxouU+9FIguAviRo1irGXsl46Kx0uyCVZwAObJf
 s+WrFBkuQWx4k2XUt4DFsIR1hz6JoSikD4o2M1IlwhCz/cCTEGMAX0rxyRKn1NIad9Kc
 i7H7/A4jwUE9SWE1nOO3rf5GfcqYicg4jxRYpzL+FTwApZTDqx1VrB6hc+YZjQuNdYjO
 NsYgLepSu9frcbAmVFDnq1bPitvmnfG1v9tiFC+wln1ZEjNRObtSJ41ibRdCkQk7Vd+p
 xL4gl+HG/8CX4iCiEz6+7kYwbv8j0ZWY2Udh1kJSyNuZyv1/uu/RciUQOpPioNS7Jafr
 tLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690383705; x=1690988505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qfJ7paRpdLJkrqEJ5aRJ+WWxHnJdXEYWWNfzKsA5g9E=;
 b=ftkCrVBeSTkUiLmBICcHSa2jyK2wzeDhvNKetSD7k2cSPP3Z2QA2NkBkWVYZThy4N3
 DBDSh0oyCJFfesS95ANdsjEsnCPHKDgGAr2790g+sPv32V/6Jga4ubKucWb/fEChGcOo
 ML999lsBG8GJCqlNSTaMBuSosK+2dNrHwxOg72pSJrJxj+jR2veTz1gagT1UgMgfzjDQ
 U3VJVUQ2IoEBITzj5CNwpzdDGxN02zfJIjMcQib8ZncnjWpbLJuy0xcd0eBIvogdNP1I
 2vUmiD7oDTv9EmcgUrm8NEEfR+5VpzriZa5IXOk7Xshzkad2KzZbbuSzb88oX8trfh+2
 lPGA==
X-Gm-Message-State: ABy/qLbhaydny1GJFqzEAt/9675vqXC3y9l4KJJ498pmb+/RmE3ygfvV
 xLgH9OFZR1aYrpu4X3zO9bufOQ==
X-Google-Smtp-Source: APBJJlFz14979q1PKYLx0IjE2f/4g0JBoikEgJFcq+J5S7XMsSxQasFufWLwK4EyQislQ+/uQjDjxA==
X-Received: by 2002:a17:90a:e2ca:b0:268:2f2:cc88 with SMTP id
 fr10-20020a17090ae2ca00b0026802f2cc88mr1901615pjb.12.1690383704904; 
 Wed, 26 Jul 2023 08:01:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a17090ad91000b00265a7145fe5sm1390213pjv.41.2023.07.26.08.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 08:01:44 -0700 (PDT)
Message-ID: <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
Date: Wed, 26 Jul 2023 08:01:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230726081710.1051126-1-ardb@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230726081710.1051126-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/26/23 01:17, Ard Biesheuvel wrote:
> While working on some EFI boot changes for Linux/x86, I noticed that TCG deviates from
> bare metal when it comes to how it handles the value of the stack pointer register RSP
> when dropping out of long mode.
> 
> On bare metal, RSP is truncated to 32 bits, even if the code that runs in 32-bit
> protected mode never uses the stack at all (and uses a long jump rather than long
> return to switch back to long mode). This means 64-bit code cannot rely on RSP
> surviving any excursions into 32-bit protected mode (with paging disabled).
> 
> Let's align TCG with this behavior, so that code that relies on RSP retaining its value
> does not inadvertently work while bare metal does not.
> 
> Observed on Intel Ice Lake cores.
> 
> Cc: Paolo Bonzini<pbonzini@redhat.com> Cc: Richard
> Henderson<richard.henderson@linaro.org> Cc: Eduardo Habkost<eduardo@habkost.net> 
> Link:https://lore.kernel.org/all/20230711091453.2543622-11-ardb@kernel.org/ 
> Signed-off-by: Ard Biesheuvel<ardb@kernel.org> --- I used this patch locally to
> reproduce an issue that was reported on Ice Lake but didn't trigger in my QEMU
> testing.
> 
> Hints welcome on where the architectural behavior is specified, and in particular,
> whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
> length values.

No idea about chapter and verse, but it has the feel of being part and parcel with the
truncation of eip.  While esp is always special, I suspect that none of the GPRs can be 
relied on carrying all bits.

I'm happy with the change though, since similar behaviour can be observed on hw.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

