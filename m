Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63657568DB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQtF-0007xi-3s; Mon, 17 Jul 2023 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLQsq-0007to-2C
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLQsn-0006aO-Ly
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689610531;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5o2DsqY4HYqcz+dnGbRVOQ99jJpjBPU/TtdtDBcJeMI=;
 b=hvS6DAa/I8tmJsdif+gRRsxRAlqbbmvdpKopTmZoRTIWpnr+zAsi4tupGlSzjVOT10L0az
 sZyIYuPiiorIhUl0CEqRYPTFQ+a5XuMhheAqeigQZEiyt0r94VzR1AUMlimBghTACzl7Dx
 RKEJLtfj7A/UJ2mHoGryd+smBQnuE74=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-UiLSe_eCN9uy1scAom05Ug-1; Mon, 17 Jul 2023 12:15:30 -0400
X-MC-Unique: UiLSe_eCN9uy1scAom05Ug-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4409ff60c89so606210137.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689610530; x=1690215330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5o2DsqY4HYqcz+dnGbRVOQ99jJpjBPU/TtdtDBcJeMI=;
 b=DAABaWa/I3ip/wofMOumXE6u3YfIWqLjafGv6l7DdBXxdAzs/up9wMY0czCVxzV118
 uFQoDwf5OoFAZuxAt75OBvjO/SclVjD7oC4/ITkefMJefyonOuJynqjDXpZbWjhfHHjH
 Tr4+Q9gdwurzj0HL9HLUhPaZhr9to4mSySgrtQA1xmZz/8IkZ60iUXHQ2hZhJYZq+tDb
 sTY7mY2aqpzNxRxKkQUb2OfKwN+AcD/DI8OORyrh0HH2/ySst9Ofj46nkd+JAvEXUfSC
 vX32tSmJSPt5zCD/CXDQlhC649amXYiktrlGY1UaBKS9NGLWNwZWk62y81p6NXZcFMsC
 0nJA==
X-Gm-Message-State: ABy/qLZVWJgQ/gen2EEjW7rgATTk2+vLb+4sLi7Kcx9nKuhsrl6vYa8e
 HyekgzFOWJnlYpH1Rrb6/6jbv08+X2FjmR81IWv00S2ZMrqenZh4PPPknxem7yYNg0ckxTupDz5
 fnf7NTVh7SOAMYeI=
X-Received: by 2002:a67:e20b:0:b0:445:175d:680e with SMTP id
 g11-20020a67e20b000000b00445175d680emr5437106vsa.33.1689610529896; 
 Mon, 17 Jul 2023 09:15:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFEEixLuTRWjymKyPaf0bYAQ+THU2e39uB/SL8IwMlvbTdhFuoCJQyA20gKNcdszeRUBei0+A==
X-Received: by 2002:a67:e20b:0:b0:445:175d:680e with SMTP id
 g11-20020a67e20b000000b00445175d680emr5437078vsa.33.1689610529605; 
 Mon, 17 Jul 2023 09:15:29 -0700 (PDT)
Received: from [192.168.43.95] ([37.168.249.127])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a0cdb86000000b006300e1db3ecsm6396536qvk.141.2023.07.17.09.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 09:15:28 -0700 (PDT)
Message-ID: <be9d45dd-1b51-4ded-cb56-307cd1b241ad@redhat.com>
Date: Mon, 17 Jul 2023 18:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH for-8.1] hw/arm/smmu: Handle big-endian hosts correctly
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230717132641.764660-1-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230717132641.764660-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 7/17/23 15:26, Peter Maydell wrote:
> The implementation of the SMMUv3 has multiple places where it reads a
> data structure from the guest and directly operates on it without
> doing a guest-to-host endianness conversion.  Since all SMMU data
> structures are little-endian, this means that the SMMU doesn't work
> on a big-endian host.  In particular, this causes the Avocado test
>   machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
> to fail on an s390x host.
>
> Add appropriate byte-swapping on reads and writes of guest in-memory
> data structures so that the device works correctly on big-endian
> hosts.
>
> As part of this we constrain queue_read() to operate only on Cmd
> structs and queue_write() on Evt structs, because in practice these
> are the only data structures the two functions are used with, and we
> need to know what the data structure is to be able to byte-swap its
> parts correctly.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  hw/arm/smmu-common.c |  3 +--
>  hw/arm/smmuv3.c      | 39 +++++++++++++++++++++++++++++++--------
>  2 files changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 5ab9d45d58a..f35ae9aa22c 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -216,8 +216,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
>      dma_addr_t addr = baseaddr + index * sizeof(*pte);
>  
>      /* TODO: guarantee 64-bit single-copy atomicity */
> -    ret = dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte),
> -                          MEMTXATTRS_UNSPECIFIED);
> +    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
>  
>      if (ret != MEMTX_OK) {
>          info->type = SMMU_PTW_ERR_WALK_EABT;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 932f0096974..1e9be8e89af 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -102,20 +102,34 @@ static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>      trace_smmuv3_write_gerrorn(toggled & pending, s->gerrorn);
>  }
>  
> -static inline MemTxResult queue_read(SMMUQueue *q, void *data)
> +static inline MemTxResult queue_read(SMMUQueue *q, Cmd *cmd)
>  {
>      dma_addr_t addr = Q_CONS_ENTRY(q);
> +    MemTxResult ret;
> +    int i;
>  
> -    return dma_memory_read(&address_space_memory, addr, data, q->entry_size,
> -                           MEMTXATTRS_UNSPECIFIED);
> +    ret = dma_memory_read(&address_space_memory, addr, cmd, sizeof(Cmd),
> +                          MEMTXATTRS_UNSPECIFIED);
> +    if (ret != MEMTX_OK) {
> +        return ret;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(cmd->word); i++) {
> +        le32_to_cpus(&cmd->word[i]);
> +    }
> +    return ret;
>  }
>  
> -static MemTxResult queue_write(SMMUQueue *q, void *data)
> +static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>  {
>      dma_addr_t addr = Q_PROD_ENTRY(q);
>      MemTxResult ret;
> +    Evt evt = *evt_in;
> +    int i;
>  
> -    ret = dma_memory_write(&address_space_memory, addr, data, q->entry_size,
> +    for (i = 0; i < ARRAY_SIZE(evt.word); i++) {
> +        cpu_to_le32s(&evt.word[i]);
> +    }
> +    ret = dma_memory_write(&address_space_memory, addr, &evt, sizeof(Evt),
>                             MEMTXATTRS_UNSPECIFIED);
>      if (ret != MEMTX_OK) {
>          return ret;
> @@ -298,7 +312,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>  static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>                          SMMUEventInfo *event)
>  {
> -    int ret;
> +    int ret, i;
>  
>      trace_smmuv3_get_ste(addr);
>      /* TODO: guarantee 64-bit single-copy atomicity */
> @@ -311,6 +325,9 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>          event->u.f_ste_fetch.addr = addr;
>          return -EINVAL;
>      }
> +    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
> +        le32_to_cpus(&buf->word[i]);
> +    }
>      return 0;
>  
>  }
> @@ -320,7 +337,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
>                         CD *buf, SMMUEventInfo *event)
>  {
>      dma_addr_t addr = STE_CTXPTR(ste);
> -    int ret;
> +    int ret, i;
>  
>      trace_smmuv3_get_cd(addr);
>      /* TODO: guarantee 64-bit single-copy atomicity */
> @@ -333,6 +350,9 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
>          event->u.f_ste_fetch.addr = addr;
>          return -EINVAL;
>      }
> +    for (i = 0; i < ARRAY_SIZE(buf->word); i++) {
> +        le32_to_cpus(&buf->word[i]);
> +    }
>      return 0;
>  }
>  
> @@ -569,7 +589,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>          return -EINVAL;
>      }
>      if (s->features & SMMU_FEATURE_2LVL_STE) {
> -        int l1_ste_offset, l2_ste_offset, max_l2_ste, span;
> +        int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
>          dma_addr_t l1ptr, l2ptr;
>          STEDesc l1std;
>  
> @@ -593,6 +613,9 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>              event->u.f_ste_fetch.addr = l1ptr;
>              return -EINVAL;
>          }
> +        for (i = 0; i < ARRAY_SIZE(l1std.word); i++) {
> +            le32_to_cpus(&l1std.word[i]);
> +        }
>  
>          span = L1STD_SPAN(&l1std);
>  


