Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA36816595
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 05:15:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF51b-0002xR-ME; Sun, 17 Dec 2023 23:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF51Z-0002wj-4y; Sun, 17 Dec 2023 23:14:37 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rF51V-0004gm-RX; Sun, 17 Dec 2023 23:14:36 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7cb337eafb8so536739241.0; 
 Sun, 17 Dec 2023 20:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702872872; x=1703477672; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rg2kohoA7yr9ddfFSSj6V6EHDoED0Rp82gnS7zVimFE=;
 b=EfpynGMkuZt8sDgDuqJrZFDR23tT29814Nc7gP5w2w6V2Lchul7hGh1T7GpfN06FR2
 YsMr6Y1myaT5vU+UBomg41MyXCe0Y8lh86qcA0PIEj/QKPJ7YLPoZmjUhAIsakHVc/QI
 X3JvVhV/keysehtMut8bijIEmU/u5A5WPTFST+CnQ8P29ulbNJ0GxCpuvq4T5KmYtlD4
 nAoCThulyQRXq/3F4NmK2Yhu8KgrHbQ7d6YAjqTwq7mQrtZp9ja959ghBHldFXoWonbw
 4y0FA+lDGTXoAgZqyjarINS6FITogGvsZ9Up92zBjo9EEdAG7GZwP5mWH4x6MjX64fOs
 qUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702872872; x=1703477672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rg2kohoA7yr9ddfFSSj6V6EHDoED0Rp82gnS7zVimFE=;
 b=tdRmwhGkZzETm+onnjwghRnx/ruuAYwySiYdSjItXd9g1vTttjMf33+M2aYHI52Tgz
 GwwCiafOciZ4ZGYJnAdfric07aL/1fZgidtjFP7oyUK8nWTdAY+LobL6Mtz+7p+dhnEs
 hMdLtgfROtcNCBJPiRjKH61Knk8BB0Ncj0C6TzEdIspcFk1SNr3m8b5F+EVFYnNKUUnp
 wKgy67F6mz4Jbg36vi1wgqzi257WI6hou+sOa1Oby7uXPdVJYOJyJdD6scETy9CE8/zy
 iuk7+kmcsFPwYawA6vjZvN4KiXF9p41KFuSznr66DlyOey4N86S2/O/UzdJ/ucesCY9h
 iDjA==
X-Gm-Message-State: AOJu0Yx5hicAVuWvV1MJapWKqhRJvhcx6vEuHH7x/ssRVyJbD0TaExqL
 EmqaqujSvKDt9BicXX442eaLdzqGfVALgDBe44g=
X-Google-Smtp-Source: AGHT+IFNVLt7BoNmHV0x5WqlHdTML9NUK+pJqb/RplLZAFJWJ3c86xQ3to1D/Ho1oTwM5+BSJF2Cw54FNTr2cITws2I=
X-Received: by 2002:ac5:cca6:0:b0:4b6:c325:6619 with SMTP id
 p6-20020ac5cca6000000b004b6c3256619mr308275vkm.1.1702872872142; Sun, 17 Dec
 2023 20:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20231122053251.440723-1-ethan84@andestech.com>
 <20231122053251.440723-4-ethan84@andestech.com>
In-Reply-To: <20231122053251.440723-4-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 Dec 2023 14:14:05 +1000
Message-ID: <CAKmqyKMx6QrZAEMKTDL=SPu_N=Ykf_PqLab+TZVyV=EvrARV4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] hw/dma: Add Andes ATCDMAC300 support
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, in.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 peterx@redhat.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 22, 2023 at 3:35=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> ATCDMAC300 is a direct memory access controller (DMAC) which transfers da=
ta
> efficiently between devices on the AMBA AXI4 bus.
>
> ATCDMAC300 supports up to 8 DMA channels. Each DMA channel provides a set=
 of
> registers to describe the intended data transfers
>
> To support RISC-V IOPMP, a memory access device needs to
> - Support setup the connection to IOPMP
> - Support asynchronous I/O to handle stall transactions
> - Support transaction information (optional)
>
> To setup the connection to IOPMP, function atcdmac300_connect_iopmp is ca=
lled.
> The iopmp_as and sid are needed, and transaction_info_sink is optional (n=
ull if
> it is not supported).
>
> To handle IOPMP stall transaction, this device uses asynchronous I/O by d=
oing
> memory access in bottom half coroutine. If it receives an IOPMP stall, th=
e
> coroutine yields to let the cpu execute then will retry at the bottom hal=
f
> called next time. You can set the iothread property to make the device ru=
n on
> iothread.
>
> To send transaction information to IOPMP streamsink, function
> transaction_info_push is called before memory access.
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  hw/dma/Kconfig              |   4 +
>  hw/dma/atcdmac300.c         | 566 ++++++++++++++++++++++++++++++++++++
>  hw/dma/meson.build          |   1 +
>  include/hw/dma/atcdmac300.h | 180 ++++++++++++
>  4 files changed, 751 insertions(+)
>  create mode 100644 hw/dma/atcdmac300.c
>  create mode 100644 include/hw/dma/atcdmac300.h
>
> diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
> index 98fbb1bb04..a1d335b52f 100644
> --- a/hw/dma/Kconfig
> +++ b/hw/dma/Kconfig
> @@ -30,3 +30,7 @@ config SIFIVE_PDMA
>  config XLNX_CSU_DMA
>      bool
>      select REGISTER
> +
> +config ATCDMAC300
> +    bool
> +    select STREAM
> diff --git a/hw/dma/atcdmac300.c b/hw/dma/atcdmac300.c
> new file mode 100644
> index 0000000000..7db408aa54
> --- /dev/null
> +++ b/hw/dma/atcdmac300.c
> @@ -0,0 +1,566 @@
> +/*
> + * Andes ATCDMAC300 (Andes Technology DMA Controller)
> + *
> + * Copyright (c) 2022 Andes Tech. Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/dma/atcdmac300.h"
> +#include "hw/irq.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "exec/memattrs.h"
> +#include "exec/address-spaces.h"
> +#include "hw/stream.h"
> +#include "hw/misc/riscv_iopmp_transaction_info.h"
> +
> +/* #define DEBUG_ANDES_ATCDMAC300 */
> +#define LOGGE(x...) qemu_log_mask(LOG_GUEST_ERROR, x)
> +#define xLOG(x...)
> +#define yLOG(x...) qemu_log(x)
> +#ifdef DEBUG_ANDES_ATCDMAC300
> +  #define LOG(x...) yLOG(x)
> +#else
> +  #define LOG(x...) xLOG(x)
> +#endif

Same comment about using trace here

> +
> +#define MEMTX_IOPMP_STALL (1 << 3)
> +
> +static void atcdmac300_dma_int_stat_update(ATCDMAC300State *s, int statu=
s,
> +                                           int ch)
> +{
> +    s->IntStatus |=3D (1 << (status + ch));
> +}
> +
> +static void atcdmac300_dma_reset_chan(ATCDMAC300State *s, int ch)
> +{
> +    if (s) {
> +        s->chan[ch].ChnCtrl &=3D ~(1 << CHAN_CTL_ENABLE);
> +        s->ChEN &=3D ~(1 << ch);
> +    }
> +}
> +
> +static void atcdmac300_dma_reset(ATCDMAC300State *s)
> +{
> +    int ch;
> +    for (ch =3D 0; ch < ATCDMAC300_MAX_CHAN; ch++) {
> +        atcdmac300_dma_reset_chan(s, ch);
> +    }
> +}
> +
> +static uint64_t atcdmac300_read(void *opaque, hwaddr offset, unsigned si=
ze)
> +{
> +    ATCDMAC300State *s =3D opaque;
> +    int ch =3D 0;
> +    uint64_t result =3D 0;
> +
> +    if (offset >=3D 0x40) {
> +        ch =3D ATCDMAC300_GET_CHAN(offset);
> +        offset =3D ATCDMAC300_GET_OFF(offset, ch);
> +    }
> +
> +    switch (offset) {
> +    case ATCDMAC300_DMA_CFG:
> +        result =3D s->DMACfg;
> +        break;
> +    case ATCDMAC300_DMAC_CTRL:
> +        break;
> +    case ATCDMAC300_CHN_ABT:
> +        break;
> +    case ATCDMAC300_INT_STATUS:
> +        result =3D s->IntStatus;
> +        break;
> +    case ATCDMAC300_CHAN_ENABLE:
> +        result =3D s->ChEN;
> +        break;
> +    case ATCDMAC300_CHAN_CTL:
> +        result =3D s->chan[ch].ChnCtrl;
> +        break;
> +    default:
> +        LOGGE("%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +              __func__, offset);
> +        break;
> +    }
> +
> +    LOG("### atcdmac300_read()=3D0x%lx, val=3D0x%lx\n", offset, result);
> +    return result;
> +}
> +
> +static void transaction_info_push(StreamSink *sink, uint8_t *buf,
> +                                bool eop)
> +{
> +    if (sink =3D=3D NULL) {
> +        /* Do nothing if streamsink is not connected */
> +        return;
> +    }
> +    if (eop) {
> +        while (stream_push(sink, buf, sizeof(iopmp_transaction_info), tr=
ue)
> +               =3D=3D 0) {
> +            ;
> +        }
> +    } else {
> +        while (stream_push(sink, buf, sizeof(iopmp_transaction_info), fa=
lse)
> +               =3D=3D 0) {
> +            ;
> +        }
> +    }
> +}
> +
> +static MemTxResult dma_iopmp_read(ATCDMAC300State *s, hwaddr addr, void =
*buf,
> +                                  hwaddr len,
> +                                  iopmp_transaction_info *transaction)
> +{
> +    MemTxResult result;
> +    if (s->iopmp_as) {
> +        if (s->transaction_info_sink) {
> +            transaction_info_push(s->transaction_info_sink,
> +                                  (uint8_t *)transaction, false);
> +        }
> +        MemTxAttrs dma_attrs =3D {.requester_id =3D s->sid};
> +        result =3D address_space_rw(s->iopmp_as, addr, dma_attrs,
> +                                buf, len, false);
> +        if (s->transaction_info_sink) {
> +            transaction_info_push(s->transaction_info_sink,
> +                                  (uint8_t *)transaction, true);
> +            return result;
> +        }
> +    }
> +    cpu_physical_memory_read(addr, buf, len);
> +    return MEMTX_OK;
> +}
> +
> +static MemTxResult dma_iopmp_write(ATCDMAC300State *s, hwaddr addr, void=
 *buf,
> +                                   hwaddr len,
> +                                   iopmp_transaction_info *transaction)
> +{
> +    MemTxResult result =3D 0;
> +    if (s->iopmp_as) {
> +        if (s->transaction_info_sink) {
> +            transaction_info_push(s->transaction_info_sink,
> +                                (uint8_t *)transaction, false);
> +        }
> +        MemTxAttrs dma_attrs =3D {.requester_id =3D s->sid};
> +        result =3D address_space_rw(s->iopmp_as, addr, dma_attrs,
> +                                  buf, len, true);
> +        if (s->transaction_info_sink) {
> +            transaction_info_push(s->transaction_info_sink,
> +                                  (uint8_t *)transaction, true);
> +            return result;
> +        }
> +    }
> +    cpu_physical_memory_write(addr, buf, len);
> +    return MEMTX_OK;
> +}
> +
> +static void atcdmac300_co_run_channel(void *opaque, int ch)
> +{
> +    ATCDMAC300State *s =3D opaque;
> +    int result;
> +    uint64_t src_addr, dst_addr;
> +    /* End address for AXI_BOUNDARY check */
> +    uint64_t src_end_addr, dst_end_addr;
> +    /* DMA register bit field */
> +    uint32_t src_addr_ctl, dst_addr_ctl, int_tc_mask, int_err_mask,
> +             int_abort_mask, burst_size, src_width, dst_width;
> +    /* Internal computation */
> +    uint32_t remain_size_byte, dst_remain_byte, burst_size_transfer,
> +             src_burst_remain, src_width_byte, dst_width_byte,
> +             burst_size_byte, dma_remain_transfer_size, buf_index;
> +    uint32_t axi_src_len, axi_dst_len;
> +    uint8_t buf[ATCDMAC300_MAX_BURST_SIZE * 32];
> +    iopmp_transaction_info src_transaction, dst_transaction;
> +    src_transaction.sid =3D s->sid;
> +    dst_transaction.sid =3D s->sid;
> +    if (((s->chan[ch].ChnCtrl >> CHAN_CTL_ENABLE) & 0x1) !=3D 0x1) {
> +        return;
> +    }
> +    src_width =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_SRC_WIDTH) &
> +                CHAN_CTL_SRC_WIDTH_MASK;
> +    dst_width =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_DST_WIDTH) &
> +                CHAN_CTL_DST_WIDTH_MASK;
> +    burst_size =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_SRC_BURST_SZ) &
> +                    CHAN_CTL_SRC_BURST_SZ_MASK;
> +    src_addr =3D (s->chan[ch].ChnSrcAddrH << 32) |
> +                s->chan[ch].ChnSrcAddr;
> +    dst_addr =3D (s->chan[ch].ChnDstAddrH << 32) |
> +                s->chan[ch].ChnDstAddr;
> +    src_addr_ctl =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_SRC_ADDR_CTL) &
> +                    CHAN_CTL_SRC_ADDR_CTL_MASK;
> +    dst_addr_ctl =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_DST_ADDR_CTL) &
> +                    CHAN_CTL_DST_ADDR_CTL_MASK;

This could use some more newlines to make it easier to read. There are
a few other places in the patch that could as well.

> +
> +    src_width_byte =3D 1 << src_width;
> +    dst_width_byte =3D 1 << dst_width;
> +    dma_remain_transfer_size =3D s->chan[ch].ChnTranSize;
> +    remain_size_byte =3D dma_remain_transfer_size * src_width_byte;
> +    int_tc_mask =3D (s->chan[ch].ChnCtrl >> CHAN_CTL_INT_TC_MASK_POS)
> +                    & 0x1;
> +    int_err_mask =3D (s->chan[ch].ChnCtrl >>
> +                    CHAN_CTL_INT_ERR_MASK_POS) & 0x1;
> +    int_abort_mask =3D (s->chan[ch].ChnCtrl >>
> +                        CHAN_CTL_INT_ABT_MASK_POS) & 0x1;
> +    burst_size_transfer =3D (1 << burst_size);
> +    burst_size_byte =3D burst_size_transfer * src_width_byte;
> +    if (remain_size_byte && burst_size < 11 &&
> +        src_width < 6 && dst_width < 6 &&
> +        (src_addr & (src_width_byte - 1)) =3D=3D 0 &&
> +        (dst_addr & (dst_width_byte - 1)) =3D=3D 0 &&
> +        (remain_size_byte & (dst_width_byte - 1)) =3D=3D 0 &&
> +        (burst_size_byte & (dst_width_byte - 1)) =3D=3D 0) {
> +        while (remain_size_byte > 0) {
> +            if (s->ChAbort & (1 << ch)) {
> +                /* check abort status before a dma brust start */
> +                s->ChAbort &=3D ~(1 << ch);
> +                atcdmac300_dma_reset_chan(s, ch);
> +                atcdmac300_dma_int_stat_update(s, INT_STATUS_ABT,
> +                                                ch);
> +                if (!int_abort_mask) {
> +                    qemu_irq_raise(s->irq);
> +                }
> +                return;
> +            }
> +            int i;
> +            src_burst_remain =3D MIN(burst_size_transfer,
> +                                   dma_remain_transfer_size);
> +            dst_remain_byte =3D src_burst_remain * src_width_byte;
> +            buf_index =3D 0;
> +            /* One DMA burst may need mutiple AXI bursts */
> +            while (src_burst_remain) {
> +                if (src_addr_ctl =3D=3D 0) {
> +                    axi_src_len =3D MIN(src_burst_remain,
> +                                      AXI_BURST_INC_LEN_MAX + 1);
> +                    src_end_addr =3D src_width_byte * axi_src_len + src_=
addr;
> +                    if ((src_addr & AXI_BOUNDARY) !=3D
> +                         (src_end_addr & AXI_BOUNDARY)) {
> +                            src_end_addr &=3D AXI_BOUNDARY;
> +                            axi_src_len =3D (src_end_addr - src_addr) /
> +                                          src_width_byte;
> +                        }
> +                    /* Convert AXI signal to general IOPMP transaction *=
/
> +                    src_transaction.start_addr =3D src_addr;
> +                    src_transaction.end_addr =3D src_end_addr - 1;
> +                }
> +                if (src_addr_ctl =3D=3D 1) {
> +                    /* AXI does not support decrement type, use fixed ty=
pe */
> +                    src_transaction.start_addr =3D src_addr;
> +                    src_transaction.end_addr =3D src_addr + src_width_by=
te - 1;
> +                }
> +                if (src_addr_ctl =3D=3D 2) {
> +                    src_transaction.start_addr =3D src_addr;
> +                    src_transaction.end_addr =3D src_addr + src_width_by=
te - 1;

Couldn't these be combined into a single `src_addr_ctl <=3D 2` ?

This logic is difficult to follow so anything that can simplify things
would be great

> +                }
> +                memset(buf, 0, sizeof(buf));
> +                /* src_burst */
> +                for (i =3D 0; i < axi_src_len; i++) {
> +                    if (src_addr_ctl =3D=3D 1) {
> +                        /* Change AXI addr for decrement address mode */
> +                        src_transaction.start_addr =3D src_addr;
> +                        src_transaction.end_addr =3D src_addr + src_widt=
h_byte
> +                                                   - 1;
> +                    }
> +                    buf_index +=3D src_width_byte;
> +                    result =3D dma_iopmp_read(s, src_addr, &buf[buf_inde=
x],
> +                                            src_width_byte, &src_transac=
tion);
> +                    while (result =3D=3D MEMTX_IOPMP_STALL) {
> +                        qemu_coroutine_yield();
> +                        result =3D dma_iopmp_read(s, src_addr, &buf[buf_=
index],
> +                                                src_width_byte,
> +                                                &src_transaction);
> +                    }
> +                    if (result !=3D MEMTX_OK) {
> +                        s->ChAbort &=3D ~(1 << ch);
> +                        atcdmac300_dma_int_stat_update(s,
> +                            INT_STATUS_ERR, ch);
> +                        atcdmac300_dma_reset_chan(s, ch);
> +                        if (!int_err_mask) {
> +                            qemu_irq_raise(s->irq);
> +                        }
> +                        return;
> +                    }
> +                    if (src_addr_ctl =3D=3D 0) {
> +                        src_addr +=3D src_width_byte;
> +                    }
> +                    if (src_addr_ctl =3D=3D 1) {
> +                        src_addr -=3D src_width_byte;
> +                    }
> +                }
> +                src_burst_remain -=3D axi_src_len;
> +                dma_remain_transfer_size -=3D axi_src_len;
> +                remain_size_byte -=3D axi_src_len * src_width_byte;
> +            }
> +            buf_index =3D 0;
> +            /* One src burst may need mutiple dst bursts*/
> +            while (dst_remain_byte > 0) {
> +                if (dst_addr_ctl =3D=3D 0) {
> +                    axi_dst_len =3D
> +                        (dst_remain_byte / dst_width_byte);
> +                    axi_dst_len =3D MIN(axi_dst_len,
> +                                        AXI_BURST_INC_LEN_MAX + 1);
> +                    dst_end_addr =3D dst_width_byte * axi_dst_len
> +                                    + dst_addr;
> +                        if ((dst_addr & AXI_BOUNDARY) !=3D
> +                            (dst_end_addr & AXI_BOUNDARY)) {
> +                            dst_end_addr &=3D AXI_BOUNDARY;
> +                            axi_dst_len =3D (dst_end_addr - dst_addr) /
> +                                          dst_width_byte;
> +                        }
> +                    dst_transaction.start_addr =3D dst_addr;
> +                    dst_transaction.end_addr =3D dst_end_addr - 1;
> +                }
> +                if (dst_addr_ctl =3D=3D 1) {
> +                    dst_transaction.start_addr =3D dst_addr;
> +                    dst_transaction.end_addr =3D dst_addr + dst_width_by=
te
> +                                            - 1;
> +                }
> +                if (dst_addr_ctl =3D=3D 2) {
> +                    dst_transaction.start_addr =3D dst_addr;
> +                    dst_transaction.end_addr =3D dst_addr + dst_width_by=
te
> +                                            - 1;
> +                }

Same here

> +                for (i =3D 0; i < axi_dst_len; i++) {
> +                    if (dst_addr_ctl =3D=3D 1) {
> +                        /* Change AXI addr for decrement address mode */
> +                        dst_transaction.start_addr =3D dst_addr;
> +                        dst_transaction.end_addr =3D dst_addr + dst_widt=
h_byte
> +                                                   - 1;
> +                    }
> +                    buf_index +=3D dst_width_byte;
> +                    result =3D dma_iopmp_write(s, dst_addr, &buf[buf_ind=
ex],
> +                                             dst_width_byte, &dst_transa=
ction);
> +                    while (result =3D=3D MEMTX_IOPMP_STALL) {
> +                        qemu_coroutine_yield();
> +                        result =3D dma_iopmp_write(s, dst_addr, &buf[buf=
_index],
> +                                                 dst_width_byte,
> +                                                 &dst_transaction);
> +                    }
> +                    if (result !=3D MEMTX_OK) {
> +                        s->ChAbort &=3D ~(1 << ch);
> +                        atcdmac300_dma_int_stat_update(s,
> +                            INT_STATUS_ERR, ch);
> +                        atcdmac300_dma_reset_chan(s, ch);
> +                        if (!int_err_mask) {
> +                            qemu_irq_raise(s->irq);
> +                        }
> +                        return;
> +                    }
> +                    if (dst_addr_ctl =3D=3D 0) {
> +                        dst_addr +=3D dst_width_byte;
> +                    }
> +                    if (dst_addr_ctl =3D=3D 1) {
> +                        dst_addr -=3D dst_width_byte;
> +                    }
> +                }
> +                dst_remain_byte -=3D dst_width_byte * axi_dst_len;
> +            }
> +        }
> +        /* DMA transfer complete */
> +        s->ChAbort &=3D ~(1 << ch);
> +        atcdmac300_dma_reset_chan(s, ch);
> +        atcdmac300_dma_int_stat_update(s, INT_STATUS_TC, ch);
> +        if (!int_tc_mask) {
> +            qemu_irq_raise(s->irq);
> +        }
> +        return;
> +    } else {
> +        s->ChAbort &=3D ~(1 << ch);
> +        atcdmac300_dma_int_stat_update(s, INT_STATUS_ERR, ch);
> +        atcdmac300_dma_reset_chan(s, ch);
> +        if (!int_err_mask) {
> +            qemu_irq_raise(s->irq);
> +        }
> +    }
> +}
> +
> +static void atcdmac300_co_run(void *opaque)
> +{
> +
> +    while (1) {
> +        for (int ch =3D 0; ch < ATCDMAC300_MAX_CHAN; ch++) {
> +            atcdmac300_co_run_channel(opaque, ch);
> +            qemu_coroutine_yield();
> +        }
> +    }
> +}
> +
> +static void atcdmac300_bh_cb(void *opaque)
> +{
> +    ATCDMAC300State *s =3D opaque;
> +
> +    int rearm =3D 0;
> +    if (s->running) {
> +        rearm =3D 1;
> +        goto out;
> +    } else {
> +        s->running =3D 1;
> +    }
> +
> +    AioContext *ctx =3D qemu_get_current_aio_context();
> +    aio_co_enter(ctx, s->co);
> +
> +    s->running =3D 0;
> +out:
> +    if (rearm) {
> +        qemu_bh_schedule_idle(s->bh);
> +        s->dma_bh_scheduled =3D true;
> +    }
> +    qemu_bh_schedule_idle(s->bh);
> +    s->dma_bh_scheduled =3D true;
> +    s->running =3D 0;
> +}
> +
> +static void atcdmac300_write(void *opaque, hwaddr offset, uint64_t value=
,
> +                             unsigned size)
> +{
> +    ATCDMAC300State *s =3D opaque;
> +    int ch =3D 0;
> +
> +    LOG("@@@ atcdmac300_write()=3D0x%lx, value=3D0x%lx\n", offset, value=
);
> +
> +    if (offset >=3D 0x40) {
> +        ch =3D ATCDMAC300_GET_CHAN(offset);
> +        offset =3D ATCDMAC300_GET_OFF(offset, ch);
> +    }
> +
> +    switch (offset) {
> +    case ATCDMAC300_INT_STATUS:
> +        /* Write 1 to clear */
> +        s->IntStatus &=3D ~value;
> +        break;
> +    case ATCDMAC300_DMAC_CTRL:
> +        atcdmac300_dma_reset(s);
> +        break;
> +    case ATCDMAC300_CHN_ABT:
> +        for (int i =3D 0; i < ATCDMAC300_MAX_CHAN; i++) {
> +            if (value & 0x1 && (s->chan[i].ChnCtrl & (1 << CHAN_CTL_ENAB=
LE))) {
> +                s->ChAbort |=3D (0x1 << i);
> +            }
> +            value >>=3D 1;
> +        }
> +        break;
> +    case ATCDMAC300_CHAN_CTL:
> +        s->chan[ch].ChnCtrl =3D value;
> +        qemu_bh_schedule_idle(s->bh);
> +        break;
> +    case ATCDMAC300_CHAN_TRAN_SZ:
> +        s->chan[ch].ChnTranSize =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_SRC_ADDR:
> +        s->chan[ch].ChnSrcAddr =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_SRC_ADDR_H:
> +        s->chan[ch].ChnSrcAddrH =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_DST_ADDR:
> +        s->chan[ch].ChnDstAddr =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_DST_ADDR_H:
> +        s->chan[ch].ChnDstAddrH =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_LL_POINTER:
> +        s->chan[ch].ChnLLPointer =3D value;
> +        break;
> +    case ATCDMAC300_CHAN_LL_POINTER_H:
> +        s->chan[ch].ChnLLPointerH =3D value;
> +        break;
> +    default:
> +        LOGGE("%s: Bad offset 0x%" HWADDR_PRIX "\n",
> +              __func__, offset);
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps atcdmac300_ops =3D {
> +    .read =3D atcdmac300_read,
> +    .write =3D atcdmac300_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 8
> +    }
> +};
> +
> +static void atcdmac300_init(Object *obj)
> +{
> +    ATCDMAC300State *s =3D ATCDMAC300(obj);
> +    SysBusDevice *sbus =3D SYS_BUS_DEVICE(obj);
> +
> +    sysbus_init_irq(sbus, &s->irq);
> +    memory_region_init_io(&s->mmio, obj, &atcdmac300_ops, s, TYPE_ATCDMA=
C300,
> +                          s->mmio_size);
> +    sysbus_init_mmio(sbus, &s->mmio);
> +    if (s->iothread) {
> +        s->ctx =3D iothread_get_aio_context(s->iothread);
> +    } else {
> +        s->ctx =3D qemu_get_aio_context();
> +    }
> +    s->bh =3D aio_bh_new(s->ctx, atcdmac300_bh_cb, s);
> +    s->co =3D qemu_coroutine_create(atcdmac300_co_run, s);
> +}
> +
> +static Property atcdmac300_properties[] =3D {
> +    DEFINE_PROP_UINT32("mmio-size", ATCDMAC300State, mmio_size, 0x100000=
),
> +    DEFINE_PROP_UINT32("id-and-revision", ATCDMAC300State, IdRev,
> +                       (ATCDMAC300_PRODUCT_ID  << 8) |
> +                       ((ATCDMAC300_PRODUCT_ID & 0x7) << 4) |
> +                       ((ATCDMAC300_PRODUCT_ID & 0x7))),
> +    DEFINE_PROP_UINT32("inturrupt-status", ATCDMAC300State, IntStatus, 0=
),
> +    DEFINE_PROP_UINT32("dmac-configuration", ATCDMAC300State,
> +                       DMACfg, 0xc3404108),
> +    DEFINE_PROP_LINK("iothread", ATCDMAC300State, iothread,
> +                     TYPE_IOTHREAD, IOThread *),
> +
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void atcdmac300_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *k =3D DEVICE_CLASS(klass);
> +    device_class_set_props(k, atcdmac300_properties);
> +}
> +
> +static const TypeInfo atcdmac300_info =3D {
> +    .name          =3D TYPE_ATCDMAC300,
> +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(ATCDMAC300State),
> +    .class_init    =3D atcdmac300_class_init,
> +    .instance_init =3D atcdmac300_init,
> +};
> +
> +DeviceState *
> +atcdmac300_create(const char *name, hwaddr addr, hwaddr mmio_size, qemu_=
irq irq)
> +{
> +    DeviceState *dev;
> +    dev =3D sysbus_create_varargs(TYPE_ATCDMAC300, addr, irq, NULL);
> +    return dev;
> +}
> +
> +static void atcdmac300_register_types(void)
> +{
> +    type_register_static(&atcdmac300_info);
> +}
> +
> +void atcdmac300_connect_iopmp(DeviceState *dev, AddressSpace *iopmp_as,
> +                              StreamSink *transaction_info_sink, uint32_=
t sid)
> +{
> +    ATCDMAC300State *s =3D ATCDMAC300(dev);
> +    s->iopmp_as =3D iopmp_as;
> +    s->transaction_info_sink =3D transaction_info_sink;
> +    s->sid =3D sid;
> +}
> +
> +type_init(atcdmac300_register_types)
> diff --git a/hw/dma/meson.build b/hw/dma/meson.build
> index a96c1be2c8..dfe37de32d 100644
> --- a/hw/dma/meson.build
> +++ b/hw/dma/meson.build
> @@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('px=
a2xx_dma.c'))
>  system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'=
))
>  system_ss.add(when: 'CONFIG_XLNX_CSU_DMA', if_true: files('xlnx_csu_dma.=
c'))
> +system_ss.add(when: 'CONFIG_ATCDMAC300', if_true: files('atcdmac300.c'))
> \ No newline at end of file
> diff --git a/include/hw/dma/atcdmac300.h b/include/hw/dma/atcdmac300.h
> new file mode 100644
> index 0000000000..5b62039e33
> --- /dev/null
> +++ b/include/hw/dma/atcdmac300.h
> @@ -0,0 +1,180 @@
> +/*
> + * Andes ATCDMAC300 (Andes Technology DMA Controller)
> + *
> + * Copyright (c) 2022 Andes Tech. Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>
> + *
> + */
> +
> +#ifndef ATCDMAC300_H
> +#define ATCDMAC300_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +#include "qemu/coroutine.h"
> +#include "block/aio.h"
> +#include "sysemu/iothread.h"
> +#include "sysemu/dma.h"
> +#include "hw/stream.h"
> +
> +#define TYPE_ATCDMAC300 "atcdmac300"
> +OBJECT_DECLARE_SIMPLE_TYPE(ATCDMAC300State, ATCDMAC300)
> +
> +#define ATCDMAC300_IOPMP_SID            0
> +
> +#define ATCDMAC300_PRODUCT_ID           0x010230
> +#define ATCDMAC300_REV_MAJOR            0x0
> +#define ATCDMAC300_REV_MINOR            0x1
> +
> +/* DMAC Configuration Register (Offset 0x10)  */
> +#define ATCDMAC300_DMA_CFG              0x10
> +#define DMA_CFG_CHAIN_XFR               31
> +#define DMA_CFG_REQ_SYNC                30
> +#define DMA_CFG_DATA_WITDTH             24
> +#define DMA_CFG_ADDR_WIDTH              17
> +#define DMA_CFG_CORE_NUM                16
> +#define DMA_CFG_BUS_NUM                 15
> +#define DMA_CFG_REQ_NUM                 10
> +#define DMA_CFG_FIFO_DEPTH              4
> +#define DMA_CFG_CHAN_NUM                0
> +
> +/* Interrupt Status Register (Offset 0x20) */
> +#define ATCDMAC300_DMAC_CTRL            0x20
> +
> +/* Channel Abort Register (Offset 0x24) */
> +#define ATCDMAC300_CHN_ABT              0x24
> +
> +/* Interrupt Status Register (Offset 0x30) */
> +#define ATCDMAC300_INT_STATUS           0x30
> +#define INT_STATUS_TC                   16
> +#define INT_STATUS_ABT                  8
> +#define INT_STATUS_ERR                  0
> +
> +/* Interrupt Status Register (Offset 0x34) */
> +#define ATCDMAC300_CHAN_ENABLE          0x34
> +
> +/* Channel n Control Register (Offset 0x40 + n*0x20) */
> +#define CHAN_CTL_SRC_BUS_IDX            31
> +#define CHAN_CTL_DST_BUS_IDX            30
> +#define CHAN_CTL_PRIORITY               29
> +#define CHAN_CTL_SRC_BURST_SZ           24
> +#define CHAN_CTL_SRC_WIDTH              21
> +#define CHAN_CTL_DST_WIDTH              18
> +#define CHAN_CTL_SRC_MODE               17
> +#define CHAN_CTL_DST_MODE               16
> +#define CHAN_CTL_SRC_ADDR_CTL           14
> +#define CHAN_CTL_DST_ADDR_CTL           12
> +#define CHAN_CTL_SRC_REQ_SEL            8
> +#define CHAN_CTL_DST_REQ_SEL            4
> +#define CHAN_CTL_INT_ABT_MASK_POS       3
> +#define CHAN_CTL_INT_ERR_MASK_POS       2
> +#define CHAN_CTL_INT_TC_MASK_POS        1
> +#define CHAN_CTL_ENABLE                 0
> +
> +#define CHAN_CTL_SRC_WIDTH_MASK         0x7
> +#define CHAN_CTL_DST_WIDTH_MASK         0x7
> +#define CHAN_CTL_SRC_BURST_SZ_MASK      0xf
> +#define CHAN_CTL_SRC_ADDR_CTL_MASK      0x3
> +#define CHAN_CTL_DST_ADDR_CTL_MASK      0x3
> +
> +#define ATCDMAC300_CHAN_CTL             0x40
> +#define ATCDMAC300_CHAN_TRAN_SZ         0x44
> +#define ATCDMAC300_CHAN_SRC_ADDR        0x48
> +#define ATCDMAC300_CHAN_SRC_ADDR_H      0x4C
> +#define ATCDMAC300_CHAN_DST_ADDR        0x50
> +#define ATCDMAC300_CHAN_DST_ADDR_H      0x54
> +#define ATCDMAC300_CHAN_LL_POINTER      0x58
> +#define ATCDMAC300_CHAN_LL_POINTER_H    0x5C
> +
> +#define ATCDMAC300_IRQ_START            0x40
> +#define ATCDMAC300_IRQ_END              (ATCDMAC300_IRQ_START + \
> +                                         ATCDMAC300_MAX_CHAN)
> +
> +#define ATCDMAC300_MAX_BURST_SIZE       1024
> +#define ATCDMAC300_MAX_CHAN             0x8
> +
> +#define AXI_BURST_TYPE_FIX 0
> +#define AXI_BURST_TYPE_INC 1
> +#define AXI_BURST_INC_LEN_MAX 255
> +#define AXI_BURST_FIX_LEN_MAX 15
> +#define AXI_BOUNDARY 0x1000
> +
> +#define PER_CHAN_OFFSET                 0x20
> +#define ATCDMAC300_FIRST_CHAN_BASE      ATCDMAC300_CHAN_CTL
> +#define ATCDMAC300_GET_CHAN(reg)        (((reg - ATCDMAC300_FIRST_CHAN_B=
ASE) / \
> +                                            PER_CHAN_OFFSET))
> +#define ATCDMAC300_GET_OFF(reg, ch)     (reg - (ch * PER_CHAN_OFFSET))
> +
> +#define DMA_ABT_RESULT (1 << 3)
> +
> +typedef struct {
> +    qemu_irq irq;
> +
> +    /* Channel control registers (n=3D0~7) */
> +    uint32_t ChnCtrl;
> +    uint32_t ChnTranSize;
> +    uint32_t ChnSrcAddr;
> +    uint64_t ChnSrcAddrH;
> +    uint32_t ChnDstAddr;
> +    uint64_t ChnDstAddrH;
> +    uint32_t ChnLLPointer;
> +    uint32_t ChnLLPointerH;
> +} ATCDMAC300Chan;
> +
> +
> +struct ATCDMAC300State {
> +    /*< private >*/
> +    SysBusDevice busdev;
> +    /*< public >*/
> +
> +    qemu_irq irq;
> +    MemoryRegion mmio;
> +    uint32_t mmio_size;
> +
> +    /* ID and revision register */
> +    uint32_t IdRev;
> +
> +    /* Configuration register */
> +    uint32_t DMACfg;
> +
> +    /* Global control registers */
> +    uint32_t DMACtrl;
> +    uint32_t ChAbort;
> +
> +    /* Channel status registers */
> +    uint32_t IntStatus;
> +    uint32_t ChEN;
> +
> +    ATCDMAC300Chan chan[ATCDMAC300_MAX_CHAN];
> +
> +    /* To support iopmp */
> +    AddressSpace *iopmp_as;
> +    StreamSink *transaction_info_sink;
> +    uint32_t sid;
> +
> +    Coroutine *co;
> +    QEMUBH *bh;
> +    bool running;
> +    bool dma_bh_scheduled;
> +    AioContext *ctx;
> +    IOThread *iothread;
> +};
> +
> +DeviceState *atcdmac300_create(const char *name, hwaddr addr, hwaddr mmi=
o_size,
> +                               qemu_irq irq);
> +
> +void atcdmac300_connect_iopmp(DeviceState *dev, AddressSpace *iopmp_as,
> +                              StreamSink *transaction_info_sink, uint32_=
t sid);
> +
> +#endif /* ATCDMAC300_H */
> --
> 2.34.1
>
>

