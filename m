Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D7173A176
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK0d-0003EK-Ia; Thu, 22 Jun 2023 09:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK0b-0003EB-Qo
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK0a-0002F7-1w
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687439155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8gDsDNYdXwL2I9GT9/GVOX6hRqWeZD+z+cTQiukgbM=;
 b=VAPzA6BD9/aFdrnfh1Bi9O1lydwsoPFVCusjbp4gPe4EW7LWa24qYdZNAhLv5E2c+hddzh
 mJVrSN10EvVv3K4u3Zx0HkvHXe56aKAZ6NQknEvsIZno9CJl0BKDwJe7E1y1dPKyVaxCdI
 oDI8UA3az9mvIMy3uB5UhrR63SLxKeQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-I1QUmLTPOvazILrpMBAq7g-1; Thu, 22 Jun 2023 09:05:52 -0400
X-MC-Unique: I1QUmLTPOvazILrpMBAq7g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-311292a0fe9so3496668f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439147; x=1690031147;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8gDsDNYdXwL2I9GT9/GVOX6hRqWeZD+z+cTQiukgbM=;
 b=OcLKUuQpTKn/mwPQw3QXLvQdtymiYHUX4ogzobqklN4nnkKqPyu2W/Lyrbg19VuVcq
 ULxMif65Ig3dWE35gpF427m2Ds4QhctIkm+5rlqg8FDhqjo0tRJbDwoq0bkIqIbj5iao
 +o6YWkyah1b8KrdLvpCB1I+9TWFj5Xyx6lGriHUw6PK26E9hddD8q+A0vkfQsmVZg9fF
 po+MfzU9XZIyIC58ENr/X5HZ6EJkKwPMXUu7hM4r4pHPXQXVSp2B/fdWvfRJNuB05GxB
 LvIALxs/pAX1yilUvSbiaQRJ0KCJBXi3tFdncZaA73SYFHBXWoieBcx4ghz3omanzyY9
 rvGw==
X-Gm-Message-State: AC+VfDyhhu6MPs48BuFNg7Mt3jgwMlZ122rYm4zYnQruMDWsPKR7+1ow
 0qpQ7sJfmV+XAvIL3N+om6zGKU21416G0kx2N1YjV7zzZVxNdsQZMBnP4rxi59eFgsq3Nrg4ATL
 P2ntiyp07ulf+Oe4=
X-Received: by 2002:a5d:4004:0:b0:30e:56d9:d7ac with SMTP id
 n4-20020a5d4004000000b0030e56d9d7acmr14609041wrp.35.1687439147721; 
 Thu, 22 Jun 2023 06:05:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7iXW0WyaWzD7yVi9ybWHifwyqRdA8JXrl/22oSSurdYDcKgIrrrkvinhI559BPNQsvmhSFqw==
X-Received: by 2002:a5d:4004:0:b0:30e:56d9:d7ac with SMTP id
 n4-20020a5d4004000000b0030e56d9d7acmr14609021wrp.35.1687439147362; 
 Thu, 22 Jun 2023 06:05:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adff0cb000000b003112d12a1ecsm6950156wro.98.2023.06.22.06.05.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:05:46 -0700 (PDT)
Message-ID: <9acf5fcc-f5d9-9f9f-2771-8af3b64b37f9@redhat.com>
Date: Thu, 22 Jun 2023 15:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230620195054.23929-3-lvivier@redhat.com>
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
> This memory is not correctly aligned and cannot be registered
> by vDPA and VFIO.
> 
> An error is reported for vhost-vdpa case:
> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
> 
> To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.
> 
> The RAM_PROTECTED flag has been introduced to skip memory
> region that looks like RAM but is not accessible via normal
> mechanims, including DMA.
> 
> See 56918a126a ("memory: Add RAM_PROTECTED flag to skip IOMMU mappings")
> 
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2141965
> 
> cc: peter.maydell@linaro.org
> cc: marcandre.lureau@redhat.com
> cc: eric.auger@redhat.com
> cc: mst@redhat.com
> cc: jasowang@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/tpm/tpm_crb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index ea930da545af..0a93c488f2fa 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -296,7 +296,7 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>   
>       memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
>           "tpm-crb-mmio", sizeof(s->regs));
> -    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> +    memory_region_init_ram_protected(&s->cmdmem, OBJECT(s),
>           "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
>   
>       memory_region_add_subregion(get_system_memory(),

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


