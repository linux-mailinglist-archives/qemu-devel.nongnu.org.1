Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D082482935E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 06:35:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNREZ-0004JX-Ih; Wed, 10 Jan 2024 00:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1rNREX-0004JH-UT
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 00:34:34 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1rNREW-0001xU-6W
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 00:34:33 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ddef319fabso348606a34.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 21:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1704864870; x=1705469670;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6luq9iKTm6AKLTaqhXJtRo9hECc6hlK4KK2Yh9BCegs=;
 b=ka7IEC5I5u+98Tm4DGLRqqK2Pf3SE4o0Z3qfaEVCxVhSm+gRVil5Zm3hn2YIGT/ShP
 ojbYFwvYjaEwbtUX80i88hurN9yjtmtIai38wwucHZywBGPov8whL1xchsm5ymkvCuwA
 dhwvL9dnlOYETQTnWuXKZ7AiLsg9+bNlILVw5xv2BGFLM5gq9A+PMqJpLG+qwJfvd+0R
 5uNB1Bj8vRGZ6uAv5HVPxXRjXqjZDw3XbCv5O39vWt2qvKn5F6XKarE1LW16rtvzvFEq
 HjXSFoI7WaDgpTTy1SPAwWYJeq3et8RpcoRaUCkMDtTO1o6lyd5ny64VhXbWQrSu6vHg
 bHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704864870; x=1705469670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6luq9iKTm6AKLTaqhXJtRo9hECc6hlK4KK2Yh9BCegs=;
 b=J0RTD6cUS1fhTmlFtqYVqtL+M16BGTTttBZXbjPJERFt1T1ROjWhlIv7ymTgSl5Ly0
 ZftM5XrhBULZ/ujzyM6J7PuUbynJU3CRM3lJX4VBtd7Ym/FEvtesR69W9LnYQeAtpbL/
 OGgPdwK/LZykLdFYT+iXxzmLYwlLUQpBWFQeJEOkwuTngd8Bx6rwFqXHmlGLRuy+8fUL
 uLtXkwZTNdWg9irBS7QSbOP+N6jrO8AVkum8FeFDEnoDafZvhaL1YjABZGRndLPGZq1A
 FtKX5gwTHUvVV8XxZn2JiPoo6h+Eg4jvffoMtuasKmlnudfhHh8HSa3tJp61GBq0S77T
 YC2w==
X-Gm-Message-State: AOJu0YwfardngtdelSW/2FRTGBqWojW+0XY0+ufy3bztYKlgMzj56WTx
 TylHG/ZIxe5AEMAiEE4Jus1O4V9yaaaT7GI8UR6yrmHe7f/mOw==
X-Google-Smtp-Source: AGHT+IEEepf6XO97k+ljxJkNQWonxljQhPcZJKFUTXOgNdMFuyXHdFIvggZJIUj5C4YfVk0wqgSuVQInBEyhSAQGsBs=
X-Received: by 2002:a9d:6b10:0:b0:6dd:edb0:b7fd with SMTP id
 g16-20020a9d6b10000000b006ddedb0b7fdmr215186otp.36.1704864870061; Tue, 09 Jan
 2024 21:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20240106223546.44460-1-wsh@wshooper.org>
 <4b8365e2-9316-4540-a739-b5e195140ebc@linaro.org>
In-Reply-To: <4b8365e2-9316-4540-a739-b5e195140ebc@linaro.org>
From: William Hooper <wsh@wshooper.org>
Date: Tue, 9 Jan 2024 21:34:35 -0800
Message-ID: <CANto9c6QV-KAuUau_CqK-rVsyNB=42HQ3AHuQPn34yMs2-iPkg@mail.gmail.com>
Subject: Re: [PATCH] net/vmnet: Pad short Ethernet frames
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=wsh@wshooper.org; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 8, 2024 at 7:36=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
> Don't we want to initialize min_pktsz here ...
>
>                min_pktsz =3D sizeof(min_pkt);
>
> > +            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) =
{
>
> ... because eth_pad_short_frame() update it?

Thanks for the review.

The results would be the same, since eth_pad_short_frame() sets
min_pktsz, if at all, to ETH_ZLEN, the same value as the initializer.

I have no objection to re-initializing min_pktsz for each packet,
however, if only to reduce the risk of a bug being introduced if this
behavior of eth_pad_short_frame() were ever to be changed.

Would you like me to post a revised patch?

