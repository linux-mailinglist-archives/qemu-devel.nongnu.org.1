Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440974F87C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 21:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJJDN-0002fd-MG; Tue, 11 Jul 2023 15:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qJJDJ-0002fG-CU
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 15:39:57 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qJJD7-0003lf-Lg
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 15:39:57 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b6ef9ed2fdso100857561fa.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1689104383; x=1691696383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bNdr7KiAsTIECwrj4LQhcR2poUx/H0AHcLPrS/+SGGU=;
 b=s+lQsrK6lnMdmH1y+78S/I1pzbxHFgOpxUZetJtWj6F19f09Z4IBpevkqh89PEo8UU
 XV6OpWA2azjUES/MPnGWL2qxduvTkyXxNpFy2uAukG0coNQUQ+NyGnziQJxExHF0YiiE
 +AD5do+bskEvO3d0bZWMuh6FtLS2GYELkYbQM8Ph47sPpG4PQKaehCEggmu1zmYZGpqD
 PZQP9cCjS7hyBPd/Z/L7AgPB6HMV4MMQHHobmStTx14sUru213Ka/WIvMl/cEqkYHGjF
 Po0jXCv8XJ4Xa+PecSZR/2pcmxNsAgZcrRg/dzPIPDi2vRvKPdpuZaYZCX/BYUACbSP6
 8psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689104383; x=1691696383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bNdr7KiAsTIECwrj4LQhcR2poUx/H0AHcLPrS/+SGGU=;
 b=jr2OLdurg/E7D30GHQ2/RtiffnTQMiuPvitu3NZGQygCcTIZ2yI6ZnB54pdD06f4gR
 9PtOuA3bWS+ryrGpbCuogjAeLirMhGD0ymN7fNbON16IOtsZn3DzZR+M1jySsgFRF3hL
 5lPxmJmmF/uxuxDFwaCwbGWecIRd5C8LBzH2RMYnsR7ezK8U3hyUXxlMA2j8fVyaP5Du
 ZkIM4fnlIwZmvB3MjxVP5oYYJlqJ08q5+fz+OqflbxGcbK56kPtiorvy8s7ynaZS4q9a
 lZb9VdkKVPqSYLTVQZJOT+Z51iNjMq5mqVNeoBFekBYnmefJgK9dwUE6TOjrG4jg2Nh7
 3uXQ==
X-Gm-Message-State: ABy/qLYfgEqJK73Ym8nqvBjcgmy3LBzhA2KvwJYA3A//1qUZKAgsUqMH
 N1jpkW36RXNiApdTsDKG0R+/0mlHmfe24i+ARShn6g==
X-Google-Smtp-Source: APBJJlGXNM36by+JKedDTyoUMRQ+3k8Yi0TPmEFvO/6DSpxnWPU92CQb5qdK/Q4xewVfQjSvqYymBgSYSVkgcQXlTQ8=
X-Received: by 2002:a2e:700b:0:b0:2b6:e780:97c9 with SMTP id
 l11-20020a2e700b000000b002b6e78097c9mr13666048ljc.18.1689104382471; Tue, 11
 Jul 2023 12:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-2-philmd@linaro.org>
In-Reply-To: <20230711144922.67491-2-philmd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 11 Jul 2023 13:39:31 -0600
Message-ID: <CANCZdfptsrH6vXCtjxWyjSFu4CG92xmOuQ9i1uGs3301QmxC=g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tests/lcitool: Generate distribution packages list
 in JSON format
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b4cd2506003b42a4"
Received-SPF: none client-ip=2a00:1450:4864:20::235;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000b4cd2506003b42a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 8:49=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Add the generate_pkglist() helper to generate a list of packages
> required by a distribution to build QEMU.
>
> Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
> JSON, create the files under tests/vm/generated/ sub-directory;
> add a README mentioning the files are generated.
>
> Suggested-by: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

also, FreeBSD 14 branches next month... do I just grep for FreeBSD-13 to
find all the places to update for 14.0?

Warner

---
>  tests/lcitool/refresh     | 11 +++++++++++
>  tests/vm/generated/README |  5 +++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 tests/vm/generated/README
>
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index b54566edcc..4584870ea1 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=3DNone):
>      generate(filename, cmd, trailer)
>
>
> +def generate_pkglist(vm, target):
> +    filename =3D Path(src_dir, "tests", "vm", "generated", vm + ".json")
> +    cmd =3D lcitool_cmd + ["variables", "--format", "json", target, "qem=
u"]
> +    generate(filename, cmd, None)
> +
> +
>  # Netmap still needs to be manually built as it is yet to be packaged
>  # into a distro. We also add cscope and gtags which are used in the CI
>  # test
> @@ -191,6 +197,11 @@ try:
>      generate_cirrus("freebsd-13")
>      generate_cirrus("macos-12")
>
> +    #
> +    # VM packages lists
> +    #
> +    generate_pkglist("freebsd", "freebsd-13")
> +
>      sys.exit(0)
>  except Exception as ex:
>      print(str(ex), file=3Dsys.stderr)
> diff --git a/tests/vm/generated/README b/tests/vm/generated/README
> new file mode 100644
> index 0000000000..7ccc6ffd3d
> --- /dev/null
> +++ b/tests/vm/generated/README
> @@ -0,0 +1,5 @@
> +# FILES IN THIS FOLDER WERE AUTO-GENERATED
> +#
> +#  $ make lcitool-refresh
> +#
> +# https://gitlab.com/libvirt/libvirt-ci
> --
> 2.38.1
>
>

--000000000000b4cd2506003b42a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 11, 2023 at 8:49=E2=80=AF=
AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Add the generate_pkglist() helper to generate a list of packa=
ges<br>
required by a distribution to build QEMU.<br>
<br>
Since we can not add a &quot;THIS FILE WAS AUTO-GENERATED&quot; comment in<=
br>
JSON, create the files under tests/vm/generated/ sub-directory;<br>
add a README mentioning the files are generated.<br>
<br>
Suggested-by: Erik Skultety &lt;<a href=3D"mailto:eskultet@redhat.com" targ=
et=3D"_blank">eskultet@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com=
">imp@bsdimp.com</a>&gt;</div><div><br></div><div>also, FreeBSD 14 branches=
 next month... do I just grep for FreeBSD-13 to find all the places to upda=
te for 14.0?</div><div><br></div><div>Warner</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tests/lcitool/refresh=C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>
=C2=A0tests/vm/generated/README |=C2=A0 5 +++++<br>
=C2=A02 files changed, 16 insertions(+)<br>
=C2=A0create mode 100644 tests/vm/generated/README<br>
<br>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh<br>
index b54566edcc..4584870ea1 100755<br>
--- a/tests/lcitool/refresh<br>
+++ b/tests/lcitool/refresh<br>
@@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0generate(filename, cmd, trailer)<br>
<br>
<br>
+def generate_pkglist(vm, target):<br>
+=C2=A0 =C2=A0 filename =3D Path(src_dir, &quot;tests&quot;, &quot;vm&quot;=
, &quot;generated&quot;, vm + &quot;.json&quot;)<br>
+=C2=A0 =C2=A0 cmd =3D lcitool_cmd + [&quot;variables&quot;, &quot;--format=
&quot;, &quot;json&quot;, target, &quot;qemu&quot;]<br>
+=C2=A0 =C2=A0 generate(filename, cmd, None)<br>
+<br>
+<br>
=C2=A0# Netmap still needs to be manually built as it is yet to be packaged=
<br>
=C2=A0# into a distro. We also add cscope and gtags which are used in the C=
I<br>
=C2=A0# test<br>
@@ -191,6 +197,11 @@ try:<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;freebsd-13&quot;)<br>
=C2=A0 =C2=A0 =C2=A0generate_cirrus(&quot;macos-12&quot;)<br>
<br>
+=C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 # VM packages lists<br>
+=C2=A0 =C2=A0 #<br>
+=C2=A0 =C2=A0 generate_pkglist(&quot;freebsd&quot;, &quot;freebsd-13&quot;=
)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>
=C2=A0except Exception as ex:<br>
=C2=A0 =C2=A0 =C2=A0print(str(ex), file=3Dsys.stderr)<br>
diff --git a/tests/vm/generated/README b/tests/vm/generated/README<br>
new file mode 100644<br>
index 0000000000..7ccc6ffd3d<br>
--- /dev/null<br>
+++ b/tests/vm/generated/README<br>
@@ -0,0 +1,5 @@<br>
+# FILES IN THIS FOLDER WERE AUTO-GENERATED<br>
+#<br>
+#=C2=A0 $ make lcitool-refresh<br>
+#<br>
+# <a href=3D"https://gitlab.com/libvirt/libvirt-ci" rel=3D"noreferrer" tar=
get=3D"_blank">https://gitlab.com/libvirt/libvirt-ci</a><br>
-- <br>
2.38.1<br>
<br>
</blockquote></div></div>

--000000000000b4cd2506003b42a4--

