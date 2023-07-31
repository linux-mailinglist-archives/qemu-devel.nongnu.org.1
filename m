Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75376A2EE
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:35:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQaX8-00061H-JA; Mon, 31 Jul 2023 17:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <33yjIZAYKCn4ugcpleiqqing.eqosgow-fgxgnpqpipw.qti@flex--seanjc.bounces.google.com>)
 id 1qQaX6-00060j-10
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:34:28 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <33yjIZAYKCn4ugcpleiqqing.eqosgow-fgxgnpqpipw.qti@flex--seanjc.bounces.google.com>)
 id 1qQaX4-0007Vx-6R
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:34:27 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d1851c52f3dso5020110276.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1690839264; x=1691444064;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=M5PijTkKav0RbsyrIfhOctghYsaDBtN0ksxtjkS2E3o=;
 b=C0RbbGvOmjlaHwoKOsVpABwkCgeBUojMJFqgHU3e7vn15TlMqi1/GNvhNBr/DnEblT
 S8ZKcXn9FhHXU6Yj2FL9z3P28LftMDsFJINcnv7hMEfCMCiavOoY20xAYb2rKktsEXOQ
 z5mBH169/JCPSbEIjZKLnQSMZ2Lld4QepdWvrkyww+Ss+NROk6emb1u+3nQvPpplchJb
 r3rGneDiJH1dEhxqhZbiyHtJIwY5il8SoHkjYv0GA2OczLFUEaI5dmW2MdSUO6wdGWBp
 FWCteCKEOMuivXPiXwICBYH89yRdMlkWwlrrSGNVh/UZS9rCQIXS+3ZUJNbqlJ3Kl2Wv
 AGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690839264; x=1691444064;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M5PijTkKav0RbsyrIfhOctghYsaDBtN0ksxtjkS2E3o=;
 b=JnWyxn30JwZF+sqGY76vF+LBr2lnjjMFMETVM14oYPM7wiuAABQqmJjOeF/Hf8E/ks
 AnbUYxRBv3Po4iQOp+OH1pqgg65H7OM0ADe2hkH+TLY5Q71ThFYMW7vsEeLFJRRjp4gI
 0WvYFvpp2ck1H6UBOWu7HynWKyIXjVdyyNc7ptxph3EJJAp02ta9VRk19RiANV0DGszp
 uzRw8GuGpZLq3Uq708S2g+30Elgu55VecL76ZbIJdTqlqDvAnvYx8kKmqbau5YEbE2wh
 WIthk31ONlGEnRBcUZYEwEm769z9tbzzqMtJNBgP0OZQG75MK2IzoqVyKbs8vBuvvVBl
 TADA==
X-Gm-Message-State: ABy/qLb4oFaG5WQ3e+awS/2eEDEYqDJcH19+J0oPenIddsiqKuDW6CtV
 9ABuazmng/mCxwOgLPXk0b7AZsjinn8=
X-Google-Smtp-Source: APBJJlHV+T8Txgl9BRU07jWBBYiAgSiNRp0sLaahO8lqY0D8EU4ErMu5NzAPx8L+vujcfg4Us62xnatJqHs=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2042:0:b0:cb6:6c22:d0f8 with SMTP id
 g63-20020a252042000000b00cb66c22d0f8mr66923ybg.4.1690839263932; Mon, 31 Jul
 2023 14:34:23 -0700 (PDT)
Date: Mon, 31 Jul 2023 14:34:22 -0700
In-Reply-To: <ZMgma0cRi/lkTKSz@x1n>
Mime-Version: 1.0
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
 <ZMgma0cRi/lkTKSz@x1n>
Message-ID: <ZMgo3mGKtoQ7QsB+@google.com>
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
From: Sean Christopherson <seanjc@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 "Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=" <berrange@redhat.com>, 
 "Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=33yjIZAYKCn4ugcpleiqqing.eqosgow-fgxgnpqpipw.qti@flex--seanjc.bounces.google.com;
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

On Mon, Jul 31, 2023, Peter Xu wrote:
> On Mon, Jul 31, 2023 at 12:21:46PM -0400, Xiaoyao Li wrote:
> > +bool memory_region_can_be_private(MemoryRegion *mr)
> > +{
> > +    return mr->ram_block && mr->ram_block->gmem_fd >= 0;
> > +}
> 
> This is not really MAP_PRIVATE, am I right?  If so, is there still chance
> we rename it (it seems to be also in the kernel proposal all across..)?

Yes and yes.

> I worry it can be very confusing in the future against MAP_PRIVATE /
> MAP_SHARED otherwise.

Heh, it's already quite confusing at times.  I'm definitely open to naming that
doesn't collide with MAP_{PRIVATE,SHARED}, especially if someone can come with a
naming scheme that includes a succinct way to describe memory that is shared
between two or more VMs, but is accessible to _only_ those VMs.

