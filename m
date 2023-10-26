Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 318DC7D842A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 16:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw0v8-0004Nm-Qc; Thu, 26 Oct 2023 10:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qw0ut-0004Lx-GE
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 10:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qw0un-0007Ij-Os
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698328848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrDJT1U/pfe2uQ++Wb+uc0ItMbxva/pUiv5adQPlCqE=;
 b=ZV/CTbvc0/BgyCh9OFnWwQMS62HVG4KEU0BH8h2mCE0Z+mw5UD5NxR1r473aazLTbS80Wz
 vVkE13pZ9l93osn3VLAj8x+S+RDicGvm2YeIESWuW+D6yphAzCMoJKiQWAInXhWFvzKAva
 iUhSh1uaP8ohJxzoXhfWUQxziTnRd4U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-QQrRY-LtOq2NJ8TU6MbCpA-1; Thu, 26 Oct 2023 10:00:36 -0400
X-MC-Unique: QQrRY-LtOq2NJ8TU6MbCpA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66cfda4c191so14029976d6.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 07:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698328835; x=1698933635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NrDJT1U/pfe2uQ++Wb+uc0ItMbxva/pUiv5adQPlCqE=;
 b=b4pmA9yUnblaSF1eNOMTmgY4f5477kk7g7vjZgq4/H/EBjyhxqRrnrVYhOeUczhRuR
 Cj8Hzv/1pE3Yd5eSqBr4Jwr5K9XwFfegFf93ETkXjFsEy1rtcBtdCt7pA+Rj69bK0Xgs
 KaK2jEUeudPkhmBx7Nrx3Q5PBxZdWqN2pKRN4CpwawUE34qGLtSPHP1GCGEAlPlLp70p
 SmSy9nVDPTV9gQ3/vpfegEfyQyT8NamZ/wTVUMqAUD/SD1vGXnlq2k+FJ5kYM8r6UmTB
 AkjgUXU9z+r5HeWcLsC+WXVe37Rr1xowpoQq8kbcLEdZIOp1jHcoQ5p6PxTklm3utmop
 vIFQ==
X-Gm-Message-State: AOJu0Ywf+l6fjpwVGY2/gAvqK7pAL/JAFWqpU72kKSNd4k9FfY/PLb7z
 YBAnidOgzzzpRVg/pyopWnxkTe/XHli744/BdyXU+vMRapnyb62nE5eM9iVEX0d3Hr9OrHMPODB
 Dqn0+rhScsO/b8d9Twa4W13oI43a2pWp818hUUWxEj/9Sp4E4SHvC1URcRP21H0FLKTNP
X-Received: by 2002:a05:6214:1c09:b0:663:95d0:a50b with SMTP id
 u9-20020a0562141c0900b0066395d0a50bmr24953288qvc.30.1698328835090; 
 Thu, 26 Oct 2023 07:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ6RHh7f+POJrWN4K2vLBgKu/ViXcsxt6VWJlcrQXquXNH2W0MuU745cqkN0iiY9kRXEzi0g==
X-Received: by 2002:a05:6214:1c09:b0:663:95d0:a50b with SMTP id
 u9-20020a0562141c0900b0066395d0a50bmr24953206qvc.30.1698328834544; 
 Thu, 26 Oct 2023 07:00:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a056214118600b0066d132b1c8bsm5122782qvv.102.2023.10.26.07.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 07:00:34 -0700 (PDT)
Message-ID: <8a9d26d0-ccb4-448b-9fc2-d7ce521646ae@redhat.com>
Date: Thu, 26 Oct 2023 16:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20231026070636.1165037-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026070636.1165037-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/26/23 09:06, Cédric Le Goater wrote:
> Hello,
> 
> This series fixes a buffer overrun in VFIO. The buffer used in
> vfio_realize() by qemu_uuid_unparse() is too small, UUID_FMT_LEN lacks
> one byte for the trailing NUL.
> 
> Instead of adding + 1, as done elsewhere, the changes introduce a
> UUID_STR_LEN define for the correct size and use it where required.

Cc: qemu-stable@nongnu.org # 8.1+

I propose to take this series in vfio-next if no one objects.

Thanks,

C.


> 
> Thanks,
> 
> C.
> 
> Changes in v2:
>   - removal of UUID_FMT_LEN
> 
> Cédric Le Goater (3):
>    util/uuid: Add UUID_STR_LEN definition
>    vfio/pci: Fix buffer overrun when writing the VF token
>    util/uuid: Remove UUID_FMT_LEN
> 
>   include/qemu/uuid.h              | 2 +-
>   block/parallels-ext.c            | 2 +-
>   block/vdi.c                      | 2 +-
>   hw/core/qdev-properties-system.c | 2 +-
>   hw/hyperv/vmbus.c                | 4 ++--
>   hw/vfio/pci.c                    | 2 +-
>   migration/savevm.c               | 4 ++--
>   tests/unit/test-uuid.c           | 2 +-
>   util/uuid.c                      | 2 +-
>   9 files changed, 11 insertions(+), 11 deletions(-)
> 


