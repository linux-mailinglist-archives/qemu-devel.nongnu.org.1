Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 887087D1C8F
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 12:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu9QD-0005Jz-DQ; Sat, 21 Oct 2023 06:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qu9Q9-0005GA-Kf; Sat, 21 Oct 2023 06:41:29 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qu9Q7-0006Ww-CG; Sat, 21 Oct 2023 06:41:28 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d9beb865a40so1629969276.1; 
 Sat, 21 Oct 2023 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697884884; x=1698489684; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0uh7CZSfuO0NQUKKWFNoyeP1THkGbAk1ccRunKqJws=;
 b=Wrv6m8jJTGmGheFCn5N5EfN108T9E7y/Bj2s6NPKzjuIBEBIZeFcrSTKkbNItIlwGb
 npnQ/Ukc1OyCrWsnhX7CTbqJu9CU29WophRQxLGJmhFsxwjM8w1YH/mL9+qx1Q8Nhg4H
 phQaPbaTiDjziVr35t6PoP9F8dfbQxmyB35zdfU7CKsaVWVDJjv2OBvV1IrGFtwfIvgq
 O++tI+8PVeBf7nzZOPWdbm/8ULqxpCGXcXCX68puiICfqnL3wiLsWM/KyiREhWDA1mGD
 3Llr6E5/Gn912e0PbmY6JCT7D15Cen8GUbMkIllKZKg3ygzXlJsqFmZHnj0gUOEzfeY1
 phNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697884884; x=1698489684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0uh7CZSfuO0NQUKKWFNoyeP1THkGbAk1ccRunKqJws=;
 b=GKEcCt6RYXzf6TpXi20H2IllmDLvjE7kcWmNezwyMSbhDq31J4+k2bP1UO03gW42kf
 qQwbUgm8XilyoKPuSVVVmUcMx4tCrIBxbrpZQCp+nDGhilqu43xaX7stPtehmS25+b4M
 OPy1TMmLtOKhIbHa4LthtIN3+GuOKq2bqvTMliKohCh7ngReKaSqE3TZ7gLCxGGsVc1Q
 lay2q07E8GZiULgAX/wX2LrIrUv9luBIxH3mSTzIjQGIt4oEmqUBKv74iBm8CKqI7eZH
 4A584UzAr3qCNJp96p8ZggIpYpNhX2OhwOto2mOJ7hHJzJEUeURizRn2QrvZLXj9RRih
 oJyw==
X-Gm-Message-State: AOJu0YzT6UjdgOjh3ox8NBBvNyvMylvOtW0SDJKWrPBzRtMjDUSdmRLL
 XISUBhG11f8RJhk29JA7A2vp6ghQchnCRVaDSyt0f/B5vvzqO+HM
X-Google-Smtp-Source: AGHT+IGN73Uk/oczE2Qg2fWh2lX64mQobBJ+p9oolI46Zm50OLZ3uNki/uJwhF4mdcLbCCofF6GbmicFK3MnkGl7Nq8=
X-Received: by 2002:a05:6902:188f:b0:d9a:bddd:f714 with SMTP id
 cj15-20020a056902188f00b00d9abdddf714mr5618272ybb.9.1697884884657; Sat, 21
 Oct 2023 03:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-2-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231019125854.390385-2-alexander.ivanov@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 21 Oct 2023 13:40:48 +0300
Message-ID: <CAL77WPC79j7LUJNTYpf5uyH3JFViDKsMMRktzfgtoZKHUVhEWA@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yb1-xb2d.google.com
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

On Thu, Oct 19, 2023 at 4:06=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
> After used bitmap freeng s->used_bmap points to the freed memory. If we t=
ry
> to free used bitmap one more time it leads to double free error.
>
> Set s->used_bmap to NULL to exclude double free error.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  block/parallels.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 6b46623241..ba1fdde259 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -244,6 +244,7 @@ static void parallels_free_used_bitmap(BlockDriverSta=
te *bs)
>  {
>      BDRVParallelsState *s =3D bs->opaque;
>      s->used_bmap_size =3D 0;
> +    s->used_bmap =3D NULL;
>      g_free(s->used_bmap);
>  }

Shouldn't it be added after g_free() call?

Regards,
Mike.

