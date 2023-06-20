Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBFB737134
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdwJ-0004SK-Iz; Tue, 20 Jun 2023 12:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdwG-0004Rv-95
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:10:41 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdwD-0001sj-4K
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:10:39 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b466744368so52346991fa.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687277426; x=1689869426;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kg5f28StkxYB7qw5EtF0u4dsTVGSLQjAudZoRVEluNY=;
 b=kAuz9Hfsg4/dHofSXJ29luc7DO4/HNwL5jljBOvGTrUpt2d2c3kiTP9JGv52W2UOtb
 hCh61cm0As5/Tjxx2F6AGO64yR4IlHicmCEsXSip5FDT6KpFRYxeNi7pKVZtJaty6737
 tqlZyaVRIKBBTXlq5gHzAXiS3c3DBUgdrnkmZY7yv4RQ0sj0Sd6X3JqGoHK9F+4HseyV
 BM31Ng0NnPWeJ3dk7+QipzYFdm3i7PH+njKsEKq+lhVBfxRBzjKdiSE3U2ZrvSTU9ovj
 P3rJ0vu0gnTOtJ+nZuVbTykWSDipJ3wsCTBjj2qbS0ctB//pr+iBINW0Zl9dqWUFWgSL
 nuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687277426; x=1689869426;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kg5f28StkxYB7qw5EtF0u4dsTVGSLQjAudZoRVEluNY=;
 b=ihlZXJkwSsac4YsjUZbGNhEs0BYYpeHDSjKsgQC43DarGnGklY+5ChQI2bPoYp1Id1
 53elLXvkeWmoZX1KlpMtsEWlSw411ALVgeTKfseNWQd0k3o6x+/KCaMCQmtwSltH5j3z
 XyyBC1HB3pVwlXAM8wXjG+KlA7RxY2i03ImPeswhI8PN9uGgCj9oUUcGReBYwuD/MddB
 tKA1tCOgXQy56ZQ4uEWBrpy9OsY7CvyYw9ktVBJGngjOgRbt6a5eFdaog47Qfwu/ehDT
 EKe+cyPAY7nNruBdAxOnrYHIfuw2pYwWxvjss2IRhHZ4C5YrhhLqR9s0Y0ZeQ6PVCUuO
 u94g==
X-Gm-Message-State: AC+VfDxMfaNElQ5DYlzd7TLrwDgOEyjswiEqfn5ekYFv8y5mF5Zd0j85
 p1UYe+YZ3KKMetqmRlNha2DoEA==
X-Google-Smtp-Source: ACHHUZ7yKJuZAkzQfUTbOroP240nLH6Q63WobrQ5gtUGCAxqsDnLD/1m99dG83ZVDn0nh2xSDC4HYA==
X-Received: by 2002:a2e:80c9:0:b0:2b1:e6eb:1ba2 with SMTP id
 r9-20020a2e80c9000000b002b1e6eb1ba2mr8951130ljg.22.1687277426389; 
 Tue, 20 Jun 2023 09:10:26 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 o5-20020aa7c505000000b0051879590e06sm1414833edq.24.2023.06.20.09.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 09:10:26 -0700 (PDT)
Message-ID: <97cf0a1f-86c6-6bd3-5643-4982a5db03bb@linaro.org>
Date: Tue, 20 Jun 2023 18:10:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/10] target/i386: implement 32-bit SYSCALL for
 linux-user
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
 <20230620151634.21053-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620151634.21053-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

On 6/20/23 17:16, Paolo Bonzini wrote:
> @@ -211,6 +211,9 @@ void cpu_loop(CPUX86State *env)
>  
>          switch(trapnr) {
>          case 0x80:
> +#ifdef TARGET_ABI32
> +        case EXCP_SYSCALL:
> +#endif
>              /* linux syscall from int $0x80 */

ABI32 includes x32.
I think you want TARGET_I386.

> +#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX_USER
> +#define TCG_EXT2_NOBSD_FEATURES CPUID_EXT2_SYSCALL
> +#else
> +#define TCG_EXT2_NOBSD_FEATURES 0
> +#endif

Missing TARGET_I386 test per above.
Better named TCG_EXT2_USERONLY_FEATURES.

Warner, if I'm reading freebsd-src correctly, sys/x86 (aka 32-bit) does not use 
sysenter/sysret?  I only see that under sys/amd64 (where fast_syscall32 is a cya nop).


r~

