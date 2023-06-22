Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06CE73ACC1
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 00:56:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCTCJ-0002Bx-7S; Thu, 22 Jun 2023 18:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCTCH-0002Bm-MZ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 18:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCTCG-00051t-09
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 18:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687474475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmtChRUMUC92YLJ+8UYUXaD9jiRJoGr3U6HwDlLaNrg=;
 b=eda8EvGwQ6+sdmHf/nKFmEG4Wg8TNmkmwmZRj+yE41FZ5v0GXY+jAKU3VM7xBWzgnUEGO5
 r/GUWKPBjDrRh+VKCI3pUFqYM8asS9BppqpLmPzFAKvx7LlEgp4dAw1B76UANex4axPfPm
 a4N66DzNIYCnQHPe7eZL/m02wpqUcuY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-SKnOiUVvOnOwsedeF_DKKw-1; Thu, 22 Jun 2023 18:54:33 -0400
X-MC-Unique: SKnOiUVvOnOwsedeF_DKKw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7e4dc0fe5so420685e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 15:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687474472; x=1690066472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PmtChRUMUC92YLJ+8UYUXaD9jiRJoGr3U6HwDlLaNrg=;
 b=OZYDAhsw/1uPFTuT/RIJBor2FwjGqkLlNWkRIrNYyyF25b7MbPDPitx8TYXBF1e+No
 8AOkUs5e1rKq6VfqiDQTd4B6ymU517NqfdEF81JPTKvy/K0E+kqnizL2MKRiwq9syTFp
 2hi8y+/TtyBKmHAOP4UsRQjOEpY5heRK2FTmGv/GkNfuxl6j6wK/nxT0vraGXpSq2jTe
 024QartF+2piygpRBkLr2zRACI2/LxgHbVf+JF2fJ5SIlz1yii4GETuYgCLAFVAdxtbi
 qmhF0wUDg621m75mMpaVCjyhBq7yaLVqXp5HJfcgQTuMjKvuPSHflij2VX0/Gj9ZL2vt
 c9Hw==
X-Gm-Message-State: AC+VfDze1dHpeL8YDKRFquIFBCc4/yS3++GlGFIm+dnes1S5+5UiZICK
 jXGsPKdWKCuzRHm1OBwk0buliTXbC80Hh06/x9+vQOFHQXovhz4v4y4w4Xz9ZLq7npoLERE+NrS
 tztt5aM4NTTzS2jo=
X-Received: by 2002:a1c:7708:0:b0:3f9:ba2:5d1c with SMTP id
 t8-20020a1c7708000000b003f90ba25d1cmr12448588wmi.9.1687474472524; 
 Thu, 22 Jun 2023 15:54:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Z30DYwqdY9uGa4Rdc1BOntvYnaSsl8adGE1cfE4ULe9SkVC7Qsbpi5oh6t6mq4jqj2aSvSw==
X-Received: by 2002:a1c:7708:0:b0:3f9:ba2:5d1c with SMTP id
 t8-20020a1c7708000000b003f90ba25d1cmr12448581wmi.9.1687474472222; 
 Thu, 22 Jun 2023 15:54:32 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 c21-20020a7bc855000000b003f60e143d38sm656923wml.11.2023.06.22.15.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 15:54:31 -0700 (PDT)
Date: Thu, 22 Jun 2023 18:54:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Viktor Prutyanov <viktor@daynix.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, yan@daynix.com,
 yuri.benditovich@daynix.com
Subject: Re: [PATCH v4 0/2] vhost: register and change IOMMU flag depending
 on ATS state
Message-ID: <20230622185347-mutt-send-email-mst@kernel.org>
References: <20230525125742.4190-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525125742.4190-1-viktor@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 25, 2023 at 03:57:40PM +0300, Viktor Prutyanov wrote:
> When IOMMU and vhost are enabled together, QEMU tracks IOTLB or
> Device-TLB unmap events depending on whether Device-TLB is enabled. But
> even if Device-TLB and PCI ATS is enabled, the guest can reject to use
> it. For example, this situation appears when Windows Server 2022 is
> running with intel-iommu with device-iotlb=on and virtio-net-pci with
> vhost=on. The guest implies that no address translation info cached in
> device IOTLB and doesn't send device IOTLB invalidation commands. So,
> it leads to irrelevant address translations in vhost-net in the host
> kernel. Therefore network frames from the guest in host tap interface
> contains wrong payload data.
> 
> This series adds checking of ATS state for proper unmap flag register
> (IOMMU_NOTIFIER_UNMAP or IOMMU_NOTIFIER_DEVIOTLB_UNMAP).
> 
> Tested on Windows Server 2022, Windows 11 and Fedora guests with
>  -device virtio-net-pci,bus=pci.3,netdev=nd0,iommu_platform=on,ats=on
>  -netdev tap,id=nd0,ifname=tap1,script=no,downscript=no,vhost=on
>  -device intel-iommu,intremap=on,eim=on,device-iotlb=on/off
> Tested on Fedora guest with
>  -device virtio-iommu

Fails build on windows hosts:

https://gitlab.com/mstredhat/qemu/-/pipelines/909063579/failures

C:\GitLab-Runner\builds\mstredhat\qemu\output/../hw/net/virtio-net.c:3954: undefined reference to `vhost_toggle_device_iotlb'




> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2001312
> 
> v4: call vhost_toggle_device_iotlb regardless of vhost backend,
>     move vhost_started check to generic part
> v3: call virtio_pci_ats_ctrl_trigger directly, remove
>     IOMMU_NOTIFIER_UNMAP fallbacks
> v2: remove memory_region_iommu_notify_flags_changed, move trigger to
>     VirtioDeviceClass, use vhost_ops, use device_iotlb name
> 
> Viktor Prutyanov (2):
>   vhost: register and change IOMMU flag depending on Device-TLB state
>   virtio-net: pass Device-TLB enable/disable events to vhost
> 
>  hw/net/virtio-net.c       |  1 +
>  hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
>  include/hw/virtio/vhost.h |  1 +
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> -- 
> 2.21.0


