Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 550618BD8FE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 03:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s49jW-00005V-0I; Mon, 06 May 2024 21:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3P4U5ZgYKCmgYKGTPIMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--seanjc.bounces.google.com>)
 id 1s49jP-000057-Ri
 for qemu-devel@nongnu.org; Mon, 06 May 2024 21:34:59 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3P4U5ZgYKCmgYKGTPIMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--seanjc.bounces.google.com>)
 id 1s49jN-00081E-Lc
 for qemu-devel@nongnu.org; Mon, 06 May 2024 21:34:59 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-61e0949fc17so51016007b3.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 18:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715045695; x=1715650495; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=VvGkjH9SPvsjHvBH/WrCy4dSbt+wcqHhkwU5LfzuS0Q=;
 b=AMidPh/rn9Kbacz1rd3GPgxelPHP7jLVXqjZkMgvYVEVHWcdhAGqGaYE5Z2B4lsYIu
 YFnKd/b30Ho+grmfIthTcubpHXQWT2dLoCiKfbMNK9M7DeZOS/32VBq7dhtf5o/r7DpG
 DFAlu/W4eHKkWBPUIEe3GYLWfb4YuqRA53th4hl1x/Crz5Jf43NQ6HWYPkOnNZ1ORcf1
 eCEsqdD5g5akmURIwFE/i9LTKi6bUW+qtjAbV4xcZTxSfuYaPYRXZSk/WcSO+7fG/YHW
 6LilPogBfqu6WVO3O42RATp2ufBlQNAYWatb/zSIhPb+jvLoAnnNuhGRsBg6Hv6rEIRv
 tuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715045695; x=1715650495;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VvGkjH9SPvsjHvBH/WrCy4dSbt+wcqHhkwU5LfzuS0Q=;
 b=Y4zq4HBW/OOz4kWCT2w9KCKWnek28q83/EAPeMdLFz3ACPzyY12Ac0Tq/Aau+mAh2Q
 RCBrAIEgfT2M88olz29otje/xVtgPgZnDENFZL4noJPzcoUEfdduXyA/5NyjokInRpoS
 1Vgfj7AQt20PVJ7UI6aHWDRfAWysYuKXWkYCcSKJsQ6Rpx+jYJVKfh5E7F3S8JiKWISO
 se5l4utshUogGfYyCxDnKxjA4YHMNE7l0xRcx5g86ll8uVb+yjoR/vijm8BXhlWvUpUK
 We6HwA0YHHXQ9lLzMDtU5YFOOoOI6smtvlfRJONN4mtK+1AYZ/dO7yCraOTxyDZNRPn2
 37XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdgH7q1A6900JMOR9aESTniLcPL0d/UWQ+I1rxIhl7SLCo7erRvIybG/jA/XgaieoK52xmbysX12ooCR4JjZx9MwkpcXM=
X-Gm-Message-State: AOJu0YxSE6G2bNnVj84O9Q47V3lGEDrSv396hkvodclGmCqWUXLsjgp1
 zinaCqKZ4sxg62GJnyoGFwSEKYEVF8cdxQyh0Mc0/A8QzXULt31fl0yVqFtHU9+yzXEtf/6VsNJ
 FFQ==
X-Google-Smtp-Source: AGHT+IEuRRNgC6bmH2Ym7Hdh0kKkoS5NCGgVEW4kTiZkpma4/j2gQOn7KVKqRXFpAim0ldEq7Pn05YmuCaI=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1893:b0:de4:67d9:a2c6 with SMTP id
 cj19-20020a056902189300b00de467d9a2c6mr1291648ybb.2.1715045695256; Mon, 06
 May 2024 18:34:55 -0700 (PDT)
Date: Mon, 6 May 2024 18:34:53 -0700
In-Reply-To: <20240506.ohwe7eewu0oB@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
Message-ID: <ZjmFPZd5q_hEBdBz@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>, 
 Anna Trikalinou <atrikalinou@microsoft.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
 "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>, 
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
 "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, 
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
 virtualization@lists.linux-foundation.org, x86@kernel.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3P4U5ZgYKCmgYKGTPIMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, May 06, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 03, 2024 at 07:03:21AM GMT, Sean Christopherson wrote:
> > > ---
> > >=20
> > > Changes since v1:
> > > * New patch. Making user space aware of Heki properties was requested=
 by
> > >   Sean Christopherson.
> >=20
> > No, I suggested having userspace _control_ the pinning[*], not merely b=
e notified
> > of pinning.
> >=20
> >  : IMO, manipulation of protections, both for memory (this patch) and C=
PU state
> >  : (control registers in the next patch) should come from userspace.  I=
 have no
> >  : objection to KVM providing plumbing if necessary, but I think usersp=
ace needs to
> >  : to have full control over the actual state.
> >  :=20
> >  : One of the things that caused Intel's control register pinning serie=
s to stall
> >  : out was how to handle edge cases like kexec() and reboot.  Deferring=
 to userspace
> >  : means the kernel doesn't need to define policy, e.g. when to unprote=
ct memory,
> >  : and avoids questions like "should userspace be able to overwrite pin=
ned control
> >  : registers".
> >  :=20
> >  : And like the confidential VM use case, keeping userspace in the loop=
 is a big
> >  : beneifit, e.g. the guest can't circumvent protections by coercing us=
erspace into
> >  : writing to protected memory.
> >=20
> > I stand by that suggestion, because I don't see a sane way to handle th=
ings like
> > kexec() and reboot without having a _much_ more sophisticated policy th=
an would
> > ever be acceptable in KVM.
> >=20
> > I think that can be done without KVM having any awareness of CR pinning=
 whatsoever.
> > E.g. userspace just needs to ability to intercept CR writes and inject =
#GPs.  Off
> > the cuff, I suspect the uAPI could look very similar to MSR filtering. =
 E.g. I bet
> > userspace could enforce MSR pinning without any new KVM uAPI at all.
> >=20
> > [*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com
>=20
> OK, I had concern about the control not directly coming from the guest,
> especially in the case of pKVM and confidential computing, but I get you

Hardware-based CoCo is completely out of scope, because KVM has zero visibi=
lity
into the guest (well, SNP technically allows trapping CR0/CR4, but KVM real=
ly
shouldn't intercept CR0/CR4 for SNP guests).

And more importantly, _KVM_ doesn't define any policies for CoCo VMs.  KVM =
might
help enforce policies that are defined by hardware/firmware, but KVM doesn'=
t
define any of its own.

If pKVM on x86 comes along, then KVM will likely get in the business of def=
ining
policy, but until that happens, KVM needs to stay firmly out of the picture=
.

> point.  It should indeed be quite similar to the MSR filtering on the
> userspace side, except that we need another interface for the guest to
> request such change (i.e. self-protection).
>=20
> Would it be OK to keep this new KVM_HC_LOCK_CR_UPDATE hypercall but
> forward the request to userspace with a VM exit instead?  That would
> also enable userspace to get the request and directly configure the CR
> pinning with the same VM exit.

No?  Maybe?  I strongly suspect that full support will need a richer set of=
 APIs
than a single hypercall.  E.g. to handle kexec(), suspend+resume, emulated =
SMM,
and so on and so forth.  And that's just for CR pinning.

And hypercalls are hampered by the fact that VMCALL/VMMCALL don't allow for
delegation or restriction, i.e. there's no way for the guest to communicate=
 to
the hypervisor that a less privileged component is allowed to perform some =
action,
nor is there a way for the guest to say some chunk of CPL0 code *isn't* all=
owed
to request transition.  Delegation and restriction all has to be done out-o=
f-band.

It'd probably be more annoying to setup initially, but I think a synthetic =
device
with an MMIO-based interface would be more powerful and flexible in the lon=
g run.
Then userspace can evolve without needing to wait for KVM to catch up.

Actually, potential bad/crazy idea.  Why does the _host_ need to define pol=
icy?
Linux already knows what assets it wants to (un)protect and when.  What's m=
issing
is a way for the guest kernel to effectively deprivilege and re-authenticat=
e
itself as needed.  We've been tossing around the idea of paired VMs+vCPUs t=
o
support VTLs and SEV's VMPLs, what if we usurped/piggybacked those ideas, w=
ith a
bit of pKVM mixed in?

Borrowing VTL terminology, where VTL0 is the least privileged, userspace la=
unches
the VM at VTL0.  At some point, the guest triggers the deprivileging sequen=
ce and
userspace creates VTL1.  Userpace also provides a way for VTL0 restrict acc=
ess to
its memory, e.g. to effectively make the page tables for the kernel's direc=
t map
writable only from VTL1, to make kernel text RO (or XO), etc.  And VTL0 cou=
ld then
also completely remove its access to code that changes CR0/CR4.

It would obviously require a _lot_ more upfront work, e.g. to isolate the k=
ernel
text that modifies CR0/CR4 so that it can be removed from VTL0, but that sh=
ould
be doable with annotations, e.g. tag relevant functions with __magic or wha=
tever,
throw them in a dedicated section, and then free/protect the section(s) at =
the
appropriate time.

KVM would likely need to provide the ability to switch VTLs (or whatever th=
ey get
called), and host userspace would need to provide a decent amount of the ba=
ckend
mechanisms and "core" policies, e.g. to manage VTL0 memory, teardown (turn =
off?)
VTL1 on kexec(), etc.  But everything else could live in the guest kernel i=
tself.
E.g. to have CR pinning play nice with kexec(), toss the relevant kexec() c=
ode into
VTL1.  That way VTL1 can verify the kexec() target and tear itself down bef=
ore
jumping into the new kernel.=20

This is very off the cuff and have-wavy, e.g. I don't have much of an idea =
what
it would take to harden kernel text patching, but keeping the policy in the=
 guest
seems like it'd make everything more tractable than trying to define an ABI
between Linux and a VMM that is rich and flexible enough to support all the
fancy things Linux does (and will do in the future).

Am I crazy?  Or maybe reinventing whatever that McAfee thing was that led t=
o
Intel implementing EPTP switching?

