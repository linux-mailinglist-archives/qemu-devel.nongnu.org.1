Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D0718571
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:00:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NJ2-0002hC-73; Wed, 31 May 2023 11:00:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4NIx-0002gC-5G; Wed, 31 May 2023 11:00:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q4NIt-0001v9-LI; Wed, 31 May 2023 11:00:02 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWXNl4bFJz6J7TC;
 Wed, 31 May 2023 22:54:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 15:59:45 +0100
Date: Wed, 31 May 2023 15:59:44 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, Keith Busch
 <kbusch@kernel.org>, Jason Wang <jasowang@redhat.com>, Lior Weintraub
 <liorw@pliops.com>, Paolo Bonzini <pbonzini@redhat.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>, <qemu-arm@nongnu.org>, Matt Johnston
 <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>,
 <qemu-block@nongnu.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Klaus Jensen <k.jensen@samsung.com>, Peter Maydell
 <peter.maydell@linaro.org>, <gost.dev@samsung.com>
Subject: Re: [PATCH v3 2/3] hw/i2c: add mctp core
Message-ID: <20230531155944.00006309@Huawei.com>
In-Reply-To: <20230531114744.9946-3-its@irrelevant.dk>
References: <20230531114744.9946-1-its@irrelevant.dk>
 <20230531114744.9946-3-its@irrelevant.dk>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Wed, 31 May 2023 13:47:43 +0200
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
Hi Klaus,

A few minor comments inline.

With those tidied up feel free to add
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> +
> +        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_SOM) {
> +            mctp->tx.is_control = false;
> +
> +            if (mctp->state == I2C_MCTP_STATE_RX) {
> +                mc->reset(mctp);
> +            }
> +
> +            mctp->state = I2C_MCTP_STATE_RX;
> +
> +            mctp->tx.addr = pkt->i2c.source;
> +            mctp->tx.eid = pkt->mctp.hdr.eid.source;
> +            mctp->tx.flags = pkt->mctp.hdr.flags & 0x7;

Maybe worth either defining that mask, or adding a comment that this
is copying the msg tag.  Or rename flags...


> +            mctp->tx.pktseq = (pkt->mctp.hdr.flags >> 4) & 0x3;
> +
> +            if ((pkt->mctp.payload[0] & 0x7f) == MCTP_MESSAGE_TYPE_CONTROL) {
> +                mctp->tx.is_control = true;
> +
> +                i2c_mctp_handle_control(mctp);
> +
> +                return 0;
> +            }
> +        } else if (mctp->state == I2C_MCTP_STATE_RX_STARTED) {
> +            trace_i2c_mctp_drop_expected_som();
> +            goto drop;
> +        } else if (((pkt->mctp.hdr.flags >> 4) & 0x3) != (++mctp->tx.pktseq & 0x3)) {
> +            trace_i2c_mctp_drop_invalid_pktseq((pkt->mctp.hdr.flags >> 4) & 0x3,
> +                                               mctp->tx.pktseq & 0x3);
> +            goto drop;
> +        }
> +
> +        mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
> +
> +        if (pkt->mctp.hdr.flags & MCTP_H_FLAGS_EOM) {
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


> diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
> new file mode 100644
> index 000000000000..ea97792e8d43
> --- /dev/null
> +++ b/include/hw/i2c/mctp.h

...
> +struct MCTPI2CEndpointClass {
> +    I2CSlaveClass parent_class;
> +
> +    /**
> +     *
> +     * put_buf() - receive incoming message fragment
> +     *
> +     * Must returns 0 for succes or -1 for error.
> +     */
> +    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
> +
> +    /**
> +     * get_buf() - provide pointer to message fragment
> +     *
> +     * Called by the mctp subsystem to request a pointer to the next message
> +     * fragment. The implementation must advance its internal position such
> +     * that successive calls returns the next fragments.
> +     *
> +     * Must return the number of bytes available.
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
> +     * (i.e. `0x0(SUCCESS),0x1(ONE),0x4(NMI)`).

ONE?  Looks to be PLDM
Good to reference DSP0239 Management Component Transport Protocol (MCTP) IDs and Codes
which has the list.

> +     *
> +     * Returns the size of the response.
> +     */
> +    size_t (*get_types)(MCTPI2CEndpoint *mctp, const uint8_t **data);
> +};

> diff --git a/include/net/mctp.h b/include/net/mctp.h
> new file mode 100644
> index 000000000000..70b49235ddb2
> --- /dev/null
> +++ b/include/net/mctp.h
> @@ -0,0 +1,28 @@
> +#ifndef QEMU_MCTP_H
> +#define QEMU_MCTP_H
> +
> +#define MCTP_BASELINE_MTU 64

Ideally add a reference for this as well.

8.3.1 Baseline transmission unit in DSP0236 1.3.0
> +
> +enum {
> +    MCTP_H_FLAGS_EOM = 1 << 6,
> +    MCTP_H_FLAGS_SOM = 1 << 7,

Trivial: I'm not really seeing the enum here as useful vs
a pair of defines.

> +};
> +
> +#define MCTP_MESSAGE_IC (1 << 7)
> +



