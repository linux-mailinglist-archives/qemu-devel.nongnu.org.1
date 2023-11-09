Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B77E6E45
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:08:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17ZT-0004VI-PL; Thu, 09 Nov 2023 11:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17ZK-0004Qv-QV
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:07:46 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17ZB-0002BJ-3A
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:07:46 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so1708348a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699546049; x=1700150849; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQLXekvzoEH+wFhPe6MCrvwFo4reyLMeIRiwgTqugdU=;
 b=FndVG1nZ43gBJUY/Xw3QidcxiTL5jNSthwhwiKg7CzH960cTNiFeP1hB2waQQQSGbd
 ye2rNfqejZrrV7GOv6s23gZuJVgefnsgARkoLUB4BPg6xZlD1lIZiBaPWbovWEOSYfJm
 LajQazOw/CK8OqJ5TkGJZgBnhSNvswuS45F5jg/TjlW68BojnrwejyIjMXCEjl+m0RaM
 eDjAIJZjAnO2WFXpn7glgYnXqtBoSrtejs4c+pMgK70HYEEWRxVZ3IuylgfUdWnXBkJd
 K4Ge4sz6/1gf7CaH5WDV+/LDM+cpxJ+vpGKfXwhYd0F9wtWYIKBXw1lUjn/4cU9N6DRS
 72tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699546049; x=1700150849;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQLXekvzoEH+wFhPe6MCrvwFo4reyLMeIRiwgTqugdU=;
 b=fLokNx01V7wR3EMEMX6Bbcn3pRCYbdCvUNGBi5veRVidcCuMEL2bbJNVZYAsk5kuZN
 3COu8usYCo7rm51WPCFJrsWpuhrBgSrJJ9vST7crIwC6KLVSfMBzyoyt1yjYxn3iZpIK
 kRcZHftLObQr99Wj1PuxPXfcxpkZV8bYG+jrb1GU4DiPDvDleTlt3pwlsjsoAWHdGteV
 2ag+v4QbXWt/qsVK7lApGNsUmcoD6ZF6VEC3O50Nq5/SwmywX7tqULJxWrHqFS5si+kR
 rJGp/ljKRYUs4tvEoa3nObnY9p/8/g79XaSrWAGp876cYU8Gxmk4ZoMaw9M32rRKlW6e
 ZsaA==
X-Gm-Message-State: AOJu0YyqwLucGc1QSnuu+I1XwloJ39d/1aiueuDk/4ZuGoPqQ8xT/JBe
 wSFtK3YrCv3qG+8UN5YQwjGonMRIoZ3Fb3r8kq/8GA==
X-Google-Smtp-Source: AGHT+IHAl1/7EJ8BxjU0nk7zHgifzTanFaYKktDNlRJqdh8XIZFtWM1zyJcaZDq0TbmjSqFgFpV9xv/idjSsGtfwSrM=
X-Received: by 2002:a50:cd08:0:b0:53f:bab5:1949 with SMTP id
 z8-20020a50cd08000000b0053fbab51949mr4413000edi.12.1699546049135; Thu, 09 Nov
 2023 08:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20231109080536.1005500-1-clg@kaod.org>
 <CAFEAcA_vs==UgZGkuW96wY=tdHXxk8cu1O7HRGKAoAj=Ltyv1A@mail.gmail.com>
 <de9177ea-c444-4710-8eda-7cecaef06eb7@kaod.org>
In-Reply-To: <de9177ea-c444-4710-8eda-7cecaef06eb7@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 16:07:18 +0000
Message-ID: <CAFEAcA_jtDHOtEKtdU1okF8Ej-C8vraEXvoZHYZYYOp=vscyAQ@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: Fix potential overflow in I2C model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 9 Nov 2023 at 15:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 11/9/23 16:02, Peter Maydell wrote:
> > On Thu, 9 Nov 2023 at 08:06, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
> >>
> >> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
> >> because the expression is evaluated using 32-bit arithmetic and then
> >> used in a context expecting a uint64_t.
> >>
> >> Fixes: Coverity CID 1523918
> >> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>   hw/ppc/pnv_i2c.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> >> index f75e59e70977..ab73c59f7704 100644
> >> --- a/hw/ppc/pnv_i2c.c
> >> +++ b/hw/ppc/pnv_i2c.c
> >> @@ -437,7 +437,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, h=
waddr addr,
> >>       case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
> >>           val =3D 0;
> >>           for (i =3D 0; i < i2c->num_busses; i++) {
> >> -            val |=3D i2c_bus_busy(i2c->busses[i]) << i;
> >> +            val |=3D (uint64_t) i2c_bus_busy(i2c->busses[i]) << i;
> >>           }
> >>           break;
> >
> > Should the device's realize function also impose a max
> > limit on the num-busses property? There doesn't seem to be
> > anything preventing a caller from setting it to a big
> > number like 128, which would then be UB here.
>
> yes. I will add an assert(i2c->num_busses < 64). The current max
> is 16 for POWER10.

We generally make that kind of "property out of range" check
be an error_setg()-and-return, rather than an assert.

thanks
-- PMM

