Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06875793D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:26:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLhu4-0005Jo-2G; Tue, 18 Jul 2023 06:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhtt-0005F7-6f
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:25:49 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLhtr-0005YV-30
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:25:48 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso8869962e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689675939; x=1692267939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53TxoCa8PwII1f/88lnrKFx7DZcJM0tT7V0/8C7GYuY=;
 b=S++L/LHeVqoR0v+BbQC/i4/siz/bxwFBocCNXA92O1UgU0dhE1hH9GNzIeT59gPhwu
 qIJiOJAT3wCrwWprzqTkk5LH3aOcn/iibA4i1yQhGBZHWIK3NiqMrn2ZaZgWE76J1amg
 1Re4T3mzo05oT8IpQOAdWc9+gfBkQws2bcqVjiTjD+dLsvAIKpKIVEGM+2HsmdwNW/WC
 p3T1pe+RJ7jqVNDIoeaXevhezWy+mlh3k/3ifpMG8cKIFaTLQyzU3vibAlAwF1VK3mLR
 bIMgO5D/qnMqP5UysBjsWi+EkkyJVxzO00as5WB4uC97zuxiKAqmWL1PHIY8Aciz7Tef
 DPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689675939; x=1692267939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53TxoCa8PwII1f/88lnrKFx7DZcJM0tT7V0/8C7GYuY=;
 b=l2PewATeuLki/okO6xbQMLzQmxc5oZshuFFcDUGNHufPQZKHR6XvhuS1EtpNjEP5X6
 nu5UQVwhmXggE3Cc0O2o4kvPkrMxH/ocfBmn+e0SSvVDN2hWr21MgWpAeV3CpM2OleQ/
 s/Lmg91UgoK6IPXFikbT3QtvR1iie4z9oSE/aYVfSfvMsMwVqA6G0AlNYSGBt+Ss9qzc
 eyGBWZ7GOkvv5JJHr4hR31w504MgAthNKA4ffInYIBaZCIZmKxhF/5yinm7NOwI6LJqO
 e1YN/CLC9+5Bq+vZ73NUKexmi62nKkoSOyKZiQ3gZaIkirBiC7MhFpub9B4H35a+zjXZ
 CdxQ==
X-Gm-Message-State: ABy/qLZIteIYrXnJLRfSWnKQFFXTSm8Agp+NBczxepWy8GNy3iVvtzmP
 n+qKEiGH59+iXQYsCUXO5PRfur9aG/ReSL7+rzA5JQ==
X-Google-Smtp-Source: APBJJlGpkhulvcqZYNGYMmRDTdM9ejBw5sSb4NgTln5/jIlZGqIjvaM+XVleW+GIcexVt3kVLDcQk7tFa9Gy6FIIsCk=
X-Received: by 2002:a05:6512:2251:b0:4f8:7568:e948 with SMTP id
 i17-20020a056512225100b004f87568e948mr10749650lfu.51.1689675938949; Tue, 18
 Jul 2023 03:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230717213504.24777-1-philmd@linaro.org>
 <20230717213504.24777-3-philmd@linaro.org>
In-Reply-To: <20230717213504.24777-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2023 11:25:28 +0100
Message-ID: <CAFEAcA8-nMZxDQNw9d9k2fyx2ZVq_7GQUrkijZK3gPxK2yer0Q@mail.gmail.com>
Subject: Re: [PATCH for-8.1 v2 2/2] target/mips: Avoid shift by negative
 number in page_table_walk_refill()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 17 Jul 2023 at 22:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Coverity points out that in page_table_walk_refill() we can shift by
> a negative number, which is undefined behaviour (CID 1452918,
> 1452920, 1452922).  We already catch the negative directory_shift and
> leaf_shift as being a "bail out early" case, but not until we've
> already used them to calculated some offset values.
>
> Move the calculation of the offset values to after we've done the
> "return early if ptew > 1" check.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> [PMD: Check for ptew > 1, use unsigned type]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I think I would expand the commit message a bit, so instead
of the current paragraph 2, something like:

The shifts can be negative only if ptew > 1, so make the
bail-out-early check look directly at that, and only
calculate the shift amounts and the offsets based on them
after we have done that check. This allows
us to simplify the expressions used to calculate the
shift amounts, use an unsigned type, and avoids the
undefined behaviour.


?

Anyway

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

