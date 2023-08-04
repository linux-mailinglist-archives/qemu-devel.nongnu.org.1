Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80222770416
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:10:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwR1-0002Ut-U0; Fri, 04 Aug 2023 11:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwQz-0002UX-0n
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:09:45 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwQx-000690-FI
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:09:44 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5222bc916acso2810192a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691161781; x=1691766581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+cEEtL2itPWygNoL5V84W8YKVevCh1MXGAy3BM4/ds=;
 b=Kw88Yzg9uLt9i0e24KgwIyfctm7E0UJmT3BMH+IKadfDbJIu/pBgLAD/ZkEeiEu3X7
 SLFtoDVabAfqO+PUAObRxpem/tIOL0l+0eLmyNY4RVN2RFjeACXz9C4vBRls7a29nk7x
 bvv/H+tnxZ0PpfOFBCWoiL+mk0eOYUkeYSECoUIsauWFOROJGxGB4Nsfu32XfSw8bQL8
 DPHgnV19Ig2FzXkUeqftdDeqpj1Fr82F8yvk9J3Vgq6rVbNFicb0/7hLQd+iV/3tG2rK
 k8dUWkfkrCizxoY3QjOmpnWH9JvCcZggiJYZ1CwsR3X+euFfXCRq2DP+jwuZVxd4oPtA
 g/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691161781; x=1691766581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+cEEtL2itPWygNoL5V84W8YKVevCh1MXGAy3BM4/ds=;
 b=E1mApWVe5ZcMcLm7tBFLTFSbxkDkPT7NoURbpQZ4DBVozik/GIYKQzYdsv55glwMX+
 mSjMxFVhVVmSOIKHVudzIn+q+nE/7Fm+KzH0er05Mm08JjVyJ6A8OG2Ke7WNNK9PijZG
 iymgxs4QXOsGyED4ia/JuENiH/RHGYTLbdILiphXrYKQsFBvU3mAel2u1NskcBDeIy1b
 jsWWEPTFUc2/pTNyaDjc8Uh8vNY9aXf/FRyYKsR8bIkyut50eFpWlTyeSn2F9Pe8gt89
 q5mN7NQxGDtcF6AXvg1TebecIyD24XpS9g7ze48/I8sKPfNrt021ydy35udH9ebSxdwM
 mglA==
X-Gm-Message-State: AOJu0Yx0z0frNYtuG9DFGuMRPGs7UWqFwE6WLveGFcku+q7/OWbp5DD9
 K92lTDchosvizNWMoGgF4HKKElZbEfbW/NEvStqBZA==
X-Google-Smtp-Source: AGHT+IEpvVc6OpeYlW6CTAGqnHyKzFXvqWQyZW0scvQELvrrpCm+9MkBwTf22kWcJvkKUFhN5Yf1apsoA7ltz8Xrdvg=
X-Received: by 2002:a50:ff1a:0:b0:523:1fa2:4f40 with SMTP id
 a26-20020a50ff1a000000b005231fa24f40mr1130761edu.19.1691161781035; Fri, 04
 Aug 2023 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <CAFEAcA_xyq3KjKVkrbtGktbS5OySZU2Q-gh_qqzv_iqnnDbQqQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_xyq3KjKVkrbtGktbS5OySZU2Q-gh_qqzv_iqnnDbQqQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 16:09:30 +0100
Message-ID: <CAFEAcA9XfkPtqdfGANXy9xAdxgTbeUTRAZVMGhuhLhwqH-x7Qg@mail.gmail.com>
Subject: Re: [PATCH 00/44] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 4 Aug 2023 at 13:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 26 Jul 2023 at 14:56, Sergey Kambalin <serg.oker@gmail.com> wrote:
> >
> > Introducing Raspberry Pi 4B model.
> > It contains new BCM2838 SoC, PCIE subsystem,
> > RNG200, Thermal sensor and Genet network controller.
> >
> > It can work with recent linux kernels 6.x.x.
> > Two avocado tests was added to check that.
> >
> > Unit tests has been made as read/write operations
> > via mailbox properties.
> >
> > Genet integration test is under development.
> >
> > Every single commit
> > 1) builds without errors
> > 2) passes regression tests
> > 3) passes style check*
> > *the only exception is bcm2838-mbox-property-test.c file
> > containing heavy macros usage which cause a lot of
> > false-positives of checkpatch.pl.
> >
> > I did my best to keep the commits less than 200 changes,
> > but had to make some of them a bit more in order to
> > keep their integrity.
>
> Thanks for doing this -- I really like the way the split
> has turned out, and the overall structure of the patchseries
> is good. I'm going through the patches individually
> (which will probably take me into next week to finish)
> but I'm not seeing anything major, just some smaller
> issues.

I got through the second half of the patchset faster
than I expected, so I'm now done with my first pass
review of it. Please let me know if you have any
questions about my comments/suggestions on the
individual patches.

-- PMM

