Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7CF80F4C9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 18:42:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD6kW-0005Ua-Is; Tue, 12 Dec 2023 12:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD6kU-0005U8-Dx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:40:50 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD6kS-0004d5-Or
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 12:40:50 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso8480708a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702402847; x=1703007647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vZpKiARdHIYDUgHMhUJ1oqAMwHYO3JtCcG6S2WzVEG0=;
 b=yirdfbOapUhRHwbCTDxp9dnR/bQQlGqAt65IrrXH53F0McbbLuFBAEsTy6vzsB/f9B
 lu25OoOakrvmMIxGgOjg/CqEcUYaK6nDjkG5iDM5J3JzSP3ed+KSO18iSFVBPD1f7f95
 DRUaM2RVvY139WzDxLKUGke8NzLFZS1YZwy0+CUvYZvHQd53cJCxwh1oguibyx3yvkfb
 /YEbtlAR8r3jRWwmKKd7V9+vtfT4N8bNThDI8FNl4BgkLyMz2s7AO/esEcWsQjs37LiI
 Jg1WUUdoc3cmLXBmqrHpeLKyFUiHxSuyZDBMNDR2chkGr/3Ts6CaUy0tKu+QTcOEOvRb
 NBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702402847; x=1703007647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZpKiARdHIYDUgHMhUJ1oqAMwHYO3JtCcG6S2WzVEG0=;
 b=xEecPLnl/7tV3WaH4oc20XxTu3KhPCvBGM9+fAOAckXSQXsgffz0JreIbQv3heB4ag
 NO/36Z/EG+tbzJP1MbG/RgbnF1m2GgN0sJdHPr6Ym6FucXtKMllSEXhblf1axA3Khvdm
 zuGBXD/WLp2fXoqqIz6mHaT20ob6/8JfADUXRrvai1o5Pmf8eeQ20UADQaZ+coCpz8YI
 Gv6Xfpgi6nG0gUJVNyy5lcQo4mt4MQUXXcBJ+6mGyvsathU+Lw+TjYrYwXDoKUU+ZGma
 QZAx01FlcgKLJ2c1u8SOqgwwueeGfmfMVmJU/Fux2UW2pqAm+5EQk2T2L5Ksb2KjU0NV
 8adQ==
X-Gm-Message-State: AOJu0Yz/d9TliPt6aZoT1C++0ok1Jt+nKAQRnGP4eTqKb0uT15mEdvQX
 bgBkeFbNlzHfQWyeknyCVufl4FZnCIAH1y/YBDBINA==
X-Google-Smtp-Source: AGHT+IGaZqy0cMQEfUwytoPCD80pc1YAu4aqBcfNvFUCvidu0SgjFhfPQsKaZJts3xMeVXag6KXm73G+nEb+HR9di0o=
X-Received: by 2002:a50:9e6d:0:b0:54c:b175:87bf with SMTP id
 z100-20020a509e6d000000b0054cb17587bfmr3742460ede.2.1702402846936; Tue, 12
 Dec 2023 09:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
 <20231205095226.2688032-3-sai.pavan.boddu@amd.com>
In-Reply-To: <20231205095226.2688032-3-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 17:40:35 +0000
Message-ID: <CAFEAcA_wLi4A7b3WSbTsd+EgBuTWPL878zQRPqfdgnfKTPVGUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: xlnx-versal-virt: Add machine property ospi-flash
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>,
 saipavanboddu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 5 Dec 2023 at 09:52, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> This property allows users to change flash model on command line as
> below.
>
>    ex: "-M xlnx-versal-virt,ospi-flash=mt35xu02gbba"
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  hw/arm/xlnx-versal-virt.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 537118224f..c57cff74d8 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -49,6 +49,7 @@ struct VersalVirt {
>      struct {
>          bool secure;
>      } cfg;
> +    char *ospi_model;
>  };
>
>  static void fdt_create(VersalVirt *s)
> @@ -637,6 +638,22 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
>                             &error_fatal);
>  }
>
> +static char *versal_get_ospi_model(Object *obj, Error **errp)
> +{
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    return g_strdup(s->ospi_model);
> +}
> +
> +static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
> +{
> +    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
> +
> +    g_free(s->ospi_model);
> +    s->ospi_model = g_strdup(value);
> +}
> +
> +
>  static void versal_virt_init(MachineState *machine)
>  {
>      VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
> @@ -736,7 +753,7 @@ static void versal_virt_init(MachineState *machine)
>
>          spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
>
> -        flash_dev = qdev_new("mt35xu01g");
> +        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
>          if (dinfo) {
>              qdev_prop_set_drive_err(flash_dev, "drive",
>                                      blk_by_legacy_dinfo(dinfo), &error_fatal);

This doesn't do any checking of the string the user passes,
which means the user can make us hit an abort() with a not
terribly helpful error message:

$ ./build/arm-clang/qemu-system-aarch64 -M xlnx-versal-virt,ospi-flash=bang
qemu-system-aarch64: unknown type 'bang'
Aborted (core dumped)

or complain about trying to create an abstract type:
$ ./build/arm-clang/qemu-system-aarch64 -M
xlnx-versal-virt,ospi-flash=m25p80-generic
**
ERROR:../../qom/object.c:525:object_initialize_with_type: assertion
failed: (type->abstract == false)
Bail out! ERROR:../../qom/object.c:525:object_initialize_with_type:
assertion failed: (type->abstract == false)
Aborted (core dumped)

or do some weird stuff if you pass it something that isn't a
flash device type name:

$ ./build/arm-clang/qemu-system-aarch64 -M xlnx-versal-virt,ospi-flash=e1000
Unexpected error in object_property_find_err() at ../../qom/object.c:1330:
qemu-system-aarch64: Property 'e1000.cs' not found
Aborted (core dumped)

I think you need to check that the string corresponds
to a type that actually exists and is a subtype of TYPE_M25P80
and isn't an abstract type.

thanks
-- PMM

