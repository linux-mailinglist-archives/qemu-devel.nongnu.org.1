Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF371717B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 01:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q48Zc-0002Ad-Ko; Tue, 30 May 2023 19:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keescook@chromium.org>)
 id 1q48Za-0002AO-Ls
 for qemu-devel@nongnu.org; Tue, 30 May 2023 19:16:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <keescook@chromium.org>)
 id 1q48ZY-00022t-Q3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 19:16:14 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d30ab1ef2so3838544b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 16:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1685488571; x=1688080571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q6wOdCsvPcfL1AGuKhq7si1i+l1tB9VGHRhgBuI4hFQ=;
 b=A6P9MRUqWxltKJ9Zgwok7DSDRoOxoww2FWlF6WQO1tYgoM5+Hi0Ez2oEaQQjsD1m8R
 d4fRiNfemEoHsLbKtPfU643qi1eTaIaRbZTrXG8PIKxDT7zOE/fxQqSHWBsVd7zxgsD9
 9LmT/yPeVeEdIlXyQ0jganlgblNgnS7PESvrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685488571; x=1688080571;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q6wOdCsvPcfL1AGuKhq7si1i+l1tB9VGHRhgBuI4hFQ=;
 b=knVzQskMH/5faINvU6NCCYccw8ty+0yY/k3d0ZS3NBk6FJIt8f4eeL7P1Sx+EeEvhA
 bCFAYgR1MT+HANJ6a6ig1uV+5J4+t/JxJ7D9cBENXrXPdHDnFFWBtVM1p6xqQSpOfUO4
 WXdv6s8rSGCEARTbozCrqImvhbV5atYObLru5PIKAUVbGT+0nCgKx6V4PzSWxDJy22MY
 yKGv8sTveXXwPTuL2YcfziE4nIv7RvwRg6Lsl02RkQUnRykxyDyae2AUTsEtBUOiWKb9
 2neE/hTDyVQYXBoNS8m+O868Nxs8S7VfP5egYXEFXXkG07shgDdPRbJrcsHOwc747XXu
 ef6g==
X-Gm-Message-State: AC+VfDy9rJ6z0X16IU87UacF8h73XZMkEE9bq5M55J5N1jldohUu9Diy
 IAU4vgFK8NyUfwppy1GAGCOxjA==
X-Google-Smtp-Source: ACHHUZ5vUXK2I/pfuTav0TBfWy3DDrvFJsd+7uESTSUanu+Vl50RByVZpLds9PiU8F5GGbjiErQYOQ==
X-Received: by 2002:a05:6a00:10c4:b0:646:663a:9d60 with SMTP id
 d4-20020a056a0010c400b00646663a9d60mr4308038pfu.10.1685488570875; 
 Tue, 30 May 2023 16:16:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 v22-20020aa78516000000b0063d3d776910sm2123773pfn.138.2023.05.30.16.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 16:16:10 -0700 (PDT)
Date: Tue, 30 May 2023 16:16:09 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Wei Liu <wei.liu@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexander Graf <graf@amazon.com>, Forrest Yuan Yu <yuanyu@google.com>,
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
 =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Thara Gopinath <tgopinath@microsoft.com>, Will Deacon <will@kernel.org>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 5/9] KVM: x86: Add new hypercall to lock control
 registers
Message-ID: <202305301614.BF8D80D3D5@keescook>
References: <20230505152046.6575-1-mic@digikod.net>
 <20230505152046.6575-6-mic@digikod.net>
 <ZFlllHjntehpthma@liuwe-devbox-debian-v2>
 <901ff104-215c-8e81-fbae-5ecd8fa94449@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <901ff104-215c-8e81-fbae-5ecd8fa94449@digikod.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=keescook@chromium.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, May 29, 2023 at 06:48:03PM +0200, Mickaël Salaün wrote:
> 
> On 08/05/2023 23:11, Wei Liu wrote:
> > On Fri, May 05, 2023 at 05:20:42PM +0200, Mickaël Salaün wrote:
> > > This enables guests to lock their CR0 and CR4 registers with a subset of
> > > X86_CR0_WP, X86_CR4_SMEP, X86_CR4_SMAP, X86_CR4_UMIP, X86_CR4_FSGSBASE
> > > and X86_CR4_CET flags.
> > > 
> > > The new KVM_HC_LOCK_CR_UPDATE hypercall takes two arguments.  The first
> > > is to identify the control register, and the second is a bit mask to
> > > pin (i.e. mark as read-only).
> > > 
> > > These register flags should already be pinned by Linux guests, but once
> > > compromised, this self-protection mechanism could be disabled, which is
> > > not the case with this dedicated hypercall.
> > > 
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > > Cc: Wanpeng Li <wanpengli@tencent.com>
> > > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > > Link: https://lore.kernel.org/r/20230505152046.6575-6-mic@digikod.net
> > [...]
> > >   	hw_cr4 = (cr4_read_shadow() & X86_CR4_MCE) | (cr4 & ~X86_CR4_MCE);
> > >   	if (is_unrestricted_guest(vcpu))
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index ffab64d08de3..a529455359ac 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -7927,11 +7927,77 @@ static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
> > >   	return value;
> > >   }
> > > +#ifdef CONFIG_HEKI
> > > +
> > > +extern unsigned long cr4_pinned_mask;
> > > +
> > 
> > Can this be moved to a header file?
> 
> Yep, but I'm not sure which one. Any preference Kees?

Uh, er, I was never expecting that mask to be non-static. ;) To that
end, how about putting it in arch/x86/kvm/x86.h ?

-- 
Kees Cook

