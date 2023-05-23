Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A146F70D1C6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I7W-0008Cz-4t; Mon, 22 May 2023 22:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I7T-0008CG-SZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:51:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I7R-0005vf-PD
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:51:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso4605319b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684810280; x=1687402280;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FwhSpvIZAGvRQ78Tzk8zpcehaWXGzWdswoVnTRgyZ6g=;
 b=J11Hsx4JoglLJ2aAE0tuqgSAazguQ8ktFY90AnVF6MYOsFaeGOdXDcEIRBPVuVy+yi
 0ArVCp34ireuhdeDeFrd91dIzZAxqaBZe12kx/0tMiYdmvRC+FGSvplLGc5p19H953jv
 BFpPc47cOTRGUALHjl7DqSIbxK6TcC5g1xE3Hu4xGNjd+/34BUfYgSKmPqJxThSkAhHV
 00tSZ/X4avQUhP5/re5ifekjj+sLHfYvJHVBeIq/mVL2rbjGu2kZ35SDUciZZox1y5+B
 Ilb/op0IUq7NnOnU7UtwI3QuH+2dQ8/TG0DpcjUDFSlda8iPAATGOvV+P2S23F0khjoi
 DgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684810280; x=1687402280;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FwhSpvIZAGvRQ78Tzk8zpcehaWXGzWdswoVnTRgyZ6g=;
 b=WPPHc0yya3nz4uH9klz6ixLZA9CgQ9j7l0SFXKbxI7BNQ6SbGPUZ0W+1HbfPazboIO
 XsIPuFmvUayYp9ghJ0bLe06q0veMxL5cZBpZoMesyQfgbaX6SDMaEbyqyr6fEtPfCpIJ
 lU/XKnx3ssyfUjWmaJzC+MDPWcvKN5k63ARxFKV92yOOwMDveafXdfWtFVcX1g/8dhiZ
 hQtt03+8KLM1AgkyLcdA3HIulqgGVLpNHq7T0nBnNLxCRGZfoAAxG0Zg3e6KWWZOVPOz
 WgjVUpk2x0UgveHX2G4oi1hmw9XkrMZ2WkQ0XSCa5Alv6K6f/oLW83a7wH4zvfVQ3Gu4
 XpMA==
X-Gm-Message-State: AC+VfDwl4+SKyxarIS0YDtIQhNwpweXJ4Nyxy3cXsXCTkmLNsuqOApx7
 +qgUievEUaNtM/N7LXqT/5CwQA==
X-Google-Smtp-Source: ACHHUZ5/q1DKwlDhOiQ2pMbjCdBrr87Eckt3PM/jRW3Of3PDntqVEK1TALubOxFzeb4GyNhsnRibcg==
X-Received: by 2002:a17:903:1112:b0:1a6:8ed5:428a with SMTP id
 n18-20020a170903111200b001a68ed5428amr16277751plh.22.1684810279835; 
 Mon, 22 May 2023 19:51:19 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a170902c19400b001ab01598f40sm5510615pld.173.2023.05.22.19.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 19:51:19 -0700 (PDT)
Message-ID: <5745517c-90f2-3c38-350c-de13940b6ccb@daynix.com>
Date: Tue, 23 May 2023 11:51:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v8 4/7] igb: RX payload guest writting refactoring
To: Tomasz Dzieciol <t.dzieciol@partner.samsung.com>, qemu-devel@nongnu.org
Cc: sriram.yagnaraman@est.tech, jasowang@redhat.com, k.kwiecien@samsung.com,
 m.sochacki@samsung.com
References: <20230518140448.2001-1-t.dzieciol@partner.samsung.com>
 <CGME20230518140459eucas1p2dafa81561d57fe5aad7d39f786e193f7@eucas1p2.samsung.com>
 <20230518140448.2001-5-t.dzieciol@partner.samsung.com>
Content-Language: en-US
In-Reply-To: <20230518140448.2001-5-t.dzieciol@partner.samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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
>   hw/net/e1000e_core.c     |  18 ++--
>   hw/net/igb_core.c        | 214 +++++++++++++++++++++++++--------------
>   tests/qtest/libqos/igb.c |   5 +
>   3 files changed, 151 insertions(+), 86 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index b2e54fe802..f9ff31fd70 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -1418,11 +1418,11 @@ e1000e_write_hdr_to_rx_buffers(E1000ECore *core,
>   }
>   
>   static void
> -e1000e_write_to_rx_buffers(E1000ECore *core,
> -                           hwaddr ba[MAX_PS_BUFFERS],
> -                           e1000e_ba_state *bastate,
> -                           const char *data,
> -                           dma_addr_t data_len)
> +e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
> +                                        hwaddr ba[MAX_PS_BUFFERS],
> +                                        e1000e_ba_state *bastate,
> +                                        const char *data,
> +                                        dma_addr_t data_len)
>   {
>       while (data_len > 0) {
>           uint32_t cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
> @@ -1594,8 +1594,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
>                   while (copy_size) {
>                       iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
>   
> -                    e1000e_write_to_rx_buffers(core, ba, &bastate,
> -                                            iov->iov_base + iov_ofs, iov_copy);
> +                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
> +                                                            iov->iov_base +
> +                                                            iov_ofs,
> +                                                            iov_copy);
>   
>                       copy_size -= iov_copy;
>                       iov_ofs += iov_copy;
> @@ -1607,7 +1609,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
>   
>                   if (desc_offset + desc_size >= total_size) {
>                       /* Simulate FCS checksum presence in the last descriptor */
> -                    e1000e_write_to_rx_buffers(core, ba, &bastate,
> +                    e1000e_write_payload_frag_to_rx_buffers(core, ba, &bastate,
>                             (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
>                   }
>               }
> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
> index c987b26d09..7a4a01c4a1 100644
> --- a/hw/net/igb_core.c
> +++ b/hw/net/igb_core.c
> @@ -941,6 +941,14 @@ igb_has_rxbufs(IGBCore *core, const E1000ERingInfo *r, size_t total_size)
>                            bufsize;
>   }
>   
> +static uint32_t
> +igb_rxhdrbufsize(IGBCore *core, const E1000ERingInfo *r)
> +{
> +    uint32_t srrctl = core->mac[E1000_SRRCTL(r->idx) >> 2];
> +    return (srrctl & E1000_SRRCTL_BSIZEHDRSIZE_MASK) >>
> +           E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +}
> +
>   void
>   igb_start_recv(IGBCore *core)
>   {
> @@ -1231,6 +1239,21 @@ igb_read_adv_rx_descr(IGBCore *core, union e1000_adv_rx_desc *desc,
>       *buff_addr = le64_to_cpu(desc->read.pkt_addr);
>   }
>   
> +typedef struct IGBPacketRxDMAState {
> +    size_t size;
> +    size_t total_size;
> +    size_t ps_hdr_len;
> +    size_t desc_size;
> +    size_t desc_offset;
> +    uint32_t rx_desc_packet_buf_size;
> +    uint32_t rx_desc_header_buf_size;
> +    struct iovec *iov;
> +    size_t iov_ofs;
> +    bool is_first;
> +    uint16_t written;
> +    hwaddr ba;
> +} IGBPacketRxDMAState;
> +
>   static inline void
>   igb_read_rx_descr(IGBCore *core, union e1000_rx_desc_union *desc,
>                     hwaddr *buff_addr)
> @@ -1514,19 +1537,6 @@ igb_pci_dma_write_rx_desc(IGBCore *core, PCIDevice *dev, dma_addr_t addr,
>       }
>   }
>   
> -static void
> -igb_write_to_rx_buffers(IGBCore *core,
> -                        PCIDevice *d,
> -                        hwaddr ba,
> -                        uint16_t *written,
> -                        const char *data,
> -                        dma_addr_t data_len)
> -{
> -    trace_igb_rx_desc_buff_write(ba, *written, data, data_len);
> -    pci_dma_write(d, ba + *written, data, data_len);
> -    *written += data_len;
> -}
> -
>   static void
>   igb_update_rx_stats(IGBCore *core, const E1000ERingInfo *rxi,
>                       size_t pkt_size, size_t pkt_fcs_size)
> @@ -1552,6 +1562,93 @@ igb_rx_descr_threshold_hit(IGBCore *core, const E1000ERingInfo *rxi)
>              ((core->mac[E1000_SRRCTL(rxi->idx) >> 2] >> 20) & 31) * 16;
>   }
>   
> +static void
> +igb_truncate_to_descriptor_size(IGBPacketRxDMAState *pdma_st, size_t *size)
> +{
> +    if (*size > pdma_st->rx_desc_packet_buf_size) {
> +        *size = pdma_st->rx_desc_packet_buf_size;
> +    }
> +}
> +
> +static void
> +igb_write_payload_frag_to_rx_buffers(IGBCore *core,
> +                                     PCIDevice *d,
> +                                     hwaddr ba,
> +                                     uint16_t *written,
> +                                     uint32_t cur_buf_len,
> +                                     const char *data,
> +                                     dma_addr_t data_len)
> +{
> +    trace_igb_rx_desc_buff_write(ba, *written, data, data_len);
> +    pci_dma_write(d, ba + *written, data, data_len);
> +    *written += data_len;
> +}
> +
> +static void
> +igb_write_payload_to_rx_buffers(IGBCore *core,
> +                                struct NetRxPkt *pkt,
> +                                PCIDevice *d,
> +                                IGBPacketRxDMAState *pdma_st,
> +                                size_t *copy_size)
> +{
> +    static const uint32_t fcs_pad;
> +    size_t iov_copy;
> +
> +    /* Copy packet payload */
> +    while (*copy_size) {
> +        iov_copy = MIN(*copy_size, pdma_st->iov->iov_len - pdma_st->iov_ofs);
> +        igb_write_payload_frag_to_rx_buffers(core, d,
> +                                             pdma_st->ba,
> +                                             &pdma_st->written,
> +                                             pdma_st->rx_desc_packet_buf_size,
> +                                             pdma_st->iov->iov_base +
> +                                             pdma_st->iov_ofs,
> +                                             iov_copy);
> +
> +        *copy_size -= iov_copy;
> +        pdma_st->iov_ofs += iov_copy;
> +        if (pdma_st->iov_ofs == pdma_st->iov->iov_len) {
> +            pdma_st->iov++;
> +            pdma_st->iov_ofs = 0;
> +        }
> +    }
> +
> +    if (pdma_st->desc_offset + pdma_st->desc_size >= pdma_st->total_size) {
> +        /* Simulate FCS checksum presence in the last descriptor */
> +        igb_write_payload_frag_to_rx_buffers(core, d,
> +                                             pdma_st->ba,
> +                                             &pdma_st->written,
> +                                             pdma_st->rx_desc_packet_buf_size,
> +                                             (const char *) &fcs_pad,
> +                                             e1000x_fcs_len(core->mac));
> +    }
> +}
> +
> +static void
> +igb_write_to_rx_buffers(IGBCore *core,
> +                        struct NetRxPkt *pkt,
> +                        PCIDevice *d,
> +                        IGBPacketRxDMAState *pdma_st)
> +{
> +    size_t copy_size;
> +
> +    if (!pdma_st->ba) {
> +        /* as per intel docs; skip descriptors with null buf addr */
> +        trace_e1000e_rx_null_descriptor();
> +        return;
> +    }
> +
> +    if (pdma_st->desc_offset >= pdma_st->size) {
> +        return;
> +    }
> +
> +    pdma_st->desc_size = pdma_st->total_size - pdma_st->desc_offset;
> +    igb_truncate_to_descriptor_size(pdma_st, &pdma_st->desc_size);
> +    copy_size = pdma_st->size - pdma_st->desc_offset;
> +    igb_truncate_to_descriptor_size(pdma_st, &copy_size);
> +    igb_write_payload_to_rx_buffers(core, pkt, d, pdma_st, &copy_size);
> +}
> +
>   static void
>   igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
>                             const E1000E_RxRing *rxr,
> @@ -1561,91 +1658,52 @@ igb_write_packet_to_guest(IGBCore *core, struct NetRxPkt *pkt,
>       PCIDevice *d;
>       dma_addr_t base;
>       union e1000_rx_desc_union desc;
> -    size_t desc_size;
> -    size_t desc_offset = 0;
> -    size_t iov_ofs = 0;
> -
> -    struct iovec *iov = net_rx_pkt_get_iovec(pkt);
> -    size_t size = net_rx_pkt_get_total_len(pkt);
> -    size_t total_size = size + e1000x_fcs_len(core->mac);
> -    const E1000ERingInfo *rxi = rxr->i;
> -    size_t bufsize = igb_rxbufsize(core, rxi);
> -
> +    const E1000ERingInfo *rxi;
> +    size_t rx_desc_len;
> +
> +    IGBPacketRxDMAState pdma_st = {0};
> +    pdma_st.is_first = true;
> +    pdma_st.size = net_rx_pkt_get_total_len(pkt);
> +    pdma_st.total_size = pdma_st.size + e1000x_fcs_len(core->mac);
> +
> +    rxi = rxr->i;
> +    rx_desc_len = core->rx_desc_len;
> +    pdma_st.rx_desc_packet_buf_size = igb_rxbufsize(core, rxi);
> +    pdma_st.rx_desc_header_buf_size = igb_rxhdrbufsize(core, rxi);
> +    pdma_st.iov = net_rx_pkt_get_iovec(pkt);
>       d = pcie_sriov_get_vf_at_index(core->owner, rxi->idx % 8);
>       if (!d) {
>           d = core->owner;
>       }
>   
>       do {
> -        hwaddr ba;
> -        uint16_t written = 0;
> +        pdma_st.written = 0;
>           bool is_last = false;
>   
> -        desc_size = total_size - desc_offset;
> -
> -        if (desc_size > bufsize) {
> -            desc_size = bufsize;
> -        }
> -
>           if (igb_ring_empty(core, rxi)) {
>               return;
>           }
>   
>           base = igb_ring_head_descr(core, rxi);
> +        pci_dma_read(d, base, &desc, rx_desc_len);
> +        trace_e1000e_rx_descr(rxi->idx, base, rx_desc_len);
>   
> -        pci_dma_read(d, base, &desc, core->rx_desc_len);
> -
> -        trace_e1000e_rx_descr(rxi->idx, base, core->rx_desc_len);
> -
> -        igb_read_rx_descr(core, &desc, &ba);
> -
> -        if (ba) {
> -            if (desc_offset < size) {
> -                static const uint32_t fcs_pad;
> -                size_t iov_copy;
> -                size_t copy_size = size - desc_offset;
> -                if (copy_size > bufsize) {
> -                    copy_size = bufsize;
> -                }
> -
> -                /* Copy packet payload */
> -                while (copy_size) {
> -                    iov_copy = MIN(copy_size, iov->iov_len - iov_ofs);
> -
> -                    igb_write_to_rx_buffers(core, d, ba, &written,
> -                                            iov->iov_base + iov_ofs, iov_copy);
> +        igb_read_rx_descr(core, &desc, &pdma_st.ba);
>   
> -                    copy_size -= iov_copy;
> -                    iov_ofs += iov_copy;
> -                    if (iov_ofs == iov->iov_len) {
> -                        iov++;
> -                        iov_ofs = 0;
> -                    }
> -                }
> -
> -                if (desc_offset + desc_size >= total_size) {
> -                    /* Simulate FCS checksum presence in the last descriptor */
> -                    igb_write_to_rx_buffers(core, d, ba, &written,
> -                          (const char *) &fcs_pad, e1000x_fcs_len(core->mac));
> -                }
> -            }
> -        } else { /* as per intel docs; skip descriptors with null buf addr */
> -            trace_e1000e_rx_null_descriptor();
> -        }
> -        desc_offset += desc_size;
> -        if (desc_offset >= total_size) {
> +        igb_write_to_rx_buffers(core, pkt, d, &pdma_st);
> +        pdma_st.desc_offset += pdma_st.desc_size;
> +        if (pdma_st.desc_offset >= pdma_st.total_size) {
>               is_last = true;
>           }
>   
>           igb_write_rx_descr(core, &desc, is_last ? core->rx_pkt : NULL,
> -                           rss_info, etqf, ts, written);
> -        igb_pci_dma_write_rx_desc(core, d, base, &desc, core->rx_desc_len);
> -
> -        igb_ring_advance(core, rxi, core->rx_desc_len / E1000_MIN_RX_DESC_LEN);
> -
> -    } while (desc_offset < total_size);
> +                           rss_info, etqf, ts, pdma_st.written);
> +        pci_dma_write(d, base, &desc, rx_desc_len);

Use igb_pci_dma_write_rx_desc() as the old code did.

> +        igb_ring_advance(core, rxi,
> +                         rx_desc_len / E1000_MIN_RX_DESC_LEN);
> +    } while (pdma_st.desc_offset < pdma_st.total_size);
>   
> -    igb_update_rx_stats(core, rxi, size, total_size);
> +    igb_update_rx_stats(core, rxi, pdma_st.size, pdma_st.total_size);
>   }
>   
>   static bool
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index a603468beb..f40c4ec4cd 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -109,6 +109,11 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
>                           le16_to_cpu(*(uint16_t *)(address + 4)));
>   
> +    /* Set supported receive descriptor mode */
> +    e1000e_macreg_write(&d->e1000e,
> +                        E1000_SRRCTL(0),
> +                        E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
> +
>       /* Enable receive */
>       e1000e_macreg_write(&d->e1000e, E1000_RFCTL, E1000_RFCTL_EXTEN);
>       e1000e_macreg_write(&d->e1000e, E1000_RCTL, E1000_RCTL_EN);

