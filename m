Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A9AA8FF6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 11:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsOT-0007k4-03; Mon, 05 May 2025 05:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsOB-0007jX-NZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBsO9-00049V-ES
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746438328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I1kS8IEoZs7ALp5HadI+JaZa1DV3YxDewQvOBPJJG6U=;
 b=GkuiEk5eRYbqIFoNPWHE+pxGNELqTusX7nx9ODDjcbzPOvY4S04G/YU5reSvAFndQUO4WI
 hnGU5nUKIuIhUZNMzwC1JU9F3Byt8z6FykAOsSUDX7I7T0Sdspq1O+1d0X3caNaxSrtf9l
 YDy8L9WovmHyIKkyCAY8LfuR2XhkuYE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-6xGY8oxuOKO6G4XqYk7bDA-1; Mon, 05 May 2025 05:45:26 -0400
X-MC-Unique: 6xGY8oxuOKO6G4XqYk7bDA-1
X-Mimecast-MFC-AGG-ID: 6xGY8oxuOKO6G4XqYk7bDA_1746438325
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39d9243b1c2so1064135f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746438325; x=1747043125;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1kS8IEoZs7ALp5HadI+JaZa1DV3YxDewQvOBPJJG6U=;
 b=jEd92GqzyDe0yg72Bk0cVATMUhh1nFuMsHxle0xbE11arg3QArBpjAg1dPAikoA6A3
 cesjEEFJQK2WyjmHm/tBXPpGMuNbSb+mTjOrH4WpQNAt6eAphM64ruV5x3icGTOZLy+e
 6HCZY7cLxF6FGgNdVP5PbVz3Q5SHSTLQjHdo/veQAUMhKw1BpyEMqfDYzVhApQqy6uAj
 22YYoZ8HqXOh8Uv/oYrLYl+UzTD3bIKir0O6O54nwe2IFITZVGY1CTnwY6d8kvehN5b6
 uyp/2A850hH5wCFwCS1odkvymTcaABYAONSbjotNhLkB0rcc4s+DT4gMCqypZk7H+4Lb
 TeIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR4fnBjKdjT1kVpWUQgPZkAVLi9eJbytHrJtZu1D1yho57HQDlBtUmrJ803tjEU4XizxO4FaqjPXb1@nongnu.org
X-Gm-Message-State: AOJu0YzF8pH1TzxBsNOqju3hVbz5+hmAd8vsCtKcCFz78ebyBNhZH+qC
 /Z8Mu5+ALJlDK66/gXm9Jw0qyTYOdCoUohVlLq+JbZAQ86P02PdP7wy38nIkjIp4UNFg4oQWzCR
 Hkb3pXJ7n22TqgcZGiro+aNriXWzCV7QmrgPgxJmlCqHk8qBS7Lvq
X-Gm-Gg: ASbGncvxvQvvnmKEwmFXmKVD2cParv92y7zMrbLNwrzEW5j+rhgNV8jJ7JJ2WA9tRZa
 jpvcj1DchnGKyXfFJ7uJ+kP9VNqzImHoJDmG86bLcFs0Oj7H9aLILtWXqQVhKS66fgCDP6oVpO1
 8i7Y41jiNGEWSO+9kLywqwH2Kn6D6+hLR7kD/B4tdhJCqT7LFfsDoD1cJ4inOEYUmdrzqzAZJgv
 scM/Dxb/EcjhNISdxB/zca6Soxa6FEDGCCgSL/s8XbRg/ydFTkpICMp7aBDvciNyJhP/qLypo9o
 e+6fhe6+eQaKnIRATeUEmYgL9jVX0TLwdrjSD90AV34aVh6qYg==
X-Received: by 2002:a05:6000:3104:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a09fd8758amr4424883f8f.29.1746438325462; 
 Mon, 05 May 2025 02:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGiJJuad5Xh/pdm7Q7BrGD/4B1V9i3yQX9CTHoRgTVZYut305Md9uFNv3YPI50I5uQEtwKWA==
X-Received: by 2002:a05:6000:3104:b0:38f:4f60:e669 with SMTP id
 ffacd0b85a97d-3a09fd8758amr4424834f8f.29.1746438324779; 
 Mon, 05 May 2025 02:45:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae831esm10049923f8f.57.2025.05.05.02.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:45:24 -0700 (PDT)
Message-ID: <808bfc81-859d-4652-8e01-52796e82445b@redhat.com>
Date: Mon, 5 May 2025 11:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/15] vfio: add vfio_pci_config_space_read/write()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
 <20250430194003.2793823-8-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250430194003.2793823-8-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/30/25 21:39, John Levon wrote:
> Add these helpers that access config space and return an -errno style
> return.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>

Looks ok.


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 123 ++++++++++++++++++++++++++++++++------------------
>   1 file changed, 80 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 768c48d7ad..8455010d62 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -967,6 +967,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>       }
>   }
>   
> +/* "Raw" read of underlying config space. */
> +static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
> +                                      uint32_t size, void *data)
> +{
> +    ssize_t ret;
> +
> +    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> +
> +    return ret < 0 ? -errno : (int)ret;
> +}
> +
> +/* "Raw" write of underlying config space. */
> +static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
> +                                       uint32_t size, void *data)
> +{
> +    ssize_t ret;
> +
> +    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
> +
> +    return ret < 0 ? -errno : (int)ret;
> +}
> +
>   static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       VFIOPCIDevice *vdev = opaque;
> @@ -1019,10 +1041,9 @@ static const MemoryRegionOps vfio_rom_ops = {
>   
>   static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
> -    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
>       char *name;
> -    int fd = vdev->vbasedev.fd;
>   
>       if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
>           /* Since pci handles romfile, just print a message and return */
> @@ -1039,11 +1060,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
>        * Use the same size ROM BAR as the physical device.  The contents
>        * will get filled in later when the guest tries to read it.
>        */
> -    if (pread(fd, &orig, 4, offset) != 4 ||
> -        pwrite(fd, &size, 4, offset) != 4 ||
> -        pread(fd, &size, 4, offset) != 4 ||
> -        pwrite(fd, &orig, 4, offset) != 4) {
> -        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
> +    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
> +        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
> +        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
> +
> +        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
>           return;
>       }
>   
> @@ -1223,6 +1245,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>   
>       memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1235,12 +1258,12 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>       if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
>           ssize_t ret;
>   
> -        ret = pread(vdev->vbasedev.fd, &phys_val, len,
> -                    vdev->config_offset + addr);
> +        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
>           if (ret != len) {
> -            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
> -                         __func__, vdev->vbasedev.name, addr, len);
> -            return -errno;
> +            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
> +                         __func__, vbasedev->name, addr, len,
> +                         strreaderror(ret));
> +            return -1;
>           }
>           phys_val = le32_to_cpu(phys_val);
>       }
> @@ -1256,15 +1279,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
>                              uint32_t addr, uint32_t val, int len)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       uint32_t val_le = cpu_to_le32(val);
> +    int ret;
>   
>       trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
>   
>       /* Write everything to VFIO, let it filter out what we can't write */
> -    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
> -                != len) {
> -        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
> -                     __func__, vdev->vbasedev.name, addr, val, len);
> +    ret = vfio_pci_config_space_write(vdev, addr, len, &val_le);
> +    if (ret != len) {
> +        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
> +                     __func__, vbasedev->name, addr, val, len,
> +                    strwriteerror(ret));
>       }
>   
>       /* MSI/MSI-X Enabling/Disabling */
> @@ -1352,9 +1378,11 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
>       int ret, entries;
>       Error *err = NULL;
>   
> -    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
> +                                     sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s",
> +                   strreaderror(ret));
>           return false;
>       }
>       ctrl = le16_to_cpu(ctrl);
> @@ -1561,30 +1589,35 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
>       uint8_t pos;
>       uint16_t ctrl;
>       uint32_t table, pba;
> -    int ret, fd = vdev->vbasedev.fd;
>       struct vfio_irq_info irq_info;
>       VFIOMSIXInfo *msix;
> +    int ret;
>   
>       pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
>       if (!pos) {
>           return true;
>       }
>   
> -    if (pread(fd, &ctrl, sizeof(ctrl),
> -              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_FLAGS,
> +                                     sizeof(ctrl), &ctrl);
> +    if (ret != sizeof(ctrl)) {
> +        error_setg(errp, "failed to read PCI MSIX FLAGS: %s",
> +                   strreaderror(ret));
>           return false;
>       }
>   
> -    if (pread(fd, &table, sizeof(table),
> -              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
> +                                     sizeof(table), &table);
> +    if (ret != sizeof(table)) {
> +        error_setg(errp, "failed to read PCI MSIX TABLE: %s",
> +                   strreaderror(ret));
>           return false;
>       }
>   
> -    if (pread(fd, &pba, sizeof(pba),
> -              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
> -        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
> +    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
> +                                     sizeof(pba), &pba);
> +    if (ret != sizeof(pba)) {
> +        error_setg(errp, "failed to read PCI MSIX PBA: %s", strreaderror(ret));
>           return false;
>       }
>   
> @@ -1744,10 +1777,10 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>       }
>   
>       /* Determine what type of BAR this is for registration */
> -    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
> -                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
> +    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
> +                                     sizeof(pci_bar), &pci_bar);
>       if (ret != sizeof(pci_bar)) {
> -        error_report("vfio: Failed to read BAR %d (%m)", nr);
> +        error_report("vfio: Failed to read BAR %d: %s", nr, strreaderror(ret));
>           return;
>       }
>   
> @@ -2450,21 +2483,23 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   
>   void vfio_pci_post_reset(VFIOPCIDevice *vdev)
>   {
> +    VFIODevice *vbasedev = &vdev->vbasedev;
>       Error *err = NULL;
> -    int nr;
> +    int ret, nr;
>   
>       if (!vfio_intx_enable(vdev, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
>       for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
> -        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
> +        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
>           uint32_t val = 0;
>           uint32_t len = sizeof(val);
>   
> -        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
> -            error_report("%s(%s) reset bar %d failed: %m", __func__,
> -                         vdev->vbasedev.name, nr);
> +        ret = vfio_pci_config_space_write(vdev, addr, len, &val);
> +        if (ret != len) {
> +            error_report("%s(%s) reset bar %d failed: %s", __func__,
> +                         vbasedev->name, nr, strwriteerror(ret));
>           }
>       }
>   
> @@ -3101,6 +3136,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       int i, ret;
>       char uuid[UUID_STR_LEN];
>       g_autofree char *name = NULL;
> +    uint32_t config_space_size;
>   
>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -3155,13 +3191,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           goto error;
>       }
>   
> +    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
> +
>       /* Get a copy of config space */
> -    ret = pread(vbasedev->fd, vdev->pdev.config,
> -                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
> -                vdev->config_offset);
> -    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
> -        ret = ret < 0 ? -errno : -EFAULT;
> -        error_setg_errno(errp, -ret, "failed to read device config space");
> +    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
> +                                     vdev->pdev.config);
> +    if (ret < (int)config_space_size) {
> +        ret = ret < 0 ? -ret : EFAULT;
> +        error_setg_errno(errp, ret, "failed to read device config space");
>           goto error;
>       }
>   


