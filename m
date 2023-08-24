Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C067873C5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZC17-000371-Fl; Thu, 24 Aug 2023 11:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZC0z-00036X-AN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:12:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZC0v-0008Qt-BY
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:12:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3ff5ddb4329so6566235e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692889965; x=1693494765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G7+9BpK2fShduHjghA/ZKiihrZ2bWBIYEE13nJcm3R8=;
 b=xvQM6gc7kcdfZAC6NwiAlDKiImRXnnMRn8fByIPep1LMJI+u/Ox0NDGzTV6Vo2CBjR
 vzhjRVX1zZIyykjnFFQ+dNwBsMQQHPOMliirvbuoByJD55j8L2KnTww6F5RUedsqX79q
 N+bSaYHmGKBzFRQc93lLQab2ER4JUWiZAy/un5QMl87ZsWWeoilLfv3Px1n7YIvjWjiW
 3lWmDbAo2BrlEEIY1p70L7zxBvIu3tYm51JMxDq09CbhBu6UubzU3bJHxsmaqI1o7ABE
 jsz/IrTyePEfPcBiCxDCPUYNl6CcAgoS1maHs/1jQyO6eHP4/BT7LVX02yiCp55laRuQ
 mbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692889965; x=1693494765;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G7+9BpK2fShduHjghA/ZKiihrZ2bWBIYEE13nJcm3R8=;
 b=TdIgtA5l2VlqNxOpx8awRoQ/kcv2dLrP3mjzChsp/veUv+oUDHJOZ5aA4FeqGUxuVB
 jmBWUY+vWfQKJyIRqEc58BKPuv4ILXxKR50wVRIgqFpLww9wp+l/Uc7hz4OBc9sU/Kg6
 gOteNbwYKV5o7hlIDy4/LYbMrx7oRp29wsbcJpyEGMGw4Sm9C7BMnQ5v5VcnbKcqqjPd
 BEXhJJgNidDGDC+ybeg3J1272bbqfVBbWO54qduPfEhhuGDVgf46CalGlY7P4N8p46Wx
 jvVaFONnaiC8FnbHlgHMjyhWrmtejJ35OkQ2gT1malc/inw1wODi8xZ4fJOQFZ5ud1vt
 xfzA==
X-Gm-Message-State: AOJu0Yz2Xgn3YZFNE72Nm5HjoEdI5mjggprt1679IU6471lZjJkj1VWG
 qqqmn7rXVFtiasTVYsl2jN+Pqkm2PU4rWY2HniI=
X-Google-Smtp-Source: AGHT+IFa65U7ghR3RB/dgKsorvFMCsi02ps46/EwSCp7f+fgwGcinbEiA6xoOwOYDvsnf5QbMPWiOQ==
X-Received: by 2002:adf:cd01:0:b0:316:f4b9:a952 with SMTP id
 w1-20020adfcd01000000b00316f4b9a952mr14126142wrm.31.1692889965372; 
 Thu, 24 Aug 2023 08:12:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d4204000000b0031c5dda3aedsm10273531wrq.95.2023.08.24.08.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:12:45 -0700 (PDT)
Message-ID: <26d1e42b-3522-7a8a-1529-1067186e81d5@linaro.org>
Date: Thu, 24 Aug 2023 17:12:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] target/i386: Fix duplicated feature name in FEAT_KVM
Content-Language: en-US
To: Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230824135710.343175-1-twiederh@redhat.com>
 <20230824135710.343175-4-twiederh@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824135710.343175-4-twiederh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/8/23 15:57, Tim Wiederhake wrote:
> The mistake became apparent as there were two features with the same name
> in this cpuid leaf. The names are now in line with the documentation from
> https://kernel.org/doc/html/latest/virt/kvm/x86/cpuid.html
> 

Fixes: 642258c6c7 ("kvm: add kvmclock to its second bit")
?

> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0b74d80371..ceb291f8a8 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -852,7 +852,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>       [FEAT_KVM] = {
>           .type = CPUID_FEATURE_WORD,
>           .feat_names = {
> -            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
> +            "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock2",
>               "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
>               NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
>               "kvm-poll-control", "kvm-pv-sched-yield", "kvm-asyncpf-int", "kvm-msi-ext-dest-id",


