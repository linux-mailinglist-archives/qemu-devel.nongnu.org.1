Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1F787DEC
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 04:46:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZMoq-0001tT-J3; Thu, 24 Aug 2023 22:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qZMom-0001t0-U0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:45:00 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qZMoj-0003EF-Su
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 22:45:00 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1c8be41e5efso277924fac.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692931374; x=1693536174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UsD2aXkIjQ/uBz/s55ljMg0zpAYgNDGMxZnnEPv2S7c=;
 b=S6PBZBP0wiTehASV+HV8ES9td7vJwNR3AnadP18e52xVI7XBjN2VF9ejRa4Lx4tqO8
 ABPO4UM7kkvUMEI75i1X37oe/68MmfXWSEV9TOjUyH7ZR+MGXBvNIJdlwutUYBRpacmL
 JA4lj+kK7K8kIGq+C9srpeBL/AkJ/SrWIccJTTBxc24WKKj55qcrXY6ZgyobvyBIKueX
 X1G3Kgv+MUYzfIdYl4bi0KDe5OforaVd14PL5H9YI0hq5yAjRtwNuFoEvITl+3wBMIjT
 GN18x2cQHYVB6pFIhhekX6uccQbj1Mciujo9uYcGTIVL6rRcz1noUm03mjiD7JRcQilz
 odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692931374; x=1693536174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UsD2aXkIjQ/uBz/s55ljMg0zpAYgNDGMxZnnEPv2S7c=;
 b=kIC6D+16F0jihWMjZ2nxa26tFZqK5JE99orR+mh3kdLf8zFHCe71lbwjp2FjgqAvSh
 gJueic5K8Pfi6r68lfN6wmqiUQKZ+0ZpBWvt0ze0FYWPN+mUk2MnXZ7KqTp8yNYlxzod
 hqGD76jeTf1Q7CXXuCKiS+88LiMMbYAcoeN/+0IKSAZsT73lOyDPa8s64dthuxCGAz73
 IpzDOzgJtW5GXkErOVsluX53/wbXzGqUzym3mLMYnVpEAAt7GUv8034YscXbvVYmsPvQ
 80b5zOAQQb19+dNOZRCeiWeUsY2Yw36+VyDF/HRcGhgBnbcZ0vN7IH6i0X826GDtoZsg
 Dorg==
X-Gm-Message-State: AOJu0YwsJI/+VWngKVltlUCV+zMVwKPE5wWjQEIw+hpxRQa2JCK/qoLh
 tzHn4nVLBS392D9e+wcksCUfTx2laNqjRKGl0uLXLA==
X-Google-Smtp-Source: AGHT+IH3HfbSGxJmcrNreHPQsFvFBOLpFI/IUFSf8s/kAVwOMDbP2R3Jamtsz1zNYP9BTWR6EPzw627U8IXwzQOyHyg=
X-Received: by 2002:a05:6870:c10f:b0:1bf:77e2:95cc with SMTP id
 f15-20020a056870c10f00b001bf77e295ccmr1720337oad.17.1692931373816; Thu, 24
 Aug 2023 19:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR11MB67609A76D397056973B406B1F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
 <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB67604ECD85AFF34BEB3072F7F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 25 Aug 2023 10:42:37 +0800
Message-ID: <CAK9dgmbsn2SpvT+uOUhbPFOUbNLzPvsf09+Qkwziz9JZw2Q=XQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] softmmu/dirtylimit: Convert free to g_free
To: alloc.young@outlook.com
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002a707d0603b64d78"
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x33.google.com
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

--0000000000002a707d0603b64d78
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 10:33=E2=80=AFAM <alloc.young@outlook.com> wrote:

> From: alloc <alloc.young@outlook.com>
>
> Convert free to g_free to match g_new and g_malloc functions.
>
> Signed-off-by: alloc <alloc.young@outlook.com>
> ---
>  softmmu/dirtylimit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
> index e3ff53b8fc..fa959d7743 100644
> --- a/softmmu/dirtylimit.c
> +++ b/softmmu/dirtylimit.c
> @@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)
>              stat.rates[i].dirty_rate;
>      }
>
> -    free(stat.rates);
> +    g_free(stat.rates);
>  }
>
>  static void *vcpu_dirty_rate_stat_thread(void *opaque)
> @@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)
>
>  void vcpu_dirty_rate_stat_finalize(void)
>  {
> -    free(vcpu_dirty_rate_stat->stat.rates);
> +    g_free(vcpu_dirty_rate_stat->stat.rates);
>      vcpu_dirty_rate_stat->stat.rates =3D NULL;
>
> -    free(vcpu_dirty_rate_stat);
> +    g_free(vcpu_dirty_rate_stat);
>      vcpu_dirty_rate_stat =3D NULL;
>  }
>
> @@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)
>
>  void dirtylimit_state_finalize(void)
>  {
> -    free(dirtylimit_state->states);
> +    g_free(dirtylimit_state->states);
>      dirtylimit_state->states =3D NULL;
>
> -    free(dirtylimit_state);
> +    g_free(dirtylimit_state);
>      dirtylimit_state =3D NULL;
>
>      trace_dirtylimit_state_finalize();
> --
> 2.39.3
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--0000000000002a707d0603b64d78
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 25, 20=
23 at 10:33=E2=80=AFAM &lt;<a href=3D"mailto:alloc.young@outlook.com">alloc=
.young@outlook.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">From: alloc &lt=
;<a href=3D"mailto:alloc.young@outlook.com" target=3D"_blank">alloc.young@o=
utlook.com</a>&gt;<br>
<br>
Convert free to g_free to match g_new and g_malloc functions.<br>
<br>
Signed-off-by: alloc &lt;<a href=3D"mailto:alloc.young@outlook.com" target=
=3D"_blank">alloc.young@outlook.com</a>&gt;<br>
---<br>
=C2=A0softmmu/dirtylimit.c | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c<br>
index e3ff53b8fc..fa959d7743 100644<br>
--- a/softmmu/dirtylimit.c<br>
+++ b/softmmu/dirtylimit.c<br>
@@ -100,7 +100,7 @@ static void vcpu_dirty_rate_stat_collect(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat.rates[i].dirty_rate;<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 free(stat.rates);<br>
+=C2=A0 =C2=A0 g_free(stat.rates);<br>
=C2=A0}<br>
<br>
=C2=A0static void *vcpu_dirty_rate_stat_thread(void *opaque)<br>
@@ -171,10 +171,10 @@ void vcpu_dirty_rate_stat_initialize(void)<br>
<br>
=C2=A0void vcpu_dirty_rate_stat_finalize(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 free(vcpu_dirty_rate_stat-&gt;stat.rates);<br>
+=C2=A0 =C2=A0 g_free(vcpu_dirty_rate_stat-&gt;stat.rates);<br>
=C2=A0 =C2=A0 =C2=A0vcpu_dirty_rate_stat-&gt;stat.rates =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 free(vcpu_dirty_rate_stat);<br>
+=C2=A0 =C2=A0 g_free(vcpu_dirty_rate_stat);<br>
=C2=A0 =C2=A0 =C2=A0vcpu_dirty_rate_stat =3D NULL;<br>
=C2=A0}<br>
<br>
@@ -220,10 +220,10 @@ void dirtylimit_state_initialize(void)<br>
<br>
=C2=A0void dirtylimit_state_finalize(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 free(dirtylimit_state-&gt;states);<br>
+=C2=A0 =C2=A0 g_free(dirtylimit_state-&gt;states);<br>
=C2=A0 =C2=A0 =C2=A0dirtylimit_state-&gt;states =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 free(dirtylimit_state);<br>
+=C2=A0 =C2=A0 g_free(dirtylimit_state);<br>
=C2=A0 =C2=A0 =C2=A0dirtylimit_state =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_dirtylimit_state_finalize();<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><span style=3D"color:rgb(80,0,80)=
;font-family:&quot;comic sans ms&quot;,sans-serif">Reviewed-by:=C2=A0Hyman =
Huang<span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">=C2=A0</span>&lt;</span><a href=3D"mailto:yong.huang@sma=
rtx.com" target=3D"_blank" style=3D"font-family:&quot;comic sans ms&quot;,s=
ans-serif">yong.huang@smartx.com</a><span style=3D"color:rgb(80,0,80);font-=
family:&quot;comic sans ms&quot;,sans-serif">&gt;</span><br></div><div><spa=
n style=3D"color:rgb(80,0,80);font-family:&quot;comic sans ms&quot;,sans-se=
rif"><br></span></div><span class=3D"gmail_signature_prefix">-- </span><br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"c=
omic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000002a707d0603b64d78--

