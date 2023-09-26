Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B24667AF50E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEe7-0000l6-BN; Tue, 26 Sep 2023 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEe5-0000kf-NZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:27:01 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEe3-0006Fd-Mx
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:27:01 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50307759b65so15823394e87.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695760018; x=1696364818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C/E5AmMRSLS2jKC/m61fTD4kLqWPKnSKi5Qv4Qsak9s=;
 b=p2W3vnMBU+i8PDx1op7Obpyfk8py7d1NiVo0WC75vKOKm0/fLwdyeDiVpz1LSm8GJe
 kOE0PS7IYsEFW/AptVShCc0axPekqZi+hOV+13ZTbwETMPJtgUsxjo7j7Krql99sZSkp
 jveRyOq/qOUpIZkJ/ZyoGZcfM2rx4tu29u/Y63kplb+eEbfprM2uUXDctxDzjqLWahpA
 zllD96intVh2NCH7hlmd7D/qi03T3UimYDvdyfIiDjN1qfD8RpmkGfTH6a/A0Er2YZ6g
 kaW54bzuF9bFoj4Un2mw2WVqmFVvsLtrCl+pgJzo33U7Kw/rhAXICrxoqxXFOhJ0pGC6
 Cu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695760018; x=1696364818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C/E5AmMRSLS2jKC/m61fTD4kLqWPKnSKi5Qv4Qsak9s=;
 b=SDI1nbPWtYj9cXbylQcZIHKnMyeDbaH+00v961U+Hk1vmVwOJyt7D6Y5tLEdSo+XkW
 DIMCQlaW9LiSC069a+UiNyI15lyavLnGbmGjhC5sUPNFFhfaf+5gpcKLR/f62WZqhR1y
 dYZZYk3OJEzXL+7OBhrFhZojINS6W6/0NmHfVCtAgQkVg0JfbQhOAt1eHIiOcugXatdt
 Ii+kt6IOjNU+Mw2H8HFw/Co8OnhDR/JoMw0NVeD1bdUos/fnqbzrhz5niL156+e91XSS
 HMW2wgFqfqVbG6i7JRG7LijW4rXMCvNrlzXQD+pMk2k7yJpuoPUIe6Dx8XQ1py6tDMiI
 cUHA==
X-Gm-Message-State: AOJu0Yz9oVKo1HyM39Vwh6PEZ369dGd0Uec8NB0dQxxAq2sGeQLeGN31
 DOJEgP9O/0XvAFn9Ig4XFTN+147Jc24vLLGJOLCuGg==
X-Google-Smtp-Source: AGHT+IFcWp1tsqF9GNVvp0s8Btkp+exyUKSdt5VEb6zNz8WlQ887UPrPgucdwwxfCxt48i/rdWpaY+3KbU4fQXxdehw=
X-Received: by 2002:a19:4f43:0:b0:502:f469:d4d5 with SMTP id
 a3-20020a194f43000000b00502f469d4d5mr8027520lfk.19.1695760017942; Tue, 26 Sep
 2023 13:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-8-vsementsov@yandex-team.ru>
In-Reply-To: <20230926201532.221152-8-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 21:26:40 +0100
Message-ID: <CAFEAcA8vkRqPgx5EiBsUH28A_9puFW4t1Dyi8g_CdPQ6zrsJFQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] hw/core/loader: gunzip(): initialize z_stream
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
 davydov-max@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Emilio Cota <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 26 Sept 2023 at 21:16, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity signals that variable as being used uninitialized. And really,
> when work with external APIs that's better to zero out the structure,
> where we set some fields by hand.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

