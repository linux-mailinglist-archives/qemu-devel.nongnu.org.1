Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22598A7D4E5
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 09:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gWT-0006wK-4P; Mon, 07 Apr 2025 03:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gWG-0006tB-4n
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gW8-0005qZ-1W
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+dcPKQdMi9vGFUDRiaSF2WuU16lA3M4+P/Gid8xCOv4=;
 b=JOAxZQ6KXEdqpg6S9fqS08qcQQ7IV3NJptutVDxJyXexdLum5RxHe24+KSdX2Tdzq5iIG8
 OMa2ScAPxR+mXjiF9dUhZFf7x3gFvTIud4sEaoBV0l9yY1hkyP6hDTjvaaBR/s5L5ixX0d
 vzusFtb6mH4O6Ove363QAE/zFCe95lA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-fmDSDARzPgaG8SN8BHv6AQ-1; Mon, 07 Apr 2025 03:03:32 -0400
X-MC-Unique: fmDSDARzPgaG8SN8BHv6AQ-1
X-Mimecast-MFC-AGG-ID: fmDSDARzPgaG8SN8BHv6AQ_1744009411
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so22343605e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 00:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009411; x=1744614211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+dcPKQdMi9vGFUDRiaSF2WuU16lA3M4+P/Gid8xCOv4=;
 b=VscfyiZiiXMEpem6v0CrjyD5HnXTWeE55O6kV5mEfxbFxxU8Z0lh8pPOmpZwW4qcNk
 cMby75w25sDJ/t4dY+7sGa+ZEqPJe51xanYwi5K/AQfv0o3RZYkDuXX43hbn98AIAHhl
 ZdNSvaTNXGbdxJhvMwKsZY2F5UhXQgPb0p5R9iQ+zLeNpP9autGeX0Ze34WJfyQD6da/
 7Ckwd0lfKyUa/iemXWPwq+suTq/nHt+MknqylJhgCu1e2ANbTVArVzqP+/+nJvyoIsMU
 LqeKeDmSTxBdx/GIrF7xRIgXC16ev6zSLJAihOpFNAcqovEQZ1mq9mQaVWeRcurFZtAn
 CwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7YzD6ockcgTaWsHE2TYGEvLHlUKP+gGw7Jnqo3qfvsLuFp1pdQPRHJDWe1+8dj5KOoOIn8oBHcScq@nongnu.org
X-Gm-Message-State: AOJu0Yx+tHPCViRopx++fn6xdz5Cjfh4RRT02O9oX8dZxCOmW98BlD87
 Qi7iFef8fjM5xkI5zxMU2ZEvyFg2vUV3FsHNdEn1LMc81zpZZauh4Sd7zuzlNx5kpuxlpG+XGaX
 vC0qsR9cinwjoaUYLp794LIzZJjaIQ60E1cVZYDBj3GpGtJNHVdUQ
X-Gm-Gg: ASbGncsR13pWIkeSp/AqgQjG65qZRTanhNPr+4a7JAPEaFBSwEgljHmQjkju1iAJtn3
 dWUeJJIBQbyzz3JVKPZXEk4eCjlleGTE9AULcjRJByCgXm6ao9yvbKFGqemduCrR5MPkUGG29y9
 AFD4Rygn0YJGtb2wyAAb4tR60HjUm47a4JaCRqFXTw0r6yz2nWxVsOesiuLjMT0y8wrNXkk0/zo
 pjIIIIfVTdR9ljabMn8riWpubUGB7/lJh/eghJ8S6S0gHOzffQp8iHjpgsGp1ehMzYEq9lvNXhw
 sKf5w/XORqlZoBPxs4Y+NgUhNBXFLlo68oZN+w+cYQp2UBymwLWB8A==
X-Received: by 2002:a5d:5f43:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-39d6fce11f5mr5881886f8f.36.1744009410798; 
 Mon, 07 Apr 2025 00:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI8oO5d/rmNnfmTU1R0wY4Vm26eFT+t28JxFh3d6vfQHX162QYB77ilXlzAAjyuvWN5dut6A==
X-Received: by 2002:a5d:5f43:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-39d6fce11f5mr5881862f8f.36.1744009410443; 
 Mon, 07 Apr 2025 00:03:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a895fsm120258285e9.13.2025.04.07.00.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:03:29 -0700 (PDT)
Message-ID: <1a7f1d26-279d-4bb4-b5d4-6f28c24e2cc2@redhat.com>
Date: Mon, 7 Apr 2025 09:03:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 27/37] vfio: Make
 vfio_devices_query_dirty_bitmap() static
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-28-clg@redhat.com>
 <74f8e5b1-a52e-49b3-b69e-52b3b59fcfd1@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <74f8e5b1-a52e-49b3-b69e-52b3b59fcfd1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/25 14:43, Avihai Horon wrote:
> 
> On 26/03/2025 9:51, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> vfio_devices_query_dirty_bitmap() is only used in "container-base.c".
>> Also, rename to vfio_container_devices_query_dirty_bitmap() to reflect
>> with the prefix 'vfio_container_devices_' that it simply loops over
>> the container's device list.
>>
>> This rename also frees the vfio_devices_query_dirty_bitmap() name
>> which we will reuse in the next changes.
> 
> Nit: this sentence can be dropped, vfio_devices_query_dirty_bitmap() is not used in the following changes IIUC.

I was referring to vfio_container_query_dirty_bitmap() but I agree
the sentence is not that useful. Will drop.

>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 

Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.



