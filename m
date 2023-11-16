Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9897EE629
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:53:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gXZ-0006s9-9T; Thu, 16 Nov 2023 12:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3gXW-0006rp-Og
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:52:31 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3gXU-0003Yd-T4
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:52:30 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so1652922a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 09:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700157147; x=1700761947; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVZVzC8npsEzmH+7oN4Wn0psaEvUB4jX0CvxIhJCDFs=;
 b=sCmChZLc9gv4mN4Grw7vMsu9VY1HQJ2Z6SUHmL/eVzCe6XO1NeYyJa3yUq5xDTysVS
 7pno4+zB3m0elQaZuG2UtT6B/uwiwJBS8+KTghrYQMRE+WkNDB9f69eIjTTWE/aP9jAP
 mAekxTxmC6LNHi7d5ZR/aw2Ug82s6YiCCzGVLfGM0gO6mkP51Jc+HVxpJqGgIReksE3R
 gT3YzIvXQXOGi5yp4EBAVSWd1HWx0Y4hu3EF/Bfi2v1PGti5qIEekjgJjm7GgqmJP6TV
 VHgx5YxGxog2hgQkUhXSgSNFOARSCZCg+VEEQjuc5GGfUfy/Hhz4G88TmZSpjs580rmL
 ucAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700157147; x=1700761947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVZVzC8npsEzmH+7oN4Wn0psaEvUB4jX0CvxIhJCDFs=;
 b=P6i804wnA6n8t99CKEHMF63PJ/duV85lJaaCLnL31//AVjba4qwpCBFazeguTgLMKR
 LxYFh4g2nT2n1vunE2GmDaJ3u8WVnnPLmXhwwpD1Xm9AvMuNEA9eiOSZp0MjthiBBJju
 S2e5e6IFT9vv3kCXw7B64PBkS+g4smYDUQvMZRS4inp8FNYlMzvKIiunrMqIn+NCQHij
 1R25nbgjU3IgegtALAEgu6wLbyDrUZsdF1LLnAo6+IiSz0QAQOrpflEwwtB9aJotiLV3
 rPOuoGspFmwg4aIp2rdJxXkB5nxvzRqEWi058TeJdyZrObutD+Rxy0E+TvYdBWQEQ9yb
 5MLw==
X-Gm-Message-State: AOJu0YxnyCW9xdINeyf5acpa4FqCbIhKADngzecT9arZniE3LwIEWKtq
 oVxHpeHBbVssvO/8YK5yg054iHvlKPQkfa+IZUDkkw==
X-Google-Smtp-Source: AGHT+IFmxoUKhRqLqGBHvIKze3VIeITt97NWaJcWW4ikmM3eQWguQaVWgDNj6kBoZ9/VXhRdrzGchPScqbqmIOqqUEw=
X-Received: by 2002:aa7:c3c9:0:b0:543:5d2e:a9c3 with SMTP id
 l9-20020aa7c3c9000000b005435d2ea9c3mr15001139edr.20.1700157147066; Thu, 16
 Nov 2023 09:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
 <20231107101524.2993389-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231107101524.2993389-10-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 17:52:15 +0000
Message-ID: <CAFEAcA8QwVTLRO8eOxRan1Uwd4uCstMXkTa6_eLnfNxAupNy=w@mail.gmail.com>
Subject: Re: [PULL v3 09/25] ui/console: allow to override the default VC
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@gmail.com, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 7 Nov 2023 at 10:24, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> If a display is backed by a specialized VC, allow to override the
> default "vc:80Cx24C".
>
> As suggested by Paolo, if the display doesn't implement a VC (get_vc()
> returns NULL), use a fallback that will use a muxed console on stdio.
>
> This changes the behaviour of "qemu -display none", to create a muxed
> serial/monitor by default (on TTY & not daemonized).

This breaks existing command line setups -- if I say
"-display none" I just mean "don't do a display", not
"please also give me a monitor". We already have a
"do what I mean" option for "no graphics", which is
"-nographic". The advantage of -display none is that
it does only and exactly what it says it does.

Setups using semihosting for output now get a spurious
load of output from the monitor on their terminal.

I think we should revert this; I'll send a patch.

thanks
-- PMM

