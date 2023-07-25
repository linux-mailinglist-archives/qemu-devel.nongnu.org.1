Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 629EC761827
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:21:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOH13-0008F3-U0; Tue, 25 Jul 2023 08:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOH0w-0008B0-Cf
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:19:42 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOH0t-0007xB-Jc
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:19:41 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-98e011f45ffso804060666b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690287578; x=1690892378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nYrCQRR/69uqvDwM5fk4fzz23/zdzo0otjNSbYd4kR4=;
 b=KECCAYKlu20hKqsaQ4cOSf/3XzAD8hYrj/Rq2i3xcScjjDq9v7gLd/Vebx9XKJy70R
 L3ZHAfde1TfZJEfYJIz+7y538pVaLD4BXAl5n6z457PNa/O8z0wxZ9+i2S+kce2NKO3+
 w4E62Zd36jyq63Hfa7x4SywHmX21aimGeLl9n+LUL/rBSkf+wXxvirER3kdFMqhX4gdY
 KX458aMnUL9L8s21mq1nbCCgrK9bRnN0kUduRFISzfKl1AYfFovoZjMr5tROPR0jGJib
 /iidJKWqni07Uk3c0D31vyZQpAUyis2tLLxy9k9amz0x0mwsMa2S5YzWVqKCj+BuB1gf
 Ppyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690287578; x=1690892378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYrCQRR/69uqvDwM5fk4fzz23/zdzo0otjNSbYd4kR4=;
 b=Cwfk50rmN2n2mNrBe/uOunGebZ7YKIEFRkOfEi5N809X7f/nDD7KGjrIAZuEa2Uqpd
 jQAb3n2jtSajc/ByEmTyNwZEyH+B5GGQ8F1kJqz1rOnS1l9u/a3xl1V7bicVMSp6UVkg
 p6oiTru7YB3NXj3VI4SPnFRkbf56NrfNdU7qe0RMWrgPPMjnfq+s7g0TE3XxZ3yxSieU
 HExrxDZp0Yuw1NaxiLXOWxRgJ8G0lRoJNw8R8lMxbIXGngDZnnudjZFaN/9oQY8yrAUn
 lZOB38pcB/2XEpzv1XwF2zWu17XrT1XVoqUuMLWkObcTZy5ziOYOzQD8W8PwPON32Nyx
 u5UQ==
X-Gm-Message-State: ABy/qLah8XBr5uP5NDyB1uaHJiqLCbSRpm6oMLsPmSSD4PFDw4QJ+2bj
 Dwdi06bYeQgSE++C3FJivnHkPg==
X-Google-Smtp-Source: APBJJlHCHvLtlmTSM3H9bL/uWGD5Lv9NiCDBzeiIz5nwstqRlZHtUf3IkveyPLYhqClhO5SYVEDC6Q==
X-Received: by 2002:a17:906:74d6:b0:993:d7f3:f055 with SMTP id
 z22-20020a17090674d600b00993d7f3f055mr11899478ejl.11.1690287577659; 
 Tue, 25 Jul 2023 05:19:37 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906375b00b00988f168811bsm8205127ejc.135.2023.07.25.05.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:19:37 -0700 (PDT)
Date: Tue, 25 Jul 2023 14:19:36 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, 
 peter.maydell@linaro.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com, 
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Message-ID: <20230725-539b009b8e15994408dbb47b@orel>
References: <20230722062115.11950-2-ajones@ventanamicro.com>
 <81dd6b4c-200f-bb35-69fa-ed623eb7e6d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81dd6b4c-200f-bb35-69fa-ed623eb7e6d1@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x633.google.com
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

On Mon, Jul 24, 2023 at 11:53:39AM +0200, Thomas Huth wrote:
> On 22/07/2023 08.21, Andrew Jones wrote:
> > Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> > irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> > RISC-V platform has AIA. The cap indicates KVM supports at least one
> > of the following ioctls:
> > 
> >    KVM_CREATE_IRQCHIP
> >    KVM_IRQ_LINE
> >    KVM_GET_IRQCHIP
> >    KVM_SET_IRQCHIP
> >    KVM_GET_LAPIC
> >    KVM_SET_LAPIC
> > 
> > but the cap doesn't imply that KVM must support any of those ioctls
> > in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
> > ioctl was supported. Stop making that assumption by introducing a
> > KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
> > sets. Adding parameters isn't awesome, but given how the
> > KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
> > options.
> > 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> > 
> > While this fixes booting guests on riscv KVM with AIA it's unlikely
> > to get merged before the QEMU support for KVM AIA[1] lands, which
> > would also fix the issue. I think this patch is still worth considering
> > though since QEMU's assumption is wrong.
> > 
> > [1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/
> > 
> > 
> >   accel/kvm/kvm-all.c    | 5 ++++-
> >   include/sysemu/kvm.h   | 1 +
> >   target/arm/kvm.c       | 3 +++
> >   target/i386/kvm/kvm.c  | 2 ++
> >   target/s390x/kvm/kvm.c | 3 +++
> >   5 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index 373d876c0580..0f5ff8630502 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -86,6 +86,7 @@ struct KVMParkedVcpu {
> >   };
> >   KVMState *kvm_state;
> > +bool kvm_has_create_irqchip;
> >   bool kvm_kernel_irqchip;
> >   bool kvm_split_irqchip;
> >   bool kvm_async_interrupts_allowed;
> > @@ -2377,8 +2378,10 @@ static void kvm_irqchip_create(KVMState *s)
> >           if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
> >               error_report("Split IRQ chip mode not supported.");
> >               exit(1);
> > -        } else {
> > +        } else if (kvm_has_create_irqchip) {
> >               ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> > +        } else {
> > +            return;
> >           }
> >       }
> >       if (ret < 0) {
> 
> I think I'd do this differntly... at the beginning of the function, there is
> a check for kvm_check_extension(s, KVM_CAP_IRQCHIP) etc. ... I think you
> could now replace that check with a simple
> 
> 	if (!kvm_has_create_irqchip) {
> 		return;
> 	}
> 
> The "kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0)" of course has to be
> moved to the target/s390x/kvm/kvm.c file, too.

Actually, once we've moved the s390 cap enablement to the s390 file we can
just drop the whole if-else chain. We don't want the
if (!kvm_has_create_irqchip) at the top because we want to try
kvm_arch_irqchip_create() even when kvm_has_create_irqchip is false, and
we don't need to check KVM_CREATE_IRQCHIP for kvm_arch_irqchip_create()
either. Keeping the check, as it is above in this v1, of
kvm_has_create_irqchip for KVM_CREATE_IRQCHIP is still necessary, though.

Thanks,
drew

