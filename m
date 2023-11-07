Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71E57E3C0A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:11:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KuX-0003MH-H4; Tue, 07 Nov 2023 07:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KuT-0003M5-7Y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:10:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0KuL-0001w5-Ew
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:10:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40859c464daso40997965e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699359010; x=1699963810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J2R1mYuNzuzNRDswuRQ7nDcs+VpaDf937PLoLwwtl/Y=;
 b=HNu//sD1540Yit+wRX1F0Gce9bHGrIS8JOqopQknl9dJdQ6dHxB6qeecPt2oOjsEXC
 +rM+EvpCyFfBXYjQHz4MWAHS8bI22pybp3pBg3ursz+iaqkXue+0X4SEgbqT2mO18H7Q
 W+qiR5LVCcGm++mvZNKPoJWl7DL72+XTbWVf1qOmk3HuvRq9gyprSJDTo6890nKB8XY7
 LLTstChv38wNEzu/wH1B64Ij16HFQTaJmTLrXDFmwdqWqQUVST4aBGpfYE+yy0V3O4dk
 7GAq6OBOm0aEHJanjExwKDyPdGNT7Dk6i8TWPWRyGAVEmpZw/JwbSSDpPG9xvCTcLz11
 4FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699359010; x=1699963810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2R1mYuNzuzNRDswuRQ7nDcs+VpaDf937PLoLwwtl/Y=;
 b=QnQvRqs0MheIJk6sIXs0/wRpu5hstGTdm7N2VNK2pIIi3c0zhmMpHDoCM2Menssdvf
 Yl7LJ3LDP36XNXT9hoQ4WbRhH8ttbD1t5uOiMMlVZXKwX+v97CnGwQK3hraj3U3goR4P
 zuEC4mcujOiA+VwSUnSxpLSzpt2Z0YJps6p6ruEVxHk5cV68/xNLncB/DR/U2kVXzNL9
 KyqWvqjZ5p9WGTmIc3/j2Df3SkpemSN/8NAFa3VQGR+Xie6sqHfTm2F8RjaQwD7S8MBq
 MATWJc85HNPknHTbBapM8LUgsPSyaAuQvay0987fAhhTqv+k8ePHBrx0YeX8rFomqJDI
 5xgg==
X-Gm-Message-State: AOJu0Yx2q2w2wgy2D9iew7c8pf4EqxCCRlBV4CPjPtGkqBBtlsB6SqIU
 MWPXgAu/HZMB1M+vHOrMd0zJO+1+pb/KBUFZDQs=
X-Google-Smtp-Source: AGHT+IHXBy85yLkTMorS7epkibpMLNewIW8R26evXhHY1jrlKYu8nfZMpORId97Ulp6MoBdzZPFEnQ==
X-Received: by 2002:a05:600c:35cb:b0:408:3707:b199 with SMTP id
 r11-20020a05600c35cb00b004083707b199mr1817055wmq.3.1699359009727; 
 Tue, 07 Nov 2023 04:10:09 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 az25-20020a05600c601900b004095874f6d3sm15967469wmb.28.2023.11.07.04.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 04:10:09 -0800 (PST)
Message-ID: <49a53d43-cc99-48f8-9e3f-41e8abd32b37@linaro.org>
Date: Tue, 7 Nov 2023 13:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/s390x/sclp: Have sclp_service_call[_protected]()
 take S390CPU*
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231106114500.5269-1-philmd@linaro.org>
 <20231106114500.5269-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106114500.5269-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/11/23 12:44, Philippe Mathieu-Daudé wrote:
> "hw/s390x/sclp.h" is a header used by target-agnostic objects
> (such hw/char/sclpconsole[-lm].c), thus can not use target-specific
> types, such CPUS390XState.
> 
> Have sclp_service_call[_protected]() take a S390CPU pointer, which
> is target-agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/s390x/sclp.h        | 5 ++---
>   hw/s390x/sclp.c                | 7 ++++---
>   target/s390x/kvm/kvm.c         | 2 +-
>   target/s390x/tcg/misc_helper.c | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 9aef6d9370..e229b81a67 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -227,8 +227,7 @@ static inline int sccb_data_len(SCCB *sccb)
>   void s390_sclp_init(void);
>   void sclp_service_interrupt(uint32_t sccb);
>   void raise_irq_cpu_hotplug(void);
> -int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
> -int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> -                                uint32_t code);
> +int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
> +int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code);
>   
>   #endif
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index d339cbb7e4..893e71a41b 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -269,9 +269,9 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>    * service_interrupt call.
>    */
>   #define SCLP_PV_DUMMY_ADDR 0x4000
> -int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> -                                uint32_t code)
> +int sclp_service_call_protected(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   {
> +    CPUS390XState *env = &cpu->env;
>       SCLPDevice *sclp = get_sclp_device();
>       SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>       SCCBHeader header;
> @@ -296,8 +296,9 @@ out_write:
>       return 0;
>   }
>   
> -int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
> +int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
>   {
> +    CPUS390XState *env = &cpu->env;
>       SCLPDevice *sclp = get_sclp_device();
>       SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>       SCCBHeader header;
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 1ddad0bec1..a12fbfc026 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -1174,7 +1174,7 @@ static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>           break;
>       case ICPT_PV_INSTR:
>           g_assert(s390_is_pv());
> -        sclp_service_call_protected(env, sccb, code);
> +        sclp_service_call_protected(cpu, sccb, code);
>           /* Setting the CC is done by the Ultravisor. */
>           break;
>       case ICPT_INSTRUCTION:

Here I forgot:
-- >8 --
@@ -1179,7 +1179,7 @@ static void kvm_sclp_service_call(S390CPU *cpu, 
struct kvm_run *run,
          break;
      case ICPT_INSTRUCTION:
          g_assert(!s390_is_pv());
-        r = sclp_service_call(env, sccb, code);
+        r = sclp_service_call(cpu, sccb, code);
          if (r < 0) {
              kvm_s390_program_interrupt(cpu, -r);
              return;
---

> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index 56c7f00cf9..6aa7907438 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -102,7 +102,7 @@ uint64_t HELPER(stck)(CPUS390XState *env)
>   uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
>   {
>       qemu_mutex_lock_iothread();
> -    int r = sclp_service_call(env, r1, r2);
> +    int r = sclp_service_call(env_archcpu(env), r1, r2);
>       qemu_mutex_unlock_iothread();
>       if (r < 0) {
>           tcg_s390_program_interrupt(env, -r, GETPC());


