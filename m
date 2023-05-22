Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392B70C7FB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:35:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1BHt-0007Kx-Fl; Mon, 22 May 2023 15:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q1BHo-0007Ki-8c
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q1BHh-0001ts-7r
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684784009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lqCkoNoTrpU9w/HyQ37i+0th1yQawlwIlMVjLi7cI0=;
 b=VVElHiL2R0cu4AUArHH8Mb4b0pbw858yxRMa0GJ2dGY/cgtZxOgITnW775bmcysf5c1GZo
 ZWBe8H1smKcsuOc8RGid2OHnhnE95xymNGnzIH7spyPqp8UBA+ZjaDovQCSkPkOOhK3Jmr
 wT8CwsEg2Q5n0RaYXS3NEtKG+a1+LuM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-l2x4dqBQOqudKOLp7rBT4g-1; Mon, 22 May 2023 15:33:28 -0400
X-MC-Unique: l2x4dqBQOqudKOLp7rBT4g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3093b0cf714so2391974f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 12:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684784007; x=1687376007;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2lqCkoNoTrpU9w/HyQ37i+0th1yQawlwIlMVjLi7cI0=;
 b=Xv/y/wjW5EmPPaYOoLBFSECEx4Fz74Hn5SHrKoYXyfwUNaluO2P21N/pk4FZyQrySj
 KmdNuuBXPW507iyoRL8NMYwBmj8N8lZbG+lZtdWH667B+pjIWCBj6ITJGEr8Y+eZNa3x
 24JqAaODeE18wNcU2w2MZLzMl1OBDYdmE9ACMyt8CLs9XLWBTD3vI9SWSk8NcGFcm409
 mq2+JXwDt1Znzf1LCPuY+pDqbQGLyKJ33JWz1Yfzeyv5FC9NEypxwVWfYRE3IDFkTiKe
 YDFbdCvxvpcPTKbApwbVp3rAb5NvJOuxgVStiMs5BgUO5dFgHgeR5Iew9PpirnwfRMel
 YbsA==
X-Gm-Message-State: AC+VfDxAsxHEB5Fdqof4cmDTJDt7lzlMXjqb1WriWNTxXCBakZf6xvjL
 yJRDouoXyEvmPQlL4THvJ6t6qlEZTWmwnvDvqX/1qr1fkODWU34Hs7K13zwp6iHWnoCUAYUQpnx
 gRzGw01qPw/toNTw=
X-Received: by 2002:adf:e591:0:b0:307:a77c:c170 with SMTP id
 l17-20020adfe591000000b00307a77cc170mr7810492wrm.2.1684784007119; 
 Mon, 22 May 2023 12:33:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4kajsyCEHDLh68zRRtcpoGFnXW/1Na9EUvXxWfqEneTydgUZml4MWB3Z336YXahILLfAfuGg==
X-Received: by 2002:adf:e591:0:b0:307:a77c:c170 with SMTP id
 l17-20020adfe591000000b00307a77cc170mr7810474wrm.2.1684784006696; 
 Mon, 22 May 2023 12:33:26 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 c14-20020a056000104e00b00307b5376b2csm8588722wrx.90.2023.05.22.12.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 12:33:25 -0700 (PDT)
Date: Mon, 22 May 2023 15:33:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 3/3] pci: ROM preallocation for incoming migration
Message-ID: <20230522153226-mutt-send-email-mst@kernel.org>
References: <20230515125229.44836-1-vsementsov@yandex-team.ru>
 <20230515125229.44836-4-vsementsov@yandex-team.ru>
 <20230519013355-mutt-send-email-mst@kernel.org>
 <9a74861d-cef7-cfad-0e87-87e2d6710501@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a74861d-cef7-cfad-0e87-87e2d6710501@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 11:44:32AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 19.05.23 08:34, Michael S. Tsirkin wrote:
> > On Mon, May 15, 2023 at 03:52:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On incoming migration we have the following sequence to load option
> > > ROM:
> > > 
> > > 1. On device realize we do normal load ROM from the file
> > > 
> > > 2. Than, on incoming migration we rewrite ROM from the incoming RAM
> > >     block. If sizes mismatch we fail, like this:
> > > 
> > >      Size mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 != 0x80000: Invalid argument
> > > 
> > > This is not ideal when we migrate to updated distribution: we have to
> > > keep old ROM files in new distribution and be careful around romfile
> > > property to load correct ROM file. Which is loaded actually just to
> > > allocate the ROM with correct length.
> > > 
> > > Note, that romsize property doesn't really help: if we try to specify
> > > it when default romfile is larger, it fails with something like:
> > > 
> > >      romfile "efi-virtio.rom" (160768 bytes) is too large for ROM size 65536
> > > 
> > > Let's just ignore ROM file when romsize is specified and we are in
> > > incoming migration state. In other words, we need only to preallocate
> > > ROM of specified size, local ROM file is unrelated.
> > > 
> > > This way:
> > > 
> > > If romsize was specified on source, we just use same commandline as on
> > > source, and migration will work independently of local ROM files on
> > > target.
> > > 
> > > If romsize was not specified on source (and we have mismatching local
> > > ROM file on target host), we have to specify romsize on target to match
> > > source romsize. romfile parameter may be kept same as on source or may
> > > be dropped, the file is not loaded anyway.
> > > 
> > > As a bonus we avoid extra reading from ROM file on target.
> > > 
> > > Note: when we don't have romsize parameter on source command line and
> > > need it for target, it may be calculated as aligned up to power of two
> > > size of ROM file on source (if we know, which file is it) or,
> > > alternatively it may be retrieved from source QEMU by QMP qom-get
> > > command, like
> > > 
> > >    { "execute": "qom-get",
> > >      "arguments": {
> > >        "path": "/machine/peripheral/CARD_ID/virtio-net-pci.rom[0]",
> > >        "property": "size" } }
> > > 
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Juan Quintela <quintela@redhat.com>
> > 
> > 
> > Breaks build here:
> > 
> > In function ‘pci_add_option_rom’,
> >      inlined from ‘pci_qdev_realize’ at ../hw/pci/pci.c:2155:5:
> > ../hw/pci/pci.c:2395:13: error: ‘size’ may be used uninitialized [-Werror=maybe-uninitialized]
> >   2395 |         if (load_image_size(path, ptr, size) < 0) {
> >        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../hw/pci/pci.c: In function ‘pci_qdev_realize’:
> > ../hw/pci/pci.c:2312:13: note: ‘size’ was declared here
> >   2312 |     int64_t size;
> >        |             ^~~~
> > 
> > 
> 
> Hmm, but works for me. Anyway that's obviously false-positive, if we are here, size is initialized in previous block if (load_file || ..).
> 
> So, may be add simply this:
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0f0c83c02f..075c998284 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2307,7 +2307,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
>  static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>                                 Error **errp)
>  {
> -    int64_t size;
> +    int64_t size = 0;  /* fix "uninitialized" false-positive */

I'd even drop the comment, we will not remember to remove it.
just mention in commit log.


OK, pls repost with this fix. Minor so include acks posted so far. Thanks!

>      g_autofree char *path = NULL;
>      char name[32];
>      const VMStateDescription *vmsd;
> 
> 
> > 
> > > ---
> > >   hw/pci/pci.c | 77 ++++++++++++++++++++++++++++++----------------------
> > >   1 file changed, 45 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 3a0107758c..0f0c83c02f 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -36,6 +36,7 @@
> > >   #include "migration/vmstate.h"
> > >   #include "net/net.h"
> > >   #include "sysemu/numa.h"
> > > +#include "sysemu/runstate.h"
> > >   #include "sysemu/sysemu.h"
> > >   #include "hw/loader.h"
> > >   #include "qemu/error-report.h"
> > > @@ -2308,10 +2309,16 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
> > >   {
> > >       int64_t size;
> > >       g_autofree char *path = NULL;
> > > -    void *ptr;
> > >       char name[32];
> > >       const VMStateDescription *vmsd;
> > > +    /*
> > > +     * In case of incoming migration ROM will come with migration stream, no
> > > +     * reason to load the file.  Neither we want to fail if local ROM file
> > > +     * mismatches with specified romsize.
> > > +     */
> > > +    bool load_file = !runstate_check(RUN_STATE_INMIGRATE);
> > > +
> > >       if (!pdev->romfile || !strlen(pdev->romfile)) {
> > >           return;
> > >       }
> > > @@ -2341,32 +2348,35 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
> > >           return;
> > >       }
> > > -    path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
> > > -    if (path == NULL) {
> > > -        path = g_strdup(pdev->romfile);
> > > -    }
> > > +    if (load_file || pdev->romsize == -1) {
> > > +        path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
> > > +        if (path == NULL) {
> > > +            path = g_strdup(pdev->romfile);
> > > +        }
> > > -    size = get_image_size(path);
> > > -    if (size < 0) {
> > > -        error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
> > > -        return;
> > > -    } else if (size == 0) {
> > > -        error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
> > > -        return;
> > > -    } else if (size > 2 * GiB) {
> > > -        error_setg(errp, "romfile \"%s\" too large (size cannot exceed 2 GiB)",
> > > -                   pdev->romfile);
> > > -        return;
> > > -    }
> > > -    if (pdev->romsize != -1) {
> > > -        if (size > pdev->romsize) {
> > > -            error_setg(errp, "romfile \"%s\" (%u bytes) "
> > > -                       "is too large for ROM size %u",
> > > -                       pdev->romfile, (uint32_t)size, pdev->romsize);
> > > +        size = get_image_size(path);
> > > +        if (size < 0) {
> > > +            error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
> > > +            return;
> > > +        } else if (size == 0) {
> > > +            error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
> > > +            return;
> > > +        } else if (size > 2 * GiB) {
> > > +            error_setg(errp,
> > > +                       "romfile \"%s\" too large (size cannot exceed 2 GiB)",
> > > +                       pdev->romfile);
> > >               return;
> > >           }
> > > -    } else {
> > > -        pdev->romsize = pow2ceil(size);
> > > +        if (pdev->romsize != -1) {
> > > +            if (size > pdev->romsize) {
> > > +                error_setg(errp, "romfile \"%s\" (%u bytes) "
> > > +                           "is too large for ROM size %u",
> > > +                           pdev->romfile, (uint32_t)size, pdev->romsize);
> > > +                return;
> > > +            }
> > > +        } else {
> > > +            pdev->romsize = pow2ceil(size);
> > > +        }
> > >       }
> > >       vmsd = qdev_get_vmsd(DEVICE(pdev));
> > > @@ -2377,15 +2387,18 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
> > >       memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize,
> > >                              &error_fatal);
> > > -    ptr = memory_region_get_ram_ptr(&pdev->rom);
> > > -    if (load_image_size(path, ptr, size) < 0) {
> > > -        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
> > > -        return;
> > > -    }
> > > +    if (load_file) {
> > > +        void *ptr = memory_region_get_ram_ptr(&pdev->rom);
> > > -    if (is_default_rom) {
> > > -        /* Only the default rom images will be patched (if needed). */
> > > -        pci_patch_ids(pdev, ptr, size);
> > > +        if (load_image_size(path, ptr, size) < 0) {
> > > +            error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
> > > +            return;
> > > +        }
> > > +
> > > +        if (is_default_rom) {
> > > +            /* Only the default rom images will be patched (if needed). */
> > > +            pci_patch_ids(pdev, ptr, size);
> > > +        }
> > >       }
> > >       pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
> > > -- 
> > > 2.34.1
> > 
> 
> -- 
> Best regards,
> Vladimir


