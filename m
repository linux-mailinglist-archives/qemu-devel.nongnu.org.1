Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E613835F02
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 11:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRr9k-0004gL-3l; Mon, 22 Jan 2024 05:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rRr9h-0004fy-ER
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1rRr9f-0006Ap-LW
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 05:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705917826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QY0PsSvduos/ZQO69cFeHP8kZWVdX9LdQ4qi/Y2mVw0=;
 b=Venq6mWzTmLkGVUtnZLwYdFSfKq4YY93Y+yW3XuhA/fLtdhDPGCZjurnA8QeX1IYo3lPlo
 R+j80qktX5J0Ff6RM+UleyedvfpDONvI84CioEbtWt8xRLgyrEaxPFz3nqVWtvQiu5Svlt
 aosMzvoYAKOApnvFrVGBWrXK5ExViw0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-hFH354hvPce-OSZq0KMhMA-1; Mon,
 22 Jan 2024 05:03:42 -0500
X-MC-Unique: hFH354hvPce-OSZq0KMhMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BCDA2806668;
 Mon, 22 Jan 2024 10:03:42 +0000 (UTC)
Received: from [10.39.194.172] (unknown [10.39.194.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20E4BC2E1E6;
 Mon, 22 Jan 2024 10:03:40 +0000 (UTC)
Message-ID: <9ac1251c-c1ff-f410-568b-c0b20f283431@redhat.com>
Date: Mon, 22 Jan 2024 11:03:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Content-Language: en-US
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 1/18/24 20:20, Vivek Kasireddy wrote:
> Recent updates in OVMF and Seabios have resulted in MMIO regions
> being placed at the upper end of the physical address space. As a
> result, when a Host device is assigned to the Guest via VFIO, the
> following mapping failures occur when VFIO tries to map the MMIO
> regions of the device:
> VFIO_MAP_DMA failed: Invalid argument
> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000) = -22 (Invalid argument)
> 
> The above failures are mainly seen on some Intel platforms where
> the physical address width is larger than the Host's IOMMU
> address width. In these cases, VFIO fails to map the MMIO regions
> because the IOVAs would be larger than the IOMMU aperture regions.
> 
> Therefore, one way to solve this problem would be to ensure that
> cpu->phys_bits = <IOMMU phys_bits>
> This can be done by parsing the IOMMU caps value from sysfs and
> extracting the address width and using it to override the
> phys_bits value as shown in this patch.
> 
> Previous attempt at solving this issue in OVMF:
> https://edk2.groups.io/g/devel/topic/102359124
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> ---
> v2:
> - Replace the term passthrough with assigned (Laszlo)

v1 of the patch was posted in last November; I've now re-read my
(superficial) comments from back then.

Acked-by: Laszlo Ersek <lersek@redhat.com>


