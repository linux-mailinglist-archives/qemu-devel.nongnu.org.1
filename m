Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC781E6B8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:53:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI47C-0001sT-Er; Tue, 26 Dec 2023 04:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI47A-0001rC-Ge
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:52:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI478-00048R-Qs
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703584361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVa/TM0jX0Qz+UCFAMwmdhwFZKkLoEj6Z3aD86p0JRQ=;
 b=RgQert8UXHIsEtc+mQ/D7FYtaYkpQCMpqosGPFXAJ7cKdzD1g3o8qL4SD9kwYnN53qy0z9
 gAFyCLa5CQ60fABJB61cnC8zmAemFnrjp12iUiH9jKbj0+D9wE5DssHYq3YaKkdMiveRg9
 rTEDmkZGXTOULMZ3FVMm6qgjlwEQm3I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-pt5y634DPcSAOMsAXhCaKQ-1; Tue, 26 Dec 2023 04:52:39 -0500
X-MC-Unique: pt5y634DPcSAOMsAXhCaKQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368c707b03so3065926f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584357; x=1704189157;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VVa/TM0jX0Qz+UCFAMwmdhwFZKkLoEj6Z3aD86p0JRQ=;
 b=sa0O7FMIYPIV0+wHGJIm1t+hUbuRVveg0SUgrZLWoW/x1Y75l5Vl1v+9MvzLrCzN6O
 hDc9v3qg34Oi4Veb8QN5dARyFuctVu1atsqB9logy4Q/3rszmxYxJ0yvvzVG/8iQ5zrQ
 qIX7KbGSpJQkMW4cfDRpDPVR4RhQ7xxeUjISn6GlOEjZTy+cPr7cTeQDwZZi2lqtUZ/M
 1ry2rTgkZL/gKdBmN/Y5UJELzOK1AVKzFkp+srMowG0C9IJYjEmIGZQB/t7gR7JhZS9x
 lqoEQC4+kP8wHD+n/LCLh6pflnpDmYcugdboUQWI46mXb9bKk87DDZr+gTuroH/5Aqa4
 SVUw==
X-Gm-Message-State: AOJu0Yx/yUdZ5EAR3kZElTeK0YAU9AlW1rlccdoZdQrvyTE392sgAN23
 m1dLXdMHn/q6/Hwh6Ug4dHjHGcxzAo0cVcMJitlWXX57PH/wWEiOtoZV7E6C7um2L/6SrEQfvHB
 39b59dtw/oHjO6z7E4kRjomxzpne4+evD8aSyR+ZkbCTOJKYx/Nfxnnm3CbUgAolU1VwePQcLTA
 /X
X-Received: by 2002:a5d:6703:0:b0:336:66be:adc8 with SMTP id
 o3-20020a5d6703000000b0033666beadc8mr3770788wru.55.1703584357133; 
 Tue, 26 Dec 2023 01:52:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrCxpCKai8nyQbpgfdjVE2YV6YGckgE0ALfpP631DM3GZ9n03ZYC0ZAwTl4tYgujPcZezfuA==
X-Received: by 2002:a5d:6703:0:b0:336:66be:adc8 with SMTP id
 o3-20020a5d6703000000b0033666beadc8mr3770784wru.55.1703584356777; 
 Tue, 26 Dec 2023 01:52:36 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 a3-20020a056000100300b003368d2e729bsm10529793wrx.43.2023.12.26.01.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:52:35 -0800 (PST)
Date: Tue, 26 Dec 2023 04:52:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/21] virtio,pc,pci: features, cleanups, fixes
Message-ID: <20231226045207-mutt-send-email-mst@kernel.org>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Dec 26, 2023 at 04:24:01AM -0500, Michael S. Tsirkin wrote:
> The following changes since commit 80f1709aa0eb4de09b4240563463f991a5b9d855:
> 
>   Merge tag 'pull-loongarch-20231221' of https://gitlab.com/gaosong/qemu into staging (2023-12-21 19:44:19 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 7b67b2f0f4f7c5ec888a331af599d9daff735d60:

f6fe3e333fe0fcb8ef87c669a3a8f84fbee10cb7 now - fixed one of commit logs.


>   vdpa: move memory listener to vhost_vdpa_shared (2023-12-25 11:34:55 -0500)
> 
> ----------------------------------------------------------------
> virtio,pc,pci: features, cleanups, fixes
> 
> vhost-scsi support for worker ioctls
> 
> fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Aaron Young (1):
>       hw/acpi: propagate vcpu hotplug after switch to modern interface
> 
> Dongli Zhang (1):
>       vhost-scsi: fix usage of error_reportf_err()
> 
> Eugenio Pérez (14):
>       vdpa: do not set virtio status bits if unneeded
>       vdpa: add VhostVDPAShared
>       vdpa: move iova tree to the shared struct
>       vdpa: move iova_range to vhost_vdpa_shared
>       vdpa: move shadow_data to vhost_vdpa_shared
>       vdpa: use vdpa shared for tracing
>       vdpa: move file descriptor to vhost_vdpa_shared
>       vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>       vdpa: move backend_cap to vhost_vdpa_shared
>       vdpa: remove msg type of vhost_vdpa
>       vdpa: move iommu_list to vhost_vdpa_shared
>       vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>       vdpa: use dev_shared in vdpa_iommu
>       vdpa: move memory listener to vhost_vdpa_shared
> 
> Mathieu Poirier (1):
>       virtio: rng: Check notifier helpers for VIRTIO_CONFIG_IRQ_IDX
> 
> Mike Christie (2):
>       vhost: Add worker backend callouts
>       vhost-scsi: Add support for a worker thread per virtqueue
> 
> Zhao Liu (1):
>       tests: bios-tables-test: Rename smbios type 4 related test functions
> 
> wangmeiling (1):
>       Fix bugs when VM shutdown with virtio-gpu unplugged
> 
>  include/hw/virtio/vhost-backend.h |  14 ++++
>  include/hw/virtio/vhost-vdpa.h    |  40 ++++++----
>  include/hw/virtio/virtio-scsi.h   |   1 +
>  hw/acpi/cpu_hotplug.c             |  20 ++++-
>  hw/display/virtio-gpu-base.c      |   4 +
>  hw/scsi/vhost-scsi.c              |  66 ++++++++++++++-
>  hw/scsi/vhost-user-scsi.c         |   3 +-
>  hw/virtio/vdpa-dev.c              |   7 +-
>  hw/virtio/vhost-backend.c         |  28 +++++++
>  hw/virtio/vhost-user-rng.c        |  16 ++++
>  hw/virtio/vhost-vdpa.c            | 164 ++++++++++++++++++++------------------
>  net/vhost-vdpa.c                  | 116 +++++++++++++--------------
>  tests/qtest/bios-tables-test.c    |  20 ++---
>  hw/virtio/trace-events            |  14 ++--
>  14 files changed, 334 insertions(+), 179 deletions(-)
> 


