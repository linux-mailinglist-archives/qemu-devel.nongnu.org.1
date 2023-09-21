Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FDC7A91E7
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDnP-0001Mw-Cy; Thu, 21 Sep 2023 03:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjDnN-0001Ma-CW; Thu, 21 Sep 2023 03:08:17 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjDnJ-0000fw-KQ; Thu, 21 Sep 2023 03:08:17 -0400
Received: from [192.168.68.112]
 (ppp14-2-88-115.adl-apt-pir-bras31.tpg.internode.on.net [14.2.88.115])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A36102003C;
 Thu, 21 Sep 2023 15:08:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1695280085;
 bh=D/gIWqcyKd41O9wt/wrIUdLx0GW2x+2dNhtQ9nyMY7w=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=TPUQA3/NxIWwL1Bj3YjGdNlHAFTwPBndkEEIQyaLalkMId4mXieYdU5gECkFqLAkL
 upw0ftFminJBicuriEg6ESHtahB/LDVq+WhVRA3nyEHkkAonIr9+OiqjCK3kAEA6xs
 qgeYjx5kA9QARG1oXl5khnYpEPtTSHRSQ2jzvfzI8k1KGIBNTJefsOQoAjb0xbl0Fi
 wVcn8UDKIiEprm442fXiOnjdVBbC1LjVsVidB3iVkjWYJ9WqQgmDT4SNIb7LDSQMf9
 HLDxDp5IzDoZkoDQmDrExRwMvULkCB0uMEvS8JXpP2WioidagHoCqI1RBSykbghEp7
 h+OKG+j68Sd0g==
Message-ID: <00465e1ef3f7321fa64ec428cbc242043ce0259a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 3/3] hw/nvme: add nvme management interface model
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,  Keith Busch
 <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,  Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Date: Thu, 21 Sep 2023 16:38:00 +0930
In-Reply-To: <20230914-nmi-i2c-v6-3-11bbb4f74d18@samsung.com>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230914-nmi-i2c-v6-3-11bbb4f74d18@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 2023-09-14 at 11:53 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Add the 'nmi-i2c' device that emulates an NVMe Management Interface
> controller.
>=20
> Initial support is very basic (Read NMI DS, Configuration Get).
>=20
> This is based on previously posted code by Padmakar Kalghatgi, Arun
> Kumar Agasar and Saurav Kumar.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/Kconfig      |   4 +
>  hw/nvme/meson.build  |   1 +
>  hw/nvme/nmi-i2c.c    | 407 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/nvme/trace-events |   6 +
>  4 files changed, 418 insertions(+)
>=20
> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
> index cfa2ab0f9d5a..e1f6360c0f4b 100644
> --- a/hw/nvme/Kconfig
> +++ b/hw/nvme/Kconfig
> @@ -2,3 +2,7 @@ config NVME_PCI
>      bool
>      default y if PCI_DEVICES || PCIE_DEVICES
>      depends on PCI
> +
> +config NVME_NMI_I2C
> +    bool
> +    default y if I2C_MCTP
> diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
> index 1a6a2ca2f307..7bc85f31c149 100644
> --- a/hw/nvme/meson.build
> +++ b/hw/nvme/meson.build
> @@ -1 +1,2 @@
>  system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c',=
 'ns.c', 'subsys.c'))
> +system_ss.add(when: 'CONFIG_NVME_NMI_I2C', if_true: files('nmi-i2c.c'))
> diff --git a/hw/nvme/nmi-i2c.c b/hw/nvme/nmi-i2c.c
> new file mode 100644
> index 000000000000..bf4648db0457
> --- /dev/null
> +++ b/hw/nvme/nmi-i2c.c
> @@ -0,0 +1,407 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * SPDX-FileCopyrightText: Copyright (c) 2023 Samsung Electronics Co., L=
td.
> + *
> + * SPDX-FileContributor: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
> + * SPDX-FileContributor: Arun Kumar Agasar <arun.kka@samsung.com>
> + * SPDX-FileContributor: Saurav Kumar <saurav.29@partner.samsung.com>
> + * SPDX-FileContributor: Klaus Jensen <k.jensen@samsung.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/crc32c.h"
> +#include "hw/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/i2c/mctp.h"
> +#include "net/mctp.h"
> +#include "trace.h"
> +
> +/* NVM Express Management Interface 1.2c, Section 3.1 */
> +#define NMI_MAX_MESSAGE_LENGTH 4224
> +
> +#define TYPE_NMI_I2C_DEVICE "nmi-i2c"
> +OBJECT_DECLARE_SIMPLE_TYPE(NMIDevice, NMI_I2C_DEVICE)
> +
> +typedef struct NMIDevice {
> +    MCTPI2CEndpoint mctp;
> +
> +    uint8_t buffer[NMI_MAX_MESSAGE_LENGTH];
> +    uint8_t scratch[NMI_MAX_MESSAGE_LENGTH];
> +
> +    size_t  len;
> +    int64_t pos;
> +} NMIDevice;
> +
> +FIELD(NMI_MCTPD, MT, 0, 7)
> +FIELD(NMI_MCTPD, IC, 7, 1)
> +
> +#define NMI_MCTPD_MT_NMI 0x4
> +#define NMI_MCTPD_IC_ENABLED 0x1
> +
> +FIELD(NMI_NMP, ROR, 7, 1)
> +FIELD(NMI_NMP, NMIMT, 3, 4)
> +
> +#define NMI_NMP_NMIMT_NVME_MI 0x1
> +#define NMI_NMP_NMIMT_NVME_ADMIN 0x2
> +
> +typedef struct NMIMessage {
> +    uint8_t mctpd;
> +    uint8_t nmp;
> +    uint8_t rsvd2[2];
> +    uint8_t payload[]; /* includes the Message Integrity Check */
> +} NMIMessage;
> +
> +typedef struct NMIRequest {
> +   uint8_t opc;
> +   uint8_t rsvd1[3];
> +   uint32_t dw0;
> +   uint32_t dw1;
> +   uint32_t mic;
> +} NMIRequest;
> +
> +FIELD(NMI_CMD_READ_NMI_DS_DW0, DTYP, 24, 8)
> +
> +typedef enum NMIReadDSType {
> +    NMI_CMD_READ_NMI_DS_SUBSYSTEM       =3D 0x0,
> +    NMI_CMD_READ_NMI_DS_PORTS           =3D 0x1,
> +    NMI_CMD_READ_NMI_DS_CTRL_LIST       =3D 0x2,
> +    NMI_CMD_READ_NMI_DS_CTRL_INFO       =3D 0x3,
> +    NMI_CMD_READ_NMI_DS_OPT_CMD_SUPPORT =3D 0x4,
> +    NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT =3D 0x5,
> +} NMIReadDSType;
> +
> +#define NMI_STATUS_INVALID_PARAMETER 0x4
> +
> +static void nmi_scratch_append(NMIDevice *nmi, const void *buf, size_t c=
ount)
> +{
> +    assert(nmi->pos + count <=3D NMI_MAX_MESSAGE_LENGTH);
> +
> +    memcpy(nmi->scratch + nmi->pos, buf, count);
> +    nmi->pos +=3D count;
> +}
> +
> +static void nmi_set_parameter_error(NMIDevice *nmi, uint8_t bit, uint16_=
t byte)
> +{
> +    /* NVM Express Management Interface 1.2c, Figure 30 */
> +    struct resp {
> +        uint8_t  status;
> +        uint8_t  bit;
> +        uint16_t byte;
> +    };
> +
> +    struct resp buf =3D {
> +        .status =3D NMI_STATUS_INVALID_PARAMETER,
> +        .bit =3D bit & 0x3,
> +        .byte =3D byte,
> +    };
> +
> +    nmi_scratch_append(nmi, &buf, sizeof(buf));
> +}
> +
> +static void nmi_set_error(NMIDevice *nmi, uint8_t status)
> +{
> +    const uint8_t buf[4] =3D {status,};
> +
> +    nmi_scratch_append(nmi, buf, sizeof(buf));
> +}
> +
> +static void nmi_handle_mi_read_nmi_ds(NMIDevice *nmi, NMIRequest *reques=
t)
> +{
> +    I2CSlave *i2c =3D I2C_SLAVE(nmi);
> +
> +    uint32_t dw0 =3D le32_to_cpu(request->dw0);
> +    uint8_t dtyp =3D FIELD_EX32(dw0, NMI_CMD_READ_NMI_DS_DW0, DTYP);
> +
> +    trace_nmi_handle_mi_read_nmi_ds(dtyp);
> +
> +    static const uint8_t nmi_ds_subsystem[36] =3D {
> +        0x00,       /* success */
> +        0x20, 0x00, /* response data length */
> +        0x00,       /* reserved */
> +        0x00,       /* number of ports */
> +        0x01,       /* major version */
> +        0x01,       /* minor version */
> +    };
> +
> +    /*
> +     * Cannot be static (or const) since we need to patch in the i2c

Solid nitpick, but it is declared const :)

> +     * address.
> +     */
> +    const uint8_t nmi_ds_ports[36] =3D {
> +        0x00,       /* success */
> +        0x20, 0x00, /* response data length */
> +        0x00,       /* reserved */
> +        0x02,       /* port type (smbus) */
> +        0x00,       /* reserved */
> +        0x40, 0x00, /* maximum mctp transission unit size (64 bytes) */
> +        0x00, 0x00, 0x00, 0x00, /* management endpoint buffer size */
> +        0x00,       /* vpd i2c address */
> +        0x00,       /* vpd i2c frequency */
> +        i2c->address, /* management endpoint i2c address */
> +        0x01,       /* management endpoint i2c frequency */
> +        0x00,       /* nvme basic management command NOT supported */
> +    };
> +
> +    /**
> +     * Controller Information is zeroed, since there are no associated
> +     * controllers at this point.
> +     */
> +    static const uint8_t nmi_ds_ctrl[36] =3D {};
> +
> +    /**
> +     * For the Controller List, Optionally Supported Command List and
> +     * Management Endpoint Buffer Supported Command List data structures=
.
> +     *
> +     * The Controller List data structure is defined in the NVM Express =
Base
> +     * Specification, revision 2.0b, Figure 134.
> +     */
> +    static const uint8_t nmi_ds_empty[6] =3D {
> +        0x00,       /* success */
> +        0x02,       /* response data length */
> +        0x00, 0x00, /* reserved */
> +        0x00, 0x00, /* number of entries (zero) */
> +    };
> +
> +    switch (dtyp) {
> +    case NMI_CMD_READ_NMI_DS_SUBSYSTEM:
> +        nmi_scratch_append(nmi, &nmi_ds_subsystem, sizeof(nmi_ds_subsyst=
em));
> +        return;
> +
> +    case NMI_CMD_READ_NMI_DS_PORTS:
> +        nmi_scratch_append(nmi, &nmi_ds_ports, sizeof(nmi_ds_ports));
> +        return;
> +
> +    case NMI_CMD_READ_NMI_DS_CTRL_INFO:
> +        nmi_scratch_append(nmi, &nmi_ds_ctrl, sizeof(nmi_ds_ctrl));
> +        return;
> +
> +    case NMI_CMD_READ_NMI_DS_CTRL_LIST:
> +    case NMI_CMD_READ_NMI_DS_OPT_CMD_SUPPORT:
> +    case NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT:
> +        nmi_scratch_append(nmi, &nmi_ds_empty, sizeof(nmi_ds_empty));
> +        return;
> +
> +    default:
> +        nmi_set_parameter_error(nmi, offsetof(NMIRequest, dw0) + 4, 0);
> +        return;
> +    }
> +}
> +
> +FIELD(NMI_CMD_CONFIGURATION_GET_DW0, IDENTIFIER, 0, 8)
> +
> +enum {
> +    NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ                =3D 0x1,
> +    NMI_CMD_CONFIGURATION_GET_HEALTH_STATUS_CHANGE      =3D 0x2,
> +    NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT    =3D 0x3,
> +};
> +
> +static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest *request=
)
> +{
> +    uint32_t dw0 =3D le32_to_cpu(request->dw0);
> +    uint8_t identifier =3D FIELD_EX32(dw0, NMI_CMD_CONFIGURATION_GET_DW0=
,
> +                                    IDENTIFIER);
> +    static const uint8_t smbus_freq[4] =3D {
> +        0x00,               /* success */
> +        0x01, 0x00, 0x00,   /* 100 kHz */
> +    };
> +
> +    static const uint8_t mtu[4] =3D {
> +        0x00,       /* success */
> +        0x40, 0x00, /* 64 */
> +        0x00,       /* reserved */
> +    };
> +
> +    trace_nmi_handle_mi_config_get(identifier);
> +
> +    switch (identifier) {
> +    case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
> +        nmi_scratch_append(nmi, &smbus_freq, sizeof(smbus_freq));
> +        return;
> +
> +    case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT:
> +        nmi_scratch_append(nmi, &mtu, sizeof(mtu));
> +        return;
> +
> +    default:
> +        nmi_set_parameter_error(nmi, 0x0, offsetof(NMIRequest, dw0));
> +        return;
> +    }
> +}
> +
> +enum {
> +    NMI_CMD_READ_NMI_DS         =3D 0x0,
> +    NMI_CMD_CONFIGURATION_GET   =3D 0x4,
> +};
> +
> +static void nmi_handle_mi(NMIDevice *nmi, NMIMessage *msg)
> +{
> +    NMIRequest *request =3D (NMIRequest *)msg->payload;
> +
> +    trace_nmi_handle_mi(request->opc);
> +
> +    switch (request->opc) {
> +    case NMI_CMD_READ_NMI_DS:
> +        nmi_handle_mi_read_nmi_ds(nmi, request);
> +        break;
> +
> +    case NMI_CMD_CONFIGURATION_GET:
> +        nmi_handle_mi_config_get(nmi, request);
> +        break;
> +
> +    default:
> +        nmi_set_parameter_error(nmi, 0x0, 0x0);
> +        fprintf(stderr, "nmi command 0x%x not handled\n", request->opc);
> +
> +        break;
> +    }
> +}
> +
> +static void nmi_reset(MCTPI2CEndpoint *mctp)
> +{
> +    NMIDevice *nmi =3D NMI_I2C_DEVICE(mctp);
> +    nmi->len =3D 0;
> +}
> +
> +static void nmi_handle(MCTPI2CEndpoint *mctp)
> +{
> +    NMIDevice *nmi =3D NMI_I2C_DEVICE(mctp);
> +    NMIMessage *msg =3D (NMIMessage *)nmi->buffer;
> +    uint32_t crc;
> +    uint8_t nmimt;
> +
> +    const uint8_t buf[] =3D {
> +        msg->mctpd,
> +        FIELD_DP8(msg->nmp, NMI_NMP, ROR, 1),
> +        0x0, 0x0,
> +    };
> +
> +    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, MT) !=3D NMI_MCTPD_MT_NMI) {
> +        goto drop;
> +    }
> +
> +    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, IC) !=3D NMI_MCTPD_IC_ENABLED) =
{
> +        goto drop;
> +    }
> +
> +    nmi->pos =3D 0;
> +    nmi_scratch_append(nmi, buf, sizeof(buf));
> +
> +    nmimt =3D FIELD_EX8(msg->nmp, NMI_NMP, NMIMT);
> +
> +    trace_nmi_handle_msg(nmimt);
> +
> +    switch (nmimt) {
> +    case NMI_NMP_NMIMT_NVME_MI:
> +        nmi_handle_mi(nmi, msg);
> +        break;
> +
> +    default:
> +        fprintf(stderr, "nmi message type 0x%x not handled\n", nmimt);
> +
> +        nmi_set_error(nmi, 0x3);

0x3 is Invalid Command Opcode? I feel it would be be helpful to give it
a name.

Otherwise, this looks good to me. I realise I haven't contributed much
upstream recently, but FWIW:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

> +
> +        break;
> +    }
> +
> +    crc =3D crc32c(0xffffffff, nmi->scratch, nmi->pos);
> +    nmi_scratch_append(nmi, &crc, sizeof(crc));
> +
> +    nmi->len =3D nmi->pos;
> +    nmi->pos =3D 0;
> +
> +    i2c_mctp_schedule_send(mctp);
> +
> +    return;
> +
> +drop:
> +    nmi_reset(mctp);
> +}
> +
> +static size_t nmi_get_buf(MCTPI2CEndpoint *mctp, const uint8_t **buf,
> +                          size_t maxlen, uint8_t *mctp_flags)
> +{
> +    NMIDevice *nmi =3D NMI_I2C_DEVICE(mctp);
> +    size_t len;
> +
> +    len =3D MIN(maxlen, nmi->len - nmi->pos);
> +
> +    if (len =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    if (nmi->pos =3D=3D 0) {
> +        *mctp_flags =3D FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, SOM, 1);
> +    }
> +
> +    *buf =3D nmi->scratch + nmi->pos;
> +    nmi->pos +=3D len;
> +
> +    if (nmi->pos =3D=3D nmi->len) {
> +        *mctp_flags =3D FIELD_DP8(*mctp_flags, MCTP_H_FLAGS, EOM, 1);
> +
> +        nmi->pos =3D nmi->len =3D 0;
> +    }
> +
> +    return len;
> +}
> +
> +static int nmi_put_buf(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len)
> +{
> +    NMIDevice *nmi =3D NMI_I2C_DEVICE(mctp);
> +
> +    if (nmi->len + len > NMI_MAX_MESSAGE_LENGTH) {
> +        return -1;
> +    }
> +
> +    memcpy(nmi->buffer + nmi->len, buf, len);
> +    nmi->len +=3D len;
> +
> +    return 0;
> +}
> +
> +static size_t nmi_get_types(MCTPI2CEndpoint *mctp, const uint8_t **data)
> +{
> +    /**
> +     * DSP0236 1.3.0, Table 19.
> +     *
> +     * This only includes message types that are supported *in addition*=
 to the
> +     * MCTP control message type.
> +     */
> +    static const uint8_t buf[] =3D {
> +        0x0,                /* success */
> +        0x1,                /* number of message types in list (supporte=
d) */
> +        NMI_MCTPD_MT_NMI,
> +    };
> +
> +    *data =3D buf;
> +
> +    return sizeof(buf);
> +}
> +
> +static void nvme_mi_class_init(ObjectClass *oc, void *data)
> +{
> +    MCTPI2CEndpointClass *mc =3D MCTP_I2C_ENDPOINT_CLASS(oc);
> +
> +    mc->get_types =3D nmi_get_types;
> +
> +    mc->get_buf =3D nmi_get_buf;
> +    mc->put_buf =3D nmi_put_buf;
> +
> +    mc->handle =3D nmi_handle;
> +    mc->reset =3D nmi_reset;
> +}
> +
> +static const TypeInfo nvme_mi =3D {
> +    .name =3D TYPE_NMI_I2C_DEVICE,
> +    .parent =3D TYPE_MCTP_I2C_ENDPOINT,
> +    .instance_size =3D sizeof(NMIDevice),
> +    .class_init =3D nvme_mi_class_init,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&nvme_mi);
> +}
> +
> +type_init(register_types);
> diff --git a/hw/nvme/trace-events b/hw/nvme/trace-events
> index 3a67680c6ad1..41e2c540dcf2 100644
> --- a/hw/nvme/trace-events
> +++ b/hw/nvme/trace-events
> @@ -216,3 +216,9 @@ pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submissio=
n queue doorbell write for
>  pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submi=
ssion queue doorbell write value beyond queue size, sqid=3D%"PRIu32", new_h=
ead=3D%"PRIu16", ignoring"
>  pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
>  pci_nvme_ub_too_many_mappings(void) "too many prp/sgl mappings"
> +
> +# nmi-i2c
> +nmi_handle_mi_read_nmi_ds(uint8_t dtyp) "dtyp 0x%"PRIx8""
> +nmi_handle_mi_config_get(uint8_t identifier) "identifier 0x%"PRIx8""
> +nmi_handle_mi(uint8_t opc) "opc 0x%"PRIx8""
> +nmi_handle_msg(uint8_t nmint) "nmint 0x%"PRIx8""
>=20


