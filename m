Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9CBBE7DF
	for <lists+qemu-devel@lfdr.de>; Mon, 06 Oct 2025 17:31:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5n9I-0005fB-Ck; Mon, 06 Oct 2025 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5n9D-0005f3-Lq
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 11:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5n94-0005C7-Oj
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 11:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759764534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9ErsCcBIaJRXt+kQOMUvyKLpjpVetAtXfeJ2ix8XL3A=;
 b=iQiDhKtoM4kgppK9aSRWGRDKEKTTKcERMGPRXz0U+SNvQ1fBPYQPQliQ2xbwS/ZSRL2MjU
 Vuw9DiQYasttag1RYywfO82iaB+o/i/MUil3eXz65glCIOoDnWsDfRnqYp4i5jMCoDck+i
 otw6IhJSTYlj237AGYN0cY0NjpWL1BE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-4JDM9QlCOOeOAk8nfGFbYQ-1; Mon, 06 Oct 2025 11:28:53 -0400
X-MC-Unique: 4JDM9QlCOOeOAk8nfGFbYQ-1
X-Mimecast-MFC-AGG-ID: 4JDM9QlCOOeOAk8nfGFbYQ_1759764532
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so21027575e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 08:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764532; x=1760369332;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ErsCcBIaJRXt+kQOMUvyKLpjpVetAtXfeJ2ix8XL3A=;
 b=fz60w6rWnfOt/fvdsDH01duPZL+8WwwRoidZiXl7kiYkiAdr8x+O5SDBEg5ophH8Hs
 s1Vi3V/xzy7+8o9xss++RmaiiC/HW8kf9ORR7ITpu0f2bVPXgv0sIPokrUeTwCuwaaIq
 lUcjCqvOOiAOGkURL/FFdKI9wZZgUkCQFozllCPYhZrUyDr+PDpDDKIAQXFV4YZeE2Gf
 Y7ECLJCXwp7yH2G8stYugNuYqi8i5Oe5uMA8EzO37LIPI9FTizB/oGtqsmJ3wzjKGBja
 dqYjcijy9DG5BoqJ8eiF48kzq+tOqFhloTvPUSMeZhB5M77nY2IdPy0ewxUFUwU+xcXR
 z/wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUZvObnKiX0pq+LZdZWhmoxP5Z4PvNU+Z3NoHYPjTKzOdNkpo05Am1dOvi56gEMZ5aMQt6szMLT62w@nongnu.org
X-Gm-Message-State: AOJu0YzLGa6ZoS+TrkcYQIMgnCuQnvnDBkQAw+qnYvd8Lm1EAiElZGgd
 Yfv+ytFrlJktuq0Ct4QUaopaibCjfbHJ/V3IfCPRndy+b6NRx7IzMeAEC3t3zJHuAJSf8D2TNwp
 rO9ahYrWBLzxMVeMQe2kVfZkxxfvMMXyTKJPyCVZ2A073Q1qz+UuHkAva
X-Gm-Gg: ASbGncvoVS+FKN2wuYkt0Z2Cvew2PjFdiNi/pQ9QMrX50jEyei3vsu1eti9j/RKLWHe
 LWc+rd84Eld81BeP0+Tve7t/yx14S5CMrElNg+EaPR8L0SMzlNu3Sgnv0MA7hja5kxgxSWF427I
 HVrvxFpGaPvBEqUjM82weD/I9ZbmfFEbo6Wp9riTlUvxQE7HFFNxrErIar+x/yYZgPjMFd8lcWg
 0mIsyrdEnVIM6sbKjhzQj3/DaWMm6scbAZ+i4qX+wLF3qmPaj7UH5AvbofOpUYSDxAd/38rTDSA
 mz515uPfyoTra/jNMd6mkpDpwrMr7P183JyTkIorrJvenENk7FsHtnQo3lMZ3S2jc9oWzQJqztA
 9YHPK3E8g
X-Received: by 2002:a05:600c:1383:b0:46b:932f:9201 with SMTP id
 5b1f17b1804b1-46e710ae7b2mr91124745e9.0.1759764531842; 
 Mon, 06 Oct 2025 08:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmDX23uEwqEyxb74F8+Y6GjXwv+xWruwXj9E50/I1psNv0XujdtAtqlHaHaL56ZiWx8JzfPQ==
X-Received: by 2002:a05:600c:1383:b0:46b:932f:9201 with SMTP id
 5b1f17b1804b1-46e710ae7b2mr91124455e9.0.1759764531363; 
 Mon, 06 Oct 2025 08:28:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374ac5sm183176435e9.18.2025.10.06.08.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 08:28:50 -0700 (PDT)
Message-ID: <6aae1d93-f531-4550-95e5-07f91b432aba@redhat.com>
Date: Mon, 6 Oct 2025 17:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and
 use it in virtio-gpu
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dongwon Kim <dongwon.kim@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vivek,

On 10/4/25 01:35, Vivek Kasireddy wrote:
> The virtio-gpu driver running in the Guest VM can create Guest blob
> resources (by importing dmabufs) that are backed by System RAM. This
> is made possible by making use of memfd memory backend and udmabuf
> driver on the Host side. However, in order to create Guest blobs
> that are backed by vfio-pci device regions (which happens when
> virtio-gpu imports dmabufs from devices that have local memory such
> as dGPU VFs), we have to implement VFIO_DEVICE_FEATURE_DMA_BUF and
> leverage it in virtio-gpu.
> 
> So, while creating the blobs we use memory_region_is_ram_device() to
> figure out if the blob is backed by memfd or a vfio-pci device. If
> it is determined that the blob is backed by vfio-pci device region,
> instead of calling into udmabuf driver to create dmabuf we would
> now call into vfio-pci driver to have a dmabuf created on the Host.
> 
> RFC -> v1:
> - Create the CPU mapping using vfio device fd if the dmabuf exporter
>    (vfio-pci) does not provide mmap() support (Akihiko)
> - Log a warning with LOG_GUEST_ERROR instead of warn_report() when
>    dmabuf cannot be created using Guest provided addresses (Akihiko)
> - Use address_space_translate() instead of gpa2hva() to obtain the
>    Host addresses (Akihiko)
> - Rearrange the patches and improve the commit messages (Akihiko)
> - Fix compilation error when VFIO is not enabled (Alex)
> - Add a new helper to obtain VFIO region index from memory region
> - Move vfio_device_create_dmabuf() to hw/vfio/device.c
> 
> Tested with an SRIOV enabled Intel dGPU by running Gnome Wayland

Could you please be more precise on the HW ?

> (in the VM) and Qemu with the following (relevant) parameters:
> -device vfio-pci,host=0000:03:00.1
> -device virtio-vga,max_outputs=1,xres=1920,yres=1080,blob=true
> -display gtk,gl=on
> 
> Associated vfio-pci kernel driver series:
> https://lore.kernel.org/dri-devel/cover.1754311439.git.leon@kernel.org/
> Associated virtio-gpu kernel driver series (merged):
> https://lore.kernel.org/dri-devel/20241126031643.3490496-1-vivek.kasireddy@intel.com/
> 
> ---
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Leon Romanovsky <leonro@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> 
> Vivek Kasireddy (7):
>    virtio-gpu: Recreate the resource's dmabuf if new backing is attached
>    virtio-gpu: Don't rely on res->blob to identify blob resources
>    virtio-gpu: Find hva for Guest's DMA addr associated with a ram device
>    vfio/region: Add a helper to get region index from memory region
>    linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
>    vfio/device: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
>    virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
>      devices
> 
>   hw/display/Kconfig              |   5 ++
>   hw/display/virtio-gpu-udmabuf.c | 143 ++++++++++++++++++++++++++++++--
>   hw/display/virtio-gpu.c         |  53 +++++++++---
>   hw/vfio/device.c                |  43 ++++++++++
>   hw/vfio/region.c                |  14 ++++
>   include/hw/vfio/vfio-device.h   |   5 ++
>   linux-headers/linux/vfio.h      |  25 ++++++
>   7 files changed, 270 insertions(+), 18 deletions(-)
> 

Please cc: Alex and I on all patches.

Thanks,

C.


