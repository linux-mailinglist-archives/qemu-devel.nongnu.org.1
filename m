Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AE770DFDC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TXn-0006QJ-KN; Tue, 23 May 2023 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1TXd-0006Pt-OU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1TXZ-00040b-QX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684854189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CS/fVfI3/YLFXR8Ko5CcgNKZm/CJblyTmySVl3474g=;
 b=fA2cB0QLGCaZ4HdVXSnFxYQfW71AptWp66l2ji027LDY3bodU25ol1IJ8PPnq2Zi0+Ez20
 2vKr1iA9pCRTz06L5/h0lyl1WOIsk4U/vOlaDqtjlJYUxMiHY0GtbBDRiTqkFqdZ1Gd32Y
 4xXW/QzapHwskhWQrqEU/o+kzLYZmLs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-1TPSv_K1Osus-OqPrKtqUA-1; Tue, 23 May 2023 11:03:07 -0400
X-MC-Unique: 1TPSv_K1Osus-OqPrKtqUA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-56183784dd3so86494727b3.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684854187; x=1687446187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CS/fVfI3/YLFXR8Ko5CcgNKZm/CJblyTmySVl3474g=;
 b=ffm1Wzyf8JwwdbA+OD65bhI3j8mRA50ZlfhZ+tfLKsMcWOHUWQCAxuD9cJ0NGIKLYk
 YhLVmF1GDkQY0CTy+v3QsG2QkIJNUaJdpZNxAvkISyPZrSQVpb7asKIOEVU3dC2z/+6I
 zKwkKEL9GeHkqz/PHAOGFXflX9irwKH71051TBJmsaQy8UBGiY061/+aTdTjqtORvZe8
 17nOPMK7VV45RK5JkwItgkiDReYGSZ8Bv4y0PkIfw5tREcuOnXLihRBgIA9yoZbvxFFZ
 5KFx7ip++WzIb9bK8H4VNfoAr9nCbfRQ13axhGjtYBsMCmvtWHr+V5/O2/JF5py8BsbL
 NfOg==
X-Gm-Message-State: AC+VfDwaVuTv7QIOA3Cnk8ihVdh5dl1ZrPMSRVto70DMQaTnqZrm+lk/
 S0U6zQ95LZBE/S4KOENEVDTwDPFUDg3H6PSWLVxLu+Bz6YrVfloFpGvz6jd34jFBCquHc21IQ6R
 j/JSVTxvOE4Jy9er8Zfv/Gs6zbwMYwCU=
X-Received: by 2002:a05:7508:5144:b0:54:e882:1c08 with SMTP id
 c4-20020a057508514400b00054e8821c08mr341055gbb.9.1684854186723; 
 Tue, 23 May 2023 08:03:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hx+q89Qj8llcWsMitSsh0PyChHu+hy5RDfc6cLsitQDt7wCsfHxOUv182K9zGYtOuK5qPamFuCDKD0EY6/hw=
X-Received: by 2002:a05:7508:5144:b0:54:e882:1c08 with SMTP id
 c4-20020a057508514400b00054e8821c08mr341023gbb.9.1684854186306; Tue, 23 May
 2023 08:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <ZGx2bzKuwO6e4E2L@redhat.com>
 <CAA8xKjVkD=K3Xnn4DyE3jVMjX_szqfb5mtkbb0odgN_5jQa93Q@mail.gmail.com>
 <ZGy5YogBNyCyam0L@redhat.com>
In-Reply-To: <ZGy5YogBNyCyam0L@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 23 May 2023 17:02:54 +0200
Message-ID: <CAA8xKjX7T9U_+p8-JXHgQP_Fcjyd4EnvD32vyDBdhn3pvskcHg@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com, 
 jacek.halon@gmail.com
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

On Tue, May 23, 2023 at 3:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, May 23, 2023 at 02:50:09PM +0200, Mauro Matteo Cascella wrote:
> > On Tue, May 23, 2023 at 10:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Mon, May 08, 2023 at 04:18:13PM +0200, Mauro Matteo Cascella wrote=
:
> > > > The cursor_alloc function still accepts a signed integer for both t=
he cursor
> > > > width and height. A specially crafted negative width/height could m=
ake datasize
> > > > wrap around and cause the next allocation to be 0, potentially lead=
ing to a
> > > > heap buffer overflow. Modify QEMUCursor struct and cursor_alloc pro=
totype to
> > > > accept unsigned ints.
> > > >
> > > I concur with Marc-Andre that there is no code path that can
> > > actually trigger an overflow:
> > >
> > >
> > >   hw/display/ati.c:        s->cursor =3D cursor_alloc(64, 64);
> > >   hw/display/vhost-user-gpu.c:            s->current_cursor =3D curso=
r_alloc(64, 64);
> > >   hw/display/virtio-gpu.c:            s->current_cursor =3D cursor_al=
loc(64, 64);
> > >
> > > Not exploitable as fixed size
> > >
> > >   hw/display/qxl-render.c:    c =3D cursor_alloc(cursor->header.width=
, cursor->header.height);
> > >
> > > Cursor header defined as:
> > >
> > >   typedef struct SPICE_ATTR_PACKED QXLCursorHeader {
> > >       uint64_t unique;
> > >       uint16_t type;
> > >       uint16_t width;
> > >       uint16_t height;
> > >       uint16_t hot_spot_x;
> > >       uint16_t hot_spot_y;
> > >   } QXLCursorHeader;
> > >
> > > So no negative values can be passed to cursor_alloc()
>
> > >
> > > > Fixes: CVE-2023-1601
> > > > Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_alloc (=
CVE-2021-4206)")
> > >
> > > Given there is no possible codepath that can overflow, CVE-2023-1601
> > > looks invalid to me. It should be clsoed as not-a-bug and these two
> > > Fixes lines removed.
> >
> > I think you can tweak the original PoC [1] to trigger this bug.
> > Setting width/height to 0x80000000 (versus 0x8000) should do the
> > trick. You should be able to overflow datasize while bypassing the
> > sanity check (width > 512 || height > 512) as width/height are signed
> > prior to this patch. I haven't tested it, though.
>
> The QXLCursorHeader  width/height fields are uint16_t, so 0x80000000
> will get truncated. No matter what value the guest sets, when we
> interpret this in qxl_cursor when calling cursor_alloc, the value
> will be in the range 0-65535, as that's the bounds of uint16_t.
>
> We'll pass this unsigned value to cursor_alloc() which converts from
> uint16_t, to (signed) int. 'int' is larger than uint16_t, so the
> result will still be positive in the range 0-65535, and so the sanity
> check > 512 will fire and protect us.

Oh, you are right! Then yes, feel free to drop the two 'Fixes' lines.
This is more of a hardening bug than a real security issue. I'll
reject the newly assigned CVE.

Thanks,

> I still see no bug, let alone a CVE.
>
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


