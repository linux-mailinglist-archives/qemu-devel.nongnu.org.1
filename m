Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A675DBE2
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:23:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNAge-0003VL-B8; Sat, 22 Jul 2023 07:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNAgb-0003V8-KD
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:22:09 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNAgW-0002m7-OI
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:22:09 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51e344efd75so5838614a12.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690024921; x=1690629721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OZgxTaeruVITXYyY97MR+4fyVPteqrsxVDo8I5Va26w=;
 b=q9b4Vf0XcAzztlyV/coyV4M/lALZJd01g0dbaDE+yD0Jb/e4sU8MYRg7WGCZh9NpV9
 1sHn7/C2Yw1ZHnTdiW0atFsieomdCV++5xv2Lil+swBQAyBWORAso75tofKHDf5+Sb1D
 fH0/bfJcbBMeosEq0ZCtV1jP9Tt32E52oOzyrrD1JMWpFxtAHO656v+n8WcU1/KbjNME
 +6oiYwoTNc6hDGh9yVHxWkuWgOj3yDIkhDXDbHXqB/nBFsfOVNuSmGeVXBPxqpk1WRpg
 wjm5lC5SbwIYbR8hDdRgeib6uHKjX6jk3iW8bqf8rxb5y54dRcB8UE6TAuYhoeGS/3YN
 Qh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690024921; x=1690629721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZgxTaeruVITXYyY97MR+4fyVPteqrsxVDo8I5Va26w=;
 b=ENYIQ0feNS7GttxAqOa4Q0Mrbhfsbgm25STraOYpkUgNIKqNJms9FqSUdPaOP7bFID
 wWpPwDV3YohOIZMf+XobnO5jgEVKloGEbfWSTwDD+2FduT7U9BEitAH6wBRWWw5g12gT
 kWIVabNEwS3QygXfeT8fcE45FjDcxXPP9IwIIyPEDZTo3Gpq04Mmq492bfzfhBrmoj/h
 RYjZoMXX1Li17uQ+N8Gx/DfGO0ZBWfNQJrajMzIXBCut4XZLiwQjVhg35j4YuNkZEAoJ
 0YNKwWxwmMa8MxojWcwDRmaHVeByXkRor5Vxjo5i/GaSi6jxpVF0+5X9C3Yvo3cHNZWw
 gOJg==
X-Gm-Message-State: ABy/qLaGv5Qnr1K43vmNn4mOLzv/Y4W9YP59Lo6648bvsYsEmfz/VRmQ
 RXANvA9o1Sr7hPP1dST9IEwQxj4zCi3bFzKjvzwU6Q==
X-Google-Smtp-Source: APBJJlHQ9q3KuceC34tpD3cFpjd4C/8Savbv/NR0r9WijLfFk2+eWO3QP7Gwa8CH8dmj2o5Gp5vFASn4ODwCgQVIfew=
X-Received: by 2002:a05:6402:752:b0:521:d2ab:e4df with SMTP id
 p18-20020a056402075200b00521d2abe4dfmr4782240edy.19.1690024921302; Sat, 22
 Jul 2023 04:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230722082616.3254040-1-mjt@tls.msk.ru>
In-Reply-To: <20230722082616.3254040-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Jul 2023 12:21:50 +0100
Message-ID: <CAFEAcA_b5NfO3ijyDQufaLhQ8kvAmctNz+BrPTt=6SxNOJy9vQ@mail.gmail.com>
Subject: Re: [PATCH] limit brk adjustment wrt interp.brk to arm32 only for now
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Andreas Schwab <schwab@suse.de>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 22 Jul 2023 at 09:26, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Commit 518f32221af7 "linux-user: Fix qemu-arm to run static armhf binaries"
> added brk value adjustment to interpreter brk value after loading the
> interpreter. Unfortunately this broke aarch64, ppc64el and s390x emulation, -
> the error which we had on armhf now happens on at least these 3 architectures.
> For the time being, limit the adjustment to aarch32 case only (where the prob
> originally observed), to be analyzed in more details later.
>
> This is a quick band-aid, not a real fix.

I think if 518f32221af7 broke things we should revert it,
not put in ifdefs.

thanks
-- PMM

