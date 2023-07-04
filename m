Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6537472A8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfyt-0004Hg-Qs; Tue, 04 Jul 2023 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfys-0004H2-5R
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:22:10 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGfyp-0007r2-KF
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:22:09 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb7769f15aso8890235e87.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688476925; x=1691068925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p2bayySQ6FpgW3ti56DIy/pwdOCtOffRBdRrh1f2cdE=;
 b=nMgQIVaCuaHER0lYEHjKV/UWu9LT/aRG9MTOB13xhnPgWq+QLVGqyzCl/9lpRphOKj
 fnFw9N/f2v/RJSo2bP8mOO9j/8LeJLLcw1U4YQOB1duFd729WcaVHdFRx1Cm518rtcx4
 pWsPMXyfAv89340PzUgxno3hriOVU3LSpU6DprpfrkrKelkwL/uTt/BMBExxAgPJX49s
 tYLmiGg8MQIlpeoOR1fG1gGV7AnChcKncbSjtkAO6ZySM/2uN67d2SpZjBjWLX/lug17
 HGJVLxLZCYnBPkEZdn012+BJxPQsSaP5+2ua6MfLQ7HsbVgvgik4cmT9+a4JO71E3jUm
 JWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688476925; x=1691068925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2bayySQ6FpgW3ti56DIy/pwdOCtOffRBdRrh1f2cdE=;
 b=IFRt0BGYsbMsqBcDwJeJkt6droOh5kcR/AKe1XNYS9ueK5AzB+1GR7b5vdLMIWvZNq
 gdR4tPuaOVnYWBQGCYWPf4IzZRCVSwU0gkjsLT0ax786isf1FGxfaZzd8N+ej4GGt8B/
 HqUbo178Z6yuDlr/FxWNmOosnfk+EdLMEVfYGWvhz4WPs9ig3uY4eyP3wvhjJcOctgaz
 aFLgmN3K9y7SXdmrHLmY9UKqn2LlzJUre10npL/QzYoP+q+JXq7DwJVMZ/QSMParTJlZ
 rysJAoVN0ngMn+XhXvQMPLvjytiBHpV9diYAVsV1033YRfCxB68fTt9iLvShSrUN4Q5Y
 prYg==
X-Gm-Message-State: ABy/qLa6VSQY2BLHKXtBA+Ri8RmdAtZFdxUwKPr+TIvz5s7S5BZsbyP6
 rszoZmWq7Cqb7q3wB/sNA9JGAX2EfgW083FbbLfuBg==
X-Google-Smtp-Source: APBJJlF6mK/cxfmLiE82iOnMRMZbGR9zenuiMIln302CMPH++sYzPHLfq5MJyQ8TGwPIN2Kos5c7orYB8cvtavbgAlc=
X-Received: by 2002:a05:6512:1595:b0:4f8:56c8:e6b4 with SMTP id
 bp21-20020a056512159500b004f856c8e6b4mr11374253lfb.47.1688476924851; Tue, 04
 Jul 2023 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
 <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
In-Reply-To: <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:21:54 +0100
Message-ID: <CAFEAcA8mk0upQUqXsdm3YXvRjAJc+6npkXAWWLtHS+3A8bMJKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Tue, 27 Jun 2023 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 27 Jun 2023 at 13:52, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
> >
> > On 2023-06-27 13:12, Peter Maydell wrote:
> > > On Mon, 26 Jun 2023 at 08:52, Marcin Juszkiewicz
> > > <marcin.juszkiewicz@linaro.org> wrote:
> > >>
> > >> Add PCI Express information into DeviceTree as part of SBSA-REF
> > >> versioning.
> > >>
> > >> Trusted Firmware will read it and provide to next firmware level.
> > >>
> > >> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> > >> ---
> > >>   hw/arm/sbsa-ref.c | 20 ++++++++++++++++++++
> > >>   1 file changed, 20 insertions(+)
> > >>
> > >> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > >> index 0639f97dd5..b87d2ee3b2 100644
> > >> --- a/hw/arm/sbsa-ref.c
> > >> +++ b/hw/arm/sbsa-ref.c
> > >> @@ -171,6 +171,25 @@ static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
> > >>       return arm_cpu_mp_affinity(idx, clustersz);
> > >>   }
> > >>
> > >> +static void sbsa_fdt_add_pcie_node(SBSAMachineState *sms)
> > >> +{
> > >> +    char *nodename;
> > >> +
> > >> +    nodename = g_strdup_printf("/pcie");
> > >> +    qemu_fdt_add_subnode(sms->fdt, nodename);
> > >> +    qemu_fdt_setprop_sized_cells(sms->fdt, nodename, "reg",
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].base,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_ECAM].size,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].base,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_PIO].size,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].base,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO].size,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base,
> > >> +                                 2, sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size);
> > >> +
> > >> +    g_free(nodename);
> > >
> > >
> > > Why do we need to do this? The firmware should just
> > > know exactly where the PCIE windows are, the same way
> > > it knows where the flash, the UART, the RTC etc etc
> > > all are in the memory map.
> >
> > That is not automatically true (it was not for at least one SoC I have
> > worked on). In a real system which had these dynamically decided, some
> > coprocessor would program the CMN to route these address ranges to
> > certain offsets within certain components, and that same coprocessor
> > could then provide a mechanism for how TF-A could discover these and
> > provide it to later-stage firmware via SiP SMC calls.
> >
> > Sticking the information in the DT lets us emulate this without actually
> > emulating the CMN and the coprocessor, and prototype (and verify) the
> > same firmware interfaces for developing i.e. edk2 support.
>
> OK. This is the kind of rationale that needs to be described
> in the commit message and comments, though, so it's clear
> why the PCI controller is special in this way.

Just to be clear about the status of this patch, I don't
have a problem with the code changes, but it does definitely
need a much clearer commit message to explain why we're changing
the way we handle the PCI controller. So I'm dropping this from
my to-review list on the assumption there will be a v2.

We could also do with expanding the commentary in the source
file to clarify the design approach we're using w.r.t. what
we do and don't want to put into the "dt" blob, but that would
probably be best in a different patch.

thanks
-- PMM

