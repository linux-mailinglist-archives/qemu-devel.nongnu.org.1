Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FC7D7C84
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtHM-0004Yp-0J; Thu, 26 Oct 2023 01:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qvtHK-0004Yg-Ec
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:51:34 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qvtHI-0000Ms-Jz
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:51:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so742769a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1698299490; x=1698904290;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vDqW8C0NyJA2/EVvGDfTjiwB9qc1RF8F5SCPYjRhXFg=;
 b=BNjUnc71WbtMUBgjDHI+AwdDe97hmwDLoECOsQL1Wd6eOTp+dTmfJD8lQ0WDFJ6LUp
 l5iaYGAvXTSfPbr2Q+rBy/jXdaEov99Mj4LuO14fyhilPdmJMuCgxBwZmAfjD4I5Wyf6
 6iLJLlG58FHYONZ4IjRXGySwAor35soQOYnUPLhcELCKQlgflOoKu+NOsMU1NPcaKT37
 9jy+4TGF/w0C4+4UxaFK2mVqI5wa1Ko9LE1kA1SJ0DvSnIVUkxSe3mqqWWFHWNx3zWGo
 biqpF2KJvXS3Gm9hIUW0k3VaQV5nIGpfMv02VoE9hociKCYFT2h1La4ELhTx5cdwMo+5
 7U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698299490; x=1698904290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDqW8C0NyJA2/EVvGDfTjiwB9qc1RF8F5SCPYjRhXFg=;
 b=voLp9dKW3PXR6mQ0YXVGfb2S5h0Os9xyPeRNVTOKOlCf1NY5pVlyEMt57ZmnIvgEKP
 Atjr93Fm6GgXvAUXdIdNtjlZQoJZziKXkaI0xUu91NUj+pFOHgqSN0Swh+UzopVpEewD
 chHS2SfQSsW5uyxscPKOPXEH6vv1iUVmxhysnpMJRU7nxrgZuIIZUfDmLVjfsLHUgCsH
 gbAgoBhXHPqbi2UC2lM+TFIH0mEKMOD6NWzVBghflQ9vhjjlseDGxfAWiYdCHGbrHcLN
 xhl/KV4C0waL8kT0aVeWzGhUJXOs7lV9LCcooRamZ2O4RctqtUGTey67/W+AF7sIvsqe
 7RIA==
X-Gm-Message-State: AOJu0YxRaPULOhzHjpLa/Kf50aZpVcyfdTf+ACMqt061djps/34+S1N3
 h0IrAXsWe4avqLRxTtg0cuaP9GTEX0/PXARIlUz/eg==
X-Google-Smtp-Source: AGHT+IEb3NdV+1j4XK1AIAhcP5HZ7IF7pUEM1iMVl/CYHVxVcTL4UO8u2Z00lLx62bOw8QAc5Sall2zeUR8nM+BH7m0=
X-Received: by 2002:a05:6402:51c8:b0:53d:d9d1:7029 with SMTP id
 r8-20020a05640251c800b0053dd9d17029mr13322300edd.15.1698299490233; Wed, 25
 Oct 2023 22:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053115.2066744-1-armbru@redhat.com>
 <20231026053115.2066744-2-armbru@redhat.com>
In-Reply-To: <20231026053115.2066744-2-armbru@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 25 Oct 2023 23:51:18 -0600
Message-ID: <CANCZdfpVS0-AuobG0=BwZ+36QWkVSr_tQozn9m2ks7kKS9uXUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] meson: Enable -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Brian Cain <bcain@quicinc.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d683650608982997"
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d683650608982997
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 25, 2023, 11:31 PM Markus Armbruster <armbru@redhat.com> wrote:

> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: commit bbde656263d (migration/rdma: Fix save_page method to
> fail on polling error).
>
> Enable -Wshadow=local to prevent such issues.  Possible thanks to
> recent cleanups.  Enabling -Wshadow would prevent more issues, but
> we're not yet ready for that.
>
> As usual, the warning is only enabled when the compiler recognizes it.
> GCC does, Clang doesn't.
>
> Some shadowed locals remain in bsd-user.  Since BSD prefers Clang,
> let's not wait for its cleanup.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index dcef8b1e79..89220443b8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -462,6 +462,7 @@ warn_flags = [
>    '-Wno-tautological-type-limit-compare',
>    '-Wno-psabi',
>    '-Wno-gnu-variable-sized-type-not-at-end',
> +  '-Wshadow=local',
>

Does this work with clang? I've not had good luck enabling it.

Warner

 ]
>
>  if targetos != 'darwin'
> --
> 2.41.0
>
>

--000000000000d683650608982997
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 25, 2023, 11:31 PM Markus Armbruster &lt;<=
a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Local variables shadowing other local var=
iables or parameters make the<br>
code needlessly hard to understand.=C2=A0 Bugs love to hide in such code.<b=
r>
Evidence: commit bbde656263d (migration/rdma: Fix save_page method to<br>
fail on polling error).<br>
<br>
Enable -Wshadow=3Dlocal to prevent such issues.=C2=A0 Possible thanks to<br=
>
recent cleanups.=C2=A0 Enabling -Wshadow would prevent more issues, but<br>
we&#39;re not yet ready for that.<br>
<br>
As usual, the warning is only enabled when the compiler recognizes it.<br>
GCC does, Clang doesn&#39;t.<br>
<br>
Some shadowed locals remain in bsd-user.=C2=A0 Since BSD prefers Clang,<br>
let&#39;s not wait for its cleanup.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index dcef8b1e79..89220443b8 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -462,6 +462,7 @@ warn_flags =3D [<br>
=C2=A0 =C2=A0&#39;-Wno-tautological-type-limit-compare&#39;,<br>
=C2=A0 =C2=A0&#39;-Wno-psabi&#39;,<br>
=C2=A0 =C2=A0&#39;-Wno-gnu-variable-sized-type-not-at-end&#39;,<br>
+=C2=A0 &#39;-Wshadow=3Dlocal&#39;,<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Does this work with clang? I&#39;ve not =
had good luck enabling it.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Warner=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0]<br>
<br>
=C2=A0if targetos !=3D &#39;darwin&#39;<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div></div>

--000000000000d683650608982997--

