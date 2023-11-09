Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F1A7E6CD5
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:04:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16Yi-0000uJ-7r; Thu, 09 Nov 2023 10:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16Ya-0000nW-Vh
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:02:59 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16YZ-00056G-7m
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:02:56 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso1490971a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542172; x=1700146972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bfe1b5VI3RuLi7hjr20jz94LZ8lN18LxXH0a6geiBck=;
 b=lnMB7IFvFS57g9Ikwwc6dBRFMnLFB0kkOM6TjH5hOEKLVs89iwms+lMYkc9Nd63aFt
 xq6YN/wcrPmRJ0ayNFuMPaVIYzZFNVmF2VSh5t8DmLfu44+C+WOcHodxKr/qGu8QKB//
 +Lk2tCsq1FwIhWjZHWsq7GeyiIIEnfQt/petrvtqezS2z7cQV8wfV0urKoWkNy3zlVA6
 uboM5OUZ7qbZGun5vdnxhuYorIwqrpLOwfftcz+nAUJvzX4AcsowG6dBDP/x4FoqHaf8
 i/Tw196GWOf2+TSRrlkz6Ed6Ck6WGSjXMHmpfU3qsrnWhrV881BXour1kdTCBlrXNGCT
 pFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542172; x=1700146972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bfe1b5VI3RuLi7hjr20jz94LZ8lN18LxXH0a6geiBck=;
 b=YKnlFGJtbDJYhU6IX5VDma0yQBC6psPcHRP5AU9GLlwZ6WHydg5eO8R/AvObhpdqs4
 ohwovgZQYan4mdIZ8H0g2PSsrwZcPULkTK/lK2wT6TsbyaVxOLpzQGwyhlZaX6qrkBk4
 FsbYGkSSPJqKv+tXO6MfkOftetBcyyKbg6CM2ZJSH7+oLFVfJwpw+h24eXDDTwQJSiEs
 8AZmcI8LtNF4hfmxyAHUG/+rxLstIrlPfEQlJWt81uBa82t5GAaM2vOjvf2BsTFJOV8t
 2BEkUToIvjKSFsprIQQtCiivoLG8d82Eq5dIdU3OpOhUbTATcZ02vLNTT9BmuS8bucgT
 dKfA==
X-Gm-Message-State: AOJu0YxHdy0+GI/WRTi9p97t/kwpI38PdZq7nT0eIHBOmrH8sFYTbzIF
 P9VEa5S4XcUO3p3wdoJZBnm10ppE86S4D6EVl3R9TQ==
X-Google-Smtp-Source: AGHT+IGCv7/fGGZ8ArqROc/HmPdlxm7zMj2nYU4z8wNqrXWjPoozi7MvODK+fojeV9msiUs04F1zjOGKihCgm0ICFF8=
X-Received: by 2002:a50:8714:0:b0:53d:f072:7b0a with SMTP id
 i20-20020a508714000000b0053df0727b0amr4642782edb.39.1699542172221; Thu, 09
 Nov 2023 07:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20231109080536.1005500-1-clg@kaod.org>
In-Reply-To: <20231109080536.1005500-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 15:02:41 +0000
Message-ID: <CAFEAcA_vs==UgZGkuW96wY=tdHXxk8cu1O7HRGKAoAj=Ltyv1A@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: Fix potential overflow in I2C model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Nov 2023 at 08:06, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
> because the expression is evaluated using 32-bit arithmetic and then
> used in a context expecting a uint64_t.
>
> Fixes: Coverity CID 1523918
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index f75e59e70977..ab73c59f7704 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -437,7 +437,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwad=
dr addr,
>      case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
>          val =3D 0;
>          for (i =3D 0; i < i2c->num_busses; i++) {
> -            val |=3D i2c_bus_busy(i2c->busses[i]) << i;
> +            val |=3D (uint64_t) i2c_bus_busy(i2c->busses[i]) << i;
>          }
>          break;

Should the device's realize function also impose a max
limit on the num-busses property? There doesn't seem to be
anything preventing a caller from setting it to a big
number like 128, which would then be UB here.

Style nit: casts shouldn't have a space after them before
the thing they're casting.

thanks
-- PMM

