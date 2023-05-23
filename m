Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF970DD1C
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ra3-0000Dr-9P; Tue, 23 May 2023 08:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1RZy-0000Bg-Vo
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1RZu-0007OD-C1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684846645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfLe2r/IoZ9ESgL/dA2xPlR8TUfBu2784h/R37gg/hQ=;
 b=jGFRALzywnaTubYHnnVlM5zItOtHqyr3vsZtVeDHxe/lg56ILb92KRRwUDrbZwxU9zCnL9
 ylpETgyCugvTySO77/ypF/AuNS/5UiP+QO7R2ziTXxHhEh92D8jaShZjOcOdiNAMUz4cgA
 xRvhOSNRxolmHyevkQvQPBXacYP9gII=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244--BxKZ88eO6q1l9Z-MsHHug-1; Tue, 23 May 2023 08:57:21 -0400
X-MC-Unique: -BxKZ88eO6q1l9Z-MsHHug-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-437e25229bcso832694137.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846641; x=1687438641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfLe2r/IoZ9ESgL/dA2xPlR8TUfBu2784h/R37gg/hQ=;
 b=KiVvNcXXhTvhplmQdn1V+od4OBGg684fT/OOpoQTDRiiL5zvUYpKnoHgVNAxIhBUfp
 njSuGVR1YQAQYA9WfbRihllPLQRhN4NGDXakGRWuXwcsdhu66iUKOMM748WmC5o0tF0h
 B2x+1qi7X0q0EVISyEiyV7y06LZorNekzCWu/1MRJGDit/6GEpAaDA89tzWMKmZ3g2mm
 7zNB8ue5JjwGr/H32P2G5epyuWirC5TCl0n9IB/e6CthClfUCD1JIMI7Vlg1sPnwoJEa
 FtySuyDd8G5B63Ob15oDBBwKHCbbXhvfbgBFG1QakS0xbM/4fD16TfJdlv5y0QcVQc1z
 c0gw==
X-Gm-Message-State: AC+VfDwzy1q31WCWLLEpJl2B8itZR1dv0BRotqED4VNLIjLzsJkNwgRO
 EdCDP2jnqXW98UHJn82XHne7pYx2MBP9x51q9Hcm9HsrJ6lrxtro8b1ShRa3KmJLwRkZSDRBfB8
 S/YyCzVXT7YnvCuE6oZyyMHgDHTdGyY8=
X-Received: by 2002:a05:6102:3c1:b0:430:3aec:efb8 with SMTP id
 n1-20020a05610203c100b004303aecefb8mr3288808vsq.28.1684846640965; 
 Tue, 23 May 2023 05:57:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OG+vPawr6bwLPjkdR7hgjwy9Q2yamNcEz7iWprs2nX8f4GGE2KltTtroz3xPLbAlG7dco+i82v95BGa5AJXo=
X-Received: by 2002:a05:6102:3c1:b0:430:3aec:efb8 with SMTP id
 n1-20020a05610203c100b004303aecefb8mr3288799vsq.28.1684846640591; Tue, 23 May
 2023 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
 <ZGx0ylB10aLWchuf@redhat.com>
 <8a9c7803-5c1c-3e68-6506-14eae205d11e@linaro.org>
In-Reply-To: <8a9c7803-5c1c-3e68-6506-14eae205d11e@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 23 May 2023 14:57:09 +0200
Message-ID: <CAA8xKjUN+Ru5h65YoTDg0trSUZg=L6iD5HF2AKNv-3wAt+ZtHg@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, kraxel@redhat.com, jacek.halon@gmail.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
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

On Tue, May 23, 2023 at 10:37=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 23/5/23 10:09, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, May 22, 2023 at 08:55:02PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> On 9/5/23 09:13, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi
> >>>
> >>> On Mon, May 8, 2023 at 6:21=E2=80=AFPM Mauro Matteo Cascella
> >>> <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
> >>>
> >>>      The cursor_alloc function still accepts a signed integer for bot=
h
> >>>      the cursor
> >>>      width and height. A specially crafted negative width/height coul=
d
> >>>      make datasize
> >>>      wrap around and cause the next allocation to be 0, potentially
> >>>      leading to a
> >>>      heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
> >>>      prototype to
> >>>      accept unsigned ints.
> >>>
> >>>      Fixes: CVE-2023-1601
> >>>      Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_allo=
c
> >>>      (CVE-2021-4206)")
> >>>      Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
> >>>      <mailto:mcascell@redhat.com>>
> >>>      Reported-by: Jacek Halon <jacek.halon@gmail.com
> >>>      <mailto:jacek.halon@gmail.com>>
> >>>
> >>>
> >>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
> >>> <mailto:marcandre.lureau@redhat.com>>
> >>>
> >>> It looks like this is not exploitable, QXL code uses u16 types, and
> >>
> >> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?
> >
> > cursor_alloc() will reject 0xffff:
> >
> >      if (width > 512 || height > 512) {
> >          return NULL;
> >      }
>
> I hadn't looked at the source file (the 'datasize' assignation
> made me incorrectly think it'd be use before sanitized).
>
> Still I wonder why can't we use a simple 'unsigned' type instead
> of a uint32_t, but I won't insist.

I can send v2 with s/uint32_t/uint16_t/ if you think it's a relevant change=
.

> >>
> >>> VMWare VGA checks for values > 256. Other paths use fixed size.
> >>>
> >>>      ---
> >>>        include/ui/console.h | 4 ++--
> >>>        ui/cursor.c          | 2 +-
> >>>        2 files changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>>      diff --git a/include/ui/console.h b/include/ui/console.h
> >>>      index 2a8fab091f..92a4d90a1b 100644
> >>>      --- a/include/ui/console.h
> >>>      +++ b/include/ui/console.h
> >>>      @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
> >>>
> >>>        /* cursor data format is 32bit RGBA */
> >>>        typedef struct QEMUCursor {
> >>>      -    int                 width, height;
> >>>      +    uint32_t            width, height;
> >>>            int                 hot_x, hot_y;
> >>>            int                 refcount;
> >>>            uint32_t            data[];
> >>>        } QEMUCursor;
> >>>
> >>>      -QEMUCursor *cursor_alloc(int width, int height);
> >>>      +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
> >>>        QEMUCursor *cursor_ref(QEMUCursor *c);
> >>>        void cursor_unref(QEMUCursor *c);
> >>>        QEMUCursor *cursor_builtin_hidden(void);
> >>>      diff --git a/ui/cursor.c b/ui/cursor.c
> >>>      index 6fe67990e2..b5fcb64839 100644
> >>>      --- a/ui/cursor.c
> >>>      +++ b/ui/cursor.c
> >>>      @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
> >>>            return cursor_parse_xpm(cursor_left_ptr_xpm);
> >>>        }
> >>>
> >>>      -QEMUCursor *cursor_alloc(int width, int height)
> >>>      +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
> >>>        {
> >>>            QEMUCursor *c;
> >>
> >> Can't we check width/height > 0 && <=3D SOME_LIMIT_THAT_MAKES_SENSE?
> >>
> >> Maybe a 16K * 16K cursor is future proof and safe enough.
> >>
> >>>            size_t datasize =3D width * height * sizeof(uint32_t);
>
> -------------------------------^
>
> >>>      --     2.40.1
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>> Marc-Andr=C3=A9 Lureau
> >>
> >>
> >
> > With regards,
> > Daniel
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


