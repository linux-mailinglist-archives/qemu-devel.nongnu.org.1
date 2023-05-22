Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D570C623
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:15:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Azn-00037R-Ep; Mon, 22 May 2023 15:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Azk-00036n-Lb
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:15:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Azj-0005iC-1e
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1S/EKGT9dSrCFA5KJiyEr5d5ihrTmanDVUme4G6A7I=;
 b=YRWElhHaXr76o0EtDQ54wKba10jORJPaqzq+QXHUFJmj10UMvp8ABgfX4tfE0+VQTCZBcL
 LviKwTlvRLB0lUgsTPbKPFQ5ytK+lXnRVKeBcnzc92JaWVnSv/yUdFdGhQJ/cI9Ja+0H2X
 dxDf/jr55lTQIwE+yY/5+AbjNjDFiDQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-6sZ3nS5VObWy-OUPCqg45A-1; Mon, 22 May 2023 15:14:57 -0400
X-MC-Unique: 6sZ3nS5VObWy-OUPCqg45A-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-43940848330so322454137.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 12:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684782896; x=1687374896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1S/EKGT9dSrCFA5KJiyEr5d5ihrTmanDVUme4G6A7I=;
 b=ddSUwvTP/LBlNP+pbEpoDGCDAXUvYlT58p0pA7b1jytmI71jH8AOutUfxOTC2mE4kJ
 rMNb+83gtn6Zxpgk0fb2fTnGgSOcZrcm2Z+z5DhtGQ4rDcTr4oE7/ZEA4Nh2lS3fsBkx
 1x/lYT8zdyrrWRbyfiH6KI6WR4u4u4yvdDAnvyxTYIssBBXROBWDCTsbjE4XFos2jNAO
 Flma6HHgZy29nEC0k9Q/re7R6nEyg2xq0C0qTOqpnISiUfq7HordtzFXl1GXLX8ZBSKO
 YxyDWPZ57ApVBFbmNALrjDh1KK2houqpyGG8fWCbbs5Jq58pvOJbD9DKQaqlcvYGz6ls
 mn2A==
X-Gm-Message-State: AC+VfDyuCADTQcUxAG/7ZdilaF3g53xLcOGpSIpWvTEyg1FFmB+4THs4
 n2/Pzxiu5lngA593t4dbMZmmRmULjL37gimF4QXCDXCDrBtx5c6AKq4e98o6dKubv05SdE3LMhg
 E4EGRG0Dh/1sqwZBLKg7Jl7dcKyQOrQs=
X-Received: by 2002:a67:e3c6:0:b0:436:52e1:40dc with SMTP id
 k6-20020a67e3c6000000b0043652e140dcmr3249055vsm.14.1684782896604; 
 Mon, 22 May 2023 12:14:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7z9xQ/LcIhD3CFTUEgzjY3Hf7XM07Q/Cq0ePuZueletDPFv5OcvoOCMOKbWppDMEalyWf00xFDikB+ovxEzgw=
X-Received: by 2002:a67:e3c6:0:b0:436:52e1:40dc with SMTP id
 k6-20020a67e3c6000000b0043652e140dcmr3249051vsm.14.1684782896384; Mon, 22 May
 2023 12:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
In-Reply-To: <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 22 May 2023 21:14:45 +0200
Message-ID: <CAA8xKjXM1P_v_cXuOiOe-FDNKj+ihjRxXJALqH5q-iU9oXbBOA@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, kraxel@redhat.com, jacek.halon@gmail.com, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Mon, May 22, 2023 at 8:55=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 9/5/23 09:13, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, May 8, 2023 at 6:21=E2=80=AFPM Mauro Matteo Cascella
> > <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
> >
> >     The cursor_alloc function still accepts a signed integer for both
> >     the cursor
> >     width and height. A specially crafted negative width/height could
> >     make datasize
> >     wrap around and cause the next allocation to be 0, potentially
> >     leading to a
> >     heap buffer overflow. Modify QEMUCursor struct and cursor_alloc
> >     prototype to
> >     accept unsigned ints.
> >
> >     Fixes: CVE-2023-1601
> >     Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc
> >     (CVE-2021-4206)")
> >     Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
> >     <mailto:mcascell@redhat.com>>
> >     Reported-by: Jacek Halon <jacek.halon@gmail.com
> >     <mailto:jacek.halon@gmail.com>>
> >
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
> > <mailto:marcandre.lureau@redhat.com>>
> >
> > It looks like this is not exploitable, QXL code uses u16 types, and
>
> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?
>
> > VMWare VGA checks for values > 256. Other paths use fixed size.
> >
> >     ---
> >       include/ui/console.h | 4 ++--
> >       ui/cursor.c          | 2 +-
> >       2 files changed, 3 insertions(+), 3 deletions(-)
> >
> >     diff --git a/include/ui/console.h b/include/ui/console.h
> >     index 2a8fab091f..92a4d90a1b 100644
> >     --- a/include/ui/console.h
> >     +++ b/include/ui/console.h
> >     @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
> >
> >       /* cursor data format is 32bit RGBA */
> >       typedef struct QEMUCursor {
> >     -    int                 width, height;
> >     +    uint32_t            width, height;
> >           int                 hot_x, hot_y;
> >           int                 refcount;
> >           uint32_t            data[];
> >       } QEMUCursor;
> >
> >     -QEMUCursor *cursor_alloc(int width, int height);
> >     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
> >       QEMUCursor *cursor_ref(QEMUCursor *c);
> >       void cursor_unref(QEMUCursor *c);
> >       QEMUCursor *cursor_builtin_hidden(void);
> >     diff --git a/ui/cursor.c b/ui/cursor.c
> >     index 6fe67990e2..b5fcb64839 100644
> >     --- a/ui/cursor.c
> >     +++ b/ui/cursor.c
> >     @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
> >           return cursor_parse_xpm(cursor_left_ptr_xpm);
> >       }
> >
> >     -QEMUCursor *cursor_alloc(int width, int height)
> >     +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
> >       {
> >           QEMUCursor *c;
>
> Can't we check width/height > 0 && <=3D SOME_LIMIT_THAT_MAKES_SENSE?

We currently ensure width/height are less than 512 in cursor_alloc.

Checking for positive values is unnecessary if we make width/height
unsigned, isn't it?

> Maybe a 16K * 16K cursor is future proof and safe enough.
>
> >           size_t datasize =3D width * height * sizeof(uint32_t);
> >     --
> >     2.40.1
> >
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


