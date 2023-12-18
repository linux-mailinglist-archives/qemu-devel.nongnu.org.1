Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB138174EB
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:14:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFFIt-0006F9-Li; Mon, 18 Dec 2023 10:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFFIr-0006Eq-Ov
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:13:09 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFFIp-0000mg-Lo
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:13:08 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55333eb0312so1276036a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 07:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702912386; x=1703517186; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bYeSHm4wswRJn6b/WQ53Z7Dgquy+ccBZWzRwub9ZcOE=;
 b=Yt0cPCs8FlbEVM+0VX0O6+q3RbKZedRzNg573ylnxB2AnXEX+uF4K0o1N6Q7K1umN4
 wilNP3QbHg9DWeTS5uWm1faIbDywe/yG6Q9aV/7S5utZj+d6UuZ1JH5XuXHcSjMAwpNh
 WHUD1xb/ewmRLHwTPDF54yppQt1McpGDvBxWWao7UKIEKYt0T6ooX+gnIrqEDs17iuwx
 kRSazLIV/pWA/sS+QG9sLN5YicIcgDnVU0VfPuj2gxtwswD+tziijK7lNDqVLltRKr3r
 Yqkt/l7DkLyPeXAG3R0MlSyv5KSKJbrbUPjNYYiGqkkByNfiIi/Br07sacGjlXjrt/ET
 r2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702912386; x=1703517186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYeSHm4wswRJn6b/WQ53Z7Dgquy+ccBZWzRwub9ZcOE=;
 b=ghMHn3yoQG5rA9O7rfElye2VgQ8bT/Hy/OXkLTbyl78Pn4NnDyEOZWBV8rVaBwe+9C
 WKH1kRbyth7/KC7oKV+InznHcZfH1pkjaXvwxMVVxbaFna5lJf/KyNTNX50+2HCWMm2a
 amltXXbGfHWQJ2k6DmXOrJME9GPtq0PaMGhYkZoGMw0zOX0RO9OGW0ydi30ITfKC2tfT
 UVt4J9vKl1x0cNm+j7tkw2ARjR2lO6/AJDDuj553UX7VvpX5LWCu24i8HcdRCh3NfQ3s
 bzkvDkrVnN+1S9lwt30gkmX9ry7wSBA4wxtFF5WS6A9ekfIvLtYBTBfv+8tgalmfJJHi
 iyWg==
X-Gm-Message-State: AOJu0Yw3dvNtd3HQuMua6VPTsNQhnejuP+O/362lsaA59HbtM8TD5n0N
 UD2zk7oRLYa1h9EP1poIJegf/SRdSStFKA+IGkbwZ9gXt99w3v/A
X-Google-Smtp-Source: AGHT+IHuGiraBWoVPJT5ZmWIsIFe9PjAbBdIfmRKCUJhK709SGJ/iQwx9iq1mgsjv08FlkxKXgfbd7rQ/OyWAukvHl0=
X-Received: by 2002:a50:d095:0:b0:553:6692:db67 with SMTP id
 v21-20020a50d095000000b005536692db67mr815664edd.12.1702912386045; Mon, 18 Dec
 2023 07:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20231216133408.2884-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231216133408.2884-1-n.ostrenkov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 15:12:55 +0000
Message-ID: <CAFEAcA_yXDfq8Q=374dtbWz=-SeioF7gxVFqtGuteTLZQgjZ5g@mail.gmail.com>
Subject: Re: [PATCH v5] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 16 Dec 2023 at 13:34, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:
>
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/misc/imx7_snvs.c         | 93 ++++++++++++++++++++++++++++++++++---
>  hw/misc/trace-events        |  4 +-
>  include/hw/misc/imx7_snvs.h |  7 ++-
>  3 files changed, 94 insertions(+), 10 deletions(-)



Applied to target-arm.next for 9.0, thanks.

-- PMM

