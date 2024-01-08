Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533858271FF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:58:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMr3X-0003PA-Vh; Mon, 08 Jan 2024 09:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr3W-0003On-39
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:56:46 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr3T-0001KY-UC
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:56:45 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5576ca4119cso1943426a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704725801; x=1705330601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vHJYva61x1YuN9zzm4jDVjaHgp/eHx7W1tefxS04oZc=;
 b=po8MFGL+yI42xFSumHqMhOWT0vS1o1T6FHED8iPFSFmhDrDfAhOG0PM4rTj3zvoXZo
 u7WYx/gka+zwbBb7ivcSGeNX4/e6v6/vb2DzioAZXZ5AOQjdZ/0E8Fl/+1qVXOpRSgSS
 3Zj54Bxdgmg4lVfXZ/j87Wd3ynVle+w4D5wavkJjjyFpFa8LV6Ai5V/UwS/7e4N8T9a3
 0gwTERDkKhPymR5MFN5fmGIFAUinXf0ZfsbwyYV09ce+heUjZsxSgG6xnVcCBIntR8AX
 dAXEUmx9v5Te2J4doZ60PIBTdua3Eez9d6PxqhDCMTDCGOODXX1IDp5Oza0pW47oK9s/
 QJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704725801; x=1705330601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHJYva61x1YuN9zzm4jDVjaHgp/eHx7W1tefxS04oZc=;
 b=WfQUe1H9YhhE9opD30c4/PS4XoYU9SKCDWxKwv0mGHHq2aX/hSF6qDcGA8Q+eo8RWp
 yWqR6r5868IN9ejGekwllXQyRe61V9XTNcWwt0M9TIbwSbVA6QA8rzQZMof9fBm5rFol
 Eje9EHLlNyBWwpRr1F2vIQqm+0lWul5INCtL9wxafgLbtok0gysz2McwNI1zS18cpWGm
 G29hB3MPr5VO69RBtz/B99raT5PWgQYlWSVCUo8+PQBaUP8ch/fTZ4UtNgXBU0bom06z
 b3GHTJ2qy8Y+S87K6IEmesjvNfbtVk+W0CNJ71skQKquUsYXDKSpKTui8f0ovIacXqvz
 /Xvw==
X-Gm-Message-State: AOJu0Yws/BDuUNhXE2Ujy3KYsbSpcLTsJmBFANp91kuRDqVksdos9uBd
 OJVDZJsZcV5YkgtjiGg09y/Xuic5lk+lRuQnoGFZHmBXvMnh+Q==
X-Google-Smtp-Source: AGHT+IFDKrEqB694UiZukvRKtqnNJgn/5SW2dG4r2DaRK0V9UTHhK07yV4IZ0mG3te7JqJ1lKXjgZdQEbgddUpGrJkY=
X-Received: by 2002:a05:6402:17d9:b0:552:9915:fab1 with SMTP id
 s25-20020a05640217d900b005529915fab1mr1918347edy.47.1704725801277; Mon, 08
 Jan 2024 06:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20231219213255.604535-1-nabihestefan@google.com>
 <20231219213255.604535-10-nabihestefan@google.com>
In-Reply-To: <20231219213255.604535-10-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 14:56:30 +0000
Message-ID: <CAFEAcA8JSjXKwaXPPC904sjxK6=u91q4Ggd-vGm3oatVfR-0LA@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] hw/net: GMAC Tx Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 19 Dec 2023 at 21:33, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - Implementation of Transmit function for packets
> - Implementation for reading and writing from and to descriptors in
>   memory for Tx
>
> NOTE: This function implements the steps detailed in the datasheet for
> transmitting messages from the GMAC.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  hw/net/npcm_gmac.c | 153 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index fe7b0421ef..69e61b2b67 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -265,6 +265,7 @@ static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
>      }
>      return 0;
>  }
> +
>  static int gmac_rx_transfer_frame_to_buffer(uint32_t rx_buf_len,
>                                              uint32_t *left_frame,
>                                              uint32_t rx_buf_addr,
> @@ -487,6 +488,158 @@ static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
>      return len;
>  }
>
> +<<<<<<< HEAD
> +=======

There are still patch conflict markers in this patch.
This suggests you didn't build and test it before sending
it out, which is generally a minimum standard we expect...

> +static int gmac_tx_get_csum(uint32_t tdes1)
> +{
> +    uint32_t mask = TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(tdes1);
> +    int csum = 0;
> +
> +    if (likely(mask > 0)) {
> +        csum |= CSUM_IP;
> +    }
> +    if (likely(mask > 1)) {
> +        csum |= CSUM_TCP | CSUM_UDP;
> +    }
> +
> +    return csum;
> +}
> +
> +static void gmac_try_send_next_packet(NPCMGMACState *gmac)
> +{
> +    /*
> +     * Comments about steps refer to steps for
> +     * transmitting in page 384 of datasheet
> +     */
> +    uint16_t tx_buffer_size = 2048;
> +    g_autofree uint8_t *tx_send_buffer = g_malloc(tx_buffer_size);
> +    uint32_t desc_addr;
> +    struct NPCMGMACTxDesc tx_desc;
> +    uint32_t tx_buf_addr, tx_buf_len;
> +    uint16_t length = 0;
> +    uint8_t *buf = tx_send_buffer;
> +    uint32_t prev_buf_size = 0;
> +    int csum = 0;
> +
> +    /* steps 1&2 */
> +    if (!gmac->regs[R_NPCM_DMA_HOST_TX_DESC]) {
> +        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
> +            NPCM_DMA_HOST_TX_DESC_MASK(gmac->regs[R_NPCM_DMA_TX_BASE_ADDR]);
> +    }
> +    desc_addr = gmac->regs[R_NPCM_DMA_HOST_TX_DESC];
> +
> +    while (true) {
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE);
> +        if (gmac_read_tx_desc(desc_addr, &tx_desc)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "TX Descriptor @ 0x%x can't be read\n",
> +                          desc_addr);
> +            return;
> +        }
> +        /* step 3 */
> +
> +        trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path,
> +            desc_addr);
> +        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &tx_desc,
> +            tx_desc.tdes0, tx_desc.tdes1, tx_desc.tdes2, tx_desc.tdes3);
> +
> +        /* 1 = DMA Owned, 0 = Software Owned */
> +        if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "TX Descriptor @ 0x%x is owned by software\n",
> +                          desc_addr);
> +            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TU;
> +            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +                NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
> +            gmac_update_irq(gmac);
> +            return;
> +        }
> +
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_READ_STATE);
> +        /* Give the descriptor back regardless of what happens. */
> +        tx_desc.tdes0 &= ~TX_DESC_TDES0_OWN;
> +
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_FIRST_SEG_MASK) {
> +            csum = gmac_tx_get_csum(tx_desc.tdes1);
> +        }
> +
> +        /* step 4 */
> +        tx_buf_addr = tx_desc.tdes2;
> +        gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
> +        tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
> +        buf = &tx_send_buffer[prev_buf_size];
> +
> +        if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
> +            tx_buffer_size = prev_buf_size + tx_buf_len;
> +            tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
> +            buf = &tx_send_buffer[prev_buf_size];
> +        }
> +
> +        /* step 5 */
> +        if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
> +                            tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read packet @ 0x%x\n",
> +                        __func__, tx_buf_addr);
> +            return;
> +        }
> +        length += tx_buf_len;
> +        prev_buf_size += tx_buf_len;
> +
> +        /* If not chained we'll have a second buffer. */
> +        if (!(tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK)) {
> +            tx_buf_addr = tx_desc.tdes3;
> +            gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
> +            tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
> +            buf = &tx_send_buffer[prev_buf_size];
> +
> +            if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
> +                tx_buffer_size = prev_buf_size + tx_buf_len;
> +                tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
> +                buf = &tx_send_buffer[prev_buf_size];
> +            }
> +
> +            if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
> +                                tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Failed to read packet @ 0x%x\n",
> +                              __func__, tx_buf_addr);
> +                return;
> +            }
> +            length += tx_buf_len;
> +            prev_buf_size += tx_buf_len;
> +        }
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_LAST_SEG_MASK) {
> +            net_checksum_calculate(tx_send_buffer, length, csum);
> +            qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
> +            trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
> +            buf = tx_send_buffer;
> +            length = 0;
> +        }
> +
> +        /* step 6 */
> +        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
> +            NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE);
> +        gmac_write_tx_desc(desc_addr, &tx_desc);
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_TX_END_RING_MASK) {
> +            desc_addr = gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
> +        } else if (tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK) {
> +            desc_addr = tx_desc.tdes3;
> +        } else {
> +            desc_addr += sizeof(tx_desc);
> +        }
> +        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] = desc_addr;
> +
> +        /* step 7 */
> +        if (tx_desc.tdes1 & TX_DESC_TDES1_INTERR_COMP_MASK) {
> +            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TI;
> +            gmac_update_irq(gmac);
> +        }
> +    }
> +}
> +
> +>>>>>>> 107e0d0181 (hw/net: GMAC Tx Implementation)
>  static void gmac_cleanup(NetClientState *nc)
>  {
>      /* Nothing to do yet. */
> --
> 2.43.0.472.g3155946c3a-goog

-- PMM

