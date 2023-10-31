Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999557DCAB1
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:24:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxlug-0002oV-1w; Tue, 31 Oct 2023 06:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxlue-0002oC-Jd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:23:56 -0400
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxlud-0004nB-3l
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:23:56 -0400
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66d24ccc6f2so54438006d6.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698747834; x=1699352634; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKcc/kOqO0R/o/OAUFULcmidUnlZdUnkz5giafdFtA8=;
 b=QA38vd3jKjWUNifILN6F3KpaYzK3Ap2cQlkRbpcRwy7fbPzuvvAKXzmRGD7XEsFm0L
 959243+8EkbWz8c2xwISpt/berDolPMXmf2reEbiIm+Y1WzOHeF6PMjpMzKK+A6DE0/k
 ul+nElq/MrQLIxiioPfOt34cjCQm8BjQKZJdpBuAhErYUdAfq4KKDx2mXKLIEGPsUuZy
 9o1E2bEtdXpWTqBUgbTXTaPlZsOuSmc2T2lcUaLz7DdWWRZ617GvuQ5hj3Zvk3yuVqj8
 E22UTcmkO0C8h2mf5OxAGsNOsilXwvMNcavvjbLEHiKtWPZUaw34Hsr8YvOe1PmPmUv+
 /q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698747834; x=1699352634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKcc/kOqO0R/o/OAUFULcmidUnlZdUnkz5giafdFtA8=;
 b=U9JozPFYVfhlNcgDQI8H+I5MwU5wlohRF4tBE5z+LbO3hKlcK4W9BerP4IO4JYknvB
 3n+pBuqLO9lhFmjb+mDAooNpIeTJSsqzv5r8zeTQXDIQmShHwC9xXzWz41euvf2AXBir
 cMHhahwiGQf5dnCNdgLNKSUJ8kqoFtQg4+ipH10CNtQx/2/fwwbsPHpmW8mpbNHHa3bl
 fC8PAohbZ7I2MGKsxq5PDQJYgHT2goUy4jzp6Xdtap+NJfpHXdPd7voWMHO0cP/8253G
 jsh1cYNXQZQ9O2j844iqOVk/DPwEmw3prqH+GmaTE/bNf9xlRw3SOprRKaNEwEJ0eTWl
 r0ZQ==
X-Gm-Message-State: AOJu0YzqTIaJV+zdZQKxcSIL8Q6RiOW9p1ZFtPJ31SmloPV4F/OeoRn2
 6QZSwp5r4aEEo8qakC1nWRvqlRtG1RSowjwqHWQ/wl6EFGMDaw==
X-Google-Smtp-Source: AGHT+IHss0ThvqElsO+V9MA0oYVk87QNjIM/A0RcaQGcoBdABlIne0GDm7qwh6znUKBXpDwBPrUQBqkvytrbTEleMMs=
X-Received: by 2002:ad4:5a54:0:b0:66d:670:d425 with SMTP id
 ej20-20020ad45a54000000b0066d0670d425mr2931969qvb.31.1698747833819; Tue, 31
 Oct 2023 03:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-6-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-6-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Oct 2023 14:23:41 +0400
Message-ID: <CAJ+F1CKEeBS85GYNNtbNaa9wZejWPvy8icK66XmVyORTvohb2Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] dump: Drop redundant check for empty dump
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2e.google.com
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

On Mon, Oct 30, 2023 at 5:37=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> dump_init() first computes the size of the dump, taking the filter
> area into account, and fails if its zero.  It then looks for memory in
> the filter area, and fails if there is none.
>
> This is redundant: if the size of the dump is zero, there is no
> memory, and vice versa.  Delete this check.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index d888e4bd3c..03627a4c17 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1674,26 +1674,6 @@ static void create_kdump_vmcore(DumpState *s, Erro=
r **errp)
>      }
>  }
>
> -static int validate_start_block(DumpState *s)
> -{
> -    GuestPhysBlock *block;
> -
> -    if (!dump_has_filter(s)) {
> -        return 0;
> -    }
> -
> -    QTAILQ_FOREACH(block, &s->guest_phys_blocks.head, next) {
> -        /* This block is out of the range */
> -        if (block->target_start >=3D s->filter_area_begin + s->filter_ar=
ea_length ||
> -            block->target_end <=3D s->filter_area_begin) {
> -            continue;
> -        }
> -        return 0;
> -   }
> -
> -    return -1;
> -}
> -
>  static void get_max_mapnr(DumpState *s)
>  {
>      GuestPhysBlock *last_block;
> @@ -1842,12 +1822,6 @@ static void dump_init(DumpState *s, int fd, bool h=
as_format,
>          goto cleanup;
>      }
>
> -    /* Is the filter filtering everything? */
> -    if (validate_start_block(s) =3D=3D -1) {
> -        error_setg(errp, QERR_INVALID_PARAMETER, "begin");
> -        goto cleanup;
> -    }
> -
>      /* get dump info: endian, class and architecture.
>       * If the target architecture is not supported, cpu_get_dump_info() =
will
>       * return -1.
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

