Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F079A791
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfetX-0007Gi-SI; Mon, 11 Sep 2023 07:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfetV-0007GQ-V4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:15:54 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qfetT-0005Ir-KI
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:15:53 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5717f7b932aso2836240eaf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694430950; x=1695035750; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kdc5E14LhEXwfEKTYcmcAb8UaBAI6Gd6db9kqJWLZf8=;
 b=q0Xx1BC97I1cn3XdoOzVXR8fI7PrAAYbxR0xlf6jgZsGi06utMTF+6OcJ8M0zX3xAt
 lni5ee8SuyD7Vpz94LahiCB3JIDP1e4hEdXoQXKTKMSzdu8G80zImOdLcDFk98k0tEUV
 bABADi/Ai7nGQzn1jwUuWEUpChZvUJrZNSN22fphbn4qAyARnU0kRoYZEwJ0hg1QPr6b
 Ue+IAuUl9JEZkBAcEXkyhJj1yXT6cfvykB3EhxzxZ0FhikY/WIqonZgRle/GEsKwsTWp
 fsx2C/d0N0JdEvQJa40XL8lpEAoNl6C50TEaW0PKMspE8DrnF897ga6Raeng8tykWiWZ
 6maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694430950; x=1695035750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdc5E14LhEXwfEKTYcmcAb8UaBAI6Gd6db9kqJWLZf8=;
 b=Z4mD5n49Gu8WpqjP7BByYCrKHtbUgsBFK6q0dW/AYJ0os43/g98XNJwzY9OMd12CaJ
 weDleowkueC77xxPRIAipZgUXsuTcP6qzaiDZlNI73lL/Uufcu+K5NWE/wYd6Eakb60Y
 9Q4p/AqSlUN+J9r3vCP4daAZOob+DDQasg7u4N1EnXBukQ9GnMKhLUV0MU4EkQsJUtMW
 jJP6vouQIBwHyyY1Too0qlNYIL82Rk06Mwh/Q8O5I80gLp0yWq6tlaiHOuWsOgaf6X6N
 QOFUCZKkxXk8xQNpzDXswQGhkGFeFhj9RQLFESyjjmVNgLTITP4reTTt9Y/JHssHnT7h
 S0XQ==
X-Gm-Message-State: AOJu0Yyz+EMQvOAd0j61mpVL5R4Q0PT70FPwHoOKeZOAERrExHVwxts3
 4/Qwrp34dcp4hDJVK9ju8l8ft7veuri2iBJ0Xe3R17XfuFs=
X-Google-Smtp-Source: AGHT+IG5fn2r+CZXTQswNTv5o7+j06b8HcxylfS5GopnmziRRoq5CFLnhStHdBfjOU0thzFJ80D+0yHOWkBr0RKaP/Y=
X-Received: by 2002:a4a:3906:0:b0:56d:2229:5f94 with SMTP id
 m6-20020a4a3906000000b0056d22295f94mr9256893ooa.6.1694430950243; Mon, 11 Sep
 2023 04:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230911103832.23596-1-philmd@linaro.org>
In-Reply-To: <20230911103832.23596-1-philmd@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Sep 2023 07:15:38 -0400
Message-ID: <CAJSP0QWDcNhso5nNBMNziLSXZczcrGp=6FgGNOXvYEQ6=Giiug@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Re-introduce few KVM stubs for Clang debug
 builds
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 11 Sept 2023 at 06:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Since commits 3adce820cf..ef1cf6890f, When building on
> a x86 host configured as:
>
>   $ ./configure --cc=3Dclang \
>     --target-list=3Dx86_64-linux-user,x86_64-softmmu \
>     --enable-debug
>
> we get:
>
>   [71/71] Linking target qemu-x86_64
>   FAILED: qemu-x86_64
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in fun=
ction `cpu_x86_cpuid':
>   cpu.c:(.text+0x1374): undefined reference to `kvm_arch_get_supported_cp=
uid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o: in fun=
ction `x86_cpu_filter_features':
>   cpu.c:(.text+0x81c2): undefined reference to `kvm_arch_get_supported_cp=
uid'
>   /usr/bin/ld: cpu.c:(.text+0x81da): undefined reference to `kvm_arch_get=
_supported_cpuid'
>   /usr/bin/ld: cpu.c:(.text+0x81f2): undefined reference to `kvm_arch_get=
_supported_cpuid'
>   /usr/bin/ld: cpu.c:(.text+0x820a): undefined reference to `kvm_arch_get=
_supported_cpuid'
>   /usr/bin/ld: libqemu-x86_64-linux-user.fa.p/target_i386_cpu.c.o:cpu.c:(=
.text+0x8225): more undefined references to `kvm_arch_get_supported_cpuid' =
follow
>   clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>   ninja: build stopped: subcommand failed.
>
> '--enable-debug' disables optimizations (CFLAGS=3D-O0).
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
> Fixes: ef1cf6890f ("target/i386: Allow elision of kvm_hv_vpindex_settable=
()")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/kvm/kvm_i386.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 55d4e68c34..0b62ac628f 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -32,7 +32,6 @@
>
>  bool kvm_has_smm(void);
>  bool kvm_enable_x2apic(void);
> -bool kvm_hv_vpindex_settable(void);
>  bool kvm_has_pit_state2(void);
>
>  bool kvm_enable_sgx_provisioning(KVMState *s);
> @@ -41,8 +40,6 @@ bool kvm_hyperv_expand_features(X86CPU *cpu, Error **er=
rp);
>  void kvm_arch_reset_vcpu(X86CPU *cs);
>  void kvm_arch_after_reset_vcpu(X86CPU *cpu);
>  void kvm_arch_do_init_vcpu(X86CPU *cs);
> -uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
> -                                      uint32_t index, int reg);
>  uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)=
;
>
>  void kvm_set_max_apic_id(uint32_t max_apic_id);
> @@ -60,6 +57,10 @@ void kvm_put_apicbase(X86CPU *cpu, uint64_t value);
>
>  bool kvm_has_x2apic_api(void);
>  bool kvm_has_waitpkg(void);
> +bool kvm_hv_vpindex_settable(void);
> +
> +uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
> +                                      uint32_t index, int reg);
>
>  uint64_t kvm_swizzle_msi_ext_dest_id(uint64_t address);
>  void kvm_update_msi_routes_all(void *private, bool global,
> @@ -76,6 +77,20 @@ typedef struct kvm_msr_handlers {
>  bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
>                      QEMUWRMSRHandler *wrmsr);
>
> +#elif defined(__clang__) && !defined(__OPTIMIZE__)

Another approach is a static library with a .o file containing the
stubs so the linker only includes it in the executable if the compiler
emitted the symbols. That way there is no need for defined(__clang__)
&& !defined(__OPTIMIZE__) and it will work with other
compilers/optimization levels. It's more work to set up though.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

