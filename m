Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48E371868C
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:41:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Nvk-0004Af-Ca; Wed, 31 May 2023 11:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4Nvh-0004AL-U2; Wed, 31 May 2023 11:40:05 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4Nve-0001rO-TD; Wed, 31 May 2023 11:40:05 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYLw420qz67ftX;
 Wed, 31 May 2023 23:38:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 16:39:57 +0100
Date: Wed, 31 May 2023 16:39:57 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Keith Busch
 <kbusch@kernel.org>, Jason Wang <jasowang@redhat.com>, Lior Weintraub
 <liorw@pliops.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, <qemu-arm@nongnu.org>, Matt Johnston
 <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>,
 <qemu-block@nongnu.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <gost.dev@samsung.com>
Subject: Re: [PATCH v3 3/3] hw/nvme: add nvme management interface model
Message-ID: <20230531163957.0000494e@Huawei.com>
In-Reply-To: <20230531114744.9946-4-its@irrelevant.dk>
References: <20230531114744.9946-1-its@irrelevant.dk>
 <20230531114744.9946-4-its@irrelevant.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 31 May 2023 13:47:44 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add the 'nmi-i2c' device that emulates an NVMe Management Interface
> controller.
> 
> Initial support is very basic (Read NMI DS, Configuration Get).
> 
> This is based on previously posted code by Padmakar Kalghatgi, Arun
> Kumar Agasar and Saurav Kumar.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

A few comments inline - I dug into the specs this time so some
new questions.

Jonathan

> diff --git a/hw/nvme/nmi-i2c.c b/hw/nvme/nmi-i2c.c
> new file mode 100644
> index 000000000000..38e43e48fa51
> --- /dev/null
> +++ b/hw/nvme/nmi-i2c.c
> @@ -0,0 +1,367 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * SPDX-FileCopyrightText: Copyright (c) 2022 Samsung Electronics Co., Ltd.

Update to 2023?

> +typedef struct NMIRequest {
> +   uint8_t opc;
> +   uint8_t rsvd1[3];
> +   uint32_t dw0;
> +   uint32_t dw1;
> +   uint32_t mic;
> +} NMIRequest;
> +
> +typedef struct NMIResponse {
> +    uint8_t status;
> +    uint8_t response[3];
> +    uint8_t payload[]; /* includes the Message Integrity Check */
> +} NMIResponse;

Not used.

> +
> +typedef enum NMIReadDSType {
> +    NMI_CMD_READ_NMI_DS_SUBSYSTEM       = 0x0,
> +    NMI_CMD_READ_NMI_DS_PORTS           = 0x1,
> +    NMI_CMD_READ_NMI_DS_CTRL_LIST       = 0x2,
> +    NMI_CMD_READ_NMI_DS_CTRL_INFO       = 0x3,
> +    NMI_CMD_READ_NMI_DS_CMD_SUPPORT     = 0x4,
> +    NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT = 0x5,
> +} NMIReadDSType;
> +
> +static void nmi_set_parameter_error(NMIDevice *nmi, uint8_t bit, uint16_t byte)
> +{
> +    nmi->scratch[nmi->pos++] = 0x4;
> +    nmi->scratch[nmi->pos++] = bit;

Mask bit to only 3 bits?

> +    nmi->scratch[nmi->pos++] = (byte >> 4) & 0xf;
> +    nmi->scratch[nmi->pos++] = byte & 0xf;

Not following how byte is split up.  Figure 29 in 1.1d suggests it should be
in bits 23:08 and this doesn't match that.  Perhaps a reference given I guess
I'm looking at wrong thing.

> +}

> +static void nmi_handle_mi_read_nmi_ds(NMIDevice *nmi, NMIRequest *request)
> +{
> +    I2CSlave *i2c = I2C_SLAVE(nmi);
> +
> +    uint32_t dw0 = le32_to_cpu(request->dw0);
> +    uint8_t dtyp = (dw0 >> 24) & 0xf;
> +    uint8_t *buf;
> +    size_t len;
> +
> +    trace_nmi_handle_mi_read_nmi_ds(dtyp);
> +
> +    static uint8_t nmi_ds_subsystem[36] = {
> +        0x00,       /* success */
> +        0x20,       /* response data length */

Not the easiest datasheet to read, but I think length is 2 bytes.
Figure 93 in the 1.2b NMI spec has it as bits 15:00 in
a 24 bit field. Ah. I see this is 1.1 definition, in that it's
the same but in figure 89.


> +        0x00, 0x00, /* reserved */
> +        0x00,       /* number of ports */
> +        0x01,       /* major version */
> +        0x01,       /* minor version */
> +    };
> +
> +    static uint8_t nmi_ds_ports[36] = {
> +        0x00,       /* success */
> +        0x20,       /* response data length */

As above - this is 2 bytes.

> +        0x00, 0x00, /* reserved */
> +        0x02,       /* port type (smbus) */
> +        0x00,       /* reserved */
> +        0x40, 0x00, /* maximum mctp transission unit size (64 bytes) */
> +        0x00, 0x00, 0x00, 0x00, /* management endpoint buffer size */
> +        0x00, 0x00, /* vpd i2c address/freq */

Give separate bytes for the two things, why not just have two lines and
a comment for each one?

> +        0x00, 0x01, /* management endpoint i2c address/freq */

Same here though second byte isn't anything to do with frequency. Documnted
as NVMe Basic Management and indicates if that command is supported.

> +    };
> +
> +    static uint8_t nmi_ds_empty[8] = {
> +        0x00,       /* success */
> +        0x02,       /* response data length */
> +        0x00, 0x00, /* reserved */
> +        0x00, 0x00, /* number of controllers */
A reference for this would be good as I'm not sure it's defined in the NMI spec.
Is it the controller list from 4.4.1 in the main NVME 2.0 spec?


> +        0x00, 0x00, /* padding */
> +    };
> +
> +    switch (dtyp) {
> +    case NMI_CMD_READ_NMI_DS_SUBSYSTEM:
> +        len = 36;
sizeof(nmi_ds_subsystem)  Might as well keep that 36 in just one place.
> +        buf = nmi_ds_subsystem;
> +
> +        break;
> +
> +    case NMI_CMD_READ_NMI_DS_PORTS:
> +        len = 36;
> +        buf = nmi_ds_ports;
same here?
> +
> +        /* patch in the i2c address of the endpoint */
> +        buf[14] = i2c->address;

If you have multiple instances of this as they will
race over the static buffer.  Just make it non static and add
a comment on why.

> +
> +        break;
> +
> +    case NMI_CMD_READ_NMI_DS_CTRL_LIST:
> +    case NMI_CMD_READ_NMI_DS_CMD_SUPPORT:
> +    case NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT:
> +        len = 8;
> +        buf = nmi_ds_empty;
> +
> +        break;
> +
> +    default:
> +        nmi_set_parameter_error(nmi, offsetof(NMIRequest, dw0) + 4, 0);
> +
> +        return;
> +    }
> +
> +    memcpy(nmi->scratch + nmi->pos, buf, len);
> +    nmi->pos += len;
> +}
> +
> +enum {
> +    NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ                = 0x1,
> +    NMI_CMD_CONFIGURATION_GET_HEALTH_STATUS_CHANGE      = 0x2,
> +    NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT    = 0x3,
> +};
> +
> +static void nmi_handle_mi_config_get(NMIDevice *nmi, NMIRequest *request)
> +{
> +    uint32_t dw0 = le32_to_cpu(request->dw0);
> +    uint8_t identifier = dw0 & 0xff;
> +    uint8_t *buf;
> +
> +    static uint8_t smbus_freq[4] = {
> +        0x00,               /* success */
> +        0x01, 0x00, 0x00,   /* 100 kHz */
> +    };
> +
> +    static uint8_t mtu[4] = {
> +        0x00,               /* success */
> +        0x40, 0x00, 0x00,   /* 64 */

2 bytes only I think with another reserved.
Figure 66 in 1.1d

> +    };
> +
> +    trace_nmi_handle_mi_config_get(identifier);
> +
> +    switch (identifier) {
> +    case NMI_CMD_CONFIGURATION_GET_SMBUS_FREQ:
> +        buf = smbus_freq;
> +        break;
> +
> +    case NMI_CMD_CONFIGURATION_GET_MCTP_TRANSMISSION_UNIT:
> +        buf = mtu;
> +        break;
> +
> +    default:
> +        nmi_set_parameter_error(nmi, 0x0, offsetof(NMIRequest, dw0));
> +        return;
> +    }
> +
> +    memcpy(nmi->scratch + nmi->pos, buf, 4);
> +    nmi->pos += 4;
> +}
> +
> +enum {
> +    NMI_CMD_READ_NMI_DS         = 0x0,
> +    NMI_CMD_CONFIGURATION_GET   = 0x4,
> +};
> +
> +static void nmi_handle_mi(NMIDevice *nmi, NMIMessage *msg)
> +{
> +    NMIRequest *request = (NMIRequest *)msg->payload;
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
> +enum {
> +    NMI_MESSAGE_TYPE_NMI = 0x1,
> +};
> +



> +static size_t nmi_get_types(MCTPI2CEndpoint *mctp, const uint8_t **data)
> +{
> +    static const uint8_t buf[] = {
> +        0x0, 0x1, MCTP_MESSAGE_TYPE_NMI,
> +    };

Perhaps a comment that the 0x1 is the length.  Or you could define
a structure for this with a variable length final field?

Also, should the control type be reported?  I couldn't find a statement
that it shouldn't and it has a message ID.

> +
> +    *data = buf;
> +
> +    return sizeof(buf);
> +}
> +

