Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0DD710023
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1wD9-0000Oz-GD; Wed, 24 May 2023 17:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3KIRuZAYKChUDzv84x19916z.x97Bz7F-yzGz689818F.9C1@flex--seanjc.bounces.google.com>)
 id 1q1wD7-0000Ob-5v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:39:58 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3KIRuZAYKChUDzv84x19916z.x97Bz7F-yzGz689818F.9C1@flex--seanjc.bounces.google.com>)
 id 1q1wD5-0001bt-99
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:39:56 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-564f529a663so16597337b3.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684964392; x=1687556392;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=u+lTI9LGfJCIeH9eUZOS37jnh9XivOrfiNHxwExkkPU=;
 b=1OM2n6A6XJR4jj8vE2JD/qVka6KhOa37sATKkJGdtzfw5ejGSX46cgRyM3KxfTglOD
 0RNiltYW0aqpSJK1ylM7pyVuNywmw3i8GLhqy6D8KbpUnlsiq///5XlVQOyARTMakL95
 sruDKzgA0kJWIRgwdNf60tHMZ2lnfSldT/PHutYtTTub50wqJp62S52UJsWvKQ7jpGPj
 JBND0HA8P6pXYHkEPXwT4zPgdYSplBBE7ttHpAHPL1RPyn6nSmxfEos2auwOVntQ9sEN
 x6n9gU3Z0Y/wI8zE55ONSW8DBiSo/6ReRvhBCmqYQEuA2BiS/6yDjqxNIpbAGpQ1wAiT
 KtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684964392; x=1687556392;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+lTI9LGfJCIeH9eUZOS37jnh9XivOrfiNHxwExkkPU=;
 b=L60XgrQIB8JmCpcOZlahCgi6w885z995N/HgZiQ9dbfJ976kL27zMdHr94+giT1gwR
 /Z3o/RIIb6u0lsu/tFMvGinlKWHo8BTjQo0O5toj53f7fdGmF3Cy7wEw1leFe0N3M5Ge
 llx3W4F/v1nKjP9GtwQSByaFvTQphlEz5By5bAeNJnBmfa5ng4jHSH4W14QwMr6pKeaH
 PH8GuuAQiB8Y/QZMKhBL3DzcwtDlU3cZmJ1J3aIge89ry+bpHoIh1GbViq5Sy16HK/7z
 lbj40ETyFeOoBAc7yUtIkGm6gWhladYikqFtCOCQhnDEeXGOwxt1XOqDspIPZd1prXPh
 WWPg==
X-Gm-Message-State: AC+VfDxiOE6WhecIcDu4Rk6XngyKHDxVGI/3vTzfAaOJANlBCMOwhUlc
 nJ2nha9x9J+DAhekoDmxx51B9FxB8io=
X-Google-Smtp-Source: ACHHUZ4gGkG32f/WDPDY+8DnC86QiU6Z2uyq9N2VVLscH3WfhLiakxSPFeyk8pWCaiTnq1AgYyU2vpbztC4=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ae14:0:b0:561:8bfb:feb1 with SMTP id
 m20-20020a81ae14000000b005618bfbfeb1mr12005442ywh.10.1684964392193; Wed, 24
 May 2023 14:39:52 -0700 (PDT)
Date: Wed, 24 May 2023 14:39:50 -0700
In-Reply-To: <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
 <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZG5wg3VbG4rCYrfk@google.com>
 <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
Message-ID: <ZG6EJoXbduApRsgV@google.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kautuk Consul <kconsul@linux.vnet.ibm.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3KIRuZAYKChUDzv84x19916z.x97Bz7F-yzGz689818F.9C1@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

On Wed, May 24, 2023, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 01:16:03PM -0700, Sean Christopherson wrote:
> > Of course, the only accesses outside of mmu_lock are reads, so on x86 that
> > "atomic" access is just a READ_ONCE() load, but that's not the case for all
> > architectures.
> 
> This is true on *all* archs. atomic_set() and atomic_read() are no more
> and no less than WRITE_ONCE() / READ_ONCE().

Ah, I take it s390's handcoded assembly routines are just a paranoid equivalents
and not truly special?  "l" and "st" do sound quite generic...

  commit 7657e41a0bd16c9d8b3cefe8fd5d6ac3c25ae4bf
  Author: Heiko Carstens <hca@linux.ibm.com>
  Date:   Thu Feb 17 13:13:58 2011 +0100

    [S390] atomic: use inline asm
    
    Use inline assemblies for atomic_read/set(). This way there shouldn't
    be any questions or subtle volatile semantics left.

static inline int __atomic_read(const atomic_t *v)
{
	int c;

	asm volatile(
		"	l	%0,%1\n"
		: "=d" (c) : "R" (v->counter));
	return c;
}

static inline void __atomic_set(atomic_t *v, int i)
{
	asm volatile(
		"	st	%1,%0\n"
		: "=R" (v->counter) : "d" (i));
}

