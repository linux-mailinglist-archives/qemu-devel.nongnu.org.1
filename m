Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABC7C819C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrED1-00060d-21; Fri, 13 Oct 2023 05:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrECt-0005xv-UA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:11:45 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrECr-0005QM-86
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:11:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso1295847a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697188299; x=1697793099;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KCuLeT7zSl6MJg/g0ThaCPtucbTdymw1irw24OM5YK0=;
 b=bxrXIUX1S+w+9JWrekm3ews0l7SgV9mPpjFUghDULyaoAFGP63p++6p9sGeNEMg6Aw
 OTbcUV2OBOz2WvitLF7GgcFfLRwC2pXnMJHgct3m0k/yXgMAQRzMrwAMeoawQQvVWeWj
 If0Fe3CvJyPAwMBnSqrWQlvOUflgSATrp/vgcNUATOHFRlFGySaSleKYaGCoJOTtUMc3
 zpWVwL7VSfccFtqC5Oqvvlg9qzNCYOb+ggIcTzq7EKVCfgb3Difu4rzvdM6MV5Nq+vDa
 zhfFoS3DFe62iWhHOJKowwvc9kAWuwiG5n72yi76ahklWVb/dgZQVdpQSHyLXnu5IImO
 2KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697188299; x=1697793099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KCuLeT7zSl6MJg/g0ThaCPtucbTdymw1irw24OM5YK0=;
 b=F/pKTXr/Da27CaqkkAfdiHI6pAyjrT+TB3rx5aFTNpL9YLYzAgz9r0yM4mNb7gphQW
 ZGA4MquB6GTCWLFKtVjYZyltqHlS53Vh4tsj7wy7lL9Zup23q5tI9wPclquQXfPsc/zo
 Ki4ZdIHa0jP4SAPsuoCWmt28/iyrlCGtRG6SpIxh0+y1Yh7KF6YgdP85DcT6kylc8LCA
 P5T0BFN0lpN6p895heICqb5ayzQp8pzoqgn7A7bsdmDkUUaqtYRf2IXKYeD/SEpz5Obf
 VfY8mJ+DROPZ9i2nka1avtpA+Z3YVEVcl9qZkgO/9mAgrI28Wqh89G7LvjmYoG03cjY9
 o6zw==
X-Gm-Message-State: AOJu0Yxn+6szQ1WG+yaw6l/nNVAGmNgXT0YyNDaLI6SfYDvX0USgDZlH
 Pondskk3h1rO750Y60TaRZ6zqQ==
X-Google-Smtp-Source: AGHT+IHKGaFWOeo/A1L/oCDPS8ZFUZh+oFpp9KaplNYP7cQ98m0WZfMaAbZPuTni6HP2HTPQaGy3aQ==
X-Received: by 2002:a05:6a21:9997:b0:16b:8b16:bfad with SMTP id
 ve23-20020a056a21999700b0016b8b16bfadmr21010002pzb.32.1697188298669; 
 Fri, 13 Oct 2023 02:11:38 -0700 (PDT)
Received: from [157.82.206.197] ([157.82.206.197])
 by smtp.gmail.com with ESMTPSA id
 ik5-20020a170902ab0500b001c723d6c410sm3465753plb.16.2023.10.13.02.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 02:11:38 -0700 (PDT)
Message-ID: <01971536-5a3d-45b0-99c2-b3583dbb9584@daynix.com>
Date: Fri, 13 Oct 2023 18:11:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 57/78] hw/net: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <84a6d743b5ff71c323cee718412e2a67084b9237.1697186560.git.manos.pitsidianakis@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <84a6d743b5ff71c323cee718412e2a67084b9237.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/10/13 17:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/net/cadence_gem.c     | 4 ++--
>   hw/net/can/can_sja1000.c | 4 ++--
>   hw/net/igb_core.c        | 2 +-
>   hw/net/igbvf.c           | 2 +-
>   hw/net/imx_fec.c         | 2 +-
>   hw/net/net_rx_pkt.c      | 2 +-
>   hw/net/pcnet.c           | 2 +-
>   hw/net/rtl8139.c         | 6 ++++--
>   hw/net/xilinx_ethlite.c  | 2 +-
>   9 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index f445d8bb5e..a59991af5b 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -834,10 +834,10 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>                   qemu_log_mask(LOG_UNIMP, "TCP compare offsets"
>                                 "unimplemented - assuming UDP\n");
>                   offset += 8;
> -                /* Fallthrough */
> +                fallthrough;
>               case 2: /* skip the IP header */
>                   offset += 20;
> -                /* Fallthrough */
> +                fallthrough;
>               case 1: /* Count from after the ethertype */
>                   offset += 14;
>                   break;
> diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
> index 73201f9139..14052b2700 100644
> --- a/hw/net/can/can_sja1000.c
> +++ b/hw/net/can/can_sja1000.c
> @@ -544,7 +544,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
>               break;
>           case 16: /* RX frame information addr16-28. */
>               s->status_pel |= (1 << 5); /* Set transmit status. */
> -            /* fallthrough */
> +            fallthrough;
>           case 17 ... 28:
>               if (s->mode & 0x01) { /* Reset mode */
>                   if (addr < 24) {
> @@ -642,7 +642,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
>               break;
>           case 10:
>               s->status_bas |= (1 << 5); /* Set transmit status. */
> -            /* fallthrough */
> +            fallthrough;
>           case 11 ... 19:
>               if ((s->control & 0x01) == 0) { /* Operation mode */
>                   s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index f6a5e2327b..1117f7cb59 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -1419,7 +1419,7 @@ igb_build_rx_metadata_common(IGBCore *core,
>               if (!csum_valid) {
>                   *status_flags |= E1000_RXDEXT_STATERR_TCPE;
>               }
> -            /* fall through */
> +            fallthrough;
>           case ETH_L4_HDR_PROTO_TCP:
>               *status_flags |= E1000_RXD_STAT_TCPCS;
>               break;
> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index d55e1e8a6a..ff68a4f3c5 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -188,7 +188,7 @@ static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
>           if (write) {
>               return HWADDR_MAX;
>           }
> -        /* fallthrough */
> +        fallthrough;
>       case 0x34E8: /* PBTWAC */
>       case 0x24E8: /* PBRWAC */
>           return addr;
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 5d1f1f104c..a7e8b06d48 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -918,7 +918,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
>                             TYPE_IMX_FEC, __func__);
>               return;
>           }
> -        /* fall through */
> +        fallthrough;
>       case ENET_TDAR:
>           if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
>               s->regs[index] = ENET_TDAR_TDAR;
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 32e5f3f9cf..52e2432c9b 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -605,7 +605,7 @@ bool net_rx_pkt_validate_l4_csum(struct NetRxPkt *pkt, bool *csum_valid)
>               trace_net_rx_pkt_l4_csum_validate_udp_with_no_checksum();
>               return false;
>           }
> -        /* fall through */
> +        fallthrough;
>       case ETH_L4_HDR_PROTO_TCP:
>           csum = _net_rx_pkt_calc_l4_csum(pkt);
>           *csum_valid = ((csum == 0) || (csum == 0xFFFF));
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index 02828ae716..a32174ef93 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -1502,7 +1502,7 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
>   #ifdef PCNET_DEBUG
>          printf("BCR_SWS=0x%04x\n", val);
>   #endif
> -        /* fall through */
> +       fallthrough;
>       case BCR_LNKST:
>       case BCR_LED1:
>       case BCR_LED2:
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 4525fda383..42f19618b1 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -2447,8 +2447,10 @@ static uint32_t rtl8139_TxStatus_TxAddr_read(RTL8139State *s, uint32_t regs[],
>       }
>   
>       switch (size) {
> -    case 1: /* fall through */
> -    case 2: /* fall through */
> +    case 1:
> +        fallthrough;
> +    case 2:
> +        fallthrough;
>       case 4:

I don't think you need comments or pseudo-keywords here.

