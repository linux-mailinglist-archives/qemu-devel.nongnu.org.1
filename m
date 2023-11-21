Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E57F294C
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:49:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NNq-0007Nh-FS; Tue, 21 Nov 2023 04:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5NNo-0007NQ-It
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5NNm-0006uM-AU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:49:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700560165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/KltjkrelcEQboa71QBmxPYK95DuZpJn3ckJFb868yE=;
 b=QYeSai/AIPkz1nb7RJUQ/nDG6gTNBjdhh6cFfCXolouyxNf5ntoAUZraLEeuFOilTwSOII
 JyyIVqVQo/xv/H6Brqj3rnV3rH9kc4MGXxt7fnhP3KzATHYG+xLFJ9OHTIzQHN/ZeD40gR
 InkpRs5C/WmMq1RRBhVrrWE1Q9ULYfU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-z23LOg1TPUOvV9lJRfK6yw-1; Tue, 21 Nov 2023 04:49:24 -0500
X-MC-Unique: z23LOg1TPUOvV9lJRfK6yw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-548ef4e9e89so775664a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 01:49:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700560162; x=1701164962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KltjkrelcEQboa71QBmxPYK95DuZpJn3ckJFb868yE=;
 b=vuF1TWDBnDLTlaThXrCzWhwqhMTR9Xrx8l2hKp7hb6rORIs2VFFGlleT0oxfgdZJWs
 7gZ/Luf8Os7wfl1lTTV5CS8hjir5xJjejJRHwbXNLfdSVF7D+okRKhrnNiu1c2PlRNi/
 cL57L8/hHpU7fBYIiWyPcESkV7qvsKYrH8AwRtI8oXIkKKkV+bnRK1qf8sS0iPytOx2F
 fgN8oZ6e/hohrrYGD5sG1z36b6VDhz+e8KNbgdbZPTsN9n+yOKAIe9908J80Hw4dlsn3
 o8d2QXl1Uvw4Ydbh5vIZHYvpt8bStzpCwhr/1WhcANHGP2r5gx8+MY+5xJTe92pGcgPo
 qd3Q==
X-Gm-Message-State: AOJu0YxySBzIdjBQ2cJrh6KWZbyl/1OTqKqvvrWFaK64Nw8zYOGQLaW3
 lBVYmDaPo+wJaaLVQ3bcpnbumG06DKtmKRl6r4milU7dMrZ/gjR98Y5ujglJNG+/X+hqBc/U6CD
 u1ha9P289GM0q3NfHT0p4PVB2odYqDtwbPiwhkCTqbw==
X-Received: by 2002:a05:6402:616:b0:548:ac1f:54ff with SMTP id
 n22-20020a056402061600b00548ac1f54ffmr1316072edv.41.1700560161964; 
 Tue, 21 Nov 2023 01:49:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTotIg+PUqdmRodkpPmVq91GW/xTHzLing0VmWgMmBGqnOC9vJKMwBXhbidfmEO+20pJwvrWgl6/gUTMfUN6Y=
X-Received: by 2002:a05:6402:616:b0:548:ac1f:54ff with SMTP id
 n22-20020a056402061600b00548ac1f54ffmr1316065edv.41.1700560161637; Tue, 21
 Nov 2023 01:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20231121093840.2121195-1-manos.pitsidianakis@linaro.org>
In-Reply-To: <20231121093840.2121195-1-manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Nov 2023 13:49:10 +0400
Message-ID: <CAMxuvaz4AWJFNgYfiBwAAfLoaGkkFYKYnf8MEgGLJJ5DxbnE4w@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/pixman-minimal.h: fix empty allocation
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Manos

On Tue, Nov 21, 2023 at 1:38=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> In the minimal pixman API stub that is used when the real pixman
> dependency is missing a NULL dereference happens when
> virtio-gpu-rutabaga allocates a pixman image with bits =3D NULL and
> rowstride_bytes =3D zero. A buffer of rowstride_bytes * height is
> allocated which is NULL. However, in that scenario pixman calculates a
> new stride value based on given width, height and format size.
>
> This commit adds a helper function that performs the same logic as
> pixman.
>

Thanks a lot for investigating this and providing a solution!
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  include/ui/pixman-minimal.h | 48 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/include/ui/pixman-minimal.h b/include/ui/pixman-minimal.h
> index efcf570c9e..6dd7de1c7e 100644
> --- a/include/ui/pixman-minimal.h
> +++ b/include/ui/pixman-minimal.h
> @@ -113,6 +113,45 @@ typedef struct pixman_color {
>      uint16_t    alpha;
>  } pixman_color_t;
>
> +static inline uint32_t *create_bits(pixman_format_code_t format,
> +                                    int width,
> +                                    int height,
> +                                    int *rowstride_bytes)
> +{
> +    int stride =3D 0;
> +    size_t buf_size =3D 0;
> +    int bpp =3D PIXMAN_FORMAT_BPP(format);
> +
> +    /*
> +     * Calculate the following while checking for overflow truncation:
> +     * stride =3D ((width * bpp + 0x1f) >> 5) * sizeof(uint32_t);
> +     */
> +
> +    if (unlikely(__builtin_mul_overflow(width, bpp, &stride))) {
> +        return NULL;
> +    }
> +
> +    if (unlikely(__builtin_add_overflow(stride, 0x1f, &stride))) {
> +        return NULL;
> +    }
> +
> +    stride >>=3D 5;
> +
> +    stride *=3D sizeof(uint32_t);
> +
> +    if (unlikely(__builtin_mul_overflow((size_t) height,
> +                                        (size_t) stride,
> +                                        &buf_size))) {
> +        return NULL;
> +    }
> +
> +    if (rowstride_bytes) {
> +        *rowstride_bytes =3D stride;
> +    }
> +
> +    return g_malloc0(buf_size);
> +}
> +
>  static inline pixman_image_t *pixman_image_create_bits(pixman_format_cod=
e_t format,
>                                                         int width,
>                                                         int height,
> @@ -123,13 +162,18 @@ static inline pixman_image_t *pixman_image_create_b=
its(pixman_format_code_t form
>
>      i->width =3D width;
>      i->height =3D height;
> -    i->stride =3D rowstride_bytes ?: width * DIV_ROUND_UP(PIXMAN_FORMAT_=
BPP(format), 8);
>      i->format =3D format;
>      if (bits) {
>          i->data =3D bits;
>      } else {
> -        i->free_me =3D i->data =3D g_malloc0(rowstride_bytes * height);
> +        i->free_me =3D i->data =3D
> +            create_bits(format, width, height, &rowstride_bytes);
> +        if (width && height) {
> +            assert(i->data);
> +        }
>      }
> +    i->stride =3D rowstride_bytes ? rowstride_bytes :
> +                            width * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(forma=
t), 8);
>      i->ref_count =3D 1;
>
>      return i;
>
> base-commit: af9264da80073435fd78944bc5a46e695897d7e5
> --
> 2.39.2
>


