Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF17DF538
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:39:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYq8-0008OY-Jh; Thu, 02 Nov 2023 10:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qyYq1-0008ON-2O
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:38:25 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qyYpz-0002ru-61
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:38:24 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4197fa36b6aso5252051cf.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698935901; x=1699540701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejkseplvrMek9eThrnFfzFiF6xLK8EYoy7pSv61VTVU=;
 b=ZvVNDxBfWxErQK65DGEKauf8X/I0oropkCKgz3pkdj4KQ7liOf/T+cUxYY+tKqCCCk
 d8NG1KqskT1LoqGv9D3uc8RA8HIHuLBXzO0A0KewoAby6l2UNK/j6Sz5D+VZWhTf1MT8
 De6CWOw0NrgiZE4MaLEqqELBfyGjDuLcIEY3wfKUq+Mc4tOQO5I8TdAIQF17b0lKF/3W
 KbN2/VgbKLIkGitDi2JxS0D7klXKebLZxNNplTePSBlddAAkOsF4eFx+g0Gzlw/fuO0E
 4jux5uWPu0cJiI/kiPPmaaSxSDNNOrC8ka9agwiHAHG80x7JkRg/yQv8u0vzB76k57iM
 fZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698935901; x=1699540701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejkseplvrMek9eThrnFfzFiF6xLK8EYoy7pSv61VTVU=;
 b=ji+9bzH7yjSqVo7VwB5qDc4a3L2eg108owyvbha9woV8I0UnkVNr/YlIGz4c2QJloj
 kP8ej+YaAHyrDTFpuFqqmuaG3dfGebnQlwbIkgWASwFqcVEoBkELCPI3j1F6wwVmWtts
 r6b9B5IdeojD6V5E/+tuPq5ua5femxQ8Mqo2DFCO5/PMtFSTJ/8uAlhSfVun76xS81Mi
 UhphHgGHFlo/dnOJNPmKW2NTv/fsaXpfYvOsPi8QUl9sT3a9tkpUl4hbAx31w5xEgShZ
 kR6lf672xeB7yJ+avex2HuMlvwf8BDrpQ3IfXb3eTjUTJaTvyCWtljEx6JGsM5z+Ssq8
 dIOA==
X-Gm-Message-State: AOJu0Yxgkb0jj54WnAjgvJWRqHv7FIYR0clfXlaaEkGK3EwyJhctgCoZ
 uhpRVx4kTICuKo4pue1rtG2CpLDcSEPAbaBdiks=
X-Google-Smtp-Source: AGHT+IFoxpbVfd9kGQmH4oLyyNdEkqHq45cTuLgdCGBQCNGf5CLOR7OGKv5Wb3kTPti3tHcbPIDa+2u9EqrOdlCFl6k=
X-Received: by 2002:a05:622a:138b:b0:41c:e206:349b with SMTP id
 o11-20020a05622a138b00b0041ce206349bmr20516024qtk.68.1698935901187; Thu, 02
 Nov 2023 07:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
 <20230918233233.1431858-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20230918233233.1431858-3-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 2 Nov 2023 18:38:09 +0400
Message-ID: <CAJ+F1CKOWYwrjmLoiQRC=s8XBBE-x2qvABNX1bUVgQdtG-+Q8w@mail.gmail.com>
Subject: Re: [PATCH v3 qemu 2/3] dump: Allow directly outputting raw kdump
 format
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Stephen

On Tue, Sep 19, 2023 at 3:32=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> The flattened format (currently output by QEMU) is used by makedumpfile
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
> "write_buffer()" in makedumpfile [1]. However, QEMU has always used the
> flattened format. For compatibility it is best not to change the default
> output format without warning. So, add a flag to DumpState which changes
> the output to use the normal (i.e. raw) format. This flag will be added
> to the QMP and HMP commands in the next change.
>
> [1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a274=
6dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  dump/dump.c           | 32 +++++++++++++++++++++++++-------
>  include/sysemu/dump.h |  1 +
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 74071a1565..10aa2c79e0 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -814,6 +814,10 @@ static int write_start_flat_header(DumpState *s)
>      MakedumpfileHeader *mh;
>      int ret =3D 0;
>
> +    if (s->kdump_raw) {
> +        return 0;
> +    }
> +
>      QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
>      mh =3D g_malloc0(MAX_SIZE_MDF_HEADER);
>
> @@ -837,6 +841,10 @@ static int write_end_flat_header(DumpState *s)
>  {
>      MakedumpfileDataHeader mdh;
>
> +    if (s->kdump_raw) {
> +        return 0;
> +    }
> +
>      mdh.offset =3D END_FLAG_FLAT_HEADER;
>      mdh.buf_size =3D END_FLAG_FLAT_HEADER;
>
> @@ -853,13 +861,21 @@ static int write_buffer(DumpState *s, off_t offset,=
 const void *buf, size_t size
>  {
>      size_t written_size;
>      MakedumpfileDataHeader mdh;
> +    loff_t seek_loc;

Any reason to use loff_t over off_t here? It fails to compile on win32
for ex. I can touch on PR commit otherwise.

>
> -    mdh.offset =3D cpu_to_be64(offset);
> -    mdh.buf_size =3D cpu_to_be64(size);
> +    if (s->kdump_raw) {
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
> @@ -1775,7 +1791,8 @@ static void vmcoreinfo_update_phys_base(DumpState *=
s)
>
>  static void dump_init(DumpState *s, int fd, bool has_format,
>                        DumpGuestMemoryFormat format, bool paging, bool ha=
s_filter,
> -                      int64_t begin, int64_t length, Error **errp)
> +                      int64_t begin, int64_t length, bool kdump_raw,
> +                      Error **errp)
>  {
>      ERRP_GUARD();
>      VMCoreInfoState *vmci =3D vmcoreinfo_find();
> @@ -1786,6 +1803,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
>      s->has_format =3D has_format;
>      s->format =3D format;
>      s->written_size =3D 0;
> +    s->kdump_raw =3D kdump_raw;
>
>      /* kdump-compressed is conflict with paging and filter */
>      if (has_format && format !=3D DUMP_GUEST_MEMORY_FORMAT_ELF) {
> @@ -2168,7 +2186,7 @@ void qmp_dump_guest_memory(bool paging, const char =
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
> index e27af8fb34..d702854853 100644
> --- a/include/sysemu/dump.h
> +++ b/include/sysemu/dump.h
> @@ -157,6 +157,7 @@ typedef struct DumpState {
>      MemoryMappingList list;
>      bool resume;
>      bool detached;
> +    bool kdump_raw;
>      hwaddr memory_offset;
>      int fd;
>
> --
> 2.39.3
>


--=20
Marc-Andr=C3=A9 Lureau

