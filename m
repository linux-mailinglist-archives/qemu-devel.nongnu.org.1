Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120328704A2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 15:58:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9lp-0001jC-2E; Mon, 04 Mar 2024 09:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rh9lm-0001hW-6f
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rh9lj-0000MO-Hj
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 09:58:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709564297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nRj+ZQOUd9c6zEEw65NfXBu2gLm5lh8Gkkiq+U+6YUM=;
 b=K4izzsvyMM2TzA0ztNplDVVqomhUvXPzgxE6/W6CJIhS63C5FMrC62OCFaEN+Q7FmR/j5m
 +eBUWAIcYdGiZMoNRswqR/g4D/aIsMGBhDwE45SmCRTtESUtHDKlUZ3Uh0uKcqPullRg9M
 2fcD2ZQAU7n/hAM2ycedu/LSNPCB3sM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-yNZwggd_Mb6qpGudFh1kVQ-1; Mon,
 04 Mar 2024 09:58:16 -0500
X-MC-Unique: yNZwggd_Mb6qpGudFh1kVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E126B3816449;
 Mon,  4 Mar 2024 14:58:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE58C111D640;
 Mon,  4 Mar 2024 14:58:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8BA3518009DB; Mon,  4 Mar 2024 15:58:14 +0100 (CET)
Date: Mon, 4 Mar 2024 15:58:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/1] kvm: add support for guest physical bits
Message-ID: <z4di6tev2kdeddclskhl5xhrlpseykgukfwit6ickrh57zscyv@bkjtbyj3enjx>
References: <20240301101713.356759-1-kraxel@redhat.com>
 <20240301101713.356759-2-kraxel@redhat.com>
 <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab64c0f-7387-4738-b78c-cf798528d5f4@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, Mar 04, 2024 at 09:54:40AM +0800, Xiaoyao Li wrote:
> On 3/1/2024 6:17 PM, Gerd Hoffmann wrote:
> > query kvm for supported guest physical address bits using
> > KVM_CAP_VM_GPA_BITS.  Expose the value to the guest via cpuid
> > (leaf 0x80000008, eax, bits 16-23).
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   target/i386/cpu.h     | 1 +
> >   target/i386/cpu.c     | 1 +
> >   target/i386/kvm/kvm.c | 8 ++++++++
> >   3 files changed, 10 insertions(+)
> > 
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 952174bb6f52..d427218827f6 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2026,6 +2026,7 @@ struct ArchCPU {
> >       /* Number of physical address bits supported */
> >       uint32_t phys_bits;
> > +    uint32_t guest_phys_bits;
> >       /* in order to simplify APIC support, we leave this pointer to the
> >          user */
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 2666ef380891..1a6cfc75951e 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6570,6 +6570,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >           if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> >               /* 64 bit processor */
> >                *eax |= (cpu_x86_virtual_addr_width(env) << 8);
> > +             *eax |= (cpu->guest_phys_bits << 16);
> 
> I think you misunderstand this field.
> 
> If you expose this field to guest, it's the information for nested guest.
> i.e., the guest itself runs as a hypervisor will know its nested guest can
> have guest_phys_bits for physical addr.

I think those limits (l1 + l2 guest phys-bits) are identical, no?

The problem this tries to solve is that making the guest phys-bits
smaller than the host phys-bits is problematic (which why we have
allow_smaller_maxphyaddr), but nevertheless there are cases where
the usable guest physical address space is smaller than the host
physical address space.  One case is intel processors with phys-bits
larger than 48 and 4-level EPT.  Another case is amd processors with
phys-bits larger than 48 and the l0 hypervisor using 4-level paging.

The guest needs to know that limit, specifically the guest firmware
so it knows where it can map PCI bars.

take care,
  Gerd


