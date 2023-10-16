Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28D7CAF52
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:31:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQUm-0004Et-TP; Mon, 16 Oct 2023 12:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQUk-0004ED-PV
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:31:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQUj-0001Pn-AU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:31:06 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso1837145a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473863; x=1698078663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fK8Z1KINcqBmmet2bA4w1l6vKCDLUfesYnkmy2gQ4cc=;
 b=Sk9HdzPu9AW6UV0Py02+divzSOyZQ8U//p0FHoAcgXm3yXCsSCIo4O8EgfXAzwdSEc
 519itFY5CQ+ni3JA8uGJfbrc/bt2xLWIyKtOVfiTUmMFwAb+n6b8855b5w+NkQ1A3tyN
 vdvyKTYgyyX+UOOmxSwvM1QQ52KeOWSG/3LqQQnlzac0BNfhBaFf6hBVOaPo7hPhp2cK
 QZahlOB6XT+OvoF+2eQ2GiBxgqKm2ppwwQsvUZ7X9ze3o6t8BN/mFvWAxBCqXgUKenWf
 gPwTdU0Z2/b2PFPPp67BKPMR4laAZq6Yo4wJpXzplnoM+9LN6gmBZCMu5PGpib3xFLQQ
 7K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473863; x=1698078663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fK8Z1KINcqBmmet2bA4w1l6vKCDLUfesYnkmy2gQ4cc=;
 b=oV0MtRUpUBr0yu0wLOJHckDLaSwKIOGCj9WqSWTSZLozH1mvTMZqZSlCr75z9eznaF
 jn5zqLWgHVQ4tC07F0Ek/7w/kiLexAHE0IXHm+TxniEXVXKuGQchvqCvA0IceNr+gdwm
 GwK12bRI0g5QFo7X3NyugrASn61cgiLuU2hOWOPerLRsPKui8jlQUt6h1G1DvyrJytTj
 wSxyZ9MSKX+Pxw698DakV1BpZiPoUWRKsq55bwlhJ8Omfu3TVGkcwoR9kjtaWUg/Y+LR
 YvAAM7tpaL9ADPhDHeIwlNbx6XROP1r2Xb/Yzu1fybvP+X996Lm8FLm0lUr8ui3secY7
 9ckQ==
X-Gm-Message-State: AOJu0YyVODDeY3YdigSKToMFjOlJc2cVHETk70Gklu9iAXpUVKXJrKiX
 mIm4OrHo9dzfjZcubMYA/kNhgSh7uDIIkwz3a6TL4w==
X-Google-Smtp-Source: AGHT+IE9LXhs1xg0/NVQcxyj30krmr2mi5wEy5S5HtiumnG4VecPBiLHggupVbykiwPPvK5tmHNEgI3U5yg26Eh/cFA=
X-Received: by 2002:a05:6402:50c7:b0:53d:ed7a:11f2 with SMTP id
 h7-20020a05640250c700b0053ded7a11f2mr14008388edb.38.1697473863644; Mon, 16
 Oct 2023 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231003052139.199665-1-tong.ho@amd.com>
In-Reply-To: <20231003052139.199665-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:30:52 +0100
Message-ID: <CAFEAcA9Qapo-JuO9ko1nqcAH-ObXOt8wjTvYb00x026S0pvyxQ@mail.gmail.com>
Subject: Re: [PATCH] xlnx-bbram: hw/nvram: Use dot in device type name
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 3 Oct 2023 at 06:21, Tong Ho <tong.ho@amd.com> wrote:
>
> This replaces the comma (,) to dot (.) in the device type name
> so the name can be used with the 'driver=' command line option.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  include/hw/nvram/xlnx-bbram.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

