Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36270C4F4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q19ux-0004qJ-Un; Mon, 22 May 2023 14:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q19uv-0004pX-7v
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q19ut-0000dO-4v
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684778751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sP5Mbo+KfoVAN0aoyuMtemv59lgs/athzOa0Ms7dKM=;
 b=KC81GmTntyQSVdrAwS7KbVA7+EfuuC74CvUWGoqCVgvjLR4cxG/uLQBMiIat9RR4tykohF
 UbF7oFRzpWqt9RnaJwR2ueCK5uCD0VK54SUmda7dQz/phIwt7vHOCNbit1jI4wAmZ48uWU
 mVyudwgY6JVUYk+kXDZOReEpkY6NeUw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-r_vJXZz7ODmkZFK_GWW8zw-1; Mon, 22 May 2023 14:05:50 -0400
X-MC-Unique: r_vJXZz7ODmkZFK_GWW8zw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-78684c215eeso68816241.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 11:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684778750; x=1687370750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sP5Mbo+KfoVAN0aoyuMtemv59lgs/athzOa0Ms7dKM=;
 b=PkUjuH4vLSkPiq7v5ysnhjcgrs8uZs322uJ7MiDJaDNRqGRp39Bq8B3JgBcGSbHRS+
 Z7Wdqbro6H2T5foQzwv+/HiEWhf362lgWxDwLYb9K017CsmFQrWSXyzc4X/x7qlcxCM2
 vwXIgSHrZOGsKgmg0D8/oQ9AiIWvruOab8bAl3Z+Wbk5/TwVscFTpYajAO6702ItZ/Ov
 5gCuE/cBw6IF1FFoiW1WOg7m6/DMqZO5XAoKML3lhVaARmLp755WLBGRe0wmM1hYMwCh
 oufJfEeEHLXD9Nuoa0stwibAHmcYLYT2SrKOuvmS+JAlYUfP1J+X19guyRW9i3Lub6QE
 P0Wg==
X-Gm-Message-State: AC+VfDxFClOZ0+1MayIza9rTZ1hdr4eEvIGBdjrsUQF7hsKjEymdX9BU
 N6WYjJHbGpMmBVmzGwlqDGz2gfl101w6r0BKCxXBbxrWxxemCnT9b9glgwCnfgNM62dFHIuORVS
 ez6kLaa4mVFD8XBgXVUM3g4Ky9GAEgxE+CyjyjF9Bjw==
X-Received: by 2002:a1f:45c3:0:b0:453:2ae:f37c with SMTP id
 s186-20020a1f45c3000000b0045302aef37cmr3960074vka.2.1684778749733; 
 Mon, 22 May 2023 11:05:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gp0RFZxkUk7ttBpg3OWOa1XTsxapMBkVStIr3mRNWM3Vsui4tsq9wRH4FEhUOkttB/RD+DUny2qaIua6KaN8=
X-Received: by 2002:a1f:45c3:0:b0:453:2ae:f37c with SMTP id
 s186-20020a1f45c3000000b0045302aef37cmr3960067vka.2.1684778749510; Mon, 22
 May 2023 11:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
In-Reply-To: <20230508141813.1086562-1-mcascell@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 22 May 2023 20:05:38 +0200
Message-ID: <CAA8xKjX=j8rDCL=UfBF2ES8hhSmxXrpOn_cgyhC5h37i4vh+Dg@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, jacek.halon@gmail.com, 
 Yair M <yairh33@gmail.com>, "Elsayed El-Refa'ei" <e.elrefaei99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Mon, May 8, 2023 at 4:20=E2=80=AFPM Mauro Matteo Cascella
<mcascell@redhat.com> wrote:
>
> The cursor_alloc function still accepts a signed integer for both the cur=
sor
> width and height. A specially crafted negative width/height could make da=
tasize
> wrap around and cause the next allocation to be 0, potentially leading to=
 a
> heap buffer overflow. Modify QEMUCursor struct and cursor_alloc prototype=
 to
> accept unsigned ints.
>
> Fixes: CVE-2023-1601
> Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc (CVE-20=
21-4206)")
> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> Reported-by: Jacek Halon <jacek.halon@gmail.com>

Addendum:
Reported-by: Yair Mizrahi <yairh33@gmail.com>
Reported-by: Elsayed El-Refa'ei <e.elrefaei99@gmail.com>

> ---
>  include/ui/console.h | 4 ++--
>  ui/cursor.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 2a8fab091f..92a4d90a1b 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
>
>  /* cursor data format is 32bit RGBA */
>  typedef struct QEMUCursor {
> -    int                 width, height;
> +    uint32_t            width, height;
>      int                 hot_x, hot_y;
>      int                 refcount;
>      uint32_t            data[];
>  } QEMUCursor;
>
> -QEMUCursor *cursor_alloc(int width, int height);
> +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
>  QEMUCursor *cursor_ref(QEMUCursor *c);
>  void cursor_unref(QEMUCursor *c);
>  QEMUCursor *cursor_builtin_hidden(void);
> diff --git a/ui/cursor.c b/ui/cursor.c
> index 6fe67990e2..b5fcb64839 100644
> --- a/ui/cursor.c
> +++ b/ui/cursor.c
> @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
>      return cursor_parse_xpm(cursor_left_ptr_xpm);
>  }
>
> -QEMUCursor *cursor_alloc(int width, int height)
> +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
>  {
>      QEMUCursor *c;
>      size_t datasize =3D width * height * sizeof(uint32_t);
> --
> 2.40.1
>


--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


