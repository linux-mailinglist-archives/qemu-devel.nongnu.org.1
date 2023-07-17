Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41782756C40
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLT6f-0003KO-A3; Mon, 17 Jul 2023 14:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLT6d-0003KB-T3
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qLT6b-0006T3-M2
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689619076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zhw45k80P1+gvkLyLzN6nFOSIuoFDXYW4UESyhOXApw=;
 b=CBDNp2zujDeoSMCNoZXOVsAbd5nVuZwyyH9v1StUkBSvN97yxt1k/meZKlcO4CuukY1nVR
 autxXjelkBtpF/yyKNrPp2+11wCVjRJGOq9tC509YQbAUmoWdFRLiKrJ6QX44xUyPCzn4t
 A/fF4q48wWkVz+Xltr7xW+Jg54rbDDM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-STOENHZ4PYKbsLJfaSZuEQ-1; Mon, 17 Jul 2023 14:37:54 -0400
X-MC-Unique: STOENHZ4PYKbsLJfaSZuEQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51dd4df2477so3324926a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689619073; x=1692211073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zhw45k80P1+gvkLyLzN6nFOSIuoFDXYW4UESyhOXApw=;
 b=NDb4i0/qJv6l/5Di3gOphAGn6FujZCWJxtU8donlCNAzEZQeim6egE9qnRJkNxq6U3
 tbKQ8zaepOrgbGJnzQ1KZEllTX0pZHxOrfKscEMSsxwX2weV9cdoW/LS5AsgBDYJ7vUd
 wSh+UbiOVSAwCSSLymlv/1kWjhdp7BZqSnD5Iu9VGPQv6mWsPQJkRs4kc2Hjini5vZCO
 PsAJ+lKi15aonwNLYpXAJ0y9qKdP+q101qV7CIymJRbusuZCgyUNN/LHTxGhV1vDu6Nw
 97Qj6OiDHQvyTuWFBqnKNyO+xOpxHMnEzuXEUIJlpntwVEiQ0jNLviAGXE913a7LMpzk
 u3fw==
X-Gm-Message-State: ABy/qLYhjSkCzEjlPae/lSfVKibx0Z1ZlEGrb4HEzGYeReCM/YpFedZ4
 1I53LT0yptykCUz0tlhWpHrQW8T4VoD1CiwwxUxjneDk7GMnX34u+vQId9HFv4l7HuEc6ymirkG
 dD7LJqCiOaVlMPRniKNtzc4wu0URl7e0=
X-Received: by 2002:aa7:d80d:0:b0:51d:ad03:95f with SMTP id
 v13-20020aa7d80d000000b0051dad03095fmr12030596edq.7.1689619073271; 
 Mon, 17 Jul 2023 11:37:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxqkDVLZsan1M/xDp0BE8FFJfNirofeCJ56Qt5OWOcLXSt3hMEA3qc5yyZbfbwoESNN2TRkH3p8R265DVPV5U=
X-Received: by 2002:aa7:d80d:0:b0:51d:ad03:95f with SMTP id
 v13-20020aa7d80d000000b0051dad03095fmr12030587edq.7.1689619072964; Mon, 17
 Jul 2023 11:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-2-stephen.s.brennan@oracle.com>
In-Reply-To: <20230717163855.7383-2-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Jul 2023 22:37:41 +0400
Message-ID: <CAMxuvaz49yi94y9FVvosFJm5gAmtRwL1ZDmU46atDq4wdNUBtQ@mail.gmail.com>
Subject: Re: [PATCH qemu 1/2] dump: Pass DumpState to write_ functions
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 joao.m.martins@oracle.com
Content-Type: multipart/alternative; boundary="000000000000a66f690600b31851"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000a66f690600b31851
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 9:55=E2=80=AFPM Stephen Brennan <
stephen.s.brennan@oracle.com> wrote:

> For the next patch, we need a reference to DumpState when writing data.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  dump/dump.c           | 40 ++++++++++++++++++++--------------------
>  include/sysemu/dump.h |  2 +-
>  2 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 1f1a6edcab..2708ddc135 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)
>      dump_end(s, errp);
>  }
>
> -static int write_start_flat_header(int fd)
> +static int write_start_flat_header(DumpState *s)
>  {
>      MakedumpfileHeader *mh;
>      int ret =3D 0;
> @@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)
>      mh->version =3D cpu_to_be64(VERSION_FLAT_HEADER);
>
>      size_t written_size;
> -    written_size =3D qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER);
> +    written_size =3D qemu_write_full(s->fd, mh, MAX_SIZE_MDF_HEADER);
>      if (written_size !=3D MAX_SIZE_MDF_HEADER) {
>          ret =3D -1;
>      }
> @@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)
>      return ret;
>  }
>
> -static int write_end_flat_header(int fd)
> +static int write_end_flat_header(DumpState *s)
>  {
>      MakedumpfileDataHeader mdh;
>
> @@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)
>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>
>      size_t written_size;
> -    written_size =3D qemu_write_full(fd, &mdh, sizeof(mdh));
> +    written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
>      if (written_size !=3D sizeof(mdh)) {
>          return -1;
>      }
> @@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)
>      return 0;
>  }
>
> -static int write_buffer(int fd, off_t offset, const void *buf, size_t
> size)
> +static int write_buffer(DumpState *s, off_t offset, const void *buf,
> size_t size)
>  {
>      size_t written_size;
>      MakedumpfileDataHeader mdh;
> @@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const
> void *buf, size_t size)
>      mdh.offset =3D cpu_to_be64(offset);
>      mdh.buf_size =3D cpu_to_be64(size);
>
> -    written_size =3D qemu_write_full(fd, &mdh, sizeof(mdh));
> +    written_size =3D qemu_write_full(s->fd, &mdh, sizeof(mdh));
>      if (written_size !=3D sizeof(mdh)) {
>          return -1;
>      }
>
> -    written_size =3D qemu_write_full(fd, buf, size);
> +    written_size =3D qemu_write_full(s->fd, buf, size);
>      if (written_size !=3D size) {
>          return -1;
>      }
> @@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **err=
p)
>  #endif
>      dh->status =3D cpu_to_dump32(s, status);
>
> -    if (write_buffer(s->fd, 0, dh, size) < 0) {
> +    if (write_buffer(s, 0, dh, size) < 0) {
>          error_setg(errp, "dump: failed to write disk dump header");
>          goto out;
>      }
> @@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error
> **errp)
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump32(s, s->note_size);
>
> -    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
> +    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
>                       block_size, kh, size) < 0) {
>          error_setg(errp, "dump: failed to write kdump sub header");
>          goto out;
> @@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error
> **errp)
>      if (*errp) {
>          goto out;
>      }
> -    if (write_buffer(s->fd, offset_note, s->note_buf,
> +    if (write_buffer(s, offset_note, s->note_buf,
>                       s->note_size) < 0) {
>          error_setg(errp, "dump: failed to write notes");
>          goto out;
> @@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error
> **errp)
>  #endif
>      dh->status =3D cpu_to_dump32(s, status);
>
> -    if (write_buffer(s->fd, 0, dh, size) < 0) {
> +    if (write_buffer(s, 0, dh, size) < 0) {
>          error_setg(errp, "dump: failed to write disk dump header");
>          goto out;
>      }
> @@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error
> **errp)
>      kh->offset_note =3D cpu_to_dump64(s, offset_note);
>      kh->note_size =3D cpu_to_dump64(s, s->note_size);
>
> -    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
> +    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
>                       block_size, kh, size) < 0) {
>          error_setg(errp, "dump: failed to write kdump sub header");
>          goto out;
> @@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error
> **errp)
>          goto out;
>      }
>
> -    if (write_buffer(s->fd, offset_note, s->note_buf,
> +    if (write_buffer(s, offset_note, s->note_buf,
>                       s->note_size) < 0) {
>          error_setg(errp, "dump: failed to write notes");
>          goto out;
> @@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn,
> uint64_t pfn, bool value,
>      while (old_offset < new_offset) {
>          /* calculate the offset and write dump_bitmap */
>          offset_bitmap1 =3D s->offset_dump_bitmap + old_offset;
> -        if (write_buffer(s->fd, offset_bitmap1, buf,
> +        if (write_buffer(s, offset_bitmap1, buf,
>                           bitmap_bufsize) < 0) {
>              return -1;
>          }
> @@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn,
> uint64_t pfn, bool value,
>          /* dump level 1 is chosen, so 1st and 2nd bitmap are same */
>          offset_bitmap2 =3D s->offset_dump_bitmap + s->len_dump_bitmap +
>                           old_offset;
> -        if (write_buffer(s->fd, offset_bitmap2, buf,
> +        if (write_buffer(s, offset_bitmap2, buf,
>                           bitmap_bufsize) < 0) {
>              return -1;
>          }
> @@ -1380,7 +1380,7 @@ out:
>  static void prepare_data_cache(DataCache *data_cache, DumpState *s,
>                                 off_t offset)
>  {
> -    data_cache->fd =3D s->fd;
> +    data_cache->state =3D s;
>      data_cache->data_size =3D 0;
>      data_cache->buf_size =3D 4 * dump_bitmap_get_bufsize(s);
>      data_cache->buf =3D g_malloc0(data_cache->buf_size);
> @@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void
> *buf, size_t size,
>      /*
>       * if flag_sync is set, synchronize data in dc->buf into vmcore.
>       * otherwise check if the space is enough for caching data in buf, i=
f
> not,
> -     * write the data in dc->buf to dc->fd and reset dc->buf
> +     * write the data in dc->buf to dc->state->fd and reset dc->buf
>       */
>      if ((!flag_sync && dc->data_size + size > dc->buf_size) ||
>          (flag_sync && dc->data_size > 0)) {
> -        if (write_buffer(dc->fd, dc->offset, dc->buf, dc->data_size) < 0=
)
> {
> +        if (write_buffer(dc->state, dc->offset, dc->buf, dc->data_size) =
<
> 0) {
>              return -1;
>          }
>
> @@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error
> **errp)
>       *  +------------------------------------------+
>       */
>
> -    ret =3D write_start_flat_header(s->fd);
> +    ret =3D write_start_flat_header(s);
>      if (ret < 0) {
>          error_setg(errp, "dump: failed to write start flat header");
>          return;
> @@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error
> **errp)
>          return;
>      }
>
> -    ret =3D write_end_flat_header(s->fd);
> +    ret =3D write_end_flat_header(s);
>      if (ret < 0) {
>          error_setg(errp, "dump: failed to write end flat header");
>          return;
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index 7008d43d04..e27af8fb34 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {
>  } KdumpSubHeader64;
>
>  typedef struct DataCache {
> -    int fd;             /* fd of the file where to write the cached data
> */
> +    DumpState *state;   /* dump state related to this data */
>      uint8_t *buf;       /* buffer for cached data */
>      size_t buf_size;    /* size of the buf */
>      size_t data_size;   /* size of cached data in buf */
> --
> 2.39.2
>
>

--000000000000a66f690600b31851
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 17, 2023 at 9:55=E2=80=AF=
PM Stephen Brennan &lt;<a href=3D"mailto:stephen.s.brennan@oracle.com">step=
hen.s.brennan@oracle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">For the next patch, we need a reference to DumpStat=
e when writing data.<br>
<br>
Signed-off-by: Stephen Brennan &lt;<a href=3D"mailto:stephen.s.brennan@orac=
le.com" target=3D"_blank">stephen.s.brennan@oracle.com</a>&gt;<br></blockqu=
ote><div><br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</di=
v><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0dump/dump.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 ++++++++++++=
++++++++--------------------<br>
=C2=A0include/sysemu/dump.h |=C2=A0 2 +-<br>
=C2=A02 files changed, 21 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/dump/dump.c b/dump/dump.c<br>
index 1f1a6edcab..2708ddc135 100644<br>
--- a/dump/dump.c<br>
+++ b/dump/dump.c<br>
@@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)<b=
r>
=C2=A0 =C2=A0 =C2=A0dump_end(s, errp);<br>
=C2=A0}<br>
<br>
-static int write_start_flat_header(int fd)<br>
+static int write_start_flat_header(DumpState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileHeader *mh;<br>
=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
@@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)<br>
=C2=A0 =C2=A0 =C2=A0mh-&gt;version =3D cpu_to_be64(VERSION_FLAT_HEADER);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0size_t written_size;<br>
-=C2=A0 =C2=A0 written_size =3D qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER=
);<br>
+=C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, mh, MAX_SIZE_MDF_=
HEADER);<br>
=C2=A0 =C2=A0 =C2=A0if (written_size !=3D MAX_SIZE_MDF_HEADER) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-static int write_end_flat_header(int fd)<br>
+static int write_end_flat_header(DumpState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileDataHeader mdh;<br>
<br>
@@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)<br>
=C2=A0 =C2=A0 =C2=A0mdh.buf_size =3D END_FLAG_FLAT_HEADER;<br>
<br>
=C2=A0 =C2=A0 =C2=A0size_t written_size;<br>
-=C2=A0 =C2=A0 written_size =3D qemu_write_full(fd, &amp;mdh, sizeof(mdh));=
<br>
+=C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, &amp;mdh, sizeof(=
mdh));<br>
=C2=A0 =C2=A0 =C2=A0if (written_size !=3D sizeof(mdh)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-static int write_buffer(int fd, off_t offset, const void *buf, size_t size=
)<br>
+static int write_buffer(DumpState *s, off_t offset, const void *buf, size_=
t size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0size_t written_size;<br>
=C2=A0 =C2=A0 =C2=A0MakedumpfileDataHeader mdh;<br>
@@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const v=
oid *buf, size_t size)<br>
=C2=A0 =C2=A0 =C2=A0mdh.offset =3D cpu_to_be64(offset);<br>
=C2=A0 =C2=A0 =C2=A0mdh.buf_size =3D cpu_to_be64(size);<br>
<br>
-=C2=A0 =C2=A0 written_size =3D qemu_write_full(fd, &amp;mdh, sizeof(mdh));=
<br>
+=C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, &amp;mdh, sizeof(=
mdh));<br>
=C2=A0 =C2=A0 =C2=A0if (written_size !=3D sizeof(mdh)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 written_size =3D qemu_write_full(fd, buf, size);<br>
+=C2=A0 =C2=A0 written_size =3D qemu_write_full(s-&gt;fd, buf, size);<br>
=C2=A0 =C2=A0 =C2=A0if (written_size !=3D size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **errp)=
<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0dh-&gt;status =3D cpu_to_dump32(s, status);<br>
<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, 0, dh, size) &lt; 0) {<br>
+=C2=A0 =C2=A0 if (write_buffer(s, 0, dh, size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite disk dump header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0kh-&gt;offset_note =3D cpu_to_dump64(s, offset_note);<b=
r>
=C2=A0 =C2=A0 =C2=A0kh-&gt;note_size =3D cpu_to_dump32(s, s-&gt;note_size);=
<br>
<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, DISKDUMP_HEADER_BLOCKS *<br>
+=C2=A0 =C2=A0 if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 block_size, kh, size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite kdump sub header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0if (*errp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, offset_note, s-&gt;note_buf,<br>
+=C2=A0 =C2=A0 if (write_buffer(s, offset_note, s-&gt;note_buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;note_size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite notes&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error **err=
p)<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0dh-&gt;status =3D cpu_to_dump32(s, status);<br>
<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, 0, dh, size) &lt; 0) {<br>
+=C2=A0 =C2=A0 if (write_buffer(s, 0, dh, size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite disk dump header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0kh-&gt;offset_note =3D cpu_to_dump64(s, offset_note);<b=
r>
=C2=A0 =C2=A0 =C2=A0kh-&gt;note_size =3D cpu_to_dump64(s, s-&gt;note_size);=
<br>
<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, DISKDUMP_HEADER_BLOCKS *<br>
+=C2=A0 =C2=A0 if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 block_size, kh, size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite kdump sub header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, offset_note, s-&gt;note_buf,<br>
+=C2=A0 =C2=A0 if (write_buffer(s, offset_note, s-&gt;note_buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;note_size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite notes&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
@@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_=
t pfn, bool value,<br>
=C2=A0 =C2=A0 =C2=A0while (old_offset &lt; new_offset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* calculate the offset and write dump_bi=
tmap */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_bitmap1 =3D s-&gt;offset_dump_bitm=
ap + old_offset;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, offset_bitmap1, buf=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(s, offset_bitmap1, buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bitmap_bufsize) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_=
t pfn, bool value,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* dump level 1 is chosen, so 1st and 2nd=
 bitmap are same */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset_bitmap2 =3D s-&gt;offset_dump_bitm=
ap + s-&gt;len_dump_bitmap +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 old_offset;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(s-&gt;fd, offset_bitmap2, buf=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(s, offset_bitmap2, buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bitmap_bufsize) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1380,7 +1380,7 @@ out:<br>
=C2=A0static void prepare_data_cache(DataCache *data_cache, DumpState *s,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off_t offset)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 data_cache-&gt;fd =3D s-&gt;fd;<br>
+=C2=A0 =C2=A0 data_cache-&gt;state =3D s;<br>
=C2=A0 =C2=A0 =C2=A0data_cache-&gt;data_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0data_cache-&gt;buf_size =3D 4 * dump_bitmap_get_bufsize=
(s);<br>
=C2=A0 =C2=A0 =C2=A0data_cache-&gt;buf =3D g_malloc0(data_cache-&gt;buf_siz=
e);<br>
@@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void *b=
uf, size_t size,<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * if flag_sync is set, synchronize data in dc-&gt;buf =
into vmcore.<br>
=C2=A0 =C2=A0 =C2=A0 * otherwise check if the space is enough for caching d=
ata in buf, if not,<br>
-=C2=A0 =C2=A0 =C2=A0* write the data in dc-&gt;buf to dc-&gt;fd and reset =
dc-&gt;buf<br>
+=C2=A0 =C2=A0 =C2=A0* write the data in dc-&gt;buf to dc-&gt;state-&gt;fd =
and reset dc-&gt;buf<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if ((!flag_sync &amp;&amp; dc-&gt;data_size + size &gt;=
 dc-&gt;buf_size) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(flag_sync &amp;&amp; dc-&gt;data_size &g=
t; 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(dc-&gt;fd, dc-&gt;offset, dc-=
&gt;buf, dc-&gt;data_size) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write_buffer(dc-&gt;state, dc-&gt;offset, =
dc-&gt;buf, dc-&gt;data_size) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 *=C2=A0 +------------------------------------------+<b=
r>
=C2=A0 =C2=A0 =C2=A0 */<br>
<br>
-=C2=A0 =C2=A0 ret =3D write_start_flat_header(s-&gt;fd);<br>
+=C2=A0 =C2=A0 ret =3D write_start_flat_header(s);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite start flat header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ret =3D write_end_flat_header(s-&gt;fd);<br>
+=C2=A0 =C2=A0 ret =3D write_end_flat_header(s);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;dump: failed to wr=
ite end flat header&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h<br>
index 7008d43d04..e27af8fb34 100644<br>
--- a/include/sysemu/dump.h<br>
+++ b/include/sysemu/dump.h<br>
@@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {<br>
=C2=A0} KdumpSubHeader64;<br>
<br>
=C2=A0typedef struct DataCache {<br>
-=C2=A0 =C2=A0 int fd;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fd=
 of the file where to write the cached data */<br>
+=C2=A0 =C2=A0 DumpState *state;=C2=A0 =C2=A0/* dump state related to this =
data */<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *buf;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* buffer for c=
ached data */<br>
=C2=A0 =C2=A0 =C2=A0size_t buf_size;=C2=A0 =C2=A0 /* size of the buf */<br>
=C2=A0 =C2=A0 =C2=A0size_t data_size;=C2=A0 =C2=A0/* size of cached data in=
 buf */<br>
-- <br>
2.39.2<br>
<br>
</blockquote></div></div>

--000000000000a66f690600b31851--


