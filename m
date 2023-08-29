Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C206F78C4DC
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:07:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayQB-00047n-6L; Tue, 29 Aug 2023 09:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayQ8-00046O-Gi
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:06:12 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qayQ6-0004dB-9Y
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:06:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a3aa99bcdso6120260a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693314368; x=1693919168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/d+IHKVhjyzzcBoT08+0UZkl6B6Df7hnsYgh7N4Kdto=;
 b=gefUOHvVcNZyaKDBkur7fFWatjsLhZA0v/AIW5WptmtSj7qPvuQ98VjBr4lZnaknvJ
 Ona6gZrR8EftXLjpoMjwnUOWyaMONL6+JNBb201663I8eG3Mx70J6HxByXkCf7y0ha/n
 CrgSzG6IbxaTa8llfMEXH6ZH7iloj2WAlVPgSaeftGQOeC30ievNkDiqtBnA4C2glFnO
 4qgzFSpT/aAa8/hBfRU+0SRuXfEmaogGtBDV9qIhlc/mNSrLmJ1Mjx+pFctGEbbTEYhN
 NBOkDw1I1amxMWJXlxXaw1tvBJV4re2GUtILsdVtgvRZLbCGezoXaFJHvDD/l9yeB/g1
 /OAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693314368; x=1693919168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/d+IHKVhjyzzcBoT08+0UZkl6B6Df7hnsYgh7N4Kdto=;
 b=gBRHNUY36fh1VlXcrO1gQIkWIrNVZsiIxlzDrb92dacoW1eME5TIB/KhXcApvFKyxN
 F1MjzKf2jdfKMUpCA/BZRgdL5ks+IEP36UdMTptAQerBD+L0fWgIDd+tqcZBhxg0NbJt
 wrw3Qoz+YJMV9wtvJBIOZW8fhFmRuqCYdkxSdjlvaw/80rj1h1igZrEoMz8T0SUX4cFm
 QH5g98fiVVom/c/jU9UZDRfw9vr/NmE88+jz4NXsKDaoJiP6YCYGQaE/JqBNZK6h5ult
 yZ9QJRTTuTRpI0ViINdk9zLh/uz3iTBEZu/QpGj8JT71zNCEVphoJN6DKPGBxz0Jt45V
 Rbpw==
X-Gm-Message-State: AOJu0YxSiz1Pk2lkqhnG4jzfW1uLXjK4SittrX8rmhfnyuk3nS0vc5zC
 6T6nERPMw4b6gYrTJ8EzZ1eKnulHJkYc+2sz1H6K3g==
X-Google-Smtp-Source: AGHT+IEkxR36PYfgHmirYQZRV1lMchCFYK7SYe0HSYJ5pZ7pHHdbFp9rnffQ7Vj+FGb71rNaSv3WtBlJCCOpB4LZ5fg=
X-Received: by 2002:aa7:d34f:0:b0:525:4f15:d26e with SMTP id
 m15-20020aa7d34f000000b005254f15d26emr20001733edr.32.1693314368534; Tue, 29
 Aug 2023 06:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
 <20230822042530.1026751-5-richard.henderson@linaro.org>
In-Reply-To: <20230822042530.1026751-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 14:05:57 +0100
Message-ID: <CAFEAcA_1YpcoDvsUgmLhD9c2U49c6coOO3X8ybuZ_cCzGC1wtA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] target/arm: Don't change pauth features when
 changing algorithm
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 22 Aug 2023 at 05:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We have cpu properties to adjust the pauth algorithm for the
> purpose of speed of emulation.  Retain the set of pauth features
> supported by the cpu even as the algorithm changes.
>
> This already affects the neoverse-v1 cpu, which has FEAT_EPAC.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

