Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F537520B6
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 14:02:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJuzy-00088S-Th; Thu, 13 Jul 2023 08:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuza-00084J-O4
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:00:19 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuzX-0006Io-W5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 08:00:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso1080189e87.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689249606; x=1691841606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pBv/l07OIc6LoGg76LMCmBbXQkjiwRyE1zqqM3sKzvg=;
 b=ZGO+aMVJiQ1ZEdFz6jnnMb184cma38WeGE/lrCGnxKyiqYXeIlpU0gnD5MK1qEIsDu
 heoDbnKZf0+qUnGuvpUWt7imnklzHNT36gNjz1ueSNDAEs/4iCaCjNigHdxX9MtYYn9V
 NvKo73sw96BgOOnImog3QZQ71KcQB6Xxb9RwyhVji4qEieX/FFDxMvjdpVD2lpo1RBVb
 xsezIjttwpmBDscZMbMqbKLjmkhDqx4w6dzs45dkEIrebrhpa4uSLAMBmQJItr1vIs+2
 zs8OE6w1T/lASIHbk2Xqd56e/ypUNDByiUFCT9oThOgqER45X1m4ulKu39xEKxDvtfNj
 Wzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689249606; x=1691841606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pBv/l07OIc6LoGg76LMCmBbXQkjiwRyE1zqqM3sKzvg=;
 b=N36TxLQ8XuGYqyXcTG/b0KvdAQZpC2oy84b+oiYLQKdQ2gwCSHKn5VP1xOSmzAdmtO
 A6P5F4qNUnDihy/LZ+fmZdk+uvEiF3YGcMHA5n4fQsq2ruiXeKh4H5gTSfI0E/cmJRqO
 U9vB7rzGhLduwO9kxR+ikm48ZCOuVanWWvsAMociVU3cYUKwN58xTMca71WfxVOsa6PB
 lOvabOESPnsGLwXML02MEehqFQRSeLE2DMMEpXZhwZX3dGvh/R8LC12fKDS5Gx0MWGXw
 zBhKFmEpx9DCyr2tcMIIidmH22r3nyDLV9o8tcWxgqviNRcTSi6QmpMe4o21DZT2m0M+
 jx5A==
X-Gm-Message-State: ABy/qLZ5yM8mDguREZmUlLSwXvFLRCWpsy90OjOowBRT5GO3Y2JmmtLS
 eRk8kyJBPJZzNW6Pn2TT606EOEKVcTUuv2+uITasiw==
X-Google-Smtp-Source: APBJJlE9LXSkKWdlyO2r9zWJ9jaX5iYW8XDEeU6UBxYvdf/o6rALg7MSGnog9FNxlE8SilrdxgMnpVvbmU7yPeEHx9E=
X-Received: by 2002:a05:6512:20c8:b0:4f9:a232:f09c with SMTP id
 u8-20020a05651220c800b004f9a232f09cmr1025830lfr.63.1689249605929; Thu, 13 Jul
 2023 05:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230713054502.410911-1-gshan@redhat.com>
 <CAFEAcA8197FCwfNZrnxfO-87RveOko0Ju-KcTJOEi0vfjVtDKg@mail.gmail.com>
 <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
In-Reply-To: <2d21e89f-c965-e8f1-3705-dfea8367fc7e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 12:59:55 +0100
Message-ID: <CAFEAcA-XK0U0bPuAf4K7avdJqnmcibFX_swY1Weo_Tn3wHJ1fw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/virt: Use generic CPU invalidation
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 pbonzini@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Thu, 13 Jul 2023 at 12:52, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 13.07.2023 o 13:44, Peter Maydell pisze:
>
> > I see this isn't a change in this patch, but given that
> > what the user specifies is not "cortex-a8-arm-cpu" but
> > "cortex-a8", why do we include the "-arm-cpu" suffix in
> > the error messages? It's not valid syntax to say
> > "-cpu cortex-a8-arm-cpu", so it's a bit misleading...
>
> Internally those cpu names are "max-{TYPE_ARM_CPU}" and similar for
> other architectures.

Yes; my question is "why are we not using the user-facing
string rather than the internal type name?".

-- PMM

