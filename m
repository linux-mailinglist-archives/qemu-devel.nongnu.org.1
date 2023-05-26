Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD984712959
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZGn-0001I9-4V; Fri, 26 May 2023 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1q2ZGh-0001Hn-De
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:22:16 -0400
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mic@digikod.net>) id 1q2ZGf-0001Zq-HD
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:22:15 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
 by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4QSTDb2m0HzMqJtD;
 Fri, 26 May 2023 17:22:07 +0200 (CEST)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4QSTDW5jBkzMpq8r; Fri, 26 May 2023 17:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
 s=20191114; t=1685114527;
 bh=q+ImSjEjmZCszdCMwbCdSpVg4DvQ3poPxVGa8t7f7U4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=tQXLni40CMr4EfzplXOAcaiNi5QkukQ3CoKpUm7sPlK7iwEW6fPx8nY8GaaUiadIG
 M5KO5fQyWE3EVFklsTrG7jSk0ERYB4XC8Vvc3kkq30lc7cfnaZ5NXLcagUfQK3M2xQ
 HRaKSJVPM1hu3rh60mZzFma3PA+dy4ElTuUEFWyU=
Message-ID: <58a803f6-c3de-3362-673f-767767a43f9c@digikod.net>
Date: Fri, 26 May 2023 17:22:03 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [RFC PATCH v1 0/9] Hypervisor-Enforced Kernel Integrity
Content-Language: en-US
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Christopherson,, Sean" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "wanpengli@tencent.com" <wanpengli@tencent.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "yuanyu@google.com" <yuanyu@google.com>,
 "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
 "marian.c.rotariu@gmail.com" <marian.c.rotariu@gmail.com>,
 "Graf, Alexander" <graf@amazon.com>,
 "Andersen, John S" <john.s.andersen@intel.com>,
 "madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 "ssicleru@bitdefender.com" <ssicleru@bitdefender.com>,
 "tgopinath@microsoft.com" <tgopinath@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "will@kernel.org"
 <will@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "dev@lists.cloudhypervisor.org" <dev@lists.cloudhypervisor.org>,
 "mdontu@bitdefender.com" <mdontu@bitdefender.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "nicu.citu@icloud.com" <nicu.citu@icloud.com>,
 "ztarkhani@microsoft.com" <ztarkhani@microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <20230505152046.6575-1-mic@digikod.net>
 <93726a7b9498ec66db21c5792079996d5fed5453.camel@intel.com>
 <facfd178-3157-80b4-243b-a5c8dabadbfb@digikod.net>
In-Reply-To: <facfd178-3157-80b4-243b-a5c8dabadbfb@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Received-SPF: pass client-ip=83.166.143.175; envelope-from=mic@digikod.net;
 helo=smtp-8faf.mail.infomaniak.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 25/05/2023 15:59, Mickaël Salaün wrote:
> 
> On 25/05/2023 00:20, Edgecombe, Rick P wrote:
>> On Fri, 2023-05-05 at 17:20 +0200, Mickaël Salaün wrote:
>>> # How does it work?
>>>
>>> This implementation mainly leverages KVM capabilities to control the
>>> Second
>>> Layer Address Translation (or the Two Dimensional Paging e.g.,
>>> Intel's EPT or
>>> AMD's RVI/NPT) and Mode Based Execution Control (Intel's MBEC)
>>> introduced with
>>> the Kaby Lake (7th generation) architecture. This allows to set
>>> permissions on
>>> memory pages in a complementary way to the guest kernel's managed
>>> memory
>>> permissions. Once these permissions are set, they are locked and
>>> there is no
>>> way back.
>>>
>>> A first KVM_HC_LOCK_MEM_PAGE_RANGES hypercall enables the guest
>>> kernel to lock
>>> a set of its memory page ranges with either the HEKI_ATTR_MEM_NOWRITE
>>> or the
>>> HEKI_ATTR_MEM_EXEC attribute. The first one denies write access to a
>>> specific
>>> set of pages (allow-list approach), and the second only allows kernel
>>> execution
>>> for a set of pages (deny-list approach).
>>>
>>> The current implementation sets the whole kernel's .rodata (i.e., any
>>> const or
>>> __ro_after_init variables, which includes critical security data such
>>> as LSM
>>> parameters) and .text sections as non-writable, and the .text section
>>> is the
>>> only one where kernel execution is allowed. This is possible thanks
>>> to the new
>>> MBEC support also brough by this series (otherwise the vDSO would
>>> have to be
>>> executable). Thanks to this hardware support (VT-x, EPT and MBEC),
>>> the
>>> performance impact of such guest protection is negligible.
>>>
>>> The second KVM_HC_LOCK_CR_UPDATE hypercall enables guests to pin some
>>> of its
>>> CPU control register flags (e.g., X86_CR0_WP, X86_CR4_SMEP,
>>> X86_CR4_SMAP),
>>> which is another complementary hardening mechanism.
>>>
>>> Heki can be enabled with the heki=1 boot command argument.
>>>
>>>
>>
>> Can the guest kernel ask the host VMM's emulated devices to DMA into
>> the protected data? It should go through the host userspace mappings I
>> think, which don't care about EPT permissions. Or did I miss where you
>> are protecting that another way? There are a lot of easy ways to ask
>> the host to write to guest memory that don't involve the EPT. You
>> probably need to protect the host userspace mappings, and also the
>> places in KVM that kmap a GPA provided by the guest.
> 
> Good point, I'll check this confused deputy attack. Extended KVM
> protections should indeed handle all ways to map guests' memory. I'm
> wondering if current VMMs would gracefully handle such new restrictions
> though.

I guess the host could map arbitrary data to the guest, so that need to 
be handled, but how could the VMM (not the host kernel) bypass/update 
EPT initially used for the guest (and potentially later mapped to the host)?

