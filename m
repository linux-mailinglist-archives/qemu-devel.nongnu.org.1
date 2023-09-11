Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BA079A965
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiUS-0002S8-Mt; Mon, 11 Sep 2023 11:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiUQ-0002PF-M5
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:06:14 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfiUD-0004Fg-Oi
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:06:14 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-501bef6e0d3so7546877e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694444759; x=1695049559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7LOky8NcfwGAuWJ42oVUPUIAPebXa+3JQ/Lqf8kx4w=;
 b=nFryXTAZGgSVi6BiCFNR5a4uH63KFNYs09U0WmhstYLoc06KYEwRgyYKaCTRGFSyGZ
 zTcdppthpz3S/IwNMx3zx9HaWNrNaR4JtIrB//P6gL0Ww2oBdcB1dY46hQzYJ8hRkfYH
 srZ4ZTHIAeZAhfScv37bUeVEiFtIGnNpO7jxZyz+4Fa73k7MHcwCWt5mDmJx3ENYBc5u
 SlBFjLyJ3I5HRxkbQQ0cHZ+D9de7WCCsqVXWaiA8QwG3Z8SlDMBtSnPUraxTVrU96oBU
 bybb9kzjNk/S0I5q8k/IW/504mmiPKwbZIxamvKMqRoKek9MRyUnmVzjgtX5IrALsfF+
 WyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694444759; x=1695049559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7LOky8NcfwGAuWJ42oVUPUIAPebXa+3JQ/Lqf8kx4w=;
 b=Gx/uPSwMuI1FG7IudeopO6NOnKERxe3nHgQV28HmcRb6zmeYNed3oUphxCxcUTGiq1
 1iCtoqFHPhndHAflEWuaNoHYWdeNQXYov2WfRQcual9itdt5np0KmIfEhIc5rzwMEhJR
 gKJbmIwJ7DBrNOlrLNohbaSDThuFsFBnbZ2QN1aliTLiLaw0nDLo37oGfrBDBFuwUXLl
 DcYL5Fc7gFUgMsiDU2ozPHNZf75uj00rA1BESEabWkeUFjwL7EdEh/R9WmVpIvDT+aLL
 bdhkpiaqQKGYQO9mh/qnzO5QkpKn83PRQK/5ecTGCDVNLMausEGoWFcBh6YfxjWN5iKC
 W+ag==
X-Gm-Message-State: AOJu0YyT4Jb+DrexUwWGSPde9bq32X4liDN+/6Y8XjtpYMrn5aaQYT/2
 ktod31aKnATwYOH1GmHd9dDASdheu91C5pK4GLA=
X-Google-Smtp-Source: AGHT+IEVB7SD5N85FLnF+qJrO5y4IE9g1kgV5jAopR4fDmyrLrWsbkmRNOsP57hOIZK40pf28RltuQ==
X-Received: by 2002:a05:6512:2212:b0:4fe:db6:cb41 with SMTP id
 h18-20020a056512221200b004fe0db6cb41mr9127047lfu.39.1694444758877; 
 Mon, 11 Sep 2023 08:05:58 -0700 (PDT)
Received: from [192.168.69.115] (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 g2-20020a50ee02000000b0051e2670d599sm4759103eds.4.2023.09.11.08.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 08:05:58 -0700 (PDT)
Message-ID: <28c832bc-2fbf-8caa-e141-51288fc0d544@linaro.org>
Date: Mon, 11 Sep 2023 17:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] target/i386: Re-introduce few KVM stubs for Clang
 debug builds
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230911131507.24943-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911131507.24943-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/9/23 15:15, Philippe Mathieu-Daudé wrote:
> Since commits 3adce820cf..ef1cf6890f, When building on
> a x86 host configured as:
> 
>    $ ./configure --cc=clang \
>      --target-list=x86_64-linux-user,x86_64-softmmu \
>      --enable-debug
> 
> we get:
> 
>    [71/71] Linking target qemu-x86_64
>    FAILED: qemu-x86_64
>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>    cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>    cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get_supported_cpuid'
>    /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' follow
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
>    ninja: build stopped: subcommand failed.
> 
> '--enable-debug' disables optimizations (CFLAGS=-O0).
> 
> While at this (un)optimization level GCC eliminate the
> following dead code:
> 
>    if (0 && foo()) {
>        ...
>    }
> 
> Clang does not. This was previously documented in commit 2140cfa51d
> ("i386: Fix build by providing stub kvm_arch_get_supported_cpuid()").
> 
> Fix by partially reverting those commits, restoring a pair of stubs
> for the unoptimized Clang builds.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
> Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/kvm/kvm-stub.c  | 31 +++++++++++++++++++++++++++++++
>   target/i386/kvm/meson.build |  2 ++
>   2 files changed, 33 insertions(+)
>   create mode 100644 target/i386/kvm/kvm-stub.c

Patch superseded, see v3:
https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.org/

