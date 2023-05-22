Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A270C87B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1BMS-0001Gq-Mp; Mon, 22 May 2023 15:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1BMP-0001G5-Dg; Mon, 22 May 2023 15:38:25 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1BMN-00036s-RT; Mon, 22 May 2023 15:38:25 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2af1e290921so53284681fa.3; 
 Mon, 22 May 2023 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684784301; x=1687376301;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oRMYDtMICSn5nsPyWp0UzpotVYQAEshwHkg9F8gB2eA=;
 b=YheHZEcWW9S1Z9Saj1LQ0e/3FE8CzSTA4nhjvODkq2YivyqF1OTxKOkgwk27ZVLbZR
 rrl2JoORmNTSt4+sczh/eIf4MGkb49lloDwkIwnLCxQQLmmO3dhVLfhWD9BsIbPgVsiQ
 P7XCX4V1eWDiGP7S3lKj3WOETSFeHZXKKlR4k6/a6dg96eM5tt8rNIQdNJ+Q7X0Xzv13
 JhHbn9c7Jeq1kqvhMN4OqnfPCxf387gn4yuLnTDivKhyTSp6sgjHoDnpEPvFn8ny/pZe
 VwzCuzMVk5yz1FDLeGPp2Ec1Dqu51rGfX/xhnlQ9vrWKim0yn8jIXn4eOY/TpWPJp/Qm
 0xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684784301; x=1687376301;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRMYDtMICSn5nsPyWp0UzpotVYQAEshwHkg9F8gB2eA=;
 b=bmSc6WgX/7wTD2+jRlcPYOVy5DLdg24/WY4CbXDJjZuGh+dLqhSt1Tpqt/W8PfY6PF
 HvTfo+f2paeqOuvsr3wPksXessn5uC+UaaATscoDCrk9b3eaQZzUQZ4xcpIpK37jEES6
 LAI7wrtx6X3Wzh060qhcUctW46+6DgwDU87cowdz8KWWz+wGwqapHEXewMvIwX4lyLC/
 d95VOb74JhQaMqkNk1c3AA9NP6IIReBMwNlHBSB5VrhoZ+CVoQMg/IQrZ0wXl6ZfG69Z
 DbfgakbBxN8jmel8azpbflk2WdGjWEIlji/brsvuRrK/WC+vCHvn66IDF5aPK6smVkCI
 ZEaw==
X-Gm-Message-State: AC+VfDyq6D3oqcc7lZAE08UQU3GqtyszVWvaMGwBIO+yJ58cr+jVLJfm
 o8DkZhfaJAuJxrki/AKNdAE=
X-Google-Smtp-Source: ACHHUZ7W1XQ85Yp6SFo9ZUEnWH1fffn4Q42jPnsGKo3cTAfdPatJcR7vnkKWhH5UvuxKmkAPqZ4dpg==
X-Received: by 2002:a2e:9588:0:b0:2ad:aa42:8c0b with SMTP id
 w8-20020a2e9588000000b002adaa428c0bmr4355501ljh.35.1684784301293; 
 Mon, 22 May 2023 12:38:21 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a2e9813000000b002a7746800d0sm1260991ljj.130.2023.05.22.12.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 12:38:20 -0700 (PDT)
Date: Mon, 22 May 2023 21:38:19 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 03/12] util/fifo8: Introduce fifo8_peek_buf()
Message-ID: <20230522193818.GF6984@fralle-msi>
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522153144.30610-4-philmd@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 May 22] Mon 17:31:35, Philippe Mathieu-Daudé wrote:
> To be able to poke at FIFO content without popping it,
> introduce the fifo8_peek_buf() method by factoring
> common content from fifo8_pop_buf().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
>  const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
>  
> +/**
> + * fifo8_peek_buf:
> + * @fifo: FIFO to poke from
> + * @max: maximum number of bytes to pop
> + * @numptr: pointer filled with number of bytes returned (can be NULL)
> + *
> + * Pop a number of elements from the FIFO up to a maximum of max. The buffer

s/Pop/Peek into/

> + * containing the popped data is returned. This buffer points directly into

s/popped data/data peeked into/

If above sounds good:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>


> + * the FIFO backing store and data is invalidated once any of the fifo8_* APIs
> + * are called on the FIFO.

(Above sounds as if it happens automatically to me but I'm not english native,
a suggestion could be to put something as below "clients are responsible for
tracking this")

> + *
> + * The function may return fewer bytes than requested when the data wraps
> + * around in the ring buffer; in this case only a contiguous part of the data
> + * is returned.
> + *
> + * The number of valid bytes returned is populated in *numptr; will always
> + * return at least 1 byte. max must not be 0 or greater than the number of
> + * bytes in the FIFO.
> + *
> + * Clients are responsible for checking the availability of requested data
> + * using fifo8_num_used().
> + *
> + * Returns: A pointer to peekable data.
> + */
> +const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
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
>  
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
> +static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
> +                                        uint32_t *numptr, bool do_pop)
>  {
>      uint8_t *ret;
>      uint32_t num;
> @@ -74,15 +75,28 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
>      assert(max > 0 && max <= fifo->num);
>      num = MIN(fifo->capacity - fifo->head, max);
>      ret = &fifo->data[fifo->head];
> -    fifo->head += num;
> -    fifo->head %= fifo->capacity;
> -    fifo->num -= num;
> +
> +    if (do_pop) {
> +        fifo->head += num;
> +        fifo->head %= fifo->capacity;
> +        fifo->num -= num;
> +    }
>      if (numptr) {
>          *numptr = num;
>      }
>      return ret;
>  }
>  
> +const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
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
>      fifo->num = 0;
> -- 
> 2.38.1
> 
> 

