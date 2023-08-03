Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB976EB2E
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYiD-0007Yb-Iu; Thu, 03 Aug 2023 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYiB-0007YH-Qx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:49:55 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYiA-0006MB-4z
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:49:55 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe1c285690so1672536e87.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691070592; x=1691675392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JwcHRpfpGdnWuxd2TDocBf6Vl+DXlwY57nbEN6moOi4=;
 b=LG7+l8+O5u4OldZj3SYCdyCliQbEV1bX5HYE/IzswHPkvsQUfMy3UPGTxgbmxAZU1n
 TWKLawVSWU9D0aCFIfsozWu/GCm84UMEseyH79HixFVAut6NTlqdIDeZKmRH7rwf0crj
 z83otPrwpvbsoWajp52dDotMMkC0TxdfBq5j/OFij02qEcGJR8YUYXcIHMu8XpYGw0DY
 F4sQmgz/TZCTibac7QxQ1aueUDu6dagvm3iIT2mdMIy+QPM+qu9ybNj1uTCAIU5a64Jv
 qA205AJOCNXoOnTSY0Mdpg/My10mFXai/ocbzDmbhi3PpE3KoVSXZ6d5Lb/C1J/UM8/g
 v9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691070592; x=1691675392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JwcHRpfpGdnWuxd2TDocBf6Vl+DXlwY57nbEN6moOi4=;
 b=flWM7D4QEGRXpTBh1PPDiFyXqq/JrXyx6mIguE1iFlrWJMdgkTSr0qk4N6cIIx/8jM
 aNFLqSgMCpdnY5IagxxoHe7h6KD96sQvgcSPiXmHyxAeYtzAWdWFTVAYfzCNPpbE5Q99
 Dj1Vu7OtBPJoGj5jVrN2GU92BC7sYGrJtKk3SvcgxDqBGhyeX76oQGld2IqwWGzpQ0Nb
 nNw2XlzDfG5w3+OE9P3UJgVn/UPGlQFhqR4F5zTD1ahf+Dr1CvYT4dlZCITEO0xLGZiF
 UXLYU5c3c+3wwruwRrrseh8cELlUP6344KHJDKj2TVcsnnwOS1Bz4htKb2rwPPyBBCZs
 yDGw==
X-Gm-Message-State: ABy/qLbOAPoKRk7wPZZyr40k1KmIMZNJCZG9tbtxeOSXZokGp+fGWmpN
 4o4Ri2CUYZPw64HcFJzij+AXMGrqTp81RQ7ib17QXA==
X-Google-Smtp-Source: APBJJlHOTlAYw6JAJw8bK4giWYlMHa3VaoNSU2LhRsDkrf+EzkqIou0SKJ15DOxB3aE6lLWd7DaOLE1/pSxFkUHOKM8=
X-Received: by 2002:a19:6418:0:b0:4f8:6e6e:4100 with SMTP id
 y24-20020a196418000000b004f86e6e4100mr6889740lfb.52.1691070592099; Thu, 03
 Aug 2023 06:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-5-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-5-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:49:41 +0100
Message-ID: <CAFEAcA_djJndhBL6MvY7BJymYEo_cLx+WrjYpwEz5ayq4d9pjw@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] hw/misc/xlnx-versal-cfu: Introduce a model of
 Xilinx Versal's CFU_SFR
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame Unit's Single
> Frame Read port (CFU_SFR).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/misc/xlnx-versal-cfu.c         | 88 +++++++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cfu.h | 15 ++++++
>  2 files changed, 103 insertions(+)

> +static void cfu_sfr_init(Object *obj)
> +{
> +    XlnxVersalCFUSFR *s = XLNX_VERSAL_CFU_SFR(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem_sfr, obj, &cfu_sfr_ops, s,
> +                          TYPE_XLNX_VERSAL_CFU_SFR, KEYHOLE_STREAM_4K);
> +    sysbus_init_mmio(sbd, &s->iomem_sfr);
> +}
> +
>  static void cfu_fdro_init(Object *obj)
>  {
>      XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
> @@ -380,6 +435,12 @@ static Property cfu_props[] = {
>          DEFINE_PROP_END_OF_LIST(),
>  };
>
> +static Property cfu_sfr_props[] = {
> +        DEFINE_PROP_LINK("cfu", XlnxVersalCFUSFR, cfg.cfu,
> +                         TYPE_XLNX_VERSAL_CFU_APB, XlnxVersalCFUAPB *),
> +        DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static const VMStateDescription vmstate_cfu_apb = {
>      .name = TYPE_XLNX_VERSAL_CFU_APB,
>      .version_id = 1,
> @@ -427,6 +488,16 @@ static const VMStateDescription vmstate_cfu_fdro = {
>      }
>  };
>
> +static const VMStateDescription vmstate_cfu_sfr = {
> +    .name = TYPE_XLNX_VERSAL_CFU_SFR,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFUSFR, 4),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
>  static void cfu_apb_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -445,6 +516,14 @@ static void cfu_fdro_class_init(ObjectClass *klass, void *data)
>      xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
>  }
>
> +static void cfu_sfr_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, cfu_sfr_props);
> +    dc->vmsd = &vmstate_cfu_sfr;

Missing reset again ?

> +}

thanks
-- PMM

