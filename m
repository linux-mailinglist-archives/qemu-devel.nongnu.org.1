Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BEBA9C33
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Sep 2025 17:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FW0-0003Pg-Fr; Mon, 29 Sep 2025 11:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FVu-0003Lq-Qk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FVj-0004M5-VC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759158591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCKJ4m0gejdJ3tWfc5ZGfQai9EEgJtRi0H8ae/b3BLc=;
 b=KJYnkgXMxji5RDq/Ov1940bNztRIyLy0uGzKYOW5Y4rNs1mTbS/rhYbWswv4xrbfpEPcbf
 dZB25c3bf3sUV/uZKnW2Rk5w6pAdC/JbRIbZ79q1VtAqI7sVCl7ugnuOKlB+68Rvz+BuC3
 ZOViURLJKz/+iu4Zu8zHvfRh0cCh3BA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-9dHaCZRCOAKPk7QpGNbp_g-1; Mon, 29 Sep 2025 11:09:50 -0400
X-MC-Unique: 9dHaCZRCOAKPk7QpGNbp_g-1
X-Mimecast-MFC-AGG-ID: 9dHaCZRCOAKPk7QpGNbp_g_1759158589
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so3717076f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759158589; x=1759763389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vCKJ4m0gejdJ3tWfc5ZGfQai9EEgJtRi0H8ae/b3BLc=;
 b=lgr1XDMhK7DrsdIeU1mh9ZIqcWoOfZ3JSvkpzuwvwaxBU1cBhWYx8nqsS58xl5dJkC
 j5EYUGjTQn+TA4p7Vt+SPXF0gi3/N+6fT4CIq0OEQL4wmKu3upGgrcjpnZ61SpTjioQ2
 jZV38eAP5/wgAoVsZcoAHUXGSYVNBAlL9w1AOBZuZ8DjqcF88Bb71vL/PpGgkXviekDO
 GxGVWOSTQhjTMv1PmyujnCC+NI9UBT0ssGNkDn3VHmOPN8iQ+viTwedESSjRwJWwcK+5
 5eaHkNQ/GvgQe2GmjGC5SBq8iQlK4foplyMDu+6PxOUZlMUSAsqRSsuzQrylyvO3u0hy
 CCYA==
X-Gm-Message-State: AOJu0YzQEmWwJgM5SLgyO6SOSQLG4hr0HgHjsWdzYvB1RMfU4qAQIfWE
 vac6Np3P7H8aJIV3CXPPXwmgykRLhFBxLspoRSMLfhtC8/X9moZfv98pOkLk1bIvalpJTeurbKd
 2R06C75aZ/veYbSz1UvSshSI4f45yYCY6QqPQ7kzt9ANFwL/NLwEYR+G5
X-Gm-Gg: ASbGnct9bt295lehXv4pDAGJr6CeL4xGp7iSPuClyPM4wM7kNd3Tb7nnBy6Cmf0Kb+b
 UoPrzejX7BA1VW+M6WNNyt6YNzMfDlH4Lhsg33EhwGeHrsVUxG6HNLi6VJL1iq0HHeGefGofkzM
 yrs1HWJmNM+X5rJcnFNxhHwn8xJT6GP7dYuj3kgAk+NvK5YRifjziZhZ5223VtIInVGmHGBszG7
 Y3Ut2mo5KguHSMdzMYcFRmfTklcRkJAqwRAuyT12ASBOnLT6Z/NL73Q+h8G9m2FSiJEKppsvXka
 elK+PEsxUjqeizEUZIpM/qv7FJ9mP42IWKEGuKSmp7osObGV1z4d40KEL/gNYCneIUVbwS4FuqB
 fooNsZjq+Dpc=
X-Received: by 2002:a05:6000:2c06:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-40e468e7375mr11618404f8f.9.1759158588701; 
 Mon, 29 Sep 2025 08:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyTXY7o5M4oaUUD5MZqA1Wt0V59toXT7qLgJoUoADWLehre8ERnwF2gGXVAozH6viUNoWxBw==
X-Received: by 2002:a05:6000:2c06:b0:3ee:1125:fb6d with SMTP id
 ffacd0b85a97d-40e468e7375mr11618381f8f.9.1759158588150; 
 Mon, 29 Sep 2025 08:09:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab48b40sm227904615e9.19.2025.09.29.08.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:09:47 -0700 (PDT)
Message-ID: <8affa333-aeae-48a9-be78-7e4ade938344@redhat.com>
Date: Mon, 29 Sep 2025 17:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] hw/arm/smmuv3: Add banked support for queues and
 error handling
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-11-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-11-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/25/25 6:26 PM, Tao Tang wrote:
> This commit extends the banked register model to the Command Queue
> (CMDQ), Event Queue (EVTQ), and global error handling logic.
>
> By leveraging the banked structure, the SMMUv3 model now supports
> separate, parallel queues and error status registers for the Secure and
> Non-secure states. This is essential for correctly modeling the
> parallel programming interfaces defined by the SMMUv3 architecture.
>
> Additionally, this patch hardens the MMIO implementation by adding
> several checks that were incomplete in the previous version.
> For instance, writes to the Command Queue registers are now correctly
> gated by the IDR1.QUEUES_PRESET bit, ensuring compliance with the
> architectural rules for pre-configured queues.
if this is a fix for the current code, you can put in a preample patch
with Fixes tag.

Eric
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3-internal.h |   2 +
>  hw/arm/smmuv3.c          | 374 +++++++++++++++++++++++++++++++++------
>  2 files changed, 323 insertions(+), 53 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index af2936cf16..6bff504219 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -517,6 +517,8 @@ typedef struct SMMUEventInfo {
>      uint32_t sid;
>      bool recorded;
>      bool inval_ste_allowed;
> +    AddressSpace *as;
> +    MemTxAttrs txattrs;
>      SMMUSecurityIndex sec_idx;
>      union {
>          struct {
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 3835b9e79f..53c7eff0e3 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -106,14 +106,15 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn,
>      trace_smmuv3_write_gerrorn(toggled & pending, s->bank[sec_idx].gerrorn);
>  }
>  
> -static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd,
> +                                     SMMUSecurityIndex sec_idx)
>  {
>      dma_addr_t addr = Q_CONS_ENTRY(q);
>      MemTxResult ret;
>      int i;
>  
> -    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(smmu_get_address_space(sec_idx), addr, cmd,
> +                          sizeof(Cmd), smmu_get_txattrs(sec_idx));
>      if (ret != MEMTX_OK) {
>          return ret;
>      }
> @@ -123,7 +124,8 @@ static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
>      return ret;
>  }
>  
> -static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
> +static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in,
> +                               SMMUSecurityIndex sec_idx)
>  {
>      dma_addr_t addr = Q_PROD_ENTRY(q);
>      MemTxResult ret;
> @@ -133,8 +135,8 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>      for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
>          cpu_to_le32s(&evt.word[i]);
>      }
> -    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
> -                           MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_write(smmu_get_address_space(sec_idx), addr, &evt,
> +                           sizeof(Evt), smmu_get_txattrs(sec_idx));
>      if (ret != MEMTX_OK) {
>          return ret;
>      }
> @@ -157,7 +159,7 @@ static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt,
>          return MEMTX_ERROR;
>      }
>  
> -    r = queue_write(q, evt);
> +    r = queue_write(q, evt, sec_idx);
>      if (r != MEMTX_OK) {
>          return r;
>      }
> @@ -1025,6 +1027,8 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>           */
>          class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
>          event->sec_idx = cfg->sec_idx;
> +        event->txattrs = cfg->txattrs;
> +        event->sec_idx = cfg->sec_idx;
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
>              event->type = SMMU_EVT_F_WALK_EABT;
> @@ -1376,6 +1380,110 @@ static bool smmu_strtab_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>      return smmuv3_is_smmu_enabled(s, sec_idx);
>  }
>  
> +static inline int smmuv3_get_cr0_cmdqen(SMMUv3State *s,
> +                                        SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, CMDQEN);
> +}
> +
> +static inline int smmuv3_get_cr0ack_cmdqen(SMMUv3State *s,
> +                                           SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].cr0ack, CR0, CMDQEN);
> +}
> +
> +static inline int smmuv3_get_cr0_eventqen(SMMUv3State *s,
> +                                          SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].cr[0], CR0, EVENTQEN);
> +}
> +
> +static inline int smmuv3_get_cr0ack_eventqen(SMMUv3State *s,
> +                                             SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].cr0ack, CR0, EVENTQEN);
> +}
> +
> +/* Check if MSI is supported */
> +static inline bool smmu_msi_supported(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].idr[0], IDR0, MSI);
> +}
> +
> +/* Check if secure GERROR_IRQ_CFGx registers are writable */
> +static inline bool smmu_gerror_irq_cfg_writable(SMMUv3State *s,
> +                                                SMMUSecurityIndex sec_idx)
> +{
> +    if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
> +        return false;
> +    }
> +
> +    bool ctrl_en = FIELD_EX32(s->bank[sec_idx].irq_ctrl,
> +                              IRQ_CTRL, GERROR_IRQEN);
> +
> +    return !ctrl_en;
> +}
> +
> +/* Check if CMDQEN is disabled */
> +static bool smmu_cmdqen_disabled(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    int cr0_cmdqen = smmuv3_get_cr0_cmdqen(s, sec_idx);
> +    int cr0ack_cmdqen = smmuv3_get_cr0ack_cmdqen(s, sec_idx);
> +    return (cr0_cmdqen == 0 && cr0ack_cmdqen == 0);
> +}
> +
> +/* Check if CMDQ_BASE register is writable */
> +static bool smmu_cmdq_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    /* Check TABLES_PRESET - use NS bank as it's the global setting */
> +    if (FIELD_EX32(s->bank[SMMU_SEC_IDX_NS].idr[1], IDR1, QUEUES_PRESET)) {
> +        return false;
> +    }
> +
> +    return smmu_cmdqen_disabled(s, sec_idx);
> +}
> +
> +/* Check if EVENTQEN is disabled */
> +static bool smmu_eventqen_disabled(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    int cr0_eventqen = smmuv3_get_cr0_eventqen(s, sec_idx);
> +    int cr0ack_eventqen = smmuv3_get_cr0ack_eventqen(s, sec_idx);
> +    return (cr0_eventqen == 0 && cr0ack_eventqen == 0);
> +}
> +
> +static bool smmu_idr1_queue_preset(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].idr[1], IDR1, QUEUES_PRESET);
> +}
> +
> +/* Check if EVENTQ_BASE register is writable */
> +static bool smmu_eventq_base_writable(SMMUv3State *s, SMMUSecurityIndex sec_idx)
> +{
> +    /* Check TABLES_PRESET - use NS bank as it's the global setting */
> +    if (smmu_idr1_queue_preset(s, SMMU_SEC_IDX_NS)) {
> +        return false;
> +    }
> +
> +    return smmu_eventqen_disabled(s, sec_idx);
> +}
> +
> +static bool smmu_irq_ctl_evtq_irqen_disabled(SMMUv3State *s,
> +                                             SMMUSecurityIndex sec_idx)
> +{
> +    return FIELD_EX32(s->bank[sec_idx].irq_ctrl, IRQ_CTRL, EVENTQ_IRQEN);
> +}
> +
> +/* Check if EVENTQ_IRQ_CFGx is writable */
> +static bool smmu_eventq_irq_cfg_writable(SMMUv3State *s,
> +                                         SMMUSecurityIndex sec_idx)
> +{
> +    if (smmu_msi_supported(s, sec_idx)) {
> +        return false;
> +    }
> +
> +    return smmu_irq_ctl_evtq_irqen_disabled(s, sec_idx);
> +}
> +
>  static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> @@ -1405,7 +1513,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>              break;
>          }
>  
> -        if (queue_read(q, &cmd) != MEMTX_OK) {
> +        if (queue_read(q, &cmd, sec_idx) != MEMTX_OK) {
>              cmd_error = SMMU_CERROR_ABT;
>              break;
>          }
> @@ -1430,8 +1538,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
>              if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (sec_idx != SMMU_SEC_IDX_S) {
> +                    /* Secure Stream with Non-Secure command */
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>              }
>  
>              if (!sdev) {
> @@ -1450,8 +1561,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>              SMMUSIDRange sid_range;
>  
>              if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (sec_idx != SMMU_SEC_IDX_S) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>              }
>  
>              mask = (1ULL << (range + 1)) - 1;
> @@ -1469,8 +1582,10 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, SMMUSecurityIndex sec_idx)
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>  
>              if (CMD_SSEC(&cmd)) {
> -                cmd_error = SMMU_CERROR_ILL;
> -                break;
> +                if (sec_idx != SMMU_SEC_IDX_S) {
> +                    cmd_error = SMMU_CERROR_ILL;
> +                    break;
> +                }
>              }
>  
>              if (!sdev) {
> @@ -1624,6 +1739,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>          s->bank[reg_sec_idx].strtab_base = data & SMMU_STRTAB_BASE_RESERVED;
>          return MEMTX_OK;
>      case A_CMDQ_BASE:
> +        if (!smmu_cmdq_base_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          s->bank[reg_sec_idx].cmdq.base = data;
>          s->bank[reg_sec_idx].cmdq.log2size = extract64(
>              s->bank[reg_sec_idx].cmdq.base, 0, 5);
> @@ -1632,6 +1754,13 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>          }
>          return MEMTX_OK;
>      case A_EVENTQ_BASE:
> +        if (!smmu_eventq_base_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
>          s->bank[reg_sec_idx].eventq.base = data;
>          s->bank[reg_sec_idx].eventq.log2size = extract64(
>              s->bank[reg_sec_idx].eventq.base, 0, 5);
> @@ -1640,8 +1769,25 @@ static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
>          }
>          return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG0:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
>          s->bank[reg_sec_idx].eventq_irq_cfg0 = data;
>          return MEMTX_OK;
> +    case A_GERROR_IRQ_CFG0:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
> +            /* SMMU_(*_)_IRQ_CTRL.GERROR_IRQEN == 1: IGNORED this write */
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                         "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +        s->bank[reg_sec_idx].gerror_irq_cfg0 =
> +            data & SMMU_GERROR_IRQ_CFG0_RESERVED;
> +        return MEMTX_OK;
>      default:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s Unexpected 64-bit access to 0x%"PRIx64" (WI)\n",
> @@ -1666,7 +1812,15 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          s->bank[reg_sec_idx].cr[1] = data;
>          return MEMTX_OK;
>      case A_CR2:
> -        s->bank[reg_sec_idx].cr[2] = data;
> +        if (smmuv3_is_smmu_enabled(s, reg_sec_idx)) {
> +            /* Allow write: SMMUEN is 0 in both CR0 and CR0ACK */
> +            s->bank[reg_sec_idx].cr[2] = data;
> +        } else {
> +            /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CR2 write ignored: register is read-only when "
> +                          "CR0.SMMUEN or CR0ACK.SMMUEN is set\n");
> +        }
>          return MEMTX_OK;
>      case A_IRQ_CTRL:
>          s->bank[reg_sec_idx].irq_ctrl = data;
> @@ -1680,14 +1834,28 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          smmuv3_cmdq_consume(s, reg_sec_idx);
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> -        s->bank[reg_sec_idx].gerror_irq_cfg0 =
> -            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32, data);
> -        return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0 + 4:
> -        s->bank[reg_sec_idx].gerror_irq_cfg0 =
> -            deposit64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32, data);
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG0 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_GERROR_IRQ_CFG0_RESERVED;
> +        if (reg_offset == A_GERROR_IRQ_CFG0) {
> +            s->bank[reg_sec_idx].gerror_irq_cfg0 = deposit64(
> +                s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32, data);
> +        } else {
> +            s->bank[reg_sec_idx].gerror_irq_cfg0 = deposit64(
> +                s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32, data);
> +        }
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_gerror_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "GERROR_IRQ_CFG1 write ignored: "
> +                          "register is RO when IRQ enabled\n");
> +            return MEMTX_OK;
> +        }
>          s->bank[reg_sec_idx].gerror_irq_cfg1 = data;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG2:
> @@ -1735,60 +1903,106 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          }
>          return MEMTX_OK;
>      case A_CMDQ_BASE: /* 64b */
> -        s->bank[reg_sec_idx].cmdq.base =
> -            deposit64(s->bank[reg_sec_idx].cmdq.base, 0, 32, data);
> -        s->bank[reg_sec_idx].cmdq.log2size =
> -            extract64(s->bank[reg_sec_idx].cmdq.base, 0, 5);
> -        if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
> -            s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
> -        }
> -        return MEMTX_OK;
>      case A_CMDQ_BASE + 4: /* 64b */
> -        s->bank[reg_sec_idx].cmdq.base =
> -            deposit64(s->bank[reg_sec_idx].cmdq.base, 32, 32, data);
> -        return MEMTX_OK;
> +        if (!smmu_cmdq_base_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
> +        if (reg_offset == A_CMDQ_BASE) {
> +            s->bank[reg_sec_idx].cmdq.base = deposit64(
> +                s->bank[reg_sec_idx].cmdq.base, 0, 32, data);
> +
> +            s->bank[reg_sec_idx].cmdq.log2size = extract64(
> +                s->bank[reg_sec_idx].cmdq.base, 0, 5);
> +            if (s->bank[reg_sec_idx].cmdq.log2size > SMMU_CMDQS) {
> +                s->bank[reg_sec_idx].cmdq.log2size = SMMU_CMDQS;
> +            }
> +        } else {
> +            s->bank[reg_sec_idx].cmdq.base = deposit64(
> +                s->bank[reg_sec_idx].cmdq.base, 32, 32, data);
> +        }
> +
>          return MEMTX_OK;
>      case A_CMDQ_PROD:
>          s->bank[reg_sec_idx].cmdq.prod = data;
>          smmuv3_cmdq_consume(s, reg_sec_idx);
>          return MEMTX_OK;
>      case A_CMDQ_CONS:
> +        if (!smmu_cmdqen_disabled(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "CMDQ_CONS write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
>          s->bank[reg_sec_idx].cmdq.cons = data;
>          return MEMTX_OK;
>      case A_EVENTQ_BASE: /* 64b */
> -        s->bank[reg_sec_idx].eventq.base =
> -            deposit64(s->bank[reg_sec_idx].eventq.base, 0, 32, data);
> -        s->bank[reg_sec_idx].eventq.log2size =
> -            extract64(s->bank[reg_sec_idx].eventq.base, 0, 5);
> -        if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
> -            s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
> -        }
> -        s->bank[reg_sec_idx].eventq.cons = data;
> -        return MEMTX_OK;
>      case A_EVENTQ_BASE + 4:
> -        s->bank[reg_sec_idx].eventq.base =
> -            deposit64(s->bank[reg_sec_idx].eventq.base, 32, 32, data);
> -        return MEMTX_OK;
> +        if (!smmu_eventq_base_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_BASE write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_QUEUE_BASE_RESERVED;
> +        if (reg_offset == A_EVENTQ_BASE) {
> +            s->bank[reg_sec_idx].eventq.base = deposit64(
> +                s->bank[reg_sec_idx].eventq.base, 0, 32, data);
> +
> +            s->bank[reg_sec_idx].eventq.log2size = extract64(
> +                s->bank[reg_sec_idx].eventq.base, 0, 5);
> +            if (s->bank[reg_sec_idx].eventq.log2size > SMMU_EVENTQS) {
> +                s->bank[reg_sec_idx].eventq.log2size = SMMU_EVENTQS;
> +            }
> +        } else {
> +            s->bank[reg_sec_idx].eventq.base = deposit64(
> +                s->bank[reg_sec_idx].eventq.base, 32, 32, data);
> +        }
>          return MEMTX_OK;
>      case A_EVENTQ_PROD:
> +        if (!smmu_eventqen_disabled(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_PROD write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
>          s->bank[reg_sec_idx].eventq.prod = data;
>          return MEMTX_OK;
>      case A_EVENTQ_CONS:
>          s->bank[reg_sec_idx].eventq.cons = data;
>          return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG0: /* 64b */
> -        s->bank[reg_sec_idx].eventq_irq_cfg0 =
> -            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32, data);
> -        return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG0 + 4:
> -        s->bank[reg_sec_idx].eventq_irq_cfg0 =
> -            deposit64(s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32, data);
> -        return MEMTX_OK;
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG0 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
> +
> +        data &= SMMU_EVENTQ_IRQ_CFG0_RESERVED;
> +        if (reg_offset == A_EVENTQ_IRQ_CFG0) {
> +            s->bank[reg_sec_idx].eventq_irq_cfg0 = deposit64(
> +                s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32, data);
> +        } else {
> +            s->bank[reg_sec_idx].eventq_irq_cfg0 = deposit64(
> +                s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32, data);
> +        }
>          return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG1:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG1 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
>          s->bank[reg_sec_idx].eventq_irq_cfg1 = data;
>          return MEMTX_OK;
>      case A_EVENTQ_IRQ_CFG2:
> +        if (!smmu_eventq_irq_cfg_writable(s, reg_sec_idx)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "EVENTQ_IRQ_CFG2 write ignored: register is RO\n");
> +            return MEMTX_OK;
> +        }
>          s->bank[reg_sec_idx].eventq_irq_cfg2 = data;
>          return MEMTX_OK;
>      case A_S_INIT_ALIAS:
> @@ -1848,6 +2062,11 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>      uint32_t reg_offset = offset & 0xfff;
>      switch (reg_offset) {
>      case A_GERROR_IRQ_CFG0:
> +        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
> +        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
>          *data = s->bank[reg_sec_idx].gerror_irq_cfg0;
>          return MEMTX_OK;
>      case A_STRTAB_BASE:
> @@ -1859,6 +2078,13 @@ static MemTxResult smmu_readll(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_BASE:
>          *data = s->bank[reg_sec_idx].eventq.base;
>          return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG0:
> +        /* MSI support is depends on the register's security domain */
> +        if (!smmu_msi_supported(s, reg_sec_idx)) {
> +            *data = 0;
> +            return MEMTX_OK;
> +        }
> +
>          *data = s->bank[reg_sec_idx].eventq_irq_cfg0;
>          return MEMTX_OK;
>      default:
> @@ -1917,16 +2143,31 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>          *data = s->bank[reg_sec_idx].gerrorn;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0: /* 64b */
> -        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32);
> -        return MEMTX_OK;
>      case A_GERROR_IRQ_CFG0 + 4:
> -        *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32);
> -        return MEMTX_OK;
> +        /* SMMU_(*_)GERROR_IRQ_CFG0 BOTH check SMMU_IDR0.MSI */
> +        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
> +
> +        if (reg_offset == A_GERROR_IRQ_CFG0) {
> +            *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 0, 32);
> +        } else {
> +            *data = extract64(s->bank[reg_sec_idx].gerror_irq_cfg0, 32, 32);
> +        }
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG1:
> +        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
>          *data = s->bank[reg_sec_idx].gerror_irq_cfg1;
>          return MEMTX_OK;
>      case A_GERROR_IRQ_CFG2:
> +        if (!smmu_msi_supported(s, SMMU_SEC_IDX_NS)) {
> +            *data = 0; /* RES0 */
> +            return MEMTX_OK;
> +        }
>          *data = s->bank[reg_sec_idx].gerror_irq_cfg2;
>          return MEMTX_OK;
>      case A_STRTAB_BASE: /* 64b */
> @@ -1962,6 +2203,33 @@ static MemTxResult smmu_readl(SMMUv3State *s, hwaddr offset,
>      case A_EVENTQ_CONS:
>          *data = s->bank[reg_sec_idx].eventq.cons;
>          return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG0:
> +    case A_EVENTQ_IRQ_CFG0 + 4:
> +        if (!smmu_msi_supported(s, reg_sec_idx)) {
> +            *data = 0;
> +            return MEMTX_OK;
> +        }
> +
> +        if (reg_offset == A_EVENTQ_IRQ_CFG0) {
> +            *data = extract64(s->bank[reg_sec_idx].eventq_irq_cfg0, 0, 32);
> +        } else {
> +            *data = extract64(s->bank[reg_sec_idx].eventq_irq_cfg0, 32, 32);
> +        }
> +        return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG1:
> +        if (!smmu_msi_supported(s, reg_sec_idx)) {
> +            *data = 0;
> +            return MEMTX_OK;
> +        }
> +        *data = s->bank[reg_sec_idx].eventq_irq_cfg1;
> +        return MEMTX_OK;
> +    case A_EVENTQ_IRQ_CFG2:
> +        if (!smmu_msi_supported(s, reg_sec_idx)) {
> +            *data = 0;
> +            return MEMTX_OK;
> +        }
> +        *data = s->bank[reg_sec_idx].eventq_irq_cfg2;
> +        return MEMTX_OK;
>      case A_S_INIT_ALIAS:
>          *data = 0;
>          return MEMTX_OK;


