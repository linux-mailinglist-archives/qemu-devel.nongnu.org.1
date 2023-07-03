Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D0745E3C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 16:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGKHB-00037f-M9; Mon, 03 Jul 2023 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGKGx-0002x6-DI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:11:25 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGKGq-0005Y2-Ds
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 10:11:18 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b69ed7d050so71754511fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688393473; x=1690985473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53CwuybO6fjO+57d6GF7c5gZTdOba/N7S2yaGs8GFWk=;
 b=HVJ+d80JFpBnlF1icsXzfAGqW9E5kf2qq5AQnSijrZDJKSBalQcZl61q6wZrNLxW1J
 1Ddo4XBxmCOSAGaQUHF5POB2HpoPSJav5SdtVnCeBQa6KgOiho7YQ+b64d//4WYEM5h7
 p4Tf4jjtN146E/qd8DKCeIsvFViWaINOgYe2tm4ivp0WpCNaG+WKeg2mPM6MRUAugVGN
 mEBonTzUYs//TOiiEwS9V7sf4NR1JlDkkMymLafdVh96cfWhdqrqABBqv5r4jzFAbpgq
 IkIvHmQVsT79blB7lyOoJchUo0FJ2Srd1zW1tLA66q69uI8FcvRarC/tWq+67m5gjOK+
 nJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688393473; x=1690985473;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53CwuybO6fjO+57d6GF7c5gZTdOba/N7S2yaGs8GFWk=;
 b=CiD3d0ICzjjigWuVLCReunNAuoqsY5+DGcXVQ5IOscJ0lBc7D+V1EXF4jSKLD9v9fb
 bM7AEZpM3xb3UsCqkkA3C13prQdx/XylzLMMxSvA3TGyyPjuq10g6dTs0Gh0EGmT/tGL
 VmPdvrXXg86LS1n1EpqrizB/648f7ur8zfL1ikvdmKhxLkbP0BdYVJkIozEF9n1XQ7yJ
 H1lykTi8q95Wf+F3Nwce/BXMRBY6XGHleC7vXKyIsW6q2+4CWG3+zEZNeVz2KSu7Oabj
 xamCRCd1+pjGYXSb/u3ReLADejTCbIqG/G/LhsFReG1XXRqVAabkQMQ0B3wZ3A1GbN4V
 jw8Q==
X-Gm-Message-State: ABy/qLa+tC0JfnXL2tQpaqeG0TwxS49qt5+LQsRlTjSD8dRwtaOXJNdS
 iPvNSLNNHI3HNtCKvxmB4VbTklYzCbIrD+IFH0/37A==
X-Google-Smtp-Source: APBJJlFApbVuuoxtVAlcO3ZIyrOnIPVHKWh+m83teydq8dlO4W9QNFfjSdNe1VisENBts0owp7cLVu9vIS61bg80CCI=
X-Received: by 2002:a05:6512:2ee:b0:4f3:80a3:b40a with SMTP id
 m14-20020a05651202ee00b004f380a3b40amr6711376lfq.69.1688393473229; Mon, 03
 Jul 2023 07:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-23-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-23-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2023 15:11:02 +0100
Message-ID: <CAFEAcA971KtrQ-0zrc8HcQUKeOvYFOCFcvveh9FKE9t5CThL_g@mail.gmail.com>
Subject: Re: [PULL 22/33] virtio-gpu/win32: allocate shareable 2d
 resources/images
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Tue, 27 Jun 2023 at 14:07, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Allocate pixman bits for scanouts with qemu_win32_map_alloc() so we can
> set a shareable handle on the associated display surface.
>
> Note: when bits are provided to pixman_image_create_bits(), you must also=
 give
> the rowstride (the argument is ignored when bits is NULL)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-Id: <20230606115658.677673-11-marcandre.lureau@redhat.com>

Hi; Coverity notes (CID 1516557) that this introduces
a possible division-by-zero (different from the one
Alex's fuzzer found):

> @@ -1252,15 +1281,23 @@ static int virtio_gpu_load(QEMUFile *f, void *opa=
que, size_t size,
>              g_free(res);
>              return -EINVAL;
>          }
> +
> +        res->hostmem =3D calc_image_hostmem(pformat, res->width, res->he=
ight);
> +#ifdef WIN32
> +        bits =3D qemu_win32_map_alloc(res->hostmem, &res->handle, &error=
_warn);
> +        if (!bits) {
> +            g_free(res);
> +            return -EINVAL;
> +        }
> +#endif
>          res->image =3D pixman_image_create_bits(pformat,
>                                                res->width, res->height,
> -                                              NULL, 0);
> +                                              bits, res->hostmem / res->=
height);

In this function we've just pulled res->height out of the
incoming migration stream, and we haven't done any sanity
checking on it. So it might be 0, in which case this division
will divide by zero and fall over.

thanks
-- PMM

