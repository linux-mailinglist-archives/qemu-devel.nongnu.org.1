Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25D78E900
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 11:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdZQ-00041T-Jm; Thu, 31 Aug 2023 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbdZH-000401-4d
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:02:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbdZD-00078c-2v
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 05:02:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so3728610a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693472537; x=1694077337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Atyf6it5YtTHtQpEthOf92yCe1kN0bIRTc86uhn4tmQ=;
 b=O3zFyCgeVeesv8jpefQWCI8A5sMAaga5kNJqLyVUEOKLTZHXpC9LR1Di0z+nq8xEmR
 BNwawC/Cz0S9fotDL5+F7dkXI+17GlvJ+a+cXt34TpMiIGBvZrosaIKD1iEOMO01YWXM
 sTo5jJbdA/QaucMITxNN0JDW0njD8S82yqSWc5/x8IQEyg2wBYm/sishYqEGm2ZReuGo
 0k0L013FnFB9NCrVbehH0RCLmHnX5B+Pmf4//KCT7Ud/2knkqWN5w3mUiLnXFjGkI1Lb
 INwZkfskXZUGOen12FwLGr3KV5kB06SKo89rqrmXlT5HRoM+QNAFL1QBleFskTB0/EhN
 ZyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693472537; x=1694077337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Atyf6it5YtTHtQpEthOf92yCe1kN0bIRTc86uhn4tmQ=;
 b=VQXeONe+KNWvBLHKv9erSrvu6sQaQJnTaxJLDc94Ol7uZ79lWePvbwBO0I+AmsGIbu
 dHIqNWf/XvsuRhzQWTVDgYEGBaTePvL7Qr7gP2mlMbekbhE3jrRH2NpGIbzhmUrQg+rL
 HghV8oWqeXB2L8MESp5C7GhQZQkUPPopKVUINqgds3L2OxObPVVMH8Xw/MBRW2F9njr+
 FgEX7aoVyfslHnrPaR1stNIYH2CZ8IEDbfuo+I2I6Nz4CB1TGJahKvzq5hjMiFWo7QSn
 dQwdGtTWCTpuYx0GZYrKGk7pecTksezzcRu2Xq+mnyUmF94rOUZ26N2HlKgE/SMcTqHS
 ZdOQ==
X-Gm-Message-State: AOJu0Yw4o+8dGi+pLny2qCKTnH1N4H+O9hQJIP1GO1pDjB3r3iDnVWdt
 lAiklVpzWiOA2gK7Nj5jAheTDnAyhq26Hm1HtKP3Zw==
X-Google-Smtp-Source: AGHT+IHH1trT8CB6FUUesTFvCdiHDmP2HufMXaFwZaE7USD+5Yv3A6Eqg7vtSm4Ex/4bcUEQO9Z9HXrKqi70Hc8SW/s=
X-Received: by 2002:a17:906:7311:b0:9a5:b66a:436d with SMTP id
 di17-20020a170906731100b009a5b66a436dmr2517451ejc.14.1693472537161; Thu, 31
 Aug 2023 02:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2023 10:02:06 +0100
Message-ID: <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
Subject: Re: QEMU features useful for Xen development?
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Xen-devel <xen-devel@lists.xenproject.org>, 
 Stewart Hildebrand <stewart.hildebrand@amd.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 Sergiy Kibrik <Sergiy_Kibrik@epam.com>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
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

On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.org> wrote:
> As Xen is gaining R52 and R82 support, it would be great to be able to
> use QEMU for development and testing there as well, but I don't think
> QEMU can emulate EL2 properly for the Cortex-R architecture. We would
> need EL2 support in the GIC/timer for R52/R82 as well.

We do actually have a Cortex-R52 model which at least in theory
should include EL2 support, though as usual with newer QEMU
stuff it quite likely has lurking bugs; I'm not sure how much
testing it's had. Also there is currently no board model which
will work with the Cortex-R52 so it's a bit tricky to use in practice.
(What sort of board model would Xen want to use it with?)

The Cortex-R82 would be more work, because (unlike the R52) it's
AArch64, and we don't have Armv8-R AArch64 support yet, only the AArch32.

I haven't looked at whether GIC on R-profile requires any changes
from the A-profile GIC; on A-profile obviously we emulate the
virtualization support already.

> On Cortex-As, in addition to a PCI root complex and an arbitrary PCI
> device, SMMUv3 emulation (both stages) and GICv3 ITS are needed to be
> able to test PCI Passthrough. However, if I recall correctly SMMUv3
> emulation in QEMU might not be complete enough to enable us to use it.

Yeah, at the moment the SMMU emulation supports stage 1 and stage 2,
but not both at the same time. This is good enough for PCI passthrough
with a Linux guest using KVM to pass a device through to a nested
Linux guest.

thanks
-- PMM

