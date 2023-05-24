Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2433170FF13
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 22:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1uu4-0001gM-CB; Wed, 24 May 2023 16:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hXBuZAYKCko4qmzvos00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--seanjc.bounces.google.com>)
 id 1q1uu2-0001g6-37
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:16:10 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hXBuZAYKCko4qmzvos00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--seanjc.bounces.google.com>)
 id 1q1utz-0004p3-O6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:16:09 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-babb5e91ab4so2648060276.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684959365; x=1687551365;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=et28JU3wkykvEfV7tUaeZmOsEZymHIt/E70MuyiU1No=;
 b=G2x7cKfO2HsF6MKrRXtuGOoWc4Yj9Z0Q1nyrd66b5CwhWsYKjq6PGytnNGnWnoUbYg
 0jM5j8y6re71Mo5bG/5Ojl0FuWMuSP9Eaoaxj5HQpFpkslAfyM1khFmi/TCdIov7pGs1
 35dPUO8OrPbZFQbz/PVLHobvQlt75SleU+2ukbo6ZGqKu4GeU1PfbY6dp1LYUPK5l9gh
 L9G4O1nBLIgKKq1HPdPHhPEBqnrucIszUNCbUVyzwlbALVm3SP6WSm1IH5u9OT/3syhL
 D/r8JPmU9oz+tOmHzugTg/xI95+Lz3S8lUd5+91fPkwHf4Yn5e/eFKasubnMlzF3zHuL
 SiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684959365; x=1687551365;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=et28JU3wkykvEfV7tUaeZmOsEZymHIt/E70MuyiU1No=;
 b=C4PCbZWt9AOGjzCRRWVBct1+xTrBSaCg+/yR2/uZikSLAk7Mw95k+5znhV8DoERdGO
 NJKDhZbnwsi0TwVx0DL6nC210twAksgGl6Y1P5DZwQh29B8iFODpEIh2BuEIexJkhkWZ
 /NdiDRzmX92t3sAwfUoYbdHVGWZqwYrxUhaXFPg2TH6FUwaQo4LZvLpJXU7fQPAvehU6
 Ji052Jd6XMQI0Z3EKEIhtJmJjUi1NseI7evRD1UNDhxiRoew4g88RDOnBMEYuQZct5Fr
 stvUDiID25/yjWHek0aIjv/dPgmSqD8i3dpzaAYl60jpfsVdYoRp59wFosLKgqim1V76
 6myg==
X-Gm-Message-State: AC+VfDzZYWnRcXIr5nToK6tfli7FTm6BQGJhk3Qtjmkr31dGR4ClNzux
 xiepqmSSe/GU5tnAXa+Je/7xA7WtxYs=
X-Google-Smtp-Source: ACHHUZ6+sl+l+zuedDR2LRUIRB6sxCHVVBdT9tzV4JiB2otIi8oPUFcdAUNp1gY5P1OZhcp9jKCI0u1SitE=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ba05:0:b0:ba8:95dd:3ccb with SMTP id
 t5-20020a25ba05000000b00ba895dd3ccbmr566879ybg.5.1684959365091; Wed, 24 May
 2023 13:16:05 -0700 (PDT)
Date: Wed, 24 May 2023 13:16:03 -0700
In-Reply-To: <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Mime-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
 <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Message-ID: <ZG5wg3VbG4rCYrfk@google.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
From: Sean Christopherson <seanjc@google.com>
To: Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc: Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, qemu-devel@nongnu.org, 
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, 
 Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
 Jeff Layton <jlayton@kernel.org>, 
 "J . Bruce Fields" <bfields@fieldses.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Steven Price <steven.price@arm.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Vlastimil Babka <vbabka@suse.cz>, 
 Vishal Annapurve <vannapurve@google.com>, Yu Zhang <yu.c.zhang@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, luto@kernel.org,
 jun.nakajima@intel.com, 
 dave.hansen@intel.com, ak@linux.intel.com, david@redhat.com, 
 aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com, 
 Quentin Perret <qperret@google.com>, Michael Roth <michael.roth@amd.com>,
 mhocko@suse.com, Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3hXBuZAYKCko4qmzvos00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--seanjc.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

On Wed, May 24, 2023, Kautuk Consul wrote:
> On 2023-05-23 07:19:43, Sean Christopherson wrote:
> > On Tue, May 23, 2023, Kautuk Consul wrote:
> > > On 2022-07-06 16:20:10, Chao Peng wrote:
> > > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > > index e9153b54e2a4..c262ebb168a7 100644
> > > > --- a/include/linux/kvm_host.h
> > > > +++ b/include/linux/kvm_host.h
> > > > @@ -765,10 +765,10 @@ struct kvm {
> > > >  
> > > >  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> > > >  	struct mmu_notifier mmu_notifier;
> > > > -	unsigned long mmu_notifier_seq;
> > > > -	long mmu_notifier_count;
> > > > -	gfn_t mmu_notifier_range_start;
> > > > -	gfn_t mmu_notifier_range_end;
> > > > +	unsigned long mmu_updating_seq;
> > > > +	long mmu_updating_count;
> > > 
> > > Can we convert mmu_updating_seq and mmu_updating_count to atomic_t ?
> > 
> > Heh, can we?  Yes.  Should we?  No.
> > 
> > > I see that not all accesses to these are under the kvm->mmu_lock
> > > spinlock.
> > 
> > Ya, working as intended.  Ignoring gfn_to_pfn_cache for the moment, all accesses
> > to mmu_invalidate_in_progress (was mmu_notifier_count / mmu_updating_count above)
> > are done under mmu_lock.  And for for mmu_notifier_seq (mmu_updating_seq above),
> > all writes and some reads are done under mmu_lock.  The only reads that are done
> > outside of mmu_lock are the initial snapshots of the sequence number.
> > 
> > gfn_to_pfn_cache uses a different locking scheme, the comments in
> > mmu_notifier_retry_cache() do a good job explaining the ordering.
> > 
> > > This will also remove the need for putting separate smp_wmb() and
> > > smp_rmb() memory barriers while accessing these structure members.
> > 
> > No, the memory barriers aren't there to provide any kind of atomicity.  The barriers
> > exist to ensure that stores and loads to/from the sequence and invalidate in-progress
> > counts are ordered relative to the invalidation (stores to counts) and creation (loads)
> > of SPTEs.  Making the counts atomic changes nothing because atomic operations don't
> > guarantee the necessary ordering.
> I'm not saying that the memory barriers provide atomicity.
> My comment was based on the assumption that "all atomic operations are
> implicit memory barriers". If that assumption is true then we won't need
> the memory barriers here if we use atomic operations for protecting
> these 2 structure members.

Atomics aren't memory barriers on all architectures, e.g. see the various
definitions of smp_mb__after_atomic().

Even if atomic operations did provide barriers, using an atomic would be overkill
and a net negative.  On strongly ordered architectures like x86, memory barriers are
just compiler barriers, whereas atomics may be more expensive.  Of course, the only
accesses outside of mmu_lock are reads, so on x86 that "atomic" access is just a
READ_ONCE() load, but that's not the case for all architectures.

Anyways, the point is that atomics and memory barriers are different things that
serve different purposes.

