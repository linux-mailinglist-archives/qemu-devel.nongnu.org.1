Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7707CBCBC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qseo3-0004rB-Tc; Tue, 17 Oct 2023 03:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qseo1-0004r1-T9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qsenz-0005i8-I3
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697528872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1S9i1OglnJytmWKzFX2c9cJorG+sGWiT4R7eaI6mqHg=;
 b=R9k94qcNxfyeecVTMtZHCkrG8+dDJnVys6JQNlngQ+p2il9yxud9BLVNqHb+Hs5EfLBWtH
 Xyw/xdqxdfBH7wjppk6Bu4qaWTIhRuHLdtLQNzBEf9FML54SoYdCQs3elkW9/aobvu7pwj
 x/XQuZ2UJmyW4GTXguYPv3qNN5+erbI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84--x69TuQMOiC9I1KYKspHJA-1; Tue, 17 Oct 2023 03:47:44 -0400
X-MC-Unique: -x69TuQMOiC9I1KYKspHJA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50d73e212so30153831fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697528863; x=1698133663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1S9i1OglnJytmWKzFX2c9cJorG+sGWiT4R7eaI6mqHg=;
 b=XvpUVC5Cn2UWUhlmlPII99Z6UXvSn56fxkW6+J/h0bRhyf0QVmVs4+zdoRFOuP57tl
 z2a6cAfqW7iTqJsE5ZqynrB1nBC2Iq4ym77rcCpv0eNf3F/oVgFUJLBy1AxM8uDWxW4D
 weyVSCtoo3BLcILxV9xnP9/VZVbZq9gtHzhTzyjsP8n3CDONAB4XQiNRxKs8wBh6uJ7i
 bIsCW4E/iE4c5RtaZuBaX2VCvmPRaN39ubKPAyVqiuyLrWs6N5xYomTlG/XTXnRvgcUC
 pV0Gr8EalPNrHzfaRfTdw35D6+Z9fygKQEGWGGZyFWOFaVP2Bg6IXZlP9fzhC8sgiaiN
 mn5w==
X-Gm-Message-State: AOJu0YxL51zMEQQ4GVLnsFztiKFluwwAwW8gOnjMTOsBzpdfV5myise6
 1ZC1kDLpYwK25HhQXCdv8NtJTscrTsDZeholVPrDRwMU7nQNE9gZcC1Dle8Qs4dQUiMzJC3z37y
 5nLBh3lqrSUwBoWJzBT8nI/kfXD7jT2k=
X-Received: by 2002:a05:651c:1192:b0:2bc:d5ad:2758 with SMTP id
 w18-20020a05651c119200b002bcd5ad2758mr848363ljo.5.1697528863449; 
 Tue, 17 Oct 2023 00:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj7BfXAV8XpGUbHz7wPHgEtOPdhxLUOxjKfaz0V2wzhKgjRzwyEKkXyhlnHgaruSHLjvflL7hKjb0TrEJ843k=
X-Received: by 2002:a05:651c:1192:b0:2bc:d5ad:2758 with SMTP id
 w18-20020a05651c119200b002bcd5ad2758mr848351ljo.5.1697528863011; Tue, 17 Oct
 2023 00:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231013155110.23175-1-anvilleg@cisco.com>
In-Reply-To: <20231013155110.23175-1-anvilleg@cisco.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Oct 2023 10:47:32 +0300
Message-ID: <CAPMcbCr+pvn5b+CYaVXp=UmMCP8FpOjjqMTvzY=R2JQhnMgufQ@mail.gmail.com>
Subject: Re: [PATCH] guest-agent: improve help for --allow-rpcs and
 --block-rpcs
To: "Angel M. Villegas" <anvilleg@cisco.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000e04d330607e4bc01"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000e04d330607e4bc01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Oct 13, 2023 at 6:53=E2=80=AFPM Angel M. Villegas <anvilleg@cisco.c=
om>
wrote:

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1757
>
> Updates to qga help output and documentation for --allow-rpcs and
> --blocks-rpcs
>
> Signed-off-by: Angel M. Villegas <anvilleg@cisco.com>
> ---
>  docs/interop/qemu-ga.rst | 8 ++++----
>  qga/main.c               | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 461c5a35ee..72fb75a6f5 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -81,13 +81,13 @@ Options
>
>  .. option:: -b, --block-rpcs=3DLIST
>
> -  Comma-separated list of RPCs to disable (no spaces, use ``help`` to
> -  list available RPCs).
> +  Comma-separated list of RPCs to disable (no spaces, use
> ``--block-rpcs=3Dhelp``
> +  to list available RPCs).
>
>  .. option:: -a, --allow-rpcs=3DLIST
>
> -  Comma-separated list of RPCs to enable (no spaces, use ``help`` to
> -  list available RPCs).
> +  Comma-separated list of RPCs to enable (no spaces, use
> ``--allow-rpcs=3Dhelp``
> +  to list available RPCs).
>
>  .. option:: -D, --dump-conf
>
> diff --git a/qga/main.c b/qga/main.c
> index 8668b9f3d3..bdf5344584 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -261,9 +261,9 @@ QEMU_COPYRIGHT "\n"
>  "  -s, --service     service commands: install, uninstall, vss-install,
> vss-uninstall\n"
>  #endif
>  "  -b, --block-rpcs  comma-separated list of RPCs to disable (no
> spaces,\n"
> -"                    use \"help\" to list available RPCs)\n"
> +"                    use \"--block-rpcs=3Dhelp\" to list available RPCs)=
\n"
>  "  -a, --allow-rpcs  comma-separated list of RPCs to enable (no spaces,\=
n"
> -"                    use \"help\" to list available RPCs)\n"
> +"                    use \"--allow-rpcs=3Dhelp\" to list available RPCs)=
\n"
>  "  -D, --dump-conf   dump a qemu-ga config file based on current config\=
n"
>  "                    options / command-line parameters to stdout\n"
>  "  -r, --retry-path  attempt re-opening path if it's unavailable or
> closed\n"
> --
> 2.39.2 (Apple Git-143)
>
>

--000000000000e04d330607e4bc01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 13, 2023 at 6:53=E2=
=80=AFPM Angel M. Villegas &lt;<a href=3D"mailto:anvilleg@cisco.com">anvill=
eg@cisco.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/iss=
ues/1757" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-proj=
ect/qemu/-/issues/1757</a><br>
<br>
Updates to qga help output and documentation for --allow-rpcs and --blocks-=
rpcs<br>
<br>
Signed-off-by: Angel M. Villegas &lt;<a href=3D"mailto:anvilleg@cisco.com" =
target=3D"_blank">anvilleg@cisco.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qemu-ga.rst | 8 ++++----<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 4 =
++--<br>
=C2=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index 461c5a35ee..72fb75a6f5 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -81,13 +81,13 @@ Options<br>
<br>
=C2=A0.. option:: -b, --block-rpcs=3DLIST<br>
<br>
-=C2=A0 Comma-separated list of RPCs to disable (no spaces, use ``help`` to=
<br>
-=C2=A0 list available RPCs).<br>
+=C2=A0 Comma-separated list of RPCs to disable (no spaces, use ``--block-r=
pcs=3Dhelp``<br>
+=C2=A0 to list available RPCs).<br>
<br>
=C2=A0.. option:: -a, --allow-rpcs=3DLIST<br>
<br>
-=C2=A0 Comma-separated list of RPCs to enable (no spaces, use ``help`` to<=
br>
-=C2=A0 list available RPCs).<br>
+=C2=A0 Comma-separated list of RPCs to enable (no spaces, use ``--allow-rp=
cs=3Dhelp``<br>
+=C2=A0 to list available RPCs).<br>
<br>
=C2=A0.. option:: -D, --dump-conf<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 8668b9f3d3..bdf5344584 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -261,9 +261,9 @@ QEMU_COPYRIGHT &quot;\n&quot;<br>
=C2=A0&quot;=C2=A0 -s, --service=C2=A0 =C2=A0 =C2=A0service commands: insta=
ll, uninstall, vss-install, vss-uninstall\n&quot;<br>
=C2=A0#endif<br>
=C2=A0&quot;=C2=A0 -b, --block-rpcs=C2=A0 comma-separated list of RPCs to d=
isable (no spaces,\n&quot;<br>
-&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use \&quot;help\&quot; to list available RPCs)\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use \&quot;--block-rpcs=3Dhelp\&quot; to list available RPCs)\n&quot;<b=
r>
=C2=A0&quot;=C2=A0 -a, --allow-rpcs=C2=A0 comma-separated list of RPCs to e=
nable (no spaces,\n&quot;<br>
-&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use \&quot;help\&quot; to list available RPCs)\n&quot;<br>
+&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 use \&quot;--allow-rpcs=3Dhelp\&quot; to list available RPCs)\n&quot;<b=
r>
=C2=A0&quot;=C2=A0 -D, --dump-conf=C2=A0 =C2=A0dump a qemu-ga config file b=
ased on current config\n&quot;<br>
=C2=A0&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 options / command-line parameters to stdout\n&quot;<br>
=C2=A0&quot;=C2=A0 -r, --retry-path=C2=A0 attempt re-opening path if it&#39=
;s unavailable or closed\n&quot;<br>
-- <br>
2.39.2 (Apple Git-143)<br>
<br>
</blockquote></div>

--000000000000e04d330607e4bc01--


