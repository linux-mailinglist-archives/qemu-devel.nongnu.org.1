Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AC78E9E4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbeWh-0008Cy-B5; Thu, 31 Aug 2023 06:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbeWf-0008Cd-Gy
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:03:45 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbeWc-00036p-UW
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:03:45 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff09632194so1260012e87.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693476221; x=1694081021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hB33pLaPpLvvdt+D2fH747Y5XKVfL/40nfO6Hfng3FQ=;
 b=y4jT+9NTgBBLV/1S8KpI4D9Z83yrWJgum73yJCkluyA7tTUUFaz6nWlUEvoI7BxXay
 Q0LfWGATGSt7iQSFCwQ2I/mjB9kx9poR8++rqCqKmgjeKJWIT9HbggRIG8tay5Qdud9P
 eZw3Xh9Zu/URN0hhORwDjO4nJE9FMPEREwmdSROgM4j/vMe0IdxaBVGK5qe9vo3F1Mvz
 VKvbchNM5vqaG2m35MwcIHuCj+J1S6wC6vPGe4hjnPv4753I1EbDZnzOfv7AqNvYt3Sz
 cvNKdiaHZXpXvtU6AZQ+X8etX9Mk2kqW0rqnYQC8SZRgny3CAVObLDKGos5fEg5ZQPtS
 /ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693476221; x=1694081021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hB33pLaPpLvvdt+D2fH747Y5XKVfL/40nfO6Hfng3FQ=;
 b=GFkc8dz66i4zwko/LCCCcUvjhLOM3FLgzFjDbosuZE0iBnughMW5EXiM7MkENcS30w
 dsqy/7+2aykttCIBLMyF6VE7pt47WG8use7p7rfsC6dNdz9HdFzeqNiFMXHS2neOlN1+
 neHluB3nly1SwvFXiaJCBUsmxMMiH5vO6kkWCdEvQOmFBFomh3SKZrUww7WdIL2wg+3t
 s+VFKRZuiLAF/GZfKwGAx6sT9G2MjHay/73pQYP1oxR8/EKxdSj/CAhn0oII5iNqXmpd
 KCJE/QPn9ZZvR/lAVW7S3dsCQ5Zaj5goxHiZ7xPduP0qamQ2H74CkI7i3A7CzDwzLHD2
 VobQ==
X-Gm-Message-State: AOJu0YxZyHZ1QqQwk/fT2NoiFa3CIrQo1j546/FhO4ZAy2Pk7f6z+ztv
 UGC7xblrVO/VgiIroQzbnwouVXJrvDCPzoXZLjDFvA==
X-Google-Smtp-Source: AGHT+IFX/1mT0xBVolLvtKiip3l9RctqLyhOc8k7b+Kx7yXW6Ml6LFMZECJTcU1bzt/3GOP5hwm7DtZPrPFwphsqjfg=
X-Received: by 2002:a19:6914:0:b0:500:b890:fb38 with SMTP id
 e20-20020a196914000000b00500b890fb38mr3118822lfc.24.1693476220885; Thu, 31
 Aug 2023 03:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <87y1hspiyh.fsf@linaro.org>
 <alpine.DEB.2.22.394.2308301745530.6458@ubuntu-linux-20-04-desktop>
 <CAFEAcA8Ziov9vA9dW+4vzFE=KkSUqfMNNMZOtvQhqCXyjRytzQ@mail.gmail.com>
 <87cyz3pmgz.fsf@linaro.org>
In-Reply-To: <87cyz3pmgz.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2023 11:03:29 +0100
Message-ID: <CAFEAcA-m8G1kfTw52kOGPEvQwWPph0NWc0URVY1aQ2WwVeB_OQ@mail.gmail.com>
Subject: Re: QEMU features useful for Xen development?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Thu, 31 Aug 2023 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 31 Aug 2023 at 01:57, Stefano Stabellini <sstabellini@kernel.or=
g> wrote:
> >> As Xen is gaining R52 and R82 support, it would be great to be able to
> >> use QEMU for development and testing there as well, but I don't think
> >> QEMU can emulate EL2 properly for the Cortex-R architecture. We would
> >> need EL2 support in the GIC/timer for R52/R82 as well.
> >
> > We do actually have a Cortex-R52 model which at least in theory
> > should include EL2 support, though as usual with newer QEMU
> > stuff it quite likely has lurking bugs; I'm not sure how much
> > testing it's had. Also there is currently no board model which
> > will work with the Cortex-R52 so it's a bit tricky to use in practice.
> > (What sort of board model would Xen want to use it with?)
>
> We already model a bunch of the mps2/mps3 images so I'm assuming adding
> the mps3-an536 would be a fairly simple step to do (mps2tz.c is mostly
> tweaking config values). The question is would it be a useful target for
> Xen?

All our MPS2/MPS3 boards are M-profile. That means we have the
device models for all the interesting devices on the board, but
it would be simpler to write the an536 board model separately.
(In particular, the M-profile boards are wrappers around an
"ARMSSE" sort-of-like-an-SoC component; there's no equivalent
for the Cortex-R52.)

>   https://developer.arm.com/documentation/dai0536/latest/
>
> > The Cortex-R82 would be more work, because (unlike the R52) it's
> > AArch64, and we don't have Armv8-R AArch64 support yet, only the AArch3=
2.
> >
> > I haven't looked at whether GIC on R-profile requires any changes
> > from the A-profile GIC; on A-profile obviously we emulate the
> > virtualization support already.
> >
> >> On Cortex-As, in addition to a PCI root complex and an arbitrary PCI
> >> device, SMMUv3 emulation (both stages) and GICv3 ITS are needed to be
> >> able to test PCI Passthrough.
>
> We have ITS emulation support and it was recently plumbed into the
> "sbsa-ref" board as it is needed for higher level SBSA compliance.
>
> >> However, if I recall correctly SMMUv3
> >> emulation in QEMU might not be complete enough to enable us to use it.
> >
> > Yeah, at the moment the SMMU emulation supports stage 1 and stage 2,
> > but not both at the same time. This is good enough for PCI passthrough
> > with a Linux guest using KVM to pass a device through to a nested
> > Linux guest.
>
> Is this a missing feature for SMMUv3 or something introduced in the
> later revisions?

It's a missing feature. The SMMUv3 spec allows an implementation
to implement stage 1, stage 2 or both. We started with just a
stage-1-only implementation because Linux doesn't need any more.
Stage-2-only just landed recently. Nobody's looked at both-stages yet.

thanks
-- PMM

