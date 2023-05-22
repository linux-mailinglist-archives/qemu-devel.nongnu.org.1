Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A970BCEA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:06:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14J0-0007HD-6V; Mon, 22 May 2023 08:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q14IT-000780-Pf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:05:59 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q14IQ-0002dz-OL
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:05:52 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-510eb980ce2so6777168a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684757149; x=1687349149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3nDPkpZcS5CkxGXF3Oer4I4F5NDGn6kOFgGyXUkxK/E=;
 b=cs0EwpM9qL8m1/7oNwI51GvZqAs/JGyPjHUDLh8y9iWvVkEHZrXW8XQCc+CVOy/pHj
 wr44yChWTKiatTH7coLAwpwiY3CeUJHd9Vu+9QjTJFUslm7NT7t15R1dA9cIaKejgBzl
 OSpd1YLhw+mj30VWXw8kvbmWr7wEt6R50xBNZF/vGEzltvjbe3gOaypdxKAaMjLVIpbN
 LKgRWSc1gjJKfvcjtYw7+crNUBHZHwLxe5PM0Wb3gv7aonNmIJ/0SCOS/eF1H2xnr+NP
 1ViqE9DOpZCHpVCX1bqHr0EmbcnohbBKk8lscuQGXBeXKNpAXYXo2SczVCXPGjfuaou4
 GHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684757149; x=1687349149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3nDPkpZcS5CkxGXF3Oer4I4F5NDGn6kOFgGyXUkxK/E=;
 b=D8agpyhIbHvCHDhLceWOg6UG2Jxcb6X87XixZKA9qeORxcwpXtQ6wFfXOdbYKFyG+d
 wwnHrcc+pBYr02yF95r/dKapRGXXgtPjSTuGfgf2Y4gwqnmYFpAhMSczafMsn6wi6Mqx
 gkNlwRGuzimoNxGml/PA4jT4zhHm/0GZe5mkJ25kmBwmL2MYKLNmIto7n9gsFewlhSDP
 q1xuYZoZUp6ylbyC5rktA8hB1+bCvA0BahpOMJN4/JO7JmGWXnFH7NgKYj6U3/5sU0CE
 N3TwGaPauBOTTO7/HHyvGfzLNmI20floZwYftzYfIQHJoOqbeBi+r7NAeK6m+HPj5W29
 Q6bw==
X-Gm-Message-State: AC+VfDz7ji2gedlgNGyzln0zMncMAxHy06Pw5rUubHVuGAF1mAKOHm3d
 pi1HGlmS+ykDrtOXjSR9V9vWK2PtfO0c/nJi0m+i4Q==
X-Google-Smtp-Source: ACHHUZ47pZ9YadquVeYyJ8XdN2WMY6ydTA9OJuKzkD/eUOmUjgedMrF74ckkcwSlvNi1lVeDSP+mSc1cUwgnCbt0hRo=
X-Received: by 2002:a05:6402:2d5:b0:510:f6e0:7d9f with SMTP id
 b21-20020a05640202d500b00510f6e07d9fmr9184627edx.13.1684757148982; Mon, 22
 May 2023 05:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230520205444.887287457E7@zero.eik.bme.hu>
 <CAFEAcA9gAYPpOJ6VyPYwCVyOhMmJMEe4QyGzB57xCbK0MOED5A@mail.gmail.com>
 <0ab99dea-dbe6-9b3c-37a1-0ad66c0573b2@eik.bme.hu>
In-Reply-To: <0ab99dea-dbe6-9b3c-37a1-0ad66c0573b2@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 May 2023 13:05:37 +0100
Message-ID: <CAFEAcA-pxaWN+AQCbzejdy072otR4Sm6hXURW7s8_Eb+cZMBUQ@mail.gmail.com>
Subject: Re: [PATCH] bitops.h: Compile out asserts without --enable-debug
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 22 May 2023 at 13:00, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Mon, 22 May 2023, Peter Maydell wrote:
> > Can we have some figures for performance improvements,
> > please? General QEMU policy is that asserts remain,
> > even in non-debug builds, so exceptions from that policy
> > should come with justification with figures attached.
>
> Here are some figures converting a 10MB wav file to mp3 with lame on
> AmigaOS pegasos2 which is using a lot of FPU operations (which is using
> softfloat on TCG target/ppc due to no hardfloat so it's very slow):
>
>     8.0: 1:11 0.8264x, 1:11 0x8258x
> master: 1:12 0.8117x, 1:12 0.8103x
>   patch: 1:02 0.9541x, 1:02 0.9506x

Thanks; that does seem like quite a lot of overhead.

> I've never seen these asserts firing and unlikely to depend on run time
> values so leaving them in non-debug builds seems unnecessary overkill that
> also hurts performance.

Where they don't depend on runtime values, the compiler will be
able to detect that the assert condition is always false and
won't emit any code. It's only the cases where the start or
length are variable that will be causing the slowdown.

thanks
-- PMM

