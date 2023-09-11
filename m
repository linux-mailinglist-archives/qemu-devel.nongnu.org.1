Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60B79A797
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfezy-0002XP-Iw; Mon, 11 Sep 2023 07:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qfezw-0002TX-8g
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qfezt-0006hk-GW
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694431348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FY1xnhXgLb3MKZYXgZ+3L/SjT5+gXejZiBkpCQ3k5I4=;
 b=VMeFvkx4mhjZV0nn1c3bqbw+7LLu3VL9THyU1xYqheeFBumT1gCstE6U7mUNrXv1bf4wUY
 8kmH2k3BBxDTF8zelyXioo24wlDQ3DmTarn0gPFpo4+7slXhPMgwVVAUB5AYO8GpBoG9un
 yFN4uZKxBs09LDzIq4kpKSWA9SO0CnU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-YG_QuyVLMkKPKexjbrwgqg-1; Mon, 11 Sep 2023 07:22:27 -0400
X-MC-Unique: YG_QuyVLMkKPKexjbrwgqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85CA51C068E4;
 Mon, 11 Sep 2023 11:22:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40AEC10005D2;
 Mon, 11 Sep 2023 11:22:25 +0000 (UTC)
Date: Mon, 11 Sep 2023 12:22:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
Message-ID: <ZP74b/ByEaVW5bZO@redhat.com>
References: <20230911103832.23596-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911103832.23596-1-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 11, 2023 at 12:38:32PM +0200, Philippe Mathieu-Daudé wrote:
> Since commits 3adce820cf..ef1cf6890f, When building on
> a x86 host configured as:
> 
>   $ ./configure --cc=clang \
>     --target-list=x86_64-linux-user,x86_64-softmmu \
>     --enable-debug
> 
> we get:
> 
>   [71/71] Linking target qemu-x86_64
>   FAILED: qemu-x86_64
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `cpu_x86_cpuid':
>   cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_filter_features':
>   cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get_supported_cpuid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' follow
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
>   ninja: build stopped: subcommand failed.
> 
> '--enable-debug' disables optimizations (CFLAGS=-O0).
> 
> While at this (un)optimization level GCC eliminate the
> following dead code:
> 
>   if (0 && foo()) {
>       ...
>   }
> 
> Clang does not. Therefore restore a pair of stubs for
> unoptimized Clang builds.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")
> Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable()")

Why not just revert those two commits, since we now learned the rationale
for them was incorrect ?

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


