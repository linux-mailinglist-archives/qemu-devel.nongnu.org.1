Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 184247F7365
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:06:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UxC-00088J-IK; Fri, 24 Nov 2023 07:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UwJ-0007jn-KD
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:05:44 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6UwH-0008NN-LD
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:05:43 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso22171981fa.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700827539; x=1701432339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KBtRS9rXbG5xbiUaGd4Om2KDFww1AXus+neXP9XVFqw=;
 b=kxUahs/NeSx9SWIRnQ7HiRIV12l//Gk+wGsZcBCnnPrCtdxG8vmfBfw4jJrq/g6DYe
 tJ8kS8Ba3ceZOgqp39DgKr8mwNWoG8T0dARaaa/7HwfOiIXlEyszAghz3xcYWlhQzO82
 U2InwPm3WY0txrUXFn5K5PW+T6TP1309XsBq7O168aXB0k3uG9XYRhokbqaJqHCDsJiX
 oT2vCIvvGaOvnx8nP9fsMQjbs0vp3V36A1X2ukPgL4MBo+sN4TsnGBOLn9c7A+6up3vx
 LFObXV6i5/lO4CtDCae3rix3v3zL2YQqzXf6d8zavQQeKRbsurbKdJvjstp5v1bP7swH
 bR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827539; x=1701432339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KBtRS9rXbG5xbiUaGd4Om2KDFww1AXus+neXP9XVFqw=;
 b=CYgA9qRLD5eLxz6GxsHLtIj7c+wZxWVGoXHhHJ2EgXQ4DUfeqfCXbTbCzLpA2N5nuD
 rEMSAbf2PgMk5mg70oofM7RkZ4oMbOGJ3VZOx/NahSAWiw+z6cSblm8eimsMbIMwrpLq
 N5cfm46M5oeo13kqrPgaqaLMVJUUT9E0gOtxpWvVxFGo0Xn1C6BURchHmZUaR2lPO8rN
 tMPmiXJZC21zIoemeYCk6kwUsfdYNwHAOHcnUbxOEM3NSMBtqRb/tyOE9VQ5r6+/4nZ/
 HbJMmKcxG9txSnoyeTH1FPDTizYHZ30kfww8NoRIoTJp5JK45RUVSjnF/OZOOlzRyxJw
 BOhw==
X-Gm-Message-State: AOJu0YxKjtWSNNvXV18t+Z1riADXdpq6RRF5wk5t1a7anrhqAn+awk0b
 Rin4FpQXK92vKtBKWnACYs5esQ==
X-Google-Smtp-Source: AGHT+IGCEzNb5EeZDUXVgy7O5lVuvNkOce2H9Y+Tuxr3RcvnjGY2vMV9B8UigYHk000bLN8G6r08wA==
X-Received: by 2002:a2e:934f:0:b0:2c5:32b:28ea with SMTP id
 m15-20020a2e934f000000b002c5032b28eamr1700773ljh.32.1700827538830; 
 Fri, 24 Nov 2023 04:05:38 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b00332cb23ccbdsm4093327wrt.81.2023.11.24.04.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:05:38 -0800 (PST)
Message-ID: <6cda42c9-b4f2-4f07-b6d8-2a7c12eb7c49@linaro.org>
Date: Fri, 24 Nov 2023 13:05:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 00/21] target/arm: kvm cleanups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 23/11/23 05:41, Richard Henderson wrote:
> This is primarily concerned with merging kvm64.c with kvm.c
> and then unexporting everything that is not required outside.
> 
> r~
> 
> Chao Du (1):
>    target/arm: kvm64: remove a redundant KVM_CAP_SET_GUEST_DEBUG probe
> 
> Richard Henderson (20):
>    accel/kvm: Make kvm_has_guest_debug static
>    target/arm/kvm: Merge kvm_arm_init_debug into kvm_arch_init
>    target/arm/kvm: Move kvm_arm_verify_ext_dabt_pending and unexport
>    target/arm/kvm: Move kvm_arm_copy_hw_debug_data and unexport
>    target/arm/kvm: Move kvm_arm_hw_debug_active and unexport
>    target/arm/kvm: Move kvm_arm_handle_debug and unexport
>    target/arm/kvm: Unexport kvm_arm_{get,put}_virtual_time
>    target/arm/kvm: Inline kvm_arm_steal_time_supported
>    target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport
>    target/arm/kvm: Use a switch for kvm_arm_cpreg_level
>    target/arm/kvm: Move kvm_arm_cpreg_level and unexport
>    target/arm/kvm: Move kvm_arm_reg_syncs_via_cpreg_list and unexport
>    target/arm/kvm: Merge kvm64.c into kvm.c
>    target/arm/kvm: Unexport kvm_arm_vcpu_init
>    target/arm/kvm: Unexport kvm_arm_vcpu_finalize
>    target/arm/kvm: Unexport kvm_arm_init_cpreg_list
>    target/arm/kvm: Init cap_has_inject_serror_esr in kvm_arch_init
>    target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
>    target/arm/kvm: Unexport and tidy kvm_arm_sync_mpstate_to_{kvm,qemu}
>    target/arm/kvm: Unexport kvm_arm_vm_state_change

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


