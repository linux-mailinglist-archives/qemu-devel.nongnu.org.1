Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EA7CC416
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:12:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjWX-0003E8-OX; Tue, 17 Oct 2023 08:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjWT-0003Dc-Qg
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:50:09 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjWR-0001iF-S4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:50:09 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so13983767a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697547006; x=1698151806; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M1fUvPCfisaD3RWNGdiZS6+mZTgMbjpos7AtuXfSfA=;
 b=XZc0TFPGSis536QuLeX176N+XjHyjMzIb3JC8jQ+5tNYZa4LdRKiLxyNQFcp3Q/qGN
 Xz8XxsozWJo3IEj0jsbGDCXrQKJQNADlvLoYLbbpK5PF+Qf8URDCykv1quxA4fHo4716
 JdjnZmW/M/DNYgmlalA/jr6L7LCXA1S2/yJPVGxSDD4NeTJx/YICquwZEgPrY7M+IEe9
 gE1A9VT4EgDcZGpu9k7XTvOI+C8FXhS0G7uvaelQPw+2LyxyCFMeoGOUs7iTZQOjePXJ
 30rqAnL0A9EQBM/bDYyBLT3MlXAUfzCW3F9DEEYqcVb5nT9CuiUB0sVGHFG+LTCX29jH
 3u/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697547006; x=1698151806;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4M1fUvPCfisaD3RWNGdiZS6+mZTgMbjpos7AtuXfSfA=;
 b=lKI4zEB4nEfvZqHzy1zLofBXhU8RdmNI04tYj9d+CTYVMl2mhiDIQTQIoirU3VwMmd
 bA3QJXqWNpyzSBP+jFQFWpilmyOgfcdxu1dXqAz00D+Vi9Y4pGHVUIwxt8FUzd1caLRm
 WeLPtlX55EE41T0Yu5oD9ZORfeD3xGnFlYcOX9Ynq1cHSlrcqabx651UBhHnxbOkt5Up
 +UhdCHC7wUfDf1l4UMnvcVzZM4oncuuuDZjEPKQVyIuq2yC7FiCrYUK9dsJ3+TExxikd
 R0fQ9rEJdSD/UdwVM8Yy+D/hvA0LhfHkuYLdlbENix8WCi3EXSiRtOk+FwnmsWV4NlEs
 Z2yA==
X-Gm-Message-State: AOJu0Yy/Jf4mklsgK5NPXju4fGJKOhKKcsgo51ppVd5Dnt/JXnRMXevV
 RPtzgZQaYUU7j4ZUQEFO0hmPW3nPRQhtoAl0F/j2ykw9wbVmmqMY
X-Google-Smtp-Source: AGHT+IHflEr2ii6AmpBKiyoaQ5E83L5kePTO02rk4qU6KcSjZtw19Nf23Sa8T+PlEaHsQ2SebUcVfqUvkTwDi3RmSQg=
X-Received: by 2002:a17:907:7251:b0:9ae:577b:3832 with SMTP id
 ds17-20020a170907725100b009ae577b3832mr1779576ejc.24.1697547006331; Tue, 17
 Oct 2023 05:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-6-peter.maydell@linaro.org>
 <f85817c0-df0f-6e71-c5d4-61e6f2082a75@linaro.org>
In-Reply-To: <f85817c0-df0f-6e71-c5d4-61e6f2082a75@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:49:55 +0100
Message-ID: <CAFEAcA-8_YVm=cFGZ7yY3Nj4GCbz4UEGH9VX7fYOkpewBdm5XQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/input/stellaris_input: Convert to qdev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 17 Oct 2023 at 13:48, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/10/23 14:23, Peter Maydell wrote:
> > Convert the hw/input/stellaris_input device to qdev.
> >
> > The interface uses an array property for the board to specify the
> > keycodes to use, so the s->keycodes memory is now allocated by the
> > array-property machinery.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/hw/input/stellaris_gamepad.h | 25 +++++++++-
> >   hw/arm/stellaris.c                   | 26 +++++++---
> >   hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++--------=
-
> >   3 files changed, 92 insertions(+), 32 deletions(-)
>
>
> > +#define TYPE_STELLARIS_GAMEPAD "stellaris-gamepad"
> > +OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
> > +
> > +struct StellarisGamepad {
> > +    /*< private >*/
>
> Since commit 067109a11c ("docs/devel: mention the spacing requirement
> for QOM") we don't use these private/public comments anymore.

Oh, good. I never really understood the purpose of them.
We still have a lot of them in the codebase, though...

thanks
-- PMM

