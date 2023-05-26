Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E5712800
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:06:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Y4o-0000fN-AP; Fri, 26 May 2023 10:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamorris@linux.microsoft.com>)
 id 1q2NJW-0002mn-IY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:36:22 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jamorris@linux.microsoft.com>) id 1q2NJU-0000W9-UL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 22:36:22 -0400
Received: by linux.microsoft.com (Postfix, from userid 1001)
 id 1932320FBE98; Thu, 25 May 2023 19:36:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1932320FBE98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1685068578;
 bh=QsI2Tqrh7Dq8rATEw0dJAIe6Y8MEWIZaKj+0i4m1b94=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=rc/phama1ktXAiy+vs2NVCSXABwbcfYCYzvoNhWo6b4QznrBTZJyht2XFXGcOWpXT
 eN3vRQ77IyNVtRNsEt3dUwkwOKfWmDDqOGFtsKRkzHP0DTyYh3PuCH9zyVE+5kTU93
 rssQ3lVi3y4biGwhIuiBnmIaxdqEKLD8WYOLFyno=
Received: from localhost (localhost [127.0.0.1])
 by linux.microsoft.com (Postfix) with ESMTP id 1639D30013A9;
 Thu, 25 May 2023 19:36:18 -0700 (PDT)
Date: Thu, 25 May 2023 19:36:18 -0700 (PDT)
From: James Morris <jamorris@linux.microsoft.com>
To: =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
 Kees Cook <keescook@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Alexander Graf <graf@amazon.com>, Forrest Yuan Yu <yuanyu@google.com>, 
 John Andersen <john.s.andersen@intel.com>, 
 Liran Alon <liran.alon@oracle.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, 
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 =?UTF-8?Q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>, 
 =?UTF-8?Q?Nicu=C8=99or_C=C3=AE=C8=9Bu?= <nicu.citu@icloud.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Thara Gopinath <tgopinath@microsoft.com>, Will Deacon <will@kernel.org>, 
 Zahra Tarkhani <ztarkhani@microsoft.com>, 
 =?UTF-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>, 
 dev@lists.cloudhypervisor.org, kvm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
 x86@kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC PATCH v1 0/9] Hypervisor-Enforced Kernel Integrity
In-Reply-To: <20230505152046.6575-1-mic@digikod.net>
Message-ID: <17f62cb1-a5de-2020-2041-359b8e96b8c0@linux.microsoft.com>
References: <20230505152046.6575-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=jamorris@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -197
X-Spam_score: -19.8
X-Spam_bar: -------------------
X-Spam_report: (-19.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 May 2023 10:05:43 -0400
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

[Side topic]

Would folks be interested in a Linux Plumbers Conference MC on this 
topic generally, across different hypervisors, VMMs, and architectures?

If so, please let me know who the key folk would be and we can try writing 
up an MC proposal.



-- 
James Morris
<jamorris@linux.microsoft.com>

