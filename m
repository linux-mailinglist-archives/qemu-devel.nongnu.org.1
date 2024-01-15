Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17482DE20
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:03:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQK6-00007R-0q; Mon, 15 Jan 2024 12:00:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQK3-00006H-ES
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:00:27 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQK0-0002Ja-QS
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:00:27 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-553ba2f0c8fso9942617a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 09:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705338023; x=1705942823; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGwlGAhd0mA1JYn1BCHmVsL+RAIJ122TLrnq5kJ+q1k=;
 b=fQoYGGp8JgKlAA4rDxWXPLpgaVe74NhAbN52k8lLi3M29Evf98Ttnq1UWQfiQm29Yf
 f+nzEWPvAnH9JMlC4nybemjKsDsc1AF9Pujg6ZSzxl/DznYj5PfyUotH994NyRC+Hw0Z
 7pfTDjeDXaFCx6g+wOTyeCcmK/+ZieQe2P9GBujBontmN3hURqPbAbqLny2sQ02lhdlP
 YplKXuW4zCXTyY/awTZcMpaTJ7JwUuNxb5WRoKaehB7qcvyedFtPjRElNKQSwPdYsDul
 A2OLzZ+8vAWHWElCphKu2xXtzccL7Kyr46w+Vr0se1GXhfTaj71aVItoI6V5JAZT5+Em
 YUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705338023; x=1705942823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGwlGAhd0mA1JYn1BCHmVsL+RAIJ122TLrnq5kJ+q1k=;
 b=uroYxSk1xQAaMLZSp5unq8e+Sx5q7iRmB8ycgTSHcgOyHGGI3/fjyvYVw9JHlQb6C5
 nBZ+/FMadFNE6QjAsPWOrzVzQ0FqJkKXwKFMmdTcUKj1mg3AB3tZe3FFE+PQ15844Xcl
 iviqaBUsfyzM5UFIYbqshWQWjL6+hoxgfp2L91PLY+XAxwgCXFAAMKGtZyfaWGIKoFJH
 DIGIckWrgZjUqMO0xEcN6wzRiKyRsZAVixNmjAcziZuTy9WIyfJJsvp29AKTM3JFkbKZ
 obbceDIfEt+5IfDD0CZ9atzX1OhA02s3gDeu7hbcLxScsxcq3464KWdZWFbZ82v+oOGg
 2gww==
X-Gm-Message-State: AOJu0YyU3pc6d6wgY6IXsbNeM0u+NaBTm0bybNWRz2GhZ1/RDryYjk5i
 G1hPF20W1Q0Wu8iKkfX7GX5Sg7zM8LmSD56Dmfi3+Zi3/9RaZQ==
X-Google-Smtp-Source: AGHT+IGILdWKV/4M/cd2dt0iAswse1r5WoMnGsA+E7uxY4K7UsCVrz1MTLzBeTNNpbJcKCBeIQ9vOOYH12QBdGVcwGc=
X-Received: by 2002:a05:6402:553:b0:558:7f0f:aa79 with SMTP id
 i19-20020a056402055300b005587f0faa79mr1590008edx.66.1705338023153; Mon, 15
 Jan 2024 09:00:23 -0800 (PST)
MIME-Version: 1.0
References: <20240115165615.78323-1-philmd@linaro.org>
In-Reply-To: <20240115165615.78323-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 17:00:12 +0000
Message-ID: <CAFEAcA9vo4BMys0EbqYq0a_eTQahbJnAb=N_fHzWCcGqeoK=yQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm: Unconditionally map MMIO-based USB host
 controllers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 15 Jan 2024 at 16:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When a chipset contain a USB controller, we can not simply
> remove it. We could disable it, but that requires more changes
> this series isn't aiming for. For more context:
> https://lore.kernel.org/qemu-devel/56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@r=
oeck-us.net/
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
>   hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller

Yes, I think this makes sense. It is technically a migration
compat break for the affected machines if the user was
passing the '-usb none' option, but I think we're OK with
that; worth mentioning in the commit messages I guess.

-- PMM

