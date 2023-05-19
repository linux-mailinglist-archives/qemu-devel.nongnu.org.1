Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EB709021
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 09:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzuBe-0007SD-Hf; Fri, 19 May 2023 03:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzuBY-0007QP-SO
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzuBW-0005gs-Ad
 for qemu-devel@nongnu.org; Fri, 19 May 2023 03:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684479953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0qGAB7USPM54ODgaWUWL5AVe/iVbhTHkCRpc8l4VTA=;
 b=bRRvG+bm5u7+QcKS+iPufOVXcQjZ3C4INz4vKt2BIMOQCDBlDxrVFwtoR6rvjcN2HWZBSu
 6Pn74ClanWsRn+FMth1XXNDQfUwnFn18gS8d3+1bhXkCmH97s6ca77V5ifh/ltiA52cG5Q
 JT6ylo6I2S2xjsppd3XuejjVQnk19ks=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-hJ2uF_vYNZGaWThIHRLL_g-1; Fri, 19 May 2023 03:05:51 -0400
X-MC-Unique: hJ2uF_vYNZGaWThIHRLL_g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso1978602e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 00:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684479948; x=1687071948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0qGAB7USPM54ODgaWUWL5AVe/iVbhTHkCRpc8l4VTA=;
 b=a5zgvCU2BmcPpeIRh9e8XXtZM518LqCPjabOCTmPp6iU79tFMzXUBmsLv6UVsQxp1v
 4cd1+rEP9aaNbi9o6b7sJlCI6SxxPX3QsKE1aBwx9p11Y8vlKVXK3fkjk9ux948goF43
 E3dhGlrZvVKErzWMjWJwBKZukvsiZrqoDwfTepiurv3CJIwbJ3IiLmezxYr2E74Rsa/x
 4OLVbOsAXSAhyyaNB/4HkKfucMpmQfqik3ib5JNaXOePS//GLM5WtuGn2nq4CqqsXqkx
 93sEybxW66O6DV8PFW6Eepr3u2HrvqxHzzFDysezVuIMl64KBnyaGnXpSShxQOc++xwf
 /SZQ==
X-Gm-Message-State: AC+VfDxWhn3ea/OiYFFD53zC66n0AlYZqaYE6CMYbA/ehkRwY5fEbq4g
 8Y9V7J/kogGPUqT85/Nl00aQx/Ndh6KqdvJnCHDIq9VWxa/3BAdfLZN7TGBCepIferMNvmtjKS8
 hwVJCY56PTpk4G/Y=
X-Received: by 2002:ac2:5a4d:0:b0:4ed:cb37:7d8c with SMTP id
 r13-20020ac25a4d000000b004edcb377d8cmr416264lfn.67.1684479948171; 
 Fri, 19 May 2023 00:05:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cU4cnan/0cKk4e5auz9IV17m/lTaoN5Aq+j334HaBu/UQzc/6Gt22HWPqxbuP7LFdr0P5Rg==
X-Received: by 2002:ac2:5a4d:0:b0:4ed:cb37:7d8c with SMTP id
 r13-20020ac25a4d000000b004edcb377d8cmr416249lfn.67.1684479947771; 
 Fri, 19 May 2023 00:05:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 24-20020ac24858000000b004cb43eb09dfsm496899lfy.123.2023.05.19.00.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 00:05:47 -0700 (PDT)
Date: Fri, 19 May 2023 03:05:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <20230519030515-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
 <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Apr 23, 2023 at 05:20:13PM +0100, Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v5:
> - Much simpler identification of the entry to modify (Ira)
> - Use CXL_CACHE_LINE_SIZE instead of 64. (Philippe)
> - Use memory_region_size() instead of accessing directly. (Michael)
> - Rename unused len parameter len_unused to make it clear that (Fan)
>   for a fixed length input payload, this parameter has already been
>   checked so the function need not do anything with it.
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 37 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 120 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6c476ad7f4..e3401b6be8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -65,6 +65,7 @@ enum {
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -512,6 +513,85 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len_unused)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    struct clear_poison_pl {
> +        uint64_t dpa;
> +        uint8_t data[64];
> +    };
> +    CXLPoison *ent;
> +    uint64_t dpa;
> +
> +    struct clear_poison_pl *in = (void *)cmd->payload;
> +
> +    dpa = ldq_le_p(&in->dpa);
> +    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline) {
> +        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +    }
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
> +            break;
> +        }
> +    }
> +    if (!ent) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    QLIST_REMOVE(ent, node);
> +    ct3d->poison_list_cnt--;
> +
> +    if (dpa > ent->start) {
> +        CXLPoison *frag;
> +        /* Cannot overflow as replacing existing entry */
> +
> +        frag = g_new0(CXLPoison, 1);
> +
> +        frag->start = ent->start;
> +        frag->length = dpa - ent->start;
> +        frag->type = ent->type;
> +
> +        QLIST_INSERT_HEAD(poison_list, frag, node);
> +        ct3d->poison_list_cnt++;
> +    }
> +
> +    if (dpa + CXL_CACHE_LINE_SIZE < ent->start + ent->length) {
> +        CXLPoison *frag;
> +
> +        if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +            cxl_set_poison_list_overflowed(ct3d);
> +        } else {
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = dpa + CXL_CACHE_LINE_SIZE;
> +            frag->length = ent->start + ent->length - frag->start;
> +            frag->type = ent->type;
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +    }
> +    /* Any fragments have been added, free original entry */
> +    g_free(ent);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -543,6 +623,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
>          cmd_media_inject_poison, 8, 0 },
> +    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> +        cmd_media_clear_poison, 72, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ab600735eb..a247f506b7 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }

Fails build:

https://gitlab.com/mstredhat/qemu/-/jobs/4313193004


> +
> +    if (vmr) {
> +        if (dpa_offset < memory_region_size(vmr)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= memory_region_size(vmr);
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +                        CXL_CACHE_LINE_SIZE);
> +    return true;
> +}
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>  {
>          ct3d->poison_list_overflowed = true;
> @@ -1168,6 +1204,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->get_lsa_size = get_lsa_size;
>      cvc->get_lsa = get_lsa;
>      cvc->set_lsa = set_lsa;
> +    cvc->set_cacheline = set_cacheline;
>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 32c234ea91..73328a52cf 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -298,6 +298,7 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -- 
> 2.37.2


