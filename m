Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9470C5EC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1AyE-0001uE-9T; Mon, 22 May 2023 15:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1Ay4-0001iZ-D5; Mon, 22 May 2023 15:13:19 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1Ay2-0005WZ-J1; Mon, 22 May 2023 15:13:15 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so1263379e87.2; 
 Mon, 22 May 2023 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684782792; x=1687374792;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKgUiUzzPXQ1tuCogr7I/mtRpKX/s6KhmaB88kM8TA0=;
 b=Gp6sLXbqRbYhOk5okVAboNBk8S4IstWTKwehNnal3rfs77XXrIRlCzvNBnKu8iKOXv
 eSIS5P/wWJMw8q1gMt6azs6NIOnL0+Oce0ufmZ3+ukI82diHGnAUnzFWiDhHPkmZHvc0
 gR6aXyQjnQgCGv6eFSrkfMwxePbOa7daCIDg5nM17GYm+Wro/0XtWNtmo+U4xJ2rf41W
 eDkl30QxDeaKWVwgSTqAndmtFewfkyy/EtBm1dCaGCu9Pvz6axcmuU4WKMiu0Q+G4NZM
 Eq4sqOVSptvqqkLqFfDIzoRT2mlaJbH9hLmYkdOull/IUGULnWhbpBoblxrHCXF0OY+T
 ipoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684782792; x=1687374792;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKgUiUzzPXQ1tuCogr7I/mtRpKX/s6KhmaB88kM8TA0=;
 b=MFVJNNjxc7sMYVaYR1eiZOfe3RtAtNurZ0cVsXfEZqzOrKzyDGOlF5EDk0XqOJX5cy
 nknfL0S68KN1nfip3nu8WbuU7AMaIbTh8uhF/QAMHp9mlESrBFtnmYdh7HI6bxXDt5UP
 ZwXt1xVcb25SkLDjk8emWmc+VjSV43GIFHrOe/EwfEhjbHLlAAvTWyDD3vkzDZjhz80Z
 1kT+UYwcckQ9hu76+9SnB3hL4rase5uOhLkJz51OGuhYfbaZUIfgNqfw4+/WXYIxqZqq
 mRPQSmJ9vZ8kO0zkw7D0EMFEs2Fj3EawKsey1xMteIDQRvrlspfFr1bIJQgu5AJRPm7x
 2WHA==
X-Gm-Message-State: AC+VfDymaizMWtrWsviGmtFSTbW6ZrTnieuueFtUgmtXc4YimWn9kmJl
 l6kPvsaC//ZzQh3/O7AKd+Q=
X-Google-Smtp-Source: ACHHUZ6B+fmB57n+i0JWWVsNPGjA1igCoK6K6k1CVkc9dGbLuL7rujp5Acql5fKqjsPrOyuSn2Ou/w==
X-Received: by 2002:ac2:5991:0:b0:4f3:a0f0:7c4a with SMTP id
 w17-20020ac25991000000b004f3a0f07c4amr3781811lfn.40.1684782791802; 
 Mon, 22 May 2023 12:13:11 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a19f502000000b004eff530efe7sm1078916lfb.93.2023.05.22.12.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 12:13:11 -0700 (PDT)
Date: Mon, 22 May 2023 21:13:10 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 02/12] util/fifo8: Allow fifo8_pop_buf() to not populate
 popped length
Message-ID: <20230522191309.GE6984@fralle-msi>
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522153144.30610-3-philmd@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

On [2023 May 22] Mon 17:31:34, Philippe Mathieu-Daudé wrote:
> There might be cases where we know the number of bytes we can
> pop from the FIFO, or we simply don't care how many bytes is
> returned. Allow fifo8_pop_buf() to take a NULL numptr.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>


> ---
>  include/qemu/fifo8.h | 10 +++++-----
>  util/fifo8.c         | 12 ++++++++----
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index 16be02f361..d0d02bc73d 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -71,7 +71,7 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>   * fifo8_pop_buf:
>   * @fifo: FIFO to pop from
>   * @max: maximum number of bytes to pop
> - * @num: actual number of returned bytes
> + * @numptr: pointer filled with number of bytes returned (can be NULL)
>   *
>   * Pop a number of elements from the FIFO up to a maximum of max. The buffer
>   * containing the popped data is returned. This buffer points directly into
> @@ -82,16 +82,16 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>   * around in the ring buffer; in this case only a contiguous part of the data
>   * is returned.
>   *
> - * The number of valid bytes returned is populated in *num; will always return
> - * at least 1 byte. max must not be 0 or greater than the number of bytes in
> - * the FIFO.
> + * The number of valid bytes returned is populated in *numptr; will always
> + * return at least 1 byte. max must not be 0 or greater than the number of
> + * bytes in the FIFO.
>   *
>   * Clients are responsible for checking the availability of requested data
>   * using fifo8_num_used().
>   *
>   * Returns: A pointer to popped data.
>   */
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num);
> +const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
>  
>  /**
>   * fifo8_reset:
> diff --git a/util/fifo8.c b/util/fifo8.c
> index d4d1c135e0..032e985440 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -66,16 +66,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>      return ret;
>  }
>  
> -const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *num)
> +const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
>  {
>      uint8_t *ret;
> +    uint32_t num;
>  
>      assert(max > 0 && max <= fifo->num);
> -    *num = MIN(fifo->capacity - fifo->head, max);
> +    num = MIN(fifo->capacity - fifo->head, max);
>      ret = &fifo->data[fifo->head];
> -    fifo->head += *num;
> +    fifo->head += num;
>      fifo->head %= fifo->capacity;
> -    fifo->num -= *num;
> +    fifo->num -= num;
> +    if (numptr) {
> +        *numptr = num;
> +    }
>      return ret;
>  }
>  
> -- 
> 2.38.1
> 
> 

