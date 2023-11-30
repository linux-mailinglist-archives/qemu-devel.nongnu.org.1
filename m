Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AB7FF44E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:02:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jTo-0004Wq-QA; Thu, 30 Nov 2023 11:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <31LFoZQYKCg05rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com>)
 id 1r8jTl-0004W6-2B
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:01:29 -0500
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <31LFoZQYKCg05rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com>)
 id 1r8jTj-000281-45
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:01:28 -0500
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-6cdf7577159so201443b3a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701360084; x=1701964884; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=TBtFesakrb+Ah3nRlWp+HFJboe/l0BTz8gE0NQu+vCI=;
 b=xcIRVsD+ukBOx1J+jIAD+H/slJ0Fgz7FLoOk40Uw8YW6a3B6ml4m49QFEybXnXDbLc
 7s3DoNPWZjnW85HWJlBVc433u5unRFUjV8ZSRz1YCXlnyU2FYPp2tqS5JFUZ8ENuXs06
 xUhfRi5/rLISMFINzbc9h72xpSRvS9vdm7qGZ1kVByRrKp2n/8mT0+XPHUk0oRb8mdV6
 MmN3xeQzYu4yerDjHfPDpsxCi7TpdBiT04E8S1YsPkFF9YTkuSr+bxrPg5chsOFW1HKX
 QDJfB9FBiFR2lha4/tIdpMm/x+caJVcmklBwTpRaEnU6DbtC8JE66pV9YypLXgCiabyZ
 8acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701360084; x=1701964884;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBtFesakrb+Ah3nRlWp+HFJboe/l0BTz8gE0NQu+vCI=;
 b=AVadW2v8+GNFAk6leuWlG6nkYNQNEwtF4S69QD6KwY9rskTrLPUnN8Fn+zRi1wiJ/6
 QA39uKPNvqLunnF3vGf6Q6dDdqMAGlg3erL3zv1dkwK6q/Xgs7bYV10n2cildvU3eOAh
 UvvBBKXfaP7eNNbk1RRAf+nEUKaLrvDbAqAccK6yJE1MDyfkOeshUZq3vTaEZkb5XajX
 GzF7oKsY8UhIlz4odVyvwpwoRK2x2iskqeedJHBDvRTW6Km6e9wHi6moDunpCBAd9KAZ
 ZvTitvS/WnV3fJGEFBlJhVBNG3P/5NY5IjB7XcPPSpF2tWPwbK+KT5D+MFHpCwJ0PKit
 JyPw==
X-Gm-Message-State: AOJu0Yx2O1P9/3H5kabRhJm0byjNmN9SneeWkMQgVo6uoroRIxp2nH3F
 fmOPG9sp42QO3aNIn7J6RYFj2mhJWb4=
X-Google-Smtp-Source: AGHT+IHi1+aV1vTTHXffZIk3uV4OpjjgxAUEw1/XhdrYnAn5A/NF0XwlraUoBa+fvhAQi1+OPSaHBc3mP7A=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:21d3:b0:6cb:ba28:b6f1 with SMTP id
 t19-20020a056a0021d300b006cbba28b6f1mr5640398pfj.5.1701360084488; Thu, 30 Nov
 2023 08:01:24 -0800 (PST)
Date: Thu, 30 Nov 2023 08:01:22 -0800
In-Reply-To: <45d28654-9565-46df-81b9-6563a4aef78c@redhat.com>
Mime-Version: 1.0
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-4-xiaoyao.li@intel.com>
 <bc84fa4f-4866-4321-8f30-1388eed7e64f@redhat.com>
 <05f0e440-36a2-4d3a-8caa-842b34e50dce@intel.com>
 <0fbfc413-7c74-4b2a-bade-6f3f04ca82c2@redhat.com>
 <4708c33a-bb8d-484e-ac7b-b7e8d3ed445a@intel.com>
 <45d28654-9565-46df-81b9-6563a4aef78c@redhat.com>
Message-ID: <ZWixXm-sboNZ-mzG@google.com>
Subject: Re: [PATCH v3 03/70] RAMBlock/guest_memfd: Enable
 KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Peter Xu <peterx@redhat.com>,
 "Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 "Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?=" <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>, 
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, 
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=31LFoZQYKCg05rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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

On Thu, Nov 30, 2023, David Hildenbrand wrote:
> On 30.11.23 08:32, Xiaoyao Li wrote:
> > On 11/20/2023 5:26 PM, David Hildenbrand wrote:
> > > 
> > > > > ... did you shamelessly copy that from hw/virtio/virtio-mem.c ? ;)
> > > > 
> > > > Get caught.
> > > > 
> > > > > This should be factored out into a common helper.
> > > > 
> > > > Sure, will do it in next version.
> > > 
> > > Factor it out in a separate patch. Then, this patch is get small that
> > > you can just squash it into #2.
> > > 
> > > And my comment regarding "flags = 0" to patch #2 does no longer apply :)
> > > 
> > 
> > I see.
> > 
> > But it depends on if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE will appear together
> > with initial guest memfd in linux (hopefully 6.8)
> > https://lore.kernel.org/all/CABgObfa=DH7FySBviF63OS9sVog_wt-AqYgtUAGKqnY5Bizivw@mail.gmail.com/
> > 
> 
> Doesn't seem to be in -next if I am looking at the right tree:
> 
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=next

Yeah, we punted on adding hugepage support for the initial guest_memfd merge so
as not to rush in kludgy uABI.  The internal KVM code isn't problematic, we just
haven't figured out exactly what the ABI should look like, e.g. should hugepages
be dependent on THP being enabled, and if not, how does userspace discover the
supported hugepage sizes?

