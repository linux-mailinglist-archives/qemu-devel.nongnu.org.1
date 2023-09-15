Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F57A12CB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 03:11:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgxLx-0002T0-LL; Thu, 14 Sep 2023 21:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-a4DZQYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com>)
 id 1qgxLn-0002Sj-Q8
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 21:10:28 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-a4DZQYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com>)
 id 1qgxLk-0007W5-3W
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 21:10:27 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-59b5a586da6so30172007b3.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 18:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694740218; x=1695345018; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LchVAEaQZVia2xZhuixmqmUBWDRimi0qnrif2w26Bq0=;
 b=kRtTBjZZIdqgXt+LTOv7v2nczeg673/wz0im5Y2qwu92yyEdZSbVKBee9sybqvTVds
 wuhZwupbHAiyO6Ab7NOUj0eWqYdudZ7wjyG+DDkOGxqsA1oYf9OtgXzv+sUQlBn8arGQ
 2uDzOAKJ3eFkOsaWGtWmA7xqDSX3rw31Vu8100WWYHJgZbFUgI7AsSXYkxyZBReF2zl8
 gNYobUmxS7afRJPa3h9U2FtXhHRQQ5IXkjZl5kfTG11XhzGylf9a8Gh8n8arpwINMyq2
 /DOnSJxMAhAvF29n/Wvm/P9guxF4dJxeX5bR5RPQttGdOVvqOmFvIx52nsmJDx4AfXJG
 ZdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694740218; x=1695345018;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LchVAEaQZVia2xZhuixmqmUBWDRimi0qnrif2w26Bq0=;
 b=OTC0zTUkr/kFWC8VUfG80Zc+IS9dFFrEtANfElepqb4vy0a/ylzothHc0jB5DQM6Ea
 tRuLeqfRqxZU9c+GeK23cj20mnYUMPCLNDljZ2fJs8pGk3QlTTElM+T+dmY1C+ULkAql
 2eUtlzvRDB3gXErO8f90RIlfn30nGNqDnd49uStKv+88lqIV0bRxj8SCWFhcjrezrxJn
 1rxwni+seaLzM6cN/qCZBfB2jYzUFQ5quHTnvMuzGiBCZIDMwEQfKeKJu6XphqG/Ekih
 /gjVsRHvyYd5D7mE7zt0Qtzb5xeqwli/NYtvaQTQOYXLGfN+s2g4tHUpENDz6OFFmxuc
 kwNg==
X-Gm-Message-State: AOJu0YzPJXWoayGLHt/3bdW5tSH1ZiBuSuCRRsboUStCru0qIYkyQSUy
 D8VjosSILOvRGvpHj99cgnYCbBTOS/k=
X-Google-Smtp-Source: AGHT+IE4VXxndDboZyldR+JkTc8V9IFSEhu1NDQu14QDd1fJjPVkNZA2uTPpYE+ifglyhzh67I96NtLgjR0=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b617:0:b0:589:a3d6:2e02 with SMTP id
 u23-20020a81b617000000b00589a3d62e02mr10196ywh.3.1694740217924; Thu, 14 Sep
 2023 18:10:17 -0700 (PDT)
Date: Thu, 14 Sep 2023 18:10:16 -0700
In-Reply-To: <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
Mime-Version: 1.0
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
Message-ID: <ZQOu+OE8LWtLTyno@google.com>
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Peter Xu <peterx@redhat.com>,
 "Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 "Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 isaku.yamahata@gmail.com, Claudio Fontana <cfontana@suse.de>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3-a4DZQYKCpQG2yB704CC492.0CAE2AI-12J29BCB4BI.CF4@flex--seanjc.bounces.google.com;
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

On Thu, Sep 14, 2023, David Hildenbrand wrote:
> On 14.09.23 05:50, Xiaoyao Li wrote:
> > It's the v2 RFC of enabling KVM gmem[1] as the backend for private
> > memory.
> > 
> > For confidential-computing, KVM provides gmem/guest_mem interfaces for
> > userspace, like QEMU, to allocate user-unaccesible private memory. This
> > series aims to add gmem support in QEMU's RAMBlock so that each RAM can
> > have both hva-based shared memory and gmem_fd based private memory. QEMU
> > does the shared-private conversion on KVM_MEMORY_EXIT and discards the
> > memory.
> > 
> > It chooses the design that adds "private" property to hostmeory backend.
> > If "private" property is set, QEMU will allocate/create KVM gmem when
> > initialize the RAMbloch of the memory backend.
> > 
> > This sereis also introduces the first user of kvm gmem,
> > KVM_X86_SW_PROTECTED_VM. A KVM_X86_SW_PROTECTED_VM with private KVM gmem
> > can be created with
> > 
> >    $qemu -object sw-protected-vm,id=sp-vm0 \
> > 	-object memory-backend-ram,id=mem0,size=1G,private=on \
> > 	-machine q35,kernel_irqchip=split,confidential-guest-support=sp-vm0,memory-backend=mem0 \
> > 	...
> > 
> > Unfortunately this patch series fails the boot of OVMF at very early
> > stage due to triple fault, because KVM doesn't support emulating string IO
> > to private memory.
> 
> Is support being added? Or have we figured out what it would take to make it
> work?

Hrm, this isn't something I've thought deeply about.  The issue is that anything
that reaches any form of copy_{from,to}_user() will go kablooie because KVM will
always try to read/write the shared mappings.  The best case scenario is that the
shared mapping is invalid and the uaccess faults.  The worst case scenario is
that KVM read/writes the wrong memory and sends the guest into the weeds.  Eww.

And we (well, at least I) definitely want to support this so that gmem can be
used for "regular" VMs, i.e. for VMs where userspace is in the TCB, but for which
userspace doesn't have access to guest memory by default.

It shouldn't be too hard to support.  It's easy enough to wire up the hook
(thankfully that aren't _that_ many sites), and gmem only supports struct page at
the moment so we go straight to kmap.  E.g. something like this

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 54480655bcce..b500b0ce5ce3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3291,12 +3291,15 @@ static int next_segment(unsigned long len, int offset)
                return len;
 }
 
-static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-                                void *data, int offset, int len)
+static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+                                gfn_t gfn, void *data, int offset, int len)
 {
        int r;
        unsigned long addr;
 
+       if (kvm_mem_is_private(kvm, gfn))
+               return kvm_gmem_read(slot, gfn, data, offset, len);
+
        addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
        if (kvm_is_error_hva(addr))
                return -EFAULT;
@@ -3309,9 +3312,8 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
                        int len)
 {
-       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
-
-       return __kvm_read_guest_page(slot, gfn, data, offset, len);
+       return __kvm_read_guest_page(kvm, gfn_to_memslot(kvm, gfn), gfn, data,
+                                    offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_page);
 
@@ -3320,7 +3322,7 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
        struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-       return __kvm_read_guest_page(slot, gfn, data, offset, len);
+       return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_page);
 
> > 2. hugepage support.
> > 
> >     KVM gmem can be allocated from hugetlbfs. How does QEMU determine

Not yet it can't.  gmem only supports THP, hugetlbfs is a future thing, if it's
ever supported.  I wouldn't be at all surprised if we end up going down a slightly
different route and don't use hugetlbfs directly.

> >     when to allocate KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. The
> >     easiest solution is create KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
> >     only when memory backend is HostMemoryBackendFile of hugetlbfs.
> 
> Good question.
> 
> Probably "if the memory backend uses huge pages, also use huge pages for the
> private gmem" makes sense.
> 
> ... but it becomes a mess with preallocation ... which is what people should
> actually be using with hugetlb. Andeventual double memory-consumption ...
> but maybe that's all been taken care of already?
> 
> Probably it's best to leave hugetlb support as future work and start with
> something minimal.
> 
> > 
> > 3. What is KVM_X86_SW_PROTECTED_VM going to look like? and do we need it?
> > 
> 
> Why implement it when you have to ask others for a motivation? ;)
> 
> Personally, I'm not sure if it is really useful, especially in this state.

Yeah, as of today, KVM_X86_SW_PROTECTED_VM is mainly a development vehicle,
e.g. so that testing gmem doesn't require TDX/SNP hardware, debugging gmem guests
isn't brutally painful, etc.

Longer term, I have aspirations of being able to back most VMs with gmem, but
that's going to require quite a bit more work, e.g. gmem needs to be mappable
(when hardware allows it) so that gmem doesn't all but require double mapping,
KVM obviously needs to be able to read/write gmem, etc.

The value proposition is that having a guest-first memory type will allow KVM to
optimize and harden gmem in ways that wouldn't be feasible for a more generic
memory implementation.  E.g. memory isn't mapped into host userspace by default
(makes it harder to accidentally corrupt the guest), the guest can have *larger*
mappings than host userspace, guest memory can be served from a dedicated pool
(similar-ish to hugetlb), the pool can be omitted from the direct map, etc.

> >     This series implements KVM_X86_SW_PROTECTED_VM because it's introduced
> >     with gmem together on KVM side and it's supposed to be the first user
> >     who requires KVM gmem. However the implementation is incomplete and
> >     there lacks the definition of how KVM_X86_SW_PROTECTED_VM works.
> 
> Then it should not be included in this series such that you can make
> progress with the gmem implementation for TDX guests instead?

