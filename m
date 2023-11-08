Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C512E7E52D6
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:49:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fBF-0001ap-CC; Wed, 08 Nov 2023 04:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fBD-0001aL-54
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:48:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fB8-00012v-97
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:48:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so3209645e9.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699436932; x=1700041732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3xN8BLIngOKf29hMu2brY8InYYpwWBu6E64Lq5VmHxM=;
 b=WRSXDpxY2g6LsJSkKZYsx4iXnGi2FcQ3CNbPgLG8IKkwWhWIkJ/4pSGfGZhEfLDhE8
 b8+zwEy4t1qRAlnZQh+wtQCUcSr24sXHlaxnUZKGgG6wn/Gx2bSAjnMMqBgUrVEx+Lyw
 XrzsDmit2vfboTP6Vn/s0M7JwrqXJ8tUkrs4mY7v5D8g0FEknNWaSo3w0gc7xGKaFOu7
 n7YbaXp0UReRgh7kPpBVEYC1md0yq1CdwQ/1TnrIRJhZQ9LXSoY7l88uYdDpae1vlwvk
 0tYoEV7MHIifh/QJ/fvGr5MHHIY6epk6GP6A+kRWLkJw6fbw+o/72OXBJOkg8R2XyUMB
 VUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699436932; x=1700041732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3xN8BLIngOKf29hMu2brY8InYYpwWBu6E64Lq5VmHxM=;
 b=dMfvXSTd79PIy1IRBFB/HV4OltPKb1bwGoaPwfYqkp6Xzwd3dCABHdY2rQTgV370Fz
 heeNClZ1FSiM4/9YzkZMsZjnCqs7Xz5GIMsrFy1AuPpB9ta4V1druZ9pPtA1WmIlCTJg
 llQDDcm+f1k2pSwnoqO+lFxxisooMXBXGXelEel7WPnXIvGUM+BU+XWeqGCC8Lf3mknr
 O54I73mnqpQYsTCNdWXfdHXhUHzDiBp8E1+5uHJujBiV0NjftsokMb2JDHQR398VL+On
 2Iu9PSyY+Hq6s6GzBBmZlZn0sFmoMSjs5C10rAUhhHzB4SfEuJ68sZAf5CfqbJQId5Cx
 WT8w==
X-Gm-Message-State: AOJu0YxJYt36P0hX7rj/Dp7gv0L+UGQKCSTu9ycle5AsOhvIcWR3HT7+
 WP8kUhLqPKj8o3uwgsxkAfmlCA==
X-Google-Smtp-Source: AGHT+IHy26c3vAFtgaJWVgMKAn5bQAqVjVKhRtO5lpXl0075kbxkRnwvHu2SzJfzh5bJfKBzYYvVpw==
X-Received: by 2002:a05:600c:3104:b0:407:3e94:bcca with SMTP id
 g4-20020a05600c310400b004073e94bccamr1576621wmo.1.1699436932469; 
 Wed, 08 Nov 2023 01:48:52 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a05600c4e0500b00407b93d8085sm18784426wmq.27.2023.11.08.01.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 01:48:51 -0800 (PST)
Message-ID: <0a11d505-ed81-4fe5-8ed6-cbbb4afd334a@linaro.org>
Date: Wed, 8 Nov 2023 10:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] target/loongarch: Implement kvm get/set registers
Content-Language: en-US
To: xianglai li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
 <20231108014141.2590657-5-lixianglai@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231108014141.2590657-5-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Tianrui, Xianglai,

On 8/11/23 02:41, xianglai li wrote:
> From: Tianrui Zhao <zhaotianrui@loongson.cn>
> 
> Implement kvm_arch_get/set_registers interfaces, many regs
> can be get/set in the function, such as core regs, csr regs,
> fpu regs, mp state, etc.
> 
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>   meson.build                   |   1 +
>   target/loongarch/cpu.c        |   3 +
>   target/loongarch/cpu.h        |   2 +
>   target/loongarch/kvm.c        | 580 +++++++++++++++++++++++++++++++++-
>   target/loongarch/trace-events |  11 +
>   target/loongarch/trace.h      |   1 +
>   6 files changed, 596 insertions(+), 2 deletions(-)
>   create mode 100644 target/loongarch/trace-events
>   create mode 100644 target/loongarch/trace.h


> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index e6a99c83ab..2580dc26e1 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -359,6 +359,7 @@ typedef struct CPUArchState {
>       MemoryRegion iocsr_mem;
>       bool load_elf;
>       uint64_t elf_address;
> +    uint32_t mp_state;
>       /* Store ipistate to access from this struct */
>       DeviceState *ipistate;
>   #endif
> @@ -477,6 +478,7 @@ static inline void cpu_get_tb_cpu_state(CPULoongArchState *env, vaddr *pc,
>   }
>   
>   void loongarch_cpu_list(void);
> +void kvm_arch_reset_vcpu(CPULoongArchState *env);

Can we keep the KVM namespace out of generic CPU one?

You add "kvm_loongarch.h" in patch #8 of this series, this seems
a good fit IMHO.

Regards,

Phil.

