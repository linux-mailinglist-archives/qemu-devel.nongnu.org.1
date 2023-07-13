Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE075258F
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 16:52:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJxeR-000763-7b; Thu, 13 Jul 2023 10:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJxeP-00075Z-JH
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 10:50:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJxeN-000416-3G
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 10:50:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51e48e1f6d1so972426a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689259833; x=1691851833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HqvOfHSUXfXxD3DGnvhEkd+icv72LDbnNffRWuBk30k=;
 b=aNpqIVV9BVYAAR08H5dbqSiwocFQsWOBsgu1wujCrkLgU0uYAJD8/lWIb8wYyKKrlw
 rXWpfFAGHALBpu6tGL0wLMzK/sUXMdmsUTrP2CdBXX/dmimzR4D/XrAYbvSLvxJ54Zuh
 ZfCB9+Y1QHLxco43OIZNP5++LHIkQfwEZxdTGLrlNP8NMXiLgbwPSdYdZvNabNDBHCuU
 Wbx7JwW8F0/r38j6nHsegRbzqPtOZBOvQhxro6IxP48s+R8fKamsBrHPnoYYixcjJgvI
 v7SwgbpulmkQTCpmuhLtCvPQQErxQAo0HN+RT+48I+kkl9n0hinljiGzVK8LSwFbOwAy
 fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689259833; x=1691851833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqvOfHSUXfXxD3DGnvhEkd+icv72LDbnNffRWuBk30k=;
 b=NDl8bn1xfIq3/U3m/sV9B/YOH8i/fvmVwYSbNNKZpV5x0AoPJc7S6Q061cy0y/0ABQ
 2DsL+AA0bZZu3KQe54Ty9Eb/tryDops1NtGl+VDn/l+z+gnxuC61kwC6j8XGh96BToEh
 kYvczQV73F8QU/lz5gNAPJUOM5kjJlWW3dphlvsXr54cFdFhSHQsE74fY3wLLCpNk0Lq
 YHmX2FNrfp8AxnDbIihkXK8vk9kzKV3UMnEnEnkDoye2SZ4za2QggEHv2Ik08lzJ2o7b
 mM5Ajr+YFryKE+Dv88MDN63ZJxkmV9jVJE0TrVki9VJLeCDXRicFBhFWHx/acSQY6BE8
 QFUA==
X-Gm-Message-State: ABy/qLa6JbZWzpJ8nyKDTv2e+NBg9U+lBY4QXbRhkSOItYbMOjJbY1Cw
 7yK0G/B1bRts688JXrs0yJGXAJI/Z7CcilPNQJL9LQ==
X-Google-Smtp-Source: APBJJlH7grKoixiQIkoOIk2+Ho3ZfoBa1RuTvHc4KtAZfg+n+rZXCoZfzTm7Grq7EBRQ3R11U6ba/aAho9JfwdgPoPs=
X-Received: by 2002:aa7:d9d3:0:b0:51a:7bcf:c8f5 with SMTP id
 v19-20020aa7d9d3000000b0051a7bcfc8f5mr1796429eds.1.1689259833444; Thu, 13 Jul
 2023 07:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-5-j@getutm.app>
 <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
In-Reply-To: <4a49285e-0d91-93a0-2f8e-e76c71ed89f8@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 15:50:22 +0100
Message-ID: <CAFEAcA-r_VOc18-jm99asYQQk4TJMBW_7oJMzFQofEHqVdF50A@mail.gmail.com>
Subject: Re: [PATCH 04/11] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 13 Jul 2023 at 15:18, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
>
> On 7/12/23 23:51, Joelle van Dyne wrote:
> > On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
> > the exception is not decoded by hardware and we cannot trap the MMIO
> > read. This led to the idea from @agraf to use the same mapping type as
> > ROM devices: namely that reads should be seen as memory type and
> > writes should trap as MMIO.

These are hardware registers, right? Windows shouldn't
really be doing LDP to those if it expects to be able to run
in a VM...

> > Once that was done, the second memory mapping of the command buffer
> > region was redundent and was removed.
> >
> > A note about the removal of the read trap for `CRB_LOC_STATE`:
> > The only usage was to return the most up-to-date value for
> > `tpmEstablished`. However, `tpmEstablished` is only set when a
> > TPM2_HashStart operation is called which only exists for locality 4.
> > Indeed, the comment for the write handler of `CRB_LOC_CTRL` makes the
> > same argument for why it is not calling the backend to reset the
> > `tpmEstablished` bit. As this bit is unused, we do not need to worry
> > about updating it for reads.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   hw/tpm/tpm_crb.h        |   2 -
> >   hw/tpm/tpm_crb.c        |   3 -
> >   hw/tpm/tpm_crb_common.c | 124 ++++++++++++++++++++--------------------
> >   3 files changed, 63 insertions(+), 66 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> > index da3a0cf256..7cdd37335f 100644
> > --- a/hw/tpm/tpm_crb.h
> > +++ b/hw/tpm/tpm_crb.h
> > @@ -26,9 +26,7 @@
> >   typedef struct TPMCRBState {
> >       TPMBackend *tpmbe;
> >       TPMBackendCmd cmd;
> > -    uint32_t regs[TPM_CRB_R_MAX];
> >       MemoryRegion mmio;
> > -    MemoryRegion cmdmem;
> >
> >       size_t be_buffer_size;
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 598c3e0161..07c6868d8d 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -68,7 +68,6 @@ static const VMStateDescription vmstate_tpm_crb_none = {
> >       .name = "tpm-crb",
> >       .pre_save = tpm_crb_none_pre_save,
> >       .fields = (VMStateField[]) {
> > -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
>
> This has to stay here otherwise we cannot restart VMs from saved state once QEMU is upgraded.
>
> 2023-07-13T14:15:43.997718Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
> 2023-07-13T14:15:43.997813Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
> 2023-07-13T14:15:43.997841Z qemu-system-x86_64: load of migration failed: Invalid argument

More generally, for migration compatibility in the other
direction you need to use memory_region_init_rom_device_nomigrate()
and make sure you keep migrating the data via this, not
via the MemoryRegion.

I'm not a super-fan of hacking around the fact that LDP
to hardware registers isn't supported in specific device
models, though...

thanks
-- PMM

