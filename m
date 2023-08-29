Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD0F78C9F9
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1zG-0004Un-JC; Tue, 29 Aug 2023 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb1z9-0004MW-Mj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:54:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb1z7-0003I6-6A
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:54:35 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so6446846a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328071; x=1693932871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KyG+yy2VfM4A1LPhXynlEF3nlHyY2Rr7va+YHTSYNiA=;
 b=Y1Z9OQGQlsHABAAXL64PM7rAcWkjyuPD3zhaRjNvE+yyNxRx8ndwUNmLV+SwB8NXjx
 ufGXv9FsSfuuUnKKUUFNSO6S0iyjuh6oPqQQRFEp6TuvlIF7St3zo+S5IcIRJxVvFl46
 c/rn7HqG/nORUgI38opv/W94dHT5yeEPoyUQh1q4dAVvB2mPNwUjERewt+EDQGphaJ1B
 fVaR5jP3RmCtXYLr5krD7+mJ4r+wQKc0iwHDe6OZ2DCiURH52krCQtsfCanMN5DbJsXe
 Ca27ztIcPqdjBQvkimfLLeVBgdaolJiA+OPrV91jAlGaKWUFSzfo8tATgSq4bk31fodm
 a/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328071; x=1693932871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyG+yy2VfM4A1LPhXynlEF3nlHyY2Rr7va+YHTSYNiA=;
 b=KabsBPVnIiCyXEWQTHfhwFci6fzDnX1ev5htXCnuo2xB5RC0Dthj+SWn0ne2TSd6/x
 JuggqPALT3UyQ+dV9kaGUgzQuS6WVBzgCyPjQH4DiPvDrn4q9zMBhM63x9c19LGIv95Q
 xUB6LZnnwcJpBcNcyH9iaqP1ygZdZCwCAKBoFV7SivbIdVvxt4iYxgTBaXb2ClYTlzWA
 DXTyYs8IseykP1mEwv5XoOPVMGWYfshpRcMMb2hWxpnao7u4bmKQ3i9RBfV3MqwCwEHR
 EXZKkp12Cyv0aXXwM8kAX//k7k4EZbsT0KbKgpkG5ToLF7BMyS7vB5uCFy1WXRyevx/Z
 jdlw==
X-Gm-Message-State: AOJu0Yyeg+jKn/NxL/4tCF0PwalUwZgAm/zU51f6ucVY199semtKzkW/
 TK2LKW3K3eF73UGHPC3CI2rQ8+cWi5ziYHFx7mjGHw==
X-Google-Smtp-Source: AGHT+IEj+JjYhqJkxNSoXFkZXzx3DzfKOl9f5c7/z2D2iOIdMcMsgsM3kX7y1U23X2CTVicLXMfpruiL7j1k5bHGhks=
X-Received: by 2002:aa7:c685:0:b0:525:950d:60ad with SMTP id
 n5-20020aa7c685000000b00525950d60admr20645996edq.25.1693328071559; Tue, 29
 Aug 2023 09:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-5-pbonzini@redhat.com>
In-Reply-To: <20230829082931.67601-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 17:54:20 +0100
Message-ID: <CAFEAcA-VBerzqPWc50s+hNwMCgbm6yTAEsEFTfWawnW5PJ+Jew@mail.gmail.com>
Subject: Re: [PATCH 04/10] configure: create native file with contents of
 $host_cc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000031a2bb060412aae4"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000031a2bb060412aae4
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Aug 2023 at 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The argument of --host-cc is not obeyed when cross compiling.  To avoid
> this issue, place it in a configuration file and pass it to meson
> with --native-file.
>
> While at it, clarify that --host-cc is not obeyed anyway when _not_
> cross compiling.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index 3423f008d5c..b2bc1ff5f7b 100755
> --- a/configure
> +++ b/configure
> @@ -922,7 +922,7 @@ Advanced options (experts only):
>    --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be
blank [$cross_prefix]
>    --cc=CC                  use C compiler CC [$cc]
>    --host-cc=CC             use C compiler CC [$host_cc] for code run at
> -                           build time
> +                           build time when cross compiling
>    --cxx=CXX                use C++ compiler CXX [$cxx]
>    --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
>    --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
> @@ -1886,7 +1886,6 @@ if test "$skip_meson" = no; then
>    echo "windres = [$(meson_quote $windres)]" >> $cross
>    echo "windmc = [$(meson_quote $windmc)]" >> $cross
>    if test "$cross_compile" = "yes"; then
> -    cross_arg="--cross-file config-meson.cross"
>      echo "[host_machine]" >> $cross
>      echo "system = '$targetos'" >> $cross
>      case "$cpu" in
> @@ -1903,6 +1902,14 @@ if test "$skip_meson" = no; then
>      else
>          echo "endian = 'little'" >> $cross
>      fi
> +    cross_arg="--cross-file config-meson.cross"
> +
> +    native="config-meson.native.new"
> +    echo "# Automatically generated by configure - do not modify" >
$native
> +    echo "[binaries]" >> $native
> +    echo "c = [$(meson_quote $host_cc)]" >> $native
> +    mv $native config-meson.native
> +    cross_arg="$cross_arg --native-file config-meson.native"
>    else
>      cross_arg="--native-file config-meson.cross"
>    fi
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

--00000000000031a2bb060412aae4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, 29 Aug 2023 at 09:31, Paolo Bonzini &lt;<a=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br>=
&gt;<br>&gt; The argument of --host-cc is not obeyed when cross compiling.=
=C2=A0 To avoid<br>&gt; this issue, place it in a configuration file and pa=
ss it to meson<br>&gt; with --native-file.<br>&gt;<br>&gt; While at it, cla=
rify that --host-cc is not obeyed anyway when _not_<br>&gt; cross compiling=
.<br>&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzi=
ni@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0config=
ure | 11 +++++++++--<br>&gt; =C2=A01 file changed, 9 insertions(+), 2 delet=
ions(-)<br>&gt;<br>&gt; diff --git a/configure b/configure<br>&gt; index 34=
23f008d5c..b2bc1ff5f7b 100755<br>&gt; --- a/configure<br>&gt; +++ b/configu=
re<br>&gt; @@ -922,7 +922,7 @@ Advanced options (experts only):<br>&gt; =C2=
=A0 =C2=A0--cross-prefix=3DPREFIX =C2=A0 =C2=A0use PREFIX for compile tools=
, PREFIX can be blank [$cross_prefix]<br>&gt; =C2=A0 =C2=A0--cc=3DCC =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use C compiler CC [=
$cc]<br>&gt; =C2=A0 =C2=A0--host-cc=3DCC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 use C compiler CC [$host_cc] for code run at<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 build time<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build time when cross compili=
ng<br>&gt; =C2=A0 =C2=A0--cxx=3DCXX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0use C++ compiler CXX [$cxx]<br>&gt; =C2=A0 =C2=A0--objcc=
=3DOBJCC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0use Objective-C compiler =
OBJCC [$objcc]<br>&gt; =C2=A0 =C2=A0--extra-cflags=3DCFLAGS =C2=A0 =C2=A0ap=
pend extra C compiler flags CFLAGS<br>&gt; @@ -1886,7 +1886,6 @@ if test &q=
uot;$skip_meson&quot; =3D no; then<br>&gt; =C2=A0 =C2=A0echo &quot;windres =
=3D [$(meson_quote $windres)]&quot; &gt;&gt; $cross<br>&gt; =C2=A0 =C2=A0ec=
ho &quot;windmc =3D [$(meson_quote $windmc)]&quot; &gt;&gt; $cross<br>&gt; =
=C2=A0 =C2=A0if test &quot;$cross_compile&quot; =3D &quot;yes&quot;; then<b=
r>&gt; - =C2=A0 =C2=A0cross_arg=3D&quot;--cross-file config-meson.cross&quo=
t;<br>&gt; =C2=A0 =C2=A0 =C2=A0echo &quot;[host_machine]&quot; &gt;&gt; $cr=
oss<br>&gt; =C2=A0 =C2=A0 =C2=A0echo &quot;system =3D &#39;$targetos&#39;&q=
uot; &gt;&gt; $cross<br>&gt; =C2=A0 =C2=A0 =C2=A0case &quot;$cpu&quot; in<b=
r>&gt; @@ -1903,6 +1902,14 @@ if test &quot;$skip_meson&quot; =3D no; then<=
br>&gt; =C2=A0 =C2=A0 =C2=A0else<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
echo &quot;endian =3D &#39;little&#39;&quot; &gt;&gt; $cross<br>&gt; =C2=A0=
 =C2=A0 =C2=A0fi<br>&gt; + =C2=A0 =C2=A0cross_arg=3D&quot;--cross-file conf=
ig-meson.cross&quot;<br>&gt; +<br>&gt; + =C2=A0 =C2=A0native=3D&quot;config=
-meson.native.new&quot;<br>&gt; + =C2=A0 =C2=A0echo &quot;# Automatically g=
enerated by configure - do not modify&quot; &gt; $native<br>&gt; + =C2=A0 =
=C2=A0echo &quot;[binaries]&quot; &gt;&gt; $native<br><div>&gt; + =C2=A0 =
=C2=A0echo &quot;c =3D [$(meson_quote $host_cc)]&quot; &gt;&gt; $native <br=
></div>&gt; + =C2=A0 =C2=A0mv $native config-meson.native<br>&gt; + =C2=A0 =
=C2=A0cross_arg=3D&quot;$cross_arg --native-file config-meson.native&quot;<=
br>&gt; =C2=A0 =C2=A0else<br>&gt; =C2=A0 =C2=A0 =C2=A0cross_arg=3D&quot;--n=
ative-file config-meson.cross&quot;<br>&gt; =C2=A0 =C2=A0fi<br><div>&gt; --=
</div><div><br></div><div>Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:=
peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt=
;<br>
<br>
thanks<br>
-- PMM<br>
</div><br></div>

--00000000000031a2bb060412aae4--

