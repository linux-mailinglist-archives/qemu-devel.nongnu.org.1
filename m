Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7050A725C1D
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qpL-0006MC-TR; Wed, 07 Jun 2023 06:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qpH-0006KU-6D; Wed, 07 Jun 2023 06:55:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qpF-0001g4-Kb; Wed, 07 Jun 2023 06:55:38 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-978863fb00fso64806266b.3; 
 Wed, 07 Jun 2023 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686135335; x=1688727335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9asYw7vpaUzs2Cw1L3wgCpr5l4u3ymdgFHG59ZE7HYs=;
 b=ZouV7kP9quQKOpo71zIR2x7+GM/1TGckmyxbc1j5dFNYaPwkjFdrqu1oayvqsPukE+
 taN2LcE+inIbgwkienNb+BhY7GneXpT882M2ERCjF1KlgpxF1Og+pPN6NQBpUzFiAHkH
 gWXiMl7DF0xhCNE8qUNZNItX6V3IbJpInramE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686135335; x=1688727335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9asYw7vpaUzs2Cw1L3wgCpr5l4u3ymdgFHG59ZE7HYs=;
 b=lB+lMSLROhZhKIkqPUEhsw8+uZWzyKReJ5xq8ndTkVcMicAo8OrzeXvtwykqF3PC3z
 nC0tXg0kmlNoSQXmISxMcDQfgZH7WL2+F8v8A2VQxz/SwmjH4/JB0JsG5RVPLR4pctSG
 fOGrXgzdHmjyFdlu1ZjMywUAm7JQ2tkGSp7qfRJ7yAuKEoIuCDbTn+90zAajDcV4HrZe
 H6UMfY+tCtSMCAnNUeF9zGG2o5kB+lqXWglJ0N2VT1Bp7FJ2bQszQ3U7mnvTjJphSO5C
 Fge7zFCkWendYAb4JDr5Zb08ML8vGI3ioSTadRs6KzLWTAxBqXCdw7P7GjaPEhI2jYlS
 oiqA==
X-Gm-Message-State: AC+VfDybOV1Z+CSiRiagOkaC1oYrrfUKkpl3CMGGgPDatNFNDJ68GExI
 1RuIls72UYYmVHBQ8RYlTGELJwQIoyyU2VGfGJE=
X-Google-Smtp-Source: ACHHUZ53/MIibQAZROfaR/LhBcoeNAkhNFk+tDyuLseQtA49eLXnqHF/Zc6ytazFpkNcdS4EZlHa0xFWxpJEXVMYh2k=
X-Received: by 2002:a17:906:9751:b0:973:fa96:aff1 with SMTP id
 o17-20020a170906975100b00973fa96aff1mr5955881ejy.35.1686135335240; Wed, 07
 Jun 2023 03:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-10-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-10-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 10:55:23 +0000
Message-ID: <CACPK8XfncDzLXFQvhzqjO8Lq5aF5QWzhzNXaKoC=rBw-VifO-w@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] m25p80: Introduce an helper to retrieve the
 BlockBackend of a device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 7 Jun 2023 at 04:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It will help in getting rid of some drive_get(IF_MTD) calls by
> retrieving the BlockBackend directly from the m25p80 device.
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

One suggestion below after reading patch 10.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  include/hw/block/flash.h | 4 ++++
>  hw/block/m25p80.c        | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 7198953702b7..de93756cbe8f 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -76,4 +76,8 @@ uint8_t ecc_digest(ECCState *s, uint8_t sample);
>  void ecc_reset(ECCState *s);
>  extern const VMStateDescription vmstate_ecc_state;
>
> +/* m25p80.c */
> +
> +BlockBackend *m25p80_get_blk(DeviceState *dev);
> +
>  #endif
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index dc5ffbc4ff52..afc3fdf4d60b 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -25,6 +25,7 @@
>  #include "qemu/units.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/block/block.h"
> +#include "hw/block/flash.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
>  #include "hw/ssi/ssi.h"
> @@ -1830,3 +1831,8 @@ static void m25p80_register_types(void)
>  }
>
>  type_init(m25p80_register_types)
> +
> +BlockBackend *m25p80_get_blk(DeviceState *dev)
> +{
> +    return M25P80(dev)->blk;

Is it qemu convention for the caller to do the null check on dev, or
should it go in this helper?

> +}
> --
> 2.40.1
>

