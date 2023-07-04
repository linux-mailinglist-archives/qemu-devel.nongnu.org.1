Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1A6747536
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:22:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhqT-0000Dw-Ir; Tue, 04 Jul 2023 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhqQ-0000C6-B9
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:21:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhqO-0001oX-Kn
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:21:34 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso32814195e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688484090; x=1691076090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gbS8ou3K3WgLGLWO7F6RM3pjaHqkGe6mRJLuqkjTdNw=;
 b=SB+MMuLkgrZNh/Dd0t8m3Ngtt8j4VfZrJL3WjI9nFv9VPTg30LbfSgGaH23eWn6aUM
 IxNmEzL8S9sM7RgoVPWXDpJwnwBu1hGkVEjdIpFD+sqbibFbgiKRGX4/KoaODEonYB0c
 Edu6Hm0Si1Azme3sO+KnRarOaeZjg+Kxi7/wANoQye+336MUZbhOksgI7D8KK/rqcx+D
 j0NSY9kkVq4cIQMP/c3FtachzlG/mU3HfF/AdI9y6RvVN5+ydGsUzQZv3CgGDPDu4Ezz
 DIOX2xaoabk+Io42GBK9cRVdnLHpO5XLKgxSl9mNYhPLEKyukGlKtQDorYg9XP3cc8vz
 M6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688484090; x=1691076090;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbS8ou3K3WgLGLWO7F6RM3pjaHqkGe6mRJLuqkjTdNw=;
 b=jTGd885NEkGCn0Zo8saG1cA/a+9+ntmVAPKzYLirpL8lWUlC05o2STg6bCjzzjUf+U
 pRCVyVkdOe+dMFLJHl+bEquo7FThOOFa6zq2LK2CN4QpktWq1nwmUptq9sZ4AtzsigCw
 CqFt9vj7eT5fPCIg3XwqHHAyNno+ERYJ9qtn4fuZESaO6CfuvCriSSlJCaA4WjKMMF2r
 IxDTjJ/Xpvkm+wYSuwUwXLMA1bM7IBbvjRAXhbZjuvdJp1h1PA01ztA/VMFvr/vHoINp
 fuaadL/i4sYWiTy0gIdpy6xgwnaSdw6YUoWT+gZEG0+zKl0cW8/VNB1UkUhYadPEJDs1
 USkQ==
X-Gm-Message-State: ABy/qLaKxUXEoevznASjBanRJCxGpyNLh4PPV46rdqwyAs0KT/bs9PDF
 hjqiYP4hzW2N4T1xeK/dPF4VXA==
X-Google-Smtp-Source: APBJJlHA27KbpP0zR3jM+eem/Uio0QiPoKZyYoA/bhJbWS2dqDO9P+5SLAMNHH3J+u23ODidP8rL0Q==
X-Received: by 2002:a05:600c:2041:b0:3fb:e189:3535 with SMTP id
 p1-20020a05600c204100b003fbe1893535mr1859439wmg.27.1688484090473; 
 Tue, 04 Jul 2023 08:21:30 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 c9-20020adfe749000000b0031416362e23sm14362382wrn.3.2023.07.04.08.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:21:30 -0700 (PDT)
Message-ID: <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
Date: Tue, 4 Jul 2023 17:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230628164821.16771-1-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628164821.16771-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 28/6/23 18:48, Fabiano Rosas wrote:
> This code is only relevant when TCG is present in the build. Building
> with --disable-tcg --enable-xen on an x86 host we get:
> 
> $ ../configure --target-list=x86_64-softmmu,aarch64-softmmu --disable-tcg --enable-xen
> $ make -j$(nproc)
> ...
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `m_sysreg_ptr':
>   ../target/arm/gdbstub.c:358: undefined reference to `arm_v7m_get_sp_ptr'
>   ../target/arm/gdbstub.c:361: undefined reference to `arm_v7m_get_sp_ptr'
> 
> libqemu-aarch64-softmmu.fa.p/target_arm_gdbstub.c.o: in function `arm_gdb_get_m_systemreg':
> ../target/arm/gdbstub.c:405: undefined reference to `arm_v7m_mrs_control'
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> This is a respin of:
> https://lore.kernel.org/r/20230313151058.19645-5-farosas@suse.de
> ---
>   target/arm/gdbstub.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 03b17c814f..f421c5d041 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -324,6 +324,7 @@ static int arm_gen_dynamic_sysreg_xml(CPUState *cs, int base_reg)
>       return cpu->dyn_sysreg_xml.num;
>   }
>   
> +#ifdef CONFIG_TCG

OK.

>   typedef enum {
>       M_SYSREG_MSP,
>       M_SYSREG_PSP,
> @@ -481,6 +482,7 @@ static int arm_gen_dynamic_m_secextreg_xml(CPUState *cs, int orig_base_reg)
>       return cpu->dyn_m_secextreg_xml.num;
>   }
>   #endif
> +#endif /* CONFIG_TCG */
>   
>   const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
>   {
> @@ -561,6 +563,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>                                arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
>                                "system-registers.xml", 0);
>   
> +#ifdef CONFIG_TCG

IIUC tcg_enabled(), this guard shouldn't be necessary; if CONFIG_TCG
is not defined, tcg_enabled() evaluates to 0, and the compiler should
elide the whole block.

>       if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) {
>           gdb_register_coprocessor(cs,
>               arm_gdb_get_m_systemreg, arm_gdb_set_m_systemreg,
> @@ -575,4 +578,5 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>           }
>   #endif
>       }
> +#endif /* CONFIG_TCG */
>   }


