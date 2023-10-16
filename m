Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E18047CAF16
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQO4-0008Lh-LC; Mon, 16 Oct 2023 12:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQO3-0008LX-Al
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:24:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQNy-00085R-K6
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:24:11 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so8440372a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473445; x=1698078245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/akte+CiF8NMtj2PiHVWNfP6urFYlEiWvzXYLM8C7GE=;
 b=rVNhdE93NSbhtTIJRS06gbq2lwTgHK1rPu9dWcloHXm0s/SYP2NZoQDgwAuB05vX/T
 HGcMBT4TqgNittGzuy6pg0XplDplP5tTX93rlbyu9kDFiqHq7skjBR8KQFFInJ6ARR1p
 RhKZKkoHryScYjsQGFKPDnaN/4BmHmh68OnHjdbG1ltDCew0yNp4TCHQ58PFXHGXv8Uk
 SsKLT/UCTIO7cDnoRU75fewyZESI1zCbccmD6XNrO7f4RZWdErOnpxTEm2Nay/oBu8SN
 9gVjBB7H34OAQR4NMhRgyad5WuUwitthODoL+xGeQ517VioYXQSUOE9ceEHa2ahcT9R+
 vaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473445; x=1698078245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/akte+CiF8NMtj2PiHVWNfP6urFYlEiWvzXYLM8C7GE=;
 b=j2JUfCSb6ho1BXvBJURec2L+i1ZjiKVS5ny+1540lPUC0RaJD+XjHu0xkwaDc4Fuxf
 ljO8S31E1DV/qZiMb3V2ivoi0KZngYZDXiQU06zN4aj1NUz3Soj7uKXZchoIBGCn9XTR
 fV+J08wEu0hB7dFRPLbj8ZSqTP+BXGj7cKm/ZOOofC0YbsvFvvN+qa3irj2gMKq8AF7U
 e4N+mkiCutATRdxOyrB5fPIslp2Jp7ZjfDXye7MJRwtZEvfHmwkasElE5MePP55Ia9Zp
 i3cmsT0SvVNGclZP+i8jAcdChfJJn8Vf9n6+6p2ic04FjdX5zIeX7HRJXubE1xSTr+Pl
 wMfQ==
X-Gm-Message-State: AOJu0YyNwlzxJJ7DFoc92qZQ40p+a4fEu8Bzpt0SMY/qu3yfruUc19Hg
 ruXS6gB+xpKbQHDb+OaI2TfLcyUO77R4v64KbVIYLg==
X-Google-Smtp-Source: AGHT+IHuta93Xf+M1IL90q/dYtdGz4sqs44ib/afWfHu7dhADwMPVXCKkB4N2m+gA0sy0PRIuPRmZT/5aLYjRCamgT0=
X-Received: by 2002:a05:6402:3985:b0:53d:bc68:633a with SMTP id
 fk5-20020a056402398500b0053dbc68633amr16847844edb.5.1697473445111; Mon, 16
 Oct 2023 09:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231012085710.880440-1-mironov@fintech.ru>
In-Reply-To: <20231012085710.880440-1-mironov@fintech.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:23:54 +0100
Message-ID: <CAFEAcA_jD+yQq8fJBY0YUobWMgadrjEPwQs1W10DtZ80Pb2ROw@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: Adding a check for the result of calling
 the CPU information check function
To: Sergey Mironov <mironov@fintech.ru>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 12 Oct 2023 at 09:57, Sergey Mironov <mironov@fintech.ru> wrote:
>
> 6 out of 7 calls to get_arm_cp_reginfo() are checked

This sounds like it's talking about a Coverity warning, though
it doesn't say so. Is that the motivation here ? If so,
it would be good to say so in the commit message. If not,
the commit message should explain why we're making the change.

That particular Coverity warning is quite prone to false
positives, since it's only a heuristic. Sometimes it's
useful to add an assert(), if it helps both Coverity and
human readers, but not always.

assert()s are also most useful if there's a comment that explains
why we can assume the thing they're assuming, as Alex suggests.

> Signed-off-by: Sergey Mironov <mironov@fintech.ru>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 74fbb6e1d7..cffbbaf571 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -198,6 +198,7 @@ static void add_cpreg_to_list(gpointer key, gpointer opaque)
>      uint32_t regidx = (uintptr_t)key;
>      const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
>
> +    assert(ri != NULL);

>      if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
>          cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
>          /* The value array need not be initialized at this point */
> --
> 2.31.1

thanks
-- PMM

