Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C75D7A482E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCEh-0003Gu-GW; Mon, 18 Sep 2023 07:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiCEf-0003Dd-El
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:16:13 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiCEa-0005vV-8G
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 07:16:13 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-773a5bb6fb6so226386285a.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695035767; x=1695640567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUlZ0YcSMol8OYE5fUSjDOxC0F0uI+1cUnDhDBAua1U=;
 b=hInN86D0RPW+4JF6ZvpOmYetcWOShjBnar8q90WEDQmV9cpvRdi1P7jygAjumqsVHn
 osuA5YDsIo3KwRftOe3Q98bOIgaverkcA4xQS2hn2mAWFg+ByxSLgcAqQo0LWyYeAWoh
 LsAmjp7DpxvA9JQoLf3jlwezZg1m4rY7uZbWA+SgZnUMDWfXTrMqNOX1fs7YaUTMSLz1
 1B6hs8XsrOUak+kStkc6oVyiYh6FC85CTL9CR+YdUUdgIuV4eXvQo7QyzF8+CwRKp0C9
 NKdEngIFfS0ozLFnQ6Zl5BvWtGbb86GmMIHc0ev6KGjpzBdUrfww/r4CSyPgMy8ll8c1
 HZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695035767; x=1695640567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUlZ0YcSMol8OYE5fUSjDOxC0F0uI+1cUnDhDBAua1U=;
 b=YwHC9RmlCNlegENjV0+9wvUSZqpe9eeHxPDrOMNdrDDCYaQEubzST4m+FiMKaPSv6a
 6HRMy2TRM9Zh9z7DHUO0t+ZW/nXbRBYmrxN1f0G1oHv9NVllBmzjLEJYdAbRy3ugrjAO
 UemLphlIbAnoBWHgrasKcj8BTqQIhTofaUp8Nl97ZxbDQ1bG3qr87X4U/lZQmrJg3Y7w
 siKKdMdpjKv1pXVf7SdVqYCIzdkBF32asQfL9vNeDgWQXsR8Jm3FaJ5Ti/5xYMTZ75/5
 DCUN4pf1K15UScHROoBBIE7psRqwObMVXroSePZ9yBACQAXPFCfmcRPGT4ArFvOrxqE/
 IjWg==
X-Gm-Message-State: AOJu0YzqT2p1kma/6+8eOLmBDHODMuFDiD8t5Hhe+EKMdKEO2JpST/Hg
 k1/LUxahQwCg3G1JCNhj48FhgytIeGekVBI994U=
X-Google-Smtp-Source: AGHT+IEM9u0REq9MN60ViPYHi3AIusEPjm3JRFnrvrdTjzE9/rfN1Zi27GpFI0jNLJV2BM1Q50uGOBx8xYh7cQvkGuA=
X-Received: by 2002:a05:622a:1a25:b0:403:b2fc:1e69 with SMTP id
 f37-20020a05622a1a2500b00403b2fc1e69mr10023143qtb.12.1695035767155; Mon, 18
 Sep 2023 04:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
 <20230914010315.945705-4-stephen.s.brennan@oracle.com>
In-Reply-To: <20230914010315.945705-4-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Sep 2023 15:15:55 +0400
Message-ID: <CAJ+F1CJmBg_v3982=TdKTRQF2m88Cf-2Jfj1JcCrtR3OdWqKVg@mail.gmail.com>
Subject: Re: [PATCH v2 qemu 3/3] dump: Add qmp argument "reassembled"
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 5:03=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> This can be used from QMP command line as "-R" to mirror the
> corresponding flag for makedumpfile. This enables the kdump_reassembled
> flag introduced in the previous patch.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  dump/dump-hmp-cmds.c |  8 +++++++-
>  dump/dump.c          | 12 +++++++++++-
>  hmp-commands.hx      |  7 +++++--
>  qapi/dump.json       | 14 +++++++++++++-
>  4 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> index b038785fee..1d882e4bd8 100644
> --- a/dump/dump-hmp-cmds.c
> +++ b/dump/dump-hmp-cmds.c
> @@ -24,9 +24,11 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *=
qdict)
>      bool has_begin =3D qdict_haskey(qdict, "begin");
>      bool has_length =3D qdict_haskey(qdict, "length");
>      bool has_detach =3D qdict_haskey(qdict, "detach");
> +    bool has_reassembled =3D qdict_haskey(qdict, "reassembled");
>      int64_t begin =3D 0;
>      int64_t length =3D 0;
>      bool detach =3D false;
> +    bool reassembled =3D false;
>      enum DumpGuestMemoryFormat dump_format =3D DUMP_GUEST_MEMORY_FORMAT_=
ELF;
>      char *prot;
>
> @@ -61,11 +63,15 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict =
*qdict)
>      if (has_detach) {
>          detach =3D qdict_get_bool(qdict, "detach");
>      }
> +    if (has_reassembled) {
> +        reassembled =3D qdict_get_bool(qdict, "reassembled");
> +    }
>
>      prot =3D g_strconcat("file:", file, NULL);
>
>      qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
> -                          has_length, length, true, dump_format, &err);
> +                          has_length, length, true, has_reassembled,
> +                          reassembled, dump_format, &err);
>      hmp_handle_error(mon, err);
>      g_free(prot);
>  }
> diff --git a/dump/dump.c b/dump/dump.c
> index fb9040cfbc..42d4015fb3 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2089,6 +2089,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>                             bool has_detach, bool detach,
>                             bool has_begin, int64_t begin, bool has_lengt=
h,
>                             int64_t length, bool has_format,
> +                           bool has_reassembled, bool reassembled,
>                             DumpGuestMemoryFormat format, Error **errp)
>  {
>      ERRP_GUARD();
> @@ -2119,6 +2120,12 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>                           "filter");
>          return;
>      }
> +    if (has_reassembled && format !=3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZL=
IB
> +                        && format !=3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZ=
O
> +                        && format !=3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SN=
APPY) {
> +        error_setg(errp, "'reassembled' only applies to kdump format");
> +        return;
> +    }
>      if (has_begin && !has_length) {
>          error_setg(errp, QERR_MISSING_PARAMETER, "length");
>          return;
> @@ -2130,6 +2137,9 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>      if (has_detach) {
>          detach_p =3D detach;
>      }
> +    if (!has_reassembled) {
> +        reassembled =3D false;
> +    }
>
>      /* check whether lzo/snappy is supported */
>  #ifndef CONFIG_LZO
> @@ -2192,7 +2202,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>      dump_state_prepare(s);
>
>      dump_init(s, fd, has_format, format, paging, has_begin,
> -              begin, length, false, errp);
> +              begin, length, reassembled, errp);
>      if (*errp) {
>          qatomic_set(&s->status, DUMP_STATUS_FAILED);
>          return;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 2cbd0f77a0..c3062da470 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1085,14 +1085,15 @@ ERST
>
>      {
>          .name       =3D "dump-guest-memory",
> -        .args_type  =3D "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,sn=
appy:-s,filename:F,begin:l?,length:l?",
> -        .params     =3D "[-p] [-d] [-z|-l|-s|-w] filename [begin length]=
",
> +        .args_type  =3D "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,sn=
appy:-s,reassembled:-R,filename:F,begin:l?,length:l?",
> +        .params     =3D "[-p] [-d] [-z|-l|-s|-w] [-R] filename [begin le=
ngth]",
>          .help       =3D "dump guest memory into file 'filename'.\n\t\t\t=
"
>                        "-p: do paging to get guest's memory mapping.\n\t\=
t\t"
>                        "-d: return immediately (do not wait for completio=
n).\n\t\t\t"
>                        "-z: dump in kdump-compressed format, with zlib co=
mpression.\n\t\t\t"
>                        "-l: dump in kdump-compressed format, with lzo com=
pression.\n\t\t\t"
>                        "-s: dump in kdump-compressed format, with snappy =
compression.\n\t\t\t"
> +                      "-R: when using kdump (-z, -l, -s), try to avoid t=
he flattened format.\n\t\t\t"
>                        "-w: dump in Windows crashdump format (can be used=
 instead of ELF-dump converting),\n\t\t\t"
>                        "    for Windows x86 and x64 guests with vmcoreinf=
o driver only.\n\t\t\t"
>                        "begin: the starting physical address.\n\t\t\t"
> @@ -1115,6 +1116,8 @@ SRST
>      dump in kdump-compressed format, with lzo compression.
>    ``-s``
>      dump in kdump-compressed format, with snappy compression.
> +  ``-R``
> +    when using kdump (-z, -l, -s), try to avoid the flattened format.
>    ``-w``
>      dump in Windows crashdump format (can be used instead of ELF-dump co=
nverting),
>      for Windows x64 guests with vmcoreinfo driver only
> diff --git a/qapi/dump.json b/qapi/dump.json
> index 4ae1f722a9..9cc7c3ea93 100644
> --- a/qapi/dump.json
> +++ b/qapi/dump.json
> @@ -69,6 +69,18 @@
>  #     to dump all guest's memory, please specify the start @begin and
>  #     @length
>  #
> +# @reassembled: if false (the default), the kdump output formats will us=
e the
> +#     "makedumpfile flattened" variant of the format, which is less broa=
dly
> +#     compatible with analysis tools. The flattened dump can be reassemb=
led
> +#     after the fact using the command "makedumpfile -R". If true, Qemu

QEMU

> +#     attempts to generate the standard kdump format. This requires a
> +#     seekable file as output -- if the output file is not seekable, the=
n
> +#     the flattened format is still generated. The standard format is mo=
re

Will have to be adjusted to return an error if we drop the fallback behavio=
ur.

> +#     broadly compatible with debugging tools, but generating it require=
s a
> +#     seekable output file descriptor, and could use more system memory =
due
> +#     to page cache utilization. This should be left unspecified for non=
-kdump
> +#     output formats.
> +#
>  # @format: if specified, the format of guest memory dump.  But non-elf
>  #     format is conflict with paging and filter, ie.  @paging, @begin
>  #     and @length is not allowed to be specified with non-elf @format
> @@ -89,7 +101,7 @@
>  { 'command': 'dump-guest-memory',
>    'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
>              '*begin': 'int', '*length': 'int',
> -            '*format': 'DumpGuestMemoryFormat'} }
> +            '*reassembled': 'bool', '*format': 'DumpGuestMemoryFormat'} =
}
>
>  ##
>  # @DumpStatus:
> --
> 2.39.3
>


--=20
Marc-Andr=C3=A9 Lureau

