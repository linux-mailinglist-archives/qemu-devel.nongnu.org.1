Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DB710B3C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29JU-0002EL-FP; Thu, 25 May 2023 07:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q29JR-0002Bn-Io
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:39:21 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q29JP-0003D7-Sp
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:39:21 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-97000a039b2so89701866b.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 04:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685014758; x=1687606758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C7VNf1rb4TufGf0vP2KuXiH0NfhrgahrSq6nimSchmE=;
 b=DdKjQn2eUlxd+yG8GJEkNxQYm4V4NAOoueE0wl1lBorTgurB1oOOb6seSih5EY0/8h
 XX8xWdWIjOqnCP3HyYffniy6A7TzpifZDIMBfQpFz7MHi8CaIiDkBONFQJIFhEY92lSI
 Ea3xwiujN+4UWXjx652KyJIFgQUiG0SM12UnRmeCYwOund62jWcKfoxrAZVLrnxxSy7r
 nVnX2tWrLeAbNiCIhZ2zOI1ZvXrQJvWYi/RntVmxwrBMo2wZezKQaszNir20eONNToM6
 3q88rU1pIzb8VvfsbCEY3tm5O0kMfj8Szb3/CUU3HTJ/u7m0kFxQ+E+TFEPyCzOWt2nS
 WktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685014758; x=1687606758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7VNf1rb4TufGf0vP2KuXiH0NfhrgahrSq6nimSchmE=;
 b=CgsrlqypJchzrMs81lXc9kavZJgmw9CzY5yNFoTo1mpoIoTaWi8N9ry5n7E96iKQYe
 DJkjFD0xgfoQGoHYWNEGS2R14LLus5pWvxuu+I/DpBL6zGCu94QZYejEiBa0dF9s3l8P
 5kpJsqNesmyahLUX+fP79TRL7v0rPId8I7Acrf7PHXwWyOXyXayby3b8Vmc7kOs/2joT
 rsTbHDLeo7BoTkRbGwOOpnXJt6Z271zg3kgfjjq+8xgcfe+SbVHNKKQ0nrgxMg8xn6ZC
 JhkcUEmrtXo9Zt/rdxp+uZhL1I7hvIUwzEusobl8W0uaiQr/OBYrw8rPMiAHKcnZficE
 w/eQ==
X-Gm-Message-State: AC+VfDxIqELuYtAZcytXZFi8jjKRJ5/6YkbOpKG0F3oQ0CheKzzFiMWG
 pMUqsEjDP4JNfNdW6xHv6V+PYeRVaKdYzkiLcvr5eHedOJqupQ/+
X-Google-Smtp-Source: ACHHUZ59zGdGi41XKFMLUJQZsYIoXXAAf1cc/yYL0gkcRmx5YLq5SwniqmHaSunU+dJr5f8SiweExG8BTcbfkqhnLfw=
X-Received: by 2002:a17:906:6a23:b0:973:93d6:189f with SMTP id
 qw35-20020a1709066a2300b0097393d6189fmr1596050ejc.61.1685014758202; Thu, 25
 May 2023 04:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
 <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
 <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
 <e6444d41-62ba-2381-3b26-78e75c2da56e@redhat.com>
 <CAFEAcA-BX6n3YWy+PtSED=Jex9waiez4vxqBK0+Ob3hT-SZmPg@mail.gmail.com>
 <87675164-50ce-a387-12a8-f965b450eb28@ilande.co.uk>
In-Reply-To: <87675164-50ce-a387-12a8-f965b450eb28@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 12:39:07 +0100
Message-ID: <CAFEAcA8O2WF2JjJ5k5L9e6yn1fh8n23cpkAbxuLSkNguaUumWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Huth <thuth@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Thu, 25 May 2023 at 12:06, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 25/05/2023 11:44, Peter Maydell wrote:
>
> > On Thu, 25 May 2023 at 11:32, Thomas Huth <thuth@redhat.com> wrote:
> >
> >> So there needs to be at least some logic dealing with vga_interface_type if
> >> we want to be able to select a different graphics card for this machine.
> >> Then why not go the full way and use pci_vga_init() here, too? ... that's
> >> certainly the least confusing way for the users.
> >
> > Is it? From an Arm perspective, having "-vga" do anything
> > at all is pretty confusing: it's a rather PC-centric option name.
> > (Also pretty noticeable for the Sparc TCX/CG3 framebuffers,
> > which are not VGA in any way.)
>
> Right. From the SPARC perspective it was added to allow the user to select either the
> TCX (default) or CG3 framebuffers from the command line.
>
> However I guess that shouldn't be needed anymore now that mc->default_display exists.
> Presumably there is now some kind of -global sun4m.default_display=cg3 command line
> option that could set the machine default_display property value instead?

Maybe. Handling builtin default devices remains kind of awkward.
But for this Arm board they're all just PCI cards, so the
only thing we really need is a way to say "don't create that
default device"...

-- PMM

