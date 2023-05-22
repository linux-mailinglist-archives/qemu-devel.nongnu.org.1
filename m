Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3A70B7EC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q119w-0005kS-UT; Mon, 22 May 2023 04:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q119r-0005gs-OT
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:44:48 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q119o-0007yk-1o
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:44:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49a:0:640:edd6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 104866068A;
 Mon, 22 May 2023 11:44:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b50f::1:35] (unknown
 [2a02:6b8:b081:b50f::1:35])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Wicffx1OquQ0-2abLkQXc; Mon, 22 May 2023 11:44:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684745073; bh=lTKBuu19Ni6A/b8rdWx59Y5zDKsqmLdzZSDvye4sqrg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1lLJ6lCZ8B6BfnnYWGo9poDBRg9XY21/9KQMJiqub6EYYTNCKWr6n5/cGhcvShJRR
 2nMV/Lqg9smi3ACr6spmGCjvWQAXL7l6vZ6GVj1noYjsTWCiLGCn+KWaScN3DmcHbf
 blz0dqpSU0cDm16QHLoKia5DKwPYJO9ALecIzTcc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9a74861d-cef7-cfad-0e87-87e2d6710501@yandex-team.ru>
Date: Mon, 22 May 2023 11:44:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/3] pci: ROM preallocation for incoming migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
References: <20230515125229.44836-1-vsementsov@yandex-team.ru>
 <20230515125229.44836-4-vsementsov@yandex-team.ru>
 <20230519013355-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230519013355-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 19.05.23 08:34, Michael S. Tsirkin wrote:
> On Mon, May 15, 2023 at 03:52:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On incoming migration we have the following sequence to load option
>> ROM:
>>
>> 1. On device realize we do normal load ROM from the file
>>
>> 2. Than, on incoming migration we rewrite ROM from the incoming RAM
>>     block. If sizes mismatch we fail, like this:
>>
>>      Size mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 != 0x80000: Invalid argument
>>
>> This is not ideal when we migrate to updated distribution: we have to
>> keep old ROM files in new distribution and be careful around romfile
>> property to load correct ROM file. Which is loaded actually just to
>> allocate the ROM with correct length.
>>
>> Note, that romsize property doesn't really help: if we try to specify
>> it when default romfile is larger, it fails with something like:
>>
>>      romfile "efi-virtio.rom" (160768 bytes) is too large for ROM size 65536
>>
>> Let's just ignore ROM file when romsize is specified and we are in
>> incoming migration state. In other words, we need only to preallocate
>> ROM of specified size, local ROM file is unrelated.
>>
>> This way:
>>
>> If romsize was specified on source, we just use same commandline as on
>> source, and migration will work independently of local ROM files on
>> target.
>>
>> If romsize was not specified on source (and we have mismatching local
>> ROM file on target host), we have to specify romsize on target to match
>> source romsize. romfile parameter may be kept same as on source or may
>> be dropped, the file is not loaded anyway.
>>
>> As a bonus we avoid extra reading from ROM file on target.
>>
>> Note: when we don't have romsize parameter on source command line and
>> need it for target, it may be calculated as aligned up to power of two
>> size of ROM file on source (if we know, which file is it) or,
>> alternatively it may be retrieved from source QEMU by QMP qom-get
>> command, like
>>
>>    { "execute": "qom-get",
>>      "arguments": {
>>        "path": "/machine/peripheral/CARD_ID/virtio-net-pci.rom[0]",
>>        "property": "size" } }
>>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
> Breaks build here:
> 
> In function ‘pci_add_option_rom’,
>      inlined from ‘pci_qdev_realize’ at ../hw/pci/pci.c:2155:5:
> ../hw/pci/pci.c:2395:13: error: ‘size’ may be used uninitialized [-Werror=maybe-uninitialized]
>   2395 |         if (load_image_size(path, ptr, size) < 0) {
>        |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../hw/pci/pci.c: In function ‘pci_qdev_realize’:
> ../hw/pci/pci.c:2312:13: note: ‘size’ was declared here
>   2312 |     int64_t size;
>        |             ^~~~
> 
> 

Hmm, but works for me. Anyway that's obviously false-positive, if we are here, size is initialized in previous block if (load_file || ..).

So, may be add simply this:

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 0f0c83c02f..075c998284 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2307,7 +2307,7 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
  static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
                                 Error **errp)
  {
-    int64_t size;
+    int64_t size = 0;  /* fix "uninitialized" false-positive */
      g_autofree char *path = NULL;
      char name[32];
      const VMStateDescription *vmsd;


> 
>> ---
>>   hw/pci/pci.c | 77 ++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 45 insertions(+), 32 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 3a0107758c..0f0c83c02f 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -36,6 +36,7 @@
>>   #include "migration/vmstate.h"
>>   #include "net/net.h"
>>   #include "sysemu/numa.h"
>> +#include "sysemu/runstate.h"
>>   #include "sysemu/sysemu.h"
>>   #include "hw/loader.h"
>>   #include "qemu/error-report.h"
>> @@ -2308,10 +2309,16 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>>   {
>>       int64_t size;
>>       g_autofree char *path = NULL;
>> -    void *ptr;
>>       char name[32];
>>       const VMStateDescription *vmsd;
>>   
>> +    /*
>> +     * In case of incoming migration ROM will come with migration stream, no
>> +     * reason to load the file.  Neither we want to fail if local ROM file
>> +     * mismatches with specified romsize.
>> +     */
>> +    bool load_file = !runstate_check(RUN_STATE_INMIGRATE);
>> +
>>       if (!pdev->romfile || !strlen(pdev->romfile)) {
>>           return;
>>       }
>> @@ -2341,32 +2348,35 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>>           return;
>>       }
>>   
>> -    path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
>> -    if (path == NULL) {
>> -        path = g_strdup(pdev->romfile);
>> -    }
>> +    if (load_file || pdev->romsize == -1) {
>> +        path = qemu_find_file(QEMU_FILE_TYPE_BIOS, pdev->romfile);
>> +        if (path == NULL) {
>> +            path = g_strdup(pdev->romfile);
>> +        }
>>   
>> -    size = get_image_size(path);
>> -    if (size < 0) {
>> -        error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
>> -        return;
>> -    } else if (size == 0) {
>> -        error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
>> -        return;
>> -    } else if (size > 2 * GiB) {
>> -        error_setg(errp, "romfile \"%s\" too large (size cannot exceed 2 GiB)",
>> -                   pdev->romfile);
>> -        return;
>> -    }
>> -    if (pdev->romsize != -1) {
>> -        if (size > pdev->romsize) {
>> -            error_setg(errp, "romfile \"%s\" (%u bytes) "
>> -                       "is too large for ROM size %u",
>> -                       pdev->romfile, (uint32_t)size, pdev->romsize);
>> +        size = get_image_size(path);
>> +        if (size < 0) {
>> +            error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
>> +            return;
>> +        } else if (size == 0) {
>> +            error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
>> +            return;
>> +        } else if (size > 2 * GiB) {
>> +            error_setg(errp,
>> +                       "romfile \"%s\" too large (size cannot exceed 2 GiB)",
>> +                       pdev->romfile);
>>               return;
>>           }
>> -    } else {
>> -        pdev->romsize = pow2ceil(size);
>> +        if (pdev->romsize != -1) {
>> +            if (size > pdev->romsize) {
>> +                error_setg(errp, "romfile \"%s\" (%u bytes) "
>> +                           "is too large for ROM size %u",
>> +                           pdev->romfile, (uint32_t)size, pdev->romsize);
>> +                return;
>> +            }
>> +        } else {
>> +            pdev->romsize = pow2ceil(size);
>> +        }
>>       }
>>   
>>       vmsd = qdev_get_vmsd(DEVICE(pdev));
>> @@ -2377,15 +2387,18 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>>       memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize,
>>                              &error_fatal);
>>   
>> -    ptr = memory_region_get_ram_ptr(&pdev->rom);
>> -    if (load_image_size(path, ptr, size) < 0) {
>> -        error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
>> -        return;
>> -    }
>> +    if (load_file) {
>> +        void *ptr = memory_region_get_ram_ptr(&pdev->rom);
>>   
>> -    if (is_default_rom) {
>> -        /* Only the default rom images will be patched (if needed). */
>> -        pci_patch_ids(pdev, ptr, size);
>> +        if (load_image_size(path, ptr, size) < 0) {
>> +            error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
>> +            return;
>> +        }
>> +
>> +        if (is_default_rom) {
>> +            /* Only the default rom images will be patched (if needed). */
>> +            pci_patch_ids(pdev, ptr, size);
>> +        }
>>       }
>>   
>>       pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
>> -- 
>> 2.34.1
> 

-- 
Best regards,
Vladimir


