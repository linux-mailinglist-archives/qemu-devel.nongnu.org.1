Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B71A1A13A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Jan 2025 10:52:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatsX-0004Wz-0n; Thu, 23 Jan 2025 04:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tatsS-0004Wn-Sj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:51:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tatsR-0002hE-5Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:51:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ydx4j6qW8z6L55w;
 Thu, 23 Jan 2025 17:49:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 56D55140A70;
 Thu, 23 Jan 2025 17:51:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 10:51:52 +0100
Date: Thu, 23 Jan 2025 09:51:51 +0000
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <mst@redhat.com>
Subject: Re: [PATCH 2/2] hw/cxl: Allow tracing component I/O accesses
Message-ID: <20250123095151.000041a0@huawei.com>
In-Reply-To: <20250122065624.34203-3-philmd@linaro.org>
References: <20250122065624.34203-1-philmd@linaro.org>
 <20250122065624.34203-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.043, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 22 Jan 2025 07:56:24 +0100
Philippe Mathieu-Daud=E9 <philmd@linaro.org> wrote:

> Map the component I/O region as UnimplementedDevice
> to be able to trace guest I/O accesses with '-d unimp'.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
I'm not that familiar with this infrastructure but seems
fine to me.

I'd definitely be curious if anything is touching this space so
tracing may be helpful for that!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_component.h |  3 ++-
>  hw/cxl/cxl-component-utils.c   | 14 +++++++++++---
>  hw/cxl/Kconfig                 |  1 +
>  3 files changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index ac61c3f33a5..54fd369a838 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -18,6 +18,7 @@
>  #include "qemu/range.h"
>  #include "hw/cxl/cxl_cdat.h"
>  #include "hw/register.h"
> +#include "hw/misc/unimp.h"
>  #include "qapi/error.h"
> =20
>  enum reg_type {
> @@ -218,7 +219,7 @@ typedef struct component_registers {
>       *   0xe000 - 0xe3ff CXL ARB/MUX registers
>       *   0xe400 - 0xffff RSVD
>       */
> -    MemoryRegion io;
> +    UnimplementedDeviceState io;
> =20
>      uint32_t cache_mem_registers[CXL2_COMPONENT_CM_REGION_SIZE >> 2];
>      uint32_t cache_mem_regs_write_mask[CXL2_COMPONENT_CM_REGION_SIZE >> =
2];
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index cd116c04012..6d593475d00 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -192,17 +192,25 @@ void cxl_component_register_block_init(Object *obj,
>                                         const char *type)
>  {
>      ComponentRegisters *cregs =3D &cxl_cstate->crb;
> +    DeviceState *io_dev;
> +    SysBusDevice *io_sbd;
> =20
>      memory_region_init(&cregs->component_registers, obj, type,
>                         CXL2_COMPONENT_BLOCK_SIZE);
> =20
>      /* io registers controls link which we don't care about in QEMU */
> -    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
> -                          CXL2_COMPONENT_IO_REGION_SIZE);
> +    object_initialize_child(obj, "io", &cregs->io, TYPE_UNIMPLEMENTED_DE=
VICE);
> +    io_dev =3D DEVICE(&cregs->io);
> +    io_sbd =3D SYS_BUS_DEVICE(&cregs->io);
> +    qdev_prop_set_string(io_dev, "name", ".io");
> +    qdev_prop_set_uint64(io_dev, "size", CXL2_COMPONENT_IO_REGION_SIZE);
> +    sysbus_realize(io_sbd, &error_fatal);
> +
>      memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cs=
tate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
> =20
> -    memory_region_add_subregion(&cregs->component_registers, 0, &cregs->=
io);
> +    memory_region_add_subregion(&cregs->component_registers, 0,
> +                                sysbus_mmio_get_region(io_sbd, 0));
>      memory_region_add_subregion(&cregs->component_registers,
>                                  CXL2_COMPONENT_IO_REGION_SIZE,
>                                  &cregs->cache_mem);
> diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
> index 8e67519b161..d6c7536001e 100644
> --- a/hw/cxl/Kconfig
> +++ b/hw/cxl/Kconfig
> @@ -1,3 +1,4 @@
>  config CXL
>      bool
>      default y if PCI_EXPRESS
> +    select UNIMP


