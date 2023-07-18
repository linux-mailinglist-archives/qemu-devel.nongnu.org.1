Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C5757683
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 10:25:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLg1O-0004Nv-9j; Tue, 18 Jul 2023 04:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLg1J-0004KR-D9
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 04:25:21 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qLg1C-0005OZ-Kv
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 04:25:18 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-403c653d934so38658131cf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689668712; x=1692260712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QMwPYcQTC61APYmXpZkeY2eobLY7lBRnTtiZOuLyOwQ=;
 b=YvbsJqOZCgxYbHdeMqdjEfSBKMzgVh6tgFxej9v8GDoHmXA7xiqnGzeSYfC0tXSkOC
 6P/WMNWh38xrHfunXGKvGV0dwK3OHPezYbM/ucg/BIlQaUtPNetHNAsmH1Y2Sk4eBj36
 sr2aZI/shBE1BgoueuPsCTzU9aaYATGsYkhl2EcVLKGFH9Z3OKPlPezdx3ONo29tfXjx
 5ufXMf6qf6I9xGlXPGhwLGKMqD2faIYEuokbc6BL/QZICD8ARTeh0ldWWk2yQh206JM2
 y61yXM1cIYBedCMWbof4ejxvWcp4j98zVxALdfsaVBmfVaHiQhDlOMeW2DaR+cjtXOHO
 IVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689668712; x=1692260712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMwPYcQTC61APYmXpZkeY2eobLY7lBRnTtiZOuLyOwQ=;
 b=frx4ez/GU9Xonod7omV0CqaoTAgUB4JGnuowt9hZ59aovFn0NYv9Pm4suUF/M+MZpR
 h8NiYt0Rggp6W0gNenNCM5ECZ6lwR/R5EBDlY4wKZ3ZgarT3Beno+RkPkoyDUrRZUEr3
 qf8ps+JHEtR6SseAwTcSnwGJOBRDOxyhwSZkNHAuaiiW5+foH4SFOOWhJFmKoQhr2cgk
 5yhezAlNQoHuN75Q2lzWoo+aa0JKFqAXFYL+fP+n+/Ujpsd9ji5hgAPVomvzr+BDuCgk
 PucezGF2g5vIrq71NCSPGNX2fE4VPpYCdKqMHwM8DWY4WWfV62BcgquzC2fHqxLX4L5+
 htog==
X-Gm-Message-State: ABy/qLZtd+Ds8UrKiGw99mqpdAZWIkLE9yvM8O8CKJPgbDU/NyJJ8eZy
 DCHLFJ1GYT6wJbPbUe+vyTw4VFCn1RnBcoJBTFo=
X-Google-Smtp-Source: APBJJlG0aHoNrJZkgI4h9WKjhxBJ2eMSztqlh0v5ux2GoerTU6TQmOvhIF3W1ZjsbZuq8ip1UdGRWuUDRYvJYEyt9yU=
X-Received: by 2002:ac8:7c4f:0:b0:403:b474:7b2c with SMTP id
 o15-20020ac87c4f000000b00403b4747b2cmr19489381qtv.23.1689668712016; Tue, 18
 Jul 2023 01:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20230717163855.7383-3-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2023 12:25:00 +0400
Message-ID: <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened format
 when necessary
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 joao.m.martins@oracle.com, Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005e33160600bea737"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

--0000000000005e33160600bea737
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jul 17, 2023 at 8:45=E2=80=AFPM Stephen Brennan <
stephen.s.brennan@oracle.com> wrote:

> The flattened format is used by makedumpfile only when it is outputting
> a vmcore to a file which is not seekable. The flattened format functions
> essentially as a set of instructions of the form "seek to the given
> offset, then write the given bytes out".
>
> The flattened format can be reconstructed using makedumpfile -R, or
> makedumpfile-R.pl, but it is a slow process beacuse it requires copying
> the entire vmcore. The flattened format can also be directly read by
> crash, but still, it requires a lengthy reassembly phase.
>
> To sum up, the flattened format is not an ideal one: it should only be
> used on files which are actually not seekable. This is the exact
> strategy which makedumpfile uses, as seen in the implementation of
> "write_buffer()" in makedumpfile [1].
>
> So, update the "dump-guest-memory" monitor command implementation so
> that it will directly do the seeks and writes, in the same strategy as
> makedumpfile. However, if the file is not seekable, then we can fall
> back to the flattened format.
>
> [1]:
> https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf9=
b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I am a bit reluctant to change the dump format by default. But since the
flatten format is more "complicated" than the "normal" format, perhaps we
can assume all users will handle it.

The change is probably late for 8.1 though..

---
>  dump/dump.c           | 30 +++++++++++++++++++++++++-----
>  include/sysemu/dump.h |  1 +
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 2708ddc135..384d275e39 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -813,6 +813,13 @@ static int write_start_flat_header(DumpState *s)
>  {
>      MakedumpfileHeader *mh;
>      int ret =3D 0;
> +    loff_t offset =3D lseek(s->fd, 0, SEEK_CUR);
> +
> +    /* If the file is seekable, don't output flattened header */
> +    if (offset =3D=3D 0) {
> +        s->seekable =3D true;
> +        return 0;
> +    }
>
>      QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
>      mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);
> @@ -837,6 +844,10 @@ static int write_end_flat_header(DumpState *s)
>  {
>      MakedumpfileDataHeader mdh;
>
> +    if (s->seekable) {
> +        return 0;
> +    }
> +
>      mdh.offset =3D END_FLAG_FLAT_HEADER;
>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>
> @@ -853,13 +864,21 @@ static int write_buffer(DumpState *s, off_t offset,
> const void *buf, size_t size
>  {
>      size_t written_size;
>      MakedumpfileDataHeader mdh;
> +    loff_t seek_loc;
>
> -    mdh.offset =3D cpu_to_be64(offset);
> -    mdh.buf_size =3D cpu_to_be64(size);
> +    if (s->seekable) {
> +        seek_loc =3D lseek(s->fd, offset, SEEK_SET);
> +        if (seek_loc =3D=3D (off_t) -1) {
> +            return -1;
> +        }
> +    } else {
> +        mdh.offset =3D cpu_to_be64(offset);
> +        mdh.buf_size =3D cpu_to_be64(size);
>
> -    written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
> -    if (written_size !=3D sizeof(mdh)) {
> -        return -1;
> +        written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
> +        if (written_size !=3D sizeof(mdh)) {
> +            return -1;
> +        }
>      }
>
>      written_size =3D qemu_write_full(s->fd, buf, size);
> @@ -1786,6 +1805,7 @@ static void dump_init(DumpState *s, int fd, bool
> has_format,
>      s->has_format =3D has_format;
>      s->format =3D format;
>      s->written_size =3D 0;
> +    s->seekable =3D false;
>
>      /* kdump-compressed is conflict with paging and filter */
>      if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index e27af8fb34..ab703c3a5e 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -157,6 +157,7 @@ typedef struct DumpState {
>      MemoryMappingList list;
>      bool resume;
>      bool detached;
> +    bool seekable;
>      hwaddr memory_offset;
>      int fd;
>
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000005e33160600bea737
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 8:45=E2=80=AFPM Steph=
en Brennan &lt;<a href=3D"mailto:stephen.s.brennan@oracle.com">stephen.s.br=
ennan@oracle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">The flattened format is used by makedumpfile only when it i=
s outputting<br>
a vmcore to a file which is not seekable. The flattened format functions<br=
>
essentially as a set of instructions of the form &quot;seek to the given<br=
>
offset, then write the given bytes out&quot;.<br>
<br>
The flattened format can be reconstructed using makedumpfile -R, or<br>
makedumpfile-R.pl, but it is a slow process beacuse it requires copying<br>
the entire vmcore. The flattened format can also be directly read by<br>
crash, but still, it requires a lengthy reassembly phase.<br>
<br>
To sum up, the flattened format is not an ideal one: it should only be<br>
used on files which are actually not seekable. This is the exact<br>
strategy which makedumpfile uses, as seen in the implementation of<br>
&quot;write_buffer()&quot; in makedumpfile [1].<br>
<br>
So, update the &quot;dump-guest-memory&quot; monitor command implementation=
 so<br>
that it will directly do the seeks and writes, in the same strategy as<br>
makedumpfile. However, if the file is not seekable, then we can fall<br>
back to the flattened format.<br>
<br>
[1]: <a href=3D"https://github.com/makedumpfile/makedumpfile/blob/f23bb9435=
68188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/makedumpfile/makedumpfile/blob/f23=
bb943568188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040</a><br>
<br>
Signed-off-by: Stephen Brennan &lt;<a href=3D"mailto:stephen.s.brennan@orac=
le.com" target=3D"_blank">stephen.s.brennan@oracle.com</a>&gt;<br></blockqu=
ote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</di=
v><div>Tested-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div><div><br></d=
iv><div>I am a bit reluctant to change the dump format by default. But sinc=
e the flatten format is more &quot;complicated&quot; than the &quot;normal&=
quot; format, perhaps we can assume all users will handle it.</div><div><br=
></div><div>The change is probably late for 8.1 though.. <br></div><div><br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0dump/dump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++++++++++=
+++++++++++++-----<br>
=C2=A0include/sysemu/dump.h |=C2=A0 1 +<br>
=C2=A02 files changed, 26 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/dump/dump.c b/dump/dump.c<br>
index 2708ddc135..384d275e39 100644<br>
--- a/dump/dump.c<br>
+++ b/dump/dump.c<br>
@@ -813,6 +813,13 @@ static int write_start_flat_header(DumpState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileHeader *mh;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
+=C2=A0 =C2=A0 loff_t offset =3D lseek(s-&gt;fd, 0, SEEK_CUR);<br>
+<br>
+=C2=A0 =C2=A0 /* If the file is seekable, don&#39;t output flattened heade=
r */<br>
+=C2=A0 =C2=A0 if (offset =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;seekable =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0QEMU_BUILD_BUG_ON(sizeof *mh &gt; MAX_SIZE_MDF_HEADER);=
<br>
=C2=A0 =C2=A0 =C2=A0mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);<br>
@@ -837,6 +844,10 @@ static int write_end_flat_header(DumpState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileDataHeader mdh;<br>
<br>
+=C2=A0 =C2=A0 if (s-&gt;seekable) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0mdh.offset =3D END_FLAG_FLAT_HEADER;<br>
=C2=A0 =C2=A0 =C2=A0mdh.buf_size =3D END_FLAG_FLAT_HEADER;<br>
<br>
@@ -853,13 +864,21 @@ static int write_buffer(DumpState *s, off_t offset, c=
onst void *buf, size_t size<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t written_size;<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileDataHeader mdh;<br>
+=C2=A0 =C2=A0 loff_t seek_loc;<br>
<br>
-=C2=A0 =C2=A0 mdh.offset =3D cpu_to_be64(offset);<br>
-=C2=A0 =C2=A0 mdh.buf_size =3D cpu_to_be64(size);<br>
+=C2=A0 =C2=A0 if (s-&gt;seekable) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 seek_loc =3D lseek(s-&gt;fd, offset, SEEK_SET)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (seek_loc =3D=3D (off_t) -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mdh.offset =3D cpu_to_be64(offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mdh.buf_size =3D cpu_to_be64(size);<br>
<br>
-=C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, &amp;mdh, sizeof(=
mdh));<br>
-=C2=A0 =C2=A0 if (written_size !=3D sizeof(mdh)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, &am=
p;mdh, sizeof(mdh));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (written_size !=3D sizeof(mdh)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0written_size =3D qemu_write_full(s-&gt;fd, buf, size);<=
br>
@@ -1786,6 +1805,7 @@ static void dump_init(DumpState *s, int fd, bool has_=
format,<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;has_format =3D has_format;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;format =3D format;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;written_size =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;seekable =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* kdump-compressed is conflict with paging and filter =
*/<br>
=C2=A0 =C2=A0 =C2=A0if (has_format &amp;&amp; format !=3D DUMP_GUEST_MEMORY=
_FORMAT_ELF) {<br>
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h<br>
index e27af8fb34..ab703c3a5e 100644<br>
--- a/include/sysemu/dump.h<br>
+++ b/include/sysemu/dump.h<br>
@@ -157,6 +157,7 @@ typedef struct DumpState {<br>
=C2=A0 =C2=A0 =C2=A0MemoryMappingList list;<br>
=C2=A0 =C2=A0 =C2=A0bool resume;<br>
=C2=A0 =C2=A0 =C2=A0bool detached;<br>
+=C2=A0 =C2=A0 bool seekable;<br>
=C2=A0 =C2=A0 =C2=A0hwaddr memory_offset;<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000005e33160600bea737--

