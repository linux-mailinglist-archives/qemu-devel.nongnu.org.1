Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4F718B1D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SMe-00074V-KH; Wed, 31 May 2023 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <346x3ZAYKCkY0mivrkowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--seanjc.bounces.google.com>)
 id 1q4SMa-0006vl-0C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:24:08 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <346x3ZAYKCkY0mivrkowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--seanjc.bounces.google.com>)
 id 1q4SMX-0000vF-O7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:24:07 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-565a336caa0so210347b3.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685564643; x=1688156643;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=APftvx9keMYUt1Xk5prtdAgJw5++/nh9oJ2TjaQ+44Q=;
 b=PX/4QCBDJ9PLCDibCE4LoOf2U0DE4t/KWyS05NGIZcGzqK/qwcSjxPluWcaqwv1Stk
 rMyraQASzxyWuHCUByRiPyI4r+TKzg18DQi23LqLbo8WEM0cjd44YF28bRWYO1A5spCy
 C8uoUDWMPuMiaxHglFY6t+vlO8uFRPkrpIUD9WU6y/eI2MWpQZdCjDnBrvtPK2foPDM8
 2b0pUD4qsLCE5pd4FfnukjL1T9+czSe/1aJuv1AeB5D9vgahqEpjGWaUrfGv4vRCGUgK
 7d8Ob7qWLSyhaFm1bWvZd46hX/2rCmhkQhiUf9f78KTYzvmJ6/SxSLGkVtXf5wgn2kFJ
 IIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685564643; x=1688156643;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=APftvx9keMYUt1Xk5prtdAgJw5++/nh9oJ2TjaQ+44Q=;
 b=aYVThxe4T+TOD3M2AHxCFGjgkViVYvPWP+du5NGVEdx70bsU5XwtWMEYARZKHm7yvL
 B02FoNsbUvJ4IViQMzQwl8Q1q5xWLRQy3NOlK1CEwtoqaEjQ4aJRhZEM6uIKWl2/CjW1
 U3FyGaBx/ROmncJ15z/0XzCTE7F6G/0hjyNO1oka8ebIcKDhfSdYTY3JuaPRnrbufscs
 3m8QIN5Fk1r5fUrL3jEUFFARpXFmfoivZ0H9Wqrx6Uw88Zo/s89yaIFbkweKKJCLI3jA
 WICH8ab6bvkgK9FF6epyQTIYqsXwY69iDLUdjiFLDmItdl18VQkmYjCleB3aCThKn11X
 KFLA==
X-Gm-Message-State: AC+VfDxk+s4At3xMkimGjpqa7pzRz9M9kxTcfv8uxjZ8n55Gshq3XFil
 HO2iufG7oMzB48XsV3QG1Y6yNpUPXw8=
X-Google-Smtp-Source: ACHHUZ4Rs9okzQlJSZpcwd3Z5dIegCtWutSFaW8eVk3gk4ZcP95GwA04TMkwmyC49mplI5lk+ocRWvQTqeQ=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e305:0:b0:55d:ea61:d8e9 with SMTP id
 q5-20020a81e305000000b0055dea61d8e9mr4086306ywl.7.1685564643426; Wed, 31 May
 2023 13:24:03 -0700 (PDT)
Date: Wed, 31 May 2023 13:24:01 -0700
In-Reply-To: <fd1dd8bcc172093ad20243ac1e7bb8fce45b38ef.camel@intel.com>
Mime-Version: 1.0
References: <20230505152046.6575-1-mic@digikod.net>
 <93726a7b9498ec66db21c5792079996d5fed5453.camel@intel.com>
 <facfd178-3157-80b4-243b-a5c8dabadbfb@digikod.net>
 <58a803f6-c3de-3362-673f-767767a43f9c@digikod.net>
 <fd1dd8bcc172093ad20243ac1e7bb8fce45b38ef.camel@intel.com>
Message-ID: <ZHes4a73Zg+6JuFB@google.com>
Subject: Re: [RFC PATCH v1 0/9] Hypervisor-Enforced Kernel Integrity
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "mic@digikod.net" <mic@digikod.net>, 
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, 
 "keescook@chromium.org" <keescook@chromium.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "wanpengli@tencent.com" <wanpengli@tencent.com>, 
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>, 
 "marian.c.rotariu@gmail.com" <marian.c.rotariu@gmail.com>,
 Alexander Graf <graf@amazon.com>, 
 John S Andersen <john.s.andersen@intel.com>, 
 "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>, 
 "ssicleru@bitdefender.com" <ssicleru@bitdefender.com>,
 "yuanyu@google.com" <yuanyu@google.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "tgopinath@microsoft.com" <tgopinath@microsoft.com>, 
 "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>, 
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "will@kernel.org" <will@kernel.org>, 
 "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>, 
 "mdontu@bitdefender.com" <mdontu@bitdefender.com>, 
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, 
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, 
 "nicu.citu@icloud.com" <nicu.citu@icloud.com>,
 "ztarkhani@microsoft.com" <ztarkhani@microsoft.com>, 
 "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=346x3ZAYKCkY0mivrkowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Tue, May 30, 2023, Rick P Edgecombe wrote:
> On Fri, 2023-05-26 at 17:22 +0200, Micka=EF=BF=BDl Sala=EF=BF=BDn wrote:
> > > > Can the guest kernel ask the host VMM's emulated devices to DMA int=
o
> > > > the protected data? It should go through the host userspace mapping=
s I
> > > > think, which don't care about EPT permissions. Or did I miss where =
you
> > > > are protecting that another way? There are a lot of easy ways to as=
k
> > > > the host to write to guest memory that don't involve the EPT. You
> > > > probably need to protect the host userspace mappings, and also the
> > > > places in KVM that kmap a GPA provided by the guest.
> > >=20
> > > Good point, I'll check this confused deputy attack. Extended KVM
> > > protections should indeed handle all ways to map guests' memory.  I'm
> > > wondering if current VMMs would gracefully handle such new restrictio=
ns
> > > though.
> >=20
> > I guess the host could map arbitrary data to the guest, so that need to=
 be
> > handled, but how could the VMM (not the host kernel) bypass/update EPT
> > initially used for the guest (and potentially later mapped to the host)=
?
>=20
> Well traditionally both QEMU and KVM accessed guest memory via host
> mappings instead of the EPT.=EF=BF=BDSo I'm wondering what is stopping th=
e
> guest from passing a protected gfn when setting up the DMA, and QEMU
> being enticed to write to it? The emulator as well would use these host
> userspace mappings and not consult the EPT IIRC.
>=20
> I think Sean was suggesting host userspace should be more involved in
> this process, so perhaps it could protect its own alias of the
> protected memory, for example mprotect() it as read-only.

Ya, though "suggesting" is really "demanding, unless someone provides super=
 strong
justification for handling this directly in KVM".  It's basically the same =
argument
that led to Linux Security Modules: I'm all for KVM providing the framework=
 and
plumbing, but I don't want KVM to get involved in defining policy, thread m=
odels, etc.

