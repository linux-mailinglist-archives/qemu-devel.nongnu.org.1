Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D940970FF83
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 22:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vUC-0003eF-62; Wed, 24 May 2023 16:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <madvenka@linux.microsoft.com>)
 id 1q1vU8-0003e7-Gy
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:53:28 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <madvenka@linux.microsoft.com>) id 1q1vU5-0005Cx-Ac
 for qemu-devel@nongnu.org; Wed, 24 May 2023 16:53:27 -0400
Received: from [192.168.4.26] (unknown [47.186.50.133])
 by linux.microsoft.com (Postfix) with ESMTPSA id E7B6E20FBA6D;
 Wed, 24 May 2023 13:53:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7B6E20FBA6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1684961602;
 bh=jaoGaATWl6qH0LBuT7PMpFhq3wR8UB0SRjcinmr2MGw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gdGCklkn+W2FG8nWXMknVmZRf7MOqfBXFQSg1XVTieJjYv2pZpbSK13nBh6SaoEhT
 jcL639wc1nVXAHEnmQmaX6AIuaD25yFRRA9zSSEUAf6N/FK7V8PguD80UGHHcNbtZY
 /rfQmT61JJHHOojvC0XgtjYl2COQYPXjTiszLZkM=
Message-ID: <b1ffbf50-7728-64a1-5d46-10331a17530d@linux.microsoft.com>
Date: Wed, 24 May 2023 15:53:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/9] KVM: x86/mmu: Add support for prewrite page
 tracking
To: Sean Christopherson <seanjc@google.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexander Graf <graf@amazon.com>, Forrest Yuan Yu <yuanyu@google.com>,
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>, Liran Alon
 <liran.alon@oracle.com>, Marian Rotariu <marian.c.rotariu@gmail.com>,
 =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
 =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Thara Gopinath <tgopinath@microsoft.com>, Will Deacon <will@kernel.org>,
 Zahra Tarkhani <ztarkhani@microsoft.com>,
 =?UTF-8?Q?=c8=98tefan_=c8=98icleru?= <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 x86@kernel.org, xen-devel@lists.xenproject.org
References: <20230505152046.6575-1-mic@digikod.net>
 <20230505152046.6575-3-mic@digikod.net> <ZFUumGdZDNs1tkQA@google.com>
 <6412bf27-4d05-eab8-3db1-d4efa44af3aa@digikod.net>
 <ZFU9YzqG/T+Ty9gY@google.com>
Content-Language: en-US
From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <ZFU9YzqG/T+Ty9gY@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=madvenka@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -198
X-Spam_score: -19.9
X-Spam_bar: -------------------
X-Spam_report: (-19.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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



On 5/5/23 12:31, Sean Christopherson wrote:
> On Fri, May 05, 2023, Mickaï¿½l Salaï¿½n wrote:
>>
>> On 05/05/2023 18:28, Sean Christopherson wrote:
>>> I have no doubt that we'll need to solve performance and scaling issues with the
>>> memory attributes implementation, e.g. to utilize xarray multi-range support
>>> instead of storing information on a per-4KiB-page basis, but AFAICT, the core
>>> idea is sound.  And a very big positive from a maintenance perspective is that
>>> any optimizations, fixes, etc. for one use case (CoCo vs. hardening) should also
>>> benefit the other use case.
>>>
>>> [1] https://lore.kernel.org/all/20230311002258.852397-22-seanjc@google.com
>>> [2] https://lore.kernel.org/all/Y2WB48kD0J4VGynX@google.com
>>> [3] https://lore.kernel.org/all/Y1a1i9vbJ%2FpVmV9r@google.com
>>
>> I agree, I used this mechanism because it was easier at first to rely on a
>> previous work, but while I was working on the MBEC support, I realized that
>> it's not the optimal way to do it.
>>
>> I was thinking about using a new special EPT bit similar to
>> EPT_SPTE_HOST_WRITABLE, but it may not be portable though. What do you
>> think?
> 
> On x86, SPTEs are even more ephemeral than memslots.  E.g. for historical reasons,
> KVM zaps all SPTEs if _any_ memslot is deleted, which is problematic if the guest
> is moving around BARs, using option ROMs, etc.
> 
> ARM's pKVM tracks metadata in its stage-2 PTEs, i.e. doesn't need an xarray to
> otrack attributes, but that works only because pKVM is more privileged than the
> host kernel, and the shared vs. private memory attribute that pKVM cares about
> is very, very restricted in how it can be used and changed.
> 
> I tried shoehorning private vs. shared metadata into x86's SPTEs in the past, and
> it ended up being a constant battle with the kernel, e.g. page migration, and with
> KVM itself, e.g. the above memslot mess.

Sorry for the delay in responding to this. I wanted to study the KVM code and fully
understand your comment before responding.

Yes, I quite agree with you. I will make an attempt to address this in the next version.
I am working on it right now.

Thanks.

Madhavan

