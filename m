Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DA7E8F40
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 10:15:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r26XI-0008OV-9j; Sun, 12 Nov 2023 04:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r26XG-0008ON-Ap
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 04:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r26XE-0007K6-Aa
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 04:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699780417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zh6V3LKovO+gp3PXAW1Ue4aIRseWMGIJ+UHCGUANsA=;
 b=gom2zQhuhtpnR7hnLIzkhDMQe0DEd06rXTqBrQnKQBgQe/J4CTuH7asxzomniqzR24wX9n
 laL4NsgnA3xPQvkqqMSGsFekCgVxUd51QWwi2OusLPFvL+ZL3s2HfCaWL0VXESwMUyFEue
 rGNvckMWgTW9PumaLLzndlhtIpROkCE=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Vsy4IvIdMmGfYLlvAKPfYg-1; Sun, 12 Nov 2023 04:13:31 -0500
X-MC-Unique: Vsy4IvIdMmGfYLlvAKPfYg-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-45d8ba8fda1so3058568137.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 01:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699780410; x=1700385210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zh6V3LKovO+gp3PXAW1Ue4aIRseWMGIJ+UHCGUANsA=;
 b=WmcZqo2NRCiSH0OhFHTxfalY/I2ypFEV7fNogjyluRV4vobLRxnuZTR6EQjVBkfAst
 /jJ+blU2GSwDzyMfMf11o0JyvFLuoQ7w2Tui8jRVyWl9kD8vNYnWlZV4l8n48ZDaedLW
 fopWMj1Pmq1LRkB3IczY4miUfXH5JjVHma0p+nMY/oUDX2SPWOqI7ktZI7iml34DlwVk
 bHTK/LlFJwA8ikzsJINFrh6FTyMwo2nzk5O4GLyZTdpgz+L+fvBvsD6tyFIMffYTsE6u
 sXI0LpBj6nJiEqV5Z8j1A8SyPEXfYOVMYgbgiRKBYH85zTVvNqzP1g6YUY7qT4w5aSj+
 pBcg==
X-Gm-Message-State: AOJu0YwP1kkmeHWm+dv30pvHcHVy297Uvkum1cPP+4JEy2rfcDGAPS7Q
 rikMAyIZtu72TkACB0Wh2U3Xilz46LBWMYeRUmq60C6Ao6Sz8b6c/teATRAdlvVqSJCPX4mB+E/
 uqR4LJslOdilJk3wDG7v9MdqdMyov9hA=
X-Received: by 2002:a05:6102:3bc7:b0:45d:8c77:76b0 with SMTP id
 a7-20020a0561023bc700b0045d8c7776b0mr3167463vsv.9.1699780410026; 
 Sun, 12 Nov 2023 01:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8wsz71J27G3wISkRAK6ONEEZiB5BvOtZjR/m2ZWz4hzTwq5+gKw8S35+AWkJzNV2piNKCzMpd0vI5fsAdfrg=
X-Received: by 2002:a05:6102:3bc7:b0:45d:8c77:76b0 with SMTP id
 a7-20020a0561023bc700b0045d8c7776b0mr3167460vsv.9.1699780409738; Sun, 12 Nov
 2023 01:13:29 -0800 (PST)
MIME-Version: 1.0
References: <610aad34-da0b-4b8a-aa22-4ad19513ae28@tls.msk.ru>
 <CABgObfYMct5NwGuYtOsFdEYaV6U=Ahe8zMPc_8QRh5a-cs_SEQ@mail.gmail.com>
 <0f4ace5b-7541-4b88-bdd1-f78aed90d01f@t-online.de>
In-Reply-To: <0f4ace5b-7541-4b88-bdd1-f78aed90d01f@t-online.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 12 Nov 2023 10:13:16 +0100
Message-ID: <CABgObfZg4WO+zZ-wH5mbwH6f0pVd6AzxXukd_5xdg6TGb8O9hw@mail.gmail.com>
Subject: Re: disable-pie build
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000084df460609f0f76f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000084df460609f0f76f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 11 nov 2023, 21:09 Volker R=C3=BCmelin <vr_qemu@t-online.de> ha scri=
tto:

> No, this doesn't look good. This patch again breaks the native Windows
> build with MSYS2 and mingw64 cross compile probably too.
>

Doh, you're right of course (
https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg05486.html). We
need to add qemu_ldflags by hand to all executable.

I will look into adding no-pie support to Meson natively.

Paolo


> See
>
> https://gitlab.com/qemu-project/qemu/-/issues/1664
>
>
> https://lore.kernel.org/qemu-devel/20230522080816.66320-1-pbonzini@redhat=
.com/
>
> https://lore.kernel.org/qemu-devel/20230523073029.19549-1-pbonzini@redhat=
.com/
>
> and the big comment above the changed lines in meson.build.
>
> With best regards,
> Volker
>
> >> /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation
> R_X86_64_32 against `.rodata' can not be used when making a PIE object;
> recompile with
> >> -fPIE
> >> /usr/bin/ld: failed to set dynamic section sizes: bad value
> >>
> >> This is failing for *all* executables, including tests, qemu-img, etc.
> >>
> >> The following change fixes it:
> >>
> >> diff --git a/meson.build b/meson.build
> >> index a9c4f28247..0b7ca45d48 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -278,7 +278,8 @@ endif
> >>   # tries to build an executable instead of a shared library and
> fails.  So
> >>   # don't add -no-pie anywhere and cross fingers. :(
> >>   if not get_option('b_pie')
> >> -  qemu_common_flags +=3D cc.get_supported_arguments('-fno-pie',
> '-no-pie')
> >> +  qemu_common_flags +=3D cc.get_supported_arguments('-fno-pie')
> >> +  qemu_ldflags +=3D cc.get_supported_arguments('-no-pie')
> >>   endif
> >>
> >>   if not get_option('stack_protector').disabled()
>
>

--00000000000084df460609f0f76f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 11 nov 2023, 21:09 Volker R=C3=BCmelin &lt;<a h=
ref=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.de</a>&gt; ha scritto:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">No, this doesn&#39;t look good. Thi=
s patch again breaks the native Windows<br>
build with MSYS2 and mingw64 cross compile probably too.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Doh, you&#39;re rig=
ht of course (<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2=
023-05/msg05486.html">https://lists.nongnu.org/archive/html/qemu-devel/2023=
-05/msg05486.html</a>). We need to add qemu_ldflags by hand to all executab=
le.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I will look into add=
ing no-pie support to Meson natively.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
See<br>
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1664" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/=
issues/1664</a><br>
<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230522080816.66320-1-pbonzi=
ni@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lor=
e.kernel.org/qemu-devel/20230522080816.66320-1-pbonzini@redhat.com/</a><br>
<a href=3D"https://lore.kernel.org/qemu-devel/20230523073029.19549-1-pbonzi=
ni@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lor=
e.kernel.org/qemu-devel/20230523073029.19549-1-pbonzini@redhat.com/</a><br>
<br>
and the big comment above the changed lines in meson.build.<br>
<br>
With best regards,<br>
Volker<br>
<br>
&gt;&gt; /usr/bin/ld: libcommon.fa.p/hw_core_cpu-common.c.o: relocation R_X=
86_64_32 against `.rodata&#39; can not be used when making a PIE object; re=
compile with<br>
&gt;&gt; -fPIE<br>
&gt;&gt; /usr/bin/ld: failed to set dynamic section sizes: bad value<br>
&gt;&gt;<br>
&gt;&gt; This is failing for *all* executables, including tests, qemu-img, =
etc.<br>
&gt;&gt;<br>
&gt;&gt; The following change fixes it:<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/meson.build b/meson.build<br>
&gt;&gt; index a9c4f28247..0b7ca45d48 100644<br>
&gt;&gt; --- a/meson.build<br>
&gt;&gt; +++ b/meson.build<br>
&gt;&gt; @@ -278,7 +278,8 @@ endif<br>
&gt;&gt;=C2=A0 =C2=A0# tries to build an executable instead of a shared lib=
rary and fails.=C2=A0 So<br>
&gt;&gt;=C2=A0 =C2=A0# don&#39;t add -no-pie anywhere and cross fingers. :(=
<br>
&gt;&gt;=C2=A0 =C2=A0if not get_option(&#39;b_pie&#39;)<br>
&gt;&gt; -=C2=A0 qemu_common_flags +=3D cc.get_supported_arguments(&#39;-fn=
o-pie&#39;, &#39;-no-pie&#39;)<br>
&gt;&gt; +=C2=A0 qemu_common_flags +=3D cc.get_supported_arguments(&#39;-fn=
o-pie&#39;)<br>
&gt;&gt; +=C2=A0 qemu_ldflags +=3D cc.get_supported_arguments(&#39;-no-pie&=
#39;)<br>
&gt;&gt;=C2=A0 =C2=A0endif<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0if not get_option(&#39;stack_protector&#39;).disabled(=
)<br>
<br>
</blockquote></div></div></div>

--00000000000084df460609f0f76f--


