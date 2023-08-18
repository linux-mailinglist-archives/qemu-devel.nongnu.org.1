Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8F7812CF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 20:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX47u-0000vt-M1; Fri, 18 Aug 2023 14:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX47s-0000uL-Ch
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:23:12 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qX47p-0001qJ-Oi
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 14:23:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99df11828c6so485888466b.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692382988; x=1692987788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wxHC3P1xEKWOGNr9/WEJNirZgjCkdmE8U9Y67V7p4mE=;
 b=PgMfpVz9NVsMxZ2GBnwbt3AT7zEObL9+7MGpYRY88w45NjLhf5MoEOh5mAQvbBEluJ
 6YH+WMBRasRTvH7Cpn6F1DXNDnEFufXwEdEBSGj199wPPCiMp81ZX+eIUpLvPZVL5vHn
 /3ZgzyvkXdc2jcr+mzOVSbIxA9+RzaH2lFQiSTNhZLwTZQn7x+OGml3hS1CZrijQ6alx
 PKMEJI1b+639MHlK/oSdGON2l0S4E+G5xdrukepBQDci602BKUL4ivgLwTGh+D9Klwuh
 +AX69Y6WzJktH9ccc8HCBd96EwQfYgdtG1yarpP00kb+aoHJEpcqV6PB/CbF9Mgs4ObU
 AyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692382988; x=1692987788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wxHC3P1xEKWOGNr9/WEJNirZgjCkdmE8U9Y67V7p4mE=;
 b=can7WNiWVNJoOeAcDcdeWfVly8pGtj2nsxHk+93j35zbErrRRO0DcAD2qx2Ct0z+Ku
 78b7yan93NB+2FIjJiGN+9fS+0BwUVCSQ3NVACdAWKzmGc6yRct6Ex4cdbNAZ5bvJJDP
 XwQhfK1Cvb49FmDqPRZgA1mXyi5I1Nj4R6bKvXsy+8iaVO2o+aKkdnVfChX3WAVvgQGY
 gzNIEGJ5OwrA471tvBd+jPCFDsowj5/WsHQ/V/x50VkGKUVFwNLjjJq6GTY0py/UWLBC
 yjeY+Pu8Xzsyk9oSrOKnKp21LMI9OAerlSThHWBzBCpe3B8uPvIMHPuVqIxEztcLrjDP
 8u/Q==
X-Gm-Message-State: AOJu0Ywtz0DN+Tr/wmNh9fAtIPWRyd+7/WlSF+e47wS0Tf6BB0zcqeOz
 qnNT6B+AffkdwsMXkEbdSB35Rt9wNLGyR8xw/HYwJN/+14P4cwV+
X-Google-Smtp-Source: AGHT+IGtJH23THn3Jw794rIsT7ndCfOP6IRazAsjtmkR/aXOyqpwxbQPqrDVv//hPcya+fLtfLpYYzW6xuuAo7FgSAw=
X-Received: by 2002:a17:907:2cd4:b0:99e:13f5:3ef1 with SMTP id
 hg20-20020a1709072cd400b0099e13f53ef1mr4055ejc.17.1692382987852; Fri, 18 Aug
 2023 11:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230818175736.144194-1-richard.henderson@linaro.org>
 <20230818175736.144194-4-richard.henderson@linaro.org>
In-Reply-To: <20230818175736.144194-4-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 18 Aug 2023 12:22:56 -0600
Message-ID: <CANCZdfpqzRb--EBJnvxRjQHvssAWMWyWLL9qjArksk5pNROj4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] bsd-user: Remove image_info.start_brk
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d0ad9f0603369ed9"
Received-SPF: none client-ip=2a00:1450:4864:20::62e;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62e.google.com
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

--000000000000d0ad9f0603369ed9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 11:57=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> This has the same value is image_info.brk, which is also logged,
> and is otherwise unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

Same comments as 1/3.

Forgot on 1/3 to mention I'm planning on doing a pull request right after
the
release (subject to our release engineer's ok) and can include this there.

Warner


> ---
>  bsd-user/qemu.h    | 1 -
>  bsd-user/elfload.c | 2 +-
>  bsd-user/main.c    | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 898fe3e8b3..61501c321b 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -50,7 +50,6 @@ struct image_info {
>      abi_ulong end_code;
>      abi_ulong start_data;
>      abi_ulong end_data;
> -    abi_ulong start_brk;
>      abi_ulong brk;
>      abi_ulong rss;
>      abi_ulong start_stack;
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 2d39e59258..baf2f63d2f 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -811,7 +811,7 @@ int load_elf_binary(struct bsd_binprm *bprm, struct
> target_pt_regs *regs,
>                                         bprm->stringp, &elf_ex, load_addr=
,
>                                         et_dyn_addr, interp_load_addr,
> info);
>      info->load_addr =3D reloc_func_desc;
> -    info->start_brk =3D info->brk =3D elf_brk;
> +    info->brk =3D elf_brk;
>      info->start_stack =3D bprm->p;
>      info->load_bias =3D 0;
>
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 381bb18df8..f913cb55a7 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -553,8 +553,6 @@ int main(int argc, char **argv)
>              fprintf(f, "page layout changed following binary load\n");
>              page_dump(f);
>
> -            fprintf(f, "start_brk   0x" TARGET_ABI_FMT_lx "\n",
> -                    info->start_brk);
>              fprintf(f, "end_code    0x" TARGET_ABI_FMT_lx "\n",
>                      info->end_code);
>              fprintf(f, "start_code  0x" TARGET_ABI_FMT_lx "\n",
> --
> 2.34.1
>
>

--000000000000d0ad9f0603369ed9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 18, 2023 at 11:57=E2=80=
=AFAM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
>richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">This has the same value is image_info.brk, whi=
ch is also logged,<br>
and is otherwise unused.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:im=
p@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div><br></div><div>Same comments=
 as 1/3.</div><div><br></div><div>Forgot on 1/3 to mention I&#39;m planning=
 on doing a pull request right after the</div><div>release (subject to our =
release engineer&#39;s ok) and can include this there.</div><div><br></div>=
<div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 | 1 -<br>
=C2=A0bsd-user/elfload.c | 2 +-<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 | 2 --<br>
=C2=A03 files changed, 1 insertion(+), 4 deletions(-)<br>
<br>
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
index 898fe3e8b3..61501c321b 100644<br>
--- a/bsd-user/qemu.h<br>
+++ b/bsd-user/qemu.h<br>
@@ -50,7 +50,6 @@ struct image_info {<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong end_code;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_data;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong end_data;<br>
-=C2=A0 =C2=A0 abi_ulong start_brk;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong brk;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong rss;<br>
=C2=A0 =C2=A0 =C2=A0abi_ulong start_stack;<br>
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
index 2d39e59258..baf2f63d2f 100644<br>
--- a/bsd-user/elfload.c<br>
+++ b/bsd-user/elfload.c<br>
@@ -811,7 +811,7 @@ int load_elf_binary(struct bsd_binprm *bprm, struct tar=
get_pt_regs *regs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bprm-&gt=
;stringp, &amp;elf_ex, load_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 et_dyn_a=
ddr, interp_load_addr, info);<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;load_addr =3D reloc_func_desc;<br>
-=C2=A0 =C2=A0 info-&gt;start_brk =3D info-&gt;brk =3D elf_brk;<br>
+=C2=A0 =C2=A0 info-&gt;brk =3D elf_brk;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;start_stack =3D bprm-&gt;p;<br>
=C2=A0 =C2=A0 =C2=A0info-&gt;load_bias =3D 0;<br>
<br>
diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
index 381bb18df8..f913cb55a7 100644<br>
--- a/bsd-user/main.c<br>
+++ b/bsd-user/main.c<br>
@@ -553,8 +553,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(f, &quot;page layou=
t changed following binary load\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_dump(f);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(f, &quot;start_brk=C2=A0=
 =C2=A00x&quot; TARGET_ABI_FMT_lx &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info=
-&gt;start_brk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(f, &quot;end_code=
=C2=A0 =C2=A0 0x&quot; TARGET_ABI_FMT_lx &quot;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0info-&gt;end_code);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(f, &quot;start_code=
=C2=A0 0x&quot; TARGET_ABI_FMT_lx &quot;\n&quot;,<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000d0ad9f0603369ed9--

