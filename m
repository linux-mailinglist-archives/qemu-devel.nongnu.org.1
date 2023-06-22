Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCE73A174
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK0C-00034x-AH; Thu, 22 Jun 2023 09:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK06-00034Q-0D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK04-00029Z-3Y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687439123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mFOrgtb6eyIBcNi/XQLmDrMBWrO17TcZtPO08qLGIU=;
 b=eceAZsUklcqjUHzQe93T6oUDlzmpxifns3ytwGtyw59u+g0kRTVK8tBbGDPNeFcoYdu22m
 zKJlnpH5n+FfGECYoAGt9ggmj+zmqhEiaWuL2J5a9/5DSB3iz1z5XehnC0BxnlqWq8JXhm
 hHf0cMPUC50o3huyzCWhUfr2iwQbz/U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-DMVn3e9bPAyrSpViYGWvcw-1; Thu, 22 Jun 2023 09:05:22 -0400
X-MC-Unique: DMVn3e9bPAyrSpViYGWvcw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b003507bso20909015e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439119; x=1690031119;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mFOrgtb6eyIBcNi/XQLmDrMBWrO17TcZtPO08qLGIU=;
 b=YINVreJngIkQr+m22Ypg4BY+SPbuau9QUV7abQDZ7VWQ0qsWXwUMz4aRhkohYJjArR
 O9/W8FMP/u+ylpyKErxBPmbMwTK1ZzaUk7R57HeRtNvi54ZeQPm3+lCHarFPad9V0pbo
 wxG54LJolKng69H9en/+c4VaOAebcNmQ07+4ZV6zz7ca9WyVojXAlsXOMxTwqZ3ud1Us
 FlulkZJXJA2FbacPNAdyQj90pVxKaKTebYbEcIXeNNYylNq+nN22ImaQJlbAd14kdpPp
 8xKkYpV9evkK+OCHkFTIBIZCBLgi8ynrCKqV83zkAFw1RaSSw2wxd1taF2+/lDWJ4X0d
 xhyQ==
X-Gm-Message-State: AC+VfDwdD7Iqi7ovGkz0MOr60mvpp85/dOasPbUg5F8fQF5zoiC1omEt
 PtDX9RbPhg3bqROQybxbXLqArIJwN4BClQQhK/t+IKiWajJGQProVmnOxaA3F3Km2/6Ptqnb7et
 hTgUTqbQe2JBUPfs=
X-Received: by 2002:a7b:cd10:0:b0:3f9:b79b:e74e with SMTP id
 f16-20020a7bcd10000000b003f9b79be74emr5828886wmj.22.1687439119275; 
 Thu, 22 Jun 2023 06:05:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GF9M6xNe6sHiQb0kEPSxP0xAyDQ4ibURJa+z4WnNiiJ8Q1De0N8qh/0Nw22b0mJRP48XiXw==
X-Received: by 2002:a7b:cd10:0:b0:3f9:b79b:e74e with SMTP id
 f16-20020a7bcd10000000b003f9b79be74emr5828866wmj.22.1687439118883; 
 Thu, 22 Jun 2023 06:05:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a7bc412000000b003f809461162sm7676698wmi.16.2023.06.22.06.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:05:18 -0700 (PDT)
Message-ID: <13a59065-a79b-95be-d3ef-dd7cb0e394e9@redhat.com>
Date: Thu, 22 Jun 2023 15:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] memory: introduce memory_region_init_ram_protected()
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-2-lvivier@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230620195054.23929-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 20.06.23 21:50, Laurent Vivier wrote:
> Commit 56918a126a ("memory: Add RAM_PROTECTED flag to skip IOMMU mappings")
> has introduced the RAM_PROTECTED flag to denote "protected" memory.
> 
> This flags is only used with qemu_ram_alloc_from_fd() for now.
> 
> To be able to register memory region with this flag, define
> memory_region_init_ram_protected() and declare the flag as valid in
> qemu_ram_alloc_internal() and qemu_ram_alloc().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   include/exec/memory.h | 33 +++++++++++++++++++++++++++++++++
>   softmmu/memory.c      | 33 +++++++++++++++++++++++++++------
>   softmmu/physmem.c     |  4 ++--
>   3 files changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 47c2e0221c35..d8760015c381 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1520,6 +1520,39 @@ void memory_region_init_iommu(void *_iommu_mr,
>                                 const char *name,
>                                 uint64_t size);
>   
> +/**
> + * memory_region_init_ram_protected - Initialize RAM memory region.  Accesses
> + *                                    into the region will modify memory
> + *                                    directly.
> + *
> + * The memory is created with the RAM_PROTECTED flag, for memory that
> + * looks and acts like RAM but inaccessible via normal mechanisms,
> + * including DMA.
> + *
> + * @mr: the #MemoryRegion to be initialized
> + * @owner: the object that tracks the region's reference count (must be
> + *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
> + * @name: name of the memory region
> + * @size: size of the region in bytes
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * This function allocates RAM for a board model or device, and
> + * arranges for it to be migrated (by calling vmstate_register_ram()
> + * if @owner is a DeviceState, or vmstate_register_ram_global() if
> + * @owner is NULL).
> + *
> + * TODO: Currently we restrict @owner to being either NULL (for
> + * global RAM regions with no owner) or devices, so that we can
> + * give the RAM block a unique name for migration purposes.
> + * We should lift this restriction and allow arbitrary Objects.
> + * If you pass a non-NULL non-device @owner then we will assert.
> + */
> +void memory_region_init_ram_protected(MemoryRegion *mr,
> +                                      Object *owner,
> +                                      const char *name,
> +                                      uint64_t size,
> +                                      Error **errp);
> +
>   /**
>    * memory_region_init_ram - Initialize RAM memory region.  Accesses into the
>    *                          region will modify memory directly.
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce7028..952c87277353 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -3551,16 +3551,18 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
>       }
>   }
>   
> -void memory_region_init_ram(MemoryRegion *mr,
> -                            Object *owner,
> -                            const char *name,
> -                            uint64_t size,
> -                            Error **errp)
> +static void memory_region_init_ram_flags(MemoryRegion *mr,
> +                                         Object *owner,
> +                                         const char *name,
> +                                         uint64_t size,
> +                                         uint32_t ram_flags,
> +                                         Error **errp)
>   {
>       DeviceState *owner_dev;
>       Error *err = NULL;
>   
> -    memory_region_init_ram_nomigrate(mr, owner, name, size, &err);
> +    memory_region_init_ram_flags_nomigrate(mr, owner, name, size, ram_flags,
> +                                           &err);
>       if (err) {
>           error_propagate(errp, err);
>           return;
> @@ -3575,6 +3577,25 @@ void memory_region_init_ram(MemoryRegion *mr,
>       vmstate_register_ram(mr, owner_dev);
>   }
>   
> +void memory_region_init_ram_protected(MemoryRegion *mr,
> +                                      Object *owner,
> +                                      const char *name,
> +                                      uint64_t size,
> +                                      Error **errp)
> +{
> +        memory_region_init_ram_flags(mr, owner, name, size, RAM_PROTECTED,
> +                                     errp);
> +}
> +
> +void memory_region_init_ram(MemoryRegion *mr,
> +                            Object *owner,
> +                            const char *name,
> +                            uint64_t size,
> +                            Error **errp)
> +{
> +        memory_region_init_ram_flags(mr, owner, name, size, 0, errp);
> +}
> +
>   void memory_region_init_rom(MemoryRegion *mr,
>                               Object *owner,
>                               const char *name,
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 6bdd944fe880..bf66c81e7255 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1978,7 +1978,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
>       Error *local_err = NULL;
>   
>       assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
> -                          RAM_NORESERVE)) == 0);
> +                          RAM_NORESERVE | RAM_PROTECTED)) == 0);
>       assert(!host ^ (ram_flags & RAM_PREALLOC));
>   
>       size = HOST_PAGE_ALIGN(size);
> @@ -2012,7 +2012,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>   RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
>                            MemoryRegion *mr, Error **errp)
>   {
> -    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
> +    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_PROTECTED)) == 0);
>       return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
>   }
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


