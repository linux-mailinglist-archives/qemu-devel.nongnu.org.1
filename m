Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E377C79A9D5
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfiyi-0003Vn-Q6; Mon, 11 Sep 2023 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiyg-0003V2-Qo
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:37:30 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfiye-0002mO-Jy
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:37:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so6010079a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694446646; x=1695051446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aGRzY2KyKsenM+dLWLHy9SRONGo4LaQUGS3X8i/Jn80=;
 b=LgYNZwusTq6nXT125dgTp9pehT3kNHGBry+uhAoPjIrzFJ+8Qa0dCJNdRFk1wY95Or
 0+ReAD+j2Uj0HOFfmQCwkrI0xjbE67CNb5aIDVC7peQD0KrIjk0HuUOtow39Lb+96zj1
 nEbtPVXyBNGJz/K+5NZTy0kxvbpFH0/T3BH16JCGjFLrRTl8PUX0Ggb/wjHr8kknzOMB
 2FP8GkJVXZcXi+GWyXF2GArbmLpppbPzSBD4vOJ4Fe9Yd9qawRztVTC90lTZPBvdx7Xb
 pmYd7zl3muTbs5iNBkRhA/5F/eh1VAcU83AFXSPWwWyl+DsHw0ENfCIejNUX3k9yKSrb
 qKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446646; x=1695051446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGRzY2KyKsenM+dLWLHy9SRONGo4LaQUGS3X8i/Jn80=;
 b=riLe8y3l2kb77czMHhFhOUVYc9SNHC9/yAgeANi/Di4hzRUKReo5YXW0TUGt4swccV
 Z9A5tcGJaXR+CWWDPwcGOo+3jTUurQDpjBpmVnh3D8ukzmwEbp8RBafRPnUT0WbUtgun
 nxx2Fig/ZyfuWiCPb69c+yWBtzFVqL+vn8WCVA2poSIHFuc4UzC+k6y+irLX0FdBCvcU
 og4tRyF07WsMguu3J4mUwPOGLrqZZDsoiDxajlMVj8GuLfyUHwQV55Tm/xqoDZ2OaFli
 brhsLUeXYVDyO4Ke3EN3YYLstLS/QgxRPpNWRDwCHfSLQRBpjwV6ccq7SVM/NLCoLvgZ
 yMPA==
X-Gm-Message-State: AOJu0YyO0e8xAl0+nZ0ylJhexYT4Yp1Kk01GrS6gKdheWjtako69FhDf
 Bs7lgVME7VdwZq+MWR15wBahuLvVvREhS6BDiAqGZw==
X-Google-Smtp-Source: AGHT+IEcxbwHn7GNGyVuygxltpHhPi3NT+g5DumhnLQio36fKG+d5IIzocLs9XFTOrdgwep0q915NUeha0mXYpQgQLE=
X-Received: by 2002:a05:6402:510:b0:52c:8a13:2126 with SMTP id
 m16-20020a056402051000b0052c8a132126mr8803356edv.37.1694446646241; Mon, 11
 Sep 2023 08:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230909131258.354675-1-mjt@tls.msk.ru>
 <20230909131258.354675-6-mjt@tls.msk.ru>
In-Reply-To: <20230909131258.354675-6-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:37:15 +0100
Message-ID: <CAFEAcA8Q3x-k_swFaFvkEMhYSAoSnb7ga6ijBhXMBkGYpX-B3Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] hw/pci: spelling fixes
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sat, 9 Sept 2023 at 14:18, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


> @@ -503,7 +503,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>                            &designware_pci_host_msi_ops,
>                            root, "pcie-msi", 0x4);
>      /*
> -     * We initially place MSI interrupt I/O region a adress 0 and
> +     * We initially place MSI interrupt I/O region a address 0 and

"at address 0"

>       * disable it. It'll be later moved to correct offset and enabled
>       * in designware_pcie_root_update_msi_mapping() as a part of
>       * initialization done by guest OS

> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 7c7316bc96..87ba074254 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -177,7 +177,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              acpi_dsdt_add_pci_route_table(dev, cfg->irq);
>
>              /*
> -             * Resources defined for PXBs are composed by the folling parts:
> +             * Resources defined for PXBs are composed by the following parts:

Should be "composed of", while we're editing the line.

>               * 1. The resources the pci-brige/pcie-root-port need.
>               * 2. The resources the devices behind pxb need.
>               */

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

