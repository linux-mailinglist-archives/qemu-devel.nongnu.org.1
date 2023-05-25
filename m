Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B7671106D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DUZ-0006wR-9k; Thu, 25 May 2023 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3pYdvZAYKCpwOA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com>)
 id 1q2DUX-0006wF-EX
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:07:05 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3pYdvZAYKCpwOA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com>)
 id 1q2DUV-0002gD-OL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:07:05 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-ba8bab3b392so1634087276.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685030822; x=1687622822;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=T8fhdJsa5NorDsEqTWIJQ5b4Ve27T8A/3D8mN23h+AM=;
 b=FEqq2WYT2bpFD+1TtSHkaFzNdRiEuyI2g6NACjIvhMwGd2nTXz/TFAkSgH9Ujas6q/
 vhfG2wZKYTJDUOpnLW2+ofbeXlQQzMc4kCX+fmSU72PlK4P1Bu6ChRJwig3K6o+kmK9V
 pCl4CF26O5Po2Isyv/JlTTvFCsfs3ZUrFwA7UHCTWbISgu9JRVShkNuOUaec2GLwo+qR
 9KOOx1CsOYaN5w2VTeTg1ACrMvUsp1nWuR5WaKwUiyP0rqYNcgG1cqc/7vdfOhawEkwt
 dDqOiNZlzeyBYZO39XTCtpGesfMZs3DSR4tffu8EiIq8HLxLRNoWCQV/DwcUzn5RT3NK
 ujWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685030822; x=1687622822;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T8fhdJsa5NorDsEqTWIJQ5b4Ve27T8A/3D8mN23h+AM=;
 b=M5yv/+FHmqk3kXbWGVCLnzmACWc5/CKP8FRQQhzlJFUNu72AYqIAtmhLzBoxCASRuR
 tkExNM3eYjf5Yz8LJ0ViGI2i4+1BtpA7re9N6UgxF/LUre8wwXs3yQ4/m8FmlzW41/Bg
 WSn+ddIWqOgD1U0eE3xfRRhVHol5Dhb+MUZlBHrdbWgpTKzrccfKQtbhQKFyWV3MR2ET
 7RjFbQe16aAeRuHGUesKYGc5DsQudYVYGfHGTWmQAHxHF7KKt+nplI+Ih4ow3vZKCmfJ
 vUTPInHCsEdB6/B4UHtygl/tniTwpwjGmA01N7wW8JR90836uVxnYOfdnUUT9+oAxeyr
 jS/w==
X-Gm-Message-State: AC+VfDyfwpYa2EiHMSZpJoi7agBdQvd8lOylbpfNLVOBH7Rq6krJ1ius
 pEK0a+4bYyNR/pJ4RNRBhGZSNjy1SI0=
X-Google-Smtp-Source: ACHHUZ6yBYNFZuYhfNGO52o3ys/I0sQ5pEx4h3FPL/IsVNBvdz1hiS3BsLpfaNj0iWMqAGXV//6VIasdS2w=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:6584:0:b0:ba8:381b:f764 with SMTP id
 z126-20020a256584000000b00ba8381bf764mr2233557ybb.3.1685030821985; Thu, 25
 May 2023 09:07:01 -0700 (PDT)
Date: Thu, 25 May 2023 09:07:00 -0700
In-Reply-To: <7cb6c4c28c077bb9f866c2d795e918610e77d49f.camel@intel.com>
Mime-Version: 1.0
References: <20230505152046.6575-1-mic@digikod.net>
 <93726a7b9498ec66db21c5792079996d5fed5453.camel@intel.com>
 <facfd178-3157-80b4-243b-a5c8dabadbfb@digikod.net>
 <7cb6c4c28c077bb9f866c2d795e918610e77d49f.camel@intel.com>
Message-ID: <ZG+HpFjIuSWvyo+B@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3pYdvZAYKCpwOA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

On Thu, May 25, 2023, Rick P Edgecombe wrote:
> I wonder if it might be a good idea to POC the guest side before
> settling on the KVM interface. Then you can also look at the whole
> thing and judge how much usage it would get for the different options
> of restrictions.

As I said earlier[*], IMO the control plane logic needs to live in host userspace.
I think any attempt to have KVM providen anything but the low level plumbing will
suffer the same fate as CR4 pinning and XO memory.  Iterating on an imperfect
solution to incremently improve security is far, far easier to do in userspace,
and far more likely to get merged.

[*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com

