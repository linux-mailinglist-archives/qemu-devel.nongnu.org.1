Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C9765D25
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6eM-0001dM-DY; Thu, 27 Jul 2023 15:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6eI-0001cw-6E
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:27:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP6eG-0000Cr-LC
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:27:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686ba97e4feso1381993b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690486063; x=1691090863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bm8TMvX2XHx+mvLmgiRQv6pyZeA2kCauapbXEfX9qP8=;
 b=WnuGHEEnElX3EcoO7ipXf17U1p44jb2Mp64DsSdMG7RRmMxxqK/D0bvJxYuKCx5jt/
 mvRSI7ZVV53sdSJG4rC40hX69dQgtqVS+AY+Qvku4r5njFkFrKB6vfULyDCndviADgnr
 Cuq28ymO9lNPewsGxYI8jv+yoovAx3+hQZMWkU5Wyq5VJx8occDQ9TyNHwQoU9tVI+nR
 ivtIcf6cXJ8GI40uXoVbQfr4+X4stlQdIRtYdLhby9hswJCio+hT7/waqVOjL02p6MEX
 sgNokBJ4jdGv25Ss7zV+0fuakFgREBClKzjEHKQfcTSo0ROQAJAAJEQuQIx35MnypNRe
 IH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690486063; x=1691090863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bm8TMvX2XHx+mvLmgiRQv6pyZeA2kCauapbXEfX9qP8=;
 b=X2FvkqrMYx+GBJ8rlwBgNmlBemgXIc12Fu0kDJPADNjJ6XNeAFloGjc/sNexh9xiyp
 k0OcR0hU7RQr1unLknLQp1SK+sH/NHdczguC/vp21wFpWbm7xxkbFfyAJFq8xihene+j
 uRSYjvg/Jy31mPkXoOy8kIi+7733CLd0Nw5u8jZbYKhJQkOlXzRdHTX/CkVxK0SmLWSr
 bq/MBqlJKw01DLu8AJ8+zeLHZ07OZv+Q5fu29tP2jRW15e3K+w7mMsU3zIUaVw2DuigL
 9iUYVDGm5A2m0PJvJgKrrZrD6NupgD1iq1p6rX8zUI+dlXR3k0fhzlrZ/vK/BcKViSy7
 6s5Q==
X-Gm-Message-State: ABy/qLb7bVusV71PwazxlEewc0QcZnie3Xv/BBPHY+xGMz2rEr7l3qBW
 PsQ0T+E0KqHgipG7J/vxAvilCw==
X-Google-Smtp-Source: APBJJlFNt+o0T1bGpXeo5xyRH/lphL9z0JF5YKk3J9BeAwpjA7rM0QzMKozGeboQ0PjbLPDrEQbKUg==
X-Received: by 2002:a05:6a00:1889:b0:680:98c:c595 with SMTP id
 x9-20020a056a00188900b00680098cc595mr103594pfh.13.1690486062387; 
 Thu, 27 Jul 2023 12:27:42 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 m1-20020aa79001000000b00686940bfb77sm1829278pfo.71.2023.07.27.12.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 12:27:41 -0700 (PDT)
Message-ID: <23d2a2d6-eb18-059a-a652-6abaac28a0dd@linaro.org>
Date: Thu, 27 Jul 2023 12:27:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/9] target: Use vaddr for
 kvm_arch_[insert|remove]_hw_breakpoint
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-4-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> Changes the signature of the target-defined functions for
> inserting/removing kvm hw breakpoints. The address and length arguments
> are now of vaddr type, which both matches the type used internally in
> accel/kvm/kvm-all.c and makes the api target-agnostic.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/sysemu/kvm.h   |  6 ++----
>   target/arm/kvm64.c     | 16 ++++++++--------
>   target/i386/kvm/kvm.c  | 15 +++++++--------
>   target/ppc/kvm.c       | 15 +++++++--------
>   target/s390x/kvm/kvm.c | 11 +++++------
>   5 files changed, 29 insertions(+), 34 deletions(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 5670306dbf..19d87b20e8 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -426,10 +426,8 @@ int kvm_arch_insert_sw_breakpoint(CPUState *cpu,
>                                     struct kvm_sw_breakpoint *bp);
>   int kvm_arch_remove_sw_breakpoint(CPUState *cpu,
>                                     struct kvm_sw_breakpoint *bp);
> -int kvm_arch_insert_hw_breakpoint(target_ulong addr,
> -                                  target_ulong len, int type);
> -int kvm_arch_remove_hw_breakpoint(target_ulong addr,
> -                                  target_ulong len, int type);
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type);
> +int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type);
>   void kvm_arch_remove_all_hw_breakpoints(void);
>   
>   void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 94bbd9661f..c0750792cb 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -49,32 +49,32 @@ void kvm_arm_init_debug(KVMState *s)
>       return;
>   }
>   
> -int kvm_arch_insert_hw_breakpoint(target_ulong addr,
> -                                  target_ulong len, int type)
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
>   {
>       switch (type) {
>       case GDB_BREAKPOINT_HW:
> -        return insert_hw_breakpoint(addr);
> +        return insert_hw_breakpoint((target_ulong) addr);

No need for the casts.


r~

