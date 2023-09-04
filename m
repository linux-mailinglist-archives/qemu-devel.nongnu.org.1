Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7596B7918D4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:42:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9oh-0006OO-Gl; Mon, 04 Sep 2023 09:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd9oY-0006NN-Hx
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd9oU-0003Os-Jn
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693834821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybX7f7bAE82t3NvaDRdD2Bv2sV2dup/rJ1RYllQVyTI=;
 b=TzbYwjEqCNIZZWSud5trCCiebrf3jc8bR/JNrK7SYVlg4l8D7RqsHKD5uRHXNDTkWtCfaY
 yfnqwCPmWvkv82mtVPyY3GReRdPWEGPgd/S+Yr9s3llXe/VJf0fT0G/eGWsxAK/QixBEqo
 yPcojAvUoDqUnpxzJTCm1pqE9caYhLM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Ha-zXdFLN2y343q18sWUWw-1; Mon, 04 Sep 2023 09:40:17 -0400
X-MC-Unique: Ha-zXdFLN2y343q18sWUWw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500ac71f353so1523966e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693834816; x=1694439616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybX7f7bAE82t3NvaDRdD2Bv2sV2dup/rJ1RYllQVyTI=;
 b=EwqjHdLOUwEietj7EN/cpDajgo+K2T2QA10DbHXXvm3Mkl99bj9OQju8V8uANXVG2Z
 FSV5GQAZmw4U1jFi+7wDdI1zqCvSXV+nCwS1F0TJpqN7ChPCZEWuiTXNaNLiS2Q73UEy
 Aoh2kT82+tCmCBQ+SSYb1JB2rpVgvJV+IFlQWpWShrGp281VLsaJfddX1st70lU0wwmQ
 jBWhD0vZf7/Dr7DxEvmRx3TjH2xhudmoo27XUEPYmhpaxso4WPajPRS6SvMrijfsMZSn
 pWtBAYOd6zcdDEuZgkSmoL/MBdDCndAaez+XiIlPz+bPglQiLRFcZuebFvEzprY/8wRG
 p5CA==
X-Gm-Message-State: AOJu0YxPb+V+iHFCMXG2CQ4yWsULouLmwLH0TtuMdJvM4yT5w7S/K9zc
 rSJF0cFL5pjjDMA7uNKXB9I/YdbBUqS8G/uFkrr74QiJeqdwJA2zNEkrVE8fz6/Wb6w/zCLii6C
 7O+63G2rDMirSDqQ=
X-Received: by 2002:a19:761a:0:b0:500:a368:a962 with SMTP id
 c26-20020a19761a000000b00500a368a962mr5727649lff.43.1693834816043; 
 Mon, 04 Sep 2023 06:40:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2/XtxuVlxB4/EWyheU+X5EwxV5jHkgwv144yyWkMy25vIixUm43Z48pPaZRSoxXwX4P36TA==
X-Received: by 2002:a19:761a:0:b0:500:a368:a962 with SMTP id
 c26-20020a19761a000000b00500a368a962mr5727636lff.43.1693834815650; 
 Mon, 04 Sep 2023 06:40:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 n10-20020adffe0a000000b003140f47224csm14482451wrr.15.2023.09.04.06.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:40:14 -0700 (PDT)
Message-ID: <4b7bb33a-625d-5ad4-2110-c575b173aad9@redhat.com>
Date: Mon, 4 Sep 2023 15:40:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/13] target/i386: Allow elision of kvm_enable_x2apic()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, kvm@vger.kernel.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230904124325.79040-1-philmd@linaro.org>
 <20230904124325.79040-8-philmd@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230904124325.79040-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/4/23 14:43, Philippe Mathieu-Daudé wrote:
> Call kvm_enabled() before kvm_enable_x2apic() to
> let the compiler elide its call.
> 
> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/intel_iommu.c      | 2 +-
>   hw/i386/x86.c              | 2 +-
>   target/i386/kvm/kvm-stub.c | 7 -------
>   3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3ca71df369..c9961ef752 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4053,7 +4053,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>               error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
>               return false;
>           }
> -        if (!kvm_enable_x2apic()) {
> +        if (kvm_enabled() && !kvm_enable_x2apic()) {
>               error_setg(errp, "eim=on requires support on the KVM side"
>                                "(X2APIC_API, first shipped in v4.7)");
>               return false;
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index a88a126123..d2920af792 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -136,7 +136,7 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>        * With KVM's in-kernel lapic: only if X2APIC API is enabled.
>        */
>       if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
> -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
> +        kvm_enabled() && (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {

This "!xen && kvm" expression can be simplified.

I am queuing the series with this squashed in:

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d2920af792d..3e86cf3060f 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -129,14 +129,11 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
                                                        ms->smp.max_cpus - 1) + 1;
  
      /*
-     * Can we support APIC ID 255 or higher?
-     *
-     * Under Xen: yes.
-     * With userspace emulated lapic: no
-     * With KVM's in-kernel lapic: only if X2APIC API is enabled.
+     * Can we support APIC ID 255 or higher?  With KVM, that requires
+     * both in-kernel lapic and X2APIC userspace API.
       */
-    if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
-        kvm_enabled() && (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
+    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
+        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
          error_report("current -smp configuration requires kernel "
                       "irqchip and X2APIC API support.");
          exit(EXIT_FAILURE);

Paolo

>           error_report("current -smp configuration requires kernel "
>                        "irqchip and X2APIC API support.");
>           exit(EXIT_FAILURE);
> diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
> index f985d9a1d3..62cccebee4 100644
> --- a/target/i386/kvm/kvm-stub.c
> +++ b/target/i386/kvm/kvm-stub.c
> @@ -12,13 +12,6 @@
>   #include "qemu/osdep.h"
>   #include "kvm_i386.h"
>   
> -#ifndef __OPTIMIZE__
> -bool kvm_enable_x2apic(void)
> -{
> -    return false;
> -}
> -#endif
> -
>   bool kvm_hv_vpindex_settable(void)
>   {
>       return false;


