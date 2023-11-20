Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6961F7F0A5D
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 02:37:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4tC3-0005LK-7e; Sun, 19 Nov 2023 20:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4tBy-0005Jl-41; Sun, 19 Nov 2023 20:35:14 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r4tBv-0001ro-5G; Sun, 19 Nov 2023 20:35:13 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc535cd5cso22578351cf.2; 
 Sun, 19 Nov 2023 17:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700444109; x=1701048909; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uE7ryHONHnDNLfpVX3tOUDszoynehfcv0my73O2mqus=;
 b=bu9InHZ0fgIUXjVraukBP2JVRKUPBTGoSdiDv7nO0cfTEX2mL6bh5namFWKgM5mGwq
 8W+4szFaTczl9PV58+UJrMJrgAYFJSbIBx8iHIpA5RA4eDbUCwGthhS4ggl1cSlP4CbA
 Ubs4jnVceuBON6NZ3j1fIlXNnUu2zVxpRO8H6HIpR9ec9bg12sHhlhAlgvx+VsSshp07
 +51LE+KmkDQPXKY72ewA/jFRdBoqFj1PxzUcdb4XUJZ7Tt6CXgrb99lh4zRonid6p7iJ
 g6LiURynLtlVMsQ6lmTkbjYdymLmZw2EG/IhezNFruKxyVYc/XcoK5tBdpiU3r8tpndV
 8S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700444109; x=1701048909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uE7ryHONHnDNLfpVX3tOUDszoynehfcv0my73O2mqus=;
 b=T71NstUlnPOYOot4SGpRa6t2EMDWtgaBmOPoSYjrhARyJxG+NNAL2VWXiy19NUXcGl
 /6PtcvZJFWN/sqK4CWF70Ph7Ip3g6rllWrHbrVwChJHxPtGzKzXaragjp13Fq8EnHQZf
 sWvY1MZpj1o0NrOZOUvDrh0CqjoKAaIHTBNT1LlsACNEGuamCw4iyrSybhL6wFUcC41x
 5EkLYPhek1UxiDbrY0Ry77WyYI5ujkyqGxFOF8RL1Fk1sdFLhtmgp80zXPD3LW9UkmSC
 7dFKn055EPeeFFU7XtaRwd+dikoeTkqsmu9ffbw/RtpkpgeixTRYVbovo/2UTPJXeO/+
 LT4A==
X-Gm-Message-State: AOJu0Ywl6LlrrAJsJl4/0FdW9RN1XM3OT7gf5d5XgvT3vnN9MNaX3Gbp
 Jymu7tjruK3VKJ3gTieUIe3wi+B/8QIoieJ4Bow=
X-Google-Smtp-Source: AGHT+IGRGbIagJ64Pgm91vim/i4LWcSONBJX2JAMkC/Spq0tOsg/cmgsO6z3IPhIwy01fo5HTeRNVJj7F6E4cyNxHlI=
X-Received: by 2002:a05:622a:4d0:b0:41e:1777:b474 with SMTP id
 q16-20020a05622a04d000b0041e1777b474mr8973430qtx.31.1700444109391; Sun, 19
 Nov 2023 17:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20231119203116.3027230-1-dhoff749@gmail.com>
 <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
In-Reply-To: <3c44d5a5-818b-46b6-a07f-af655a060032@linaro.org>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Sun, 19 Nov 2023 19:34:58 -0600
Message-ID: <CAFXChKJrXAop188pTFcU0YNPocn_KyiAXiqWoES2F0_==VyO+Q@mail.gmail.com>
Subject: Re: [PATCH v3] hw/i386: fix short-circuit logic with non-optimizing
 builds
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000019ca70060a8b7feb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=dhoff749@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000019ca70060a8b7feb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As far as I can tell, yes. Any optimization level above O0 does not have
this issue (on this version of Clang, at least)

On Sun, Nov 19, 2023 at 4:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 19/11/23 21:31, Daniel Hoffman wrote:
> > `kvm_enabled()` is compiled down to `0` and short-circuit logic is
> > used to remove references to undefined symbols at the compile stage.
> > Some build configurations with some compilers don't attempt to
> > simplify this logic down in some cases (the pattern appears to be
> > that the literal false must be the first term) and this was causing
> > some builds to emit references to undefined symbols.
> >
> > An example of such a configuration is clang 16.0.6 with the following
> > configure: ./configure --enable-debug --without-default-features
> > --target-list=3Dx86_64-softmmu --enable-tcg-interpreter
>
> Is the '--enable-debug' option triggering this?
>
> I'm surprised the order of conditions matters for code elision...
>
> > Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> > ---
> >   hw/i386/x86.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index b3d054889bb..2b6291ad8d5 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int
> default_cpu_version)
> >       /*
> >        * Can we support APIC ID 255 or higher?  With KVM, that requires
> >        * both in-kernel lapic and X2APIC userspace API.
> > +     *
> > +     * kvm_enabled() must go first to ensure that kvm_* references are
> > +     * not emitted for the linker to consume (kvm_enabled() is
> > +     * a literal `0` in configurations where kvm_* aren't defined)
> >        */
> > -    if (x86ms->apic_id_limit > 255 && kvm_enabled() &&
> > +    if (kvm_enabled() && x86ms->apic_id_limit > 255 &&
> >           (!kvm_irqchip_in_kernel() || !kvm_enable_x2apic())) {
> >           error_report("current -smp configuration requires kernel "
> >                        "irqchip and X2APIC API support.");
> > @@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >       }
> >       cpu->thread_id =3D topo_ids.smt_id;
> >
> > -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> > -        kvm_enabled() && !kvm_hv_vpindex_settable()) {
> > +    /*
> > +    * kvm_enabled() must go first to ensure that kvm_* references are
> > +    * not emitted for the linker to consume (kvm_enabled() is
> > +    * a literal `0` in configurations where kvm_* aren't defined)
> > +    */
> > +    if (kvm_enabled() && hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX)
> &&
> > +        !kvm_hv_vpindex_settable()) {
> >           error_setg(errp, "kernel doesn't allow setting HyperV
> VP_INDEX");
> >           return;
> >       }
>
>

--00000000000019ca70060a8b7feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">As far as I can tell, yes. Any optimization level above O=
0 does not have this issue (on this version of Clang, at least)</div><div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun,=
 Nov 19, 2023 at 4:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D=
"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-w=
idth:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204=
,204,204)">Hi,<br>
<br>
On 19/11/23 21:31, Daniel Hoffman wrote:<br>
&gt; `kvm_enabled()` is compiled down to `0` and short-circuit logic is<br>
&gt; used to remove references to undefined symbols at the compile stage.<b=
r>
&gt; Some build configurations with some compilers don&#39;t attempt to<br>
&gt; simplify this logic down in some cases (the pattern appears to be<br>
&gt; that the literal false must be the first term) and this was causing<br=
>
&gt; some builds to emit references to undefined symbols.<br>
&gt; <br>
&gt; An example of such a configuration is clang 16.0.6 with the following<=
br>
&gt; configure: ./configure --enable-debug --without-default-features<br>
&gt; --target-list=3Dx86_64-softmmu --enable-tcg-interpreter<br>
<br>
Is the &#39;--enable-debug&#39; option triggering this?<br>
<br>
I&#39;m surprised the order of conditions matters for code elision...<br>
<br>
&gt; Signed-off-by: Daniel Hoffman &lt;<a href=3D"mailto:dhoff749@gmail.com=
" target=3D"_blank">dhoff749@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/i386/x86.c | 15 ++++++++++++---<br>
&gt;=C2=A0 =C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/i386/x86.c b/hw/i386/x86.c<br>
&gt; index b3d054889bb..2b6291ad8d5 100644<br>
&gt; --- a/hw/i386/x86.c<br>
&gt; +++ b/hw/i386/x86.c<br>
&gt; @@ -131,8 +131,12 @@ void x86_cpus_init(X86MachineState *x86ms, int de=
fault_cpu_version)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Can we support APIC ID 255 or higher?=C2=
=A0 With KVM, that requires<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * both in-kernel lapic and X2APIC userspace=
 API.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* kvm_enabled() must go first to ensure that kvm_=
* references are<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* not emitted for the linker to consume (kvm_enab=
led() is<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* a literal `0` in configurations where kvm_* are=
n&#39;t defined)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 if (x86ms-&gt;apic_id_limit &gt; 255 &amp;&amp; kvm_ena=
bled() &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 if (kvm_enabled() &amp;&amp; x86ms-&gt;apic_id_limit &g=
t; 255 &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!kvm_irqchip_in_kernel() || !=
kvm_enable_x2apic())) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;current -sm=
p configuration requires kernel &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &quot;irqchip and X2APIC API support.&quot;);<br>
&gt; @@ -418,8 +422,13 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;thread_id =3D topo_ids.smt_id;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &amp;=
&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_enabled() &amp;&amp; !kvm_hv_vpindex_=
settable()) {<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 * kvm_enabled() must go first to ensure that kvm_* refe=
rences are<br>
&gt; +=C2=A0 =C2=A0 * not emitted for the linker to consume (kvm_enabled() =
is<br>
&gt; +=C2=A0 =C2=A0 * a literal `0` in configurations where kvm_* aren&#39;=
t defined)<br>
&gt; +=C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 if (kvm_enabled() &amp;&amp; hyperv_feat_enabled(cpu, H=
YPERV_FEAT_VPINDEX) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !kvm_hv_vpindex_settable()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;kernel =
doesn&#39;t allow setting HyperV VP_INDEX&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</blockquote></div></div>

--00000000000019ca70060a8b7feb--

