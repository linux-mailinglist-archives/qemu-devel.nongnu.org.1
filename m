Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5D173E075
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm8p-0007Vh-Qz; Mon, 26 Jun 2023 09:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm8f-0007UP-Ih
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDm8c-0006eV-JM
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687785613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Er7uzBZRbs1PMd3Z0u/O9jmhnMkuSK2O8BjmBb7/asU=;
 b=PPMHpB+mS926Ak0vun77h3ZPURRSQcWktBLllzzxueIeDXn6GoZsKMyk5mAN0tbKOisxmy
 QxsFrG99PViMvody+c3Z/WKYTK3E6XaR8UGNE8xiF2QJqG2b/wfOSyaN7brjOjnHrNfj1M
 6r4OceT/RgtsvWbTF2yBSMm0MiI0UFw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-oIb3QIjdNL-LfehEaT174w-1; Mon, 26 Jun 2023 09:20:12 -0400
X-MC-Unique: oIb3QIjdNL-LfehEaT174w-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6a2a5f08aso7619061fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785611; x=1690377611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er7uzBZRbs1PMd3Z0u/O9jmhnMkuSK2O8BjmBb7/asU=;
 b=cuDa+QDwjCDAHFWPKk+7sO7NkeFFDObkjaCW5ZhawW0F5oXKly7gj0djwGBzj+npA3
 wTqESR23x2w1u5X3rDkz3/IHBHbOGrGpnvvKzGFHZ+IquX2tZWrgoZOqsjJ2sR/2dv6C
 2GYaJTIeaJwVIGWSxghrj/ssPglii/NWB55ad3r7LRIe5GyyDMeEzwOgVvK+gvLvWiyh
 4GKesMnR9A+Sr+CejLtkP6wtMvlVeKHligBtM07lbTkGh2WCaDce5r6B2R/V1li+fc2h
 nFwprxXNXDxksROdNmEWYyhp1J/aEKYvvwNaiHR7HMXPd5t9Bv6dbWDfOuWkmLQNTG22
 SQAQ==
X-Gm-Message-State: AC+VfDyIecneeCt92mzecfg/meoC0WCJVaj3EAUSbkNcEZ1NrcYR6DnD
 fo1zB5KjQeTcLvxEoDTxQmwkhySBgAqW0i6TtBj9gS9gReDx29bwXTXjYIOMDlAU6oA+ZbuqYLD
 V+8QsHp2Cq7VcSDw=
X-Received: by 2002:a2e:2c0f:0:b0:2b4:765b:f6f0 with SMTP id
 s15-20020a2e2c0f000000b002b4765bf6f0mr15203470ljs.28.1687785610807; 
 Mon, 26 Jun 2023 06:20:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cJY7EHBRbeXtVCbuy2X9pxgzmJbwpPSUGb/pBs8/d+Id2YG3dWEq+XG3j5aJk7Sfvzy4RYA==
X-Received: by 2002:a2e:2c0f:0:b0:2b4:765b:f6f0 with SMTP id
 s15-20020a2e2c0f000000b002b4765bf6f0mr15203444ljs.28.1687785610394; 
 Mon, 26 Jun 2023 06:20:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f25-20020aa7d859000000b0051d946ae298sm1768005eds.69.2023.06.26.06.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:20:09 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:20:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, BALATON
 Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 30/53] hw/acpi: Fix PM control register access
Message-ID: <20230626152009.13c7b66a@imammedo.users.ipa.redhat.com>
In-Reply-To: <3d563fc68732179b86eff2b87f2d7dbef150315f.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <3d563fc68732179b86eff2b87f2d7dbef150315f.1687782442.git.mst@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 26 Jun 2023 08:29:19 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: BALATON Zoltan <balaton@eik.bme.hu>
> 
> On pegasos2 which has ACPI as part of VT8231 south bridge the board
> firmware writes PM control register by accessing the second byte so
> addr will be 1. This wasn't handled correctly and the write went to
> addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
> only once and does not take addr into account and handle non-zero
> address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
> pegasos2 firmware.
> 
> The issue below is possibly related to the same memory core bug.
> 
> Link: https://gitlab.com/qemu-project/qemu/-/issues/360
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-Id: <20230607200125.A9988746377@zero.eik.bme.hu>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Somewhere you lost mine
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/core.c | 56 +++++++++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 6da275c599..00b1e79a30 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -551,8 +551,35 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
>  }
>  
>  /* ACPI PM1aCNT */
> -static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
> +void acpi_pm1_cnt_update(ACPIREGS *ar,
> +                         bool sci_enable, bool sci_disable)
>  {
> +    /* ACPI specs 3.0, 4.7.2.5 */
> +    if (ar->pm1.cnt.acpi_only) {
> +        return;
> +    }
> +
> +    if (sci_enable) {
> +        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
> +    } else if (sci_disable) {
> +        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
> +    }
> +}
> +
> +static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> +{
> +    ACPIREGS *ar = opaque;
> +    return ar->pm1.cnt.cnt >> addr * 8;
> +}
> +
> +static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> +                              unsigned width)
> +{
> +    ACPIREGS *ar = opaque;
> +
> +    if (addr == 1) {
> +        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
> +    }
>      ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
>  
>      if (val & ACPI_BITMASK_SLEEP_ENABLE) {
> @@ -575,33 +602,6 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
>      }
>  }
>  
> -void acpi_pm1_cnt_update(ACPIREGS *ar,
> -                         bool sci_enable, bool sci_disable)
> -{
> -    /* ACPI specs 3.0, 4.7.2.5 */
> -    if (ar->pm1.cnt.acpi_only) {
> -        return;
> -    }
> -
> -    if (sci_enable) {
> -        ar->pm1.cnt.cnt |= ACPI_BITMASK_SCI_ENABLE;
> -    } else if (sci_disable) {
> -        ar->pm1.cnt.cnt &= ~ACPI_BITMASK_SCI_ENABLE;
> -    }
> -}
> -
> -static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
> -{
> -    ACPIREGS *ar = opaque;
> -    return ar->pm1.cnt.cnt;
> -}
> -
> -static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
> -                              unsigned width)
> -{
> -    acpi_pm1_cnt_write(opaque, val);
> -}
> -
>  static const MemoryRegionOps acpi_pm_cnt_ops = {
>      .read = acpi_pm_cnt_read,
>      .write = acpi_pm_cnt_write,


