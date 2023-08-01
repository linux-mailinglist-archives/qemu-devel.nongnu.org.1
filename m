Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA676B999
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQs9y-0000JX-2J; Tue, 01 Aug 2023 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3hTHJZAYKCjooaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com>)
 id 1qQs9r-0000Iz-BR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:23:39 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3hTHJZAYKCjooaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com>)
 id 1qQs9p-0006kg-Sf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:23:39 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-56cf9a86277so72601937b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1690907013; x=1691511813;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=NgZSQqVHoMoE0f+lS5e3QWSUOJFOEE52tAnc49VIYRg=;
 b=1d0AeLxpW6AaqQYKp6bsfKUSfvqCTazQibc601NnJqqQxWwpSfkc0bkzGIAScujRWR
 5GYNHlVns/SMJIfjbI4qCaIBNuwRx9qiQFS/4LI8uhcC4qRKqxjw3M7ZT3BheRJxo4sG
 UKhhpv6QGYKf8tMSiksOV42hayAmOUAKI6BOs+c50Xnddf1KIoVcx4KUjtB3cSLX/2D6
 HUGlQuNsjvTD6GLe9pchnYC5DO71KiLwfGbA4O10lnmzbxTKXdhKaLcMnkdFWr2kveON
 8nqH05tVlHXqtwLmipIIinCuYxrEQ5MFIyQ5bYFqPl8zgF9UY13ULRvTqpawV7ZB+Fpv
 9ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690907013; x=1691511813;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NgZSQqVHoMoE0f+lS5e3QWSUOJFOEE52tAnc49VIYRg=;
 b=EPnAbzngIr3pxTFn8WVbfA5J72wUgOnYti42spkjyEDeo32ZJBi/+XTtJLudc4ZLpP
 e3Q5O0N6xdixG9WvS1x4GeBdSNVTxsUTvUwF4T8y/tfPbFMVnk/zN1+z/HEIvOKnlZge
 +S0f+19xyvr3RhVR94GEfMW4HyIIewK3C7mLqgPuWe0qfQDGe1Le6bIB6+V+NkVP+nDw
 2cHdJCQ6lkW9TV2+j/krHoxXz8nhktpcZAMAvLFZ5kIQfeBTc5MScVO9lYtwdb3QKsSr
 I3dPJ/jUlAepKUGbiPrslWnVmpWmWgsEO0ySHC4Eb62AEPGhi72dSgzbOvUeU3fiS58b
 1j7g==
X-Gm-Message-State: ABy/qLZclYDPvAJ/6zlgg6OjcfimGL1PkbyTglDjTd4MHe20sMvpMzW+
 T7S0z0e1vlmFKbdB5yP71FLIRL8aERI=
X-Google-Smtp-Source: APBJJlHFG1aWzseIj2/abAfwCu1Bgk1T523XeBUXRqAUKi+lEhA3pqwo6TwG4Ih2Lc8QYauvbY3mcrh0aww=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4144:0:b0:586:4dec:80b6 with SMTP id
 f4-20020a814144000000b005864dec80b6mr50325ywk.1.1690907013406; Tue, 01 Aug
 2023 09:23:33 -0700 (PDT)
Date: Tue, 1 Aug 2023 09:23:31 -0700
In-Reply-To: <ZMhQGi6MuHfyvNS9@x1n>
Mime-Version: 1.0
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
 <ZMgma0cRi/lkTKSz@x1n> <ZMgo3mGKtoQ7QsB+@google.com>
 <20230731173607-mutt-send-email-mst@kernel.org>
 <ZMhQGi6MuHfyvNS9@x1n>
Message-ID: <ZMkxg0+vmehOmSL5@google.com>
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
From: Sean Christopherson <seanjc@google.com>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3hTHJZAYKCjooaWjfYckkcha.Ykimaiq-Zarahjkjcjq.knc@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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
> On Mon, Jul 31, 2023 at 05:36:37PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 31, 2023 at 02:34:22PM -0700, Sean Christopherson wrote:
> > > On Mon, Jul 31, 2023, Peter Xu wrote:
> > > > On Mon, Jul 31, 2023 at 12:21:46PM -0400, Xiaoyao Li wrote:
> > > > > +bool memory_region_can_be_private(MemoryRegion *mr)
> > > > > +{
> > > > > +    return mr->ram_block && mr->ram_block->gmem_fd >= 0;
> > > > > +}
> > > > 
> > > > This is not really MAP_PRIVATE, am I right?  If so, is there still chance
> > > > we rename it (it seems to be also in the kernel proposal all across..)?
> > > 
> > > Yes and yes.
> > > 
> > > > I worry it can be very confusing in the future against MAP_PRIVATE /
> > > > MAP_SHARED otherwise.
> > > 
> > > Heh, it's already quite confusing at times.  I'm definitely open to naming that
> > > doesn't collide with MAP_{PRIVATE,SHARED}, especially if someone can come with a
> > > naming scheme that includes a succinct way to describe memory that is shared
> > > between two or more VMs, but is accessible to _only_ those VMs.
> > 
> > Standard solution is a technology specific prefix.
> > protect_shared, encrypt_shared etc.
> 
> Agreed, a prefix could definitely help (if nothing better comes at last..).
> If e.g. "encrypted" too long to be applied everywhere in var names and
> functions, maybe it can also be "enc_{private|shared}".

FWIW, I would stay away from "encrypted", there is no requirement that the memory
actually be encrypted.

