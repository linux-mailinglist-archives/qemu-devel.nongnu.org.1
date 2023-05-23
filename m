Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193870D1C5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I7D-0007hr-D7; Mon, 22 May 2023 22:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I77-0007eA-C8
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:51:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I74-0005sG-Cs
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:51:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae4e49727eso67087645ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684810260; x=1687402260;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fXUQNpPPJOG4A+MA0EMC6t3tvV9s3vDDInWLt1xRHQ0=;
 b=gO7wB9+5izq/tOfhiuOk5ummWnIj7C4oohVQAEUZkABJbN3ROnw7M07vgmaWGqXUky
 PBj0ynHrcnhcXdoSTGxXmiN34cUptVgPnfQzkNiV7/+h0GyGvsNQNs3cxX0syKvaQqKT
 qd11B4odFfBeLvkgBJO094sEEyS1S/1S4ezv/BY2UjHD8PbKqcAu8RCpdRoxkHNPu0TH
 uAcEAIjGkLfEnM1hzrhzbna6OAqbNT+yZM58eBSFd14aZfa/V5mjnQ+0qctfJxA0PmEy
 IJY7tdXusxKO1wssZ5O5aT26dBC4k2j6jFQqcug1tErxrdW8Lna5X1L9pX8dM8uFUhrk
 VKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684810260; x=1687402260;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXUQNpPPJOG4A+MA0EMC6t3tvV9s3vDDInWLt1xRHQ0=;
 b=ShvWGrLGQFOHq8C4Cvx8EMawQV3PDqnIZTNZ+IzMQLY8ftm4o9amPQ5e8tbeCY4uFM
 tBKI1tOGaGd7yz9iyKwrCIZteehk237svH+D6OvsvqNPHPodeVnBR2F747dvKYeM3y8I
 yfttwgUwl1UsUFjb2zwse7h8ML7H5auLTQV+nlxL+A3ZPaL6rMe1idfw5zfCvpN5fmCQ
 HN2xp1t1v8bMl/RepDUk4okbKdTwFbTtV47AmHeJOBUgiE58TeOjiruVE8wySPizYM2L
 YVdwX2mPkvuiANE2bwWWWlJUpd8vLyDWh9LD5FCdetYZYSCtVUIeg594EMa9LhcBftAH
 zPRA==
X-Gm-Message-State: AC+VfDxWGzuLsiFtq0IUAruJkIXIBfE5Qm31tywKLl0hk6U84BEjgK66
 cZvpTjrLdXewn5pqE0YmVItuRA==
X-Google-Smtp-Source: ACHHUZ5lWwN5MNMWQ+VW0B3cKdTQj49fjy+jAVNTxSdkDvCIVKTvXyF/2Fg3zgaPsa8zYpabNDjMsw==
X-Received: by 2002:a17:902:c944:b0:1ac:8cd4:7404 with SMTP id
 i4-20020a170902c94400b001ac8cd47404mr14520022pla.35.1684810260512; 
 Mon, 22 May 2023 19:51:00 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a17090274c400b001a64ce7b18dsm5500117plt.165.2023.05.22.19.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 19:51:00 -0700 (PDT)
Message-ID: <b9cbf9d9-baea-d7c9-f952-20766f991e18@daynix.com>
Date: Tue, 23 May 2023 11:50:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v8 3/7] igb: RX descriptors guest writting refactoring
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140458eucas1p200bea061f622857ab8aa5140b9130515@eucas1p2.samsung.com>
 <20230518140448.2001-4-t.dzieciol@partner.samsung.com>
Content-Language: en-US
In-Reply-To: <20230518140448.2001-4-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/05/18 23:04, Tomasz Dzieciol wrote:
> Refactoring is done in preparation for support of multiple advanced
> descriptors RX modes, especially packet-split modes.
> 
> Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
> ---
>   hw/net/igb_core.c   | 178 +++++++++++++++++++++++---------------------
>   hw/net/igb_regs.h   |  10 +--
>   hw/net/trace-events |   6 +-
>   3 files changed, 101 insertions(+), 93 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index b6031dea24..c987b26d09 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -1281,15 +1281,11 @@ igb_verify_csum_in_sw(IGBCore *core,
>   }
>   
>   static void
> -igb_build_rx_metadata(IGBCore *core,
> -                      struct NetRxPkt *pkt,
> -                      bool is_eop,
> -                      const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
> -                      uint16_t *pkt_info, uint16_t *hdr_info,
> -                      uint32_t *rss,
> -                      uint32_t *status_flags,
> -                      uint16_t *ip_id,
> -                      uint16_t *vlan_tag)
> +igb_build_rx_metadata_common(IGBCore *core,
> +                             struct NetRxPkt *pkt,
> +                             bool is_eop,
> +                             uint32_t *status_flags,
> +                             uint16_t *vlan_tag)
>   {
>       struct virtio_net_hdr *vhdr;
>       bool hasip4, hasip6, csum_valid;
> @@ -1298,7 +1294,6 @@ igb_build_rx_metadata(IGBCore *core,
>       *status_flags = E1000_RXD_STAT_DD;
>   
>       /* No additional metadata needed for non-EOP descriptors */
> -    /* TODO: EOP apply only to status so don't skip whole function. */
>       if (!is_eop) {
>           goto func_exit;
>       }
> @@ -1315,59 +1310,6 @@ igb_build_rx_metadata(IGBCore *core,
>           trace_e1000e_rx_metadata_vlan(*vlan_tag);
>       }
>   
> -    /* Packet parsing results */
> -    if ((core->mac[RXCSUM] & E1000_RXCSUM_PCSD) != 0) {
> -        if (rss_info->enabled) {
> -            *rss = cpu_to_le32(rss_info->hash);
> -            trace_igb_rx_metadata_rss(*rss);
> -        }
> -    } else if (hasip4) {
> -            *status_flags |= E1000_RXD_STAT_IPIDV;
> -            *ip_id = cpu_to_le16(net_rx_pkt_get_ip_id(pkt));
> -            trace_e1000e_rx_metadata_ip_id(*ip_id);
> -    }
> -
> -    if (pkt_info) {
> -        *pkt_info = rss_info->enabled ? rss_info->type : 0;
> -
> -        if (etqf < 8) {
> -            *pkt_info |= BIT(11) | (etqf << 4);
> -        } else {
> -            if (hasip4) {
> -                *pkt_info |= E1000_ADVRXD_PKT_IP4;
> -            }
> -
> -            if (hasip6) {
> -                *pkt_info |= E1000_ADVRXD_PKT_IP6;
> -            }
> -
> -            switch (l4hdr_proto) {
> -            case ETH_L4_HDR_PROTO_TCP:
> -                *pkt_info |= E1000_ADVRXD_PKT_TCP;
> -                break;
> -
> -            case ETH_L4_HDR_PROTO_UDP:
> -                *pkt_info |= E1000_ADVRXD_PKT_UDP;
> -                break;
> -
> -            case ETH_L4_HDR_PROTO_SCTP:
> -                *pkt_info |= E1000_ADVRXD_PKT_SCTP;
> -                break;
> -
> -            default:
> -                break;
> -            }
> -        }
> -    }
> -
> -    if (hdr_info) {
> -        *hdr_info = 0;
> -    }
> -
> -    if (ts) {
> -        *status_flags |= BIT(16);
> -    }
> -
>       /* RX CSO information */
>       if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_XSUM_DIS)) {
>           trace_e1000e_rx_metadata_ipv6_sum_disabled();
> @@ -1423,43 +1365,108 @@ func_exit:
>   static inline void
>   igb_write_lgcy_rx_descr(IGBCore *core, struct e1000_rx_desc *desc,
>                           struct NetRxPkt *pkt,
> -                        const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
> +                        const E1000E_RSSInfo *rss_info,
>                           uint16_t length)
>   {
> -    uint32_t status_flags, rss;
> -    uint16_t ip_id;
> +    uint32_t status_flags;
>   
>       assert(!rss_info->enabled);
> +
> +    memset(desc, 0, sizeof(*desc));
>       desc->length = cpu_to_le16(length);
> -    desc->csum = 0;
> +    igb_build_rx_metadata_common(core, pkt, pkt != NULL,
> +                                 &status_flags,
> +                                 &desc->special);
>   
> -    igb_build_rx_metadata(core, pkt, pkt != NULL,
> -                          rss_info, etqf, ts,
> -                          NULL, NULL, &rss,
> -                          &status_flags, &ip_id,
> -                          &desc->special);
>       desc->errors = (uint8_t) (le32_to_cpu(status_flags) >> 24);
>       desc->status = (uint8_t) le32_to_cpu(status_flags);
>   }
>   
> +static uint16_t
> +igb_rx_desc_get_packet_type(IGBCore *core, struct NetRxPkt *pkt, uint16_t etqf)
> +{
> +    uint16_t pkt_type;
> +    bool hasip4, hasip6;
> +    EthL4HdrProto l4hdr_proto;
> +
> +    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
> +
> +    if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
> +        pkt_type = E1000_ADVRXD_PKT_IP6;
> +    } else if (hasip4) {
> +        pkt_type = E1000_ADVRXD_PKT_IP4;
> +    } else {
> +        pkt_type = 0;
> +    }
> +
> +    if (etqf < 8) {

When ETQF is applied, E1000_ADVRXD_PKT_IP6 and E1000_ADVRXD_PKT_IP4 
shouldn't be set.

> +        pkt_type |= (BIT(11) >> 4) | etqf;
> +        return pkt_type;
> +    }
> +
> +    switch (l4hdr_proto) {
> +    case ETH_L4_HDR_PROTO_TCP:
> +        pkt_type |= E1000_ADVRXD_PKT_TCP;
> +        break;
> +    case ETH_L4_HDR_PROTO_UDP:
> +        pkt_type |= E1000_ADVRXD_PKT_UDP;
> +        break;
> +    case ETH_L4_HDR_PROTO_SCTP:
> +        pkt_type |= E1000_ADVRXD_PKT_SCTP;
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    return pkt_type;
> +}
> +
>   static inline void
> -igb_write_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
> +igb_write_adv_rx_descr(IGBCore *core,
> +                       union e1000_adv_rx_desc *d,
>                          struct NetRxPkt *pkt,
> -                       const E1000E_RSSInfo *rss_info, uint16_t etqf, bool ts,
> +                       const E1000E_RSSInfo *rss_info,
> +                       uint16_t etqf,
> +                       bool ts,

Don't change the signature. Remove newlines you added and restore the 
name of the second parameter, just as pointed out for 
igb_write_lgcy_rx_descr().

>                          uint16_t length)
>   {
> -    memset(&desc->wb, 0, sizeof(desc->wb));
> +    bool hasip4, hasip6;
> +    EthL4HdrProto l4hdr_proto;
> +    uint16_t rss_type = 0, pkt_type;
> +    bool eop = (pkt != NULL);
> +    memset(&d->wb, 0, sizeof(d->wb));
> +
> +    d->wb.upper.length = cpu_to_le16(length);
> +    igb_build_rx_metadata_common(core, pkt, eop,
> +                                 &d->wb.upper.status_error,
> +                                 &d->wb.upper.vlan);
> +
> +    if (!eop) {
> +        return;
> +    }
> +
> +    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
>   
> -    desc->wb.upper.length = cpu_to_le16(length);
> +    if ((core->mac[RXCSUM] & E1000_RXCSUM_PCSD) != 0) {
> +        if (rss_info->enabled) {
> +            d->wb.lower.hi_dword.rss = cpu_to_le32(rss_info->hash);
> +            rss_type = rss_info->type;
> +            trace_igb_rx_metadata_rss(d->wb.lower.hi_dword.rss, rss_type);
> +        }
> +    } else if (hasip4) {
> +            d->wb.upper.status_error |= E1000_RXD_STAT_IPIDV;

Here, convert the endian properly.

> +            d->wb.lower.hi_dword.csum_ip.ip_id =
> +                cpu_to_le16(net_rx_pkt_get_ip_id(pkt));
> +            trace_e1000e_rx_metadata_ip_id(d->wb.lower.hi_dword.csum_ip.ip_id);
> +    }
> +
> +    if (ts) {
> +        d->wb.upper.status_error |= BIT(16);
> +    }
>   
> -    igb_build_rx_metadata(core, pkt, pkt != NULL,
> -                          rss_info, etqf, ts,
> -                          &desc->wb.lower.lo_dword.pkt_info,
> -                          &desc->wb.lower.lo_dword.hdr_info,
> -                          &desc->wb.lower.hi_dword.rss,
> -                          &desc->wb.upper.status_error,
> -                          &desc->wb.lower.hi_dword.csum_ip.ip_id,
> -                          &desc->wb.upper.vlan);
> +    pkt_type = igb_rx_desc_get_packet_type(core, pkt, etqf);
> +    trace_e1000e_rx_metadata_pkt_type(pkt_type);
> +    d->wb.lower.lo_dword.pkt_info = cpu_to_le16(rss_type | (pkt_type << 4));
>   }
>   
>   static inline void
> @@ -1468,8 +1475,7 @@ igb_write_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
>                      uint16_t etqf, bool ts, uint16_t length)
>   {
>       if (igb_rx_use_legacy_descriptor(core)) {
> -        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info,
> -                                etqf, ts, length);
> +        igb_write_lgcy_rx_descr(core, &desc->legacy, pkt, rss_info, length);
>       } else {
>           igb_write_adv_rx_descr(core, &desc->adv, pkt, rss_info,
>                                  etqf, ts, length);
> diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
> index 82ff195dfc..71a8833229 100644
> --- a/hw/net/igb_regs.h
> +++ b/hw/net/igb_regs.h
> @@ -692,11 +692,11 @@ union e1000_adv_rx_desc {
>   
>   #define E1000_STATUS_NUM_VFS_SHIFT 14
>   
> -#define E1000_ADVRXD_PKT_IP4 BIT(4)
> -#define E1000_ADVRXD_PKT_IP6 BIT(6)
> -#define E1000_ADVRXD_PKT_TCP BIT(8)
> -#define E1000_ADVRXD_PKT_UDP BIT(9)
> -#define E1000_ADVRXD_PKT_SCTP BIT(10)
> +#define E1000_ADVRXD_PKT_IP4  BIT(0)
> +#define E1000_ADVRXD_PKT_IP6  BIT(2)
> +#define E1000_ADVRXD_PKT_TCP  BIT(4)
> +#define E1000_ADVRXD_PKT_UDP  BIT(5)
> +#define E1000_ADVRXD_PKT_SCTP BIT(6)
>   
>   static inline uint8_t igb_ivar_entry_rx(uint8_t i)
>   {
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e4a98b2c7d..def651c186 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -277,9 +277,9 @@ igb_core_mdic_write_unhandled(uint32_t addr) "MDIC WRITE: PHY[%u] UNHANDLED"
>   igb_link_set_ext_params(bool asd_check, bool speed_select_bypass, bool pfrstd) "Set extended link params: ASD check: %d, Speed select bypass: %d, PF reset done: %d"
>   
>   igb_rx_desc_buff_size(uint32_t b) "buffer size: %u"
> -igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"
> +igb_rx_desc_buff_write(uint64_t addr, uint16_t offset, const void* source, uint32_t len) "buffer %u, addr: 0x%"PRIx64", offset: %u, from: %p, length: %u"

The format is changed but the parameters are not updated.

>   
> -igb_rx_metadata_rss(uint32_t rss) "RSS data: 0x%X"
> +igb_rx_metadata_rss(uint32_t rss, uint16_t rss_pkt_type) "RSS data: rss: 0x%X, rss_pkt_type: 0x%X"
>   
>   igb_irq_icr_clear_gpie_nsicr(void) "Clearing ICR on read due to GPIE.NSICR enabled"
>   igb_irq_set_iam(uint32_t icr) "Update IAM: 0x%x"
> @@ -294,6 +294,8 @@ igb_irq_eitr_set(uint32_t eitr_num, uint32_t val) "EITR[%u] = 0x%x"
>   igb_set_pfmailbox(uint32_t vf_num, uint32_t val) "PFMailbox[%d]: 0x%x"
>   igb_set_vfmailbox(uint32_t vf_num, uint32_t val) "VFMailbox[%d]: 0x%x"
>   
> +igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d"
> +
>   # igbvf.c
>   igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
>   

