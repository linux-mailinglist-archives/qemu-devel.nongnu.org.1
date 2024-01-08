Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2814C827203
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:59:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMr5t-00054i-UC; Mon, 08 Jan 2024 09:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr5h-00054D-UA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:59:03 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMr5f-0001yk-WF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:59:01 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-557c188f313so1144337a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704725937; x=1705330737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c7iYMBVhBsrYnsJcY2FLpqUui1X0DuZ9loQO9NDMOOY=;
 b=Ld/8AJEW0iu14ebwL5kJhSqG3kiRX/Rx0f6LdYpYvKSsYdTk/lt//TZu9bV8oKKBVu
 hkULHwVsKIOE73kN0Wyd4970ruXhexjlgAFx8SsgY26ZLqsXlN065t58WLZ8k0oPd+ns
 O5DIGP1z+3jDb/1EwdgMVNUtwHoXaiNjexjbV30rCRU1FpiQRYTLU2ng6oEsxWo8D1D/
 lUSpqrYDmK9PZ8DM9bqx8dAa5c+YOUYt3krHGnO68BpnNlCJqLrsx2zGXk98AXr5g53J
 4TblPvs8/4hQ7PZl4oERJLre3h6C7XldzqwViqZWzIw94GlMmJ7CObSg1fc+Z1u2Yy4+
 xlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704725937; x=1705330737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c7iYMBVhBsrYnsJcY2FLpqUui1X0DuZ9loQO9NDMOOY=;
 b=naJbK+3VeUaRKhvsqBsGoWrrlimiYqg0Rr3c9WE2FYUKijw+JrFaOPVP72+763l0Sf
 IVy1GoHiqv+493UaeSXc5gIFC41bPxydO5+jH2OdMSLaeHVLvkbFUbE/oW9FftoV1U+S
 AoeyKw7J+zOcA6fnvexlsSQkQRDMkiB7Ca0w3WMizr8M38DxMaEjxKbudes55rCzZbXv
 7rdLClDkqdfBU7TqNGrpmYL2tPrJQqdj5hxpj5ruF2UeaWauheVVtbWEWo6utTY2vlJU
 8lXp5cLukj9ZuJcoMuEBNrHPweGAoL9QDs3aMH1Wg/SwB1yoze99r9ubQvXIPBv2M62y
 dC+w==
X-Gm-Message-State: AOJu0YzWbnSWaJvM0/1c6TuRQZrGJhgjUg051kaChFRJd/NUFt9F9LW1
 dWJYv/09wohl/kqRWlRSLHEWNeYoAlWjQSbZ7qpy5Frs+4VXug==
X-Google-Smtp-Source: AGHT+IG11vjmuTJV0mVDAKoavLJoChDVE9MIaSHkOM3KeTcth5NlelL7Jlkjv5yfEr27wPdWLsueooD5JnB9In7IGMc=
X-Received: by 2002:a50:9ea2:0:b0:556:e101:535 with SMTP id
 a31-20020a509ea2000000b00556e1010535mr4281619edf.37.1704725937481; Mon, 08
 Jan 2024 06:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20231219213255.604535-1-nabihestefan@google.com>
 <20231219213255.604535-8-nabihestefan@google.com>
In-Reply-To: <20231219213255.604535-8-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 14:58:46 +0000
Message-ID: <CAFEAcA82Bgh8qQ7sxdMTHTfdMO97qTdbdB4xCcGLnKXgoATGMg@mail.gmail.com>
Subject: Re: [PATCH v9 07/10] include/hw/net: General GMAC Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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
> Implemented Classes and Masks for GMAC Descriptors
>  - Implemeted classes for GMAC Receive and Transmit Descriptors
>  - Implemented Masks for said descriptors
>
> - General GMAC Register handling
> - GMAC IRQ Handling
>

This commit message doesn't match the changes in the patch:
it claims it's adding a lot more than it actually does.


> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  hw/net/npcm_gmac.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  hw/net/trace-events |  8 ++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 98b3c33c94..44c4ffaff4 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -149,6 +149,46 @@ static bool gmac_can_receive(NetClientState *nc)
>      return true;
>  }
>
> +/*
> + * Function that updates the GMAC IRQ
> + * It find the logical OR of the enabled bits for NIS (if enabled)
> + * It find the logical OR of the enabled bits for AIS (if enabled)
> + */
> +static void gmac_update_irq(NPCMGMACState *gmac)
> +{
> +    /*
> +     * Check if the normal interrupts summary is enabled
> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
> +        (NPCM_DMA_INTR_ENAB_NIE_BITS)) {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_NIS;
> +    }
> +    /*
> +     * Check if the abnormal interrupts summary is enabled
> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
> +        (NPCM_DMA_INTR_ENAB_AIE_BITS)) {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_AIS;
> +    }
> +
> +    /* Get the logical OR of both normal and abnormal interrupts */
> +    int level = !!((gmac->regs[R_NPCM_DMA_STATUS] &
> +                    gmac->regs[R_NPCM_DMA_INTR_ENA] &
> +                    NPCM_DMA_STATUS_NIS) |
> +                   (gmac->regs[R_NPCM_DMA_STATUS] &
> +                   gmac->regs[R_NPCM_DMA_INTR_ENA] &
> +                   NPCM_DMA_STATUS_AIS));
> +
> +    /* Set the IRQ */
> +    trace_npcm_gmac_update_irq(DEVICE(gmac)->canonical_path,
> +                               gmac->regs[R_NPCM_DMA_STATUS],
> +                               gmac->regs[R_NPCM_DMA_INTR_ENA],
> +                               level);
> +    qemu_set_irq(gmac->irq, level);
> +}
> +
>  static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
>  {
>      /* Placeholder. Function will be filled in following patches */
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 33514548b8..78efa2ec2c 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -473,6 +473,14 @@ npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offs
>  npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
>  npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
>  npcm_gmac_set_link(bool active) "Set link: active=%u"
> +npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04" PRIX32 " IRQ Set: %d"
> +npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) "%s: attempting to read descriptor @0x%04" PRIX32
> +npcm_gmac_packet_receive(const char* name, uint32_t len) "%s: RX packet length: 0x%04" PRIX32
> +npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len, uint32_t rx_buf_addr) "%s: Receiving into Buffer size: 0x%04" PRIX32 " at address 0x%04" PRIX32
> +npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finished, packet left: 0x%04" PRIX32
> +npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet sent!, length: 0x%04" PRIX16
> +npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
> +npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32

Most of these trace events don't correspond to the code change
in the patch; they should be added in the same patch which adds
the call to the trace event.

thanks
-- PMM

