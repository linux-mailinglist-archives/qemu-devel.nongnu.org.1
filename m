Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18FF70DD77
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S4K-0002Hb-W3; Tue, 23 May 2023 09:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S4H-0002Gq-Nm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:28:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S4F-00058G-Th
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:28:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30a892c45c4so1985856f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848526; x=1687440526;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWOTDckImL3sk/CWKdrCughxvucW1d/DeVqsiocuR90=;
 b=O81RP/WcxbPhSpCobETkuMgESYzTqNjIahZelEHYBy3A3H8Ow12yqCBj+edXBvxZBt
 I+Fx/aCDELZFU5tk8M4LoYxg4jvFaTWI9oxnZjj+1FONYiqxsRdhAEhPFZgzo44irqOT
 Z82J7izfYX4kbr451JayhDkjL2y6XOF5KlSaxyq7PLfDOfV3HilA8MlalM8ukqyCuE58
 etOS0Qm0LAtwWVQaCmZXGD5QlU1pfS64v/AJk7UKMPbq87ellv9c3p6VAtVK8R7JRLou
 9wk3h6Y5czjA58NgiPnzy9YE9AXxnPJlhBSzJY3jYi3kZSNQCeIdcxSylIQrhk/2ajNI
 l06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848526; x=1687440526;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UWOTDckImL3sk/CWKdrCughxvucW1d/DeVqsiocuR90=;
 b=YR7ELpuW25LVYsLUebxDHg4dnMhh7lJo7HF1BEizeebQut2ouuLpWiaOkiUZRKhmma
 PSnJCRAxEIrBbKvsjM2wo0KHGEF9Yp7sdaCK3acFtKlfUnLOQBsdJ6C3VkViBvsmJ1Mo
 m0zF8rZcGLqFF9/Lo8mlx7FuP0JzYRFf8BgoSjlAhH81cgwIQF2isn0yFai6TKarqdQb
 o229CNmrMt7ugExZLju1D7XJFU0sOwDiBCPc23dtnsusvUP4TY/AEq/evpb+xEQ1EnKI
 DfS8SNDD4dB9lR+zstf0jyu4FyN0K6V6uEal4pwK9+Qjdxc5LI+2Mnw/BbNmUFPEm2Bw
 Ip9w==
X-Gm-Message-State: AC+VfDyag6Zs3QjDcOubc5dB+ZrF9FIn9Jt6WOhEMToHPyeP/0/s2HzI
 vSO4gMTDVOAgNpbrdadYnR6flQ==
X-Google-Smtp-Source: ACHHUZ7lHWXmSc4O0w4UNRhPJePNHc0EIcCDFW2cjjAkSxgyYCsX4l5qnU+tRP45ONG1fd7FJieWNg==
X-Received: by 2002:adf:eccb:0:b0:2fb:7099:6070 with SMTP id
 s11-20020adfeccb000000b002fb70996070mr10219136wro.47.1684848526271; 
 Tue, 23 May 2023 06:28:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a0560001b0f00b003062c609115sm11067393wrz.21.2023.05.23.06.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:28:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 836E21FFBB;
 Tue, 23 May 2023 14:28:45 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-4-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 03/12] util/fifo8: Introduce fifo8_peek_buf()
Date: Tue, 23 May 2023 14:25:34 +0100
In-reply-to: <20230522153144.30610-4-philmd@linaro.org>
Message-ID: <877csz5g8i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> To be able to poke at FIFO content without popping it,

peek/poke are different operations in my head. You peek to read stuff
and poke to change stuff, or at least thats what I did in BASIC back in
the 80s.

Either way I don't think peek and poke are synonyms.

> introduce the fifo8_peek_buf() method by factoring
> common content from fifo8_pop_buf().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qemu/fifo8.h | 26 ++++++++++++++++++++++++++
>  util/fifo8.c         | 22 ++++++++++++++++++----
>  2 files changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index d0d02bc73d..7acf6d1347 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -93,6 +93,32 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>   */
>  const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr=
);
>=20=20
> +/**
> + * fifo8_peek_buf:

fifo8_peek_buf() - read upto max bytes from the fifo


> + * @fifo: FIFO to poke from
> + * @max: maximum number of bytes to pop
> + * @numptr: pointer filled with number of bytes returned (can be NULL)
> + *
> + * Pop a number of elements from the FIFO up to a maximum of max. The bu=
ffer
> + * containing the popped data is returned. This buffer points directly i=
nto
> + * the FIFO backing store and data is invalidated once any of the fifo8_=
* APIs
> + * are called on the FIFO.
> + *
> + * The function may return fewer bytes than requested when the data wraps
> + * around in the ring buffer; in this case only a contiguous part of the=
 data
> + * is returned.
> + *
> + * The number of valid bytes returned is populated in *numptr; will alwa=
ys
> + * return at least 1 byte. max must not be 0 or greater than the number =
of
> + * bytes in the FIFO.
> + *
> + * Clients are responsible for checking the availability of requested da=
ta
> + * using fifo8_num_used().
> + *
> + * Returns: A pointer to peekable data.
> + */
> +const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numpt=
r);
> +
>  /**
>   * fifo8_reset:
>   * @fifo: FIFO to reset
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 032e985440..e12477843e 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -66,7 +66,8 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>      return ret;
>  }
>=20=20
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
> +static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
> +                                        uint32_t *numptr, bool do_pop)
>  {
>      uint8_t *ret;
>      uint32_t num;
> @@ -74,15 +75,28 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t ma=
x, uint32_t *numptr)
>      assert(max > 0 && max <=3D fifo->num);
>      num =3D MIN(fifo->capacity - fifo->head, max);
>      ret =3D &fifo->data[fifo->head];
> -    fifo->head +=3D num;
> -    fifo->head %=3D fifo->capacity;
> -    fifo->num -=3D num;
> +
> +    if (do_pop) {
> +        fifo->head +=3D num;
> +        fifo->head %=3D fifo->capacity;
> +        fifo->num -=3D num;
> +    }
>      if (numptr) {
>          *numptr =3D num;
>      }
>      return ret;
>  }
>=20=20
> +const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numpt=
r)
> +{
> +    return fifo8_peekpop_buf(fifo, max, numptr, false);
> +}
> +
> +const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
> +{
> +    return fifo8_peekpop_buf(fifo, max, numptr, true);
> +}
> +
>  void fifo8_reset(Fifo8 *fifo)
>  {
>      fifo->num =3D 0;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

