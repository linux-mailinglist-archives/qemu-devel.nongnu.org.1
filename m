Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8067F7364
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 13:06:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UwV-0007jU-AF; Fri, 24 Nov 2023 07:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Uvs-0007Kq-0f
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:05:17 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6Uvp-0008GW-Dq
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 07:05:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so2376322e87.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 04:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700827510; x=1701432310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02VHxxyVfJLwPmySCDAydN8jj8JkgVACzvTPcrsU5IM=;
 b=TAokiu9RlLp1PJQE9YZW8aGQOfLS5H70K6/EvfdzctmvwHRsrAksY/Qcobc4fnDwCe
 G81nMGk0mbhrZMIUO979cT2jO4s7+m1cUSKV7biNmcNdo0NFy8OImMruFFsz1863vdyt
 Ts3pH9ZIv/rWUiXz6OOWqnWwwuxgONyoBJHc65fhVD8ds8qYG4E4eYC92uZ9+XpJ8MrY
 DkGhxu2JE7mKIl6DbLwcSQdXrRrZ5tNI9R6ZL/y/QRp5rKk216eXL6S3ECkZfrK0mO3I
 J+SCt5vHIpJYldnQNvp2ZDnoL+s4ibz243t+mc2W/u1QSjLeqfSK+XrgkgHttCouL1dA
 mtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827510; x=1701432310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02VHxxyVfJLwPmySCDAydN8jj8JkgVACzvTPcrsU5IM=;
 b=uydTA9k4NC/PEJHGR9Hj3jI3+trkTVSGdC1bwsUH7FtVKxXQO6tqy/E+YYruJV0URN
 1jRDoovUyQwlpmcqItuYhKNo+Fmr6QaAy64L6pgklNXyDWboLSSZBr14p0dQHU5ul+Eo
 H2y4i/37h+eEXi6bobbMAoYDW6a1q/tJ1yqeO+9BRnbcBCz7XDhq/rRNnGHr33jsYrb+
 FHC1iTIxhMYqlPNiD0eHgfpN+T2mS8EWaFwRSR2KEPa0tiqJyMmI6Gt6bcUi/NLjs+t6
 hBqO9nnxGECT9ATov8UOTlrQ0IdBl1kaPDjx7ARCFB+2zJ5tPe95CR0x+WCm7e6F4lK8
 11tA==
X-Gm-Message-State: AOJu0YyBAnEaXqjtWOmieUYvWuEKxTZEWqXpMmLhN7r2fXEt8k+qglZV
 uH80XFe/oM/KK0RXYuZy8kE8Rg==
X-Google-Smtp-Source: AGHT+IHRR4Xk1FFQ2VajEm87zK5G9NNvFEDkNIKaKbe4FyOI8BQV+AGRMZDuPR+0QXyBt4d9+cUOTw==
X-Received: by 2002:a05:6512:1581:b0:50a:2721:a43d with SMTP id
 bp1-20020a056512158100b0050a2721a43dmr2229559lfb.49.1700827509730; 
 Fri, 24 Nov 2023 04:05:09 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b00332cb23ccbdsm4093327wrt.81.2023.11.24.04.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 04:05:09 -0800 (PST)
Message-ID: <db8f1d15-121c-4597-8f04-15661c7eaa3b@linaro.org>
Date: Fri, 24 Nov 2023 13:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Drop fprintfs and actually use the return values in the callers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 20 --------------------
>   target/arm/kvm.c     | 23 ++++++-----------------
>   2 files changed, 6 insertions(+), 37 deletions(-)


>   /*
>    * Sync the KVM MP_STATE into QEMU
>    */
> -int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
> +static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
>   {
>       if (cap_has_mp_state) {
>           struct kvm_mp_state mp_state;
>           int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
>           if (ret) {
> -            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
> -                    __func__, ret, strerror(-ret));
> -            abort();

I suppose if this abort() had fired, we'd have reworked that code...
Maybe mention its removal? Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +            return ret;
>           }
>           cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
>               PSCI_OFF : PSCI_ON;
>       }
> -
>       return 0;
>   }

