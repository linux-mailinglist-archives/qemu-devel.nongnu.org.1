Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE57A0F5F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtOc-0007Zt-8s; Thu, 14 Sep 2023 16:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qgtOZ-0007YJ-8K; Thu, 14 Sep 2023 16:57:03 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qgtOW-0001u9-A7; Thu, 14 Sep 2023 16:57:02 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57361de8878so810243eaf.0; 
 Thu, 14 Sep 2023 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694725017; x=1695329817; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=e7ecPbyya53Ta7o9actpGFkYEruQhrx2bIbTivFbGjE=;
 b=BUcrwYlsRSnuI9YTYsmdzqwOGVro9fVbTOglvQI0TV0Yaz4Ppl16gpujaTfoEmCyVm
 pcbf/YDyeclSsFBKzzu9YjvzOx98q8gaLRlp/LWHr3HlVHjEdQ4mP0jprK5zv3huTe2j
 2jNu/lwL3vyerMkfBp6YxDpfk4+NDNjo+Ce8Z5ZDB3vHIYIOdaNDVQlMBrjgGOxV07eu
 ZjyBG705p8AeGkwDsnnu4Cipksrl3xTsHhqQWQSLMD6yy/v42c4D26RcrrUC1+hPjIhA
 H9JFRyZOJYS7vQAJh6ArwKWwZ2r5S0PcWCE5HBFF+LLen4sP2Y328O5bKc53pw6Kw4O+
 6TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694725017; x=1695329817;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7ecPbyya53Ta7o9actpGFkYEruQhrx2bIbTivFbGjE=;
 b=XASuBB8psGDPeqEhBrPp5Wg4nGrxXfGQZ7GYxYA0R8NVeDkQsmDpqRlAl5UlxPcxh1
 XOsD6J56STnYSaEL8AoLQDVY+I7PV35/vRC++HBOcSmQ9IOCzLO6+s7AYfck7OW82aCs
 sMvBOV4qaGR7fw8lcOXUqQqD2j/GZWF+6h4LUq33FkWMtCBa4nFh/OZGM9k2Ow4FSX/2
 3ZYKl6qwxKtXYWk635kmvMMl0UkdoHqcJuzuIAvvwdlsYDVBs3G0Kks0gkzDxv3MOGDA
 oTt6TzQDbVgEfZK9IYwcbwnrfQunaqX17+npNmTsNsoNdiFV8u7nVubvt9iHqaMl1Pss
 WKMw==
X-Gm-Message-State: AOJu0Yx0PAChML+ZGaLaEUBHqXVFbw3i+PQTb4bscOtTo42RtX39g7Vg
 eCYA4Phmu0ARnl5uv5JS3w==
X-Google-Smtp-Source: AGHT+IGKo53NaBGOmgpeWtdyF+vjlkgKduyccTPZv/SW3AhR+9HEJt3vH0heEP7JNgpGCuqzc8j3rg==
X-Received: by 2002:a05:6870:d58d:b0:1d5:f814:567b with SMTP id
 u13-20020a056870d58d00b001d5f814567bmr7198617oao.5.1694725017369; 
 Thu, 14 Sep 2023 13:56:57 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 cb2-20020a056871e10200b001d5902793d9sm1200455oac.39.2023.09.14.13.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:56:57 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:82e2:1f7b:b4e5:7826])
 by serve.minyard.net (Postfix) with ESMTPSA id 62943180108;
 Thu, 14 Sep 2023 20:56:56 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:56:55 -0500
From: Corey Minyard <minyard@acm.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v6 2/3] hw/i2c: add mctp core
Message-ID: <ZQNzlzSZ1D6PGOqk@mail.minyard.net>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230914-nmi-i2c-v6-2-11bbb4f74d18@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914-nmi-i2c-v6-2-11bbb4f74d18@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 14, 2023 at 11:53:42AM +0200, Klaus Jensen wrote:
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

I've been kind of watching this, I guess I need to review.  I've been
over the logic and it all looks good, I think.  So I can do:

Acked-by: Corey Minyard <cminyard@mvista.com>

Thanks to everyone that reviewed.

> 
> Squashed a fix[2] from Matt Johnston.
> 
>   [1]: https://lore.kernel.org/qemu-devel/20220520170128.4436-1-Jonathan.Cameron@huawei.com/
>   [2]: https://lore.kernel.org/qemu-devel/20221121080445.GA29062@codeconstruct.com.au/
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  MAINTAINERS           |   7 +
>  hw/arm/Kconfig        |   1 +
>  hw/i2c/Kconfig        |   4 +
>  hw/i2c/mctp.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/i2c/meson.build    |   1 +
>  hw/i2c/trace-events   |  13 ++
>  include/hw/i2c/mctp.h | 125 +++++++++++++++
>  include/net/mctp.h    |  35 ++++
>  8 files changed, 618 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f7a..3208ebb1bcde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3404,6 +3404,13 @@ F: tests/qtest/adm1272-test.c
>  F: tests/qtest/max34451-test.c
>  F: tests/qtest/isl_pmbus_vr-test.c
>  
> +MCTP I2C Transport
> +M: Klaus Jensen <k.jensen@samsung.com>
> +S: Maintained
> +F: hw/i2c/mctp.c
> +F: include/hw/i2c/mctp.h
> +F: include/net/mctp.h
> +
>  Firmware schema specifications
>  M: Philippe Mathieu-Daudé <philmd@linaro.org>
>  R: Daniel P. Berrange <berrange@redhat.com>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7e6834844051..5bcb1e0e8a6f 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -541,6 +541,7 @@ config ASPEED_SOC
>      select DS1338
>      select FTGMAC100
>      select I2C
> +    select I2C_MCTP
>      select DPS310
>      select PCA9552
>      select SERIAL
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 14886b35dac2..2b2a50b83d1e 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -6,6 +6,10 @@ config I2C_DEVICES
>      # to any board's i2c bus
>      bool
>  
> +config I2C_MCTP
> +    bool
> +    select I2C
> +
>  config SMBUS
>      bool
>      select I2C
> diff --git a/hw/i2c/mctp.c b/hw/i2c/mctp.c
> new file mode 100644
> index 000000000000..8d8e74567745
> --- /dev/null
> +++ b/hw/i2c/mctp.c
> @@ -0,0 +1,432 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * SPDX-FileCopyrightText: Copyright (c) 2023 Samsung Electronics Co., Ltd.
> + * SPDX-FileContributor: Klaus Jensen <k.jensen@samsung.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/i2c/smbus_master.h"
> +#include "hw/i2c/mctp.h"
> +#include "net/mctp.h"
> +
> +#include "trace.h"
> +
> +/* DSP0237 1.2.0, Figure 1 */
> +typedef struct MCTPI2CPacketHeader {
> +    uint8_t dest;
> +#define MCTP_I2C_COMMAND_CODE 0xf
> +    uint8_t command_code;
> +    uint8_t byte_count;
> +    uint8_t source;
> +} MCTPI2CPacketHeader;
> +
> +typedef struct MCTPI2CPacket {
> +    MCTPI2CPacketHeader i2c;
> +    MCTPPacket          mctp;
> +} MCTPI2CPacket;
> +
> +#define i2c_mctp_payload_offset offsetof(MCTPI2CPacket, mctp.payload)
> +#define i2c_mctp_payload(buf) (buf + i2c_mctp_payload_offset)
> +
> +/* DSP0236 1.3.0, Figure 20 */
> +typedef struct MCTPControlMessage {
> +#define MCTP_MESSAGE_TYPE_CONTROL 0x0
> +    uint8_t type;
> +#define MCTP_CONTROL_FLAGS_RQ               (1 << 7)
> +#define MCTP_CONTROL_FLAGS_D                (1 << 6)
> +    uint8_t flags;
> +    uint8_t command_code;
> +    uint8_t data[];
> +} MCTPControlMessage;
> +
> +enum MCTPControlCommandCodes {
> +    MCTP_CONTROL_SET_EID                    = 0x01,
> +    MCTP_CONTROL_GET_EID                    = 0x02,
> +    MCTP_CONTROL_GET_VERSION                = 0x04,
> +    MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT   = 0x05,
> +};
> +
> +#define MCTP_CONTROL_ERROR_UNSUPPORTED_CMD 0x5
> +
> +#define i2c_mctp_control_data_offset \
> +    (i2c_mctp_payload_offset + offsetof(MCTPControlMessage, data))
> +#define i2c_mctp_control_data(buf) (buf + i2c_mctp_control_data_offset)
> +
> +/**
> + * The byte count field in the SMBUS Block Write containers the number of bytes
> + * *following* the field itself.
> + *
> + * This is at least 5.
> + *
> + * 1 byte for the MCTP/I2C piggy-backed I2C source address in addition to the
> + * size of the MCTP transport/packet header.
> + */
> +#define MCTP_I2C_BYTE_COUNT_OFFSET (sizeof(MCTPPacketHeader) + 1)
> +
> +void i2c_mctp_schedule_send(MCTPI2CEndpoint *mctp)
> +{
> +    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(DEVICE(mctp)));
> +
> +    mctp->tx.state = I2C_MCTP_STATE_TX_START_SEND;
> +
> +    i2c_bus_master(i2c, mctp->tx.bh);
> +}
> +
> +static void i2c_mctp_tx(void *opaque)
> +{
> +    DeviceState *dev = DEVICE(opaque);
> +    I2CBus *i2c = I2C_BUS(qdev_get_parent_bus(dev));
> +    I2CSlave *slave = I2C_SLAVE(dev);
> +    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(dev);
> +    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
> +    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
> +    uint8_t flags = 0;
> +
> +    switch (mctp->tx.state) {
> +    case I2C_MCTP_STATE_TX_SEND_BYTE:
> +        if (mctp->pos < mctp->len) {
> +            uint8_t byte = mctp->buffer[mctp->pos];
> +
> +            trace_i2c_mctp_tx_send_byte(mctp->pos, byte);
> +
> +            /* send next byte */
> +            i2c_send_async(i2c, byte);
> +
> +            mctp->pos++;
> +
> +            break;
> +        }
> +
> +        /* packet sent */
> +        i2c_end_transfer(i2c);
> +
> +        /* end of any control data */
> +        mctp->len = 0;
> +
> +        /* fall through */
> +
> +    case I2C_MCTP_STATE_TX_START_SEND:
> +        if (mctp->tx.is_control) {
> +            /* packet payload is already in buffer; max 1 packet */
> +            flags = FIELD_DP8(flags, MCTP_H_FLAGS, SOM, 1);
> +            flags = FIELD_DP8(flags, MCTP_H_FLAGS, EOM, 1);
> +        } else {
> +            const uint8_t *payload;
> +
> +            /* get message bytes from derived device */
> +            mctp->len = mc->get_buf(mctp, &payload, I2C_MCTP_MAXMTU, &flags);
> +            assert(mctp->len <= I2C_MCTP_MAXMTU);
> +
> +            memcpy(pkt->mctp.payload, payload, mctp->len);
> +        }
> +
> +        if (!mctp->len) {
> +            trace_i2c_mctp_tx_done();
> +
> +            /* no more packets needed; release the bus */
> +            i2c_bus_release(i2c);
> +
> +            mctp->state = I2C_MCTP_STATE_IDLE;
> +            mctp->tx.is_control = false;
> +
> +            break;
> +        }
> +
> +        mctp->state = I2C_MCTP_STATE_TX;
> +
> +        pkt->i2c = (MCTPI2CPacketHeader) {
> +            .dest = mctp->tx.addr << 1,
> +            .command_code = MCTP_I2C_COMMAND_CODE,
> +            .byte_count = MCTP_I2C_BYTE_COUNT_OFFSET + mctp->len,
> +
> +            /* DSP0237 1.2.0, Figure 1 */
> +            .source = slave->address << 1 | 0x1,
> +        };
> +
> +        pkt->mctp.hdr = (MCTPPacketHeader) {
> +            .version = 0x1,
> +            .eid.dest = mctp->tx.eid,
> +            .eid.source = mctp->my_eid,
> +            .flags = flags,
> +        };
> +
> +        pkt->mctp.hdr.flags = FIELD_DP8(pkt->mctp.hdr.flags, MCTP_H_FLAGS,
> +                                        PKTSEQ, mctp->tx.pktseq++);
> +        pkt->mctp.hdr.flags = FIELD_DP8(pkt->mctp.hdr.flags, MCTP_H_FLAGS, TAG,
> +                                        mctp->tx.tag);
> +
> +        mctp->len += sizeof(MCTPI2CPacket);
> +        assert(mctp->len < I2C_MCTP_MAX_LENGTH);
> +
> +        mctp->buffer[mctp->len] = i2c_smbus_pec(0, mctp->buffer, mctp->len);
> +        mctp->len++;
> +
> +        trace_i2c_mctp_tx_start_send(mctp->len);
> +
> +        i2c_start_send_async(i2c, pkt->i2c.dest >> 1);
> +
> +        /* already "sent" the destination slave address */
> +        mctp->pos = 1;
> +
> +        mctp->tx.state = I2C_MCTP_STATE_TX_SEND_BYTE;
> +
> +        break;
> +    }
> +}
> +
> +static void i2c_mctp_set_control_data(MCTPI2CEndpoint *mctp, const void * buf,
> +                                      size_t len)
> +{
> +    assert(i2c_mctp_control_data_offset < I2C_MCTP_MAX_LENGTH - len);
> +    memcpy(i2c_mctp_control_data(mctp->buffer), buf, len);
> +
> +    assert(mctp->len < I2C_MCTP_MAX_LENGTH - len);
> +    mctp->len += len;
> +}
> +
> +static void i2c_mctp_handle_control_set_eid(MCTPI2CEndpoint *mctp, uint8_t eid)
> +{
> +    mctp->my_eid = eid;
> +
> +    uint8_t buf[] = {
> +        0x0, 0x0, eid, 0x0,
> +    };
> +
> +    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
> +}
> +
> +static void i2c_mctp_handle_control_get_eid(MCTPI2CEndpoint *mctp)
> +{
> +    uint8_t buf[] = {
> +        0x0, mctp->my_eid, 0x0, 0x0,
> +    };
> +
> +    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
> +}
> +
> +static void i2c_mctp_handle_control_get_version(MCTPI2CEndpoint *mctp)
> +{
> +    uint8_t buf[] = {
> +        0x0, 0x1, 0x0, 0x1, 0x3, 0x1,
> +    };
> +
> +    i2c_mctp_set_control_data(mctp, buf, sizeof(buf));
> +}
> +
> +static void i2c_mctp_handle_get_message_type_support(MCTPI2CEndpoint *mctp)
> +{
> +    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
> +    const uint8_t *types;
> +    size_t len;
> +
> +    len = mc->get_types(mctp, &types);
> +    assert(mctp->len <= MCTP_BASELINE_MTU - len);
> +
> +    i2c_mctp_set_control_data(mctp, types, len);
> +}
> +
> +static void i2c_mctp_handle_control(MCTPI2CEndpoint *mctp)
> +{
> +    MCTPControlMessage *msg = (MCTPControlMessage *)i2c_mctp_payload(mctp->buffer);
> +
> +    /* clear Rq/D */
> +    msg->flags &= ~(MCTP_CONTROL_FLAGS_RQ | MCTP_CONTROL_FLAGS_D);
> +
> +    mctp->len = sizeof(MCTPControlMessage);
> +
> +    trace_i2c_mctp_handle_control(msg->command_code);
> +
> +    switch (msg->command_code) {
> +    case MCTP_CONTROL_SET_EID:
> +        i2c_mctp_handle_control_set_eid(mctp, msg->data[1]);
> +        break;
> +
> +    case MCTP_CONTROL_GET_EID:
> +        i2c_mctp_handle_control_get_eid(mctp);
> +        break;
> +
> +    case MCTP_CONTROL_GET_VERSION:
> +        i2c_mctp_handle_control_get_version(mctp);
> +        break;
> +
> +    case MCTP_CONTROL_GET_MESSAGE_TYPE_SUPPORT:
> +        i2c_mctp_handle_get_message_type_support(mctp);
> +        break;
> +
> +    default:
> +        trace_i2c_mctp_unhandled_control(msg->command_code);
> +
> +        msg->data[0] = MCTP_CONTROL_ERROR_UNSUPPORTED_CMD;
> +        mctp->len++;
> +
> +        break;
> +    }
> +
> +    assert(mctp->len <= MCTP_BASELINE_MTU);
> +
> +    i2c_mctp_schedule_send(mctp);
> +}
> +
> +static int i2c_mctp_event_cb(I2CSlave *i2c, enum i2c_event event)
> +{
> +    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
> +    MCTPI2CEndpointClass *mc = MCTP_I2C_ENDPOINT_GET_CLASS(mctp);
> +    MCTPI2CPacket *pkt = (MCTPI2CPacket *)mctp->buffer;
> +    size_t payload_len;
> +    uint8_t pec, pktseq, msgtype;
> +    int ret;
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
> +        ret = mc->put_buf(mctp, i2c_mctp_payload(mctp->buffer), payload_len);
> +        if (ret < 0) {
> +            goto drop;
> +        }
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
> +
> +static int i2c_mctp_send_cb(I2CSlave *i2c, uint8_t data)
> +{
> +    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(i2c);
> +
> +    if (mctp->len < I2C_MCTP_MAX_LENGTH) {
> +        mctp->buffer[mctp->len++] = data;
> +        return 0;
> +    }
> +
> +    return -1;
> +}
> +
> +static void i2c_mctp_instance_init(Object *obj)
> +{
> +    MCTPI2CEndpoint *mctp = MCTP_I2C_ENDPOINT(obj);
> +
> +    mctp->tx.bh = qemu_bh_new(i2c_mctp_tx, mctp);
> +}
> +
> +static Property mctp_i2c_props[] = {
> +    DEFINE_PROP_UINT8("eid", MCTPI2CEndpoint, my_eid, 0x9),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void i2c_mctp_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    I2CSlaveClass *k = I2C_SLAVE_CLASS(oc);
> +
> +    k->event = i2c_mctp_event_cb;
> +    k->send = i2c_mctp_send_cb;
> +
> +    device_class_set_props(dc, mctp_i2c_props);
> +}
> +
> +static const TypeInfo i2c_mctp_info = {
> +    .name = TYPE_MCTP_I2C_ENDPOINT,
> +    .parent = TYPE_I2C_SLAVE,
> +    .abstract = true,
> +    .instance_init = i2c_mctp_instance_init,
> +    .instance_size = sizeof(MCTPI2CEndpoint),
> +    .class_init = i2c_mctp_class_init,
> +    .class_size = sizeof(MCTPI2CEndpointClass),
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&i2c_mctp_info);
> +}
> +
> +type_init(register_types)
> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> index b58bc167dbcd..c4bddc4f5024 100644
> --- a/hw/i2c/meson.build
> +++ b/hw/i2c/meson.build
> @@ -1,5 +1,6 @@
>  i2c_ss = ss.source_set()
>  i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
> +i2c_ss.add(when: 'CONFIG_I2C_MCTP', if_true: files('mctp.c'))
>  i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
>  i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
>  i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index d7b1e25858b1..5a5c64b2652a 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -45,3 +45,16 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
>  
>  pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
>  pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
> +
> +# mctp.c
> +i2c_mctp_tx_start_send(size_t len) "len %zu"
> +i2c_mctp_tx_send_byte(size_t pos, uint8_t byte) "pos %zu byte 0x%"PRIx8""
> +i2c_mctp_tx_done(void) "packet sent"
> +i2c_mctp_handle_control(uint8_t command) "command 0x%"PRIx8""
> +i2c_mctp_unhandled_control(uint8_t command) "command 0x%"PRIx8""
> +i2c_mctp_drop_invalid_length(unsigned byte_count, size_t expected) "byte_count %u expected %zu"
> +i2c_mctp_drop_invalid_pec(uint8_t pec, uint8_t expected) "pec 0x%"PRIx8" expected 0x%"PRIx8""
> +i2c_mctp_drop_invalid_eid(uint8_t eid, uint8_t expected) "eid 0x%"PRIx8" expected 0x%"PRIx8""
> +i2c_mctp_drop_invalid_pktseq(uint8_t pktseq, uint8_t expected) "pktseq 0x%"PRIx8" expected 0x%"PRIx8""
> +i2c_mctp_drop_short_packet(size_t len) "len %zu"
> +i2c_mctp_drop_expected_som(void) ""
> diff --git a/include/hw/i2c/mctp.h b/include/hw/i2c/mctp.h
> new file mode 100644
> index 000000000000..10c3fb904802
> --- /dev/null
> +++ b/include/hw/i2c/mctp.h
> @@ -0,0 +1,125 @@
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
> +     * put_buf() - receive incoming message fragment
> +     *
> +     * Return 0 for success or negative for error.
> +     */
> +    int (*put_buf)(MCTPI2CEndpoint *mctp, uint8_t *buf, size_t len);
> +
> +    /**
> +     * get_buf() - provide pointer to message fragment
> +     *
> +     * Called by the mctp subsystem to request a pointer to the next message
> +     * fragment. Subsequent calls MUST return next fragment (if any).
> +     *
> +     * Must return the number of bytes in message fragment.
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
> + * Header and the 1 byte MCTP/I2C piggy-backed source address).
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
> diff --git a/include/net/mctp.h b/include/net/mctp.h
> new file mode 100644
> index 000000000000..5d26d855dba0
> --- /dev/null
> +++ b/include/net/mctp.h
> @@ -0,0 +1,35 @@
> +#ifndef QEMU_MCTP_H
> +#define QEMU_MCTP_H
> +
> +#include "hw/registerfields.h"
> +
> +/* DSP0236 1.3.0, Section 8.3.1 */
> +#define MCTP_BASELINE_MTU 64
> +
> +/* DSP0236 1.3.0, Table 1, Message body */
> +FIELD(MCTP_MESSAGE_H, TYPE, 0, 7)
> +FIELD(MCTP_MESSAGE_H, IC,   7, 1)
> +
> +/* DSP0236 1.3.0, Table 1, MCTP transport header */
> +FIELD(MCTP_H_FLAGS, TAG,    0, 3);
> +FIELD(MCTP_H_FLAGS, TO,     3, 1);
> +FIELD(MCTP_H_FLAGS, PKTSEQ, 4, 2);
> +FIELD(MCTP_H_FLAGS, EOM,    6, 1);
> +FIELD(MCTP_H_FLAGS, SOM,    7, 1);
> +
> +/* DSP0236 1.3.0, Figure 4 */
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
> +#endif /* QEMU_MCTP_H */
> 
> -- 
> 2.42.0
> 
> 

