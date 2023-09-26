Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD97AF0A1
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAr1-0007WR-Op; Tue, 26 Sep 2023 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAqy-0007WG-EP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:24:04 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qlAqv-000620-92
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:24:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c4194f769fso66393655ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695745439; x=1696350239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=him49Q7t8XPMtZfHMBO5Yopc3ogYerfAu1hPHjG2CMw=;
 b=ITJyqZESYS6snZjelizWuEUv7YIvPE6DX2OqKxolKpot5IUZB9Z5lnMhkt2Ulmwcaj
 ui3Jgt9zLI7jnm/J31smJQJ9LmjR4L0lck/bkYgb/xH69s9vE9Z4DoBa/1aE50WdTGsr
 0HsnVOv9x2IW5mDPJv8BLBN8dW+YaZRGucWo3REIeQ+wknt9xVdHmO/sX4blIiJ9l6lm
 MJr8XtKVpFJY6fWZbAD7LqCAcLjuswBU4jx5rknIdpTXn8D7CX28b9JXNoO8mDfuU+8E
 PqK7ATEMFBqs3Q0WcOgedl7BzsN3VWlhXN4bCCuPGrYH1YWWlL1CN4zRDfnIcEw8mrtX
 31Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695745439; x=1696350239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=him49Q7t8XPMtZfHMBO5Yopc3ogYerfAu1hPHjG2CMw=;
 b=CldsIcZOVQYNxbFbcVwO+zfG0xRB+tTHkOveenVYEUBlL6RJF1rX80xk8K4AfGZMR8
 IsPv5stynkl0CTohynn7JJ+iHL59XPGNh/kXxUMtfB/pLvDZ9Jm4irOthHRLDBXp0Phe
 KHHTomgtHz2SkfJ8AUFsb+iLtvsEJXUUV/BjG3c8uX+0JVS/wcEXbCntxfhqr9C9LP6t
 KbMvMMUnRgSPWTo5KjKKnIkeJhArU65ti0Ft2bdOzaGxcxRschZHt6Ex04l1VrHx6mFg
 rcltlbYRyqfst8krRGYBiMAUHjq0RXePpgTaoxBLeYI+p+xQzHdmoQAZGfRNgpgmY/nn
 Pr9g==
X-Gm-Message-State: AOJu0YyLZdxjkjZPZ8QnKN2JUVkycoXrBoOjcWbu2/haHYypEyw9ZDkX
 5aAvDun1dWxFpkyDZIq/kNOZrvCNt2HE9A==
X-Google-Smtp-Source: AGHT+IHiIoE8SIuLTigBoyacP/MsjbrMAqVFK7wPqYxOn+eNhPNjWpPW4xvParwHPCsQzdiKRRCrxg==
X-Received: by 2002:a17:902:7798:b0:1c0:aca0:8c44 with SMTP id
 o24-20020a170902779800b001c0aca08c44mr7588966pll.19.1695745439349; 
 Tue, 26 Sep 2023 09:23:59 -0700 (PDT)
Received: from ?IPV6:2001:ee0:50f4:9050:2173:954b:298f:df36?
 ([2001:ee0:50f4:9050:2173:954b:298f:df36])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001bb99ea5d02sm11242652pli.4.2023.09.26.09.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 09:23:58 -0700 (PDT)
Message-ID: <1e402165-24bd-7380-a5a7-c32fe33e457d@gmail.com>
Date: Tue, 26 Sep 2023 23:23:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 0/5] Support x2APIC mode with TCG accelerator
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230926160637.27995-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230926160637.27995-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-1.473,
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

On 9/26/23 23:06, Bui Quang Minh wrote:

> Version 8 changes,
> - Patch 2, 4:
>    + Rebase to master and resolve conflicts in these 2 patches

The conflicts when rebasing is due to the commit 9926cf34de5fa15da 
("target/i386: Allow elision of kvm_enable_x2apic()"). AFAIK, this 
commit adds kvm_enabled() before kvm_enable_x2apic() in the and (&&) 
expression so that when kvm_enabled() is known to be false at the 
compile time (CONFIG_KVM_IS_POSSIBLE is undefined), the compiler can 
omit the kvm_enable_x2apic() in the and expression.

In patch 2, I simply combine the change logic in patch 2 with logic in 
the commit 9926cf34de5fa15da.

In patch 4, the end result of version 8 is the same as version 7. I 
don't think we need to add the kvm_enabled() to make the expression become

	if (kvm_enabled() && kvm_irqchip_is_split() && !kvm_enable_x2apic())

Because when CONFIG_KVM_IS_POSSIBLE is undefined, kvm_irqchip_is_split() 
is known to be false at the compile time too so just keep the expression as

	if (kvm_irqchip_is_split() && !kvm_enable_x2apic())

is enough.

 > git range-diff feat/tcg-x2apic-v7~5..feat/tcg-x2apic-v7 
feat/tcg-x2apic-v8~5..feat/tcg-x2apic-v8

1:  c1d197a230 = 1:  f6e3918e0f i386/tcg: implement x2APIC registers MSR 
access
2:  dd96cb0238 ! 2:  54d44a15b6 apic: add support for x2APIC mode
     @@ Commit message

       ## hw/i386/x86.c ##
      @@ hw/i386/x86.c: void x86_cpus_init(X86MachineState *x86ms, int 
default_cpu_version)
     -      * Can we support APIC ID 255 or higher?
     -      *
     -      * Under Xen: yes.
     --     * With userspace emulated lapic: no
     -+     * With userspace emulated lapic: checked later in 
apic_common_set_id.
     -      * With KVM's in-kernel lapic: only if X2APIC API is enabled.
     +      * both in-kernel lapic and X2APIC userspace API.
            */
     -     if (x86ms->apic_id_limit > 255 && !xen_enabled() &&
     +     if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
      -        (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
      +        kvm_irqchip_in_kernel() && !kvm_enable_x2apic()) {
               error_report("current -smp configuration requires kernel "
3:  31a5c555a6 = 3:  eb080d1e2c apic, i386/tcg: add x2apic transitions
4:  d78b5c43b4 ! 4:  59f028f119 intel_iommu: allow Extended Interrupt 
Mode when using userspace APIC
     @@ hw/i386/intel_iommu.c: static bool 
vtd_decide_config(IntelIOMMUState *s, Error *
      -            error_setg(errp, "eim=on requires 
accel=kvm,kernel-irqchip=split");
      -            return false;
      -        }
     --        if (!kvm_enable_x2apic()) {
     +-        if (kvm_enabled() && !kvm_enable_x2apic()) {
      +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
                   error_setg(errp, "eim=on requires support on the KVM 
side"
                                    "(X2APIC_API, first shipped in v4.7)");
5:  51f558035d = 5:  bc95c3cb60 amd_iommu: report x2APIC support to the 
operating system

As the change is minor and does not change the main logic, I keep the 
Reviewed-by and Acked-by tags.

Thank you,
Quang Minh.

