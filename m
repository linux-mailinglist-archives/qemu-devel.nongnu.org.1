Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF16816A45
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 10:55:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFAKX-0005oJ-TT; Mon, 18 Dec 2023 04:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFAKV-0005nu-Ol
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:54:31 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFAKK-0007hn-CS
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 04:54:31 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cc2238f597so29767721fa.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702893258; x=1703498058; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22XHa7TU2HAZhqIoLxu+1GCExXKqhDp67R/omYu6sKM=;
 b=FxsHh5TB6MwlX6x2NhiwLPK8Z/tcBdjX3/YtmS9R2awy/v28fFwMsVJMBMnnVS3Z+X
 RpBsWQFRBEzuzTDqoS4GUpggBhcpHWDagNgd5UwPS81TQqk2NU8D4CmkcUqNhyo/4En9
 mp6iEDli3R+yOnPT9pzZlZWKxLgmj6lJ3QrRBvp0VSiDcEcG50Z8N6hCZKWj/7ylaWw4
 h9PqYo6uazYv6eJHEPxyzF7Go7mL0egMoZ37TEo5zXkllORiIdyHlwy92D96l1PzCLzA
 7ymhvavDqs6KiGjtUtRKUypA+j0sXUZaxXmFZvMRKVEWRJFgndrgqYtO20tMaIOeUAvN
 xkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702893258; x=1703498058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=22XHa7TU2HAZhqIoLxu+1GCExXKqhDp67R/omYu6sKM=;
 b=VL5mt64rPjL/uvG+cIrL2QeIo8T0FtNM6SKngozj8qWXdueAmLApgpC9lZwkVAMVRs
 fvlgcD7mvw5oRKnMweMaiPUySaVkwoQRbs7si+QwlX3ent0m5lVAJZRWyr6aEwu2cjGT
 wx0ZiV9n543sdviaIvGi0UAay4eDNMZhGLkdUT56vkMulWiKQ9z8v3cuk8jFdUm6X0kp
 603G4kWjLo8nqRgrTMq3efWDKc+paEWl+gukbsbtpGne/ZE4w4nxH779O4JZHe1pZRdb
 K6B96fs1+cYiMoTFof8gZZf8KXGMV3iZVy8EQYgonyfTD5qL2xDMv6EimqoswdJwrxOb
 ztqw==
X-Gm-Message-State: AOJu0YzapRFCxO3xhFrSL4/xlsL5bYfh0PEXArBd2kqBccF4W+q2Qyvx
 9bpp0+i4NVnQvbf/aaPk+WCyVv/JIBAYKFjLdqziQg==
X-Google-Smtp-Source: AGHT+IG8OYz2pq+QHf1MF7BM0rOkxLAelM2wX2KQDjadCOgPquG+JTMBma3kcPkXa0doXhtS2mks+vCRtXDZtTwFiE0=
X-Received: by 2002:a2e:8608:0:b0:2cc:652b:9fd4 with SMTP id
 a8-20020a2e8608000000b002cc652b9fd4mr450177lji.79.1702893258257; Mon, 18 Dec
 2023 01:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20231214171447.44025-1-philmd@linaro.org>
In-Reply-To: <20231214171447.44025-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 09:54:07 +0000
Message-ID: <CAFEAcA8fmzv6qkN=N9TZoYVox+uQ0m5iLkGPQpcRDVA8eDEujg@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm: Prefer arm_feature() over
 object_property_find()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Thu, 14 Dec 2023 at 17:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> QOM properties are added on the ARM vCPU object when a
> feature is present. Rather than checking the property
> is present, check the feature.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: If there is no objection on this patch, I can split
>      as a per-feature series if necessary.
>
> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>   "hw: Simplify accesses to CPUState::'start-powered-off' property"
> ---
>  hw/arm/armv7m.c       | 21 ++++++++++++---------
>  hw/arm/exynos4210.c   |  4 ++--
>  hw/arm/highbank.c     |  3 ++-
>  hw/arm/integratorcp.c |  5 ++---
>  hw/arm/realview.c     |  2 +-
>  hw/arm/sbsa-ref.c     |  3 ++-
>  hw/arm/versatilepb.c  |  5 ++---
>  hw/arm/vexpress.c     |  6 ++++--
>  hw/arm/virt.c         | 27 +++++++++++++++------------
>  hw/arm/xilinx_zynq.c  |  2 +-
>  hw/cpu/a15mpcore.c    | 17 +++++++++++------
>  hw/cpu/a9mpcore.c     |  6 +++---
>  12 files changed, 57 insertions(+), 44 deletions(-)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 3a6d72b0f3..932061c11a 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -302,28 +302,29 @@ static void armv7m_realize(DeviceState *dev, Error =
**errp)
>
>      object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->contai=
ner),
>                               &error_abort);
> -    if (object_property_find(OBJECT(s->cpu), "idau")) {
> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY)) {
>          object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
>                                   &error_abort);
> -    }
> -    if (object_property_find(OBJECT(s->cpu), "init-svtor")) {
>          if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
>                                        s->init_svtor, errp)) {
>              return;
>          }
>      }
> -    if (object_property_find(OBJECT(s->cpu), "init-nsvtor")) {
> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_M)) {

This doesn't make sense as a check -- we shouldn't be able to get
here if the CPU isn't M-profile.

>          if (!object_property_set_uint(OBJECT(s->cpu), "init-nsvtor",
>                                        s->init_nsvtor, errp)) {
>              return;
>          }
>      }
> -    if (object_property_find(OBJECT(s->cpu), "vfp")) {
> -        if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, err=
p)) {
> -            return;
> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_AARCH64)) {

Similarly this can't possibly be an AArch64 CPU, so this is
not the correct condition to check.

> +        if (cpu_isar_feature(aa64_fp_simd, s->cpu)) {
> +            if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp,=
 errp)) {
> +                return;
> +            }
>          }
>      }
> -    if (object_property_find(OBJECT(s->cpu), "dsp")) {
> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_M) &&
> +        arm_feature(&s->cpu->env, ARM_FEATURE_THUMB_DSP)) {
>          if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, err=
p)) {

Another unnecessary "is this M-profile?" check. This also is
introducing a point of potential future failure because now
we have the condition for "do we have a dsp property" in two
places: in the CPU object where we add it, and then again here
when we set it. Now they can get out of sync.

Most of the others are similar. There might be places where we're
using the "does property X check" to do something more than just
guard "now set property X"; those are probably worth looking at
to see if they should be checking something else.

thanks
-- PMM

