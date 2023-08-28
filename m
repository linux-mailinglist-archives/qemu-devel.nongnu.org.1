Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107778A81A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 10:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaXwG-0001Md-CH; Mon, 28 Aug 2023 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaXvv-00016O-A3; Mon, 28 Aug 2023 04:49:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qaXvo-0000SI-IX; Mon, 28 Aug 2023 04:49:14 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99de884ad25so392220566b.3; 
 Mon, 28 Aug 2023 01:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693212545; x=1693817345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4aUi+igPSiGh43qaVr6A1dKr/sffhDAemyWigld+KRs=;
 b=fUztUqZIsRUuuPivZT03BR/pBwO+fZwZegqbBzid3rqTCw1c2xf9ak9ycluF6f7ThX
 72tUiW1WoAKqxYx6ctUsmcxhY3x8lOIiqs67Ueyh/HU0wcqZgpjzlqGUt5pS8VZhDRbZ
 zWUoVfpgAbvT5wai3qjUI4yuVFu4A/MC7SJxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693212545; x=1693817345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aUi+igPSiGh43qaVr6A1dKr/sffhDAemyWigld+KRs=;
 b=a8wfBGH1M6ZDH2UZt9NIYAGfybS19gK5AhD5ISeM7DTsHcv//lNGouSxmqqGhz24nX
 Tsv/QqjPd6ndQQH3vLWYCC66XbqZyMJLSWKeCntFslrKI+VoQ8D73xA+bEQqQzLaV3t+
 6GmRRj36Xs8RvSppRdH/bx4Po/PGehBm46AfRUWRoBe423vusX70ovf5viVXB25brqzH
 BQ52j29c4C6UcScNntM7tmOLk49OpYprUm7/V4hNlU6O9bbuC7igCeMDnRHlryP5RjgU
 WVzOLVWe5aGuzO/GT8cC83GkpGjMGtF6wzugwNuIyu5n+Bngfj4OCy/dkNs1buJ/G+Dm
 lKRw==
X-Gm-Message-State: AOJu0Yw+hunw/63WX8DPaY+ZaacoUkPbfPLxtgReZSe3fpfiNvqJ4gRr
 3qt/3DWlS6A8qdCNf92Gta0mj1se6zQEYSnCNX0=
X-Google-Smtp-Source: AGHT+IHlrfrCkiVzOHQ6yu/qTvVQxLFPcrz6WYM5neOWHvbYlQSy8K/Rnv9kqVhbcwawYmW+emws4pUHVfbLZoe12aY=
X-Received: by 2002:a17:906:3287:b0:991:fef4:bb9 with SMTP id
 7-20020a170906328700b00991fef40bb9mr19123814ejw.58.1693212544864; Mon, 28 Aug
 2023 01:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-8-ninad@linux.ibm.com>
In-Reply-To: <20230825203046.3692467-8-ninad@linux.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Aug 2023 08:48:53 +0000
Message-ID: <CACPK8XeynLYjenP-EhDQHwoeRK8ZFVN05eiFqNbxFiXZrH3HmA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] hw/arm: Hook up FSI module in AST2600
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 25 Aug 2023 at 20:35, Ninad Palsule <ninad@linux.ibm.com> wrote:
>
> This patchset introduces IBM's Flexible Service Interface(FSI).
>
> Time for some fun with inter-processor buses. FSI allows a service
> processor access to the internal buses of a host POWER processor to
> perform configuration or debugging.
>
> FSI has long existed in POWER processes and so comes with some baggage,
> including how it has been integrated into the ASPEED SoC.
>
> Working backwards from the POWER processor, the fundamental pieces of
> interest for the implementation are:
>
> 1. The Common FRU Access Macro (CFAM), an address space containing
>    various "engines" that drive accesses on buses internal and external
>    to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>    engines hang off of an internal Local Bus (LBUS) which is described
>    by the CFAM configuration block.
>
> 2. The FSI slave: The slave is the terminal point of the FSI bus for
>    FSI symbols addressed to it. Slaves can be cascaded off of one
>    another. The slave's configuration registers appear in address space
>    of the CFAM to which it is attached.
>
> 3. The FSI master: A controller in the platform service processor (e.g.
>    BMC) driving CFAM engine accesses into the POWER chip. At the
>    hardware level FSI is a bit-based protocol supporting synchronous and
>    DMA-driven accesses of engines in a CFAM.
>
> 4. The On-Chip Peripheral Bus (OPB): A low-speed bus typically found in
>    POWER processors. This now makes an appearance in the ASPEED SoC due
>    to tight integration of the FSI master IP with the OPB, mainly the
>    existence of an MMIO-mapping of the CFAM address straight onto a
>    sub-region of the OPB address space.
>
> 5. An APB-to-OPB bridge enabling access to the OPB from the ARM core in
>    the AST2600. Hardware limitations prevent the OPB from being directly
>    mapped into APB, so all accesses are indirect through the bridge.
>
> The implementation appears as following in the qemu device tree:
>
>     (qemu) info qtree
>     bus: main-system-bus
>       type System
>       ...
>       dev: aspeed.apb2opb, id ""
>         gpio-out "sysbus-irq" 1
>         mmio 000000001e79b000/0000000000001000
>         bus: opb.1
>           type opb
>           dev: fsi.master, id ""
>             bus: fsi.bus.1
>               type fsi.bus
>               dev: cfam.config, id ""
>               dev: cfam, id ""
>                 bus: lbus.1
>                   type lbus
>                   dev: scratchpad, id ""
>                     address =3D 0 (0x0)
>         bus: opb.0
>           type opb
>           dev: fsi.master, id ""
>             bus: fsi.bus.0
>               type fsi.bus
>               dev: cfam.config, id ""
>               dev: cfam, id ""
>                 bus: lbus.0
>                   type lbus
>                   dev: scratchpad, id ""
>                     address =3D 0 (0x0)
>
> The LBUS is modelled to maintain the qdev bus hierarchy and to take
> advantage of the object model to automatically generate the CFAM
> configuration block. The configuration block presents engines in the
> order they are attached to the CFAM's LBUS. Engine implementations
> should subclass the LBusDevice and set the 'config' member of
> LBusDeviceClass to match the engine's type.
>
> CFAM designs offer a lot of flexibility, for instance it is possible for
> a CFAM to be simultaneously driven from multiple FSI links. The modeling
> is not so complete; it's assumed that each CFAM is attached to a single
> FSI slave (as a consequence the CFAM subclasses the FSI slave).
>
> As for FSI, its symbols and wire-protocol are not modelled at all. This
> is not necessary to get FSI off the ground thanks to the mapping of the
> CFAM address space onto the OPB address space - the models follow this
> directly and map the CFAM memory region into the OPB's memory region.
> Future work includes supporting more advanced accesses that drive the
> FSI master directly rather than indirectly via the CFAM mapping, which
> will require implementing the FSI state machine and methods for each of
> the FSI symbols on the slave. Further down the track we can also look at
> supporting the bitbanged SoftFSI drivers in Linux by extending the FSI
> slave model to resolve sequences of GPIO IRQs into FSI symbols, and
> calling the associated symbol method on the slave to map the access onto
> the CFAM.
>
> Testing:
> Tested by reading cfam config address 0 on rainier machine. We can
> ignore the error line as it is not related.
> root@p10bmc:~# pdbg -a getcfam 0x0
> Unable to open dtb file '/var/lib/phosphor-software-manager/pnor/rw/DEVTR=
EE'

Delete this line (and the explanation). It's something to follow up
with the version of pdbg that openbmc has, but unrelated to this
patch.

> p0: 0x0 =3D 0xc0022d15
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  hw/arm/aspeed_ast2600.c     | 15 +++++++++++++++
>  include/hw/arm/aspeed_soc.h |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index a8b3a8065a..e239487c16 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -75,6 +75,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>      [ASPEED_DEV_UART12]    =3D 0x1E790600,
>      [ASPEED_DEV_UART13]    =3D 0x1E790700,
>      [ASPEED_DEV_VUART]     =3D 0x1E787000,
> +    [ASPEED_DEV_FSI1]      =3D 0x1E79B000,
> +    [ASPEED_DEV_FSI2]      =3D 0x1E79B100,
>      [ASPEED_DEV_I3C]       =3D 0x1E7A0000,
>      [ASPEED_DEV_SDRAM]     =3D 0x80000000,
>  };
> @@ -132,6 +134,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_DEV_ETH4]      =3D 33,
>      [ASPEED_DEV_KCS]       =3D 138,   /* 138 -> 142 */
>      [ASPEED_DEV_DP]        =3D 62,
> +    [ASPEED_DEV_FSI1]      =3D 100,
> +    [ASPEED_DEV_FSI2]      =3D 101,
>      [ASPEED_DEV_I3C]       =3D 102,   /* 102 -> 107 */
>  };
>
> @@ -262,6 +266,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>      object_initialize_child(obj, "emmc-boot-controller",
>                              &s->emmc_boot_controller,
>                              TYPE_UNIMPLEMENTED_DEVICE);
> +
> +    object_initialize_child(obj, "fsi[*]", &s->fsi[0], TYPE_ASPEED_APB2O=
PB);
>  }
>
>  /*
> @@ -622,6 +628,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
>      aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sbc), 0, sc->memmap[ASPEED_DEV=
_SBC]);
> +
> +    /* FSI */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsi[0]), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->fsi[0]), 0,
> +                    sc->memmap[ASPEED_DEV_FSI1]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
> +                       aspeed_soc_get_irq(s, ASPEED_DEV_FSI1));

You only attach the first FSI device. You should attach the second, or
if you decide to not model the second, remove the array and just have
one AspeedAPB2OPBState in AspeedSoCState.

>  }
>
>  static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 8adff70072..db3ba3abc7 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -36,6 +36,7 @@
>  #include "hw/misc/aspeed_lpc.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/misc/aspeed_peci.h"
> +#include "hw/fsi/aspeed-apb2opb.h"
>  #include "hw/char/serial.h"
>
>  #define ASPEED_SPIS_NUM  2
> @@ -96,6 +97,7 @@ struct AspeedSoCState {
>      UnimplementedDeviceState udc;
>      UnimplementedDeviceState sgpiom;
>      UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
> +    AspeedAPB2OPBState fsi[2];
>  };
>
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -191,6 +193,8 @@ enum {
>      ASPEED_DEV_SGPIOM,
>      ASPEED_DEV_JTAG0,
>      ASPEED_DEV_JTAG1,
> +    ASPEED_DEV_FSI1,
> +    ASPEED_DEV_FSI2,
>  };
>
>  #define ASPEED_SOC_SPI_BOOT_ADDR 0x0
> --
> 2.39.2
>

