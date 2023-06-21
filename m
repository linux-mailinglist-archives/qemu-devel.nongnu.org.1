Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBFA7383BB
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwvg-00009m-2d; Wed, 21 Jun 2023 08:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qBwvb-0008WD-Ag
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qBwvY-0004jq-Uj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:27:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LCPHcu012671; Wed, 21 Jun 2023 12:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=da5ZlzRKiAH+tuWb5BtUT59hLuI+T8KyQ+hAsgsuzEA=;
 b=H44wHawS7DZwtAutQb15CaeETmlTZsqrxBKwa/l5rmN/VBuJM9N9zWO/ySm8mvfSRS6v
 plHNgMJUg6tB9fpl6z6akmYvpXs+hLafHO4r/9FQS0Y9TLeNPUKImxDJkHUljHIfhBaM
 LxCtzL/DyRTIKkax9DZu2cpOTiXzi/9OnEHzrrq9gfjv7qpc5S6AbfVzW46H6XsFgSnw
 ocebpykP3ie184+5K7nZXKIkIvUmbmlDy6+5SH+ze4lGLvm5cV+bYcw8lkY3mrLFY/pJ
 K97l4Z/rIL3P0Z+O6EMyPBejwHDk7mclqUu0p1lVr+xv16Mlc6iJCymPNxnJiM/Wlhqr cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc16tr1kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:27:08 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LCQK3f016080;
 Wed, 21 Jun 2023 12:27:08 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc16tr1k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:27:08 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35LAKEHw009590;
 Wed, 21 Jun 2023 12:27:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r94f6qde2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:27:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LCR5Ub56820054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 12:27:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DACB5805F;
 Wed, 21 Jun 2023 12:27:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67A2B58043;
 Wed, 21 Jun 2023 12:27:04 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 12:27:04 +0000 (GMT)
Message-ID: <e5b5f9d7-1272-a44f-372a-b70743be855f@linux.ibm.com>
Date: Wed, 21 Jun 2023 08:27:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] memory: introduce memory_region_init_ram_protected()
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-2-lvivier@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230620195054.23929-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gnwr9PvuzVDp3sfVo3OE9aj9HXBEjmtf
X-Proofpoint-ORIG-GUID: 1EV87vsdSgSUBX_OQ_kOcTKfxSDYakgT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210101
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 6/20/23 15:50, Laurent Vivier wrote:
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

but is inaccessible


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

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

