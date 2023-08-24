Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0AB7874D2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCmo-0000Ri-Ur; Thu, 24 Aug 2023 12:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCmV-0000MW-6P
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:02:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCmS-0001Aq-A8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:01:58 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso56196a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892914; x=1693497714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1t4fZORILK3o88mS4JvL2E/7QM3GCNQLXZNmVOowh1U=;
 b=iG6Zjg8PPGWM1xXOw5K+RwPnuhj0910ceUqkDv1u3jy4jWV6VrcVsviC7yt7PZZfaM
 5KDtaYET6Dy9KQhRPpCpVuofaaSwfCiBLOhmdivBz4clvcSI8F48YwXjlVM6LCNH/oDF
 OlvpMXEautQMT5n1OP9LM3rXuPgcsppar/hkXP+qaXP7jnz8mhxbRak9HQQpq+Lo3Tay
 w9JEPGoCV5LkyOmjD62kJr62xb2ERMquJA5qjatkmYBApAB9MMsUhLSjrJ6HSpzztEkw
 Q0tU+YfJHwtOoyUWSEukzoEFmVHBut0vBTXOPjUGmpQAtsPazuxSVOX7XTDH6Ob7t/rn
 LL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892915; x=1693497715;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1t4fZORILK3o88mS4JvL2E/7QM3GCNQLXZNmVOowh1U=;
 b=St8IppLThUG3MR9atm4a7Bcueb4053p3UwAM/6EWS6QytSY2kXMHrIozfGxDDo8Ywm
 Kni7ZXYdt506MSSIb10UQVJNVGtw2ABs4DrrlT2boYROlWWZi/ReX2fz7Tbv1yzzsrRJ
 CJO/Jz0OFbda5eB45qEweIwUkEY4MiTyrUbuxHz7Ot1kMax0pufaLHt+xv0eJFGRRsQn
 /Z8NvO8fbjeS54ICZiH0W3Gd0+uOJjSopgAOJC7dOmgY8vdld8v00SDQLllfgtNebOy3
 ZcltzEPBMSysE0SxoM6fb21V205eabNGNCIcSwhF8XJWi5N878CKBNRJqt4WN0gGeJ4q
 Y84A==
X-Gm-Message-State: AOJu0YwU5vGm+lwp8zikz0TeQrwkUdIoPm1DhKJW9XSLgIzg6NvpTIH9
 qrPQDqnAdf+DhpG07egaQEkYY+7+jtR9jiEOWpsGXg==
X-Google-Smtp-Source: AGHT+IEjtj4GcBlSNKKtM2kN4rQ4NBbwTXMte4m9B8yCKlY+6xdr59J5LVs/E9THy9Y9Hl4tHCUpMm9AMfitKGDSMBY=
X-Received: by 2002:a05:6402:1502:b0:52a:1d9c:83f2 with SMTP id
 f2-20020a056402150200b0052a1d9c83f2mr6427432edw.23.1692892914690; Thu, 24 Aug
 2023 09:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-2-peter.maydell@linaro.org>
 <663d4cd3-50d5-d5db-bd43-efc55fe6bbf0@linaro.org>
In-Reply-To: <663d4cd3-50d5-d5db-bd43-efc55fe6bbf0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 17:01:42 +0100
Message-ID: <CAFEAcA-jswkb6JwPUMuBjvHFPo5YrAZMu5FBt7az_toVsQa=Jg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/net/fsl_etsec/rings.c: Avoid variable length array
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 24 Aug 2023 at 16:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 24/8/23 17:32, Peter Maydell wrote:
> > In fill_rx_bd() we create a variable length array of size
> > etsec->rx_padding. In fact we know that this will never be
> > larger than 64 bytes, because rx_padding is set in rx_init_frame()
> > in a way that ensures it is only that large. Use a fixed sized
> > array and assert that it is big enough.
> >
> > Since padd[] is now potentially rather larger than the actual
> > padding required, adjust the memset() we do on it to match the
> > size that we write with cpu_physical_memory_write(), rather than
> > clearing the entire array.
> >
> > The codebase has very few VLAs, and if we can get rid of them all we
> > can make the compiler error on new additions.  This is a defensive
> > measure against security bugs where an on-stack dynamic allocation
> > isn't correctly size-checked (e.g.  CVE-2021-3527).
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/net/fsl_etsec/rings.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> > index 788463f1b62..2f2f359f7a5 100644
> > --- a/hw/net/fsl_etsec/rings.c
> > +++ b/hw/net/fsl_etsec/rings.c
> > @@ -372,6 +372,12 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr=
)
> >       etsec->regs[TSTAT].value |=3D 1 << (31 - ring_nbr);
> >   }
> >
> > +/*
> > + * rx_init_frame() ensures we never do more padding than this
> > + * (checksum plus minimum data packet size)
> > + */
> > +#define MAX_RX_PADDING 64
> > +
> >   static void fill_rx_bd(eTSEC          *etsec,
> >                          eTSEC_rxtx_bd  *bd,
> >                          const uint8_t **buf,
> > @@ -380,9 +386,11 @@ static void fill_rx_bd(eTSEC          *etsec,
> >       uint16_t to_write;
> >       hwaddr   bufptr =3D bd->bufptr +
> >           ((hwaddr)(etsec->regs[TBDBPH].value & 0xF) << 32);
> > -    uint8_t  padd[etsec->rx_padding];
> > +    uint8_t  padd[MAX_RX_PADDING];
> >       uint8_t  rem;
> >
> > +    assert(etsec->rx_padding <=3D MAX_RX_PADDING);
> > +
> >       RING_DEBUG("eTSEC fill Rx buffer @ 0x%016" HWADDR_PRIx
> >                  " size:%zu(padding + crc:%u) + fcb:%u\n",
> >                  bufptr, *size, etsec->rx_padding, etsec->rx_fcb_size);
> > @@ -426,7 +434,7 @@ static void fill_rx_bd(eTSEC          *etsec,
> >           rem =3D MIN(etsec->regs[MRBLR].value - bd->length, etsec->rx_=
padding);
> >
> >           if (rem > 0) {
> > -            memset(padd, 0x0, sizeof(padd));
> > +            memset(padd, 0x0, rem);
> >               etsec->rx_padding -=3D rem;
> >               *size             -=3D rem;
> >               bd->length        +=3D rem;
>
> Maybe we can add this for clarity:
>
> @@ -468,6 +468,6 @@ static void rx_init_frame(eTSEC *etsec, const
> uint8_t *buf, size_t size)
>        * minimum MTU size bytes long (64)
>        */
> -    if (etsec->rx_buffer_len < 60) {
> -        etsec->rx_padding +=3D 60 - etsec->rx_buffer_len;
> +    if (etsec->rx_padding + etsec->rx_buffer_len < MAX_RX_PADDING) {
> +        etsec->rx_padding =3D MAX_RX_PADDING - etsec->rx_buffer_len;
>       }

I think that's a more confusing way of putting it. What the
code is doing is "if the packet is too short, pad it to
the minimum-packet-length", and the clear way to express
that is "if (packet_len < max) add_more_padding;".

There is potential to use the constants ETH_ZLEN (60) and
ETH_FCS_LEN (4) instead of the hard-coded 60 and 4 currently
in the code, but I felt that was starting to wander a bit
out of scope of just getting rid of the VLA.

thanks
-- PMM

