Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F2C7CD131
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 02:17:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsuFI-0003Aa-Tl; Tue, 17 Oct 2023 20:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuFG-0003AI-NO
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:17:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1qsuFD-0007D6-Bb
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 20:17:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40662119cd0so22985e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 17:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697588221; x=1698193021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mRJ7csEeKk5eLWCaS1oVk9KWBJYlKEYtc4v68G5w4qA=;
 b=OXHFYw8dL0AF0+zGCvNv8Hrdq/C1wOOejb3oGFqyIEkwMujkvYPMAGv7rCnWmCSTfv
 RohMwdy0fdO6EfZ323+aDHLDwE4cL8wOruj2Mi8sBMKph5o6DNryxw/EaKtm9ndWHcuJ
 PbbTww8NEEMBzNP2+i4cALcSWmjoqLVzCuiiSTXutHT4yRnXbZY94jynHIgecder0Jat
 MyVAqHJ6Lh3LKQ4dJsH+1V2mKpNeZ7mE43osZ+C+FpNE5uQNYJIlVN2YPaM90XBciyA+
 h90fDtpJ+Hf7f3bIJCXIx5B84juZVRrBghmSwCbky1DswjjQpEy0J0JlT8vU6Uj3OoIP
 T0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697588221; x=1698193021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mRJ7csEeKk5eLWCaS1oVk9KWBJYlKEYtc4v68G5w4qA=;
 b=VGkZywdoX/vruxNy+ZWI7g4W64TpUXzMAio1Pe+tP3zU28kijAHh5nDaFWhx4Utm8c
 PpM0FND9Tz1i1mdNHQhS2NVPYUwj80n/jgHM54b2b4oO1/muZ6sQ3bX5aRKwI7wZfu5t
 nanJuSA98KwpoJe73OridMeTZMLdeYr+HnQ0VMea89A3s4nfSO/9z8O/NLLs9fYb5J7o
 mBUAa4viNKI8681LpgpvanrzV3vkTgwNh673IcJIOvzS3D1mSu7eKYyyVIoS+n9JT/ce
 j901fjViuT2RHCSxOxH7h0fgFA5l543YQKZ6KfR4ADtHaoN1n07ugfND4d27HWa3c7Ys
 6efg==
X-Gm-Message-State: AOJu0YyOCwVrTVF56uk8cN+g3Asb7mdVxtk54XSACL8GzyQau/5BW8Ij
 KMXPgEM71Z+9ndI/vEiLY1bLGmCPb6uBI2QIN1PhRQ==
X-Google-Smtp-Source: AGHT+IG1iO52F9xf63iLOhUnnUSvpg3JUOUSU2rhWhZs3yYpeJA/uOuap4JaCmgGlH0Ru/wHESTobmCoZbOKLON9l98=
X-Received: by 2002:a1c:6a16:0:b0:3f7:3e85:36a with SMTP id
 f22-20020a1c6a16000000b003f73e85036amr35280wmc.7.1697588221491; Tue, 17 Oct
 2023 17:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231017230342.311227-1-nabihestefan@google.com>
 <20231017230342.311227-8-nabihestefan@google.com>
In-Reply-To: <20231017230342.311227-8-nabihestefan@google.com>
From: Hao Wu <wuhaotsh@google.com>
Date: Tue, 17 Oct 2023 17:16:49 -0700
Message-ID: <CAGcCb11E5s7d2uZfNwdR7JH86Ebgx=dceVOJ973s=5-W+A2G+A@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] include/hw/net: Implemented Classes and Masks
 for GMAC Descriptors
To: Nabih Estefan <nabihestefan@google.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 kfting@nuvoton.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: multipart/alternative; boundary="000000000000eb474f0607f28eb7"
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=wuhaotsh@google.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000eb474f0607f28eb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 4:04=E2=80=AFPM Nabih Estefan <nabihestefan@google.=
com>
wrote:

> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
>  - Implemeted classes for GMAC Receive and Transmit Descriptors
>  - Implemented Masks for said descriptors
>
> Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

> ---
>  hw/net/npcm_gmac.c           | 183 +++++++++++++++++++++++++++--------
>  hw/net/trace-events          |   9 ++
>  include/hw/net/npcm_gmac.h   |   2 -
>  tests/qtest/npcm_gmac-test.c |   2 +-
>  4 files changed, 150 insertions(+), 46 deletions(-)
>
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 5ce632858d..6f8109e0ee 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -32,7 +32,7 @@
>  REG32(NPCM_DMA_BUS_MODE, 0x1000)
>  REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)
>  REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)
> -REG32(NPCM_DMA_RCV_BASE_ADDR, 0x100c)
> +REG32(NPCM_DMA_RX_BASE_ADDR, 0x100c)
>  REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)
>  REG32(NPCM_DMA_STATUS, 0x1014)
>  REG32(NPCM_DMA_CONTROL, 0x1018)
> @@ -91,7 +91,8 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
>  #define NPCM_DMA_BUS_MODE_SWR               BIT(0)
>
>  static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] =3D=
 {
> -    [R_NPCM_GMAC_VERSION]         =3D 0x00001037,
> +    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
> +    [R_NPCM_GMAC_VERSION]         =3D 0x00001032,
>      [R_NPCM_GMAC_TIMER_CTRL]      =3D 0x03e80000,
>      [R_NPCM_GMAC_MAC0_ADDR_HI]    =3D 0x8000ffff,
>      [R_NPCM_GMAC_MAC0_ADDR_LO]    =3D 0xffffffff,
> @@ -125,12 +126,12 @@ static const uint16_t phy_reg_init[] =3D {
>      [MII_EXTSTAT]   =3D 0x3000, /* 1000BASTE_T full-duplex capable */
>  };
>
> -static void npcm_gmac_soft_reset(NPCMGMACState *s)
> +static void npcm_gmac_soft_reset(NPCMGMACState *gmac)
>  {
> -    memcpy(s->regs, npcm_gmac_cold_reset_values,
> +    memcpy(gmac->regs, npcm_gmac_cold_reset_values,
>             NPCM_GMAC_NR_REGS * sizeof(uint32_t));
>      /* Clear reset bits */
> -    s->regs[R_NPCM_DMA_BUS_MODE] &=3D ~NPCM_DMA_BUS_MODE_SWR;
> +    gmac->regs[R_NPCM_DMA_BUS_MODE] &=3D ~NPCM_DMA_BUS_MODE_SWR;
>  }
>
>  static void gmac_phy_set_link(NPCMGMACState *s, bool active)
> @@ -148,11 +149,53 @@ static bool gmac_can_receive(NetClientState *nc)
>      return true;
>  }
>
> -static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf,
> size_t len1)
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
> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] =
&
> +        (NPCM_DMA_INTR_ENAB_NIE_BITS))
> +    {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=3D  NPCM_DMA_STATUS_NIS;
> +    }
> +    /*
> +     * Check if the abnormal interrupts summery is enabled
> +     * if so, add the bits for the summary that are enabled
> +     */
> +    if (gmac->regs[R_NPCM_DMA_INTR_ENA] & gmac->regs[R_NPCM_DMA_STATUS] =
&
> +        (NPCM_DMA_INTR_ENAB_AIE_BITS))
> +    {
> +        gmac->regs[R_NPCM_DMA_STATUS] |=3D  NPCM_DMA_STATUS_AIS;
> +    }
> +
> +    /* Get the logical OR of both normal and abnormal interrupts */
> +    int level =3D !!((gmac->regs[R_NPCM_DMA_STATUS] &
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
> +static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf,
> size_t len)
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
>  {
>      bool busy =3D v & NPCM_GMAC_MII_ADDR_BUSY;
>      uint8_t is_write;
> @@ -183,33 +226,38 @@ static void npcm_gmac_mdio_access(NPCMGMACState *s,
> uint16_t v)
>
>
>          if (v & NPCM_GMAC_MII_ADDR_WRITE) {
> -            data =3D s->regs[R_NPCM_GMAC_MII_DATA];
> +            data =3D gmac->regs[R_NPCM_GMAC_MII_DATA];
>              /* Clear reset bit for BMCR register */
>              switch (gr) {
>              case MII_BMCR:
>                  data &=3D ~MII_BMCR_RESET;
> -                /* Complete auto-negotiation immediately and set as
> complete */
> -                if (data & MII_BMCR_AUTOEN) {
> +                /* Autonegotiation is a W1C bit*/
> +                if (data & MII_BMCR_ANRESTART) {
>                      /* Tells autonegotiation to not restart again */
>                      data &=3D ~MII_BMCR_ANRESTART;
> +                }
> +                if ((data & MII_BMCR_AUTOEN) &&
> +                    !(gmac->phy_regs[pa][MII_BMSR] & MII_BMSR_AN_COMP)) =
{
>                      /* sets autonegotiation as complete */
> -                    s->phy_regs[pa][MII_BMSR] |=3D MII_BMSR_AN_COMP;
> +                    gmac->phy_regs[pa][MII_BMSR] |=3D MII_BMSR_AN_COMP;
> +                    /* Resolve AN automatically->need to set this */
> +                    gmac->phy_regs[0][MII_ANLPAR] =3D 0x0000;
>                  }
>              }
> -            s->phy_regs[pa][gr] =3D data;
> +            gmac->phy_regs[pa][gr] =3D data;
>          } else {
> -            data =3D s->phy_regs[pa][gr];
> -            s->regs[R_NPCM_GMAC_MII_DATA] =3D data;
> +            data =3D gmac->phy_regs[pa][gr];
> +            gmac->regs[R_NPCM_GMAC_MII_DATA] =3D data;
>          }
> -        trace_npcm_gmac_mdio_access(DEVICE(s)->canonical_path, is_write,
> pa,
> -                                    gr, data);
> +        trace_npcm_gmac_mdio_access(DEVICE(gmac)->canonical_path,
> is_write, pa,
> +                                        gr, data);
>      }
> -    s->regs[R_NPCM_GMAC_MII_ADDR] =3D v & ~NPCM_GMAC_MII_ADDR_BUSY;
> +    gmac->regs[R_NPCM_GMAC_MII_ADDR] =3D v & ~NPCM_GMAC_MII_ADDR_BUSY;
>  }
>
>  static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned siz=
e)
>  {
> -    NPCMGMACState *s =3D opaque;
> +    NPCMGMACState *gmac =3D opaque;
>      uint32_t v =3D 0;
>
>      switch (offset) {
> @@ -218,22 +266,25 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr
> offset, unsigned size)
>      case A_NPCM_DMA_RCV_POLL_DEMAND:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Read of write-only reg: offset: 0x%04"
> HWADDR_PRIx
> -                      "\n", DEVICE(s)->canonical_path, offset);
> +                      "\n", DEVICE(gmac)->canonical_path, offset);
>          break;
>
>      default:
> -        v =3D s->regs[offset / sizeof(uint32_t)];
> +        v =3D gmac->regs[offset / sizeof(uint32_t)];
>      }
> -    trace_npcm_gmac_reg_read(DEVICE(s)->canonical_path, offset, v);
> +
> +    trace_npcm_gmac_reg_read(DEVICE(gmac)->canonical_path, offset, v);
>      return v;
>  }
>
>  static void npcm_gmac_write(void *opaque, hwaddr offset,
>                                uint64_t v, unsigned size)
>  {
> -    NPCMGMACState *s =3D opaque;
> +    NPCMGMACState *gmac =3D opaque;
> +    uint32_t prev;
> +
> +    trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
>
> -    trace_npcm_gmac_reg_write(DEVICE(s)->canonical_path, offset, v);
>      switch (offset) {
>      /* Read only registers */
>      case A_NPCM_GMAC_VERSION:
> @@ -250,25 +301,44 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Write of read-only reg: offset: 0x%04"
> HWADDR_PRIx
>                        ", value: 0x%04" PRIx64 "\n",
> -                      DEVICE(s)->canonical_path, offset, v);
> +                      DEVICE(gmac)->canonical_path, offset, v);
> +        break;
> +
> +    case A_NPCM_GMAC_MAC_CONFIG:
> +        prev =3D gmac->regs[offset / sizeof(uint32_t)];
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
> +
> +        /* If transmit is being enabled for first time, update desc addr
> */
> +        if (~(prev & NPCM_GMAC_MAC_CONFIG_TX_EN) &
> +             (v & NPCM_GMAC_MAC_CONFIG_TX_EN)) {
> +            gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =3D
> +                gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
> +        }
> +
> +        /* If receive is being enabled for first time, update desc addr =
*/
> +        if (~(prev & NPCM_GMAC_MAC_CONFIG_RX_EN) &
> +             (v & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
> +            gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =3D
> +                gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
> +        }
>          break;
>
>      case A_NPCM_GMAC_MII_ADDR:
> -        npcm_gmac_mdio_access(s, v);
> +        npcm_gmac_mdio_access(gmac, v);
>          break;
>
>      case A_NPCM_GMAC_MAC0_ADDR_HI:
> -        s->regs[offset / sizeof(uint32_t)] =3D v;
> -        s->conf.macaddr.a[0] =3D v >> 8;
> -        s->conf.macaddr.a[1] =3D v >> 0;
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
> +        gmac->conf.macaddr.a[0] =3D v >> 8;
> +        gmac->conf.macaddr.a[1] =3D v >> 0;
>          break;
>
>      case A_NPCM_GMAC_MAC0_ADDR_LO:
> -        s->regs[offset / sizeof(uint32_t)] =3D v;
> -        s->conf.macaddr.a[2] =3D v >> 24;
> -        s->conf.macaddr.a[3] =3D v >> 16;
> -        s->conf.macaddr.a[4] =3D v >> 8;
> -        s->conf.macaddr.a[5] =3D v >> 0;
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
> +        gmac->conf.macaddr.a[2] =3D v >> 24;
> +        gmac->conf.macaddr.a[3] =3D v >> 16;
> +        gmac->conf.macaddr.a[4] =3D v >> 8;
> +        gmac->conf.macaddr.a[5] =3D v >> 0;
>          break;
>
>      case A_NPCM_GMAC_MAC1_ADDR_HI:
> @@ -277,33 +347,60 @@ static void npcm_gmac_write(void *opaque, hwaddr
> offset,
>      case A_NPCM_GMAC_MAC2_ADDR_LO:
>      case A_NPCM_GMAC_MAC3_ADDR_HI:
>      case A_NPCM_GMAC_MAC3_ADDR_LO:
> -        s->regs[offset / sizeof(uint32_t)] =3D v;
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: Only MAC Address 0 is supported. This request=
 "
> -                      "is ignored.\n", DEVICE(s)->canonical_path);
> +                      "is ignored.\n", DEVICE(gmac)->canonical_path);
>          break;
>
>      case A_NPCM_DMA_BUS_MODE:
> -        s->regs[offset / sizeof(uint32_t)] =3D v;
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
>          if (v & NPCM_DMA_BUS_MODE_SWR) {
> -            npcm_gmac_soft_reset(s);
> +            npcm_gmac_soft_reset(gmac);
> +        }
> +        break;
> +
> +    case A_NPCM_DMA_RCV_POLL_DEMAND:
> +        /* We dont actually care about the value */
> +        break;
> +
> +    case A_NPCM_DMA_STATUS:
> +        /* Check that RO bits are not written to */
> +        if (NPCM_DMA_STATUS_RO_MASK(v)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Write of read-only bits of reg: offset:
> 0x%04"
> +                           HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
> +                           DEVICE(gmac)->canonical_path, offset, v);
> +        } else {
> +            /* for W1c bits, implement W1C */
> +            gmac->regs[offset / sizeof(uint32_t)] &=3D
> +                ~NPCM_DMA_STATUS_W1C_MASK(v);
> +            if (v & NPCM_DMA_STATUS_NIS_BITS) {
> +                gmac->regs[offset / sizeof(uint32_t)] &=3D
> ~NPCM_DMA_STATUS_NIS;
> +            }
> +            if (v & NPCM_DMA_STATUS_AIS_BITS) {
> +                gmac->regs[offset / sizeof(uint32_t)] &=3D
> ~NPCM_DMA_STATUS_AIS;
> +            }
>          }
>          break;
>
>      default:
> -        s->regs[offset / sizeof(uint32_t)] =3D v;
> +        gmac->regs[offset / sizeof(uint32_t)] =3D v;
>          break;
>      }
> +
> +    gmac_update_irq(gmac);
>  }
>
>  static void npcm_gmac_reset(DeviceState *dev)
>  {
> -    NPCMGMACState *s =3D NPCM_GMAC(dev);
> +    NPCMGMACState *gmac =3D NPCM_GMAC(dev);
>
> -    npcm_gmac_soft_reset(s);
> -    memcpy(s->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
> +    npcm_gmac_soft_reset(gmac);
> +    memcpy(gmac->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
>
> -    trace_npcm_gmac_reset(DEVICE(s)->canonical_path,
> s->phy_regs[0][MII_BMSR]);
> +    trace_npcm_gmac_reset(DEVICE(gmac)->canonical_path,
> +                          gmac->phy_regs[0][MII_BMSR]);
>  }
>
>  static NetClientInfo net_npcm_gmac_info =3D {
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 1dbb5d2d64..2843f1eaf8 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -472,6 +472,15 @@ npcm_gmac_reg_write(const char *name, uint64_t
> offset, uint32_t value) "%s: offs
>  npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa,
> uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %"
> PRIu8 " val: 0x%04" PRIx16
>  npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]:
> 0x%04" PRIx16
>  npcm_gmac_set_link(bool active) "Set link: active=3D%u"
> +npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en=
,
> int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04"
> PRIX32 " IRQ Set: %d"
> +npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) "%s:
> attempting to read descriptor @0x%04" PRIX32
> +npcm_gmac_packet_receive(const char* name, uint32_t len) "%s: RX packet
> length: 0x%04" PRIX32
> +npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len,
> uint32_t rx_buf_addr) "%s: Receiving into Buffer size: 0x%04" PRIX32 " at
> address 0x%04" PRIX32
> +npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception
> finished, packet left: 0x%04" PRIX32
> +npcm_gmac_packet_transmit(const char* name, uint16_t len) "%s: TX
> transmission start, packed length 0x%04" PRIX16
> +npcm_gmac_packet_sent(const char* name, uint16_t len) "%s: TX packet
> sent!, length: 0x%04" PRIX16
> +npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0,
> uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0=
:
> 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 =
"
> Descriptor 3: 0x%04" PRIX32
> +npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t
> tdes1) "%s: Tdes0: 0x%04" PRIX32 " Tdes1: 0x%04" PRIX32
>
>  # npcm_pcs.c
>  npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes,
> uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04"
> PRIx64 " value: 0x%04" PRIx16
> diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
> index a92a654278..e5729e83ea 100644
> --- a/include/hw/net/npcm_gmac.h
> +++ b/include/hw/net/npcm_gmac.h
> @@ -37,8 +37,6 @@ struct NPCMGMACRxDesc {
>  /* RDES2 and RDES3 are buffer address pointers */
>  /* Owner: 0 =3D software, 1 =3D gmac */
>  #define RX_DESC_RDES0_OWNER_MASK BIT(31)
> -/* Owner*/
> -#define RX_DESC_RDES0_OWNER_SHIFT 31
>  /* Destination Address Filter Fail */
>  #define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
>  /* Frame length*/
> diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
> index 30d27e8dcc..84511fd915 100644
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
> 2.42.0.655.g421f12c284-goog
>
>

--000000000000eb474f0607f28eb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 17, 2023 at 4:04=E2=80=AF=
PM Nabih Estefan &lt;<a href=3D"mailto:nabihestefan@google.com">nabihestefa=
n@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: Nabih Estefan Diaz &lt;<a href=3D"mailto:nabihestefan@goo=
gle.com" target=3D"_blank">nabihestefan@google.com</a>&gt;<br>
<br>
=C2=A0- Implemeted classes for GMAC Receive and Transmit Descriptors<br>
=C2=A0- Implemented Masks for said descriptors<br>
<br>
Signed-off-by: Nabih Estefan Diaz &lt;<a href=3D"mailto:nabihestefan@google=
.com" target=3D"_blank">nabihestefan@google.com</a>&gt;<br></blockquote><di=
v>Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuhaotsh@g=
oogle.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
---<br>
=C2=A0hw/net/npcm_gmac.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 183 ++++=
+++++++++++++++++++++++--------<br>
=C2=A0hw/net/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09=
 ++<br>
=C2=A0include/hw/net/npcm_gmac.h=C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A0tests/qtest/npcm_gmac-test.c |=C2=A0 =C2=A02 +-<br>
=C2=A04 files changed, 150 insertions(+), 46 deletions(-)<br>
<br>
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c<br>
index 5ce632858d..6f8109e0ee 100644<br>
--- a/hw/net/npcm_gmac.c<br>
+++ b/hw/net/npcm_gmac.c<br>
@@ -32,7 +32,7 @@<br>
=C2=A0REG32(NPCM_DMA_BUS_MODE, 0x1000)<br>
=C2=A0REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)<br>
=C2=A0REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)<br>
-REG32(NPCM_DMA_RCV_BASE_ADDR, 0x100c)<br>
+REG32(NPCM_DMA_RX_BASE_ADDR, 0x100c)<br>
=C2=A0REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)<br>
=C2=A0REG32(NPCM_DMA_STATUS, 0x1014)<br>
=C2=A0REG32(NPCM_DMA_CONTROL, 0x1018)<br>
@@ -91,7 +91,8 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)<br>
=C2=A0#define NPCM_DMA_BUS_MODE_SWR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0BIT(0)<br>
<br>
=C2=A0static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] =
=3D {<br>
-=C2=A0 =C2=A0 [R_NPCM_GMAC_VERSION]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x00001037,<br>
+=C2=A0 =C2=A0 /* Reduce version to 3.2 so that the kernel can enable inter=
rupt. */<br>
+=C2=A0 =C2=A0 [R_NPCM_GMAC_VERSION]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0=
x00001032,<br>
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_TIMER_CTRL]=C2=A0 =C2=A0 =C2=A0 =3D 0x03e8=
0000,<br>
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_MAC0_ADDR_HI]=C2=A0 =C2=A0 =3D 0x8000ffff,=
<br>
=C2=A0 =C2=A0 =C2=A0[R_NPCM_GMAC_MAC0_ADDR_LO]=C2=A0 =C2=A0 =3D 0xffffffff,=
<br>
@@ -125,12 +126,12 @@ static const uint16_t phy_reg_init[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[MII_EXTSTAT]=C2=A0 =C2=A0=3D 0x3000, /* 1000BASTE_T fu=
ll-duplex capable */<br>
=C2=A0};<br>
<br>
-static void npcm_gmac_soft_reset(NPCMGMACState *s)<br>
+static void npcm_gmac_soft_reset(NPCMGMACState *gmac)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 memcpy(s-&gt;regs, npcm_gmac_cold_reset_values,<br>
+=C2=A0 =C2=A0 memcpy(gmac-&gt;regs, npcm_gmac_cold_reset_values,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM_GMAC_NR_REGS * sizeof(uint32=
_t));<br>
=C2=A0 =C2=A0 =C2=A0/* Clear reset bits */<br>
-=C2=A0 =C2=A0 s-&gt;regs[R_NPCM_DMA_BUS_MODE] &amp;=3D ~NPCM_DMA_BUS_MODE_=
SWR;<br>
+=C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_BUS_MODE] &amp;=3D ~NPCM_DMA_BUS_MO=
DE_SWR;<br>
=C2=A0}<br>
<br>
=C2=A0static void gmac_phy_set_link(NPCMGMACState *s, bool active)<br>
@@ -148,11 +149,53 @@ static bool gmac_can_receive(NetClientState *nc)<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t=
 len1)<br>
+/*<br>
+ * Function that updates the GMAC IRQ<br>
+ * It find the logical OR of the enabled bits for NIS (if enabled)<br>
+ * It find the logical OR of the enabled bits for AIS (if enabled)<br>
+ */<br>
+static void gmac_update_irq(NPCMGMACState *gmac)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Check if the normal interrupts summery is enabled<br=
>
+=C2=A0 =C2=A0 =C2=A0* if so, add the bits for the summary that are enabled=
<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (gmac-&gt;regs[R_NPCM_DMA_INTR_ENA] &amp; gmac-&gt;regs[R=
_NPCM_DMA_STATUS] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (NPCM_DMA_INTR_ENAB_NIE_BITS))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] |=3D=C2=A0 NP=
CM_DMA_STATUS_NIS;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Check if the abnormal interrupts summery is enabled<=
br>
+=C2=A0 =C2=A0 =C2=A0* if so, add the bits for the summary that are enabled=
<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (gmac-&gt;regs[R_NPCM_DMA_INTR_ENA] &amp; gmac-&gt;regs[R=
_NPCM_DMA_STATUS] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (NPCM_DMA_INTR_ENAB_AIE_BITS))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_STATUS] |=3D=C2=A0 NP=
CM_DMA_STATUS_AIS;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Get the logical OR of both normal and abnormal interrupts=
 */<br>
+=C2=A0 =C2=A0 int level =3D !!((gmac-&gt;regs[R_NPCM_DMA_STATUS] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac=
-&gt;regs[R_NPCM_DMA_INTR_ENA] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NPCM=
_DMA_STATUS_NIS) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(gmac=
-&gt;regs[R_NPCM_DMA_STATUS] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmac-=
&gt;regs[R_NPCM_DMA_INTR_ENA] &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NPCM_=
DMA_STATUS_AIS));<br>
+<br>
+=C2=A0 =C2=A0 /* Set the IRQ */<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_update_irq(DEVICE(gmac)-&gt;canonical_path,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmac-&gt;regs[R_NPCM_DMA_STATUS],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gmac-&gt;regs[R_NPCM_DMA_INTR_ENA],<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0level);<br>
+=C2=A0 =C2=A0 qemu_set_irq(gmac-&gt;irq, level);<br>
=C2=A0}<br>
<br>
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t=
 len)<br>
+{<br>
+=C2=A0 =C2=A0 /* Placeholder */<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
=C2=A0static void gmac_cleanup(NetClientState *nc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Nothing to do yet. */<br>
@@ -166,7 +209,7 @@ static void gmac_set_link(NetClientState *nc)<br>
=C2=A0 =C2=A0 =C2=A0gmac_phy_set_link(s, !nc-&gt;link_down);<br>
=C2=A0}<br>
<br>
-static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)<br>
+static void npcm_gmac_mdio_access(NPCMGMACState *gmac, uint16_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0bool busy =3D v &amp; NPCM_GMAC_MII_ADDR_BUSY;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t is_write;<br>
@@ -183,33 +226,38 @@ static void npcm_gmac_mdio_access(NPCMGMACState *s, u=
int16_t v)<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (v &amp; NPCM_GMAC_MII_ADDR_WRITE) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D s-&gt;regs[R_NPCM_GMAC_=
MII_DATA];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D gmac-&gt;regs[R_NPCM_GM=
AC_MII_DATA];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Clear reset bit for BMCR=
 register */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (gr) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case MII_BMCR:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data &amp;=3D=
 ~MII_BMCR_RESET;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Complete auto-n=
egotiation immediately and set as complete */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data &amp; MII=
_BMCR_AUTOEN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Autonegotiation=
 is a W1C bit*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data &amp; MII=
_BMCR_ANRESTART) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Tells autonegotiation to not restart again */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0data &amp;=3D ~MII_BMCR_ANRESTART;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((data &amp; MI=
I_BMCR_AUTOEN) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(gm=
ac-&gt;phy_regs[pa][MII_BMSR] &amp; MII_BMSR_AN_COMP)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* sets autonegotiation as complete */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&g=
t;phy_regs[pa][MII_BMSR] |=3D MII_BMSR_AN_COMP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac=
-&gt;phy_regs[pa][MII_BMSR] |=3D MII_BMSR_AN_COMP;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* R=
esolve AN automatically-&gt;need to set this */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac=
-&gt;phy_regs[0][MII_ANLPAR] =3D 0x0000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;phy_regs[pa][gr] =3D data;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;phy_regs[pa][gr] =3D da=
ta;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D s-&gt;phy_regs[pa][gr];=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_NPCM_GMAC_MII_DATA]=
 =3D data;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D gmac-&gt;phy_regs[pa][g=
r];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_GMAC_MII_DA=
TA] =3D data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_mdio_access(DEVICE(s)-&gt;cano=
nical_path, is_write, pa,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gr, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_npcm_gmac_mdio_access(DEVICE(gmac)-&gt;c=
anonical_path, is_write, pa,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gr, data=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 s-&gt;regs[R_NPCM_GMAC_MII_ADDR] =3D v &amp; ~NPCM_GMAC_MII_=
ADDR_BUSY;<br>
+=C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_GMAC_MII_ADDR] =3D v &amp; ~NPCM_GMAC_M=
II_ADDR_BUSY;<br>
=C2=A0}<br>
<br>
=C2=A0static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned =
size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 NPCMGMACState *s =3D opaque;<br>
+=C2=A0 =C2=A0 NPCMGMACState *gmac =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t v =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>
@@ -218,22 +266,25 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr o=
ffset, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_DMA_RCV_POLL_DEMAND:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: Read of write-only reg: offset: 0x%04&quot; HWADDR_PRIx=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;\n&quot;, DEVICE(s)-&gt;canonical_path, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;\n&quot;, DEVICE(gmac)-&gt;canonical_path, offset);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D s-&gt;regs[offset / sizeof(uint32_t)];<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D gmac-&gt;regs[offset / sizeof(uint32_t)]=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 trace_npcm_gmac_reg_read(DEVICE(s)-&gt;canonical_path, offse=
t, v);<br>
+<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_reg_read(DEVICE(gmac)-&gt;canonical_path, of=
fset, v);<br>
=C2=A0 =C2=A0 =C2=A0return v;<br>
=C2=A0}<br>
<br>
=C2=A0static void npcm_gmac_write(void *opaque, hwaddr offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t v, unsigned size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 NPCMGMACState *s =3D opaque;<br>
+=C2=A0 =C2=A0 NPCMGMACState *gmac =3D opaque;<br>
+=C2=A0 =C2=A0 uint32_t prev;<br>
+<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_reg_write(DEVICE(gmac)-&gt;canonical_path, o=
ffset, v);<br>
<br>
-=C2=A0 =C2=A0 trace_npcm_gmac_reg_write(DEVICE(s)-&gt;canonical_path, offs=
et, v);<br>
=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>
=C2=A0 =C2=A0 =C2=A0/* Read only registers */<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_VERSION:<br>
@@ -250,25 +301,44 @@ static void npcm_gmac_write(void *opaque, hwaddr offs=
et,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: Write of read-only reg: offset: 0x%04&quot; HWADDR_PRIx=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;, value: 0x%04&quot; PRIx64 &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DEVICE(s)-&gt;canonical_path, offset, v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 DEVICE(gmac)-&gt;canonical_path, offset, v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case A_NPCM_GMAC_MAC_CONFIG:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev =3D gmac-&gt;regs[offset / sizeof(uint32_=
t)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If transmit is being enabled for first time=
, update desc addr */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (~(prev &amp; NPCM_GMAC_MAC_CONFIG_TX_EN) &=
amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(v &amp; NPCM_GMAC_MAC_CON=
FIG_TX_EN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_TX=
_DESC] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NP=
CM_DMA_TX_BASE_ADDR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If receive is being enabled for first time,=
 update desc addr */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (~(prev &amp; NPCM_GMAC_MAC_CONFIG_RX_EN) &=
amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(v &amp; NPCM_GMAC_MAC_CON=
FIG_RX_EN)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NPCM_DMA_HOST_RX=
_DESC] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[R_NP=
CM_DMA_RX_BASE_ADDR];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MII_ADDR:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm_gmac_mdio_access(s, v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm_gmac_mdio_access(gmac, v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC0_ADDR_HI:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[offset / sizeof(uint32_t)] =3D v;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[0] =3D v &gt;&gt; 8;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[1] =3D v &gt;&gt; 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[0] =3D v &gt;&gt; 8;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[1] =3D v &gt;&gt; 0;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC0_ADDR_LO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[offset / sizeof(uint32_t)] =3D v;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[2] =3D v &gt;&gt; 24;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[3] =3D v &gt;&gt; 16;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[4] =3D v &gt;&gt; 8;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;conf.macaddr.a[5] =3D v &gt;&gt; 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[2] =3D v &gt;&gt; 24;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[3] =3D v &gt;&gt; 16;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[4] =3D v &gt;&gt; 8;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;conf.macaddr.a[5] =3D v &gt;&gt; 0;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC1_ADDR_HI:<br>
@@ -277,33 +347,60 @@ static void npcm_gmac_write(void *opaque, hwaddr offs=
et,<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC2_ADDR_LO:<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC3_ADDR_HI:<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_GMAC_MAC3_ADDR_LO:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[offset / sizeof(uint32_t)] =3D v;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;%s: Only MAC Address 0 is supported. This request &quot;<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;is ignored.\n&quot;, DEVICE(s)-&gt;canonical_path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot;is ignored.\n&quot;, DEVICE(gmac)-&gt;canonical_path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case A_NPCM_DMA_BUS_MODE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[offset / sizeof(uint32_t)] =3D v;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (v &amp; NPCM_DMA_BUS_MODE_SWR) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm_gmac_soft_reset(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm_gmac_soft_reset(gmac);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case A_NPCM_DMA_RCV_POLL_DEMAND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We dont actually care about the value */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 case A_NPCM_DMA_STATUS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check that RO bits are not written to */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (NPCM_DMA_STATUS_RO_MASK(v)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;%s: Write of read-only bits of reg: offset: 0x%04&q=
uot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0HWADDR_PRIx &quot;, value: 0x%04&quot; PRIx64 &quot=
;\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0DEVICE(gmac)-&gt;canonical_path, offset, v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for W1c bits, implement W1C *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(ui=
nt32_t)] &amp;=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~NPCM_DMA_STATUS_W=
1C_MASK(v);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_STATUS_NIS_=
BITS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offs=
et / sizeof(uint32_t)] &amp;=3D ~NPCM_DMA_STATUS_NIS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (v &amp; NPCM_DMA_STATUS_AIS_=
BITS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offs=
et / sizeof(uint32_t)] &amp;=3D ~NPCM_DMA_STATUS_AIS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[offset / sizeof(uint32_t)] =3D v;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gmac-&gt;regs[offset / sizeof(uint32_t)] =3D v=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 gmac_update_irq(gmac);<br>
=C2=A0}<br>
<br>
=C2=A0static void npcm_gmac_reset(DeviceState *dev)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 NPCMGMACState *s =3D NPCM_GMAC(dev);<br>
+=C2=A0 =C2=A0 NPCMGMACState *gmac =3D NPCM_GMAC(dev);<br>
<br>
-=C2=A0 =C2=A0 npcm_gmac_soft_reset(s);<br>
-=C2=A0 =C2=A0 memcpy(s-&gt;phy_regs[0], phy_reg_init, sizeof(phy_reg_init)=
);<br>
+=C2=A0 =C2=A0 npcm_gmac_soft_reset(gmac);<br>
+=C2=A0 =C2=A0 memcpy(gmac-&gt;phy_regs[0], phy_reg_init, sizeof(phy_reg_in=
it));<br>
<br>
-=C2=A0 =C2=A0 trace_npcm_gmac_reset(DEVICE(s)-&gt;canonical_path, s-&gt;ph=
y_regs[0][MII_BMSR]);<br>
+=C2=A0 =C2=A0 trace_npcm_gmac_reset(DEVICE(gmac)-&gt;canonical_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 gmac-&gt;phy_regs[0][MII_BMSR]);<br>
=C2=A0}<br>
<br>
=C2=A0static NetClientInfo net_npcm_gmac_info =3D {<br>
diff --git a/hw/net/trace-events b/hw/net/trace-events<br>
index 1dbb5d2d64..2843f1eaf8 100644<br>
--- a/hw/net/trace-events<br>
+++ b/hw/net/trace-events<br>
@@ -472,6 +472,15 @@ npcm_gmac_reg_write(const char *name, uint64_t offset,=
 uint32_t value) &quot;%s: offs<br>
=C2=A0npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa,=
 uint8_t gr, uint16_t val) &quot;%s: is_write: %&quot; PRIu8 &quot; pa: %&q=
uot; PRIu8 &quot; gr: %&quot; PRIu8 &quot; val: 0x%04&quot; PRIx16<br>
=C2=A0npcm_gmac_reset(const char *name, uint16_t value) &quot;%s: phy_regs[=
0][1]: 0x%04&quot; PRIx16<br>
=C2=A0npcm_gmac_set_link(bool active) &quot;Set link: active=3D%u&quot;<br>
+npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, =
int level) &quot;%s: Status Reg: 0x%04&quot; PRIX32 &quot; Interrupt Enable=
 Reg: 0x%04&quot; PRIX32 &quot; IRQ Set: %d&quot;<br>
+npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) &quot;%s:=
 attempting to read descriptor @0x%04&quot; PRIX32<br>
+npcm_gmac_packet_receive(const char* name, uint32_t len) &quot;%s: RX pack=
et length: 0x%04&quot; PRIX32<br>
+npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len, uint=
32_t rx_buf_addr) &quot;%s: Receiving into Buffer size: 0x%04&quot; PRIX32 =
&quot; at address 0x%04&quot; PRIX32<br>
+npcm_gmac_packet_received(const char* name, uint32_t len) &quot;%s: Recept=
ion finished, packet left: 0x%04&quot; PRIX32<br>
+npcm_gmac_packet_transmit(const char* name, uint16_t len) &quot;%s: TX tra=
nsmission start, packed length 0x%04&quot; PRIX16<br>
+npcm_gmac_packet_sent(const char* name, uint16_t len) &quot;%s: TX packet =
sent!, length: 0x%04&quot; PRIX16<br>
+npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uin=
t32_t des1, uint32_t des2, uint32_t des3)&quot;%s: Address: %p Descriptor 0=
: 0x%04&quot; PRIX32 &quot; Descriptor 1: 0x%04&quot; PRIX32 &quot;Descript=
or 2: 0x%04&quot; PRIX32 &quot; Descriptor 3: 0x%04&quot; PRIX32<br>
+npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t t=
des1) &quot;%s: Tdes0: 0x%04&quot; PRIX32 &quot; Tdes1: 0x%04&quot; PRIX32<=
br>
<br>
=C2=A0# npcm_pcs.c<br>
=C2=A0npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, ui=
nt64_t offset, uint16_t value) &quot;%s: IND: 0x%02&quot; PRIx16 &quot; off=
set: 0x%04&quot; PRIx64 &quot; value: 0x%04&quot; PRIx16<br>
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h<br>
index a92a654278..e5729e83ea 100644<br>
--- a/include/hw/net/npcm_gmac.h<br>
+++ b/include/hw/net/npcm_gmac.h<br>
@@ -37,8 +37,6 @@ struct NPCMGMACRxDesc {<br>
=C2=A0/* RDES2 and RDES3 are buffer address pointers */<br>
=C2=A0/* Owner: 0 =3D software, 1 =3D gmac */<br>
=C2=A0#define RX_DESC_RDES0_OWNER_MASK BIT(31)<br>
-/* Owner*/<br>
-#define RX_DESC_RDES0_OWNER_SHIFT 31<br>
=C2=A0/* Destination Address Filter Fail */<br>
=C2=A0#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)<br>
=C2=A0/* Frame length*/<br>
diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c<br=
>
index 30d27e8dcc..84511fd915 100644<br>
--- a/tests/qtest/npcm_gmac-test.c<br>
+++ b/tests/qtest/npcm_gmac-test.c<br>
@@ -154,7 +154,7 @@ static void test_init(gconstpointer test_data)<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_MII_DATA, 0);<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_FLOW_CTRL, 0);<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_VLAN_FLAG, 0);<br>
-=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_VERSION, 0x00001037);<br>
+=C2=A0 =C2=A0 CHECK_REG32(NPCM_GMAC_VERSION, 0x00001032);<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_WAKEUP_FILTER, 0);<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_PMT, 0);<br>
=C2=A0 =C2=A0 =C2=A0CHECK_REG32(NPCM_GMAC_LPI_CTRL, 0);<br>
-- <br>
2.42.0.655.g421f12c284-goog<br>
<br>
</blockquote></div></div>

--000000000000eb474f0607f28eb7--

