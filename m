Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07279A7F2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfg6J-00049j-8c; Mon, 11 Sep 2023 08:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfg6H-00049G-AA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfg67-0003Yk-Oz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694435577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFPCeboRoy4KTxZvptyVuhnmEIMckSskZ+HTU8JbYgA=;
 b=fGh7gJD8Zm8yMqtnxquHod9Mq/PptUm7nzWnhz13sKj1YPvRj6bHU68LU+PqYiNIynXANh
 G3a6mrmal/2jzcUF+2cF7Ri8mZZBvIt1R4j9rh2ncDbW2h94y+tKqlkS2Yejgm0+P7HCLJ
 kUhRNE+KlVNuihdpDbicDqY5uGHXHi8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-qh0rTVqsO6mWZZi3P6f0TQ-1; Mon, 11 Sep 2023 08:32:55 -0400
X-MC-Unique: qh0rTVqsO6mWZZi3P6f0TQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485101C05AAA;
 Mon, 11 Sep 2023 12:32:55 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ED9A2156701;
 Mon, 11 Sep 2023 12:32:53 +0000 (UTC)
Date: Mon, 11 Sep 2023 14:32:52 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Message-ID: <ZP8I9B3O4CTwTTie@redhat.com>
References: <20230911103832.23596-1-philmd@linaro.org>
 <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 11.09.2023 um 13:15 hat Stefan Hajnoczi geschrieben:
> On Mon, 11 Sept 2023 at 06:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > Since commits 3adce820cf..ef1cf6890f, When building on
> > a x86 host configured as:
> >
> >   $ ./configure --cc=clang \
> >     --target-list=x86_64-linux-user,x86_64-softmmu \
> >     --enable-debug
> >
> > we get:
> >
> >   [71/71] Linking target qemu-x86_64
> >   FAILED: qemu-x86_64
> >   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
> >   cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
> >   cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' follow
> >   clang: error: linker command failed with exit code 1 (use -v to see invocation)
> >   ninja: build stopped: subcommand failed.
> >
> > '--enable-debug' disables optimizations (CFLAGS=-O0).
> >
> > While at this (un)optimization level GCC eliminate the
> > following dead code:
> >
> >   if (0 && foo()) {
> >       ...
> >   }
> >
> > Clang does not. Therefore restore a pair of stubs for
> > unoptimized Clang builds.
> >
> > Reported-by: Kevin Wolf <kwolf@redhat.com>
> > Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
> > Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> > index 55d4e68c34..0b62ac628f 100644
> > --- a/target/i386/kvm/kvm_i386.h
> > +++ b/target/i386/kvm/kvm_i386.h
> > @@ -32,7 +32,6 @@
> >
> >  bool kvm_has_smm(void);
> >  bool kvm_enable_x2apic(void);
> > -bool kvm_hv_vpindex_settable(void);
> >  bool kvm_has_pit_state2(void);
> >
> >  bool kvm_enable_sgx_provisioning(KVMState *s);
> > @@ -41,8 +40,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
> >  void kvm_arch_reset_vcpu(X86CPU *cs);
> >  void kvm_arch_after_reset_vcpu(X86CPU *cpu);
> >  void kvm_arch_do_init_vcpu(X86CPU *cs);
> > -uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
> > -                                      uint32_t index, int reg);
> >  uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index);
> >
> >  void kvm_set_max_apic_id(uint32_t max_apic_id);
> > @@ -60,6 +57,10 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
> >
> >  bool kvm_has_x2apic_api(void);
> >  bool kvm_has_waitpkg(void);
> > +bool kvm_hv_vpindex_settable(void);
> > +
> > +uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
> > +                                      uint32_t index, int reg);
> >
> >  uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
> >  void kvm_update_msi_routes_all(void *private, bool global,
> > @@ -76,6 +77,20 @@ typedef struct kvm_msr_handlers {
> >  bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> >                      QEMUWRMSRHandler *wrmsr);
> >
> > +#elif defined(__clang__) && !defined(__OPTIMIZE__)
> 
> Another approach is a static library with a .o file containing the
> stubs so the linker only includes it in the executable if the compiler
> emitted the symbols. That way there is no need for defined(__clang__)
> && !defined(__OPTIMIZE__) and it will work with other
> compilers/optimization levels. It's more work to set up though.

Isn't that exactly how it was before the stubs were removed? It would be
a simple revert of that commit.

The approach with static inline functions defined only for a very
specific configuration looks a lot more fragile to me. In fact, I'm
surprised that it works because I think it requires that the header
isn't used in any files that are shared between user space and system
emulation - and naively cpu.c sounded like something that could be
shared. Looks like this patch only works because the linux-user target
uses a separate build of the same CPU emulation source file.

So I think reverting the commit that removed the stubs would be much
more obvious.

Kevin


