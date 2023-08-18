Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1EE7812C9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 20:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX45j-0008Mi-HX; Fri, 18 Aug 2023 14:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX45h-0008LI-Oc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:20:57 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX45f-00018l-Fx
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:20:57 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso151004766b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692382853; x=1692987653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VnoS7HMAasfrPnSfXlWCh5nXEvthKeT/gNb1MUF4sJk=;
 b=fnjZTDKg4TOO/jbR/zKmeHO4It1M5hlIIgJBOLrjY8QptMDtWk3xqoa0uXfvB+ixfB
 Ipf43k0j4byFCRMqP1cqWLJXGvyikA6cKBphT1NsO1/p2Y16XMHN2gL5aTe6WhpdMgIR
 Gw17Gkyrc8IXMjhKGkhhyQKfI2fHtsNK9eNqb4N2nVBP59B4W6ne4AIMOAe4jRrnSvBZ
 +GtJpFOqDTM9dXfAtch3fjVZGY51tZoR2kV6iVwQcDXIn+gr3Ho0NJnXearAlK5Av0jh
 mFkazPu71rf07pIISm5e37hpy1P6W+9ZngRnInO8eVm0nzcInQwFUBnyrmGfQkwdncIZ
 nUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692382853; x=1692987653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnoS7HMAasfrPnSfXlWCh5nXEvthKeT/gNb1MUF4sJk=;
 b=cJXfh4iwlNtrmwYqXg0HF2r6minWHDclibaYq32sdwszJpKerz7MD7Sf+a8gGjipnL
 tuDo+E+gotuXYTaPYAqVXS1I2az1P17JGvTRj3JR5LqRBe9DZSQUlufrDXpTkWh2Q3W/
 gVlt/4fr0VhzkVZrzCrtNTQt1s7MKB9d4v0KUgRuqBTsT64zTt1PmrEauheDI9vtGVDu
 DDG0JiT5jff5u92enTF1zvx4qTJGCOy3jOZ6mnPWQysesZk4GBr1jRp59PlC7gir/Sq6
 qnz2EjgQYC544JXDGRj1u6MDA9f+o889WUC3xOAGpppJg5QUHca2MilruNJCWKgcFsDQ
 xhhA==
X-Gm-Message-State: AOJu0YxK5ZZ4QAg/PuYHgo0RQZIMS1IT3Xsn2HtXRO/yV9crfdEj0PiN
 Fz8fShObubTcYsprLZjHTjhHxJJswyw/UkVtaHdZUmgh3ee2wA/k
X-Google-Smtp-Source: AGHT+IE+dOH72EX+DUZVKeepAHl4RexKjBc0ENQSZCjm8uIA49TFLqQYuAciMhX8EZMzy/UnO2B7F6Rz3dT87sih0g8=
X-Received: by 2002:a17:907:7715:b0:99b:6e54:bd5b with SMTP id
 kw21-20020a170907771500b0099b6e54bd5bmr2300488ejc.50.1692382853477; Fri, 18
 Aug 2023 11:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230818175736.144194-1-richard.henderson@linaro.org>
 <20230818175736.144194-3-richard.henderson@linaro.org>
In-Reply-To: <20230818175736.144194-3-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 18 Aug 2023 12:20:42 -0600
Message-ID: <CANCZdfqAcxveCdE046nxq8oDsQfK+F3dMqsHqRmsDxsjJFy6Hg@mail.gmail.com>
Subject: Re: [PATCH 2/3] bsd-user: Remove image_info.mmap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ce48170603369673"
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62f.google.com
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

--000000000000ce48170603369673
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 11:57=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This value is unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>]
>

Reviewed by: Warner Losh <imp@bsdimp.com>

Same comments as patch 1/3.

Warner


> ---
>  bsd-user/qemu.h    | 1 -
>  bsd-user/elfload.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 178114b423..898fe3e8b3 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -52,7 +52,6 @@ struct image_info {
>      abi_ulong end_data;
>      abi_ulong start_brk;
>      abi_ulong brk;
> -    abi_ulong mmap;
>      abi_ulong rss;
>      abi_ulong start_stack;
>      abi_ulong entry;
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 38a3439d2c..2d39e59258 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct
> target_pt_regs *regs,
>      /* OK, This is the point of no return */
>      info->end_data =3D 0;
>      info->end_code =3D 0;
> -    info->mmap =3D 0;
>      elf_entry =3D (abi_ulong) elf_ex.e_entry;
>
>      /* XXX Join this with PT_INTERP search? */
> --
> 2.34.1
>
>

--000000000000ce48170603369673
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 11:57=E2=80=
=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">This value is unused.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;]<br></bloc=
kquote><div><br></div><div>Reviewed by: Warner Losh &lt;<a href=3D"mailto:i=
mp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Same comment=
s as patch 1/3.</div><div><br></div><div>Warner</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0bsd-user/elfload.c | 1 -<br>
=C2=A02 files changed, 2 deletions(-)<br>
<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 178114b423..898fe3e8b3 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -52,7 +52,6 @@ struct image_info {<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong end_data;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_brk;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong brk;<br>
-=C2=A0 =C2=A0 abi_ulong mmap;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong rss;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_stack;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong entry;<br>
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
index 38a3439d2c..2d39e59258 100644<br>
--- a/bsd-user/elfload.c<br>
+++ b/bsd-user/elfload.c<br>
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct tar=
get_pt_regs *regs,<br>
=C2=A0 =C2=A0 =C2=A0/* OK, This is the point of no return */<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;end_data =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;end_code =3D 0;<br>
-=C2=A0 =C2=A0 info-&gt;mmap =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0elf_entry =3D (abi_ulong) elf_ex.e_entry;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* XXX Join this with PT_INTERP search? */<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000ce48170603369673--

