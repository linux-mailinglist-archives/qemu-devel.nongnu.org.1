Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82770796E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 07:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzVuG-0003EP-94; Thu, 18 May 2023 01:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzVu7-0003Co-Bt
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzVu3-0003Ne-3i
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684386612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2saJ2kehoukek5c92HxgZ2YxEeutbV7AdUvgLgzNkM0=;
 b=CjNs1CUMDr5fHC0v5uH4Liw6y4fxjLAnCs8l439hXCLfvVFEh07hzNfi5M2Jh30QN3Z/N2
 WU3jutb36RNtXFjJrj6Iux//KooXPmmxmkuDBKSQSjd2R0mGJYUm6Mnanhl6t57zG7rFcM
 9xDdEHF0zWP/xWh2pqcwTGt+/AzqKl8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547--GCsk3JrN6abSOn65Ga8tA-1; Thu, 18 May 2023 01:10:11 -0400
X-MC-Unique: -GCsk3JrN6abSOn65Ga8tA-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-450ddbc9431so442490e0c.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 22:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684386610; x=1686978610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2saJ2kehoukek5c92HxgZ2YxEeutbV7AdUvgLgzNkM0=;
 b=bzcpM4Wl1MjymhZbmqwkupp0E4E0p1j0ke0BkeLV4CbsQtlrouni8VvhQqL/4LAzD9
 HsY/5c8N0DAZ0bPe+yZbpC1AEEPhYhDSLemsGdYTaKhxIf9ZYY+z3cpOWo7y8HTNCLWI
 3MFtGvQMUhAi88EIk962fQQ/yhWhjYhNnIb7flb64pWpLi7Sv3lmyqlZLqvUIpTb7v35
 ImOmWr/ouxcmH2gF8nA/xesM9/YVj4Hx27+4NJwEVmJH5TmVuyIHYLTLsvQbbrKHTV9p
 LIV8qhrsxsW6LLBoKF5tolhd2OZrHU4TMf0gY+B1SObCuKALBC7nrJkAKn+Xb4ohjigP
 4yCQ==
X-Gm-Message-State: AC+VfDwpZi7dYcVl37pSoXk42I2DMcwdkMnAjpU08tNO0O2XUlquXmiH
 PiHzGxWjs1U38rnwR5upBsjH9xmrp9hn9XvR6UAgv9g4+VveoakfT9oV+cm5BgY62ji1sJUcfYt
 yzxqAxq5BYJlDxtsfQ7KcZRpHZo4oqm0=
X-Received: by 2002:a67:fe02:0:b0:42f:46d1:ffad with SMTP id
 l2-20020a67fe02000000b0042f46d1ffadmr156035vsr.22.1684386610502; 
 Wed, 17 May 2023 22:10:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fmjz/cftfrE/Nnm10gieBywXwd1NbEUQFBd8VLBn2k4VwG5J7R4UA8gUeUIK87ZYQDyq8BSz4qnK46r/yykg=
X-Received: by 2002:a67:fe02:0:b0:42f:46d1:ffad with SMTP id
 l2-20020a67fe02000000b0042f46d1ffadmr156031vsr.22.1684386610195; Wed, 17 May
 2023 22:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
In-Reply-To: <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 May 2023 07:09:58 +0200
Message-ID: <CABgObfaxs0PLEtdJPvfuaxg+AGnfzT9raBL-VVpZ9jMX--i4GA@mail.gmail.com>
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000090ccb305fbf0d15d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000090ccb305fbf0d15d
Content-Type: text/plain; charset="UTF-8"

Il mer 17 mag 2023, 22:31 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> https://gitlab.com/qemu-project/qemu/-/jobs/4304958487#L1887
>
> Warning, treated as error:
> the sphinx_rtd_theme extension does not declare if it is safe for parallel
> reading,
> assuming it isn't - please ask the extension author to check and make it
> explicit
>

Hmm I think with John's infrastructure it will be easy to check for a given
version of the theme but I wonder why it didn't fail for me.


> https://gitlab.com/qemu-project/qemu/-/jobs/4304958508#L2551
>
> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(init-first.o):
>
> in function `__libc_init_first':
> (.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15
> against symbol
> `__environ' defined in .bss section in
>
> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(environ.o)
> /usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please
> recompile with
> -fPIC
>

I will probably just split the PR in two while I figure out what happens,
thanks.

Paolo


>
> r~
>
>

--00000000000090ccb305fbf0d15d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 17 mag 2023, 22:31 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/4304958487#L1887" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/4304958487#L1887</a><br>
<br>
Warning, treated as error:<br>
the sphinx_rtd_theme extension does not declare if it is safe for parallel =
reading, <br>
assuming it isn&#39;t - please ask the extension author to check and make i=
t explicit<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Hmm I think with John&#39;s infrastructure it will be easy to che=
ck for a given version of the theme but I wonder why it didn&#39;t fail for=
 me.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
<br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/jobs/4304958508#L2551" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-proje=
ct/qemu/-/jobs/4304958508#L2551</a><br>
<br>
/usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/=
libc.a(init-first.o): <br>
in function `__libc_init_first&#39;:<br>
(.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 agai=
nst symbol <br>
`__environ&#39; defined in .bss section in <br>
/usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/=
libc.a(environ.o)<br>
/usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please =
recompile with <br>
-fPIC<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">I will probably just split the PR in two while I figure out what happe=
ns, thanks.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000090ccb305fbf0d15d--


