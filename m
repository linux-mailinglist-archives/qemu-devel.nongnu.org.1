Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90491777783
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4Ar-0001TC-Sp; Thu, 10 Aug 2023 07:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU4Am-0001Sp-Gj
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:49:48 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qU4Ak-00060S-67
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:49:48 -0400
Received: by mail-lj1-x241.google.com with SMTP id
 38308e7fff4ca-2b9cbaee7a9so12686381fa.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691668183; x=1692272983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iWf3CiN5pd1dJ4ELk7fNaMr3Kkzj0raVtdEZMR7ozGw=;
 b=Co9Q7jEmrwsHgN8dUiasSO0lcdWLyd/dQX5XyDfQDLDnSG1M4VAYKyaVwTvdakvanY
 Bh4qD96ismnWedydWi7vN+0ZsuoiP7pyUXLGOD3gQQNZbLm8zhAIAIQ1OVtxh5yZ6xPN
 GxxsX+jHKSfFtsJWt3BcmFvC6dA5xd9ke/HjSEvV7npw7oNOcoM3Gb6g6QPVgjlzIFvc
 N12YlCAXP0Wfkt67MzJF+cHoFRsOCWiezmg5m9PSD/wvjH5u+Jg7sO0QlaHJWKu5fXHf
 l8xrMDTXtkmgoW0UkGfxQc0AeStr5A9LJpyonFHm0ca8FXomXgZKmbttT9Q8x5e+dHPf
 K0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691668183; x=1692272983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWf3CiN5pd1dJ4ELk7fNaMr3Kkzj0raVtdEZMR7ozGw=;
 b=IbAftNLAvzc63H0SKs1nhP3O7iqKoX6ncSI/BXceGJ5B902tR1djfPs0aTCrYoFJh1
 yofDxMay242BapVjRl9GuhTOF15T2sNXDkrcVTwY6a5pMO6QOnSY1tC5GAn7zLKrY0sA
 6tGWfvBLOr+OTzpSEaRSZx51V4yVwxu3HrDGfAxcFVvkdJwm81gjWf1R9oyy9hfDjWng
 Vq9AzVyrmolOfM04op9rNgtEk9OlnUQHl8PyRmeIkTcs1G1l28F9RQSf2OzwrqjCxvND
 +K+l7YqSM+TnOlmQSGuBrYz5xuYu8qAtEUVlPnq5UFZj0FEOCj7mZ2kxcwid9orp2BEO
 q9yA==
X-Gm-Message-State: AOJu0YxQklhgvhBtG4da/OjtHTBZZ4FrPGQWc+ZK+UJJPmHB7E8cwt1G
 ilXaEfQYKos5kFN1PR+nVDbW9Q==
X-Google-Smtp-Source: AGHT+IFqo+BGhbnSbHFbRj5BUeQUUqnhaNbhQVjslyiaSUaHOEndD9oHWWZiUr1j7HVtC1RO3dF0Vw==
X-Received: by 2002:a2e:3216:0:b0:2b9:ead7:4534 with SMTP id
 y22-20020a2e3216000000b002b9ead74534mr1799819ljy.47.1691668182785; 
 Thu, 10 Aug 2023 04:49:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a1709064e8500b00993928e4d1bsm822593eju.24.2023.08.10.04.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 04:49:42 -0700 (PDT)
Date: Thu, 10 Aug 2023 13:49:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, 
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com, 
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v2] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Message-ID: <20230810-9b964f592930357cd5c83fbe@orel>
References: <20230725122601.424738-2-ajones@ventanamicro.com>
 <20230810-3326d0a412d01fe729f7e6e4@orel>
 <CAFEAcA9Yj+9oWgjU1t=df+As0K7FhaE4YLJ9ee2oRpSEejTjCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Yj+9oWgjU1t=df+As0K7FhaE4YLJ9ee2oRpSEejTjCg@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 10, 2023 at 12:38:28PM +0100, Peter Maydell wrote:
> On Thu, 10 Aug 2023 at 12:29, Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> >
> > Hi Paolo,
> >
> > Is this good for 8.1?
> 
> Is it fixing a regression since 8.0 ?

The fix is for running with KVM which includes 00f918f61c56, which is
v6.5-rc1 and later. All QEMU versions will fail to start, so this fix
isn't fixing a QEMU regression, but until this fix, or the KVM AIA
support series, is merged, then we won't have any QEMU version we can
use with later KVM.

Thanks,
drew

> 
> thanks
> -- PMM
> 
> >
> > Thanks,
> > drew
> >
> >
> > On Tue, Jul 25, 2023 at 02:26:02PM +0200, Andrew Jones wrote:
> > > Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> > > irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> > > RISC-V platform has AIA. The cap indicates KVM supports at least one
> > > of the following ioctls:
> > >
> > >   KVM_CREATE_IRQCHIP
> > >   KVM_IRQ_LINE
> > >   KVM_GET_IRQCHIP
> > >   KVM_SET_IRQCHIP
> > >   KVM_GET_LAPIC
> > >   KVM_SET_LAPIC
> > >
> > > but the cap doesn't imply that KVM must support any of those ioctls
> > > in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
> > > ioctl was supported. Stop making that assumption by introducing a
> > > KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
> > > sets. Adding parameters isn't awesome, but given how the
> > > KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
> > > options.
> > >
> > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > ---
> > >
> > > While this fixes booting guests on riscv KVM with AIA it's unlikely
> > > to get merged before the QEMU support for KVM AIA[1] lands, which
> > > would also fix the issue. I think this patch is still worth considering
> > > though since QEMU's assumption is wrong.
> > >
> > > [1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/
> > >
> > > v2:
> > >   - Move the s390x code to an s390x file. [Thomas]
> > >   - Drop the KVM_CAP_IRQCHIP check from the top of kvm_irqchip_create(),
> > >     as it's no longer necessary.
> > >
> > >  accel/kvm/kvm-all.c    | 16 ++++------------
> > >  include/sysemu/kvm.h   |  1 +
> > >  target/arm/kvm.c       |  3 +++
> > >  target/i386/kvm/kvm.c  |  2 ++
> > >  target/s390x/kvm/kvm.c | 11 +++++++++++
> > >  5 files changed, 21 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > > index 373d876c0580..cddcb6eca641 100644
> > > --- a/accel/kvm/kvm-all.c
> > > +++ b/accel/kvm/kvm-all.c
> > > @@ -86,6 +86,7 @@ struct KVMParkedVcpu {
> > >  };
> > >
> > >  KVMState *kvm_state;
> > > +bool kvm_has_create_irqchip;
> > >  bool kvm_kernel_irqchip;
> > >  bool kvm_split_irqchip;
> > >  bool kvm_async_interrupts_allowed;
> > > @@ -2358,17 +2359,6 @@ static void kvm_irqchip_create(KVMState *s)
> > >      int ret;
> > >
> > >      assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
> > > -    if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
> > > -        ;
> > > -    } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
> > > -        ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
> > > -        if (ret < 0) {
> > > -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
> > > -            exit(1);
> > > -        }
> > > -    } else {
> > > -        return;
> > > -    }
> > >
> > >      /* First probe and see if there's a arch-specific hook to create the
> > >       * in-kernel irqchip for us */
> > > @@ -2377,8 +2367,10 @@ static void kvm_irqchip_create(KVMState *s)
> > >          if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
> > >              error_report("Split IRQ chip mode not supported.");
> > >              exit(1);
> > > -        } else {
> > > +        } else if (kvm_has_create_irqchip) {
> > >              ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> > > +        } else {
> > > +            return;
> > >          }
> > >      }
> > >      if (ret < 0) {
> > > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> > > index 115f0cca79d1..84b1bb3dc91e 100644
> > > --- a/include/sysemu/kvm.h
> > > +++ b/include/sysemu/kvm.h
> > > @@ -32,6 +32,7 @@
> > >  #ifdef CONFIG_KVM_IS_POSSIBLE
> > >
> > >  extern bool kvm_allowed;
> > > +extern bool kvm_has_create_irqchip;
> > >  extern bool kvm_kernel_irqchip;
> > >  extern bool kvm_split_irqchip;
> > >  extern bool kvm_async_interrupts_allowed;
> > > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > > index b4c7654f4980..2fa87b495d68 100644
> > > --- a/target/arm/kvm.c
> > > +++ b/target/arm/kvm.c
> > > @@ -250,6 +250,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
> > >  int kvm_arch_init(MachineState *ms, KVMState *s)
> > >  {
> > >      int ret = 0;
> > > +
> > > +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> > > +
> > >      /* For ARM interrupt delivery is always asynchronous,
> > >       * whether we are using an in-kernel VGIC or not.
> > >       */
> > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > index ebfaf3d24c79..6363e67f092d 100644
> > > --- a/target/i386/kvm/kvm.c
> > > +++ b/target/i386/kvm/kvm.c
> > > @@ -2771,6 +2771,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> > >          }
> > >      }
> > >
> > > +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
> > > +
> > >      return 0;
> > >  }
> > >
> > > diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> > > index a9e5880349d9..bcc735227f7d 100644
> > > --- a/target/s390x/kvm/kvm.c
> > > +++ b/target/s390x/kvm/kvm.c
> > > @@ -391,6 +391,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> > >      }
> > >
> > >      kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
> > > +
> > > +    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_S390_IRQCHIP);
> > > +    if (kvm_has_create_irqchip) {
> > > +        int ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
> > > +
> > > +        if (ret < 0) {
> > > +            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
> > > +            exit(1);
> > > +        }
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >
> > > --
> > > 2.41.0
> > >

