Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC121752751
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 17:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJyKq-0006fj-SF; Thu, 13 Jul 2023 11:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJyKf-0006fM-Lu
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:34:19 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJyKd-0003J0-J3
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 11:34:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so4522114a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689262453; x=1691854453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/idHrsINrPZDFxxMttH+pz4uwiOtxdQbw2c5cH0SFds=;
 b=wA9r5RtOwkUoP6cWxK2aESEoe6MjTVutynsmOUWkODHKhlyDQq24ydmp/l1DiKmP5N
 AgQuJrgPz+jdfC2U71dLyPpqkWjGxx5vlxb7PiHwIXQkvU2ca61eI928oCmg/pyTJxRf
 tUkRtsiciHFkIscDZxx1CzV8S05cEmIE98Cthoo8FAmb2jSm6esCNbucwDuWu8thzGbF
 LpDNrzfScp8rIG26k84kcBkJ8sWa0yIAlDtfVmHZi+1KobsZG9Qap1yo7fv92xLwU9Ya
 MTFG4VMXPPKq/uULwjuTWiaxrbU2NSR7WWgoc173eYegA/CurTV+lJiFFI2A+zcQo3Hw
 d+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689262453; x=1691854453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/idHrsINrPZDFxxMttH+pz4uwiOtxdQbw2c5cH0SFds=;
 b=O49O8aYC9JGTNKe7Ibj6SMzZnVRkhfktR7R2WUEtVqR70txmyS0BVuviG6XpXBmZ+F
 pBY0q9EMNTaZ+uyspwPV40OUm5Z5GeLJBYs8sqa2VxZhwH27WSrf29NG6dMwZQLOu+9r
 LuAMryeXYsXXCBQGWGscYzMIDe/R+I0CuvLYIlLYHL4kibP+qQ4YsSWS8EPgCcRTncRW
 BJYGUCp10HO3HDhcJiSpm3Dz9XnLmqaP/8JJ7Fy15D165yjBM2XkvAxVk8pzQOiIGw++
 nPOG383ckYt2D1GelDKfx64OdzydBAz9E8v+7L17sHt0/ICD46u04xqPtokrSCk9uHWj
 8fGw==
X-Gm-Message-State: ABy/qLb0VPAt027Q3aGV14SArJM46XU74VlQI94bQfBVJe6mGqsqhhby
 M8wBpEYnpKgcPaKvS2EbAPDK2vCBC1W8yLSljDQygw==
X-Google-Smtp-Source: APBJJlEsTjt0cc3afsD7L2kNGl/+TxxB7T426cXskItE74TeD4XLdBoAJRS/Xuo0a8j0n27l0GAw/41CMvgEbuXQsVU=
X-Received: by 2002:a05:6402:2695:b0:51e:5bd5:fe7e with SMTP id
 w21-20020a056402269500b0051e5bd5fe7emr6373edd.17.1689262453246; Thu, 13 Jul
 2023 08:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
 <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
 <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
In-Reply-To: <ab339186-1af7-171c-eb11-fe124f12b4a2@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 16:34:02 +0100
Message-ID: <CAFEAcA9nad4H3MgitMyVsZjNZdY-n9d65Yz4Gtbz2wPYA4fbsg@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 13 Jul 2023 at 16:28, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 7/13/23 10:50, Peter Maydell wrote:
> > On Thu, 13 Jul 2023 at 15:18, Stefan Berger <stefanb@linux.ibm.com> wrote:
> >>
> >>
> >>
> >> On 7/12/23 23:51, Joelle van Dyne wrote:
> >>> On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
> >>> the exception is not decoded by hardware and we cannot trap the MMIO
> >>> read. This led to the idea from @agraf to use the same mapping type as
> >>> ROM devices: namely that reads should be seen as memory type and
> >>> writes should trap as MMIO.
>
> >>> +++ b/hw/tpm/tpm_crb.c
> >>> @@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
> >>>        .name = "tpm-crb",
> >>>        .pre_save = tpm_crb_none_pre_save,
> >>>        .fields = (VMStateField[]) {
> >>> -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
> >>
> >> This has to stay here otherwise we cannot restart VMs from saved state once QEMU is upgraded.
> >>
> >> 2023-07-13T14:15:43.997718Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
> >> 2023-07-13T14:15:43.997813Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
> >> 2023-07-13T14:15:43.997841Z qemu-system-x86_64: load of migration failed: Invalid argument
> >
> > More generally, for migration compatibility in the other
> > direction you need to use memory_region_init_rom_device_nomigrate()
> > and make sure you keep migrating the data via this, not
> > via the MemoryRegion.
> >
> > I'm not a super-fan of hacking around the fact that LDP
> > to hardware registers isn't supported in specific device
> > models, though...
>
> What does this mean for this effort here?

Usually we say "fix the guest to not try to access hardware
registers with silly load/store instruction types". The other
option would be "put in a large amount of effort to support
emulating those instructions in QEMU userspace when KVM/HVF/etc
trap and punt them to us". For the last decade or so we have
taken the first of these approaches :-)

thanks
-- PMM

