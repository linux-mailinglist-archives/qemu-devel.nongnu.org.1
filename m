Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D04907A482A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCCT-0001zu-El; Mon, 18 Sep 2023 07:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiCCF-0001vP-E6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:13:49 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiCCC-0005PI-Pm
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:13:42 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3adcec86a8cso694104b6e.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695035620; x=1695640420; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Muytw7Xb3bSzzBX7EybLQFIvJbCJQTp+2CyV7XtpksY=;
 b=g14jgEcYkxQJohRlYJvHKFSv4/eZTAVqgymdKiVuomCwvb4QH8HScVIuAXC86p4uyf
 fs8XEeBlWXWBaII5f8Y7ESjRgFy4nss151qHHsuhaNu/tIWWaGJYMuk4gkqyJ0quf3Mq
 z7DY7g4JZbibktclyfVfqkP5u5FwFdA+aVBkxHTCOnrMPQ7gZa/dIojOJc+1tbQIf1YQ
 Q0tEQPJ0rM/6K9ZPsSA2oCtMeMKOcJvxwn1KTk4q8t5Ak0nyJPhyrELRhuDcLnhBbK3J
 lYOFYtbLYc2tz2AU9T2kfFSQTf6MK9SMfka3Kr7OzATZ+rSzihsQYWqUBswvq24fcCA6
 44pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695035620; x=1695640420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Muytw7Xb3bSzzBX7EybLQFIvJbCJQTp+2CyV7XtpksY=;
 b=AinXYENjuvbwaVXDIDdOJ054f2B7udeG9yfK8xK5AKyb0Q/TcKgWMlAumwkrPsDsBs
 FV8V1z3bYlsNd3cOHTUVJ62Bis8HClNZCDq183Qa7yCoFaXkE0vS3fOnV8404evFPPG0
 EK4Lwa/A+MBeP/5AXHoT75UvK+WEsFCTbFcEJwNRbnd8alFk4Q+U5rtdmRhdgm33kO7a
 Ju9XMNaFSCty19Pfol6NlgKXthsZKvj7Wq/VDMfqOehYqF6L1itHhDNE6CP/RsAum9/W
 35Whcub+R3nB8A3nRD3AiQZ2mjIax63qypeEC8xxkRdgXOeEAb4rzsiwMR13njINymmz
 zfCw==
X-Gm-Message-State: AOJu0Yw25b/VCr/irkOy58FPK8KW5Oljdp8L9/dH2W5tWv0GNqWvXXGj
 1Qbck4BwwwpOHDtWAKAyNzDxzaCzNehWILm8ImE=
X-Google-Smtp-Source: AGHT+IFIi7FYpZ7QGaNe6e+jd8ZoMjoM0RUuOEuL6Emc4X3VThBzglUCDwHhDY+uB1Om6hu0o2UhBxxEgfs9oowIk8E=
X-Received: by 2002:a05:6808:64c:b0:3a7:36f9:51aa with SMTP id
 z12-20020a056808064c00b003a736f951aamr8023601oih.17.1695035619688; Mon, 18
 Sep 2023 04:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
 <20230914010315.945705-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20230914010315.945705-3-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Sep 2023 15:13:28 +0400
Message-ID: <CAJ+F1CJK60Mu5DJTgPg1ytGaxQ3aoXiV9GXG61+rOOYDuk6Dmg@mail.gmail.com>
Subject: Re: [PATCH v2 qemu 2/3] dump: Allow directly outputting reassembled
 kdumps
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, Sep 14, 2023 at 5:04=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> The flattened format (currently output by qemu) is used by makedumpfile
> only when it is outputting a vmcore to a file which is not seekable. The
> flattened format functions essentially as a set of instructions of the
> form "seek to the given offset, then write the given bytes out".
>
> The flattened format can be reconstructed using makedumpfile -R, or
> makedumpfile-R.pl, but it is a slow process because it requires copying
> the entire vmcore. The flattened format can also be directly read by
> crash, but still, it requires a lengthy reassembly phase.
>
> To sum up, the flattened format is not an ideal one: it should only be
> used on files which are actually not seekable. This is the exact
> strategy which makedumpfile uses, as seen in the implementation of
> "write_buffer()" in makedumpfile [1]. However, Qemu has always used the
> flattened format. For compatibility it is best not to change the default
> output format without warning. So, add a flag to DumpState which changes
> the output to use the normal (i.e. reassembled) format. This flag will
> be added to the QMP commands in the next change.
>
> [1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a274=
6dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  dump/dump.c           | 38 +++++++++++++++++++++++++++++++-------
>  include/sysemu/dump.h |  1 +
>  2 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 74071a1565..fb9040cfbc 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -814,6 +814,16 @@ static int write_start_flat_header(DumpState *s)
>      MakedumpfileHeader *mh;
>      int ret =3D 0;
>
> +    /* The user can request we not use the flattened format, but
> +     * if the file is not seekable, we need to fall back to flattened. *=
/
> +    if (s->kdump_reassembled) {
> +        if (lseek(s->fd, 0, SEEK_CUR) =3D=3D (loff_t) -1) {
> +            s->kdump_reassembled =3D false;

Since it was explicitly asked by the user, we better return an error
instead of falling back silently on flattened.


> +        } else {
> +            return 0;
> +        }
> +    }
> +
>      QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
>      mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);
>
> @@ -837,6 +847,10 @@ static int write_end_flat_header(DumpState *s)
>  {
>      MakedumpfileDataHeader mdh;
>
> +    if (s->kdump_reassembled) {
> +        return 0;
> +    }
> +
>      mdh.offset =3D END_FLAG_FLAT_HEADER;
>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>
> @@ -853,13 +867,21 @@ static int write_buffer(DumpState *s, off_t offset,=
 const void *buf, size_t size
>  {
>      size_t written_size;
>      MakedumpfileDataHeader mdh;
> +    loff_t seek_loc;
>
> -    mdh.offset =3D cpu_to_be64(offset);
> -    mdh.buf_size =3D cpu_to_be64(size);
> +    if (s->kdump_reassembled) {
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
> @@ -1775,7 +1797,8 @@ static void vmcoreinfo_update_phys_base(DumpState *=
s)
>
>  static void dump_init(DumpState *s, int fd, bool has_format,
>                        DumpGuestMemoryFormat format, bool paging, bool ha=
s_filter,
> -                      int64_t begin, int64_t length, Error **errp)
> +                      int64_t begin, int64_t length, bool kdump_reassemb=
led,
> +                      Error **errp)
>  {
>      ERRP_GUARD();
>      VMCoreInfoState *vmci =3D vmcoreinfo_find();
> @@ -1786,6 +1809,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
>      s->has_format =3D has_format;
>      s->format =3D format;
>      s->written_size =3D 0;
> +    s->kdump_reassembled =3D kdump_reassembled;
>
>      /* kdump-compressed is conflict with paging and filter */
>      if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> @@ -2168,7 +2192,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>      dump_state_prepare(s);
>
>      dump_init(s, fd, has_format, format, paging, has_begin,
> -              begin, length, errp);
> +              begin, length, false, errp);
>      if (*errp) {
>          qatomic_set(&s->status, DUMP_STATUS_FAILED);
>          return;
> diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
> index e27af8fb34..71ec492fce 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -157,6 +157,7 @@ typedef struct DumpState {
>      MemoryMappingList list;
>      bool resume;
>      bool detached;
> +    bool kdump_reassembled;
>      hwaddr memory_offset;
>      int fd;
>
> --
> 2.39.3
>


--
Marc-Andr=C3=A9 Lureau

