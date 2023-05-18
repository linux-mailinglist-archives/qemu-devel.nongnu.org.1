Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B8707833
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 04:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzTe6-00053v-0d; Wed, 17 May 2023 22:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1pzTe4-00050j-AV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:45:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1pzTdz-0008De-Bl
 for qemu-devel@nongnu.org; Wed, 17 May 2023 22:45:33 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d139e0d67so179795b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 19:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684377929; x=1686969929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FJ/jb2glWm8FG9DwBZxmXDmaB9TBwrpfZNs6s1tg7oQ=;
 b=rQsewv79spD+TzhVsPn9uFxan4C0bXoC6xDIfdKzzo6iSj9jLsJIWB/XVEnodo72gx
 wr9xGwSkRiAzGUGRqMyHO7gQeXzl+KVbWIF7n/7dfeJEEwbsIuWev1DZQ/EyNr9D55IV
 6JIBNQIbOccMb144Oz0fr/t0pffroVwHvfynxInxnOytbp+HmytmzezsaF2YYfyIsDFJ
 /WcMFpNrtIdpA718zbBP8I2ZHFHfVRYxxGT1GdWesCmEDAQegVYycDZ7o1Zu6j7JY4xK
 Eexw3vh7ufjlep6rKmPCTj707l01NiL3TghUmMTjLxBUjqb0A4MFPrVgmNoI7siyYBgq
 bwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684377929; x=1686969929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FJ/jb2glWm8FG9DwBZxmXDmaB9TBwrpfZNs6s1tg7oQ=;
 b=Sn7ADOic7FgAv44s0FTV4cTU/A8jNXf7cjAZFntb0SX0/TJCi1H+up+Xf+15HGOb5a
 UwANiKr4gShiCeplBGQwgkhjMSmavg1DLzXYFPdJS7iR865qfMLidC1Rb5PqU0GEv+ap
 OC6F9AYI9IIMevMPLmxXyoayyTMmyoL2947t9DP1y56D4ntyAt+T8pjSsPAMl/+8B8Br
 RWznXVCvZSU1XgdXmp0KyoixOs1krTn04keLklFTDa4Coqgl8u3ofsyhZivALrwJnBjY
 7jy2kPhvtn0GOAY/ZKbCVuS5F5d6cILZ9IpNHAul5qneo1i6eeOeCzWUXc3FKINELUSk
 +SrQ==
X-Gm-Message-State: AC+VfDw9GM/gDWZYVSo+2eOsu4jS5igN0pCDbkqd2LBZHy0xo461kDTd
 sEL7zSvi04zz3fbQ9I8Mbvfkug==
X-Google-Smtp-Source: ACHHUZ7Nz0bTEoGL/gMnJbYJ88UE1GDhqH8Yrq0O7Aoo+OTEQSuPmMkNskph93BD8qHCAXRJsVfkmw==
X-Received: by 2002:a05:6a20:a104:b0:103:ef39:a832 with SMTP id
 q4-20020a056a20a10400b00103ef39a832mr660670pzk.23.1684377929179; 
 Wed, 17 May 2023 19:45:29 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 c21-20020aa78c15000000b0063d2bb0d10asm213365pfd.113.2023.05.17.19.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 19:45:28 -0700 (PDT)
Message-ID: <6dae337a-0890-b1c0-4d08-1a44867a14cc@daynix.com>
Date: Thu, 18 May 2023 11:45:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 3/7] igb: RX descriptors guest writting refactoring
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <20230517154702.4215-1-t.dzieciol@partner.samsung.com>
 <CGME20230517154709eucas1p175f07cfb871664c854ce73663e7f5052@eucas1p1.samsung.com>
 <20230517154702.4215-4-t.dzieciol@partner.samsung.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230517154702.4215-4-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 2023/05/18 0:46, Tomasz Dzieciol wrote:
> Refactoring is done in preparation for support of multiple advanced
> descriptors RX modes, especially packet-split modes.
> 
> Signed-off-by: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>
> ---
>   hw/net/igb_core.c   | 176 ++++++++++++++++++++++----------------------
>   hw/net/igb_regs.h   |  10 +--
>   hw/net/trace-events |   6 +-
>   3 files changed, 99 insertions(+), 93 deletions(-)
> 
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index b6031dea24..774b34fc92 100644
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
> @@ -1423,43 +1365,106 @@ func_exit:
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
> +    uint16_t pkt_type = 0;
> +    bool hasip4, hasip6;
> +    EthL4HdrProto l4hdr_proto;
> +
> +    net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
> +
> +    if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
> +        pkt_type |= E1000_ADVRXD_PKT_IP6;
> +    } else if (hasip4) {
> +        pkt_type = E1000_ADVRXD_PKT_IP4;

For IPv6 "|=" is used but here "=" is used. This should be consistent. I 
suggest:
     if (hasip6 && !(core->mac[RFCTL] & E1000_RFCTL_IPV6_DIS)) {
         pkt_type = E1000_ADVRXD_PKT_IP6;
     } else if (hasip4) {
         pkt_type = E1000_ADVRXD_PKT_IP4;
     } else {
         pkt_type = 0;
     }

> +    }
> +
> +    if (etqf < 8) {
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
> @@ -1468,8 +1473,7 @@ igb_write_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
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

