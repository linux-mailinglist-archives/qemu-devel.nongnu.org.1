Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4579A7BC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffXV-00069K-EA; Mon, 11 Sep 2023 07:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qffXR-00068w-VS
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:57:10 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qffXP-0004ZQ-17
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:57:09 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c0b40a13ebso2203344a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694433425; x=1695038225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRcYPO3DZLp8cXDPZdwVywuxXBCIxdMf7t602mmqYFE=;
 b=SNNcfmP8Fc6gzSocrAkjrXcVEUMjTITGAewaoZRNooQ9IYZ3zk2cDy3zSXKpZJmk05
 3FGnXHLrk823wrerKDiJfxm3xNCrbXCmB0KNC0keEDkg0fRx5EqHRo2Lwe4UEHr+dEdg
 6/9ZfTMzcort+OSA9YEdRKqPDkKtrLOmjkh3k/IuCKNagtyxDywpZKhFp+4tl+CgtbWy
 YvJVUJ2KBLLPezPVgasDizWKQwXQxCPLlPJe0pr2qbzUMzd3KuHlaU0qxqmil1UQEPyk
 /hxuJvLpbxS+7DEpZvqa9XrQIw3rAaarqO3dTnjeKSDCOzVv5rx/kiHXNwhQ9LrLmGuh
 wHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694433425; x=1695038225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRcYPO3DZLp8cXDPZdwVywuxXBCIxdMf7t602mmqYFE=;
 b=nNAViQpCbdihlcM679RVPlA0eWEF3ATIJDRsU1gqEj0Y/5VbEwCp/CuAuy5Hh5Yt/5
 f5ACLJfu89n9G/yPXao8qmUdL63RhyWrFwVOfJ5ywlOjldQJXXj1ICePePgQYv/kicP9
 DR0VCkDRlj/8e79hs7ZIkIwr0TFEnQA0eCYV5cy7fY1RirsLaNHfB6G/cZksrwWzTuuf
 GqkFRiPHcFf5avq7BtlhSVhl317oV7POBrDJdEdvTsd6aDIHlDLdsnyXszcUI9bnEzbS
 uC5yVaroKLKmDllR/FS3uBi0bjouyMOIH7cHilzpSKNmbgWRv9g7NV3rFl+eKI5z4g85
 wWIw==
X-Gm-Message-State: AOJu0YxVYh1HPaSrtwNhNeUcteMOzn+h5GATgMVOzRFHxkIkwHGQWfq/
 snst2Gc5z/2a3o17On9oIIQEYhj3HcMx/fUhYME=
X-Google-Smtp-Source: AGHT+IHjIzLLKg7xPUsbT/kc8uU4918D/fPNH2x7HHGKB+fxBpYXg+a6IOEM0DO0U7meJZDfyn/SgUL1AHpSo/QMawE=
X-Received: by 2002:a9d:4114:0:b0:6be:ec37:be90 with SMTP id
 o20-20020a9d4114000000b006beec37be90mr5642947ote.6.1694433425638; Mon, 11 Sep
 2023 04:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230911103832.23596-1-philmd@linaro.org>
 <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
In-Reply-To: <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Sep 2023 07:56:54 -0400
Message-ID: <CAJSP0QVmxRPBVVq-JShUwiCvTK0WS2rM01c7=jDFquw3CRE+qw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 kvm <kvm@vger.kernel.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006e49c80605140666"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000006e49c80605140666
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Or instead of using linker behavior, maybe just change the #ifdef so it
only applies when KVM is disabled. I didn't look at the code to see if this
is possible, but it would be nice to avoid the very specific #ifdef
condition in this patch.

Stefan

On Mon, Sep 11, 2023, 07:15 Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, 11 Sept 2023 at 06:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org>
> wrote:
> >
> > Since commits 3adce820cf..ef1cf6890f, When building on
> > a x86 host configured as:
> >
> >   $ ./configure --cc=3Dclang \
> >     --target-list=3Dx86_64-linux-user,x86_64-softmmu \
> >     --enable-debug
> >
> > we get:
> >
> >   [71/71] Linking target qemu-x86_64
> >   FAILED: qemu-x86_64
> >   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in
> function `cpu_x86_cpuid':
> >   cpu.c:(.text+0x1374): undefined reference to
> `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in
> function `x86_cpu_filter_features':
> >   cpu.c:(.text+0x81c2): undefined reference to
> `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to
> `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to
> `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to
> `kvm_arch_get_supported_cpuid'
> >   /usr/bin/ld:
> libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(.text+0x8225):
> more undefined references to `kvm_arch_get_supported_cpuid' follow
> >   clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
> >   ninja: build stopped: subcommand failed.
> >
> > '--enable-debug' disables optimizations (CFLAGS=3D-O0).
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
> > Fixes: ef1cf6890f ("target/i386: Allow elision of
> kvm_hv_vpindex_settable()")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
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
> > @@ -41,8 +40,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error
> **errp);
> >  void kvm_arch_reset_vcpu(X86CPU *cs);
> >  void kvm_arch_after_reset_vcpu(X86CPU *cpu);
> >  void kvm_arch_do_init_vcpu(X86CPU *cs);
> > -uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function=
,
> > -                                      uint32_t index, int reg);
> >  uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t
> index);
> >
> >  void kvm_set_max_apic_id(uint32_t max_apic_id);
> > @@ -60,6 +57,10 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
> >
> >  bool kvm_has_x2apic_api(void);
> >  bool kvm_has_waitpkg(void);
> > +bool kvm_hv_vpindex_settable(void);
> > +
> > +uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function=
,
> > +                                      uint32_t index, int reg);
> >
> >  uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
> >  void kvm_update_msi_routes_all(void *private, bool global,
> > @@ -76,6 +77,20 @@ typedef struct kvm_msr_handlers {
> >  bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr=
,
> >                      QEMUWRMSRHandler *wrmsr);
> >
> > +#elif defined(__clang__) && !defined(__OPTIMIZE__)
>
> Another approach is a static library with a .o file containing the
> stubs so the linker only includes it in the executable if the compiler
> emitted the symbols. That way there is no need for defined(__clang__)
> && !defined(__OPTIMIZE__) and it will work with other
> compilers/optimization levels. It's more work to set up though.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

--0000000000006e49c80605140666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Or instead of using linker behavior, maybe just change th=
e #ifdef so it only applies when KVM is disabled. I didn&#39;t look at the =
code to see if this is possible, but it would be nice to avoid the very spe=
cific #ifdef condition in this patch.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Stefan</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Mon, Sep 11, 2023, 07:15 Stefan Hajnoczi &lt;<a hr=
ef=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">On Mon, 11 Sept 2023 at 06:39, Philippe Mat=
hieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" =
rel=3D"noreferrer">philmd@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Since commits 3adce820cf..ef1cf6890f, When building on<br>
&gt; a x86 host configured as:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0$ ./configure --cc=3Dclang \<br>
&gt;=C2=A0 =C2=A0 =C2=A0--target-list=3Dx86_64-linux-user,x86_64-softmmu \<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0--enable-debug<br>
&gt;<br>
&gt; we get:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0[71/71] Linking target qemu-x86_64<br>
&gt;=C2=A0 =C2=A0FAILED: qemu-x86_64<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cp=
u.c.o: in function `cpu_x86_cpuid&#39;:<br>
&gt;=C2=A0 =C2=A0cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get=
_supported_cpuid&#39;<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cp=
u.c.o: in function `x86_cpu_filter_features&#39;:<br>
&gt;=C2=A0 =C2=A0cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get=
_supported_cpuid&#39;<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to =
`kvm_arch_get_supported_cpuid&#39;<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to =
`kvm_arch_get_supported_cpuid&#39;<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to =
`kvm_arch_get_supported_cpuid&#39;<br>
&gt;=C2=A0 =C2=A0/usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cp=
u.c.o:cpu.c:(.text+0x8225): more undefined references to `kvm_arch_get_supp=
orted_cpuid&#39; follow<br>
&gt;=C2=A0 =C2=A0clang: error: linker command failed with exit code 1 (use =
-v to see invocation)<br>
&gt;=C2=A0 =C2=A0ninja: build stopped: subcommand failed.<br>
&gt;<br>
&gt; &#39;--enable-debug&#39; disables optimizations (CFLAGS=3D-O0).<br>
&gt;<br>
&gt; While at this (un)optimization level GCC eliminate the<br>
&gt; following dead code:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0if (0 &amp;&amp; foo()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; Clang does not. Therefore restore a pair of stubs for<br>
&gt; unoptimized Clang builds.<br>
&gt;<br>
&gt; Reported-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">kwolf@redhat.com</a>&gt;<br>
&gt; Fixes: 3adce820cf (&quot;target/i386: Remove unused KVM stubs&quot;)<b=
r>
&gt; Fixes: ef1cf6890f (&quot;target/i386: Allow elision of kvm_hv_vpindex_=
settable()&quot;)<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a>&gt=
;<br>
&gt; ---<br>
&gt;=C2=A0 target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---<br>
&gt;=C2=A0 1 file changed, 18 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h<b=
r>
&gt; index 55d4e68c34..0b62ac628f 100644<br>
&gt; --- a/target/i386/kvm/kvm_i386.h<br>
&gt; +++ b/target/i386/kvm/kvm_i386.h<br>
&gt; @@ -32,7 +32,6 @@<br>
&gt;<br>
&gt;=C2=A0 bool kvm_has_smm(void);<br>
&gt;=C2=A0 bool kvm_enable_x2apic(void);<br>
&gt; -bool kvm_hv_vpindex_settable(void);<br>
&gt;=C2=A0 bool kvm_has_pit_state2(void);<br>
&gt;<br>
&gt;=C2=A0 bool kvm_enable_sgx_provisioning(KVMState *s);<br>
&gt; @@ -41,8 +40,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error *=
*errp);<br>
&gt;=C2=A0 void kvm_arch_reset_vcpu(X86CPU *cs);<br>
&gt;=C2=A0 void kvm_arch_after_reset_vcpu(X86CPU *cpu);<br>
&gt;=C2=A0 void kvm_arch_do_init_vcpu(X86CPU *cs);<br>
&gt; -uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t functio=
n,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t in=
dex, int reg);<br>
&gt;=C2=A0 uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_=
t index);<br>
&gt;<br>
&gt;=C2=A0 void kvm_set_max_apic_id(uint32_t max_apic_id);<br>
&gt; @@ -60,6 +57,10 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);=
<br>
&gt;<br>
&gt;=C2=A0 bool kvm_has_x2apic_api(void);<br>
&gt;=C2=A0 bool kvm_has_waitpkg(void);<br>
&gt; +bool kvm_hv_vpindex_settable(void);<br>
&gt; +<br>
&gt; +uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t functio=
n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t in=
dex, int reg);<br>
&gt;<br>
&gt;=C2=A0 uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);<br>
&gt;=C2=A0 void kvm_update_msi_routes_all(void *private, bool global,<br>
&gt; @@ -76,6 +77,20 @@ typedef struct kvm_msr_handlers {<br>
&gt;=C2=A0 bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler =
*rdmsr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 QEMUWRMSRHandler *wrmsr);<br>
&gt;<br>
&gt; +#elif defined(__clang__) &amp;&amp; !defined(__OPTIMIZE__)<br>
<br>
Another approach is a static library with a .o file containing the<br>
stubs so the linker only includes it in the executable if the compiler<br>
emitted the symbols. That way there is no need for defined(__clang__)<br>
&amp;&amp; !defined(__OPTIMIZE__) and it will work with other<br>
compilers/optimization levels. It&#39;s more work to set up though.<br>
<br>
Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
</blockquote></div>

--0000000000006e49c80605140666--

