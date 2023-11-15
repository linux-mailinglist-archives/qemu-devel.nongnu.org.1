Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1CE7EC9A3
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:27:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jf5-0005PZ-DS; Wed, 15 Nov 2023 12:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3Jf4-0005Oy-0d
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:26:46 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1r3Jeo-00063M-C6
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:26:45 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54366bb1c02so15291a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700069187; x=1700673987; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J01iTOxwjY5T0Ke4A05PEMIDIBeAqZi6gL0HTLYvahE=;
 b=E+P2h3zyCt/Fp3aImEd31ujptjgNsNDiZ8dhRUmwNuhcE6SSXmmM23PDdW8OjC2u5b
 CqcA2c4uxcOk9FdUXD1BMBSjMMiaLRb+qu14fMbzETaKL4KCULczc/42H/y4B5TLfuER
 apeDC/jxofeXlE7JRnc8VDTvTFQiGdbpxonTzaiOggDq5xgGtX8Tbk9L702mDrQo6J03
 ewrYVvvw1LhJYGMF99t+JLrCWq2RHjeZq4/9Xama7O48WkBhMRkNmBWJJ3QTyAQwljyp
 jz1xx1ap7CPGcbV5JpINdnZ8GuVWrTTQslvQXMDoJiVxik44Tx4+i/3hgfOsHV8okFTV
 fsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700069187; x=1700673987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J01iTOxwjY5T0Ke4A05PEMIDIBeAqZi6gL0HTLYvahE=;
 b=tUJqjqD5QA17uhoc5b1A6ux/r85rKxtRa469q1JFmioHd9ieJ6cZ536p+oa5MXhK93
 bpeKJrE5S5wcdt05JWi62HLOlKA4JIOJCD/FXFU+J5j/aEaTlVmBkFi6QJ7diajxsbVG
 s6n3eb8hLMfxpLZ0lUD4MU3fc0iDZbchxb1uBZVLRy4t83CIQWM9R6n+Sb9xkGUqbGnp
 hii9oKYzBNKfUya0TKJDXBw5mLh02IHFs5GpXYayFxRvgdF3Osompk6kVzthTLpDPJKm
 a7xNgIRig/blVqT1uCZUE6CYl82YTdO7mAJfmFrO6cIhvG9o2h3N+i7Gkrzff9ABUulC
 fp4g==
X-Gm-Message-State: AOJu0Yz/vQempD9FunRPq9Lmwa4ySSqW47Mqgk2E+Az3Yc8E26eeOaUm
 lR1reVSj8NZgTgAEo48cY21Ljz1kMNJtSF7xWDDzC/aq4v88tFmfro9Do6XO
X-Google-Smtp-Source: AGHT+IEClUy6GXg9S+x22PDXua7qIXilqZnOkvP0DDCtCAJSHAZenlruKbCbbmYQU2zAArSj/YZXfJhBtSiGrSZx+9w=
X-Received: by 2002:a05:6402:5405:b0:545:2921:d217 with SMTP id
 ev5-20020a056402540500b005452921d217mr235463edb.6.1700069186798; Wed, 15 Nov
 2023 09:26:26 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
 <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
 <CAO=notzk2Dv3LOh+w1XZ1H6vTdq4sp_KvOat4Dj1vbDBhJKzvA@mail.gmail.com>
 <aa6bce64-430c-4876-9025-f29e06399d4d@linaro.org>
In-Reply-To: <aa6bce64-430c-4876-9025-f29e06399d4d@linaro.org>
From: Patrick Venture <venture@google.com>
Date: Wed, 15 Nov 2023 09:26:14 -0800
Message-ID: <CAO=notyVTQTAsk9u7LkZJF_C+mqPvQPkYB52-cHAoNAWYW9=Lw@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, pbonzini@redhat.com,
 peterx@redhat.com, 
 david@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org, 
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>
Content-Type: multipart/alternative; boundary="000000000000f99683060a343392"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=venture@google.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--000000000000f99683060a343392
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:02=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 11/15/23 08:58, Patrick Venture wrote:
> >
> >
> > On Wed, Nov 15, 2023 at 2:35=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org
> > <mailto:peter.maydell@linaro.org>> wrote:
> >
> >     On Tue, 14 Nov 2023 at 20:55, Patrick Venture <venture@google.com
> >     <mailto:venture@google.com>> wrote:
> >      > Avoids unaligned pointer issues.
> >      >
> >
> >     It would be nice to be more specific in the commit message here, by
> >     describing what kind of guest behaviour or machine config runs into
> this
> >     problem, and whether this happens in a situation users are likely t=
o
> >     run into. If the latter, we should consider tagging the commit
> >     with "Cc: qemu-stable@nongnu.org <mailto:qemu-stable@nongnu.org>"
> to have it
> >     backported to the
> >     stable release branches.
> >
> >
> > Thanks! I'll update the commit message with v2.  We were seeing this in
> our
> > infrastructure with unaligned accesses using the pointer dereference as
> there are no
> > guarantees on alignment of the incoming values.
>
> Which host cpu, for reference?  There aren't many that generate unaligned
> traps these days...
>
>
Here's the sanitizer log/qemu log, the host-cpu was an amd64.

qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.01H:ECX.pcid [bit 17]
qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.07H:EBX.erms [bit 9]
qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.07H:EBX.invpcid [bit 10]
qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.01H:ECX.pcid [bit 17]
qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.07H:EBX.erms [bit 9]
qemu-kvm-system-x86_64: warning: host doesn't support requested feature:
CPUID.07H:EBX.invpcid [bit 10]
third_party/qemu/softmmu/memory.c:1341:16: runtime error: load of
misaligned address 0x52500020b10d for type 'uint32_t' (aka 'unsigned int'),
which requires 4 byte alignment
0x52500020b10d: note: pointer points here
 ab ab ab ab ab ab ab  ab ab ab ab ab ab ab ab  ab ab ab ab ab ab ab ab  ab
ab ab ab ab ab ab ab  ab
             ^
    #0 0x55b34f8ef9d8 in memory_region_ram_device_read
third_party/qemu/softmmu/memory.c:1341:16
    #1 0x55b34f8ee8a8 in memory_region_read_accessor
third_party/qemu/softmmu/memory.c:441:11
    #2 0x55b34f8e06db in access_with_adjusted_size
third_party/qemu/softmmu/memory.c:569:18
    #3 0x55b34f8dfcb4 in memory_region_dispatch_read1
third_party/qemu/softmmu/memory.c
    #4 0x55b34f8dfcb4 in memory_region_dispatch_read
third_party/qemu/softmmu/memory.c:1476:9
    #5 0x55b34f8fa8b0 in flatview_read_continue
third_party/qemu/softmmu/physmem.c:2744:23
    #6 0x55b34f8fb0db in flatview_read
third_party/qemu/softmmu/physmem.c:2786:12
    #7 0x55b34f8faefa in address_space_read_full
third_party/qemu/softmmu/physmem.c:2799:18
    #8 0x55b34f8fb5b4 in address_space_rw
third_party/qemu/softmmu/physmem.c:2827:16
    #9 0x55b34f71eab5 in kvm_cpu_exec
third_party/qemu/accel/kvm/kvm-all.c:3062:13
    #10 0x55b34f7172e3 in kvm_vcpu_thread_fn
third_party/qemu/accel/kvm/kvm-accel-ops.c:51:17
    #11 0x55b350467044 in qemu_thread_start
third_party/qemu/util/qemu-thread-posix.c:541:9
    #12 0x55b34f6dba10 in asan_thread_start(void*)
third_party/llvm/llvm-project/compiler-rt/lib/asan/asan_interceptors.cpp:23=
4:28
    #13 0x7f5e1c81a7d8 in start_thread
(/usr/grte/v5/lib64/libpthread.so.0+0xb7d8) (BuildId:
3ccc1600b9140e48da03ed16e0210354)
    #14 0x7f5e1c77169e in clone (/usr/grte/v5/lib64/libc.so.6+0x13969e)
(BuildId: 280088eab084c30a3992a9bce5c35b44)

SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use
third_party/qemu/softmmu/memory.c:1341:16 in




>
> r~
>
>

--000000000000f99683060a343392
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 15, 2023 at 9:02=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 11/15/23 08:58, Patrick Venture wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Wed, Nov 15, 2023 at 2:35=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a> <br>
&gt; &lt;mailto:<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blan=
k">peter.maydell@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, 14 Nov 2023 at 20:55, Patrick Venture &lt;<=
a href=3D"mailto:venture@google.com" target=3D"_blank">venture@google.com</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:venture@google.com" ta=
rget=3D"_blank">venture@google.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Avoids unaligned pointer issues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It would be nice to be more specific in the commit =
message here, by<br>
&gt;=C2=A0 =C2=A0 =C2=A0describing what kind of guest behaviour or machine =
config runs into this<br>
&gt;=C2=A0 =C2=A0 =C2=A0problem, and whether this happens in a situation us=
ers are likely to<br>
&gt;=C2=A0 =C2=A0 =C2=A0run into. If the latter, we should consider tagging=
 the commit<br>
&gt;=C2=A0 =C2=A0 =C2=A0with &quot;Cc: <a href=3D"mailto:qemu-stable@nongnu=
.org" target=3D"_blank">qemu-stable@nongnu.org</a> &lt;mailto:<a href=3D"ma=
ilto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable@nongnu.org</a>&g=
t;&quot; to have it<br>
&gt;=C2=A0 =C2=A0 =C2=A0backported to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0stable release branches.<br>
&gt; <br>
&gt; <br>
&gt; Thanks! I&#39;ll update the commit message with v2.=C2=A0 We were seei=
ng this in our <br>
&gt; infrastructure=C2=A0with unaligned accesses using the pointer derefere=
nce as there are no <br>
&gt; guarantees on alignment of the incoming values.<br>
<br>
Which host cpu, for reference?=C2=A0 There aren&#39;t many that generate un=
aligned traps these days...<br>
<br></blockquote><div><br></div><div>Here&#39;s the sanitizer log/qemu log,=
 the host-cpu was an amd64.</div><div><br></div><div>qemu-kvm-system-x86_64=
: warning: host doesn&#39;t support requested feature: CPUID.01H:ECX.pcid [=
bit 17]<br>qemu-kvm-system-x86_64: warning: host doesn&#39;t support reques=
ted feature: CPUID.07H:EBX.erms [bit 9]<br>qemu-kvm-system-x86_64: warning:=
 host doesn&#39;t support requested feature: CPUID.07H:EBX.invpcid [bit 10]=
<br>qemu-kvm-system-x86_64: warning: host doesn&#39;t support requested fea=
ture: CPUID.01H:ECX.pcid [bit 17]<br>qemu-kvm-system-x86_64: warning: host =
doesn&#39;t support requested feature: CPUID.07H:EBX.erms [bit 9]<br>qemu-k=
vm-system-x86_64: warning: host doesn&#39;t support requested feature: CPUI=
D.07H:EBX.invpcid [bit 10]<br>third_party/qemu/softmmu/memory.c:1341:16: ru=
ntime error: load of misaligned address 0x52500020b10d for type &#39;uint32=
_t&#39; (aka &#39;unsigned int&#39;), which requires 4 byte alignment<br>0x=
52500020b10d: note: pointer points here<br>=C2=A0ab ab ab ab ab ab ab =C2=
=A0ab ab ab ab ab ab ab ab =C2=A0ab ab ab ab ab ab ab ab =C2=A0ab ab ab ab =
ab ab ab ab =C2=A0ab<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^ <=
br>=C2=A0 =C2=A0 #0 0x55b34f8ef9d8 in memory_region_ram_device_read third_p=
arty/qemu/softmmu/memory.c:1341:16<br>=C2=A0 =C2=A0 #1 0x55b34f8ee8a8 in me=
mory_region_read_accessor third_party/qemu/softmmu/memory.c:441:11<br>=C2=
=A0 =C2=A0 #2 0x55b34f8e06db in access_with_adjusted_size third_party/qemu/=
softmmu/memory.c:569:18<br>=C2=A0 =C2=A0 #3 0x55b34f8dfcb4 in memory_region=
_dispatch_read1 third_party/qemu/softmmu/memory.c<br>=C2=A0 =C2=A0 #4 0x55b=
34f8dfcb4 in memory_region_dispatch_read third_party/qemu/softmmu/memory.c:=
1476:9<br>=C2=A0 =C2=A0 #5 0x55b34f8fa8b0 in flatview_read_continue third_p=
arty/qemu/softmmu/physmem.c:2744:23<br>=C2=A0 =C2=A0 #6 0x55b34f8fb0db in f=
latview_read third_party/qemu/softmmu/physmem.c:2786:12<br>=C2=A0 =C2=A0 #7=
 0x55b34f8faefa in address_space_read_full third_party/qemu/softmmu/physmem=
.c:2799:18<br>=C2=A0 =C2=A0 #8 0x55b34f8fb5b4 in address_space_rw third_par=
ty/qemu/softmmu/physmem.c:2827:16<br>=C2=A0 =C2=A0 #9 0x55b34f71eab5 in kvm=
_cpu_exec third_party/qemu/accel/kvm/kvm-all.c:3062:13<br>=C2=A0 =C2=A0 #10=
 0x55b34f7172e3 in kvm_vcpu_thread_fn third_party/qemu/accel/kvm/kvm-accel-=
ops.c:51:17<br>=C2=A0 =C2=A0 #11 0x55b350467044 in qemu_thread_start third_=
party/qemu/util/qemu-thread-posix.c:541:9<br>=C2=A0 =C2=A0 #12 0x55b34f6dba=
10 in asan_thread_start(void*) third_party/llvm/llvm-project/compiler-rt/li=
b/asan/asan_interceptors.cpp:234:28<br>=C2=A0 =C2=A0 #13 0x7f5e1c81a7d8 in =
start_thread (/usr/grte/v5/lib64/libpthread.so.0+0xb7d8) (BuildId: 3ccc1600=
b9140e48da03ed16e0210354)<br>=C2=A0 =C2=A0 #14 0x7f5e1c77169e in clone (/us=
r/grte/v5/lib64/libc.so.6+0x13969e) (BuildId: 280088eab084c30a3992a9bce5c35=
b44)<br><br>SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use thi=
rd_party/qemu/softmmu/memory.c:1341:16 in=C2=A0<br></div><div><br></div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
r~<br>
<br>
</blockquote></div></div>

--000000000000f99683060a343392--

