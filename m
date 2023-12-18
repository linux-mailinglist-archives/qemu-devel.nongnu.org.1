Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD08173CE
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:38:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEjh-0007md-CJ; Mon, 18 Dec 2023 09:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFEjc-0007ll-2V
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:36:45 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFEjO-0002Pu-VX
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:36:42 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54f4f7e88feso4266248a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702910186; x=1703514986; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwkqfPcsGAp7aDWReZVSUF9rt/1jfsc6XeTbvrPW6N4=;
 b=aV8ZU7rIC0FOgSDcYfU0ZR9P6d52wpL6e6Fzz4alV3UGVupc9vJjMe0WtsJ9Czt/p+
 Bodd8LF33/wDhae5mqYxoOC6OlEf01/GDj5QzNtj7+hGZ/tEMN4RztTZZtlR8tBX2Yl/
 SJKZ+vVOIUAd7S+VAsoJK7AdKA6c5t8sVu1kyf4t6dV3Z5CWfohSMAsHFL4QpErgadH4
 hYYZ1vDjejkRpf9EtShC5aahZvQQz7b4fdROL9vU7VA+CsLMv7ugMj1M5QOU2JuoHBnN
 gn6hacC/u5yU0Xsbyy5vPg4BOK8B+PASya/t/ni3v0HJH3DYmi2SQuqPOx0oF8AVn8z1
 K2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702910186; x=1703514986;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwkqfPcsGAp7aDWReZVSUF9rt/1jfsc6XeTbvrPW6N4=;
 b=rfLiQ7BSBKOX3asuO/cdya74anxWQtJxhMlZ6b+mAuA9crpb3Ll5+B+Ey24HEUv7JF
 KNhp9awk7CL0pIcba/V50HKh3rMbJcQTTv5MKZ7YmpwQf+mx6EAx1sDzjILOeTITurxe
 y+PTcXmdQ6OQ3QaYrTTjmyrP0OlSFOT8laBb3D/h7e5/ip9DzYI+ySMtSr/X5stsRZch
 IRBfeW2nt5nyREKUmLQwOo+djPjdMp/n5rXda7Wmj2OIXt5Wg9H+1suzbqmg4GyWdHKg
 Y9uAk+KF/998jrCryKWCzbcIj6F7aJK+7JZKzTORqVE4y1P/SYqAtSPll6G3Zws6XY/w
 v7ng==
X-Gm-Message-State: AOJu0YzTyjNhd/auGtyM2shPLQBPJFOlhNvqBBf3GVB/F9wTuWBF7Vb3
 VZOFVDq7FHFlu6oCIcbvj/Ch5onZCI2HDchbonpRlQ==
X-Google-Smtp-Source: AGHT+IHEXEs6W4AXjxuoKYQjCVLKZT2W2wWHYu1CdDPAEcdWvE1xqCLjKWjV6nh5DptR1lPJ0ow1x83MQQmpA/qo51Q=
X-Received: by 2002:a50:85c6:0:b0:54c:8104:cd20 with SMTP id
 q6-20020a5085c6000000b0054c8104cd20mr10617332edh.19.1702910185949; Mon, 18
 Dec 2023 06:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20231214211527.1946302-1-nabihestefan@google.com>
 <20231214211527.1946302-8-nabihestefan@google.com>
In-Reply-To: <20231214211527.1946302-8-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 14:36:14 +0000
Message-ID: <CAFEAcA86KEMq=BwA0mJefvRzAArNCzWSbj=vbmE3v_60Ze80tg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] include/hw/net: Implemented Classes and Masks
 for GMAC Descriptors
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
>  - Implemeted classes for GMAC Receive and Transmit Descriptors
>  - Implemented Masks for said descriptors
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>


>  static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
> -    [R_NPCM_GMAC_VERSION]         = 0x00001037,
> +    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
> +    [R_NPCM_GMAC_VERSION]         = 0x00001032,

This needs more description. What's going on here? Generally
workarounds for guest bugs are a bad idea, because once we put
them in we have pretty much no way of ever getting them out
of the codebase again. This goes doubly so if we don't record
exactly what the problem was that made us do the workaround...

Also, if you want to implement only v3.2, then do that from
the start, don't start with a patch that says "3.7" and then
change it in this patch.

>      [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
>      [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
>      [R_NPCM_GMAC_MAC0_ADDR_LO]    = 0xffffffff,
> @@ -125,12 +126,12 @@ static const uint16_t phy_reg_init[] = {
>      [MII_EXTSTAT]   = 0x3000, /* 1000BASTE_T full-duplex capable */
>  };
>
> -static void npcm_gmac_soft_reset(NPCMGMACState *s)
> +static void npcm_gmac_soft_reset(NPCMGMACState *gmac)
>  {
> -    memcpy(s->regs, npcm_gmac_cold_reset_values,
> +    memcpy(gmac->regs, npcm_gmac_cold_reset_values,
>             NPCM_GMAC_NR_REGS * sizeof(uint32_t));
>      /* Clear reset bits */
> -    s->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
> +    gmac->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
>  }

What is this churn from 's' to 'gmac' doing in this patch?
If you want 'gmac', that's fine, but this file is new in
this patch series, so just make it be the variable name you
want in the patch where you add this function, rather than
adding it with one name then changing it later in the series.

>  static void gmac_phy_set_link(NPCMGMACState *s, bool active)
> @@ -148,11 +149,53 @@ static bool gmac_can_receive(NetClientState *nc)
>      return true;
>  }
>
> -static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len1)

Similarly, why did the 'len1' argument here change to 'len',
and the "/* Placeholder */" comment appear only now? The effect
is it looks like this patch changed that function, but it didn't
in any interesting way.

That comment is not very helpful, by the way -- if, eg, the
idea is that the function gets filled in later in the patchseries,
then say so. If the function is a dummy one because of a missing
feature that won't be added in this patchset, then say that. Etc.

> +/*
> + * Function that updates the GMAC IRQ
> + * It find the logical OR of the enabled bits for NIS (if enabled)
> + * It find the logical OR of the enabled bits for AIS (if enabled)
> + */
> +static void gmac_update_irq(NPCMGMACState *gmac)
>  {
> -    return 0;
> +    /*
> +     * Check if the normal interrupts summery is enabled

It might be helpful to run a spellcheck on your comments.
This is "summary" (which you get right on the line below).

> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
> +        (NPCM_DMA_INTR_ENAB_NIE_BITS))
> +    {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=  NPCM_DMA_STATUS_NIS;
> +    }

Our coding style puts the opening brace on the same line as the if(),
not on a line of its own.

> +    /*
> +     * Check if the abnormal interrupts summery is enabled
> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] &
> +        (NPCM_DMA_INTR_ENAB_AIE_BITS))
> +    {
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
>  }
>
> +static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
> +{
> +    /* Placeholder */
> +    return 0;
> +}
>  static void gmac_cleanup(NetClientState *nc)
>  {
>      /* Nothing to do yet. */
> @@ -166,7 +209,7 @@ static void gmac_set_link(NetClientState *nc)
>      gmac_phy_set_link(s, !nc->link_down);
>  }
>
> -static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)
> +static void npcm_gmac_mdio_access(NPCMGMACState *gmac, uint16_t v)

More changes of variable names. Please clean all this up into
the right patches.

>  {
>      bool busy = v & NPCM_GMAC_MII_ADDR_BUSY;
>      uint8_t is_write;

> diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
> index a92a654278..e5729e83ea 100644
> --- a/include/hw/net/npcm_gmac.h
> +++ b/include/hw/net/npcm_gmac.h
> @@ -37,8 +37,6 @@ struct NPCMGMACRxDesc {
>  /* RDES2 and RDES3 are buffer address pointers */
>  /* Owner: 0 = software, 1 = gmac */
>  #define RX_DESC_RDES0_OWNER_MASK BIT(31)
> -/* Owner*/
> -#define RX_DESC_RDES0_OWNER_SHIFT 31

Why did this go away?

>  /* Destination Address Filter Fail */
>  #define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
>  /* Frame length*/
> diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
> index 77a83c4c58..130a1599a8 100644
> --- a/tests/qtest/npcm_gmac-test.c
> +++ b/tests/qtest/npcm_gmac-test.c
> @@ -154,7 +154,7 @@ static void test_init(gconstpointer test_data)
>      CHECK_REG32(NPCM_GMAC_MII_DATA, 0);
>      CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);
>      CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);
> -    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);
> +    CHECK_REG32(NPCM_GMAC_VERSION, 0x00001032);
>      CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);
>      CHECK_REG32(NPCM_GMAC_PMT, 0);
>      CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);
> --

thanks
-- PMM

