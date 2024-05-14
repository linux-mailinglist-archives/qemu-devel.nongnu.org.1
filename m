Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00DE8C55EA
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 14:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6r52-0005iJ-U4; Tue, 14 May 2024 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s6r4f-0005ew-IS
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:16:07 -0400
Received: from smtp-bc0c.mail.infomaniak.ch ([2001:1600:4:17::bc0c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1s6r4b-0004lC-6t
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:16:04 -0400
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VdwLH3dTwzN03;
 Tue, 14 May 2024 14:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
 s=20191114; t=1715688951;
 bh=6cLb3jtwfOqoRKJtvZPYLahhceLlkxg39lBtYJITgWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KRT/ov4rWMykef9xMhIwSZhHfcSSN6GQwPRDurzMGPbliQsS0VO6zSHgJ9Wbadi3l
 OGIHTWGzorzDqVpD81oSg4u9D970KQGA1j7nSMc8pi7COPs75RE7gvSRn175mFw02a
 0K4edTjsnRc2MHxsDF/mZpD6rApUOvuun3U3rT6U=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VdwLD3B6RzB4h; Tue, 14 May 2024 14:15:48 +0200 (CEST)
Date: Tue, 14 May 2024 14:15:46 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Sean Christopherson <seanjc@google.com>, 
 Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>,
 Anna Trikalinou <atrikalinou@microsoft.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>, Forrest Yuan Yu <yuanyu@google.com>, 
 James Gowans <jgowans@amazon.com>, James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>,
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
 Marian Rotariu <marian.c.rotariu@gmail.com>,
 Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>, 
 =?utf-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>, 
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 =?utf-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, 
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
Message-ID: <20240514.OoPohLaejai6@digikod.net>
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjpTxt-Bxia3bRwB@google.com>
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=2001:1600:4:17::bc0c;
 envelope-from=mic@digikod.net; helo=smtp-bc0c.mail.infomaniak.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Tue, May 07, 2024 at 09:16:06AM -0700, Sean Christopherson wrote:
> On Tue, May 07, 2024, Mickaël Salaün wrote:
> > > Actually, potential bad/crazy idea.  Why does the _host_ need to define policy?
> > > Linux already knows what assets it wants to (un)protect and when.  What's missing
> > > is a way for the guest kernel to effectively deprivilege and re-authenticate
> > > itself as needed.  We've been tossing around the idea of paired VMs+vCPUs to
> > > support VTLs and SEV's VMPLs, what if we usurped/piggybacked those ideas, with a
> > > bit of pKVM mixed in?
> > > 
> > > Borrowing VTL terminology, where VTL0 is the least privileged, userspace launches
> > > the VM at VTL0.  At some point, the guest triggers the deprivileging sequence and
> > > userspace creates VTL1.  Userpace also provides a way for VTL0 restrict access to
> > > its memory, e.g. to effectively make the page tables for the kernel's direct map
> > > writable only from VTL1, to make kernel text RO (or XO), etc.  And VTL0 could then
> > > also completely remove its access to code that changes CR0/CR4.
> > > 
> > > It would obviously require a _lot_ more upfront work, e.g. to isolate the kernel
> > > text that modifies CR0/CR4 so that it can be removed from VTL0, but that should
> > > be doable with annotations, e.g. tag relevant functions with __magic or whatever,
> > > throw them in a dedicated section, and then free/protect the section(s) at the
> > > appropriate time.
> > > 
> > > KVM would likely need to provide the ability to switch VTLs (or whatever they get
> > > called), and host userspace would need to provide a decent amount of the backend
> > > mechanisms and "core" policies, e.g. to manage VTL0 memory, teardown (turn off?)
> > > VTL1 on kexec(), etc.  But everything else could live in the guest kernel itself.
> > > E.g. to have CR pinning play nice with kexec(), toss the relevant kexec() code into
> > > VTL1.  That way VTL1 can verify the kexec() target and tear itself down before
> > > jumping into the new kernel. 
> > > 
> > > This is very off the cuff and have-wavy, e.g. I don't have much of an idea what
> > > it would take to harden kernel text patching, but keeping the policy in the guest
> > > seems like it'd make everything more tractable than trying to define an ABI
> > > between Linux and a VMM that is rich and flexible enough to support all the
> > > fancy things Linux does (and will do in the future).
> > 
> > Yes, we agree that the guest needs to manage its own policy.  That's why
> > we implemented Heki for KVM this way, but without VTLs because KVM
> > doesn't support them.
> > 
> > To sum up, is the VTL approach the only one that would be acceptable for
> > KVM?  
> 
> Heh, that's not a question you want to be asking.  You're effectively asking me
> to make an authorative, "final" decision on a topic which I am only passingly
> familiar with.
> 
> But since you asked it... :-)  Probably?
> 
> I see a lot of advantages to a VTL/VSM-like approach:
> 
>  1. Provides Linux-as-a guest the flexibility it needs to meaningfully advance
>     its security, with the least amount of policy built into the guest/host ABI.
> 
>  2. Largely decouples guest policy from the host, i.e. should allow the guest to
>     evolve/update it's policy without needing to coordinate changes with the host.
> 
>  3. The KVM implementation can be generic enough to be reusable for other features.
> 
>  4. Other groups are already working on VTL-like support in KVM, e.g. for VSM
>     itself, and potentially for VMPL/SVSM support.
> 
> IMO, #2 is a *huge* selling point.  Not having to coordinate changes across
> multiple code bases and/or organizations and/or maintainers is a big win for
> velocity, long term maintenance, and probably the very viability of HEKI.

Agree, this is our goal.

> 
> Providing the guest with the tools to define and implement its own policy means
> end users don't have to way for some third party, e.g. CSPs, to deploy the
> accompanying host-side changes, because there are no host-side changes.
> 
> And encapsulating everything in the guest drastically reduces the friction with
> changes in the kernel that interact with hardening, both from a technical and a
> social perspective.  I.e. giving the kernel (near) complete control over its
> destiny minimizes the number of moving parts, and will be far, far easier to sell
> to maintainers.  I would expect maintainers to react much more favorably to being
> handed tools to harden the kernel, as opposed to being presented a set of APIs
> that can be used to make the kernel compliant with _someone else's_ vision of
> what kernel hardening should look like.
> 
> E.g. imagine a new feature comes along that requires overriding CR0/CR4 pinning
> in a way that doesn't fit into existing policy.  If the VMM is involved in
> defining/enforcing the CR pinning policy, then supporting said new feature would
> require new guest/host ABI and an updated host VMM in order to make the new
> feature compatible with HEKI.  Inevitably, even if everything goes smoothly from
> an upstreaming perspective, that will result in guests that have to choose between
> HEKI and new feature X, because there is zero chance that all hosts that run Linux
> as a guest will be updated in advance of new feature X being deployed.

Sure. We need to find a generic-enough KVM interface to be able to
restrict a wide range of virtualization/hardware mechanisms (to not rely
too much on KVM changes) and delegate most of enforcement/emulation to
VTL1.  In short, policy definition owned by VTL0/guest, and policy
enforcement shared between KVM (coarse grained) and VTL1 (fine grained).

> 
> And if/when things don't go smoothly, odds are very good that kernel maintainers
> will eventually tire of having to coordinate and negotiate with QEMU and other
> VMMs, and will become resistant to continuing to support/extend HEKI.

Yes, that was our concern too and another reason why we choose to let
the guest handle its own security policy.

> 
> > If yes, that would indeed require a *lot* of work for something we're not
> > sure will be accepted later on.
> 
> Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SVSM support
> is trending toward the paired VM+vCPU model.  IMO, it's entirely feasible to
> design KVM support such that much of the development load can be shared between
> the projects.  And having 2+ use cases for a feature (set) makes it _much_ more
> likely that the feature(s) will be accepted.
> 
> And similar to what Paolo said regarding HEKI not having a complete story, I
> don't see a clear line of sight for landing host-defined policy enforcement, as
> there are many open, non-trivial questions that need answers. I.e. upstreaming
> HEKI in its current form is also far from a done deal, and isn't guaranteed to
> be substantially less work when all is said and done.

I'm not sure to understand why "Heki not having a complete story".  The
goal is the same as the current kernel self-protection mechanisms.

