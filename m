Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669473FCDA
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8jT-0006G0-Nn; Tue, 27 Jun 2023 09:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8jQ-0006EA-8X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:27:44 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE8jN-0004gP-Rj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:27:43 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so4302927e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687872460; x=1690464460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rhb34US/1lRYqkodFSuCtYHiQR/FRAfKBgB3zQh1JLM=;
 b=SC2y8OUAU/P7NmBHj05K/obwnrzJztdTLGS37CcE2TZHEVp2ss4GiXvKGa2Z65yxMD
 SU/khviMeUrGr442hstiY/tUtTZBJEbE4BaSq29RfW5kT3+zL0CRTwY4kJR1sAIc8nES
 HQPGtNL8VmhbnbHrSK8h/MuaukVfoMQcsUwk2SgXB38KuAlPLQxECrdAhJccaV5pLxM3
 pyQERu9wj68ilHZc2hOTsxYNZiMrB8nyV8lgF76bK8qbQoF/B/TuIRbz8gNEzvIR7tIN
 fIWKtmD06YrOxBDERVgt1pbAPjpKUpdPPur9QCM8wR3LRBfyIn06b/uarcz0CfsEhiNW
 ov4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687872460; x=1690464460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rhb34US/1lRYqkodFSuCtYHiQR/FRAfKBgB3zQh1JLM=;
 b=WpUsBhdwW+aeicxuGB3rbRxyEWb++S9p8gHoEGjMWELSQPXFj4EdyxwL+6PPh5bL5Y
 65LstlkCaueJEBRPFhf+VpStUFbuSOye/bzTgp41c8U+FHR9EzOT+1ofrIr4EpoLEEiS
 UanUoYdWRtoDbtF9U4YTw4GIgzj625iGM9yOKt+Dmjf5db1YL5WluEj0To4rWmheY+7/
 OYy6GDF7TjiH9eoMNctuILNKTgMzVCB0h4Iu8/6Qm3+h/p4V01uwy1D2HDr/8zMkQSqy
 AlJYXnEfDhNgTy6kFRwaVjSyrRzEsrJ+LwrkkHpdM8sGxo4Rgoc9IB7RROWhFrpi6WkP
 FLbg==
X-Gm-Message-State: AC+VfDzNJd66fAf+zn+PKiz5xjjWHGe+aBvsYDobGds5NaOUWbTPFGAI
 0KrB7r7j/Owx7PsN6iB4cpg4/YBvqHexudeHayiz9w==
X-Google-Smtp-Source: ACHHUZ5R+7F7DZrYhF+O8kc8c1718bNYAXYr0eM11WkGwxjQSlU6iM//9E0p2yavKyYcxhCwEYY6fBz+zEPDBTsOSAc=
X-Received: by 2002:a05:6512:224c:b0:4fa:f79f:85a with SMTP id
 i12-20020a056512224c00b004faf79f085amr4652348lfu.69.1687872459887; Tue, 27
 Jun 2023 06:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
In-Reply-To: <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 14:27:29 +0100
Message-ID: <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Tue, 27 Jun 2023 at 13:52, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> On 2023-06-27 13:12, Peter Maydell wrote:
> > On Mon, 26 Jun 2023 at 08:52, Marcin Juszkiewicz
> > <marcin.juszkiewicz@linaro.org> wrote:
> >>
> >> Add PCI Express information into DeviceTree as part of SBSA-REF
> >> versioning.
> >>
> >> Trusted Firmware will read it and provide to next firmware level.
> >>
> >> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> >> ---
> >>   hw/arm/sbsa-ref.c | 20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> >> index 0639f97dd5..b87d2ee3b2 100644
> >> --- a/hw/arm/sbsa-ref.c
> >> +++ b/hw/arm/sbsa-ref.c
> >> @@ -171,6 +171,25 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> >>       return arm_cpu_mp_affinity(idx, clustersz);
> >>   }
> >>
> >> +static void sbsa_fdt_add_pcie_node(SBSAMachineState *sms)
> >> +{
> >> +    char *nodename;
> >> +
> >> +    nodename = g_strdup_printf("/pcie");
> >> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> >> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].base,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].size,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].base,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].size,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].base,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].size,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base,
> >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size);
> >> +
> >> +    g_free(nodename);
> >
> >
> > Why do we need to do this? The firmware should just
> > know exactly where the PCIE windows are, the same way
> > it knows where the flash, the UART, the RTC etc etc
> > all are in the memory map.
>
> That is not automatically true (it was not for at least one SoC I have
> worked on). In a real system which had these dynamically decided, some
> coprocessor would program the CMN to route these address ranges to
> certain offsets within certain components, and that same coprocessor
> could then provide a mechanism for how TF-A could discover these and
> provide it to later-stage firmware via SiP SMC calls.
>
> Sticking the information in the DT lets us emulate this without actually
> emulating the CMN and the coprocessor, and prototype (and verify) the
> same firmware interfaces for developing i.e. edk2 support.

OK. This is the kind of rationale that needs to be described
in the commit message and comments, though, so it's clear
why the PCI controller is special in this way.

What I'm trying to avoid here is that we start off saying
"the dtb we pass to the firmware is just a convenient format
for passing a tiny amount of information to it" and then
gradually add more and more stuff to it until we've backed
ourselves into "actually it's almost a complete dtb except
it's not compliant with the spec". That means there needs
to be a clear rationale for what is in the dtb versus
what is "the firmware knows what hardware it runs on".

thanks
-- PMM

