Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17157779169
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSnT-0007jl-Vb; Fri, 11 Aug 2023 10:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUSnJ-0007j5-8k
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:07:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUSnH-0006z7-OR
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:07:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52364e9daceso2593163a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691762830; x=1692367630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7bFbX07yuBBUa5uASnwWdoa6sYiAjx93TaQjSh4YIE=;
 b=IQKCVtmzNx6rQrukzGiTiIBfBH6QZCN7WSa6zPnV9SAVQA3MzJW/3KrkR3oIo9RRhK
 j/Y3Z5jQspsZhsRRw4nOqoMmJ2OuR3ZzHGSjWEjKEN3NMqr2domJn76LIE1ucmN7MMN6
 w07Y7lGvYJBzjvu9ct2DMPN/pR+ZY5xNIBzVmJ0kIL2OEXiNpG44xoror5/16t09mFA/
 zeraHCfxWcZJPK15LCGcHOKdb6sw9Cm+fm197gwiwBamriiqLiosXa7FdUlDbn8gUGx7
 RpuLsGv0KZ1nFes87/Bds8sXCJ2AL+WnQLSFproTWvnejYT/OrIfSkUvDXfff3Jtz5dd
 cvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691762830; x=1692367630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7bFbX07yuBBUa5uASnwWdoa6sYiAjx93TaQjSh4YIE=;
 b=ZuL2WV+tXbcyg9vS6YdogQj8WhMS1Y3JQMF3uL11hWoWk2zwJ2I/UK7VvrwuOl1nB5
 iT0e/WHic0FEHdRWl0uMbMl10xLmTcsUXKGL1F7w5yvifiaFp8sLLnyDiuEmc606hhaB
 PxnW21wl8CO7X9bVTx7jdlH8IJbI/umf+D7VSa5AqUWcNRyE1xAzyHoFcaozWdvlInTQ
 HUz6l8wzL4ZQEcwThn6M2SfJaL+qftwHpMP9fcThHkcKnlIFCrPH7WMwBMyC1wHKQSBP
 byTrlCTnfkzuTGAeFF+RMEulzphZ6WHIM9GMDkx3NdCja+NZ9zAh7rEir1Vze+Ghl/yh
 raFA==
X-Gm-Message-State: AOJu0Yy1sMubA74sdZpEnMI9HFXzjgHH4WQuJu9tv2aWDX/R5bJB6tBC
 4RuyHOt8enZ4ewW3L23rfzw2D2+clGdLmlGLzn/iMw==
X-Google-Smtp-Source: AGHT+IFiyeP/ZkgFTxAL4bkOACJPV96sNR7bmQDloXzjTkvcOtpyrPdYLzQJHlh/12YphOmC/gn213+jJVj2USfjQiQ=
X-Received: by 2002:aa7:d357:0:b0:51f:f1a4:edc6 with SMTP id
 m23-20020aa7d357000000b0051ff1a4edc6mr1858217edr.37.1691762829896; Fri, 11
 Aug 2023 07:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230809102257.25121-1-jason.chien@sifive.com>
 <20230810135050-mutt-send-email-mst@kernel.org>
 <CAFEAcA_B5W5CX7-C_a7iWTL87kpcLsGEjAsqs5t54sgjTKi3Eg@mail.gmail.com>
In-Reply-To: <CAFEAcA_B5W5CX7-C_a7iWTL87kpcLsGEjAsqs5t54sgjTKi3Eg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 15:06:58 +0100
Message-ID: <CAFEAcA8vr-Bk+tPvugTH4DwAk=S_RXiUhrqDytFGg-EyoC9Mmg@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host: Allow extended config space access for
 Designware PCIe host
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Fri, 11 Aug 2023 at 10:55, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 10 Aug 2023 at 18:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Aug 09, 2023 at 10:22:50AM +0000, Jason Chien wrote:
> > > In pcie_bus_realize(), a root bus is realized as a PCIe bus and a non-root
> > > bus is realized as a PCIe bus if its parent bus is a PCIe bus. However,
> > > the child bus "dw-pcie" is realized before the parent bus "pcie" which is
> > > the root PCIe bus. Thus, the extended configuration space is not accessible
> > > on "dw-pcie". The issue can be resolved by adding the
> > > PCI_BUS_EXTENDED_CONFIG_SPACE flag to "pcie" before "dw-pcie" is realized.
> > >
> > > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> >
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > I'm not planning another pull before release, hopefully
> > another maintainer can pick it up? Peter?
>
> At the moment I don't have anything intended for 8.1 either,
> so whoever of us does it it would be a 1-patch pullreq...

Also, at this stage in the release cycle it's always worth
asking: is this a regression, or was this bug also in 8.0?

thanks
-- PMM

