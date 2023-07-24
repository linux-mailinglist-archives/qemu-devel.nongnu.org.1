Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDCC75F3EE
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNtBq-0006fb-Lh; Mon, 24 Jul 2023 06:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNtBm-0006dA-U1
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:53:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qNtBk-0001Yv-BY
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:53:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31743dbf13eso1013465f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690195994; x=1690800794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=72Vxid4lPGFAPqcNotszz48/hXCNrAO2F4A+SW1VaR4=;
 b=sQOBzZctSBnZ7py40vFsg1unHyBQ9XXalIA/kbqy75KmENsrvk93LxUJ+U29RWg1d4
 xbcitWnMCF0PJpsSerM3TbONu3AK3V7XuvbCUVocEukr4E6aTKshGm4weE6UStiXiHbd
 qFWGlgWo1QwQTjYiwuhMrbIZVYY1ZmaX2CRS/WKKarToYsWIAp1lX2JA73o5ff1Wys/0
 GIelBcTNJRJcEQ4MVFZjZ8L5iSAO8ujPvr4FaTB/QSqpo2clAsf3Dy2OdjLt4mxz8e+U
 /yFLgQTHantouv6/oDPS30wN1cmuqrERK8KddLJeAc8XALVdhzin57D5oiwWwZO56Icu
 jbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690195994; x=1690800794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=72Vxid4lPGFAPqcNotszz48/hXCNrAO2F4A+SW1VaR4=;
 b=iacKXFwYaCqdE0tuZ/MGA+pXeymp7Dvzji2xIb6Uuaq7rNeQkIm/DT/JTt/Enst8Pp
 HrbJefNU7c+Ffob5Ye3fgXRufRqmTXcDoWPWIFpcJFoN84ooSa8KmReOj/mTEoadj2j5
 vXtcbiD2kwNzKOWtAcdkfE7yyogNf/MQ4ysTI/6kqDL9U4zbQTS/WzzcT6KomWbfQQZS
 2NwiN2EBiU12OmNknE510+Mv4jkGwpk+G3YsaLwm6GLCToCF84n+rmOfrWfSazgwN7wZ
 K/A+ndzfjTlHcGo6UfkpxFmFtQQ8Z/WZr0PZVGfO9oW6XMs4bNQFpIvT4ANXIo2TMcga
 AuiQ==
X-Gm-Message-State: ABy/qLYGXHBi5AVvJGOP1MEBh67JM5E8WNbBp885+M7K+xupo3jeqNkN
 Lq2T/78Vn0Jf/0O18OINq0Nomg==
X-Google-Smtp-Source: APBJJlHzWS1AhRNdK3VZO/1/qUbO0wJi19B0Axc/E2eJFHd2c4kSs0QFE8erw7fzpv/ZsLeSL4Itfg==
X-Received: by 2002:adf:f185:0:b0:317:50b7:2ce3 with SMTP id
 h5-20020adff185000000b0031750b72ce3mr3713517wro.51.1690195993963; 
 Mon, 24 Jul 2023 03:53:13 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.210.255])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adff94d000000b003143c9beeaesm12673051wrr.44.2023.07.24.03.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jul 2023 03:53:13 -0700 (PDT)
Message-ID: <da9bf5ae-a61e-24da-9d17-6cfd8bdaf4b7@linaro.org>
Date: Mon, 24 Jul 2023 12:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] kvm: Introduce kvm_arch_get_default_type hook
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20230722062250.18111-1-akihiko.odaki@daynix.com>
 <20230722062250.18111-2-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230722062250.18111-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 22/7/23 08:22, Akihiko Odaki wrote:
> kvm_arch_get_default_type() returns the default KVM type. This hook is
> particularly useful to derive a KVM type that is valid for "none"
> machine model, which is used by libvirt to probe the availability of
> KVM.
> 
> For MIPS, the existing mips_kvm_type() is reused. This function ensures
> the availability of VZ which is mandatory to use KVM on the current
> QEMU.

Pre-existing: mips_kvm_type() returns -1. Should we check for
'type' in kvm_init() before calling kvm_ioctl()?

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/sysemu/kvm.h     | 2 ++
>   target/mips/kvm_mips.h   | 9 ---------
>   accel/kvm/kvm-all.c      | 4 +++-
>   hw/mips/loongson3_virt.c | 1 -
>   target/arm/kvm.c         | 5 +++++
>   target/i386/kvm/kvm.c    | 5 +++++
>   target/mips/kvm.c        | 2 +-
>   target/ppc/kvm.c         | 5 +++++
>   target/riscv/kvm.c       | 5 +++++
>   target/s390x/kvm/kvm.c   | 5 +++++
>   10 files changed, 31 insertions(+), 12 deletions(-)


