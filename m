Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE357700D5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuYT-0002JW-1q; Fri, 04 Aug 2023 09:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuYP-0002Iv-I0
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:09:17 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRuYN-0001NM-R4
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:09:17 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe28f92d8eso3534526e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691154553; x=1691759353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m1J4aXhtd2ojg8Ya2HLoFacJp/rnIMMlcEtzHdoHPNM=;
 b=VQeHJGTijHnuPadwdDf+Pq9POqOBsjxtx85aq6RYzEJlsmLDrQkpsPA/ZuCFkngSdT
 4cuYJqIXBMjgKUOyYnafE8Ys1tX50Gj+PEXeNlAEecFINoPn4fZzwnbj8VA6t2w3poVA
 6WzxcEunZWbxwRiSN3TSwUKAGDtOzyKprIpXBNoKFMHLqo2i9iNKibL+HDtOEEl86uSl
 GvKhtzmK43zkEr7eCOSvLoFOAf98XBtFuM1PsAvYrNABjJ8UXIgfWd+gn4awkbHByS1p
 fghRhPX4AJ+7gfXKshFoBZFTKLuXRIrJHgEYc3v+Ty2vCqW5HUaQeYhQmZsYSo2T9rGK
 yumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691154553; x=1691759353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1J4aXhtd2ojg8Ya2HLoFacJp/rnIMMlcEtzHdoHPNM=;
 b=LUwZEFoDKlSYTTj8kOcKPQ+nE8k+54WN9daPXRvvnxUVxBbPrkgtZR1tPahgVftzuJ
 BQliVP4MyxE5Ri2C1QBPiYQcUV4Iwom0E+4NjQu5wO9nua3dm+4fbLb4/gahJZ3jl3zr
 7kYcmgVWfXxRHIcC/9/HmOoXXU+ann9MKl5vxsPkHeA/0VmuLLriSqcVfnSliD63bbzX
 DWWrYC6VQWf3iBwCjt+xZ/g0MwL3U6BH0W8ajJ+yj2ox2Qivxh9O7kLDSmEXM0M1WKqV
 XH9tKVd6ygaeIe7YKtQWBcql1cK3IDdXVOpU4xRJ6HqdU8+ruLZ4mnTrijeV7KIruM7C
 P9Tw==
X-Gm-Message-State: AOJu0YyHMfYP0UJiXytWqNHGieHnKG/HQq4Zm7KFs+4sPuWwGwM1Lsy8
 d8DeCFr41FmxfIL6pIyOvVvFU8sh7pnlSC4aiA4Nyg==
X-Google-Smtp-Source: AGHT+IG3EYGynNxSbkdniq6PECGNfydP8i+a4Msca+2E5nfSMJpMFaP3yVgB0N6kjI0fXJYjoj8521SKioKMSsuyXWU=
X-Received: by 2002:ac2:5058:0:b0:4f9:596d:c803 with SMTP id
 a24-20020ac25058000000b004f9596dc803mr1305957lfm.53.1691154553208; Fri, 04
 Aug 2023 06:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-16-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-16-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 14:09:02 +0100
Message-ID: <CAFEAcA9Pab8pOf+B0=pfvUTHx5u8akdj7RNQSgggkMrtptfLCA@mail.gmail.com>
Subject: Re: [PATCH 15/44] Add BCM2838 PCIE host
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Wed, 26 Jul 2023 at 14:46, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_pcie.c         | 232 +++++++++++++++++++++++++++++++++-
>  include/hw/arm/bcm2838_pcie.h |  23 ++++
>  2 files changed, 253 insertions(+), 2 deletions(-)

> +    /*
> +     * The MemoryRegions io_mmio and io_ioport that we pass to
> +     * pci_register_root_bus() are not the same as the MemoryRegions
> +     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
> +     * The difference is in the behavior of accesses to addresses where no PCI
> +     * device has been mapped.
> +     *
> +     * io_mmio and io_ioport are the underlying PCI view of the PCI address
> +     * space, and when a PCI device does a bus master access to a bad address
> +     * this is reported back to it as a transaction failure.
> +     *
> +     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
> +     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
> +     * not mandated properly by the PCI spec but expected by the majority of
> +     * PCI-using guest software, including Linux.
> +     *
> +     * We implement it in the PCIe host controller, by providing the *_window
> +     * MRs, which are containers with io ops that implement the 'background'
> +     * behavior and which hold the real PCI MRs as sub-regions.
> +     */

This comment has been copied from gpex.c, which is an implementation
of a "generic" PCIE controller. Since it's generic, QEMU gets to
decide its behaviour, and since we started with one behaviour and
then changed to a different one we need to provide the property
so that old versioned machine types get the old behaviour.

For the raspi4 PCIe controller, we don't get to decide -- the hardware
will behave in a particular way for accesses to addresses where no PCI
device has been mapped, and we need to follow that.

You should find out whether accesses to unmapped addresses should
cause PCI transaction failures, or read-as-minus-one, and implement
only that behaviour. You don't need to provide a property selecting
between the two.

thanks
-- PMM

