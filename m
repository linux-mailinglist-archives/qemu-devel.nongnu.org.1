Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E190E82C40C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:55:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKnm-0005X3-7n; Fri, 12 Jan 2024 11:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKnj-0005WF-5w
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:54:35 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKnh-0005uN-9x
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:54:34 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cd46e7ae8fso75456141fa.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705078471; x=1705683271; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8JjTOfCzqVpwPkPDjZGfbXYAPHDqCLAmmtt4HbnXnc=;
 b=zDPjDlzwaF8DnQFLuopEK296LnArycQhe4G8meJcEXAnrJHvKCRMhUAGCciQ9DHH/p
 7s0RCGAhd+YgVglssmBlCyRWWJU8LsVg2jJ2eMGaTiuCIbfkK9mbi1YAKNqSceiJ+nFm
 q55k0K1PQKlZMepq85HcBn0uC3SGFWvAIOeEWntQjfxcvCu+yoIHKLyi+xodb+ulBmaJ
 OVaAWl47JSJVSNayQDnstpJUALPvU1J2pN5/sJZHeou/jKpE6PYtuhbkChyTKN6iSoVO
 6xPnXH5Qv9hw39uA6FUVRnoEZE12VPVe0pQkV1MOQOFglIYVn3qOmxbt7POFturk6VEh
 E3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705078471; x=1705683271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8JjTOfCzqVpwPkPDjZGfbXYAPHDqCLAmmtt4HbnXnc=;
 b=NFuDgo1CNnqf117mDZRZ9jS0oLx2EHDC8/UFjA+adppPn3nO2/Skkmq3N/CjgNdbpT
 qbehrgzUlZMYgaIej2qCVFIbI3sEjJ43aPgSKOV5ObzTcLHmwb+FDOO9s9uEwlODMxsS
 MSqGoosEezT57k0KfZcDo4LgZrLpwCszTaQHZOMhP72TJr+rcibrfHy+rtjOrnEUHvYo
 fL8AHPMWtRkUKeW/ybUzk7XI5XV358ZBtL23OJaVKSIEF5bwV7lj3fLuZlSXmnYSB3Hc
 Ps6SDS3tw4xzZ2oW+R4HhzB26CmCR0cJOYBHxmxal74AXyyUjkkxJldmwZUVmHP8FvWa
 hVGQ==
X-Gm-Message-State: AOJu0YwIW4TcN96UaKOlWVuS9b+IlZVohOcIsn/Q1H3AITkhTs2wl641
 3kHDspAmXaStX9sjVJCv//KwFg0cO1vDqPDZvU25nSIPbncwbw==
X-Google-Smtp-Source: AGHT+IEtHSpotYXYy19kQqJRFcrplCgOHpTBM7SMsRTJ419dILhRvUQrMmS22FNG3/w9KVypaLNZgsCSPUPq5i6fGoA=
X-Received: by 2002:a2e:5cc6:0:b0:2cd:a70d:fee0 with SMTP id
 q189-20020a2e5cc6000000b002cda70dfee0mr7326ljb.45.1705078470869; Fri, 12 Jan
 2024 08:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
 <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
In-Reply-To: <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 16:54:20 +0000
Message-ID: <CAFEAcA8ZMHwKeEmwakt9BHt5Z_0DihYXtfTP-sOSBnt2dv6hWg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Mon, 8 Jan 2024 at 13:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Gerd,
>
> On 8/1/24 13:53, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Gerd Hoffmann <kraxel@redhat.com>
> >
> > Add an update buffer where all block updates are staged.
> > Flush or discard updates properly, so we should never see
> > half-completed block writes in pflash storage.
> >
> > Drop a bunch of FIXME comments ;)
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++---------=
-
> >   1 file changed, 80 insertions(+), 26 deletions(-)
> >
> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> > index ce63ba43b6..0120462648 100644
> > --- a/hw/block/pflash_cfi01.c
> > +++ b/hw/block/pflash_cfi01.c
> > @@ -80,16 +80,39 @@ struct PFlashCFI01 {
> >       uint16_t ident3;
> >       uint8_t cfi_table[0x52];
> >       uint64_t counter;
> > -    unsigned int writeblock_size;
> > +    uint32_t writeblock_size;
> >       MemoryRegion mem;
> >       char *name;
> >       void *storage;
> >       VMChangeStateEntry *vmstate;
> >       bool old_multiple_chip_handling;
> > +
> > +    /* block update buffer */
> > +    unsigned char *blk_bytes;
>
> I'd rather use a 'void *' type here, but then we need to
> use a (uinptr_t) cast in pflash_data_write().
>
> > +    uint32_t blk_offset;
> >   };
> >
> >   static int pflash_post_load(void *opaque, int version_id);
> >
> > +static bool pflash_blk_write_state_needed(void *opaque)
> > +{
> > +    PFlashCFI01 *pfl =3D opaque;
> > +
> > +    return (pfl->blk_offset !=3D -1);
> > +}
> > +
> > +static const VMStateDescription vmstate_pflash_blk_write =3D {
> > +    .name =3D "pflash_cfi01_blk_write",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D pflash_blk_write_state_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writeb=
lock_size),
>
> I don't get the difference with VMSTATE_VBUFFER_ALLOC_UINT32() which
> sets VMS_ALLOC. In this case pflash_cfi01_realize() does the alloc so
> we don't need VMS_ALLOC?

Yes, that's the idea. A VMS_ALLOC vmstate type means "this
block of memory is dynamically sized at runtime, so when the
migration code is doing inbound migration it needs to
allocate a buffer of the right size first (based on some
state struct field we've already migrated) and then put the
incoming data into it". VMS_VBUFFER means "the size of the buffer
isn't a compile-time constant, so we need to fish it out of
some other state struct field". So:

 VMSTATE_VBUFFER_UINT32: we need to migrate (a pointer to) an array
 of uint32_t; the size of that is in some other struct field,
 but it's a runtime constant and we can assume the memory has
 already been allocated

 VMSTATE_VBUFFER_ALLOC_UINT32: we need to migrate an array
 of uint32_t of variable size dependent on the inbound migration
 data, and so the migration code must allocate it

thanks
-- PMM

