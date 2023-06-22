Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962473A95F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 22:15:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQgi-0005z7-M5; Thu, 22 Jun 2023 16:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQgg-0005xp-TE
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCQgf-0007EM-AQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 16:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687464828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XubY0rqvt0/p6OB1uA8q+9GRjQII2pVurqbY7EUIcZ8=;
 b=R28My3pUXrlRp3nQIxpo9SWIlQYGTTycIpnDH56pAWYjsHfAlFA+OjKj3L1omKyxxtp/tW
 jhyqZv1wC+EPOFu/1jNArcpFqGS+nM3PHRg5LLZQgO2jncjCBYnd/vfg7gOcnmYXbwQdYN
 QHUrSai3UfwE87hfncVYpwtfhmflU0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-uUX7JjDrNgSLxMgqrxq3qw-1; Thu, 22 Jun 2023 16:13:41 -0400
X-MC-Unique: uUX7JjDrNgSLxMgqrxq3qw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f9b5bbd79aso19834565e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 13:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687464819; x=1690056819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XubY0rqvt0/p6OB1uA8q+9GRjQII2pVurqbY7EUIcZ8=;
 b=IxRZ2/eBKTHpQDYWfwc4ZxBle0VDWwEypnUkX67F/4DNawZOZ8uCHJ4Gb1e9kh/tBd
 drdF8YVmqOlAfh2OPgbcea28tbp1GR72OOZwdsT3pcZfOJjWlNFi5jgGU6XMkiXtSfwx
 Vf1w5cEyK4XEXzebSSmHVXbUohl5swZzwkOONKx9p06m5B5wPj7HYVzC8bgpaJKxJJ07
 gH7bPNdM8lqfwZ924wq9EEe0NWFMGbYUN/FH3gXBNtXHhwUEYbPUo51A6O0h8Dl93ncY
 CW85SrwWAEJn04Fq06lWF8DiqH96UokqVhHQ2XmtBW+L29rQysDfjvp/uyQPsiymxulK
 jklg==
X-Gm-Message-State: AC+VfDyE7HtCGdI2ZRafcpqbl73v8+2KihEvNBJY1Bv1hrUeO3yf9or/
 cD4DhtyPD/YRGQF8E4Wg+dvFJ9TELTjT55UPxIariOzQrEa2du5BTAgOjjgGQ2gFZ8MaiHSbIt7
 rQdkgw3L2Vy7ecGU=
X-Received: by 2002:a05:6000:1008:b0:311:1501:ba53 with SMTP id
 a8-20020a056000100800b003111501ba53mr13990332wrx.49.1687464819300; 
 Thu, 22 Jun 2023 13:13:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Z848Cdg9f74GCBSXn9IJ+HeZEJOTGfu6fEZWrkjAlXPzs+SsC21fcHu00BvljuPM9Du27mw==
X-Received: by 2002:a05:6000:1008:b0:311:1501:ba53 with SMTP id
 a8-20020a056000100800b003111501ba53mr13990310wrx.49.1687464819009; 
 Thu, 22 Jun 2023 13:13:39 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 e10-20020a5d65ca000000b002f28de9f73bsm7752224wrw.55.2023.06.22.13.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 13:13:38 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:13:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: Re: [PATCH 00/10] memory-device: Some cleanups
Message-ID: <20230622161320-mutt-send-email-mst@kernel.org>
References: <20230530113838.257755-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530113838.257755-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, May 30, 2023 at 01:38:28PM +0200, David Hildenbrand wrote:
> Working on adding multi-memslot support for virtio-mem (teaching memory
> device code about memory devices that can consume multiple memslots), I
> have some preparatory cleanups in my queue that make sense independent of
> the actual memory-device/virtio-mem extensions.

pc/acpi things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1 -> v2:
> - Allocate ms->device_memory only if the size > 0.
> - Split it up and include more cleanups
> 
> David Hildenbrand (10):
>   memory-device: Unify enabled vs. supported error messages
>   memory-device: Introduce memory_devices_init()
>   hw/arm/virt: Use memory_devices_init()
>   hw/ppc/spapr: Use memory_devices_init()
>   hw/loongarch/virt: Use memory_devices_init()
>   hw/i386/pc: Use memory_devices_init()
>   hw/i386/acpi-build: Rely on machine->device_memory when building SRAT
>   hw/i386/pc: Remove PC_MACHINE_DEVMEM_REGION_SIZE
>   memory-device: Refactor memory_device_pre_plug()
>   memory-device: Track used region size in DeviceMemoryState
> 
>  hw/arm/virt.c                  |  9 +----
>  hw/i386/acpi-build.c           |  9 ++---
>  hw/i386/pc.c                   | 36 +++---------------
>  hw/loongarch/virt.c            | 14 ++-----
>  hw/mem/memory-device.c         | 69 +++++++++++++++-------------------
>  hw/ppc/spapr.c                 | 37 +++++++++---------
>  hw/ppc/spapr_hcall.c           |  2 +-
>  include/hw/boards.h            |  2 +
>  include/hw/i386/pc.h           |  1 -
>  include/hw/mem/memory-device.h |  2 +
>  10 files changed, 68 insertions(+), 113 deletions(-)
> 
> -- 
> 2.40.1


