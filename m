Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB91D78D6A3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMTl-0007kj-2F; Wed, 30 Aug 2023 10:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMTa-0007Ih-LB; Wed, 30 Aug 2023 10:47:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMTT-0007qc-4T; Wed, 30 Aug 2023 10:47:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbRpy0TS0z67yc8;
 Wed, 30 Aug 2023 22:42:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 15:47:09 +0100
Date: Wed, 30 Aug 2023 15:47:08 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Lior Weintraub <liorw@pliops.com>, Jeremy
 Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, "Klaus Jensen"
 <k.jensen@samsung.com>
Subject: Re: [PATCH v4 3/3] hw/nvme: add nvme management interface model
Message-ID: <20230830154708.000045ef@Huawei.com>
In-Reply-To: <20230823-nmi-i2c-v4-3-2b0f86e5be25@samsung.com>
References: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
 <20230823-nmi-i2c-v4-3-2b0f86e5be25@samsung.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 23 Aug 2023 11:22:00 +0200
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

Hi Klaus

Minor suggestions inline.  Either way given how trivial they are

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/hw/nvme/nmi-i2c.c b/hw/nvme/nmi-i2c.c
> new file mode 100644
> index 000000000000..9040ba28a87c
> --- /dev/null
> +++ b/hw/nvme/nmi-i2c.c
> @@ -0,0 +1,418 @@
...

> +#define NMI_MAX_MESSAGE_LENGTH 4224

Spec reference or similar would be good for this.

...

> +
> +static void nmi_set_error(NMIDevice *nmi, uint8_t status)
> +{
> +    uint8_t buf[4] = {};
> +
> +    buf[0] = status;

Could just do

    uint8_t buf[4] = { status, };

> +
> +    memcpy(nmi->scratch + nmi->pos, buf, 4);
> +    nmi->pos += 4;
sizeof(buf)

> +}
> +
> +static void nmi_handle_mi_read_nmi_ds(NMIDevice *nmi, NMIRequest *request)
> +{
> +    I2CSlave *i2c = I2C_SLAVE(nmi);
> +
> +    uint32_t dw0 = le32_to_cpu(request->dw0);
> +    uint8_t dtyp = (dw0 >> 24) & 0xf;

Maybe FIELD_EX32() with appropriate defines?

> +    uint8_t *buf;
> +    size_t len;
> +
> +    trace_nmi_handle_mi_read_nmi_ds(dtyp);
> +
> +    static uint8_t nmi_ds_subsystem[36] = {
> +        0x00,       /* success */
> +        0x20, 0x00, /* response data length */
> +        0x00,       /* reserved */
> +        0x00,       /* number of ports */
> +        0x01,       /* major version */
> +        0x01,       /* minor version */
> +    };
> +
> +    /* cannot be static since we need to patch in the i2c address */
> +    uint8_t nmi_ds_ports[36] = {
> +        0x00,       /* success */
> +        0x20, 0x00, /* response data length */
> +        0x00,       /* reserved */
> +        0x02,       /* port type (smbus) */
> +        0x00,       /* reserved */
> +        0x40, 0x00, /* maximum mctp transission unit size (64 bytes) */
> +        0x00, 0x00, 0x00, 0x00, /* management endpoint buffer size */
> +        0x00,       /* vpd i2c address */
> +        0x00,       /* vpd i2c frequency */
> +        0x00,       /* management endpoint i2c address */
> +        0x01,       /* management endpoint i2c frequency */
> +        0x00,       /* nvme basic management command NOT supported */
> +    };
> +
> +    /**
> +     * Controller Information is zeroed, since there are no associated
> +     * controllers at this point.
> +     */
> +    static uint8_t nmi_ds_ctrl[36] = {};
> +
> +    /**
> +     * For the Controller List, Optionally Supported Command List and
> +     * Management Endpoint Buffer Supported Command List data structures.
> +     *
> +     * The Controller List data structure is defined in the NVM Express Base
> +     * Specification, revision 2.0b, Figure 134.
> +     */
> +    static uint8_t nmi_ds_empty[6] = {
> +        0x00,       /* success */
> +        0x02,       /* response data length */
> +        0x00, 0x00, /* reserved */
> +        0x00, 0x00, /* number of entries (zero) */
> +    };
> +
> +    switch (dtyp) {
> +    case NMI_CMD_READ_NMI_DS_SUBSYSTEM:
> +        len = sizeof(nmi_ds_subsystem);
> +        buf = nmi_ds_subsystem;
> +
> +        break;
> +
> +    case NMI_CMD_READ_NMI_DS_PORTS:
> +        len = sizeof(nmi_ds_ports);
> +        buf = nmi_ds_ports;
> +
> +        /* patch in the i2c address of the endpoint */
> +        buf[14] = i2c->address;
> +
> +        break;
> +
> +    case NMI_CMD_READ_NMI_DS_CTRL_INFO:
> +        len = sizeof(nmi_ds_ctrl);
> +        buf = nmi_ds_ctrl;
> +
> +        break;
> +
> +    case NMI_CMD_READ_NMI_DS_CTRL_LIST:
> +    case NMI_CMD_READ_NMI_DS_OPT_CMD_SUPPORT:
> +    case NMI_CMD_READ_NMI_DS_MEB_CMD_SUPPORT:
> +        len = sizeof(nmi_ds_empty);
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

const for these? Same for other similar buffers.

> +
> +    static uint8_t mtu[4] = {
> +        0x00,       /* success */
> +        0x40, 0x00, /* 64 */
> +        0x00,       /* reserved */
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



> +static void nmi_handle(MCTPI2CEndpoint *mctp)
> +{
> +    NMIDevice *nmi = NMI_I2C_DEVICE(mctp);
> +    NMIMessage *msg = (NMIMessage *)nmi->buffer;
> +    uint32_t crc;
> +    uint8_t nmimt;
> +
> +    uint8_t buf[] = {

const?

> +        msg->mctpd,
> +        FIELD_DP8(msg->nmp, NMI_NMP, ROR, 1),
> +        0x0, 0x0,
> +    };
> +
> +    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, MT) != NMI_MCTPD_MT_NMI) {
> +        goto drop;
> +    }
> +
> +    if (FIELD_EX8(msg->mctpd, NMI_MCTPD, IC) != NMI_MCTPD_IC_ENABLED) {
> +        goto drop;
> +    }
> +
> +    memcpy(nmi->scratch, buf, sizeof(buf));

Jonathan



