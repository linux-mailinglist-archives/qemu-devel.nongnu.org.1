Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11582AB39C8
	for <lists+qemu-devel@lfdr.de>; Mon, 12 May 2025 15:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETdU-00088W-5C; Mon, 12 May 2025 09:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uETdQ-00086z-Fi
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uETdO-0003Pf-ED
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747058157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jtiTe14ry/sNQlxojovf9iWHhnxleZPa+q6h5NIpexU=;
 b=YvJ1Odzy+FFjov97tmaEDG+BXCVorVqbHLsszf8yY8OIf3jZpNrOIaqfYyrThzyPdTp2zj
 FzrHXMjM4apwD7wEdgrsKDiWAA9dU6HenVkZ6Z+Z7GLWEuacXYnznozLfeR3Y5UgQXllF4
 wIvGq2JYKJENBQpN71CbpGFkFZ+jvUw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-sI4Ieyc1No6X9aU1hC9ZOQ-1; Mon, 12 May 2025 09:55:54 -0400
X-MC-Unique: sI4Ieyc1No6X9aU1hC9ZOQ-1
X-Mimecast-MFC-AGG-ID: sI4Ieyc1No6X9aU1hC9ZOQ_1747058153
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so21698565e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747058153; x=1747662953;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtiTe14ry/sNQlxojovf9iWHhnxleZPa+q6h5NIpexU=;
 b=cyQ+vFCQM+nBB6denm8fXiBGDZALGd1N2eCHRrtgV/DLbVlAn30M7kdemvLEr0lVGR
 688OutbwSJUIay8O7y5RqJWUyvRu3sPXUxQOcQO2cSOrPhdEP0gWUdY7pnfSta6DNsuX
 8Dq68auy9kJ+ILq0SMP/dUm8jfn0s8/ccZNj8H0/kyBUQtusdnrpd/Mru/WqiPzG38N+
 1ZndASk4Bba+2NtqdLHFPS5xSqDguQj3pe9C2aF1OVZnGUef0aku5mZkVVGlT6Goqi2k
 PwiYk7jGBRpurfis+Jf6AbpAIsvHGWwgXVGISdcuEsrzBTjWN7Zg+27k3nuF9ZQwzYQH
 7hJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79hUbuyyxiQpmGCSJtP1Ms4DlfbIExnMj8e4ThOgVninqo+y5y3DFsPeyPsv+ts6Th3slYZQsl29r@nongnu.org
X-Gm-Message-State: AOJu0YzNuH8Q4D5EL11B1lLpIs2gUcRm7Q1PSuz/YqflwFNXgHj12Dxr
 eET5tftUWI33azQLWbLKU3dZsY4Q0Bs7dhfTknJjMDO4W72lXeojnaBger89P75S0MrmBQu6siK
 Rp3JzAx2OBeEZGC++WgCSRQl7lDNuNmn9xsCBBLOs23XTr6nUG7Fi
X-Gm-Gg: ASbGncuZlTZsYnRDRYf3O7U7WMzbMhbu49h1DsGQnLYNx2XNCeeDXD1xUxTu6VcraIL
 UcfJJtO1SJQTdQUhAJWkxf6npWsmnR9vkTQbpEpqE0wxEjnghqxxXviovwIoXYrX0VP0bpY5Jen
 VuYBtZ2lTDFlOuexxhXzwmWqcUgnBrtQsUwXjKdXf3uSUbXy5B2brwxIK5bG5jxZ+eaIXAhfD7H
 rh9gBxcaL/m2AwNgl4kJqT+Cpa7s+fZk9A/cAwHXaqPLyzM3JIzkxnNOZaVUBT8Clp208cQcvY7
 SYNhurh92ZavObTKPr7DRcn9Bf7aVMEWBYDJkdsBbc1UNmcRaA==
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442d6dc5328mr98219455e9.23.1747058153356; 
 Mon, 12 May 2025 06:55:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr4kU6jd3DC9ZGqblH5qAQtWDEWnUXFjxCqw+KG5651Lk+Mm0NUaHxdPn2FdtV0JK5+g5+jw==
X-Received: by 2002:a05:600c:a44:b0:43c:ec4c:25b1 with SMTP id
 5b1f17b1804b1-442d6dc5328mr98219135e9.23.1747058152850; 
 Mon, 12 May 2025 06:55:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57de0b2sm12743860f8f.19.2025.05.12.06.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 06:55:52 -0700 (PDT)
Message-ID: <80302f24-0037-458c-99c6-a1c88a17b570@redhat.com>
Date: Mon, 12 May 2025 15:55:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 0/6] Report vfio-ap configuration changes
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250509163645.33050-1-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250509163645.33050-1-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Rorie,

On 5/9/25 18:36, Rorie Reyes wrote:
> Changelog:
> v8:
> - fixed windows cross-compile build
> - moved /hw/vfio/ap-stub.c to /hw/s390x/ap-stub.c
> - updated the use of stub file to MAINTAINERS to reflect new location
> - removed if_false for 'CONFIG_VFIO_AP' statement from /hw/vfio/meson.build
> - added if_false for 'CONFIG_VFIO_AP' to use ap-stub.c in /hw/s390x/meson.build
> - all those changes still address '--without-default-devices' issue from v5


v8 fixed the build break. There is still one little issue on the
last patch.

No need to resend the linux headers update since they were merged.

Thanks,

C.



> v7:
> - Dropped initial commit for linux-header file vfio.h since I created two new commits
> to address the changes made in v6
> - Moved patches 6 and 7 to the beginning of the series after dropping the first patch
>     - Because I dropped the initial commit for linux-header file vfio.h, I had to add
> VFIO_AP_CFG_CHG_IRQ_INDEX
> - Resyncing latest to v6.15-rc3
> - Still need Thomas Huth's review of v5 changes for patch 6/6
> 
> v6:
> - Updating the update-linux-headers script to address kernel commit change 8a14
> - Update headers to retrieve uapi information for vfio-ap for update to Linux v6.15-rc1
> - Still need Thomas Huth's review of v5 changes for patch 7/7 (see below)
> 
> v5:
> - configuring using the '--without-default-devices' fails when building the code
> - created a stub file for functions ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event
> - add if_false for 'CONFIG_VFIO_AP' use ap-stub.c in meson.build
> - add the use of the stub file to MAINTAINERS since it's a new file
> 
> v4:
> - allocating cfg_chg_event before inserting into the queue
> - calling nt0_have_event in if loop to check if there are any
> elemenets in the queue, then calling QTAILQ_FIRST when the check
> passes
> - moving memset() after the check
> 
> v3:
> - changes that were made to patch 3/5 should have been made in
> patch 2/5
> 
> v2:
> - removed warnings that weren't needed
> - added unregister function
> - removed whitelines
> - changed variable names for consistency
> - removed rc variable and returning 1 or 0 outright
> - reversed logics for if statements
> - using g_free() instead of free()
> - replaced hardcoded numeric values by defining them with #define
> in the header
> 
> --------------------------------------------------------------------------
> This patch series creates and registers a handler that is called when
> userspace is notified by the kernel that a guest's AP configuration has
> changed. The handler in turn notifies the guest that its AP configuration
> has changed. This allows the guest to immediately respond to AP
> configuration changes rather than relying on polling or some other
> inefficient mechanism for detecting config changes.
> 
> Rorie Reyes (6):
>    linux-header: update-linux-header script changes
>    linux-headers: Update to Linux v6.15-rc3
>    hw/vfio/ap: notification handler for AP config changed event
>    hw/vfio/ap: store object indicating AP config changed in a queue
>    hw/vfio/ap: Storing event information for an AP configuration change
>      event
>    s390: implementing CHSC SEI for AP config change
> 
>   MAINTAINERS                                   |   1 +
>   hw/s390x/ap-stub.c                            |  23 ++++
>   hw/s390x/meson.build                          |   1 +
>   hw/vfio/ap.c                                  |  82 +++++++++++
>   include/hw/s390x/ap-bridge.h                  |  22 +++
>   include/standard-headers/asm-x86/setup_data.h |   4 +-
>   include/standard-headers/drm/drm_fourcc.h     |  41 ++++++
>   include/standard-headers/linux/const.h        |   2 +-
>   include/standard-headers/linux/ethtool.h      |  22 +++
>   include/standard-headers/linux/fuse.h         |  12 +-
>   include/standard-headers/linux/pci_regs.h     |  13 +-
>   include/standard-headers/linux/virtio_net.h   |  13 ++
>   include/standard-headers/linux/virtio_snd.h   |   2 +-
>   linux-headers/asm-arm64/kvm.h                 |  11 ++
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/mman-common.h       |   1 +
>   linux-headers/asm-generic/unistd.h            |   4 +-
>   linux-headers/asm-loongarch/unistd_64.h       |   1 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |   2 +
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            |   1 +
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |   3 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   8 +-
>   linux-headers/linux/const.h                   |   2 +-
>   linux-headers/linux/iommufd.h                 | 129 +++++++++++++++++-
>   linux-headers/linux/kvm.h                     |   1 +
>   linux-headers/linux/psp-sev.h                 |  21 ++-
>   linux-headers/linux/stddef.h                  |   2 +
>   linux-headers/linux/vfio.h                    |  30 ++--
>   scripts/update-linux-headers.sh               |   2 +-
>   target/s390x/ioinst.c                         |  11 +-
>   41 files changed, 440 insertions(+), 39 deletions(-)
>   create mode 100644 hw/s390x/ap-stub.c
> 


