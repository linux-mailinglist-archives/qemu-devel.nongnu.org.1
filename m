Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A187E7812C8
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 20:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX44j-0007YU-8P; Fri, 18 Aug 2023 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX44e-0007YF-SX
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:19:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX44c-0000pL-17
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:19:52 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99c47ef365cso161275866b.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692382787; x=1692987587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xc4n0I5JvAaBUUMy+WNEtlHiP/Sh0EpFjWy6Pg168o0=;
 b=mNTq4YwIvW/5iZHBO95HZrfOIj3M3RwVNggUdxzFFVrKxsO20Q336EfA1diPZtpXgp
 iQpFuyyn7D8fwPzjwxvTdBZdMvysyzjutiGVnbmWrvebq/yCntDtmW4RvHEv2t9ux2Li
 U0QzgiOaW+IN8KqBSUDYZwAlBLyShtPQHvrLrlamoKkWfQBBg2Wl2dXTa8jub7qk5QWS
 ToNKMgGhbkKndyqgZYZRdeqEzbboQMFKq6M8VWvUj1jl1g3Bai1ijdZP44KsXKo4Y6Lc
 K0WY3EjdCrHFMoOSTUq1LzWHHU28Y8cPP7pbEaG128/xqhvQpTtj84SBwiK81nggW/ua
 dgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692382787; x=1692987587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xc4n0I5JvAaBUUMy+WNEtlHiP/Sh0EpFjWy6Pg168o0=;
 b=KeGcBaiLzvF6xsZ8kCQ+CfhbWO27rBrr76eigzxrl6r84UIj2aalRmZtu/osj52smH
 gbVh4jsMNTCnnWbw4cLtIrPretdtwramy1kPut+gknLnN++axPik0Cw2V+Ybo18CBzKT
 sX3c61+BMjvKuQh3KhkbCYwoOxPck6Btxs6cPSkBkNtKVZaQoglGkasg/4196hQUsMkH
 8BZy61ZOO3aK/BWte3wAKbSItX0zHMoDZ7BPVtN1PvrR3MBUGeNaU9ABj64teEfPYbka
 k878Y6eRs+k1ysj2Sv2rOsGXsP+wxRVP6kWS0xy5ApOoEjBauLcxcYgwPE1nsDVQ4C6J
 HCMA==
X-Gm-Message-State: AOJu0YynIYzlxHOEUUQzaZ1lqNF8mTbYnRL/VDiBCgw6/M9LAwyaF9Vj
 SWYRUFoU31ubo3q6on4Mz0rDmmw8XRYqgGTRGlLEgFGrBC3jHuO+
X-Google-Smtp-Source: AGHT+IG8/d9SMEFqt8W6mjqDteNoksikjqXsaYdplsk2C42z1Wv6WiO+RzMH8NxHq6MsceyQ7WBDIPsFhWqBVpmzRoI=
X-Received: by 2002:a17:906:5dd8:b0:991:fef4:bb7 with SMTP id
 p24-20020a1709065dd800b00991fef40bb7mr2689980ejv.73.1692382787185; Fri, 18
 Aug 2023 11:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230818175736.144194-1-richard.henderson@linaro.org>
 <20230818175736.144194-2-richard.henderson@linaro.org>
In-Reply-To: <20230818175736.144194-2-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 18 Aug 2023 12:19:36 -0600
Message-ID: <CANCZdfonZUg5jX6xigA0U0FSPKsf1LTqGX0uAQj9gJacBsBbeA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bsd-user: Remove ELF_START_MMAP and
 image_info.start_mmap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000dabee406033692f8"
Received-SPF: none client-ip=2a00:1450:4864:20::634;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x634.google.com
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

--000000000000dabee406033692f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 11:57=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The start_mmap value is write-only.
> Remove the field and the defines that populated it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

This one won't interfere with anything, but unless I hear otherwise, I'll
queue it.
It applies to the blitz branch (though it needs a few more targets there),
and none
of these files are being modified by Kariim Taha, my gsoc student.

Warner

> ---
>  bsd-user/arm/target_arch_elf.h    | 1 -
>  bsd-user/i386/target_arch_elf.h   | 1 -
>  bsd-user/qemu.h                   | 1 -
>  bsd-user/x86_64/target_arch_elf.h | 1 -
>  bsd-user/elfload.c                | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/bsd-user/arm/target_arch_elf.h
> b/bsd-user/arm/target_arch_elf.h
> index 935bce347f..b1c0fd2b32 100644
> --- a/bsd-user/arm/target_arch_elf.h
> +++ b/bsd-user/arm/target_arch_elf.h
> @@ -20,7 +20,6 @@
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>
> -#define ELF_START_MMAP 0x80000000
>  #define ELF_ET_DYN_LOAD_ADDR    0x500000
>
>  #define elf_check_arch(x) ((x) =3D=3D EM_ARM)
> diff --git a/bsd-user/i386/target_arch_elf.h
> b/bsd-user/i386/target_arch_elf.h
> index cbcd1f08e2..4ac27b02e7 100644
> --- a/bsd-user/i386/target_arch_elf.h
> +++ b/bsd-user/i386/target_arch_elf.h
> @@ -20,7 +20,6 @@
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>
> -#define ELF_START_MMAP 0x80000000
>  #define ELF_ET_DYN_LOAD_ADDR    0x01001000
>  #define elf_check_arch(x) (((x) =3D=3D EM_386) || ((x) =3D=3D EM_486))
>
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 8f2d6a3c78..178114b423 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -52,7 +52,6 @@ struct image_info {
>      abi_ulong end_data;
>      abi_ulong start_brk;
>      abi_ulong brk;
> -    abi_ulong start_mmap;
>      abi_ulong mmap;
>      abi_ulong rss;
>      abi_ulong start_stack;
> diff --git a/bsd-user/x86_64/target_arch_elf.h
> b/bsd-user/x86_64/target_arch_elf.h
> index b244711888..e51c2faf08 100644
> --- a/bsd-user/x86_64/target_arch_elf.h
> +++ b/bsd-user/x86_64/target_arch_elf.h
> @@ -20,7 +20,6 @@
>  #ifndef TARGET_ARCH_ELF_H
>  #define TARGET_ARCH_ELF_H
>
> -#define ELF_START_MMAP 0x2aaaaab000ULL
>  #define ELF_ET_DYN_LOAD_ADDR    0x01021000
>  #define elf_check_arch(x) (((x) =3D=3D ELF_ARCH))
>
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 1f650bdde8..38a3439d2c 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct
> target_pt_regs *regs,
>      /* OK, This is the point of no return */
>      info->end_data =3D 0;
>      info->end_code =3D 0;
> -    info->start_mmap =3D (abi_ulong)ELF_START_MMAP;
>      info->mmap =3D 0;
>      elf_entry =3D (abi_ulong) elf_ex.e_entry;
>
> --
> 2.34.1
>
>

--000000000000dabee406033692f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 11:57=E2=80=
=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">The start_mmap value is write-only.<br>
Remove the field and the defines that populated it.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:im=
p@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>This one won&=
#39;t interfere with anything, but unless I hear otherwise, I&#39;ll queue =
it.</div><div>It applies to the blitz branch (though it needs a few more ta=
rgets there), and none</div><div>of these files are being modified by Karii=
m Taha, my gsoc student.</div><div><br></div><div>Warner</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0bsd-user/arm/target_arch_elf.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0bsd-user/i386/target_arch_elf.h=C2=A0 =C2=A0| 1 -<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A0bsd-user/x86_64/target_arch_elf.h | 1 -<br>
=C2=A0bsd-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 1 -<br>
=C2=A05 files changed, 5 deletions(-)<br>
<br>
diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.=
h<br>
index 935bce347f..b1c0fd2b32 100644<br>
--- a/bsd-user/arm/target_arch_elf.h<br>
+++ b/bsd-user/arm/target_arch_elf.h<br>
@@ -20,7 +20,6 @@<br>
=C2=A0#ifndef TARGET_ARCH_ELF_H<br>
=C2=A0#define TARGET_ARCH_ELF_H<br>
<br>
-#define ELF_START_MMAP 0x80000000<br>
=C2=A0#define ELF_ET_DYN_LOAD_ADDR=C2=A0 =C2=A0 0x500000<br>
<br>
=C2=A0#define elf_check_arch(x) ((x) =3D=3D EM_ARM)<br>
diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_arch_el=
f.h<br>
index cbcd1f08e2..4ac27b02e7 100644<br>
--- a/bsd-user/i386/target_arch_elf.h<br>
+++ b/bsd-user/i386/target_arch_elf.h<br>
@@ -20,7 +20,6 @@<br>
=C2=A0#ifndef TARGET_ARCH_ELF_H<br>
=C2=A0#define TARGET_ARCH_ELF_H<br>
<br>
-#define ELF_START_MMAP 0x80000000<br>
=C2=A0#define ELF_ET_DYN_LOAD_ADDR=C2=A0 =C2=A0 0x01001000<br>
=C2=A0#define elf_check_arch(x) (((x) =3D=3D EM_386) || ((x) =3D=3D EM_486)=
)<br>
<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 8f2d6a3c78..178114b423 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -52,7 +52,6 @@ struct image_info {<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong end_data;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_brk;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong brk;<br>
-=C2=A0 =C2=A0 abi_ulong start_mmap;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong mmap;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong rss;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_stack;<br>
diff --git a/bsd-user/x86_64/target_arch_elf.h b/bsd-user/x86_64/target_arc=
h_elf.h<br>
index b244711888..e51c2faf08 100644<br>
--- a/bsd-user/x86_64/target_arch_elf.h<br>
+++ b/bsd-user/x86_64/target_arch_elf.h<br>
@@ -20,7 +20,6 @@<br>
=C2=A0#ifndef TARGET_ARCH_ELF_H<br>
=C2=A0#define TARGET_ARCH_ELF_H<br>
<br>
-#define ELF_START_MMAP 0x2aaaaab000ULL<br>
=C2=A0#define ELF_ET_DYN_LOAD_ADDR=C2=A0 =C2=A0 0x01021000<br>
=C2=A0#define elf_check_arch(x) (((x) =3D=3D ELF_ARCH))<br>
<br>
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
index 1f650bdde8..38a3439d2c 100644<br>
--- a/bsd-user/elfload.c<br>
+++ b/bsd-user/elfload.c<br>
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct tar=
get_pt_regs *regs,<br>
=C2=A0 =C2=A0 =C2=A0/* OK, This is the point of no return */<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;end_data =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;end_code =3D 0;<br>
-=C2=A0 =C2=A0 info-&gt;start_mmap =3D (abi_ulong)ELF_START_MMAP;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;mmap =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0elf_entry =3D (abi_ulong) elf_ex.e_entry;<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000dabee406033692f8--

