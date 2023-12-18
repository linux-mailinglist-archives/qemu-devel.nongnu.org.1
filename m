Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993B8173DC
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:39:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFElf-0000L8-4S; Mon, 18 Dec 2023 09:38:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFElW-0000Kn-5Z
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:38:42 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFElU-0002iy-Dz
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:38:41 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so212797a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702910319; x=1703515119; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bgj0sVrI7U95CLv7d0BYIHP/xkmJZivXlbPSx3e/iDk=;
 b=jYTJb+Grf5p7psAsq5bto4SOed9imocfKMrytciikuOgjxfvnP9FChOt/9kaVar3Qj
 9ZTxSfxpYaS3lYiTdnnj9ckWVDQpH6goXwKafMxE1gpbjNBUsBAnheZGxutQO73W8RwF
 jWz0fb44dZxtJI64YxZNwz/a0CPE/ApIALZes1+NEWBEJ+fEVcNEjd3UkFYvN/7ixEOE
 4LuJim2xI9z8GWE0GodMEFVUDctpEK0V0yF+2R4NyZIq7EQwCZJJj5MzRGSzm55R4SVB
 oTeeP9Gwq3LnuixXc2+G2c8XoQAMurye+LYu5Nq7ZEM8tePyaFYX+n2IACfLSUkw0pQg
 LkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702910319; x=1703515119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bgj0sVrI7U95CLv7d0BYIHP/xkmJZivXlbPSx3e/iDk=;
 b=LdH6cVFwT20KtuOcoHZHzdp3Bvwg9uIlIilgAteGC6hBsSVvx6lGAazTidOY03EDxJ
 ePS4TBHPXRO790hoO7uReEF9NCc4ew1DKH9N0Xsc0bKRdZaiSF+Bmlo+KwNQSKSUnQUC
 NpGZzmy18fWS5A8Mi3D7B1gsqUaXXzX2btyCa3V7vHM3XGOCQr/Wx9BfKYx7rSYhqA89
 KCREf4U7VcJBAcVBA00JVFTr+RDEvjrPyCZo39DvKvImtrV7qAtGECMIRTjdcrgL/Yq9
 BfG+FQAdHhej5RlPTIVqjIQzBh64MDTfhkCv5qaIb8lxviPpz8HTfNAERzLOpDL8ZZzN
 XC+w==
X-Gm-Message-State: AOJu0YwHZmplgk0i31XPOF/5Xqn8OysAtQWd5haXNDrOu3TvwnfNsh/y
 sTp9rogutaVPDk8MezXxeYwCtYagFJCh5vkmgVL99g==
X-Google-Smtp-Source: AGHT+IFm3/pF++7j9mVkDej1tskpvLfA06D4xobsFQ7fNQgQuPaStMUUEzSxRyT4h6sFZfv5N6RRNI3FwdoOlYeH8DI=
X-Received: by 2002:a50:baa2:0:b0:553:42bd:f0ee with SMTP id
 x31-20020a50baa2000000b0055342bdf0eemr1602405ede.53.1702910318770; Mon, 18
 Dec 2023 06:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20231214211527.1946302-1-nabihestefan@google.com>
 <20231214211527.1946302-9-nabihestefan@google.com>
In-Reply-To: <20231214211527.1946302-9-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 14:38:27 +0000
Message-ID: <CAFEAcA9e8Pe38ei=L16w-JrQDLmH9wHoKDjktJLFNMoFCpHZCg@mail.gmail.com>
Subject: Re: [PATCH v8 08/11] hw/net: General GMAC Implementation
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 14 Dec 2023 at 21:15, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> - General GMAC Register handling
> - GMAC IRQ Handling
> - Added traces in some methods for debugging
> - Lots of declarations for accessing information on GMAC Descriptors (npcm_gmac.h file)
>
> NOTE: With code on this state, the GMAC can boot-up properly and will show up in the ifconfig command on the BMC

This commit message does not match the contents of the patch.

> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  hw/net/npcm_gmac.c         |  26 -----
>  include/hw/net/npcm_gmac.h | 198 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 184 insertions(+), 40 deletions(-)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index be3f076200..09f048383b 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -305,22 +305,6 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
>          break;
>
>      case A_NPCM_GMAC_MAC_CONFIG:
> -        prev = gmac->regs[offset / sizeof(uint32_t)];
> -        gmac->regs[offset / sizeof(uint32_t)] = v;
> -
> -        /* If transmit is being enabled for first time, update desc addr */
> -        if (~(prev & NPCM_GMAC_MAC_CONFIG_TX_EN) &
> -             (v & NPCM_GMAC_MAC_CONFIG_TX_EN)) {
> -            gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
> -                gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
> -        }
> -
> -        /* If receive is being enabled for first time, update desc addr */
> -        if (~(prev & NPCM_GMAC_MAC_CONFIG_RX_EN) &
> -             (v & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
> -            gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =
> -                gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
> -        }
>          break;
>
>      case A_NPCM_GMAC_MII_ADDR:
> @@ -371,16 +355,6 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
>                            "%s: Write of read-only bits of reg: offset: 0x%04"
>                             HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
>                             DEVICE(gmac)->canonical_path, offset, v);
> -        } else {
> -            /* for W1c bits, implement W1C */
> -            gmac->regs[offset / sizeof(uint32_t)] &=
> -                ~NPCM_DMA_STATUS_W1C_MASK(v);
> -            if (v & NPCM_DMA_STATUS_NIS_BITS) {
> -                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_NIS;
> -            }
> -            if (v & NPCM_DMA_STATUS_AIS_BITS) {
> -                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_AIS;
> -            }
>          }
>          break;

Why has this code been deleted in this patch ?

>
> diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
> index e5729e83ea..c97eb6fe6e 100644
> --- a/include/hw/net/npcm_gmac.h
> +++ b/include/hw/net/npcm_gmac.h
> @@ -34,13 +34,15 @@ struct NPCMGMACRxDesc {
>  };
>
>  /* NPCMGMACRxDesc.flags values */
> -/* RDES2 and RDES3 are buffer address pointers */
> -/* Owner: 0 = software, 1 = gmac */
> -#define RX_DESC_RDES0_OWNER_MASK BIT(31)
> +/* RDES2 and RDES3 are buffer addresses */
> +/* Owner: 0 = software, 1 = dma */
> +#define RX_DESC_RDES0_OWN BIT(31)
>  /* Destination Address Filter Fail */
> -#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
> -/* Frame length*/
> -#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
> +#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL BIT(30)
> +/* Frame length */
> +#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 14)
> +/* Frame length Shift*/
> +#define RX_DESC_RDES0_FRAME_LEN_SHIFT 16
>  /* Error Summary */
>  #define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
>  /* Descriptor Error */
> @@ -83,9 +85,9 @@ struct NPCMGMACRxDesc {
>  /* Receive Buffer 2 Size */
>  #define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
>  #define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
> -    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
> +    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 11)
>  /* Receive Buffer 1 Size */
> -#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
> +#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 11)

More churn here. Please go through your whole patchset reading
each patch and making sure that you don't have anything where
an earlier patch adds in some code and then a later patch
changes the way it's written unnecessarily.

thanks
-- PMM

