Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10782DBF8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:58:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOQ9-0004Dl-1M; Mon, 15 Jan 2024 09:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOQ6-0004DN-7r
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:58:34 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOQ4-0007Rw-QP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:58:33 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-559533e2503so972667a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705330711; x=1705935511; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hROscwwMm0aNciaHc/wxiXeZ+5kQK+edq78Gjj+wHtU=;
 b=fdQrU04Te6gQjBtw9ODtryhdTjHTFdisIExRw/fp0dH8hJhzIRHOcS16OEEEkAlqwd
 7ZXSKzviZV0j7LjGyhkGe0Bi3TBDdZ2P9R1t7sEkRX1o/6VPCXz8DepsylmjNvRsDvfg
 PK33sY5BVZHHtxdDiDCvWJxB6gl6GbO6zacc6zRncsUh/rCPSaR5kzovoaCN8F3wwWV9
 GRUx6E4zHao2h1CcGeki8d0Vydmybw+Cdscfdn+nR0J2i/v0lokUs94DgLgZ1WF9/E2R
 JYMb1RZRymbGPFK3MDbKD0BFd9ensQhgVonNgRHSCGqHrbiwSxhWMdgMYGMHo4fEaOOR
 hsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705330711; x=1705935511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hROscwwMm0aNciaHc/wxiXeZ+5kQK+edq78Gjj+wHtU=;
 b=L53OLRGUoDsSAMACMZMpDjNZw1q3GlonarK/NYRFtZyOZHCKaFLRzvgB1Ch+8KfxI2
 OFIS8J4GXRMKQ+pZX1EqRaVfjhfbSfsvcWCJgAjrA0H0z5rMBQyWxqM+VXjeBfM0s4RT
 AGKze+NmucLWgpSGir6WXrprSu//wHWa7L9mZhRLTezfNX63/ioNu5KH3EQ3DHC4oshI
 FDUJS5RfpELQNkBAHpOqjx+mqzhidN6Qor+TwpKW5a/cC/JYk/xhL8NdxAKVzMF6mZN2
 Z/9eMMNimBQ6mOqAjwTxt2j14hYAzvof6deBfZuQUIJYS+RoTYHSlTulloaP8stI4c8P
 gTmA==
X-Gm-Message-State: AOJu0YzBFTAC2f9Qk/xzCDINNP0FjZdzje4D9FMLJi9iUw6GNvuq+ivX
 44hiI4yd2magOkamuSw8d8w50ZL4wzR/kAv8E3F7I+Yy0mvoNg==
X-Google-Smtp-Source: AGHT+IGnG/GlQDxgpSjUHlTEI002x/jXIXWAJop36sRPkLS4IxNoKMNXJaOlExZyMyyk6JXtBFZx+9MD2y3Ye65k+QI=
X-Received: by 2002:a05:6402:33cb:b0:551:14f0:f7ae with SMTP id
 a11-20020a05640233cb00b0055114f0f7aemr2650559edc.25.1705330710914; Mon, 15
 Jan 2024 06:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-38-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-38-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:58:19 +0000
Message-ID: <CAFEAcA_UqjoP2e8q+0QenKdzRPd93Sn1hg4H+a_senvJ4r+y5A@mail.gmail.com>
Subject: Re: [PATCH v4 37/45] Add mailbox tests tags. Part 1
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 8 Dec 2023 at 02:38, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.h | 195 +++++++++++++++++++++++++++++++++-
>  1 file changed, 190 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
> index 8acc4bd2ff..04472fe23d 100644
> --- a/tests/qtest/bcm2838-mailbox.h
> +++ b/tests/qtest/bcm2838-mailbox.h
> @@ -147,13 +147,21 @@
>  /* Used to test stubs that don't perform actual work */
>  #define DUMMY_VALUE 0x12345678
>
> -REG32(MBOX_WRITE_REG, 0)
> +REG32(MBOX_WRITE_REG,          0)
>  FIELD(MBOX_WRITE_REG, CHANNEL, 0, 4)
> -FIELD(MBOX_WRITE_REG, DATA, 4, 28)
> +FIELD(MBOX_WRITE_REG, DATA,    4, 28)

I don't strongly care whether you like to line up the
macro argument fields or not, but please pick something
and stick to it, rather than doing it one way to start
and then making whitespace changes in a later patch.

> -REG32(MBOX_SIZE_STAT, 0)
> -FIELD(MBOX_WRITE_REG, SIZE, 0, 30)
> -FIELD(MBOX_WRITE_REG, SUCCESS, 30, 1)
> +REG32(MBOX_SIZE_STAT,          0)
> +FIELD(MBOX_SIZE_STAT, SIZE,    0, 30)
> +FIELD(MBOX_SIZE_STAT, SUCCESS, 30, 1)
> +
> +REG32(SET_DEVICE_POWER_STATE_CMD,        0)
> +FIELD(SET_DEVICE_POWER_STATE_CMD, EN,    0, 1)
> +FIELD(SET_DEVICE_POWER_STATE_CMD, WAIT,  1, 1)
> +
> +REG32(GET_CLOCK_STATE_CMD,        0)
> +FIELD(GET_CLOCK_STATE_CMD, EN,    0, 1)
> +FIELD(GET_CLOCK_STATE_CMD, NPRES, 1, 1)
>
>  typedef struct {

thanks
-- PMM

