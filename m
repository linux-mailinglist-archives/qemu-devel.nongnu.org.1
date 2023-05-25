Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6558710AE5
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:29:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q298U-000114-Gw; Thu, 25 May 2023 07:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q2983-00083e-2W; Thu, 25 May 2023 07:27:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q297z-0000aR-Pq; Thu, 25 May 2023 07:27:34 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRlyf2BlHz6J7Fx;
 Thu, 25 May 2023 19:22:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 12:27:12 +0100
Date: Thu, 25 May 2023 12:27:11 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, <qemu-arm@nongnu.org>, Peter Delevoryas
 <peter@pjd.dev>, Keith Busch <kbusch@kernel.org>, "=?ISO-8859-1?Q?C=E9dric?=
 Le Goater" <clg@kaod.org>, Jason Wang <jasowang@redhat.com>, Lior Weintraub
 <liorw@pliops.com>, <qemu-block@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Matt Johnston <matt@codeconstruct.com.au>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2 1/3] hw/i2c: add mctp core
Message-ID: <20230525122711.00002a61@Huawei.com>
In-Reply-To: <20230425063540.46143-2-its@irrelevant.dk>
References: <20230425063540.46143-1-its@irrelevant.dk>
 <20230425063540.46143-2-its@irrelevant.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Tue, 25 Apr 2023 08:35:38 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add an abstract MCTP over I2C endpoint model. This implements MCTP
> control message handling as well as handling the actual I2C transport
> (packetization).
> 
> Devices are intended to derive from this and implement the class
> methods.
> 
> Parts of this implementation is inspired by code[1] previously posted by
> Jonathan Cameron.
> 
>   [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

This is very useful for the CXL MCTP CCI support - got rid of most of the
nasty code when I moved over to using this (will post code shortly)

A few comments inline - but all trivial stuff.

What I can give now though is:
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
> new file mode 100644
> index 000000000000..0f4045d0d685
> --- /dev/null
> +++ b/hw/i2c/mctp.c
> @@ -0,0 +1,352 @@
...

> +enum {
> +    MCTP_CONTROL_SET_EID                    = 0x01,
> +    MCTP_CONTROL_GET_EID                    = 0x02,
> +    MCTP_CONTROL_GET_VERSION                = 0x04,
> +    MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT   = 0x05,
> +};

See below.  If the control command codes are down here, why
not also bring the structure they go in out of the header as well.
There should be no reason for an emulated device to be touching
that directly (I think anyway?)


> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> index 3996564c25c6..fd1f9022fd96 100644
> --- a/hw/i2c/meson.build
> +++ b/hw/i2c/meson.build
> @@ -1,5 +1,6 @@
>  i2c_ss = ss.source_set()
>  i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
> +i2c_ss.add(when: 'CONFIG_MCTP_I2C', if_true: files('mctp.c'))
>  i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
>  i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
>  i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
> diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
> index 6a53c34e70b7..47f9eb24e033 100644
> --- a/hw/i2c/smbus_master.c
> +++ b/hw/i2c/smbus_master.c

While it's first used in this patch, the smbus pec code stuff
is from the SMBUS spec itself and stands independently of the rest of the
set.  As such I'd make this a precursor patch.

> @@ -15,6 +15,34 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus_master.h"
>  
> +static uint8_t crc8(uint16_t data)
> +{
> +#define POLY (0x1070U << 3)
> +    int i;
> +
> +    for (i = 0; i < 8; i++) {
> +        if (data & 0x8000) {
> +            data = data ^ POLY;
> +        }
> +
> +        data = data << 1;
> +    }
> +
> +    return (uint8_t)(data >> 8);
> +#undef POLY
> +}
> +
> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
> +{
> +    int i;
> +
> +    for (i = 0; i < len; i++) {
> +        crc = crc8((crc ^ buf[i]) << 8);
> +    }
> +
> +    return crc;
> +}
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
>  {

...


> diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
> new file mode 100644
> index 000000000000..c53ee6a3b61b
> --- /dev/null
> +++ b/include/hw/i2c/mctp.h
> @@ -0,0 +1,114 @@
> +#ifndef QEMU_I2C_MCTP_H
> +#define QEMU_I2C_MCTP_H
> +
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +#include "net/mctp.h"

I'd definitely put some specification references in here to the
MCTP SMBus/I2C Transport Binding Specification

> +
> +typedef struct MCTPI2CPacketHeader {
> +    uint8_t dest;
> +    uint8_t prot; 

This is called Command Code in the spec I'm looking at...
Why I have no idea given it always takes 0x0F

> +    uint8_t byte_count;
> +    uint8_t source;
> +} MCTPI2CPacketHeader;
> +
> +typedef struct MCTPI2CPacket {
> +    MCTPI2CPacketHeader i2c;
> +    MCTPPacket          mctp;
> +} MCTPI2CPacket;
> +
> +#define i2c_mctp_payload(buf) (buf + offsetof(MCTPI2CPacket, mctp.payload))
> +
> +#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
> +OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_ENDPOINT)
> +
> +struct MCTPI2CEndpointClass {
> +    I2CSlaveClass parent_class;
> +
> +    int (*put_message_bytes)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
> +    size_t (*get_message_bytes)(MCTPI2CEndpoint *mctp, uint8_t *buf,
> +                                size_t maxlen, uint8_t *mctp_flags);
> +
> +    void (*handle_message)(MCTPI2CEndpoint *mctp);
> +    void (*reset_message)(MCTPI2CEndpoint *mctp);
> +
> +    size_t (*get_message_types)(MCTPI2CEndpoint *mctp, uint8_t *data,
> +                                size_t maxlen);
> +};
> +
> +/*
> + * Maximum value of the SMBus Block Write "Byte Count" field (8 bits).
> + *
> + * This is the count of bytes that follow the Byte Count field and up to, but
> + * not including, the PEC byte.
> + */
> +#define I2C_MCTP_MAXBLOCK 255
> +
> +/*
> + * Maximum Transmission Unit under I2C.
> + *
> + * This is for the MCTP Packet Payload (255, subtracting the 4 byte MCTP Packet
> + * Header or the 1 byte MCTP/I2C piggy-backed source address).
> + */
> +#define I2C_MCTP_MAXMTU (I2C_MCTP_MAXBLOCK - (sizeof(MCTPPacketHeader) + 1))
> +
> +/*
> + * Maximum length of an MCTP/I2C packet.
> + *
> + * This is the sum of the three I2C header bytes (Destination target address,
> + * Command Code and Byte Count), the maximum number of bytes in a message (255)
> + * and the 1 byte Packet Error Code.
> + */
> +#define I2C_MCTP_MAX_LENGTH (3 + I2C_MCTP_MAXBLOCK + 1)
> +
> +/*
> + * Maximum length of an MCTP/I2C Control Message.
> + *
> + * This is the 64 byte MCTP Baseline Maximum Transmission Unit, adding the
> + * combined MCTP/I2C headers and the trailing 1 byte PEC.
> + */
> +#define I2C_MCTP_CONTROL_MAX_LENGTH \
> +    (sizeof(MCTPI2CPacket) + MCTP_BASELINE_MTU + 1)
> +
> +typedef enum {
> +    I2C_MCTP_STATE_IDLE,
> +    I2C_MCTP_STATE_RX_STARTED,
> +    I2C_MCTP_STATE_RX,
> +    I2C_MCTP_STATE_WAIT_TX,
> +    I2C_MCTP_STATE_TX,
> +} MCTPState;
> +
> +typedef enum {
> +    I2C_MCTP_STATE_TX_START_SEND,
> +    I2C_MCTP_STATE_TX_SEND_BYTE,
> +} MCTPTxState;
> +
> +typedef struct MCTPI2CEndpoint {
> +    I2CSlave parent_obj;
> +    I2CBus *i2c;
> +
> +    MCTPState state;
> +
> +    /* mctp endpoint identifier */
> +    uint8_t my_eid;
> +
> +    uint8_t  buffer[I2C_MCTP_MAX_LENGTH];
> +    uint64_t pos;
> +    size_t   len;

I'd not bother trying to align these. Just use 1 space
everywhere. It's inconsistent already...

> +
> +    struct {
> +        MCTPTxState state;
> +        bool is_control;
> +
> +        uint8_t eid;
> +        uint8_t addr;
> +        uint8_t pktseq;
> +        uint8_t flags;
> +
> +        QEMUBH *bh;
> +    } tx;
> +} MCTPI2CEndpoint;
> +
> +void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp);
> +
> +#endif /* QEMU_I2C_MCTP_H */
> diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
> index bb13bc423c22..ea5eff3a2cd0 100644
> --- a/include/hw/i2c/smbus_master.h
> +++ b/include/hw/i2c/smbus_master.h
> @@ -27,6 +27,9 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> +/* SMBus PEC */

Trivial, but I'd not bother with the comment given the function
name makes that clear.

> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
>  int smbus_receive_byte(I2CBus *bus, uint8_t addr);
> diff --git a/include/net/mctp.h b/include/net/mctp.h
> new file mode 100644
> index 000000000000..c936224ecf60
> --- /dev/null
> +++ b/include/net/mctp.h
> @@ -0,0 +1,43 @@
> +#ifndef QEMU_MCTP_H
> +#define QEMU_MCTP_H
> +
> +#define MCTP_BASELINE_MTU 64
> +
> +enum {
> +    MCTP_H_FLAGS_EOM = 1 << 6,
> +    MCTP_H_FLAGS_SOM = 1 << 7,
> +};
> +
> +enum {
> +    MCTP_MESSAGE_TYPE_CONTROL   = 0x0,
> +    MCTP_MESSAGE_TYPE_NMI       = 0x4,
As there is no need for the core mctp support to know about
the other protocols, I'd move them to the relevant device specific
emulation.  Otherwise we'll have potential churn and merge conflicts
in here if lots of new ones get added.
> +
> +    MCTP_MESSAGE_IC             = 1 << 7,

That's nasty - just make it a define rather than pushing it into
the enum.

> +};
> +
> +typedef struct MCTPPacketHeader {
> +    uint8_t version;
> +    struct {
> +        uint8_t dest;
> +        uint8_t source;
> +    } eid;
> +    uint8_t flags;
> +} MCTPPacketHeader;
> +
> +typedef struct MCTPPacket {
> +    MCTPPacketHeader hdr;
> +    uint8_t          payload[];
> +} MCTPPacket;
> +
Maybe worth some spec references in here to help reviewers find the
right tables.  This took a bit of finding...
Figure 20 in 1.3.0

> +typedef struct MCTPControlMessage {
> +    uint8_t type;
> +    uint8_t flags;

Perhaps good to add defines for the various fields hidden in flags.

> +    uint8_t command;

Maybe worth an enum for the many command codes.
Ah. There is one down in the implementation .c
Why not push this structure down there as well? 

> +    uint8_t data[];
> +} MCTPControlMessage;
> +
> +enum {
> +    MCTP_CONTROL_ERROR_UNSUPPORTED_CMD = 0x5,
> +};
> +
> +#endif /* QEMU_MCTP_H */


