Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4127E4145
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:54:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MXI-0005nz-Vj; Tue, 07 Nov 2023 08:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0MX9-0005nJ-96
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:54:23 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0MX7-0000kS-Et
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:54:23 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso9422421a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699365259; x=1699970059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ehJuneutVnZo8eVkxRP+OOMKBTey12ObjuPsdkLoKHk=;
 b=LNsQUv9Qhk2jSv1jQvk02htxFsXd/UveV+ZpSWw7cjnjDer4/DJXO0D5x2Qws0KXqc
 Bj2oQjoPgU8L9lkgJ0ayYPexZyRZ6RtMvY3pPo9mmG3iOXKfiz5wgUxakvl2vttLdz/+
 MtboCMrO8ueDWPLn0OB/KF2W+tzkHFVB0SmckFbToueRgaIvGkofl3/M6+hIo3o36ELR
 uaM2YpMB5mS1KZRGqa45MH4QubsTgWMDpCY7XktU8mEBaomVBVcFMCQ/gOimY7LsD2wE
 Dv0pf7AvPi8wdRHqLBZaHwrYzUboMXOX0450m4AiDbcFPvQoy5//uP5e/Arf2f4hjzMn
 +RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699365259; x=1699970059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ehJuneutVnZo8eVkxRP+OOMKBTey12ObjuPsdkLoKHk=;
 b=fbCMRPNekrhEz1l62imijaXXte1BKK/cUDJepmaxMMS7DducwTOgyoHzX9Hfur4NF9
 IdcH22lCGFC3oTrP8BRUDfSuu0h63chr9txvQWXY+rY73zXBEGSKENJJRglLzSD0BoDz
 YO6+G8LRGW6TH6/kZzMk2ptMA5vv7/h4GBCkd7XBEIVsCFfSJuNAtKFxPeqNlDiPDnWu
 umsf/75An+jfXoVUH5X8AbeiKRExsi2XjHK9fQf61Pn6PPYaQG9nflrGA1waYzTLbtqN
 JDLuJSjlJ0/iESkj2YGOPXjTyJiHE1Zrdy0ZnwgyWW6zJ8873USkxb7/3TUEbeXwWveW
 dl9w==
X-Gm-Message-State: AOJu0Yy1Anx+FlzpJ+WtEHbWjON6E9qAA530uuuOzvKvqz15zJd98z0N
 zwUBzbOiFSvUhpzKRUjtmrGCf1cozvQaPjt8Zc0AUA==
X-Google-Smtp-Source: AGHT+IFPbuxHg5xSk24I3Z+BRranAURIMp0Po1cJf9CsV3GSZx9450uJPfxAj8K6g7Mtj4CD0WZkVWtqHjkJoWyzHqI=
X-Received: by 2002:a50:d694:0:b0:542:f968:f9f9 with SMTP id
 r20-20020a50d694000000b00542f968f9f9mr19566834edi.28.1699365259550; Tue, 07
 Nov 2023 05:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
 <20231103070136.437557-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231103070136.437557-4-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 13:54:08 +0000
Message-ID: <CAFEAcA9Pzr_bHom6hy8g8ARS6kbaqLZ8i0wCFT_yjrvBfJu9tQ@mail.gmail.com>
Subject: Re: [PULL 3/8] dump: Add command interface for kdump-raw formats
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org, 
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 3 Nov 2023 at 07:02, <marcandre.lureau@redhat.com> wrote:
>
> From: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> The QMP dump API represents the dump format as an enumeration. Add three
> new enumerators, one for each supported kdump compression, each named
> "kdump-raw-*".
>
> For the HMP command line, rather than adding a new flag corresponding to
> each format, it seems more human-friendly to add a single flag "-R" to
> switch the kdump formats to "raw" mode. The choice of "-R" also
> correlates nicely to the "makedumpfile -R" option, which would serve to
> reassemble a flattened vmcore.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> [ Marc-Andr=C3=A9: replace loff_t with off_t, indent fixes ]
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20230918233233.1431858-4-stephen.s.brennan@oracle.com>

Hi; Coverity points out some issues in this commit:

> diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> index b038785fee..b428ec33df 100644
> --- a/dump/dump-hmp-cmds.c
> +++ b/dump/dump-hmp-cmds.c
> @@ -19,6 +19,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *q=
dict)
>      bool paging =3D qdict_get_try_bool(qdict, "paging", false);
>      bool zlib =3D qdict_get_try_bool(qdict, "zlib", false);
>      bool lzo =3D qdict_get_try_bool(qdict, "lzo", false);
> +    bool raw =3D qdict_get_try_bool(qdict, "raw", false);
>      bool snappy =3D qdict_get_try_bool(qdict, "snappy", false);
>      const char *file =3D qdict_get_str(qdict, "filename");
>      bool has_begin =3D qdict_haskey(qdict, "begin");
> @@ -40,16 +41,28 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict =
*qdict)
>          dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
>      }
>
> -    if (zlib) {
> -        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;
> +    if (zlib && raw) {
> +        if (raw) {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
> +        } else {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB;

This is dead code, beacuse the outer conditional "(zlib && raw)"
ensures that raw can't be false here. What was the intention here?
(CID 1523841)

> +        }
>      }
>
>      if (lzo) {
> -        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
> +        if (raw) {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_LZO;
> +        } else {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO;
> +        }
>      }
>
>      if (snappy) {
> -        dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
> +        if (raw) {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY;
> +        } else {
> +            dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY;
> +        }
>      }
>
>      if (has_begin) {


> @@ -2166,6 +2190,10 @@ void qmp_dump_guest_memory(bool paging, const char=
 *file,
>          error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
>          return;
>      }
> +    if (kdump_raw && lseek(fd, 0, SEEK_CUR) =3D=3D (off_t) -1) {
> +        error_setg(errp, "kdump-raw formats require a seekable file");
> +        return;
> +    }

This error-exit return path forgets to close(fd), so we leak
the file descriptor. (CID 1523842)

>
>      if (!dump_migration_blocker) {
>          error_setg(&dump_migration_blocker,

thanks
-- PMM

