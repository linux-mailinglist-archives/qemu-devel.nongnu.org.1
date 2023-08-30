Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57F78D68F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMEN-0001EB-Ne; Wed, 30 Aug 2023 10:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMEK-0001DK-T6; Wed, 30 Aug 2023 10:31:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbMEF-00047y-GO; Wed, 30 Aug 2023 10:31:36 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbRSn0gSPz67Q0T;
 Wed, 30 Aug 2023 22:27:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 15:31:24 +0100
Date: Wed, 30 Aug 2023 15:31:23 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Lior Weintraub <liorw@pliops.com>, Jeremy
 Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>, "Klaus Jensen"
 <k.jensen@samsung.com>
Subject: Re: [PATCH v4 2/3] hw/i2c: add mctp core
Message-ID: <20230830153123.00006cc4@Huawei.com>
In-Reply-To: <20230823-nmi-i2c-v4-2-2b0f86e5be25@samsung.com>
References: <20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com>
 <20230823-nmi-i2c-v4-2-2b0f86e5be25@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Wed, 23 Aug 2023 11:21:59 +0200
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
> Squashed a fix[2] from Matt Johnston.
> 
>   [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
>   [2]: https://lore.kernel.org/qemu-devel/20221121080445.GA29062@codeconstruct.com.au/
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

I made the minor changes to the CXL FM-API PoC to use this and all works as expected so

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Some minor things inline.  With those tidied up or ignored with clear reasoning.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
> new file mode 100644
> index 000000000000..217073d62435
> --- /dev/null
> +++ b/hw/i2c/mctp.c


...


> +static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
> +{
> +    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
> +    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
> +    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
> +    size_t payload_len;
> +    uint8_t pec, pktseq, msgtype;
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        if (mctp->state == I2C_MCTP_STATE_IDLE) {
> +            mctp->state = I2C_MCTP_STATE_RX_STARTED;
> +        } else if (mctp->state != I2C_MCTP_STATE_RX) {
> +            return -1;
> +        }
> +
> +        /* the i2c core eats the slave address, so put it back in */
> +        pkt->i2c.dest = i2c->address << 1;
> +        mctp->len = 1;
> +
> +        return 0;
> +
> +    case I2C_FINISH:
> +        if (mctp->len < sizeof(MCTPI2CPacket) + 1) {
> +            trace_i2c_mctp_drop_short_packet(mctp->len);
> +            goto drop;
> +        }
> +
> +        payload_len = mctp->len - (1 + offsetof(MCTPI2CPacket, mctp.payload));
> +
> +        if (pkt->i2c.byte_count + 3 != mctp->len - 1) {
> +            trace_i2c_mctp_drop_invalid_length(pkt->i2c.byte_count + 3,
> +                                               mctp->len - 1);
> +            goto drop;
> +        }
> +
> +        pec = i2c_smbus_pec(0, mctp->buffer, mctp->len - 1);
> +        if (mctp->buffer[mctp->len - 1] != pec) {
> +            trace_i2c_mctp_drop_invalid_pec(mctp->buffer[mctp->len - 1], pec);
> +            goto drop;
> +        }
> +
> +        if (!(pkt->mctp.hdr.eid.dest == mctp->my_eid ||
> +              pkt->mctp.hdr.eid.dest == 0)) {
> +            trace_i2c_mctp_drop_invalid_eid(pkt->mctp.hdr.eid.dest,
> +                                            mctp->my_eid);
> +            goto drop;
> +        }
> +
> +        pktseq = FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, PKTSEQ);
> +
> +        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, SOM)) {
> +            mctp->tx.is_control = false;
> +
> +            if (mctp->state == I2C_MCTP_STATE_RX) {
> +                mc->reset(mctp);
> +            }
> +
> +            mctp->state = I2C_MCTP_STATE_RX;
> +
> +            mctp->tx.addr = pkt->i2c.source >> 1;
> +            mctp->tx.eid = pkt->mctp.hdr.eid.source;
> +            mctp->tx.tag = FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, TAG);
> +            mctp->tx.pktseq = pktseq;
> +
> +            msgtype = FIELD_EX8(pkt->mctp.payload[0], MCTP_MESSAGE_H, TYPE);
> +
> +            if (msgtype == MCTP_MESSAGE_TYPE_CONTROL) {
> +                mctp->tx.is_control = true;
> +
> +                i2c_mctp_handle_control(mctp);
> +
> +                return 0;
> +            }
> +        } else if (mctp->state == I2C_MCTP_STATE_RX_STARTED) {
> +            trace_i2c_mctp_drop_expected_som();
> +            goto drop;
> +        } else if (pktseq != (++mctp->tx.pktseq & 0x3)) {
> +            trace_i2c_mctp_drop_invalid_pktseq(pktseq, mctp->tx.pktseq & 0x3);
> +            goto drop;
> +        }
> +
> +        mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);

Given this returns -1 on error should probably handle errors.


> +
> +        if (FIELD_EX8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, EOM)) {
> +            mc->handle(mctp);
> +            mctp->state = I2C_MCTP_STATE_WAIT_TX;
> +        }
> +
> +        return 0;
> +
> +    default:
> +        return -1;
> +    }
> +
> +drop:
> +    mc->reset(mctp);
> +
> +    mctp->state = I2C_MCTP_STATE_IDLE;
> +
> +    return 0;
> +}

...


> diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
> new file mode 100644
> index 000000000000..fccbf249cdbe
> --- /dev/null
> +++ b/include/hw/i2c/mctp.h
> @@ -0,0 +1,127 @@
> +#ifndef QEMU_I2C_MCTP_H
> +#define QEMU_I2C_MCTP_H
> +
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_MCTP_I2C_ENDPOINT "mctp-i2c-endpoint"
> +OBJECT_DECLARE_TYPE(MCTPI2CEndpoint, MCTPI2CEndpointClass, MCTP_I2C_ENDPOINT)
> +
> +struct MCTPI2CEndpointClass {
> +    I2CSlaveClass parent_class;
> +
> +    /**
> +     *

Drop the blank line for consistency with the other comments.

> +     * put_buf() - receive incoming message fragment
> +     *
> +     * Must returns 0 for succes or -1 for error.

I would expect any negative to count as error rather than just -1.
Also, simple imperative should be clear enough
	* Return 0 for success or negative for error.

> +     */
> +    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
> +
> +    /**
> +     * get_buf() - provide pointer to message fragment
> +     *
> +     * Called by the mctp subsystem to request a pointer to the next message
> +     * fragment. The implementation must advance its internal position such
> +     * that successive calls returns the next fragments.
Subsequent call with return next fragment.

Up to the implementation to decide how it does this.

> +     *
> +     * Must return the number of bytes available.
	Return number of bytes in message fragment.

Available might mean in all fragments.

> +     */
> +    size_t (*get_buf)(MCTPI2CEndpoint *mctp, const uint8_t **buf,
> +                      size_t maxlen, uint8_t *mctp_flags);
> +
> +    /**
> +     * handle() - handle an MCTP message
> +     *
> +     * Called by the mctp subsystem when a full message has been delivered and
> +     * may be parsed and processed.
> +     */
> +    void (*handle)(MCTPI2CEndpoint *mctp);
> +
> +    /**
> +     * reset() - reset internal state
> +     *
> +     * Called by the mctp subsystem in the event of some transport error.
> +     * Implementation must reset its internal state and drop any fragments
> +     * previously receieved.
> +     */
> +    void (*reset)(MCTPI2CEndpoint *mctp);
> +
> +    /**
> +     * get_types() - provide supported mctp message types
> +     *
> +     * Must provide a buffer with a full MCTP supported message types payload
> +     * (i.e. `0x0(SUCCESS),0x1(COUNT),0x4(NMI)`).
> +     *
> +     * Returns the size of the response.
> +     */
> +    size_t (*get_types)(MCTPI2CEndpoint *mctp, const uint8_t **data);
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
and the 1 byte.. ?

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
> +    uint8_t buffer[I2C_MCTP_MAX_LENGTH];
> +    uint64_t pos;
> +    size_t len;
> +
> +    struct {
> +        MCTPTxState state;
> +        bool is_control;
> +
> +        uint8_t eid;
> +        uint8_t addr;
> +        uint8_t pktseq;
> +        uint8_t tag;
> +
> +        QEMUBH *bh;
> +    } tx;
> +} MCTPI2CEndpoint;
> +
> +void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp);
> +
> +#endif /* QEMU_I2C_MCTP_H */



