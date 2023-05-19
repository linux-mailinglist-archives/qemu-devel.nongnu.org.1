Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE062708F7C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 07:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzsl2-0005k3-Jd; Fri, 19 May 2023 01:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzskx-0005jY-Ow
 for qemu-devel@nongnu.org; Fri, 19 May 2023 01:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzskv-0006sZ-TH
 for qemu-devel@nongnu.org; Fri, 19 May 2023 01:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684474460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyBt3dGF7ywscTlzp6IqhqjH0cOqmeYH/OS6rsKK3KU=;
 b=IMU5HYw4mnpNgD61jxui4hgu5602sJx/U4gdC1WZJe+uXlvUsbC+cD7yKdfmEJDxAWqJ+I
 LbwsUXWs5a0N8eqQyoXvhXQiId2T62mrbs9B0AVmbq2f2S1lNIU7FAUuHibi9xU7vzQeIL
 87TkPcEDIRy6aNhV4FCiwu0U1q6dxqU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-tEGpLuXiOTqXLGxZ1Ge6Sg-1; Fri, 19 May 2023 01:34:18 -0400
X-MC-Unique: tEGpLuXiOTqXLGxZ1Ge6Sg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f3a9670ae0so680411e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 22:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684474457; x=1687066457;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hyBt3dGF7ywscTlzp6IqhqjH0cOqmeYH/OS6rsKK3KU=;
 b=mDwy++eKXctVpb7mdJ5EilG8zgOU9KgbL9vT0hraSW/3i6qut4KONrisWUE10E02A0
 abHmNXf3f+IV5JuscaV3XU5IEi8njAKKBhPAvRx5F243cLtWkiywn2BLrSR7AGp2R8r8
 aiOMlk7knC/kO24uE8PNOl0fafbpqEPxlkBW9/95Tl1XHCREVGHkEstMe9ek5BrXr/ha
 E1GHEYImJ866J9ksAzXAOv4B7xR28HRAHGC7EP8vpDdQqWasaxAz03EY6hTJYSYut2LX
 g/pP3dNwDHfE1kzouneU8l+MlviHP4Z5WyYTlnEUlllzDNwOX8FFhwJClF9PpjoKWxyR
 pVag==
X-Gm-Message-State: AC+VfDwuiyOWS0R0KeGQ3JupfyXSWrLURTmjzzXBr8sCeJ3o08b0SVaT
 ChxFhvzM/R5uspcgWgXh4IDQ6nlRacIQO/M8Kwyu8vylygEXtsPs6A7Zre/MZ9kw+AXrssgT9Ww
 7QBDy4ZwkRlxHD9s=
X-Received: by 2002:a19:c202:0:b0:4f3:9001:848c with SMTP id
 l2-20020a19c202000000b004f39001848cmr400254lfc.33.1684474457064; 
 Thu, 18 May 2023 22:34:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YJa5m3+xXoUd6LwLV3UCraXx2EdnOWkut4Kt4HSrisrV7qol1KHiRI2b/s0z/+hRZqR5/Cw==
X-Received: by 2002:a19:c202:0:b0:4f3:9001:848c with SMTP id
 l2-20020a19c202000000b004f39001848cmr400242lfc.33.1684474456662; 
 Thu, 18 May 2023 22:34:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 b20-20020ac247f4000000b004eaeb0a984csm474515lfp.88.2023.05.18.22.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 22:34:15 -0700 (PDT)
Date: Fri, 19 May 2023 01:34:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 3/3] pci: ROM preallocation for incoming migration
Message-ID: <20230519013355-mutt-send-email-mst@kernel.org>
References: <20230515125229.44836-1-vsementsov@yandex-team.ru>
 <20230515125229.44836-4-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515125229.44836-4-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, May 15, 2023 at 03:52:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On incoming migration we have the following sequence to load option
> ROM:
> 
> 1. On device realize we do normal load ROM from the file
> 
> 2. Than, on incoming migration we rewrite ROM from the incoming RAM
>    block. If sizes mismatch we fail, like this:
> 
>     Size mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 != 0x80000: Invalid argument
> 
> This is not ideal when we migrate to updated distribution: we have to
> keep old ROM files in new distribution and be careful around romfile
> property to load correct ROM file. Which is loaded actually just to
> allocate the ROM with correct length.
> 
> Note, that romsize property doesn't really help: if we try to specify
> it when default romfile is larger, it fails with something like:
> 
>     romfile "efi-virtio.rom" (160768 bytes) is too large for ROM size 65536
> 
> Let's just ignore ROM file when romsize is specified and we are in
> incoming migration state. In other words, we need only to preallocate
> ROM of specified size, local ROM file is unrelated.
> 
> This way:
> 
> If romsize was specified on source, we just use same commandline as on
> source, and migration will work independently of local ROM files on
> target.
> 
> If romsize was not specified on source (and we have mismatching local
> ROM file on target host), we have to specify romsize on target to match
> source romsize. romfile parameter may be kept same as on source or may
> be dropped, the file is not loaded anyway.
> 
> As a bonus we avoid extra reading from ROM file on target.
> 
> Note: when we don't have romsize parameter on source command line and
> need it for target, it may be calculated as aligned up to power of two
> size of ROM file on source (if we know, which file is it) or,
> alternatively it may be retrieved from source QEMU by QMP qom-get
> command, like
> 
>   { "execute": "qom-get",
>     "arguments": {
>       "path": "/machine/peripheral/CARD_ID/virtio-net-pci.rom[0]",
>       "property": "size" } }
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>


Breaks build here:

In function ‘pci_add_option_rom’,
    inlined from ‘pci_qdev_realize’ at ../hw/pci/pci.c:2155:5:
../hw/pci/pci.c:2395:13: error: ‘size’ may be used uninitialized [-Werror=maybe-uninitialized]
 2395 |         if (load_image_size(path, ptr, size) < 0) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../hw/pci/pci.c: In function ‘pci_qdev_realize’:
../hw/pci/pci.c:2312:13: note: ‘size’ was declared here
 2312 |     int64_t size;
      |             ^~~~



> ---
>  hw/pci/pci.c | 77 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 3a0107758c..0f0c83c02f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -36,6 +36,7 @@
>  #include "migration/vmstate.h"
>  #include "net/net.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/loader.h"
>  #include "qemu/error-report.h"
> @@ -2308,10 +2309,16 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>  {
>      int64_t size;
>      g_autofree char *path = NULL;
> -    void *ptr;
>      char name[32];
>      const VMStateDescription *vmsd;
>  
> +    /*
> +     * In case of incoming migration ROM will come with migration stream, no
> +     * reason to load the file.  Neither we want to fail if local ROM file
> +     * mismatches with specified romsize.
> +     */
> +    bool load_file = !runstate_check(RUN_STATE_INMIGRATE);
> +
>      if (!pdev->romfile || !strlen(pdev->romfile)) {
>          return;
>      }
> @@ -2341,32 +2348,35 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>          return;
>      }
>  
> -    path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
> -    if (path == NULL) {
> -        path = g_strdup(pdev->romfile);
> -    }
> +    if (load_file || pdev->romsize == -1) {
> +        path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
> +        if (path == NULL) {
> +            path = g_strdup(pdev->romfile);
> +        }
>  
> -    size = get_image_size(path);
> -    if (size < 0) {
> -        error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
> -        return;
> -    } else if (size == 0) {
> -        error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
> -        return;
> -    } else if (size > 2 * GiB) {
> -        error_setg(errp, "romfile \"%s\" too large (size cannot exceed 2 GiB)",
> -                   pdev->romfile);
> -        return;
> -    }
> -    if (pdev->romsize != -1) {
> -        if (size > pdev->romsize) {
> -            error_setg(errp, "romfile \"%s\" (%u bytes) "
> -                       "is too large for ROM size %u",
> -                       pdev->romfile, (uint32_t)size, pdev->romsize);
> +        size = get_image_size(path);
> +        if (size < 0) {
> +            error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
> +            return;
> +        } else if (size == 0) {
> +            error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
> +            return;
> +        } else if (size > 2 * GiB) {
> +            error_setg(errp,
> +                       "romfile \"%s\" too large (size cannot exceed 2 GiB)",
> +                       pdev->romfile);
>              return;
>          }
> -    } else {
> -        pdev->romsize = pow2ceil(size);
> +        if (pdev->romsize != -1) {
> +            if (size > pdev->romsize) {
> +                error_setg(errp, "romfile \"%s\" (%u bytes) "
> +                           "is too large for ROM size %u",
> +                           pdev->romfile, (uint32_t)size, pdev->romsize);
> +                return;
> +            }
> +        } else {
> +            pdev->romsize = pow2ceil(size);
> +        }
>      }
>  
>      vmsd = qdev_get_vmsd(DEVICE(pdev));
> @@ -2377,15 +2387,18 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>      memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize,
>                             &error_fatal);
>  
> -    ptr = memory_region_get_ram_ptr(&pdev->rom);
> -    if (load_image_size(path, ptr, size) < 0) {
> -        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
> -        return;
> -    }
> +    if (load_file) {
> +        void *ptr = memory_region_get_ram_ptr(&pdev->rom);
>  
> -    if (is_default_rom) {
> -        /* Only the default rom images will be patched (if needed). */
> -        pci_patch_ids(pdev, ptr, size);
> +        if (load_image_size(path, ptr, size) < 0) {
> +            error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
> +            return;
> +        }
> +
> +        if (is_default_rom) {
> +            /* Only the default rom images will be patched (if needed). */
> +            pci_patch_ids(pdev, ptr, size);
> +        }
>      }
>  
>      pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
> -- 
> 2.34.1


