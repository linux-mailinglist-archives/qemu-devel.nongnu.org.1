Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201A78D6B9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:56:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMbu-0005e6-3l; Wed, 30 Aug 2023 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbMbk-0005Qb-9x
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:55:51 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbMbi-0001Lo-3H
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:55:48 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so85955811fa.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407344; x=1694012144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PqZLJH+sYZ+PTZMmrO4ed85PJ1nGazXEdyk5wET/rsc=;
 b=SpPGQcJsHJhPkBFYYw4W4zcEQxnSllrQgd+hh/5xyHmCvyomj3yhg7ehLheVD7GsoF
 n7t1uKQ6RSn0Bg3u69uPhT7fHrCG9CjchLoGLl+rQG+ZUmSYp9wJMxkTEgWZpegp8ABk
 UW1KWieh+hqSQ39AHJfN/LDy3v/1IjBee0vc3WbA9Aw4jeVum6uXFOBs7qauDdIOLBs1
 oXF8vIVDrqLVRyriGMetO/xOfQG+pLmeUnM2fpcZTcvsckUTG7+RH4hOYWKHA7cEjTPb
 pnz2V1017VXHYUCRJRZ8Mj4zd1AygIDheHFa4JrlSyFPjKfWCJQ7L5ubb2cgIspxUB94
 ZdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407344; x=1694012144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqZLJH+sYZ+PTZMmrO4ed85PJ1nGazXEdyk5wET/rsc=;
 b=SatptMI0YrWHdLyWN3ENH5NutQZFfIEue7wxljcUZJbYQPat0uEhuwX+Oc9fyKNNoP
 tfrS430T56D7dVxEU3b+KogLx+U9WbkooRS8FTR1HcvBUqGRde8FRgrDOyT0Id/4SF+W
 NalV907WryFPhP2+eNY1RVDgaTuWIVWGy8obeRruSZXeMcfKpu4Q/BbrLFTqvyvJxqMP
 BJEUdhaImJvuWzYVjxsKGBxNcduATAS8j92xp5+wvLt67FtrV736YVL4Laury7k19Fsm
 EDmFVs12UHGaWDNZJSyEqAwP6ZKDgzUv7zh+yopodLe+1+vN734mHv/2e012H6hg9DTE
 6TSw==
X-Gm-Message-State: AOJu0Yw6FE+Ti8K2+/wD3JFw7A+l+/dpCGl8Pdou3HB6S8kdt43b3i3m
 t0biENyBFNzVKSJALawjG587bVtqibuoSI9BMu6kkQ==
X-Google-Smtp-Source: AGHT+IFVEBGCLfvWoClqKa8Lrn2ANg4JPDsezG9WJrS5mM0/9AeXor/VtAPF50XweKESQZAbnnYLqdt4ji288cE+jlQ=
X-Received: by 2002:ac2:46d2:0:b0:4fd:d470:203b with SMTP id
 p18-20020ac246d2000000b004fdd470203bmr1818868lfo.69.1693407343950; Wed, 30
 Aug 2023 07:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830144743.53770-1-imp@bsdimp.com>
In-Reply-To: <20230830144743.53770-1-imp@bsdimp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2023 15:55:31 +0100
Message-ID: <CAFEAcA9LNyxEe42cBBWYLE2TxQKD39Qv_Ud+-TbbWdvMR=wNCg@mail.gmail.com>
Subject: Re: [PATCH v3] bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to
 qemu.h
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Wed, 30 Aug 2023 at 15:51, Warner Losh <imp@bsdimp.com> wrote:
>
> For the moment, move PRAGMA_DISABLE_PACKED_WARNING and
> PRAGMA_ENABLE_PACKED_WARNING back to bsd-user/qemu.h.
>
> Of course, these should be in compiler.h, but that interferes with too
> many things at the moment, so take one step back to unbreak clang
> linux-user builds first. Use the exact same version that's in
> linux-user/qemu.h since that's what should be in compiler.h.
> ---
>  bsd-user/qemu.h         | 27 +++++++++++++++++++++++++++
>  include/qemu/compiler.h | 30 ------------------------------
>  2 files changed, 27 insertions(+), 30 deletions(-)

Yeah, let's un-break CI first and then think about a neater
thing afterwards.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

