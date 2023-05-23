Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B727470DCFC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RTK-0007bq-Vg; Tue, 23 May 2023 08:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1RTH-0007Zx-FJ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1RT9-0005Py-MH
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684846223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XK5Dlg+5QORJTTzD4xzB4uyxnmsfZHsr3HjcX8qYXrE=;
 b=ffxIrVGY11n1E1nOHfUGYj1ZS8wF/QgO93pb1a3wW0+CmG0RhyfnhARYIF7HfWE50Jn/9r
 NzGivvJr4kWlCb7smDGq4qRydtcNc7TOeGM5cWVrDeRjzS3/7oK7ZccYMmNkHwlN6FyAGP
 ad/aYBHRknjhApfY1zY4dJ68iXIm3kE=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-RIIty5wNMuaoQqJqs6Xn7g-1; Tue, 23 May 2023 08:50:21 -0400
X-MC-Unique: RIIty5wNMuaoQqJqs6Xn7g-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4575661883aso2151748e0c.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846221; x=1687438221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XK5Dlg+5QORJTTzD4xzB4uyxnmsfZHsr3HjcX8qYXrE=;
 b=i9udegeTvsLhFgAy2BsIk49hlpj+pfgZfTi2Zbjy04gePQVcj666eFnaiMkcd6rOGA
 akMowbAjZ5nLjixEfeFMFSgAq0Xrq7nS60nm+R8f6aWGly2ZZCEVAG+dWobBxxbLCIat
 I9QPuRr1LUWN7GfZpfyz3W95zZjcDkheF3hTwzw0yr6BpxfH1MzvnlO9I+3IJ7PpZbHr
 6PXHTxVE/nH8+1uBQDEsCM92/46iwzb4JJlvSl82XTvttcL4sSBPRZ2zgordT5XDfChH
 YjZqffHn+uPR5hc9HcXLmZ58DdVYJdiz1NnWT/b1ARG4CR2ecwVWJkpx/fwcmI09/0ag
 JeCg==
X-Gm-Message-State: AC+VfDzOLEPmdiS2mh/qAA1fzC+j0heTFwlEE1isW+v0+6UYOotY/UIa
 mE3c+1x7UEwrXBLy9u5AsQA0EqdVmt8VhZXuFrcqZslCiuMDoanMyzPhUP2J5deZRdo7667AryZ
 b2iEFUXVP5knGINyzEKk2MYkfxL6TCyY=
X-Received: by 2002:a1f:3d4e:0:b0:447:fafb:c15 with SMTP id
 k75-20020a1f3d4e000000b00447fafb0c15mr4391988vka.1.1684846220971; 
 Tue, 23 May 2023 05:50:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YLYLAg2ScfnDcG3fBHv4hVeuYPXgt1AWHbQJs+Owqt0Imwe9tPsIz1ygiz0Dl6C014n3umvb8V8eAxi8oRyo=
X-Received: by 2002:a1f:3d4e:0:b0:447:fafb:c15 with SMTP id
 k75-20020a1f3d4e000000b00447fafb0c15mr4391980vka.1.1684846220648; Tue, 23 May
 2023 05:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <ZGx2bzKuwO6e4E2L@redhat.com>
In-Reply-To: <ZGx2bzKuwO6e4E2L@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 23 May 2023 14:50:09 +0200
Message-ID: <CAA8xKjVkD=K3Xnn4DyE3jVMjX_szqfb5mtkbb0odgN_5jQa93Q@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 jacek.halon@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 23, 2023 at 10:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Mon, May 08, 2023 at 04:18:13PM +0200, Mauro Matteo Cascella wrote:
> > The cursor_alloc function still accepts a signed integer for both the c=
ursor
> > width and height. A specially crafted negative width/height could make =
datasize
> > wrap around and cause the next allocation to be 0, potentially leading =
to a
> > heap buffer overflow. Modify QEMUCursor struct and cursor_alloc prototy=
pe to
> > accept unsigned ints.
> >
> I concur with Marc-Andre that there is no code path that can
> actually trigger an overflow:
>
>
>   hw/display/ati.c:        s->cursor =3D cursor_alloc(64, 64);
>   hw/display/vhost-user-gpu.c:            s->current_cursor =3D cursor_al=
loc(64, 64);
>   hw/display/virtio-gpu.c:            s->current_cursor =3D cursor_alloc(=
64, 64);
>
> Not exploitable as fixed size
>
>   hw/display/qxl-render.c:    c =3D cursor_alloc(cursor->header.width, cu=
rsor->header.height);
>
> Cursor header defined as:
>
>   typedef struct SPICE_ATTR_PACKED QXLCursorHeader {
>       uint64_t unique;
>       uint16_t type;
>       uint16_t width;
>       uint16_t height;
>       uint16_t hot_spot_x;
>       uint16_t hot_spot_y;
>   } QXLCursorHeader;
>
> So no negative values can be passed to cursor_alloc()
>
>
>   hw/display/vmware_vga.c:    qc =3D cursor_alloc(c->width, c->height);
>
> Where 'c' is defined as:
>
>   struct vmsvga_cursor_definition_s {
>       uint32_t width;
>       uint32_t height;
>       int id;
>       uint32_t bpp;
>       int hot_x;
>       int hot_y;
>       uint32_t mask[1024];
>       uint32_t image[4096];
>   };
>
> and is also already bounds checked:
>
>             if (cursor.width > 256
>                 || cursor.height > 256
>                 || cursor.bpp > 32
>                 || SVGA_BITMAP_SIZE(x, y) > ARRAY_SIZE(cursor.mask)
>                 || SVGA_PIXMAP_SIZE(x, y, cursor.bpp)
>                     > ARRAY_SIZE(cursor.image)) {
>                     goto badcmd;
>             }
>
> > Fixes: CVE-2023-1601
> > Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc (CVE-=
2021-4206)")
>
> Given there is no possible codepath that can overflow, CVE-2023-1601
> looks invalid to me. It should be clsoed as not-a-bug and these two
> Fixes lines removed.

I think you can tweak the original PoC [1] to trigger this bug.
Setting width/height to 0x80000000 (versus 0x8000) should do the
trick. You should be able to overflow datasize while bypassing the
sanity check (width > 512 || height > 512) as width/height are signed
prior to this patch. I haven't tested it, though.

[1] https://github.com/star-sg/CVE/blob/master/CVE-2021-4206/poc.c
[2] https://starlabs.sg/advisories/21/21-4206/


> > Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
> > Reported-by: Jacek Halon <jacek.halon@gmail.com>
> > ---
> >  include/ui/console.h | 4 ++--
> >  ui/cursor.c          | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Even though it isn't fixing a bug, the change itself still makes
> sense, because there's no reason a negative width/height is ever
> appropriate. This protects us against accidentally introducing
> future bugs, so with the two CVE Fixes lines removed:
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 2a8fab091f..92a4d90a1b 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -144,13 +144,13 @@ typedef struct QemuUIInfo {
> >
> >  /* cursor data format is 32bit RGBA */
> >  typedef struct QEMUCursor {
> > -    int                 width, height;
> > +    uint32_t            width, height;
> >      int                 hot_x, hot_y;
> >      int                 refcount;
> >      uint32_t            data[];
> >  } QEMUCursor;
> >
> > -QEMUCursor *cursor_alloc(int width, int height);
> > +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height);
> >  QEMUCursor *cursor_ref(QEMUCursor *c);
> >  void cursor_unref(QEMUCursor *c);
> >  QEMUCursor *cursor_builtin_hidden(void);
> > diff --git a/ui/cursor.c b/ui/cursor.c
> > index 6fe67990e2..b5fcb64839 100644
> > --- a/ui/cursor.c
> > +++ b/ui/cursor.c
> > @@ -90,7 +90,7 @@ QEMUCursor *cursor_builtin_left_ptr(void)
> >      return cursor_parse_xpm(cursor_left_ptr_xpm);
> >  }
> >
> > -QEMUCursor *cursor_alloc(int width, int height)
> > +QEMUCursor *cursor_alloc(uint32_t width, uint32_t height)
> >  {
> >      QEMUCursor *c;
> >      size_t datasize =3D width * height * sizeof(uint32_t);
> > --
> > 2.40.1
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


