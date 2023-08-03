Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC076EC2C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZ99-0004IV-91; Thu, 03 Aug 2023 10:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qRZ8u-0003z8-3c
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:17:33 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qRZ8r-0002pY-FZ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:17:31 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9cbaee7a9so15963471fa.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1691072246; x=1691677046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OccaV2iCroXm800b878fiRj0SFuQRuhY1XzDYEHNXxI=;
 b=YBXk+DZaqFTGgAu/G+dQWESb3IR0iMmTCshWYksTNETS+mKp13tYHfqHPSLxiGzLzJ
 rp2dAJqmqL3oYrrcMid0xfRRUJSqrfLroJC0kfySYTB7kLkqOA9gE3p6zhKXyjdTBY6P
 ZmY3KPhBBHKnkWV1PRZVYaRGE2CsxLSkuwtUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691072246; x=1691677046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OccaV2iCroXm800b878fiRj0SFuQRuhY1XzDYEHNXxI=;
 b=NmhGbgAfN5TuizRy2F26Ry48JHGUS5l+t//MrRdZVd7nDI0RLBtfLGjRQhbzDXK4FJ
 9PsQSXPrzz1PIF/WWAJx3gIpGlPs2pKEB2cMN9b8Huz2ooC073INElUA1nHCTY7Bg83n
 Q0OeBJ+ZxmbOlSbIcuDNMwVGCEfk4vPkPgiMc6eo0N/jF48CXXMbU3dH0wteE+PG9R05
 9tsH0EM0dYknk9V2WN82bB/NIotEzbIwTQ8gLtzKKKr9P4JNvAYpZc6+r9EctOIbMInI
 SsiWRENfE/dgTiqTWicr19V+/NnMwhgeDRqFgW5uX5LZcUOOrEiEC1zqF6rk5UgOV1ca
 revA==
X-Gm-Message-State: ABy/qLYPy4MVR8G+seOtZ5lkAsnB/+tkxpNALUBcykBbhM6xGEfxn8hy
 wETVWGSesKSuEcvCI6bMu/w/fK4ybCHlBdrjObmBTwPF
X-Google-Smtp-Source: APBJJlHOiodaxew3TdhvohQ46f0K2vQybS2quJwearwsNkkSD/h2qheHteci8paEofSeqrmPXTxD41DoHtz4A5zMiH8=
X-Received: by 2002:a05:651c:232:b0:2b9:d28c:9c30 with SMTP id
 z18-20020a05651c023200b002b9d28c9c30mr7401296ljn.44.1691072246173; Thu, 03
 Aug 2023 07:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
In-Reply-To: <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 3 Aug 2023 14:17:14 +0000
Message-ID: <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
To: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 laurent@vivier.eu, akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x232.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 3 Aug 2023 at 13:55, Helge Deller <deller@gmx.de> wrote:
> > 143551 brk(NULL) = 0x0009b000
> > 143551 brk(0x0009b8fc) = 0x0009b000
>
> I think the problem is the brk with 9b000 here.
> It's not 64k aligned (=pages size of your ppc64le).
>
> Please try with this patch on top of Richard's series:
>
> > @@ -3229,7 +3208,8 @@ static void load_elf_image(const char *image_name, int image_fd,
> >       info->end_code = 0;
> >       info->start_data = -1;
> >       info->end_data = 0;
> > -    info->brk = .....
> change that to become:
>      info->brk = HOST_PAGE_ALIGN(hiaddr);

That stopped the crashing, and the binaries seem to run fine. I tested
on two hosts: ppc64le (64K) and arm64 (16K).

Cheers,

Joel

