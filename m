Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5070F8E5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pe0-0008PK-9O; Wed, 24 May 2023 10:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1pdz-0008P2-1z; Wed, 24 May 2023 10:39:15 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1q1pdv-000877-G6; Wed, 24 May 2023 10:39:13 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4c264f6c6so1010058e87.3; 
 Wed, 24 May 2023 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684939149; x=1687531149;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rdttr7haU7IIhhdvbjhpeJ/fAXXq8y2BiENAuYnRsT4=;
 b=XpI1SYyBrl/IFav9tvGqvs5JXeOJ9/y7tqwCmjw4yCDs0e3D/cr2miXR+q3Iv2yjno
 qScsMFrBfgzjgf2vRisR6qhN5ROLqFmeNIgI5j7VjqiQweD5/40jrpQRtjBH4dSrHP0w
 zbx6utT3m2DWLqFAiyv0AkKHkLcT8nAEuVHc8a9PjNPyPOpVKrnTp+WilEepdoH7fc+y
 UNovT7IyAyywW7QFahlb+a+BiOHfqyz9kOqv9m6QQvvILsDRqZwLPMOrDzzPJIzPUrhe
 0mypHe1mu6XmEDEI+9qto/bIFtbJkjpppok55QXQ9CfYizTU+F3OMeY2fJU1btElajFJ
 vWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684939149; x=1687531149;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rdttr7haU7IIhhdvbjhpeJ/fAXXq8y2BiENAuYnRsT4=;
 b=ItS8cGYWTMc4kyDQC9eC/rPNsuxW19HWNed6IGcKrdKjNVH5gbLl8qKgkxXmrn6urD
 S6cShrlGr+Fvegp4dIq+2d/xQjBzzA7bQ2p+DK97SQbuDSN2irf6EEOKX0yD6o9Wcp6l
 qmVIbUxkfbhF2onYc2XD3VXP3pSPXwVct5J83KEU4Pdm6LIICJ5Wwp8ta0dIblJxP5+C
 RCqKHRLGaKvkVw4KnYs9ejkW0jmSm1wY212ulGjzAW13cR/jzxBsAohMeO960VGSH0rG
 aMi5Xa7u4RkbpgxY92E6ABZmuaew8fW8jPNSHI0mODcoo5SGg+hf0hKIhUfS6Sy0nCSH
 Yivg==
X-Gm-Message-State: AC+VfDwDlKFeiJJ2iOac9f5WWciTxrw2Sim5qRK73OHXFaApRR2lg6MG
 dX5LOXmAj31js8Sjies3060=
X-Google-Smtp-Source: ACHHUZ6zZ7T3uxBWGf/qxX8OUtFbwQHX4Lf+Q8yYdA3LtVT0bIFQLbjCFgzK7VfGJBoJwqKtG56giA==
X-Received: by 2002:ac2:44d6:0:b0:4f1:3eca:769c with SMTP id
 d22-20020ac244d6000000b004f13eca769cmr5189309lfm.42.1684939148380; 
 Wed, 24 May 2023 07:39:08 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a2e2e07000000b002a8bb52d994sm2094719lju.25.2023.05.24.07.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 07:39:07 -0700 (PDT)
Date: Wed, 24 May 2023 16:39:06 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: qemu-devel@nongnu.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:Xilinx ZynqMP and..." <qemu-arm@nongnu.org>
Subject: Re: [QEMU][PATCH v5 2/4] hw/net/can: Introduce Xilinx Versal CANFD
 controller
Message-ID: <20230524143905.GA20498@fralle-msi>
References: <20230519203658.21211-2-vikram.garhwal@amd.com>
 <20230519203658.21211-3-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203658.21211-3-vikram.garhwal@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

Hi Vikram,

On [2023 May 19] Fri 13:36:56, Vikram Garhwal wrote:
> The Xilinx Versal CANFD controller is developed based on SocketCAN, QEMU CAN bus
> implementation. Bus connection and socketCAN connection for each CAN module
> can be set through command lines.
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> ---
>  hw/net/can/meson.build             |    1 +
>  hw/net/can/trace-events            |    7 +
>  hw/net/can/xlnx-versal-canfd.c     | 2107 ++++++++++++++++++++++++++++
>  include/hw/net/xlnx-versal-canfd.h |   87 ++
>  4 files changed, 2202 insertions(+)
>  create mode 100644 hw/net/can/xlnx-versal-canfd.c
>  create mode 100644 include/hw/net/xlnx-versal-canfd.h
> 
> diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
> index 8fabbd9ee6..8d85201cb0 100644
> --- a/hw/net/can/meson.build
> +++ b/hw/net/can/meson.build
> @@ -5,3 +5,4 @@ softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
>  softmmu_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_core.c'))
>  softmmu_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan_pci.c'))
>  softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-can.c'))
> +softmmu_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-canfd.c'))
> diff --git a/hw/net/can/trace-events b/hw/net/can/trace-events
> index 8346a98ab5..de64ac1b31 100644
> --- a/hw/net/can/trace-events
> +++ b/hw/net/can/trace-events
> @@ -7,3 +7,10 @@ xlnx_can_filter_mask_pre_write(uint8_t filter_num, uint32_t value) "Filter%d MAS
>  xlnx_can_tx_data(uint32_t id, uint8_t dlc, uint8_t db0, uint8_t db1, uint8_t db2, uint8_t db3, uint8_t db4, uint8_t db5, uint8_t db6, uint8_t db7) "Frame: ID: 0x%08x DLC: 0x%02x DATA: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x"
>  xlnx_can_rx_data(uint32_t id, uint32_t dlc, uint8_t db0, uint8_t db1, uint8_t db2, uint8_t db3, uint8_t db4, uint8_t db5, uint8_t db6, uint8_t db7) "Frame: ID: 0x%08x DLC: 0x%02x DATA: 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x"
>  xlnx_can_rx_discard(uint32_t status) "Controller is not enabled for bus communication. Status Register: 0x%08x"
> +
> +# xlnx-versal-canfd.c
> +xlnx_canfd_update_irq(char *path, uint32_t isr, uint32_t ier, uint32_t irq) "%s: ISR: 0x%08x IER: 0x%08x IRQ: 0x%08x"
> +xlnx_canfd_rx_fifo_filter_reject(char *path, uint32_t id, uint8_t dlc) "%s: Frame: ID: 0x%08x DLC: 0x%02x"
> +xlnx_canfd_rx_data(char *path, uint32_t id, uint8_t dlc, uint8_t flags) "%s: Frame: ID: 0x%08x DLC: 0x%02x CANFD Flag: 0x%02x"
> +xlnx_canfd_tx_data(char *path, uint32_t id, uint8_t dlc, uint8_t flgas) "%s: Frame: ID: 0x%08x DLC: 0x%02x CANFD Flag: 0x%02x"
> +xlnx_canfd_reset(char *path, uint32_t val) "%s: Resetting controller with value = 0x%08x"
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> new file mode 100644
> index 0000000000..bb86b3a9cf
> --- /dev/null
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -0,0 +1,2107 @@
> +/*
> + * QEMU model of the Xilinx Versal CANFD device.
> + *
> + * This implementation is based on the following datasheet:
> + * https://docs.xilinx.com/v/u/2.0-English/pg223-canfd
> + *
> + * Copyright (c) 2022 AMD Inc.

s/2022 AMD Inc/2023 Advanced Micro Devices, Inc/


> + *
> + * Written-by: Vikram Garhwal <vikram.garhwal@amd.com>
> + *
> + * Based on QEMU CANFD Device emulation implemented by Jin Yang, Deniz Eren and
> + * Pavel Pisa
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +

.
.
.

> +REG32(STATUS_REGISTER, 0x18)
> +    FIELD(STATUS_REGISTER, TDCV, 16, 7)
> +    FIELD(STATUS_REGISTER, SNOOP, 12, 1)
> +    FIELD(STATUS_REGISTER, BSFR_CONFIG, 10, 1)
> +    FIELD(STATUS_REGISTER, PEE_CONFIG, 9, 1)
> +    FIELD(STATUS_REGISTER, ESTAT, 7, 2)
> +    FIELD(STATUS_REGISTER, ERRWRN, 6, 1)
> +    FIELD(STATUS_REGISTER, BBSY, 5, 1)
> +    FIELD(STATUS_REGISTER, BIDLE, 4, 1)
> +    FIELD(STATUS_REGISTER, NORMAL, 3, 1)
> +    FIELD(STATUS_REGISTER, SLEEP, 2, 1)
> +    FIELD(STATUS_REGISTER, LBACK, 1, 1)
> +    FIELD(STATUS_REGISTER, CONFIG, 0, 1)
> +REG32(INTERRUPT_STATUS_REGISTER, 0x1c)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TXEWMFLL, 31, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TXEOFLW, 30, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXBOFLW_BI, 24, 6)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXLRM_BI, 18, 6)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXMNF, 17, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXFWMFLL_1, 16, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXFOFLW_1, 15, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TXCRS, 14, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TXRRS, 13, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXFWMFLL, 12, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, WKUP, 11, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, SLP, 10, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, BSOFF, 9, 1)
> +    /*
> +     * In original hw description below bit is named as ERROR but ERROR field
> +     * name collides with a macro in Windows build. To avoid Windows build
> +     * failure, renaming the bit to ERROR_BIT manually.
> +     */

Below sounds better to me but since I'm not english native this is just a
suggestion (alternatively for my taste it is clear enough without the
comment too).

"In the original HW description below bit is named as ERROR but an ERROR
field name collides with a macro in the Windows build. To avoid Windows
build failures, the bit is renamed to ERROR_BIT."

> +    FIELD(INTERRUPT_STATUS_REGISTER, ERROR_BIT, 8, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXFOFLW, 6, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TSCNT_OFLW, 5, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, RXOK, 4, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, BSFRD, 3, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, PEE, 2, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, TXOK, 1, 1)
> +    FIELD(INTERRUPT_STATUS_REGISTER, ARBLST, 0, 1)
> +REG32(INTERRUPT_ENABLE_REGISTER, 0x20)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXEWMFLL, 31, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXEOFLW, 30, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXMNF, 17, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXFWMFLL_1, 16, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXFOFLW_1, 15, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXCRS, 14, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXRRS, 13, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXFWMFLL, 12, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EWKUP, 11, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ESLP, 10, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EBSOFF, 9, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EERROR, 8, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERFXOFLW, 6, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETSCNT_OFLW, 5, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ERXOK, 4, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EBSFRD, 3, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EPEE, 2, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, ETXOK, 1, 1)
> +    FIELD(INTERRUPT_ENABLE_REGISTER, EARBLOST, 0, 1)

.
.
.

> +static void canfd_register_types(void)
> +{
> +    type_register_static(&canfd_info);
> +}
> +
> +type_init(canfd_register_types)
> diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
> new file mode 100644
> index 0000000000..544e6545dc
> --- /dev/null
> +++ b/include/hw/net/xlnx-versal-canfd.h
> @@ -0,0 +1,87 @@
> +/*
> + * QEMU model of the Xilinx Versal CANFD Controller.
> + *
> + * Copyright (c) 2022 AMD Inc.

s/2022 AMD Inc/2023 Advanced Micro Devices, Inc/

> + *
> + * Written-by: Vikram Garhwal<vikram.garhwal@amd.com>
> + * Based on QEMU CANFD Device emulation implemented by Jin Yang, Deniz Eren and
> + * Pavel Pisa.
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_CANFD_XILINX_H
> +#define HW_CANFD_XILINX_H
> +
> +#include "hw/register.h"
> +#include "hw/ptimer.h"
> +#include "net/can_emu.h"
> +#include "hw/qdev-clock.h"
> +
> +#define TYPE_XILINX_CANFD "xlnx.versal-canfd"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCANFDState, XILINX_CANFD)
> +
> +#define NUM_REGS_PER_MSG_SPACE 18 /* 1 ID + 1 DLC + 16 Data(DW0 - DW15) regs. */
> +#define MAX_NUM_RX             64
> +#define OFFSET_RX1_DW15        (0x4144 / 4)
> +#define CANFD_TIMER_MAX        0xFFFFUL
> +#define CANFD_DEFAULT_CLOCK    (24 * 1000 * 1000)

s/24/25/

With above changes:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> +
> +#define XLNX_VERSAL_CANFD_R_MAX (OFFSET_RX1_DW15 + \
> +                    ((MAX_NUM_RX - 1) * NUM_REGS_PER_MSG_SPACE) + 1)
> +
> +typedef struct XlnxVersalCANFDState {
> +    SysBusDevice            parent_obj;
> +    MemoryRegion            iomem;
> +
> +    qemu_irq                irq_canfd_int;
> +    qemu_irq                irq_addr_err;
> +
> +    RegisterInfo            reg_info[XLNX_VERSAL_CANFD_R_MAX];
> +    RegisterAccessInfo      *tx_regs;
> +    RegisterAccessInfo      *rx0_regs;
> +    RegisterAccessInfo      *rx1_regs;
> +    RegisterAccessInfo      *af_regs;
> +    RegisterAccessInfo      *txe_regs;
> +    RegisterAccessInfo      *rx_mailbox_regs;
> +    RegisterAccessInfo      *af_mask_regs_mailbox;
> +
> +    uint32_t                regs[XLNX_VERSAL_CANFD_R_MAX];
> +
> +    ptimer_state            *canfd_timer;
> +
> +    CanBusClientState       bus_client;
> +    CanBusState             *canfdbus;
> +
> +    struct {
> +        uint8_t             rx0_fifo;
> +        uint8_t             rx1_fifo;
> +        uint8_t             tx_fifo;
> +        bool                enable_rx_fifo1;
> +        uint32_t            ext_clk_freq;
> +   } cfg;
> +
> +} XlnxVersalCANFDState;
> +
> +typedef struct tx_ready_reg_info {
> +    uint32_t can_id;
> +    uint32_t reg_num;
> +} tx_ready_reg_info;
> +
> +#endif
> -- 
> 2.17.1
> 

