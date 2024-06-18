Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619990D7BC
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jun 2024 17:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJb4V-0002SH-I2; Tue, 18 Jun 2024 11:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJb4N-0002Rb-H8; Tue, 18 Jun 2024 11:48:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJb4K-0004ie-8X; Tue, 18 Jun 2024 11:48:27 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W3WPD3KLlz4x0v;
 Wed, 19 Jun 2024 01:48:16 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3WP80wg5z4wZx;
 Wed, 19 Jun 2024 01:48:11 +1000 (AEST)
Message-ID: <29251dbf-1e17-4476-a1e8-31da86958b4c@kaod.org>
Date: Tue, 18 Jun 2024 17:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] ppc/pnv: Add SPI model
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240617165419.8388-1-chalapathi.v@linux.ibm.com>
 <20240617165419.8388-2-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240617165419.8388-2-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Of75=NU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello Chalapathi,

On 6/17/24 6:54 PM, Chalapathi V wrote:
> SPI controller device model supports a connection to a single SPI responder.
> This provide access to SPI seeproms, TPM, flash device and an ADC controller.
> 
> All SPI function control is mapped into the SPI register space to enable full
> control by firmware. In this commit SPI configuration component is modelled
> which contains all SPI configuration and status registers as well as the hold
> registers for data to be sent or having been received.
> 
> An existing QEMU SSI framework is used and SSI_BUS is created.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/ppc/pnv_xscom.h    |   5 +-
>   include/hw/ssi/pnv_spi.h      |  59 ++++++++++
>   include/hw/ssi/pnv_spi_regs.h | 114 +++++++++++++++++++
>   hw/ssi/pnv_spi.c              | 202 ++++++++++++++++++++++++++++++++++
>   hw/ppc/Kconfig                |   3 +
>   hw/ssi/Kconfig                |   4 +
>   hw/ssi/meson.build            |   1 +
>   hw/ssi/trace-events           |   6 +
>   8 files changed, 393 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/ssi/pnv_spi.h
>   create mode 100644 include/hw/ssi/pnv_spi_regs.h
>   create mode 100644 hw/ssi/pnv_spi.c
> 
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index 6209e18492..0020dd172f 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -21,9 +21,9 @@
>   #define PPC_PNV_XSCOM_H
>   
>   #include "exec/memory.h"
> -#include "hw/ppc/pnv.h"
>   
>   typedef struct PnvXScomInterface PnvXScomInterface;
> +typedef struct PnvChip PnvChip;
>   
>   #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
>   #define PNV_XSCOM_INTERFACE(obj) \

Could please provide the above change in its own patch ?

> @@ -194,6 +194,9 @@ struct PnvXScomInterfaceClass {
>   #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
>   #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
>   
> +#define PNV10_XSCOM_PIB_SPIC_BASE 0xc0000
> +#define PNV10_XSCOM_PIB_SPIC_SIZE 0x20
> +
>   void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
>   int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>                    uint64_t xscom_base, uint64_t xscom_size,
> diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
> new file mode 100644
> index 0000000000..71c53d4a17
> --- /dev/null
> +++ b/include/hw/ssi/pnv_spi.h
> @@ -0,0 +1,59 @@
> +/*
> + * QEMU PowerPC SPI model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This model Supports a connection to a single SPI responder.
> + * Introduced for P10 to provide access to SPI seeproms, TPM, flash device
> + * and an ADC controller.
> + */
> +#include "hw/ssi/ssi.h"
> +#include "hw/sysbus.h"

The include should be protected by PPC_PNV_SPI_H also.

> +#ifndef PPC_PNV_SPI_H
> +#define PPC_PNV_SPI_H
> +
> +/* Userful macros */

/* Macros from target/ppc/cpu.h */

please explain why they are copied in the comment and move them in the .c
file for now. We don't want them to conflict with other definitions.

> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT8(bit)           (0x80 >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> +#define PPC_BITMASK8(bs, be)    ((PPC_BIT8(bs) - PPC_BIT8(be)) | PPC_BIT8(bs))
> +#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> +#define SETFIELD(m, v, val) \
> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))

same comment for _FDT() which comes from include/hw/ppc/fdt.h.

The rest looks OK.

Thanks,

C.



> +#define _FDT(exp)                                                  \
> +    do {                                                           \
> +        int _ret = (exp);                                          \
> +        if (_ret < 0) {                                            \
> +            error_report("error creating device tree: %s: %s",     \
> +                    #exp, fdt_strerror(_ret));                     \
> +            exit(1);                                               \
> +        }                                                          \
> +    } while (0)
> +
> +#define TYPE_PNV_SPI "pnv-spi"
> +OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
> +
> +#define PNV_SPI_REG_SIZE 8
> +#define PNV_SPI_REGS 7
> +
> +#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
> +typedef struct PnvSpi {
> +    SysBusDevice parent_obj;
> +
> +    SSIBus *ssi_bus;
> +    qemu_irq *cs_line;
> +    MemoryRegion    xscom_spic_regs;
> +    /* SPI object number */
> +    uint32_t        spic_num;
> +
> +    /* SPI registers */
> +    uint64_t        regs[PNV_SPI_REGS];
> +    uint8_t         seq_op[PNV_SPI_REG_SIZE];
> +    uint64_t        status;
> +} PnvSpi;
> +#endif /* PPC_PNV_SPI_H */
> diff --git a/include/hw/ssi/pnv_spi_regs.h b/include/hw/ssi/pnv_spi_regs.h
> new file mode 100644
> index 0000000000..a0b5f3973d
> --- /dev/null
> +++ b/include/hw/ssi/pnv_spi_regs.h
> @@ -0,0 +1,114 @@
> +/*
> + * QEMU PowerPC SPI model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef PNV_SPI_CONTROLLER_REGS_H
> +#define PNV_SPI_CONTROLLER_REGS_H
> +
> +/* Error Register */
> +#define ERROR_REG               0x00
> +
> +/* counter_config_reg */
> +#define SPI_CTR_CFG_REG         0x01
> +#define SPI_CTR_CFG_N1          PPC_BITMASK(0, 7)
> +#define SPI_CTR_CFG_N2          PPC_BITMASK(8, 15)
> +#define SPI_CTR_CFG_CMP1        PPC_BITMASK(24, 31)
> +#define SPI_CTR_CFG_CMP2        PPC_BITMASK(32, 39)
> +#define SPI_CTR_CFG_N1_CTRL     PPC_BITMASK(48, 51)
> +#define SPI_CTR_CFG_N2_CTRL     PPC_BITMASK(52, 55)
> +
> +/* config_reg */
> +#define CONFIG_REG1             0x02
> +
> +/* clock_config_reset_control_ecc_enable_reg */
> +#define SPI_CLK_CFG_REG         0x03
> +#define SPI_CLK_CFG_HARD_RST    0x0084000000000000;
> +#define SPI_CLK_CFG_RST_CTRL    PPC_BITMASK(24, 27)
> +#define SPI_CLK_CFG_ECC_CTRL    PPC_BITMASK(28, 30)
> +
> +/* memory_mapping_reg */
> +#define SPI_MM_REG              0x04
> +#define SPI_MM_BASE_ADDR        PPC_BITMASK(0, 15)
> +#define SPI_MM_ADDR_MASK        PPC_BITMASK(16, 31)
> +#define SPI_MM_RDR_MATCH_VAL    PPC_BITMASK(32, 47)
> +#define SPI_MM_RDR_MATCH_MASK   PPC_BITMASK(48, 63)
> +
> +/* transmit_data_reg */
> +#define SPI_XMIT_DATA_REG       0x05
> +
> +/* receive_data_reg */
> +#define SPI_RCV_DATA_REG        0x06
> +
> +/* sequencer_operation_reg */
> +#define SPI_SEQ_OP_REG          0x07
> +
> +/* status_reg */
> +#define SPI_STS_REG             0x08
> +#define SPI_STS_RDR_FULL        PPC_BIT(0)
> +#define SPI_STS_RDR_OVERRUN     PPC_BIT(1)
> +#define SPI_STS_RDR_UNDERRUN    PPC_BIT(2)
> +#define SPI_STS_TDR_FULL        PPC_BIT(4)
> +#define SPI_STS_TDR_OVERRUN     PPC_BIT(5)
> +#define SPI_STS_TDR_UNDERRUN    PPC_BIT(6)
> +#define SPI_STS_SEQ_FSM         PPC_BITMASK(8, 15)
> +#define SPI_STS_SHIFTER_FSM     PPC_BITMASK(16, 27)
> +#define SPI_STS_SEQ_INDEX       PPC_BITMASK(28, 31)
> +#define SPI_STS_GEN_STATUS      PPC_BITMASK(32, 63)
> +#define SPI_STS_RDR             PPC_BITMASK(1, 3)
> +#define SPI_STS_TDR             PPC_BITMASK(5, 7)
> +
> +/*
> + * Shifter states
> + *
> + * These are the same values defined for the Shifter FSM field of the
> + * status register.  It's a 12 bit field so we will represent it as three
> + * nibbles in the constants.
> + *
> + * These are shifter_fsm values
> + *
> + * Status reg bits 16-27 -> field bits 0-11
> + * bits 0,1,2,5 unused/reserved
> + * bit 4 crc shift in (unused)
> + * bit 8 crc shift out (unused)
> + */
> +
> +#define FSM_DONE                        0x100   /* bit 3 */
> +#define FSM_SHIFT_N2                    0x020   /* bit 6 */
> +#define FSM_WAIT                        0x010   /* bit 7 */
> +#define FSM_SHIFT_N1                    0x004   /* bit 9 */
> +#define FSM_START                       0x002   /* bit 10 */
> +#define FSM_IDLE                        0x001   /* bit 11 */
> +
> +/*
> + * Sequencer states
> + *
> + * These are sequencer_fsm values
> + *
> + * Status reg bits 8-15 -> field bits 0-7
> + * bits 0-3 unused/reserved
> + *
> + */
> +#define SEQ_STATE_INDEX_INCREMENT       0x08    /* bit 4 */
> +#define SEQ_STATE_EXECUTE               0x04    /* bit 5 */
> +#define SEQ_STATE_DECODE                0x02    /* bit 6 */
> +#define SEQ_STATE_IDLE                  0x01    /* bit 7 */
> +
> +/*
> + * These are the supported sequencer operations.
> + * Only the upper nibble is significant because for many operations
> + * the lower nibble is a variable specific to the operation.
> + */
> +#define SEQ_OP_STOP                     0x00
> +#define SEQ_OP_SELECT_SLAVE             0x10
> +#define SEQ_OP_SHIFT_N1                 0x30
> +#define SEQ_OP_SHIFT_N2                 0x40
> +#define SEQ_OP_BRANCH_IFNEQ_RDR         0x60
> +#define SEQ_OP_TRANSFER_TDR             0xC0
> +#define SEQ_OP_BRANCH_IFNEQ_INC_1       0xE0
> +#define SEQ_OP_BRANCH_IFNEQ_INC_2       0xF0
> +
> +#endif
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> new file mode 100644
> index 0000000000..da9e3925dd
> --- /dev/null
> +++ b/hw/ssi/pnv_spi.c
> @@ -0,0 +1,202 @@
> +/*
> + * QEMU PowerPC SPI model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/ppc/pnv_xscom.h"
> +#include "hw/ssi/pnv_spi.h"
> +#include "hw/ssi/pnv_spi_regs.h"
> +#include "hw/ssi/ssi.h"
> +#include <libfdt.h>
> +#include "hw/irq.h"
> +#include "trace.h"
> +
> +static uint64_t pnv_spi_xscom_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    PnvSpi *s = PNV_SPI(opaque);
> +    uint32_t reg = addr >> 3;
> +    uint64_t val = ~0ull;
> +
> +    switch (reg) {
> +    case ERROR_REG:
> +    case SPI_CTR_CFG_REG:
> +    case CONFIG_REG1:
> +    case SPI_CLK_CFG_REG:
> +    case SPI_MM_REG:
> +    case SPI_XMIT_DATA_REG:
> +        val = s->regs[reg];
> +        break;
> +    case SPI_RCV_DATA_REG:
> +        val = s->regs[reg];
> +        trace_pnv_spi_read_RDR(val);
> +        s->status = SETFIELD(SPI_STS_RDR_FULL, s->status, 0);
> +        break;
> +    case SPI_SEQ_OP_REG:
> +        val = 0;
> +        for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
> +            val = (val << 8) | s->seq_op[i];
> +        }
> +        break;
> +    case SPI_STS_REG:
> +        val = s->status;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
> +                 "read at 0x%" PRIx32 "\n", reg);
> +    }
> +
> +    trace_pnv_spi_read(addr, val);
> +    return val;
> +}
> +
> +static void pnv_spi_xscom_write(void *opaque, hwaddr addr,
> +                                 uint64_t val, unsigned size)
> +{
> +    PnvSpi *s = PNV_SPI(opaque);
> +    uint32_t reg = addr >> 3;
> +
> +    trace_pnv_spi_write(addr, val);
> +
> +    switch (reg) {
> +    case ERROR_REG:
> +    case SPI_CTR_CFG_REG:
> +    case CONFIG_REG1:
> +    case SPI_MM_REG:
> +    case SPI_RCV_DATA_REG:
> +        s->regs[reg] = val;
> +        break;
> +    case SPI_CLK_CFG_REG:
> +        /*
> +         * To reset the SPI controller write the sequence 0x5 0xA to
> +         * reset_control field
> +         */
> +        if ((GETFIELD(SPI_CLK_CFG_RST_CTRL, s->regs[SPI_CLK_CFG_REG]) == 0x5)
> +             && (GETFIELD(SPI_CLK_CFG_RST_CTRL, val) == 0xA)) {
> +                /* SPI controller reset sequence completed, resetting */
> +            s->regs[reg] = SPI_CLK_CFG_HARD_RST;
> +        } else {
> +            s->regs[reg] = val;
> +        }
> +        break;
> +    case SPI_XMIT_DATA_REG:
> +        /*
> +         * Writing to the transmit data register causes the transmit data
> +         * register full status bit in the status register to be set.  Writing
> +         * when the transmit data register full status bit is already set
> +         * causes a "Resource Not Available" condition.  This is not possible
> +         * in the model since writes to this register are not asynchronous to
> +         * the operation sequence like it would be in hardware.
> +         */
> +        s->regs[reg] = val;
> +        trace_pnv_spi_write_TDR(val);
> +        s->status = SETFIELD(SPI_STS_TDR_FULL, s->status, 1);
> +        s->status = SETFIELD(SPI_STS_TDR_UNDERRUN, s->status, 0);
> +        break;
> +    case SPI_SEQ_OP_REG:
> +        for (int i = 0; i < PNV_SPI_REG_SIZE; i++) {
> +            s->seq_op[i] = (val >> (56 - i * 8)) & 0xFF;
> +        }
> +        break;
> +    case SPI_STS_REG:
> +        /* other fields are ignore_write */
> +        s->status = SETFIELD(SPI_STS_RDR_OVERRUN, s->status,
> +                                  GETFIELD(SPI_STS_RDR, val));
> +        s->status = SETFIELD(SPI_STS_TDR_OVERRUN, s->status,
> +                                  GETFIELD(SPI_STS_TDR, val));
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
> +                 "write at 0x%" PRIx32 "\n", reg);
> +    }
> +    return;
> +}
> +
> +static const MemoryRegionOps pnv_spi_xscom_ops = {
> +    .read = pnv_spi_xscom_read,
> +    .write = pnv_spi_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static Property pnv_spi_properties[] = {
> +    DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void pnv_spi_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvSpi *s = PNV_SPI(dev);
> +    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
> +                    s->spic_num);
> +    s->ssi_bus = ssi_create_bus(dev, name);
> +    s->cs_line = g_new0(qemu_irq, 1);
> +    qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
> +
> +    /* spi scoms */
> +    pnv_xscom_region_init(&s->xscom_spic_regs, OBJECT(s),
> +                          &pnv_spi_xscom_ops, s,
> +                          "xscom-spi-regs",
> +                          PNV10_XSCOM_PIB_SPIC_SIZE);
> +}
> +
> +static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
> +                             int offset)
> +{
> +    PnvSpi *s = PNV_SPI(dev);
> +    g_autofree char *name;
> +    int s_offset;
> +    const char compat[] = "ibm,power10-spi";
> +    uint32_t spic_pcba = PNV10_XSCOM_PIB_SPIC_BASE +
> +        s->spic_num * PNV10_XSCOM_PIB_SPIC_SIZE;
> +    uint32_t reg[] = {
> +        cpu_to_be32(spic_pcba),
> +        cpu_to_be32(PNV10_XSCOM_PIB_SPIC_SIZE)
> +    };
> +    name = g_strdup_printf("pnv_spi@%x", spic_pcba);
> +    s_offset = fdt_add_subnode(fdt, offset, name);
> +    _FDT(s_offset);
> +
> +    _FDT(fdt_setprop(fdt, s_offset, "reg", reg, sizeof(reg)));
> +    _FDT(fdt_setprop(fdt, s_offset, "compatible", compat, sizeof(compat)));
> +    _FDT((fdt_setprop_cell(fdt, s_offset, "spic_num#", s->spic_num)));
> +    return 0;
> +}
> +
> +static void pnv_spi_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PnvXScomInterfaceClass *xscomc = PNV_XSCOM_INTERFACE_CLASS(klass);
> +
> +    xscomc->dt_xscom = pnv_spi_dt_xscom;
> +
> +    dc->desc = "PowerNV SPI";
> +    dc->realize = pnv_spi_realize;
> +    device_class_set_props(dc, pnv_spi_properties);
> +}
> +
> +static const TypeInfo pnv_spi_info = {
> +    .name          = TYPE_PNV_SPI,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(PnvSpi),
> +    .class_init    = pnv_spi_class_init,
> +    .interfaces    = (InterfaceInfo[]) {
> +        { TYPE_PNV_XSCOM_INTERFACE },
> +        { }
> +    }
> +};
> +
> +static void pnv_spi_register_types(void)
> +{
> +    type_register_static(&pnv_spi_info);
> +}
> +
> +type_init(pnv_spi_register_types);
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 78f83e78ce..4668d59eab 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -39,6 +39,9 @@ config POWERNV
>       select PCI_POWERNV
>       select PCA9552
>       select PCA9554
> +    select SSI
> +    select SSI_M25P80
> +    select PNV_SPI
>   
>   config PPC405
>       bool
> diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
> index 83ee53c1d0..8d180de7cf 100644
> --- a/hw/ssi/Kconfig
> +++ b/hw/ssi/Kconfig
> @@ -24,3 +24,7 @@ config STM32F2XX_SPI
>   config BCM2835_SPI
>       bool
>       select SSI
> +
> +config PNV_SPI
> +    bool
> +    select SSI
> diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
> index b999aeb027..b7ad7fca3b 100644
> --- a/hw/ssi/meson.build
> +++ b/hw/ssi/meson.build
> @@ -12,3 +12,4 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
>   system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_spi.c'))
>   system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
>   system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
> +system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
> diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
> index 2d5bd2b83d..4388024a05 100644
> --- a/hw/ssi/trace-events
> +++ b/hw/ssi/trace-events
> @@ -32,3 +32,9 @@ ibex_spi_host_reset(const char *msg) "%s"
>   ibex_spi_host_transfer(uint32_t tx_data, uint32_t rx_data) "tx_data: 0x%" PRIx32 " rx_data: @0x%" PRIx32
>   ibex_spi_host_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
>   ibex_spi_host_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size %u:"
> +
> +#pnv_spi.c
> +pnv_spi_read(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
> +pnv_spi_write(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " val 0x%" PRIx64
> +pnv_spi_read_RDR(uint64_t val) "data extracted = 0x%" PRIx64
> +pnv_spi_write_TDR(uint64_t val) "being written, data written = 0x%" PRIx64


