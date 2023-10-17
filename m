Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 228EA7CC41A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjYs-0006me-Go; Tue, 17 Oct 2023 08:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjYq-0006lc-6r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:52:36 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjYo-000203-C0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:52:35 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5041bb9ce51so6740261e87.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697547152; x=1698151952; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a89/UZYajdfDiu/Qyo8LXhoRbcItNYhruRfFoObqOi4=;
 b=l4fJNuhiLFD5zlmlT4huTrH27fVal6MFfqrm4YPfJXHGqkvHbmJjPHO5JXKUzf5W92
 3NpkVhKcj3u3xEbF7uLy785EIi9vgcwielp6kgL35HWOxbGBdDWhCuHdoo5FJnsp902W
 muysQLGuZtPrFsYjeu3i/Bc0buQXVVaBeUBZyfmcDSEx3s3BnOJkqGe2LoYJne9hw/w7
 xKcgtDUkDMH3C9iCRfdYJWB1Rz6T74xuhmLaCcNT8BTeAjlbSmPsoyYxZbYzwjqbMBvA
 Y7XjUQjV9Irj296LA1XxnFtxN9j0lb6jBi+tzsUkYjq4/PK71orBs7LIr7gPYkW7rgce
 Q2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547152; x=1698151952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a89/UZYajdfDiu/Qyo8LXhoRbcItNYhruRfFoObqOi4=;
 b=XkPRQ91nLkPYdRNUUtxYf7iySZa9e9o40A+eMaubObttOenSBXS5rqPzpXq+zi/Wus
 UL1vqj+9TAAKWUKN01hcGyUPf8ZLWAPzPi+FqCiOUEMRTOLdBU1O3mkAj7JG+hQLwEUx
 OQx2Mf4SjY9+3V4OIEtUphs5Ubucv+Gfe33x1AXEwr18vVcMy7f/7d3DJHbo4vvIOoiO
 FEONfHUWfJOgf/btcooK8r4fP78SaWv/nFQFAcmXSlxUGyEemR8qaJS5dxBJnkjMMQaJ
 VnIRE+Bp6227pJFbhUM3ZRIKRHvsDVIyetZ3tHvWHnCgOWx1yVBE1+1yeGQxcw0iWI9t
 BaFg==
X-Gm-Message-State: AOJu0Yx6yibBZ5bfTZS9wvxDMHf7MUMmMEepOqcCD6kwlDRGUoKTq9SC
 Kfx6yTA9qg+/jHFtQZOlMOUpAkUKDkVhcumnaxMi4A==
X-Google-Smtp-Source: AGHT+IHuO2E39DphJKqOfejGVohuwg2DUfCusdjC9lT5z+wuv2rPo7IoqGL0QR9qwTAfBpuojewZlAyUzA8sQFduBks=
X-Received: by 2002:ac2:5384:0:b0:502:a4f4:ced9 with SMTP id
 g4-20020ac25384000000b00502a4f4ced9mr1697033lfh.62.1697547152502; Tue, 17 Oct
 2023 05:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-5-peter.maydell@linaro.org>
 <c61b98d3-cafd-862b-09ad-818a5e2f051d@linaro.org>
In-Reply-To: <c61b98d3-cafd-862b-09ad-818a5e2f051d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:52:21 +0100
Message-ID: <CAFEAcA8OfRyVnP-tdMWz0g9HvYJtQb6xDha1zO05Dp855_SMfw@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/input/stellaris_gamepad: Remove
 StellarisGamepadButton struct
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Tue, 17 Oct 2023 at 13:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 17/10/23 14:23, Peter Maydell wrote:
> > Currently for each button on the device we have a
> > StellarisGamepadButton struct which has the irq, keycode and pressed
> > state for it.  When we convert to qdev, the qdev property and GPIO
> > APIs are going to require that we have separate arrays for the irqs
> > and keycodes.  Convert from array-of-structs to three separate arrays
> > in preparation.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/input/stellaris_gamepad.c | 43 ++++++++++++-----------------------=
-
> >   1 file changed, 14 insertions(+), 29 deletions(-)
>
>
> > -static const VMStateDescription vmstate_stellaris_button =3D {
> > -    .name =3D "stellaris_button",
> > -    .version_id =3D 0,
> > -    .minimum_version_id =3D 0,
> > -    .fields =3D (VMStateField[]) {
> > -        VMSTATE_UINT8(pressed, StellarisGamepadButton),
> > -        VMSTATE_END_OF_LIST()
> > -    }
> > -};
> > -
> >   static const VMStateDescription vmstate_stellaris_gamepad =3D {
> >       .name =3D "stellaris_gamepad",
> >       .version_id =3D 2,
> >       .minimum_version_id =3D 2,
> >       .fields =3D (VMStateField[]) {
> >           VMSTATE_INT32(extension, StellarisGamepad),
> > -        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, StellarisGamepad,
> > -                                            num_buttons,
> > -                                            vmstate_stellaris_button,
> > -                                            StellarisGamepadButton),
> > +        VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
> > +                              0, vmstate_info_uint8, uint8_t),
>
> Don't this break the migration stream?

Yes; this is OK because we don't care about migration compat
for this board. But I forgot to mention it in the commit
message, and we should bump the version_id fields too.

thanks
-- PMM

