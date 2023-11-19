Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FE7F097F
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 23:55:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4qgr-0007Tx-6e; Sun, 19 Nov 2023 17:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qgp-0007Tf-Ie
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:54:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r4qgo-0002g3-0M
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 17:54:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso9331805e9.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700434492; x=1701039292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hH3FGY+gRiDBbE29BRC2yieIeafm/xNMpFbiUIaQ2NI=;
 b=OXI+NgwKK1V6WUHZx845LxwNcJFC8/MCjL+I+g7J2I+SEkpBp8ydrQVthxX2OtKWb5
 3WUSublhKGQxbnZlBrwVqVinJO7ZzfT8Lmt+F9RGhBkTtR0pR3IGmVkbhNxN4vrtyAXh
 81WXuxkMefwhe8MdDswQofw30IOC2NP9lzSqyCk/F8WP5RvvGsudoo3+DIm3DtJjXahY
 9E2xfom9U5wtSmycFALA/geWDl8hJ0q0Da9std1lFJbdqXAOM/dL6LCA3s5xmKEeHxN/
 a7elvRUyfZFo31yaiph3isjlw0GMDTCdRzo7OuOPyc4t0h/UlDpxCkJifhVoSUTra5AY
 rWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700434492; x=1701039292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hH3FGY+gRiDBbE29BRC2yieIeafm/xNMpFbiUIaQ2NI=;
 b=QA67DsSIU7dTkFIIcM+KN2w/9qyrJdZSPZ+1J5ig+F7IgAVWgL8qmX9iHLPhmB/j05
 /STcFc0hAb29qMzhLByHysts5QYX/5Zg7aH5WeUVimTYMv40U9ck+Bc7lLj3D1hKbZnp
 212U21L9TIQMRxryamsKyS9+/i3VFtUPWxThZsslYxFm90hWlTvlYjpueg8Hlxyd2iIS
 FfigkJp2rjOVZEtrDKvyqKfpUywjeEnufadylJIdSWgpTkR724v/8k7CKZBHQtKCS+MK
 874MgtLEq93KARe6QCrIblabCfofV7C7MiM9HNbhdBD5KJhAd/49xl3Ka7KclZwj6w/G
 AYKA==
X-Gm-Message-State: AOJu0YxmcSZZ/rSXf3GSQdLEJoufic66I7ruu7VJAco63DJDguIoXaqy
 Yy19p2fQaM0Bg6FHumyFEzDLiQ==
X-Google-Smtp-Source: AGHT+IF0mRiI3dn+unvC/E+XLohkuG5HAlmtKtwzYBgMmaLBRSB+r9HClqszayGBxfduudRZ5m3KYA==
X-Received: by 2002:a05:600c:230a:b0:408:37d4:b5ba with SMTP id
 10-20020a05600c230a00b0040837d4b5bamr4772475wmo.12.1700434491537; 
 Sun, 19 Nov 2023 14:54:51 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.133])
 by smtp.gmail.com with ESMTPSA id
 je14-20020a05600c1f8e00b0040596352951sm16039184wmb.5.2023.11.19.14.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 14:54:51 -0800 (PST)
Message-ID: <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
Date: Sun, 19 Nov 2023 23:54:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
Content-Language: en-US
To: Daniel Hoffman <dhoff749@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231119203116.3027230-1-dhoff749@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231119203116.3027230-1-dhoff749@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

On 19/11/23 21:31, Daniel Hoffman wrote:
> `kvm_enabled()` is compiled down to `0` and short-circuit logic is
> used to remove references to undefined symbols at the compile stage.
> Some build configurations with some compilers don't attempt to
> simplify this logic down in some cases (the pattern appears to be
> that the literal false must be the first term) and this was causing
> some builds to emit references to undefined symbols.
> 
> An example of such a configuration is clang 16.0.6 with the following
> configure: ./configure --enable-debug --without-default-features
> --target-list=x86_64-softmmu --enable-tcg-interpreter

Is the '--enable-debug' option triggering this?

I'm surprised the order of conditions matters for code elision...

> Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> ---
>   hw/i386/x86.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index b3d054889bb..2b6291ad8d5 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>       /*
>        * Can we support APIC ID 255 or higher?  With KVM, that requires
>        * both in-kernel lapic and X2APIC userspace API.
> +     *
> +     * kvm_enabled() must go first to ensure that kvm_* references are
> +     * not emitted for the linker to consume (kvm_enabled() is
> +     * a literal `0` in configurations where kvm_* aren't defined)
>        */
> -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
>           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
>           error_report("current -smp configuration requires kernel "
>                        "irqchip and X2APIC API support.");
> @@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>       }
>       cpu->thread_id = topo_ids.smt_id;
>   
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> -        kvm_enabled() && !kvm_hv_vpindex_settable()) {
> +    /*
> +    * kvm_enabled() must go first to ensure that kvm_* references are
> +    * not emitted for the linker to consume (kvm_enabled() is
> +    * a literal `0` in configurations where kvm_* aren't defined)
> +    */
> +    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> +        !kvm_hv_vpindex_settable()) {
>           error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
>           return;
>       }


