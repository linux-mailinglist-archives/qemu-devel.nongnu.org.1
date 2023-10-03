Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968E7B72BD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:50:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmL9-0005zo-In; Tue, 03 Oct 2023 16:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmL7-0005zK-Td
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmL2-00059M-O5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696366190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWwwvluzdeggJ5lCu9JOpBxpSN5MFm5uxg9ILGwF4Co=;
 b=ijclcgGdWDwMauAbyjyAQsQwGNvEyQ24yrKaVlXN+0HmdmeHvlYH3wI3NO0+RoH1yqDFA1
 6LcNKPMnwGfAe/aPXL31RuVhmTdxP1Kk5f3AX6DjvVMx9o9MGB+UvGrV98CEwoskmoRwhg
 uLvUIQJgKoQqEmTDFmVi8HTcGFxrD+I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-S2h0qKdmPW6YPqLF5Eq8KQ-1; Tue, 03 Oct 2023 16:49:39 -0400
X-MC-Unique: S2h0qKdmPW6YPqLF5Eq8KQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7742bd869e4so28213385a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366179; x=1696970979;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWwwvluzdeggJ5lCu9JOpBxpSN5MFm5uxg9ILGwF4Co=;
 b=ZNPs8f+sgkSHJ/d3wLpsytk8I2K7qLtAIxmSRZV1Ou0klTG9VKRDZxvUFNdptxMPID
 vTvz4bwnFtNo6ni1SI0t/EZq9Y3bKed2QnKg9mXMdZLAq1FTY8iUgEfEd+sLSQZXGS6k
 rowoQZaLSazx/U6RRYeGkDTNQAyQejT6dRYFE36F1tKcrqkBL44S0rqrvtCvr6y1/j5i
 I6SaCXxOB6XBDMpsFn9phDnS0e51hCER+Vvc9i9JuZO4Bxs9H9Q6bfykxrVxCYJ0RkSG
 JUB3SGr4pgs/T6i2PNJiTzeVDRcTIOS8SqZ6nt1oYs23pSJ5FCebzOI+lRLd+59PjYzH
 zkLg==
X-Gm-Message-State: AOJu0YywBuJyQHGx2tJtVj4AZum6PgYZCqdScWF9Y5R+GBIJ74NCIg0l
 t/+SJafZZfCo1U37o/eIbz5OtUXESqRLXvL1sGNmmkoh+S4fFGwqF0dZA/cHDrs+iiAXEvp+Idu
 INlZfJuARmMsXzUU=
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr679642qkb.3.1696366178965; 
 Tue, 03 Oct 2023 13:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED/KOctlx6Hbsg4iAm7sJz5n2mQPCP4oljul3lvDdacT9c4iZ23qukkMW03FjlPDSRlAAnsA==
X-Received: by 2002:a05:620a:19a0:b0:76e:f686:cacb with SMTP id
 bm32-20020a05620a19a000b0076ef686cacbmr679631qkb.3.1696366178589; 
 Tue, 03 Oct 2023 13:49:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05620a03d100b00775838e79f8sm738697qkm.134.2023.10.03.13.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:49:38 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:49:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/5] hw/i386/apic: Defer error check from
 apic_get_class to kvm_apic_realize
Message-ID: <ZRx+X8C8+34K4d+q@x1n>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003082728.83496-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 03, 2023 at 10:27:25AM +0200, Philippe Mathieu-Daudé wrote:
> apic_get_class() isn't supposed to fail. kvm_apic_realize() is
> DeviceRealize() handler, which can fail. Defer the error check
> to the latter.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/kvm/apic.c       | 5 +++++
>  target/i386/cpu-sysemu.c | 8 --------
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
> index 1e89ca0899..4883308247 100644
> --- a/hw/i386/kvm/apic.c
> +++ b/hw/i386/kvm/apic.c
> @@ -228,6 +228,11 @@ static void kvm_apic_realize(DeviceState *dev, Error **errp)
>  {
>      APICCommonState *s = APIC_COMMON(dev);
>  
> +    if (!kvm_irqchip_in_kernel()) {
> +        error_setg(errp, "KVM does not support userspace APIC");
> +        return;
> +    }

IMO the code reads a bit weird, that we are already trying to create
kvm-apic even if !kvm_irqchip_in_kernel()..

Would it be better to check this in i386's kvm_arch_irqchip_create()?

> +
>      memory_region_init_io(&s->io_memory, OBJECT(s), &kvm_apic_io_ops, s,
>                            "kvm-apic-msi", APIC_SPACE_SIZE);
>  
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 2375e48178..6a228c9178 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -253,10 +253,6 @@ APICCommonClass *apic_get_class(Error **errp)
>  
>      /* TODO: in-kernel irqchip for hvf */
>      if (kvm_enabled()) {
> -        if (!kvm_irqchip_in_kernel()) {
> -            error_setg(errp, "KVM does not support userspace APIC");
> -            return NULL;
> -        }
>          apic_type = "kvm-apic";
>      } else if (xen_enabled()) {
>          apic_type = "xen-apic";
> @@ -272,10 +268,6 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>      APICCommonState *apic;
>      APICCommonClass *apic_class = apic_get_class(errp);
>  
> -    if (!apic_class) {
> -        return;
> -    }
> -
>      cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
>      object_property_add_child(OBJECT(cpu), "lapic",
>                                OBJECT(cpu->apic_state));
> -- 
> 2.41.0
> 

-- 
Peter Xu


