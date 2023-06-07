Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D77256F2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:07:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oBy-000062-L7; Wed, 07 Jun 2023 04:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6oBv-00005E-CM; Wed, 07 Jun 2023 04:06:51 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6oBt-00074G-Iq; Wed, 07 Jun 2023 04:06:51 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so1040929066b.0; 
 Wed, 07 Jun 2023 01:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686125207; x=1688717207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzyfxXEkg4mwZuF47QujeTh0B75sADTfkMPP+0WPGGY=;
 b=naxuEslgqluC8eXwzylc06kT2yjsUZ4i4aLNZBSGzPVj92iDu3WuCtSGoooZ1geGIr
 OzjWihnZSASkb/miK51bAJjNO/qq919ToFMyOVgV0MU1vGhl6iD9DM65VTACn3VeGcvd
 hCvMBNnccv1XgL3l2e4jCtqVBqpCu9H75wBcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125207; x=1688717207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzyfxXEkg4mwZuF47QujeTh0B75sADTfkMPP+0WPGGY=;
 b=U3MDMUAOaLnE6XwFn7RaHaEIgpTwz1CmmnWJwmawexegXstl4QHtqxbRnkLseDD4Zs
 aRKyMx9bpsD9dJ54aqjXCZqHkWbq6yWlPmq+4/OShLfCog9AFTtOVuqM0xDxeflsotLK
 HhT9K6C/6JBpib9F8/zhBE9GH1OjksAegbBQTaSeNeXQAAafNqMFv9pg3VpX21mr3NwK
 i9WG6sghCWaqgo7n71iHMieDFeYIur6Eq8Serge/W+V2e681+gM6LOLVx0t52u5mlDF2
 jx0r1VbIlXzfgcxOzI+/WpGVmu3E7Dl8tEGzrL9LB/qKq/k8/obVV7GLix/MhhS3fi/K
 RaAQ==
X-Gm-Message-State: AC+VfDzkyGady/W0dZp3OOBtzs5OZTgoOSZ2+xFZyeMPGpJJWkv5GVjI
 UzwfaoyK7PeSuNNtmh2QjPICCb/IK2ui6DAmXb4hR06K
X-Google-Smtp-Source: ACHHUZ6xeLTAZSnC9IZKgqZvi1ASXe/IfBYYvv7tNG9gqcJC2rRrTYI/u2v5vCwi3Bc/PUcW+pK75aVyFLcOdBro4xw=
X-Received: by 2002:a17:907:9621:b0:970:bef:4393 with SMTP id
 gb33-20020a170907962100b009700bef4393mr6479166ejc.7.1686125207067; Wed, 07
 Jun 2023 01:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-5-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-5-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 08:06:35 +0000
Message-ID: <CACPK8XencE5MMgYdQ5H6iV_rTHaynv-UJYHZy=y-DaCXYBWWXg@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] hw/ssi: Add an "addr" property to SSIPeripheral
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x632.google.com
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
> Boards will use this new property to identify the device CS line and
> wire the SPI controllers accordingly.

"addr" and not "cs" or even "chip-select"?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Cc: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ssi/ssi.h | 3 +++
>  hw/ssi/ssi.c         | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 6950f86810d3..9e0706a5248c 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -64,6 +64,9 @@ struct SSIPeripheral {
>
>      /* Chip select state */
>      bool cs;
> +
> +    /* Chip select address/index */
> +    uint8_t addr;
>  };
>
>  extern const VMStateDescription vmstate_ssi_peripheral;
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index d54a109beeb5..d4409535429c 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -13,6 +13,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/ssi/ssi.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> @@ -71,6 +72,11 @@ static void ssi_peripheral_realize(DeviceState *dev, E=
rror **errp)
>      ssc->realize(s, errp);
>  }
>
> +static Property ssi_peripheral_properties[] =3D {
> +    DEFINE_PROP_UINT8("addr", SSIPeripheral, addr, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void ssi_peripheral_class_init(ObjectClass *klass, void *data)
>  {
>      SSIPeripheralClass *ssc =3D SSI_PERIPHERAL_CLASS(klass);
> @@ -81,6 +87,7 @@ static void ssi_peripheral_class_init(ObjectClass *klas=
s, void *data)
>      if (!ssc->transfer_raw) {
>          ssc->transfer_raw =3D ssi_transfer_raw_default;
>      }
> +    device_class_set_props(dc, ssi_peripheral_properties);
>  }
>
>  static const TypeInfo ssi_peripheral_info =3D {
> --
> 2.40.1
>

