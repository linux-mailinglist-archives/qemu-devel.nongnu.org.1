Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3EA7CD140
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 02:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsuMf-00078c-D0; Tue, 17 Oct 2023 20:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuMc-00077o-IP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:24:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuMY-0008Db-Eu
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:24:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4078fe6a063so22465e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 17:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697588677; x=1698193477; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oDXOQwHp+Nth72fAnb7kMI37y7ddZwE4Zu9VWuMSmig=;
 b=hr+DCGZmv7HiYnDIUFSn7t4jmXapXEY04pQcq4VzW5PimSy680T//aCEgwr6fq+Y3t
 sZYgxSWmWvD1w4qegDecwfuKgFwxfLAe9iRAi4VdCRJeV85UES0JxoSZQNhgtAh6MHe4
 uglazwJqUhmCI8IbuMvkpkKWd2S4aZCPX/1wIEvGVzBPOlMZM8A4rt0KtunzYOrtjXCu
 IjvvXOSnu6pUleOAxCvZGuE69O8sHvfBSwbjco82CM/VC0RFiV5PkOH27PRFyLS5jR4a
 /sUrJUWyF+cKOfXRQbIWVcO1lRZ9XnXf5JtQkpp4sYevrcHmtVr1UpzARAOszF7zWPlS
 34bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697588677; x=1698193477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oDXOQwHp+Nth72fAnb7kMI37y7ddZwE4Zu9VWuMSmig=;
 b=aATlwPl/ry14y3mdBuVe+4DJB0Albwjtns/2Fy0q9MVqMz+AN4bd58TMfx+MWjFoT1
 H3R2z0qrQtwuCl53LfXTZbGpc1+ERse4HkDPpCvQzmjqmPs6HzbR6AJYLHWfs3st/LNy
 AqyLR5FiGf4eezqLn7X/Hsqx0/T7+ittCB+Q9K6cw12CJ3MU5SIOkyT01pLG92FWdY0O
 WE/PpmCZFsqTjrjB6RzLn/HccXAIeT9SoVjOx9QqP9NxwLjkghjME46RDgj9ruHk7elB
 ibZMskivW+0HIQMYvi5hLmcJYOmUQ30cD+m9girn+MzVntLiAVBf2uJAYeN6NAiNPCSy
 dVZg==
X-Gm-Message-State: AOJu0YwtUvLIaNLItwiDdINNFAyBYj0QL5/tJcuyFBIOTiFPySBinQxn
 erryl25pD46XGpcK19qznpBXZGm+lhy0vDhZ3W7DfYfwkFIzO7QpPZA=
X-Google-Smtp-Source: AGHT+IFXoDRlBgpkruS3rzKywlMokIOsRFdBIJ1rYQtb1ipnfWCIylVGDHLR9KxW77uUvVG7L1Bi070Ru2k/d8Nyiao=
X-Received: by 2002:a05:600c:2111:b0:404:7462:1f87 with SMTP id
 u17-20020a05600c211100b0040474621f87mr61035wml.6.1697588676646; Tue, 17 Oct
 2023 17:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231017230342.311227-1-nabihestefan@google.com>
 <20231017230342.311227-10-nabihestefan@google.com>
In-Reply-To: <20231017230342.311227-10-nabihestefan@google.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 17 Oct 2023 17:24:23 -0700
Message-ID: <CAGcCb136pZd4HaoUf7w1-P=ap2kPSWq6KjK4LEQyvW8SeRZSgA@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] hw/net: GMAC Rx Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 kfting@nuvoton.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: multipart/alternative; boundary="0000000000000c3ed20607f2aa9c"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=wuhaotsh@google.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--0000000000000c3ed20607f2aa9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please consolidate the commit message in this patch. I think we only need
to describe the functionality you implemented here (i.e. the receive (RX)
for the GMAC model) and how you did it. There's no need to keep the verbose
comment on each corner cases we had.



On Tue, Oct 17, 2023 at 4:04=E2=80=AFPM Nabih Estefan <nabihestefan@google.=
com>
wrote:

> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - Implementation of Receive function for packets
> - Implementation for reading and writing from and to descriptors in
>   memory for Rx
>
> NOTE: At this point in development we believe this function is working
> as intended, and the kernel supports these findings, but we need the
> Transmit function to work before we upload
>
> Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
>
> hw/net: npcm_gmac Flush queued packets when starting RX
>
> When RX starts, we need to flush the queued packets so that they
> can be received by the GMAC device. Without this it won't work
> with TAP NIC device.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
>
> hw/net: Handle RX desc full in NPCM GMAC
>
> When RX descriptor list is full, it returns a DMA_STATUS for software to
> handle it. But there's no way to indicate the software ha handled all RX
> descriptors and the whole pipeline stalls.
>
> We do something similar to NPCM7XX EMC to handle this case.
>
> 1. Return packet size when RX descriptor is full, effectively dropping
> these packets in such a case.
> 2. When software clears RX descriptor full bit, continue receiving furthe=
r
> packets by flushing QEMU packet queue.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
>
> hw/net: Receive and drop packets when descriptors are full in GMAC
>
> Effectively this allows QEMU to receive and drop incoming packets when
> RX descriptors are full. Similar to EMC, this lets GMAC to drop packets
> faster, especially during bootup sequence.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
>
> hw/net: Update frame_ptr during gmac_receive
>
> There was a bug that frame_ptr wasn't updated after receiving
> the first batch of data, causing the received data to be wrong
> when the frame is too large.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
>
> hw/net: Fix GMAC not detecting owned by software properly in RX
>
> RX should stop receiving when a descriptor is owned by software
> but currently implementation made it reversed (owned by DMA) instead.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
>
> hw/net: Fix GMAC receive problem
>
> Fix the following 2 problems in GMAC receive function:
>
> 1. When kernel driver disables GMAC RX interrupt and all descriptors
>     are full, it will not send further interrupt to the kernel
>     driver as the driver doesn't listen to NPCM_DMA_STATUS_RU.
>     Since descriptors full indicates that there are packets received
>     we should also set NPCM_DMA_STATUS_RI for firing the interrupt.
> 2. Kernel driver does not clear rdes0 from used descriptor so we need
>     to clear it such that old flags are removed before setting new
>     flags.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/net/npcm_gmac.c         | 356 ++++++++++++++++++++++++++++++++++---
>  include/hw/net/npcm_gmac.h |  28 +--
>  2 files changed, 342 insertions(+), 42 deletions(-)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 6f8109e0ee..a7c8b67223 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -23,7 +23,11 @@
>  #include "hw/registerfields.h"
>  #include "hw/net/mii.h"
>  #include "hw/net/npcm_gmac.h"
> +#include "linux/if_ether.h"
>  #include "migration/vmstate.h"
> +#include "net/checksum.h"
> +#include "net/net.h"
> +#include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qemu/units.h"
>  #include "sysemu/dma.h"
> @@ -91,7 +95,6 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
>  #define NPCM_DMA_BUS_MODE_SWR               BIT(0)
>
>  static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] =3D=
 {
> -    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
>
Why is this line removed?

>      [R_NPCM_GMAC_VERSION]         =3D 0x00001032,
>      [R_NPCM_GMAC_TIMER_CTRL]      =3D 0x03e80000,
>      [R_NPCM_GMAC_MAC0_ADDR_HI]    =3D 0x8000ffff,
> @@ -146,6 +149,17 @@ static void gmac_phy_set_link(NPCMGMACState *s, bool
> active)
>
>  static bool gmac_can_receive(NetClientState *nc)
>  {
> +    NPCMGMACState *gmac =3D NPCM_GMAC(qemu_get_nic_opaque(nc));
> +
> +    /* If GMAC receive is disabled. */
> +    if (!(gmac->regs[R_NPCM_GMAC_MAC_CONFIG] &
> NPCM_GMAC_MAC_CONFIG_RX_EN)) {
> +        return false;
> +    }
> +
> +    /* If GMAC DMA RX is stopped. */
> +    if (!(gmac->regs[R_NPCM_DMA_CONTROL] &
> NPCM_DMA_CONTROL_START_STOP_RX)) {
> +        return false;
> +    }
>      return true;
>  }
>
> @@ -191,11 +205,288 @@ static void gmac_update_irq(NPCMGMACState *gmac)
>      qemu_set_irq(gmac->irq, level);
>  }
>
> -static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf,
> size_t len)
> +static int gmac_read_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *des=
c)
>  {
> -    /* Placeholder */
> +    if (dma_memory_read(&address_space_memory, addr, desc,
> +                        sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read descriptor @
> 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
> +    desc->rdes0 =3D le32_to_cpu(desc->rdes0);
> +    desc->rdes1 =3D le32_to_cpu(desc->rdes1);
> +    desc->rdes2 =3D le32_to_cpu(desc->rdes2);
> +    desc->rdes3 =3D le32_to_cpu(desc->rdes3);
> +    return 0;
> +}
> +
> +static int gmac_write_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc
> *desc)
> +{
> +    struct NPCMGMACRxDesc le_desc;
> +    le_desc.rdes0 =3D cpu_to_le32(desc->rdes0);
> +    le_desc.rdes1 =3D cpu_to_le32(desc->rdes1);
> +    le_desc.rdes2 =3D cpu_to_le32(desc->rdes2);
> +    le_desc.rdes3 =3D cpu_to_le32(desc->rdes3);
> +    if (dma_memory_write(&address_space_memory, addr, &le_desc,
> +                        sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to write descriptor @
> 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int gmac_read_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *des=
c)
> +{
> +    if (dma_memory_read(&address_space_memory, addr, desc,
> +                        sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read descriptor @
> 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
> +    desc->tdes0 =3D le32_to_cpu(desc->tdes0);
> +    desc->tdes1 =3D le32_to_cpu(desc->tdes1);
> +    desc->tdes2 =3D le32_to_cpu(desc->tdes2);
> +    desc->tdes3 =3D le32_to_cpu(desc->tdes3);
> +    return 0;
> +}
> +
> +static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc
> *desc)
> +{
> +    struct NPCMGMACTxDesc le_desc;
> +    le_desc.tdes0 =3D cpu_to_le32(desc->tdes0);
> +    le_desc.tdes1 =3D cpu_to_le32(desc->tdes1);
> +    le_desc.tdes2 =3D cpu_to_le32(desc->tdes2);
> +    le_desc.tdes3 =3D cpu_to_le32(desc->tdes3);
> +    if (dma_memory_write(&address_space_memory, addr, &le_desc,
> +                        sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to write descriptor @
> 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        return -1;
> +    }
>      return 0;
>  }
> +static int gmac_rx_transfer_frame_to_buffer(uint32_t rx_buf_len,
> +                                            uint32_t *left_frame,
> +                                            uint32_t rx_buf_addr,
> +                                            bool *eof_transferred,
> +                                            const uint8_t **frame_ptr,
> +                                            uint16_t *transferred)
> +{
> +    uint32_t to_transfer;
> +    /*
> +     * Check that buffer is bigger than the frame being transfered
> +     * If bigger then transfer only whats left of frame
> +     * Else, fill frame with all the content possible
> +     */
> +    if (rx_buf_len >=3D *left_frame) {
> +        to_transfer =3D *left_frame;
> +        *eof_transferred =3D true;
> +    } else {
> +        to_transfer =3D rx_buf_len;
> +    }
> +
> +    /* write frame part to memory */
> +    if (dma_memory_write(&address_space_memory, (uint64_t) rx_buf_addr,
> +                         *frame_ptr, to_transfer, MEMTXATTRS_UNSPECIFIED=
))
> +    {
> +        return -1;
> +    }
> +
> +    /* update frame pointer and size of whats left of frame */
> +    *frame_ptr +=3D to_transfer;
> +    *left_frame -=3D to_transfer;
> +    *transferred +=3D to_transfer;
> +
> +    return 0;
> +}
> +
> +static void gmac_dma_set_state(NPCMGMACState *gmac, int shift, uint32_t
> state)
> +{
> +    gmac->regs[R_NPCM_DMA_STATUS] =3D
> deposit32(gmac->regs[R_NPCM_DMA_STATUS],
> +        shift, 3, state);
> +}
> +
> +static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf,
> size_t len)
> +{
> +    /*
> +     * Comments have steps that relate to the
> +     * receiving process steps in pg 386
> +     */
> +    NPCMGMACState *gmac =3D NPCM_GMAC(qemu_get_nic_opaque(nc));
> +    uint32_t left_frame =3D len;
> +    const uint8_t *frame_ptr =3D buf;
> +    uint32_t desc_addr;
> +    uint32_t rx_buf_len, rx_buf_addr;
> +    struct NPCMGMACRxDesc rx_desc;
> +    uint16_t transferred =3D 0;
> +    bool eof_transferred =3D false;
> +
> +    trace_npcm_gmac_packet_receive(DEVICE(gmac)->canonical_path, len);
> +    if (!gmac_can_receive(nc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "GMAC Currently is not able for
> Rx");
> +        return -1;
> +    }
> +    if (!gmac->regs[R_NPCM_DMA_HOST_RX_DESC]) {
> +        gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =3D
> +
> NPCM_DMA_HOST_RX_DESC_MASK(gmac->regs[R_NPCM_DMA_RX_BASE_ADDR]);
> +    }
> +    desc_addr =3D
> NPCM_DMA_HOST_RX_DESC_MASK(gmac->regs[R_NPCM_DMA_HOST_RX_DESC]);
> +
> +    /* step 1 */
> +    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +        NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE);
> +    trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path,
> desc_addr);
> +    if (gmac_read_rx_desc(desc_addr, &rx_desc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "RX Descriptor @ 0x%x cant be
> read\n",
> +                      desc_addr);
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_RX_SUSPENDED_STATE);
> +        return -1;
> +    }
> +
> +    /* step 2 */
> +    if (!(rx_desc.rdes0 & RX_DESC_RDES0_OWN)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "RX Descriptor @ 0x%x is owned by software\n",
> +                      desc_addr);
> +        gmac->regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA_STATUS_RU;
> +        gmac->regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA_STATUS_RI;
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_RX_SUSPENDED_STATE);
> +        gmac_update_irq(gmac);
> +        return len;
> +    }
> +    /* step 3 */
> +    /*
> +     * TODO --
> +     * Implement all frame filtering and processing (with its own
> interrupts)
> +     */
> +    trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path,
> &rx_desc,
> +                                    rx_desc.rdes0, rx_desc.rdes1,
> rx_desc.rdes2,
> +                                    rx_desc.rdes3);
> +    /* Clear rdes0 for the incoming descriptor and set FS in first
> descriptor.*/
> +    rx_desc.rdes0 =3D RX_DESC_RDES0_FIRST_DESC_MASK;
> +
> +    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +        NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE);
> +
> +    /* Pad the frame with FCS as the kernel driver will strip it away. *=
/
> +    left_frame +=3D ETH_FCS_LEN;
> +
> +    /* repeat while we still have frame to transfer to memory */
> +    while (!eof_transferred) {
> +        /* Return descriptor no matter what happens */
> +        rx_desc.rdes0 &=3D ~RX_DESC_RDES0_OWN;
> +        /* Set the frame to be an IPv4/IPv6 frame. */
> +        rx_desc.rdes0 |=3D RX_DESC_RDES0_FRM_TYPE_MASK;
> +
> +        /* step 4 */
> +        rx_buf_len =3D RX_DESC_RDES1_BFFR1_SZ_MASK(rx_desc.rdes1);
> +        rx_buf_addr =3D rx_desc.rdes2;
> +        gmac->regs[R_NPCM_DMA_CUR_RX_BUF_ADDR] =3D rx_buf_addr;
> +        gmac_rx_transfer_frame_to_buffer(rx_buf_len, &left_frame,
> rx_buf_addr,
> +                                         &eof_transferred, &frame_ptr,
> +                                         &transferred);
> +
> +
> trace_npcm_gmac_packet_receiving_buffer(DEVICE(gmac)->canonical_path,
> +                                                rx_buf_len, rx_buf_addr)=
;
> +        /* if we still have frame left and the second buffer is not
> chained */
> +         if (!(rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK) && \
> +              !eof_transferred) {
> +            /* repeat process from above on buffer 2 */
> +            rx_buf_len =3D RX_DESC_RDES1_BFFR2_SZ_MASK(rx_desc.rdes1);
> +            rx_buf_addr =3D rx_desc.rdes3;
> +            gmac->regs[R_NPCM_DMA_CUR_RX_BUF_ADDR] =3D rx_buf_addr;
> +            gmac_rx_transfer_frame_to_buffer(rx_buf_len, &left_frame,
> +                                             rx_buf_addr,
> &eof_transferred,
> +                                             &frame_ptr, &transferred);
> +            trace_npcm_gmac_packet_receiving_buffer( \
> +
> DEVICE(gmac)->canonical_path,
> +                                                rx_buf_len, rx_buf_addr)=
;
> +        }
> +        /* update address for descriptor */
> +        gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =3D rx_buf_addr;
> +        /* Return descriptor */
> +        rx_desc.rdes0 &=3D ~RX_DESC_RDES0_OWN;
> +        /* Update frame length transferred */
> +        rx_desc.rdes0 |=3D ((uint32_t)transferred)
> +            << RX_DESC_RDES0_FRAME_LEN_SHIFT;
> +        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path,
> &rx_desc,
> +                                        rx_desc.rdes0, rx_desc.rdes1,
> +                                        rx_desc.rdes2, rx_desc.rdes3);
> +
> +        /* step 5 */
> +        gmac_write_rx_desc(desc_addr, &rx_desc);
> +        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path,
> +                                        &rx_desc, rx_desc.rdes0,
> +                                        rx_desc.rdes1, rx_desc.rdes2,
> +                                        rx_desc.rdes3);
> +        /* read new descriptor into rx_desc if needed*/
> +        if (!eof_transferred) {
> +            /* Get next descriptor address (chained or sequential) */
> +            if (rx_desc.rdes1 & RX_DESC_RDES1_RC_END_RING_MASK) {
> +                desc_addr =3D gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
> +            } else if (rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK)=
 {
> +                desc_addr =3D rx_desc.rdes3;
> +            } else {
> +                desc_addr +=3D sizeof(rx_desc);
> +            }
> +            trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_pat=
h,
> +                                             desc_addr);
> +            if (gmac_read_rx_desc(desc_addr, &rx_desc)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "RX Descriptor @ 0x%x cant be read\n",
> +                              desc_addr);
> +                gmac->regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA_STATUS_RU;
> +                gmac_update_irq(gmac);
> +                return len;
> +            }
> +
> +            /* step 6 */
> +            if (!(rx_desc.rdes0 & RX_DESC_RDES0_OWN)) {
> +                if (!(gmac->regs[R_NPCM_DMA_CONTROL] & \
> +                     NPCM_DMA_CONTROL_FLUSH_MASK)) {
> +                    rx_desc.rdes0 |=3D RX_DESC_RDES0_DESC_ERR_MASK;
> +                }
> +                eof_transferred =3D true;
> +            }
> +            /* Clear rdes0 for the incoming descriptor */
> +            rx_desc.rdes0 =3D 0;
> +        }
> +    }
> +    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +        NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE);
> +
> +    rx_desc.rdes0 |=3D RX_DESC_RDES0_LAST_DESC_MASK;
> +    if (!(rx_desc.rdes1 & RX_DESC_RDES1_DIS_INTR_COMP_MASK)) {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA_STATUS_RI;
> +        gmac_update_irq(gmac);
> +    }
> +    trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path,
> &rx_desc,
> +                                    rx_desc.rdes0, rx_desc.rdes1,
> rx_desc.rdes2,
> +                                    rx_desc.rdes3);
> +
> +    /* step 8 */
> +    gmac->regs[R_NPCM_DMA_CONTROL] |=3D NPCM_DMA_CONTROL_FLUSH_MASK;
> +
> +    /* step 9 */
> +    trace_npcm_gmac_packet_received(DEVICE(gmac)->canonical_path,
> left_frame);
> +    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +        NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
> +    gmac_write_rx_desc(desc_addr, &rx_desc);
> +
> +    /* Get next descriptor address (chained or sequential) */
> +    if (rx_desc.rdes1 & RX_DESC_RDES1_RC_END_RING_MASK) {
> +        desc_addr =3D gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
> +    } else if (rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK) {
> +        desc_addr =3D rx_desc.rdes3;
> +    } else {
> +        desc_addr +=3D sizeof(rx_desc);
> +    }
> +    gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =3D desc_addr;
> +    return len;
> +}
>  static void gmac_cleanup(NetClientState *nc)
>  {
>      /* Nothing to do yet. */
> @@ -281,7 +572,6 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>                                uint64_t v, unsigned size)
>  {
>      NPCMGMACState *gmac =3D opaque;
> -    uint32_t prev;
>
>      trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
>
> @@ -305,22 +595,7 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>          break;
>
>      case A_NPCM_GMAC_MAC_CONFIG:
> -        prev =3D gmac->regs[offset / sizeof(uint32_t)];
>          gmac->regs[offset / sizeof(uint32_t)] =3D v;
> -
> -        /* If transmit is being enabled for first time, update desc addr
> */
> -        if (~(prev & NPCM_GMAC_MAC_CONFIG_TX_EN) &
> -             (v & NPCM_GMAC_MAC_CONFIG_TX_EN)) {
> -            gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =3D
> -                gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
> -        }
> -
> -        /* If receive is being enabled for first time, update desc addr =
*/
> -        if (~(prev & NPCM_GMAC_MAC_CONFIG_RX_EN) &
> -             (v & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
> -            gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =3D
> -                gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
> -        }
>
Why are these lines removed? Maybe they should exist in the first patch
we've added them if we don't need them.

>          break;
>
>      case A_NPCM_GMAC_MII_ADDR:
> @@ -362,6 +637,31 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>
>      case A_NPCM_DMA_RCV_POLL_DEMAND:
>          /* We dont actually care about the value */
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
> +        break;
> +
> +    case A_NPCM_DMA_XMT_POLL_DEMAND:
> +        /* We dont actually care about the value */
> +        gmac_try_send_next_packet(gmac);
> +        break;
> +
> +    case A_NPCM_DMA_CONTROL:
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
> +        if (v & NPCM_DMA_CONTROL_START_STOP_TX) {
> +            gmac_try_send_next_packet(gmac);
> +        } else {
> +            gmac_dma_set_state(gmac,
> NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_TX_STOPPED_STATE);
> +        }
> +        if (v & NPCM_DMA_CONTROL_START_STOP_RX) {
> +            gmac_dma_set_state(gmac,
> NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
> +            qemu_flush_queued_packets(qemu_get_queue(gmac->nic));
> +        } else {
> +            gmac_dma_set_state(gmac,
> NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_RX_STOPPED_STATE);
> +        }
>          break;
>
>      case A_NPCM_DMA_STATUS:
> @@ -371,16 +671,14 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>                            "%s: Write of read-only bits of reg: offset:
> 0x%04"
>                             HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
>                             DEVICE(gmac)->canonical_path, offset, v);
> -        } else {
> -            /* for W1c bits, implement W1C */
> -            gmac->regs[offset / sizeof(uint32_t)] &=3D
> -                ~NPCM_DMA_STATUS_W1C_MASK(v);
> -            if (v & NPCM_DMA_STATUS_NIS_BITS) {
> -                gmac->regs[offset / sizeof(uint32_t)] &=3D
> ~NPCM_DMA_STATUS_NIS;
> -            }
> -            if (v & NPCM_DMA_STATUS_AIS_BITS) {
> -                gmac->regs[offset / sizeof(uint32_t)] &=3D
> ~NPCM_DMA_STATUS_AIS;
> -            }
>
ditto.

> +        }
> +        /* for W1C bits, implement W1C */
> +        gmac->regs[offset / sizeof(uint32_t)] &=3D
> ~NPCM_DMA_STATUS_W1C_MASK(v);
> +        if (v & NPCM_DMA_STATUS_RU) {
> +            /* Clearing RU bit indicates descriptor is owned by DMA
> again. */
> +            gmac_dma_set_state(gmac,
> NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
> +            qemu_flush_queued_packets(qemu_get_queue(gmac->nic));
>          }
>          break;
>
> diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
> index c97eb6fe6e..d0a37e6988 100644
> --- a/include/hw/net/npcm_gmac.h
> +++ b/include/hw/net/npcm_gmac.h
> @@ -136,7 +136,7 @@ struct NPCMGMACTxDesc {
>  #define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
>  /* Last Segment */
>  #define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
> -/* Last Segment */
> +/* First Segment */
>  #define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
>  /* Checksum Insertion Control */
>  #define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2)
> @@ -176,32 +176,32 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC=
)
>  #define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20
>  /* Transmit States */
>  #define NPCM_DMA_STATUS_TX_STOPPED_STATE \
> -    (0b000 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b000)
>  #define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \
> -    (0b001 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b001)
>  #define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \
> -    (0b010 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b010)
>  #define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \
> -    (0b011 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b011)
>  #define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \
> -    (0b110 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b110)
>  #define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \
> -    (0b111 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
> +    (0b111)
>  /* Transmit Process State */
>  #define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17
>  /* Receive States */
>  #define NPCM_DMA_STATUS_RX_STOPPED_STATE \
> -    (0b000 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b000)
>  #define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \
> -    (0b001 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b001)
>  #define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \
> -    (0b011 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b011)
>  #define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \
> -    (0b100 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b100)
>  #define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \
> -    (0b101 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b101)
>  #define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \
> -    (0b111 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
> +    (0b111)
>
>
>  /* Early Receive Interrupt */
> @@ -302,6 +302,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
>  #define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)
>  /* Start/stop Transmit */
>  #define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)
> +/* Start/stop Receive */
> +#define NPCM_DMA_CONTROL_START_STOP_RX BIT(1)
>  /* Next receive descriptor start address */
>  #define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
>  /* Next transmit descriptor start address */
> --
> 2.42.0.655.g421f12c284-goog
>
>

--0000000000000c3ed20607f2aa9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Please consolidate the commit message in =
this patch. I think we only need to describe the functionality you implemen=
ted here (i.e. the receive (RX) for the GMAC model) and how you did it. The=
re&#39;s no need to keep the verbose comment on each corner cases we had.<d=
iv><br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Oct 17, 2023 at 4:04=E2=80=AFPM Nabih=
 Estefan &lt;<a href=3D"mailto:nabihestefan@google.com">nabihestefan@google=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">From: Nabih Estefan Diaz &lt;<a href=3D"mailto:nabihestefan@google.com"=
 target=3D"_blank">nabihestefan@google.com</a>&gt;<br>
<br>
- Implementation of Receive function for packets<br>
- Implementation for reading and writing from and to descriptors in<br>
=C2=A0 memory for Rx<br>
<br>
NOTE: At this point in development we believe this function is working<br>
as intended, and the kernel supports these findings, but we need the<br>
Transmit function to work before we upload<br>
<br>
Signed-off-by: Nabih Estefan Diaz &lt;<a href=3D"mailto:nabihestefan@google=
.com" target=3D"_blank">nabihestefan@google.com</a>&gt;<br>
<br>
hw/net: npcm_gmac Flush queued packets when starting RX<br>
<br>
When RX starts, we need to flush the queued packets so that they<br>
can be received by the GMAC device. Without this it won&#39;t work<br>
with TAP NIC device.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
<br>
hw/net: Handle RX desc full in NPCM GMAC<br>
<br>
When RX descriptor list is full, it returns a DMA_STATUS for software to ha=
ndle it. But there&#39;s no way to indicate the software ha handled all RX =
descriptors and the whole pipeline stalls.<br>
<br>
We do something similar to NPCM7XX EMC to handle this case.<br>
<br>
1. Return packet size when RX descriptor is full, effectively dropping thes=
e packets in such a case.<br>
2. When software clears RX descriptor full bit, continue receiving further =
packets by flushing QEMU packet queue.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
<br>
hw/net: Receive and drop packets when descriptors are full in GMAC<br>
<br>
Effectively this allows QEMU to receive and drop incoming packets when<br>
RX descriptors are full. Similar to EMC, this lets GMAC to drop packets<br>
faster, especially during bootup sequence.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
<br>
hw/net: Update frame_ptr during gmac_receive<br>
<br>
There was a bug that frame_ptr wasn&#39;t updated after receiving<br>
the first batch of data, causing the received data to be wrong<br>
when the frame is too large.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
<br>
hw/net: Fix GMAC not detecting owned by software properly in RX<br>
<br>
RX should stop receiving when a descriptor is owned by software<br>
but currently implementation made it reversed (owned by DMA) instead.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
<br>
hw/net: Fix GMAC receive problem<br>
<br>
Fix the following 2 problems in GMAC receive function:<br>
<br>
1. When kernel driver disables GMAC RX interrupt and all descriptors<br>
=C2=A0 =C2=A0 are full, it will not send further interrupt to the kernel<br=
>
=C2=A0 =C2=A0 driver as the driver doesn&#39;t listen to NPCM_DMA_STATUS_RU=
.<br>
=C2=A0 =C2=A0 Since descriptors full indicates that there are packets recei=
ved<br>
=C2=A0 =C2=A0 we should also set NPCM_DMA_STATUS_RI for firing the interrup=
t.<br>
2. Kernel driver does not clear rdes0 from used descriptor so we need<br>
=C2=A0 =C2=A0 to clear it such that old flags are removed before setting ne=
w<br>
=C2=A0 =C2=A0 flags.<br>
<br>
Signed-off-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com" target=3D"=
_blank">wuhaotsh@google.com</a>&gt;<br>
---<br>
=C2=A0hw/net/npcm_gmac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 356 +++++++++++=
+++++++++++++++++++++++---<br>
=C2=A0include/hw/net/npcm_gmac.h |=C2=A0 28 +--<br>
=C2=A02 files changed, 342 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c<br>
index 6f8109e0ee..a7c8b67223 100644<br>
--- a/hw/net/npcm_gmac.c<br>
+++ b/hw/net/npcm_gmac.c<br>
@@ -23,7 +23,11 @@<br>
=C2=A0#include &quot;hw/registerfields.h&quot;<br>
=C2=A0#include &quot;hw/net/mii.h&quot;<br>
=C2=A0#include &quot;hw/net/npcm_gmac.h&quot;<br>
+#include &quot;linux/if_ether.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
+#include &quot;net/checksum.h&quot;<br>
+#include &quot;net/net.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
@@ -91,7 +95,6 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)<br>
=C2=A0#define NPCM_DMA_BUS_MODE_SWR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(0)<br>
<br>
=C2=A0static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] =
=3D {<br>
-=C2=A0 =C2=A0 /* Reduce version to 3.2 so that the kernel can enable inter=
rupt. */<br></blockquote><div>Why is this line removed?=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_VERSION]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D 0x00001032,<br>
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_TIMER_CTRL]=C2=A0 =C2=A0 =C2=A0 =3D 0x03e8=
0000,<br>
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_MAC0_ADDR_HI]=C2=A0 =C2=A0 =3D 0x8000ffff,=
<br>
@@ -146,6 +149,17 @@ static void gmac_phy_set_link(NPCMGMACState *s, bool a=
ctive)<br>
<br>
=C2=A0static bool gmac_can_receive(NetClientState *nc)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 NPCMGMACState *gmac =3D NPCM_GMAC(qemu_get_nic_opaque(nc));<=
br>
+<br>
+=C2=A0 =C2=A0 /* If GMAC receive is disabled. */<br>
+=C2=A0 =C2=A0 if (!(gmac-&gt;regs[R_NPCM_GMAC_MAC_CONFIG] &amp; NPCM_GMAC_=
MAC_CONFIG_RX_EN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* If GMAC DMA RX is stopped. */<br>
+=C2=A0 =C2=A0 if (!(gmac-&gt;regs[R_NPCM_DMA_CONTROL] &amp; NPCM_DMA_CONTR=
OL_START_STOP_RX)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
@@ -191,11 +205,288 @@ static void gmac_update_irq(NPCMGMACState *gmac)<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_irq(gmac-&gt;irq, level);<br>
=C2=A0}<br>
<br>
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t=
 len)<br>
+static int gmac_read_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc)=
<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 /* Placeholder */<br>
+=C2=A0 =C2=A0 if (dma_memory_read(&amp;address_space_memory, addr, desc,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Faile=
d to read descriptor @ 0x%&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx &quot;\n&quot;, __func__, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 desc-&gt;rdes0 =3D le32_to_cpu(desc-&gt;rdes0);<br>
+=C2=A0 =C2=A0 desc-&gt;rdes1 =3D le32_to_cpu(desc-&gt;rdes1);<br>
+=C2=A0 =C2=A0 desc-&gt;rdes2 =3D le32_to_cpu(desc-&gt;rdes2);<br>
+=C2=A0 =C2=A0 desc-&gt;rdes3 =3D le32_to_cpu(desc-&gt;rdes3);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int gmac_write_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc=
)<br>
+{<br>
+=C2=A0 =C2=A0 struct NPCMGMACRxDesc le_desc;<br>
+=C2=A0 =C2=A0 le_desc.rdes0 =3D cpu_to_le32(desc-&gt;rdes0);<br>
+=C2=A0 =C2=A0 le_desc.rdes1 =3D cpu_to_le32(desc-&gt;rdes1);<br>
+=C2=A0 =C2=A0 le_desc.rdes2 =3D cpu_to_le32(desc-&gt;rdes2);<br>
+=C2=A0 =C2=A0 le_desc.rdes3 =3D cpu_to_le32(desc-&gt;rdes3);<br>
+=C2=A0 =C2=A0 if (dma_memory_write(&amp;address_space_memory, addr, &amp;l=
e_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Faile=
d to write descriptor @ 0x%&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx &quot;\n&quot;, __func__, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int gmac_read_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)=
<br>
+{<br>
+=C2=A0 =C2=A0 if (dma_memory_read(&amp;address_space_memory, addr, desc,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Faile=
d to read descriptor @ 0x%&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx &quot;\n&quot;, __func__, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 desc-&gt;tdes0 =3D le32_to_cpu(desc-&gt;tdes0);<br>
+=C2=A0 =C2=A0 desc-&gt;tdes1 =3D le32_to_cpu(desc-&gt;tdes1);<br>
+=C2=A0 =C2=A0 desc-&gt;tdes2 =3D le32_to_cpu(desc-&gt;tdes2);<br>
+=C2=A0 =C2=A0 desc-&gt;tdes3 =3D le32_to_cpu(desc-&gt;tdes3);<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc=
)<br>
+{<br>
+=C2=A0 =C2=A0 struct NPCMGMACTxDesc le_desc;<br>
+=C2=A0 =C2=A0 le_desc.tdes0 =3D cpu_to_le32(desc-&gt;tdes0);<br>
+=C2=A0 =C2=A0 le_desc.tdes1 =3D cpu_to_le32(desc-&gt;tdes1);<br>
+=C2=A0 =C2=A0 le_desc.tdes2 =3D cpu_to_le32(desc-&gt;tdes2);<br>
+=C2=A0 =C2=A0 le_desc.tdes3 =3D cpu_to_le32(desc-&gt;tdes3);<br>
+=C2=A0 =C2=A0 if (dma_memory_write(&amp;address_space_memory, addr, &amp;l=
e_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: Faile=
d to write descriptor @ 0x%&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx &quot;\n&quot;, __func__, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
+static int gmac_rx_transfer_frame_to_buffer(uint32_t rx_buf_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t *left_frame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint32_t rx_buf_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bool *eof_transferred,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const uint8_t **frame_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 uint16_t *transferred)<br>
+{<br>
+=C2=A0 =C2=A0 uint32_t to_transfer;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Check that buffer is bigger than the frame being tra=
nsfered<br>
+=C2=A0 =C2=A0 =C2=A0* If bigger then transfer only whats left of frame<br>
+=C2=A0 =C2=A0 =C2=A0* Else, fill frame with all the content possible<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (rx_buf_len &gt;=3D *left_frame) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 to_transfer =3D *left_frame;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *eof_transferred =3D true;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 to_transfer =3D rx_buf_len;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* write frame part to memory */<br>
+=C2=A0 =C2=A0 if (dma_memory_write(&amp;address_space_memory, (uint64_t) r=
x_buf_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*frame_ptr, to_transfer, MEMTXATTRS_UNSPECIFIED))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* update frame pointer and size of whats left of frame */<b=
r>
+=C2=A0 =C2=A0 *frame_ptr +=3D to_transfer;<br>
+=C2=A0 =C2=A0 *left_frame -=3D to_transfer;<br>
+=C2=A0 =C2=A0 *transferred +=3D to_transfer;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void gmac_dma_set_state(NPCMGMACState *gmac, int shift, uint32_t st=
ate)<br>
+{<br>
+=C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] =3D deposit32(gmac-&gt;regs=
[R_NPCM_DMA_STATUS],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 shift, 3, state);<br>
+}<br>
+<br>
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t=
 len)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Comments have steps that relate to the<br>
+=C2=A0 =C2=A0 =C2=A0* receiving process steps in pg 386<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 NPCMGMACState *gmac =3D NPCM_GMAC(qemu_get_nic_opaque(nc));<=
br>
+=C2=A0 =C2=A0 uint32_t left_frame =3D len;<br>
+=C2=A0 =C2=A0 const uint8_t *frame_ptr =3D buf;<br>
+=C2=A0 =C2=A0 uint32_t desc_addr;<br>
+=C2=A0 =C2=A0 uint32_t rx_buf_len, rx_buf_addr;<br>
+=C2=A0 =C2=A0 struct NPCMGMACRxDesc rx_desc;<br>
+=C2=A0 =C2=A0 uint16_t transferred =3D 0;<br>
+=C2=A0 =C2=A0 bool eof_transferred =3D false;<br>
+<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_packet_receive(DEVICE(gmac)-&gt;canonical_pa=
th, len);<br>
+=C2=A0 =C2=A0 if (!gmac_can_receive(nc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;GMAC Curr=
ently is not able for Rx&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!gmac-&gt;regs[R_NPCM_DMA_HOST_RX_DESC]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_RX_DESC] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_HOST_RX_DESC_MASK(gmac-=
&gt;regs[R_NPCM_DMA_RX_BASE_ADDR]);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 desc_addr =3D NPCM_DMA_HOST_RX_DESC_MASK(gmac-&gt;regs[R_NPC=
M_DMA_HOST_RX_DESC]);<br>
+<br>
+=C2=A0 =C2=A0 /* step 1 */<br>
+=C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SH=
IFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE);<br=
>
+=C2=A0 =C2=A0 trace_npcm_gmac_packet_desc_read(DEVICE(gmac)-&gt;canonical_=
path, desc_addr);<br>
+=C2=A0 =C2=A0 if (gmac_read_rx_desc(desc_addr, &amp;rx_desc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;RX Descri=
ptor @ 0x%x cant be read\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 desc_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PR=
OCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_SUSPENDED_STA=
TE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* step 2 */<br>
+=C2=A0 =C2=A0 if (!(rx_desc.rdes0 &amp; RX_DESC_RDES0_OWN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;RX Descriptor @ 0x%x is owned by software\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 desc_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA=
_STATUS_RU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA=
_STATUS_RI;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PR=
OCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_SUSPENDED_STA=
TE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_update_irq(gmac);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* step 3 */<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* TODO --<br>
+=C2=A0 =C2=A0 =C2=A0* Implement all frame filtering and processing (with i=
ts own interrupts)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_debug_desc_data(DEVICE(gmac)-&gt;canonical_p=
ath, &amp;rx_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0, rx_desc=
.rdes1, rx_desc.rdes2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes3);<br>
+=C2=A0 =C2=A0 /* Clear rdes0 for the incoming descriptor and set FS in fir=
st descriptor.*/<br>
+=C2=A0 =C2=A0 rx_desc.rdes0 =3D RX_DESC_RDES0_FIRST_DESC_MASK;<br>
+<br>
+=C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SH=
IFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE)=
;<br>
+<br>
+=C2=A0 =C2=A0 /* Pad the frame with FCS as the kernel driver will strip it=
 away. */<br>
+=C2=A0 =C2=A0 left_frame +=3D ETH_FCS_LEN;<br>
+<br>
+=C2=A0 =C2=A0 /* repeat while we still have frame to transfer to memory */=
<br>
+=C2=A0 =C2=A0 while (!eof_transferred) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Return descriptor no matter what happens */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0 &amp;=3D ~RX_DESC_RDES0_OWN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the frame to be an IPv4/IPv6 frame. */<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0 |=3D RX_DESC_RDES0_FRM_TYPE_MASK=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* step 4 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_buf_len =3D RX_DESC_RDES1_BFFR1_SZ_MASK(rx_=
desc.rdes1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_buf_addr =3D rx_desc.rdes2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_CUR_RX_BUF_ADDR] =3D =
rx_buf_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_rx_transfer_frame_to_buffer(rx_buf_len, &=
amp;left_frame, rx_buf_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;eof_transferred, &amp;frame_ptr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;transferred);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_packet_receiving_buffer(DEVICE=
(gmac)-&gt;canonical_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 rx_buf_len, rx_buf_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if we still have frame left and the second =
buffer is not chained */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(rx_desc.rdes1 &amp; RX_DESC_RDES1_=
SEC_ADDR_CHND_MASK) &amp;&amp; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !eof_transferred) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* repeat process from above on =
buffer 2 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_buf_len =3D RX_DESC_RDES1_BFF=
R2_SZ_MASK(rx_desc.rdes1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_buf_addr =3D rx_desc.rdes3;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_CUR_RX_=
BUF_ADDR] =3D rx_buf_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_rx_transfer_frame_to_buffer=
(rx_buf_len, &amp;left_frame,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0rx_buf_addr, &amp;eof_transferred,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&amp;frame_ptr, &amp;transferred);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_packet_receiving=
_buffer( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 DEVICE(gmac)-&gt;canonical_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 rx_buf_len, rx_buf_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* update address for descriptor */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_RX_DESC] =3D rx_=
buf_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Return descriptor */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0 &amp;=3D ~RX_DESC_RDES0_OWN;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Update frame length transferred */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0 |=3D ((uint32_t)transferred)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&lt; RX_DESC_RDES0_FRAME_LEN=
_SHIFT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_debug_desc_data(DEVICE(gmac)-&=
gt;canonical_path, &amp;rx_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.=
rdes0, rx_desc.rdes1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.=
rdes2, rx_desc.rdes3);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* step 5 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_write_rx_desc(desc_addr, &amp;rx_desc);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_debug_desc_data(DEVICE(gmac)-&=
gt;canonical_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;rx_=
desc, rx_desc.rdes0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.=
rdes1, rx_desc.rdes2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.=
rdes3);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* read new descriptor into rx_desc if needed*=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!eof_transferred) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Get next descriptor address (=
chained or sequential) */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rx_desc.rdes1 &amp; RX_DESC_=
RDES1_RC_END_RING_MASK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D gmac=
-&gt;regs[R_NPCM_DMA_RX_BASE_ADDR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (rx_desc.rdes1 &amp; R=
X_DESC_RDES1_SEC_ADDR_CHND_MASK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D rx_d=
esc.rdes3;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr +=3D siz=
eof(rx_desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_packet_desc_read=
(DEVICE(gmac)-&gt;canonical_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0desc_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (gmac_read_rx_desc(desc_addr,=
 &amp;rx_desc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_=
GUEST_ERROR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;RX Descriptor @ 0x%x cant be read\n&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NP=
CM_DMA_STATUS] |=3D NPCM_DMA_STATUS_RU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_update_irq(gm=
ac);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* step 6 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(rx_desc.rdes0 &amp; RX_DES=
C_RDES0_OWN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(gmac-&gt;reg=
s[R_NPCM_DMA_CONTROL] &amp; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0NPCM_DMA_CONTROL_FLUSH_MASK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_d=
esc.rdes0 |=3D RX_DESC_RDES0_DESC_ERR_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eof_transferred =
=3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clear rdes0 for the incoming =
descriptor */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0 =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SH=
IFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE);<br>
+<br>
+=C2=A0 =C2=A0 rx_desc.rdes0 |=3D RX_DESC_RDES0_LAST_DESC_MASK;<br>
+=C2=A0 =C2=A0 if (!(rx_desc.rdes1 &amp; RX_DESC_RDES1_DIS_INTR_COMP_MASK))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] |=3D NPCM_DMA=
_STATUS_RI;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_update_irq(gmac);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_debug_desc_data(DEVICE(gmac)-&gt;canonical_p=
ath, &amp;rx_desc,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes0, rx_desc=
.rdes1, rx_desc.rdes2,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_desc.rdes3);<br>
+<br>
+=C2=A0 =C2=A0 /* step 8 */<br>
+=C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_CONTROL] |=3D NPCM_DMA_CONTROL_FLUS=
H_MASK;<br>
+<br>
+=C2=A0 =C2=A0 /* step 9 */<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_packet_received(DEVICE(gmac)-&gt;canonical_p=
ath, left_frame);<br>
+=C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SH=
IFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);<br>
+=C2=A0 =C2=A0 gmac_write_rx_desc(desc_addr, &amp;rx_desc);<br>
+<br>
+=C2=A0 =C2=A0 /* Get next descriptor address (chained or sequential) */<br=
>
+=C2=A0 =C2=A0 if (rx_desc.rdes1 &amp; RX_DESC_RDES1_RC_END_RING_MASK) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D gmac-&gt;regs[R_NPCM_DMA_RX_BASE=
_ADDR];<br>
+=C2=A0 =C2=A0 } else if (rx_desc.rdes1 &amp; RX_DESC_RDES1_SEC_ADDR_CHND_M=
ASK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr =3D rx_desc.rdes3;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 desc_addr +=3D sizeof(rx_desc);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_RX_DESC] =3D desc_addr;<br>
+=C2=A0 =C2=A0 return len;<br>
+}<br>
=C2=A0static void gmac_cleanup(NetClientState *nc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Nothing to do yet. */<br>
@@ -281,7 +572,6 @@ static void npcm_gmac_write(void *opaque, hwaddr offset=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t v, unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0NPCMGMACState *gmac =3D opaque;<br>
-=C2=A0 =C2=A0 uint32_t prev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_npcm_gmac_reg_write(DEVICE(gmac)-&gt;canonical_pa=
th, offset, v);<br>
<br>
@@ -305,22 +595,7 @@ static void npcm_gmac_write(void *opaque, hwaddr offse=
t,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC_CONFIG:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D gmac-&gt;regs[offset / sizeof(uint32_=
t)];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmac-&gt;regs[offset / sizeof(uint32_t)] =
=3D v;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If transmit is being enabled for first time=
, update desc addr */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (~(prev &amp; NPCM_GMAC_MAC_CONFIG_TX_EN) &=
amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(v &amp; NPCM_GMAC_MAC_CON=
FIG_TX_EN)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_TX=
_DESC] =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NP=
CM_DMA_TX_BASE_ADDR];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If receive is being enabled for first time,=
 update desc addr */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (~(prev &amp; NPCM_GMAC_MAC_CONFIG_RX_EN) &=
amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(v &amp; NPCM_GMAC_MAC_CON=
FIG_RX_EN)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_RX=
_DESC] =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NP=
CM_DMA_RX_BASE_ADDR];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div>Why are these lines rem=
oved? Maybe they should exist in the first patch we&#39;ve added them if we=
 don&#39;t need them.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MII_ADDR:<br>
@@ -362,6 +637,31 @@ static void npcm_gmac_write(void *opaque, hwaddr offse=
t,<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_DMA_RCV_POLL_DEMAND:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We dont actually care about the value =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PR=
OCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX_RUNNING_WAITI=
NG_STATE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case A_NPCM_DMA_XMT_POLL_DEMAND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We dont actually care about the value */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_try_send_next_packet(gmac);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case A_NPCM_DMA_CONTROL:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_CONTROL_START_STOP_TX) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_try_send_next_packet(gmac);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DM=
A_STATUS_TX_PROCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_TX=
_STOPPED_STATE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_CONTROL_START_STOP_RX) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DM=
A_STATUS_RX_PROCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX=
_RUNNING_WAITING_STATE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_g=
et_queue(gmac-&gt;nic));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DM=
A_STATUS_RX_PROCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX=
_STOPPED_STATE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_DMA_STATUS:<br>
@@ -371,16 +671,14 @@ static void npcm_gmac_write(void *opaque, hwaddr offs=
et,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s: Write of read-only bits of reg: offset: 0=
x%04&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 HWADDR_PRIx &quot;, value: 0x%04&quot; PRIx64 &quo=
t;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 DEVICE(gmac)-&gt;canonical_path, offset, v);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for W1c bits, implement W1C *=
/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(ui=
nt32_t)] &amp;=3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~NPCM_DMA_STATUS_W=
1C_MASK(v);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_STATUS_NIS_=
BITS) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offs=
et / sizeof(uint32_t)] &amp;=3D ~NPCM_DMA_STATUS_NIS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_STATUS_AIS_=
BITS) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offs=
et / sizeof(uint32_t)] &amp;=3D ~NPCM_DMA_STATUS_AIS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div>ditto.=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for W1C bits, implement W1C */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] &amp;=
=3D ~NPCM_DMA_STATUS_W1C_MASK(v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_STATUS_RU) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Clearing RU bit indicates des=
criptor is owned by DMA again. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac_dma_set_state(gmac, NPCM_DM=
A_STATUS_RX_PROCESS_STATE_SHIFT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_DMA_STATUS_RX=
_RUNNING_WAITING_STATE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_g=
et_queue(gmac-&gt;nic));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h<br>
index c97eb6fe6e..d0a37e6988 100644<br>
--- a/include/hw/net/npcm_gmac.h<br>
+++ b/include/hw/net/npcm_gmac.h<br>
@@ -136,7 +136,7 @@ struct NPCMGMACTxDesc {<br>
=C2=A0#define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)<br>
=C2=A0/* Last Segment */<br>
=C2=A0#define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)<br>
-/* Last Segment */<br>
+/* First Segment */<br>
=C2=A0#define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)<br>
=C2=A0/* Checksum Insertion Control */<br>
=C2=A0#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2=
)<br>
@@ -176,32 +176,32 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)<=
br>
=C2=A0#define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20<br>
=C2=A0/* Transmit States */<br>
=C2=A0#define NPCM_DMA_STATUS_TX_STOPPED_STATE \<br>
-=C2=A0 =C2=A0 (0b000 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b000)<br>
=C2=A0#define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \<br>
-=C2=A0 =C2=A0 (0b001 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b001)<br>
=C2=A0#define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \<br>
-=C2=A0 =C2=A0 (0b010 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b010)<br>
=C2=A0#define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \<br>
-=C2=A0 =C2=A0 (0b011 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b011)<br>
=C2=A0#define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \<br>
-=C2=A0 =C2=A0 (0b110 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b110)<br>
=C2=A0#define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \<br>
-=C2=A0 =C2=A0 (0b111 &lt;&lt; NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b111)<br>
=C2=A0/* Transmit Process State */<br>
=C2=A0#define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17<br>
=C2=A0/* Receive States */<br>
=C2=A0#define NPCM_DMA_STATUS_RX_STOPPED_STATE \<br>
-=C2=A0 =C2=A0 (0b000 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b000)<br>
=C2=A0#define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \<br>
-=C2=A0 =C2=A0 (0b001 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b001)<br>
=C2=A0#define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \<br>
-=C2=A0 =C2=A0 (0b011 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b011)<br>
=C2=A0#define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \<br>
-=C2=A0 =C2=A0 (0b100 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b100)<br>
=C2=A0#define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \<br>
-=C2=A0 =C2=A0 (0b101 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b101)<br>
=C2=A0#define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \<br>
-=C2=A0 =C2=A0 (0b111 &lt;&lt; NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)<br>
+=C2=A0 =C2=A0 (0b111)<br>
<br>
<br>
=C2=A0/* Early Receive Interrupt */<br>
@@ -302,6 +302,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)<br=
>
=C2=A0#define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)<br>
=C2=A0/* Start/stop Transmit */<br>
=C2=A0#define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)<br>
+/* Start/stop Receive */<br>
+#define NPCM_DMA_CONTROL_START_STOP_RX BIT(1)<br>
=C2=A0/* Next receive descriptor start address */<br>
=C2=A0#define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) &amp; ~3u=
)<br>
=C2=A0/* Next transmit descriptor start address */<br>
-- <br>
2.42.0.655.g421f12c284-goog<br>
<br>
</blockquote></div></div>

--0000000000000c3ed20607f2aa9c--

